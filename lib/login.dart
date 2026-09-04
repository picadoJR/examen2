import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loading = false;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.94,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> signIn() async {
    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      showMessage('Please enter your email');
      return;
    }

    if (!email.contains('@')) {
      showMessage('Please enter a valid email');
      return;
    }

    if (password.isEmpty) {
      showMessage('Please enter your password');
      return;
    }

    if (password.length < 6) {
      showMessage('Password must contain at least 6 characters');
      return;
    }

    setState(() {
      loading = true;
    });

    // Pequeña animación de carga.
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    // Animación antes de continuar.
    await animationController.reverse();

    if (!mounted) return;

    // Por ahora mostramos el mensaje.
    // Aquí posteriormente puedes conectar la pantalla de productos.
    showMessage('Login successful!');
   
    // Volvemos a mostrar la tarjeta.
    animationController.forward();
  }

  void forgotPassword() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Forgot Password?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter your email and we will send you a recovery link.',
              ),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  showMessage('Enter your email first');
                  return;
                }

                Navigator.pop(context);
                showMessage('Recovery email sent');
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void googleLogin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Google Sign In'),
          content: const Text(
            'Google authentication is ready to be connected.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void appleLogin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apple Sign In'),
          content: const Text(
            'Apple authentication is ready to be connected.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signUp() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Account'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showMessage('Complete all fields');
                  return;
                }

                Navigator.pop(context);
                showMessage('Account created successfully');
              },
              child: const Text('Sign Up'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration inputDecoration({
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xFFB6B6BF),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE1E1E6),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE1E1E6),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE9277B),
          width: 1.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Container(
                    width: 270,
                    padding: const EdgeInsets.fromLTRB(
                      25,
                      20,
                      25,
                      25,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ICONO
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFCE4EF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Color(0xFFE9277B),
                            size: 27,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // TITULO
                        const Text(
                          'Elegance',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF172033),
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Welcome back to your style sanctuary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF8B8B94),
                          ),
                        ),

                        const SizedBox(height: 26),

                        // EMAIL
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF454552),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        SizedBox(
                          height: 42,
                          child: TextField(
                            controller: emailController,
                            keyboardType:
                                TextInputType.emailAddress,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            decoration: inputDecoration(
                              hint: 'hello@fashion.com',
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // PASSWORD + FORGOT
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF454552),
                              ),
                            ),
                            GestureDetector(
                              onTap: forgotPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFE9277B),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        // PASSWORD
                        SizedBox(
                          height: 42,
                          child: TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            decoration: inputDecoration(
                              hint: '••••••••',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                size: 17,
                                color: Color(0xFF9EA1AA),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword =
                                        !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 17,
                                  color:
                                      const Color(0xFF9EA1AA),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 17),

                        // SIGN IN
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            onPressed:
                                loading ? null : signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFE9277B),
                              disabledBackgroundColor:
                                  const Color(0xFFF08AB8),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration:
                                  const Duration(milliseconds: 200),
                              child: loading
                                  ? const SizedBox(
                                      key: ValueKey('loading'),
                                      width: 18,
                                      height: 18,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Sign In',
                                      key: ValueKey('text'),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // OR CONTINUE
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE8E8EC),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                'OR CONTINUE WITH',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Color(0xFFE8E8EC),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // GOOGLE + IOS
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 37,
                                child: OutlinedButton(
                                  onPressed: googleLogin,
                                  style:
                                      OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white,
                                    side: const BorderSide(
                                      color: Color(0xFFE6E6EA),
                                    ),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'G',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Color(0xFF4285F4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 37,
                                child: OutlinedButton(
                                  onPressed: appleLogin,
                                  style:
                                      OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white,
                                    side: const BorderSide(
                                      color: Color(0xFFE6E6EA),
                                    ),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'iOS',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Color(0xFF202124),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 21),

                        // SIGN UP
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF55555F),
                              ),
                            ),
                            GestureDetector(
                              onTap: signUp,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFE82A7D),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
