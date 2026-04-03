import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/components/counter.dart';

class HomePage extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: ProgressBar(
            value: 0.75, // 0.0 to 1.0
            valueColor: Colors.green, // Fill color
            backgroundColor: Colors.grey, // Empty area color
            showPercentage: true, // Show "75%" in center
            // label: 'Loading...', // Custom label text
            fillCharacter: '█', // Character for filled area
            emptyCharacter: '░', // Character for empty area
          ),
        ),
        Tint(
          color: Colors.blue.withOpacity(0.3),
          child: Text('Hey this is a tinted text'),
        ),
        Expanded(child: Counter()),
        Text(asciiArt),
      ],
    );
  }
}

const asciiArt = r'''
              (
               )
              (
        /\  .-"""-.  /\
       //\\/  ,,,  \//\\
       |/\| ,;;;;;, |/\|
       //\\\;-"""-;///\\
      //  \/   .   \/  \\
     (| ,-_| \ | / |_-, |)
       //`__\.-.-./__`\\
      // /.-(() ())-.\ \\
     (\ |)   '---'   (| /)
      ` (|           |) `
        \)           (/
''';