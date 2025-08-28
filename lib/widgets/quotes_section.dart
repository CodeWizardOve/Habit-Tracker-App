import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/quote.dart';
import '../providers/quote_provider.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onRefresh;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onRefresh,
  });

  Future<void> _copyToClipboard(BuildContext context) async {
    final String textToCopy = '"${quote.text}"\n- ${quote.author}';
    await Clipboard.setData(ClipboardData(text: textToCopy));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quote copied to clipboard'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor.withOpacity(0.05),
              theme.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.format_quote, size: 24),
              const SizedBox(height: 8),
              Text(
                quote.text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '- ${quote.author}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded),
                    onPressed: () => _copyToClipboard(context),
                    tooltip: 'Copy quote',
                    style: IconButton.styleFrom(
                      backgroundColor: theme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuotesSection extends StatelessWidget {
  const QuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, _) {
        if (quoteProvider.isLoading && quoteProvider.quotes.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Motivation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: quoteProvider.refreshQuotes,
                    tooltip: 'Refresh quotes',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: quoteProvider.quotes.length,
                itemBuilder: (context, index) {
                  return QuoteCard(
                    quote: quoteProvider.quotes[index],
                    onRefresh: quoteProvider.refreshQuotes,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
