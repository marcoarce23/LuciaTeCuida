

class Resource 
{
      String imageDefault = 'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';
      static final Resource _instancia = new Resource._internal();

      factory Resource() {
          return _instancia;
      }

        Resource._internal();
      
        

  // get imagenDefault {
  //     return getString('avatarImagen') ?? 'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';
  //         }
      
  //         set imageDefault( String value ) {
  //           _prefs.setString('avatarImagen', value);
  //         }
      
  //     const String _imageDefault
      
  //      String get imageDefault => _imageDefault;
      
  //      set imageDefault(String value) => _imageDefault = value; = 
      
  //       getString(String s) {}'http://res.cloudinary.com/propia/image/upload/v1592167496/djsbl74vjdwtso6zrst7.jpg';

}