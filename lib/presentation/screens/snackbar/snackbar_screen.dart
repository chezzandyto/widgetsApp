import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'Snackbar Screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'Ok!',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Estas seguro ?'),
              content: const Text(
                  'Elit cillum sit culpa irure duis et eiusmod. Ullamco ipsum ad laborum ullamco enim occaecat eu aliqua. Culpa nulla sit esse Lorem excepteur proident. Nisi nulla ex exercitation labore exercitation proident quis anim mollit ea excepteur. Enim ut ex dolor minim pariatur.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar')),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Aceptar'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar y Dialogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Fugiat et sint magna cillum ut labore eiusmod. Do fugiat ullamco ipsum officia tempor consectetur ea elit elit pariatur nostrud sunt. Sunt tempor elit ullamco sit laborum exercitation dolore aliqua. Ullamco officia velit est adipisicing officia aliqua irure sint consequat irure nulla sint anim.')
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () {
                  openDialog(context);
                },
                child: const Text('Mostrar dialogo'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
