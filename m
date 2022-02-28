Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68E4C7A78
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiB1Uab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiB1UaP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:30:15 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 12:29:26 PST
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3809A5C354
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:29:25 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0259BBD2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 20:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1646076757;
        bh=WqcZGxLVkI/ykaqRWbHL0DFLRiXeUiOhOVqn2BQ+VYU=;
        h=Date:From:To:Subject:From;
        b=HVWZqSfYQAIOLPuISUQGW0q5GxQezs4wjJR8SCRDFnYnNrM5t8iztAtW13jMnlmSI
         LSgUTyajOQxm028DY3Lehiplw9whu8OoT3sRGxBjzSSxctvxaqMNMkR3EXKxz7Nx0L
         roAnfuVwkivt4MlxY2d4uKZBCg8XEzdr2ej3I6krJk+NL2J6PE5XEIX8gSSSK7SNcS
         rmTLOt2HKS/5CMxpaZMso+OPbBOSv9Xp71lAUdcoaxaWjTjTFhQGeVQ+XRqPy7Lp2J
         tcOtzyo2FY4rnEDbBKxbeZE3ls+lusrwessrY7AgWFOvZdQmCjagP+2R35NaV/4lqX
         GDn6dgfMAk+Sw==
Date:   Mon, 28 Feb 2022 20:32:35 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     linux-nfs@vger.kernel.org
Subject: exportfs recursively processes backslash escapes in exports file
Message-ID: <20220228193235.2g2uvf7fphj4jdy5@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgfxbmsll2gwt67h"
Content-Disposition: inline
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--sgfxbmsll2gwt67h
Content-Type: multipart/mixed; boundary="65m2ezorwnvfs6y6"
Content-Disposition: inline


--65m2ezorwnvfs6y6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It is, I fear, like in the subject:
  $ tail -4 /etc/exports.d/zfs.exports
  /a\040\134053\040b 1(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)
  /a\040\134134053\040b 2(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)
  /a\040\134134134053\040b 3(sec=3Dsys,rw,no_subtree_check,mountpoint,cross=
mnt)
  /a\040\134134134134053\040b 4(sec=3Dsys,rw,no_subtree_check,mountpoint,cr=
ossmnt)
  # exportfs -ra
  exportfs: Failed to stat /a + b: No such file or directory
  exportfs: Failed to stat /a + b: No such file or directory
  exportfs: Failed to stat /a + b: No such file or directory
  exportfs: Failed to stat /a + b: No such file or directory

I just wanted to export '/a \053 b', of course. The rest are just PoC.

The manual states:
> You can also specify spaces or other unusual character in the export
> name using a backslash followed by the character code as three octal
> digits.

The this happens on 1:1.3.4-6 off Debian, nfs-utils-2.6.1, and
current HEAD (7f8463fe702174bd613df9d308cc899af25ae02e).

strace off HEAD attached.

Best,
=D0=BD=D0=B0=D0=B1

Please keep me in CC, as I'm not subscribed.

--65m2ezorwnvfs6y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=strace
Content-Transfer-Encoding: quoted-printable

execve("./utils/exportfs/exportfs", ["./utils/exportfs/exportfs", "-ra"], 0=
x7fffa27ca428 /* 15 vars */) =3D 0
brk(NULL)                               =3D 0x55dcf1911000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D101487, ...}) =3D 0
mmap(NULL, 101487, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f36a2a56000
close(3)                                =3D 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXE=
C) =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 |\0\0\0\0\0\0@\0\0\=
0\0\0\0\0P?\2\0\0\0\0\0\0\0\0\0@\08\0\v\0@\0#\0\"\0\6\0\0\0\4\0\0\0@\0\0\0\=
0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0h\2\0\0\0\0\0\0h\2\0\0\0\0\0\0\10\0\0\=
0\0\0\0\0\3\0\0\0\4\0\0\0\0\202\1\0\0\0\0\0\0\202\1\0\0\0\0\0\0\202\1\0\0\0=
\0\0\34\0\0\0\0\0\0\0\34\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0\1\0\0\0\4\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0`j\0\0\0\0\0\0`j\0\0\0\0\0\0\0\=
20\0\0\0\0\0\0\1\0\0\0\5\0\0\0\0p\0\0\0\0\0\0\0p\0\0\0\0\0\0\0p\0\0\0\0\0\0=
\255\360\0\0\0\0\0\0\255\360\0\0\0\0\0\0\0\20\0\0\0\0\0\0\1\0\0\0\4\0\0\0\0=
p\1\0\0\0\0\0\0p\1\0\0\0\0\0\0p\1\0\0\0\0\0`G\0\0\0\0\0\0`G\0\0\0\0\0\0\0\2=
0\0\0\0\0\0\0\1\0\0\0\6\0\0\0\10\274\1\0\0\0\0\0\10\314\1\0\0\0\0\0\10\314\=
1\0\0\0\0\0\10\7\0\0\0\0\0\0hH\0\0\0\0\0\0\0\20\0\0\0\0\0\0\2\0\0\0\6\0\0\0=
p\275\1\0\0\0\0\0p\315\1\0\0\0\0\0p\315\1\0\0\0\0\0000\2\0\0\0\0\0\0000\2\0=
\0\0\0\0\0\10\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\250\2\0\0\0\0\0\0\250\2\0\0\0\0=
\0\0\250\2\0\0\0\0\0\0D\0\0\0\0\0\0\0D\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0P\345td=
\4\0\0\0\34\202\1\0\0\0\0\0\34\202\1\0\0\0\0\0\34\202\1\0\0\0\0\0T\t\0\0\0\=
0\0\0T\t\0\0\0\0\0\0\4\0\0\0\0\0\0\0Q\345td\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0R\=
345td\4\0\0\0\10\274\1\0\0\0\0\0\10\314\1\0\0\0\0\0\10\314\1\0\0\0\0\0\370\=
3\0\0\0\0\0\0\370\3\0\0\0\0\0\0\1\0\0\0\0\0\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU=
\0P\30#{\277\1+@\224\2\177\320\271o\302*$In\244\4\0\0\0\20\0\0\0\1\0\0\0GNU=
\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\262\2\0\0i\1\0\0\17\0\0\0\0\0\0\=
0\0\0\0\0\370\0\0\0\26\1\0\0\261\0\0\0\2\0\0\0\0\0\0\0g\1\0\0\0\0\0\0W\1\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0E\1\0\0\304\0\0\0\0\0\0\0\0\0\0\0", 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D149520, ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f36a2a54000
mmap(NULL, 136304, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f36a2=
a32000
mmap(0x7f36a2a39000, 65536, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_=
DENYWRITE, 3, 0x7000) =3D 0x7f36a2a39000
mmap(0x7f36a2a49000, 20480, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE,=
 3, 0x17000) =3D 0x7f36a2a49000
mmap(0x7f36a2a4e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
DENYWRITE, 3, 0x1b000) =3D 0x7f36a2a4e000
mmap(0x7f36a2a50000, 13424, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7f36a2a50000
close(3)                                =3D 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libresolv.so.2", O_RDONLY|O_CLOEXEC=
) =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260C\0\0\0\0\0\0@\0=
\0\0\0\0\0\0\310c\1\0\0\0\0\0\0\0\0\0@\08\0\t\0@\0\36\0\35\0\1\0\0\0\4\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0P<\0\0\0\0\0\0P<\0\0\0\0\0=
\0\0\20\0\0\0\0\0\0\1\0\0\0\5\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\=
0\0\0\365\321\0\0\0\0\0\0\365\321\0\0\0\0\0\0\0\20\0\0\0\0\0\0\1\0\0\0\4\0\=
0\0\0 \1\0\0\0\0\0\0 \1\0\0\0\0\0\0 \1\0\0\0\0\0<.\0\0\0\0\0\0<.\0\0\0\0\0\=
0\0\20\0\0\0\0\0\0\1\0\0\0\6\0\0\0\20V\1\0\0\0\0\0\20f\1\0\0\0\0\0\20f\1\0\=
0\0\0\0p\f\0\0\0\0\0\0p4\0\0\0\0\0\0\0\20\0\0\0\0\0\0\2\0\0\0\6\0\0\0\250]\=
1\0\0\0\0\0\250m\1\0\0\0\0\0\250m\1\0\0\0\0\0\20\2\0\0\0\0\0\0\20\2\0\0\0\0=
\0\0\10\0\0\0\0\0\0\0\4\0\0\0\4\0\0\08\2\0\0\0\0\0\08\2\0\0\0\0\0\08\2\0\0\=
0\0\0\0D\0\0\0\0\0\0\0D\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0P\345td\4\0\0\0D/\1\0\=
0\0\0\0D/\1\0\0\0\0\0D/\1\0\0\0\0\0\304\3\0\0\0\0\0\0\304\3\0\0\0\0\0\0\4\0=
\0\0\0\0\0\0Q\345td\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0R\345td\4\0\0\0\20V\1\0\0\=
0\0\0\20f\1\0\0\0\0\0\20f\1\0\0\0\0\0\360\t\0\0\0\0\0\0\360\t\0\0\0\0\0\0\1=
\0\0\0\0\0\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\200?\341s\t\7(\235&_\220\367/\=
221e,V N\346\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0\=
0\0\0\0\35\1\0\0\247\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0w\0\0\0\0\0\0\0\1\0\0\0\2=
6\0\0\0\0\0\0\0\0\0\0\0&\0\0\0\0\0\0\0\245\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0\0\0s\0\0\0\0\0\0\0\0\0\0\0O\0\0\0\0\0\0\0\=
0\0\0\0p\0\0\0\242\0\0\0\0\0\0\0;\0\0\0\0\0\0\0\"\0\0\0\0\0\0\0N\0\0\0\0\0\=
0\0\0\0\0\0\241\0\0\0\0\0\0\0\0\0\0\0\216\0\0\0\0\0\0\0\0\0\0\0a\0\0\0\0\0\=
0\0\0\0\0\0004\0\0\0", 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D93000, ...}) =3D 0
mmap(NULL, 105088, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f36a2=
a18000
mprotect(0x7f36a2a1c000, 73728, PROT_NONE) =3D 0
mmap(0x7f36a2a1c000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_=
DENYWRITE, 3, 0x4000) =3D 0x7f36a2a1c000
mmap(0x7f36a2a2a000, 12288, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE,=
 3, 0x12000) =3D 0x7f36a2a2a000
mmap(0x7f36a2a2e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
DENYWRITE, 3, 0x15000) =3D 0x7f36a2a2e000
mmap(0x7f36a2a30000, 6784, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
ANONYMOUS, -1, 0) =3D 0x7f36a2a30000
close(3)                                =3D 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D=
 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@n\2\0\0\0\0\0@\0\0\=
0\0\0\0\0p\2\34\0\0\0\0\0\0\0\0\0@\08\0\f\0@\0A\0@\0\6\0\0\0\4\0\0\0@\0\0\0=
\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\240\2\0\0\0\0\0\0\240\2\0\0\0\0\0\0\=
10\0\0\0\0\0\0\0\3\0\0\0\4\0\0\0 ?\31\0\0\0\0\0 ?\31\0\0\0\0\0 ?\31\0\0\0\0=
\0\34\0\0\0\0\0\0\0\34\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0\1\0\0\0\4\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\200I\2\0\0\0\0\0\200I\2\0\0\0\0\=
0\0\20\0\0\0\0\0\0\1\0\0\0\5\0\0\0\0P\2\0\0\0\0\0\0P\2\0\0\0\0\0\0P\2\0\0\0=
\0\0\f\245\24\0\0\0\0\0\f\245\24\0\0\0\0\0\0\20\0\0\0\0\0\0\1\0\0\0\4\0\0\0=
\0\0\27\0\0\0\0\0\0\0\27\0\0\0\0\0\0\0\27\0\0\0\0\0\313\237\4\0\0\0\0\0\313=
\237\4\0\0\0\0\0\0\20\0\0\0\0\0\0\1\0\0\0\6\0\0\0\340\245\33\0\0\0\0\0\340\=
265\33\0\0\0\0\0\340\265\33\0\0\0\0\0000P\0\0\0\0\0\0(\217\0\0\0\0\0\0\0\20=
\0\0\0\0\0\0\2\0\0\0\6\0\0\0\200\313\33\0\0\0\0\0\200\333\33\0\0\0\0\0\200\=
333\33\0\0\0\0\0\340\1\0\0\0\0\0\0\340\1\0\0\0\0\0\0\10\0\0\0\0\0\0\0\4\0\0=
\0\4\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0\0\0\0\0D\0\0\0\0\0=
\0\0D\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\7\0\0\0\4\0\0\0\340\245\33\0\0\0\0\0\34=
0\265\33\0\0\0\0\0\340\265\33\0\0\0\0\0\20\0\0\0\0\0\0\0\220\0\0\0\0\0\0\0\=
10\0\0\0\0\0\0\0P\345td\4\0\0\0<?\31\0\0\0\0\0<?\31\0\0\0\0\0<?\31\0\0\0\0\=
0\254a\0\0\0\0\0\0\254a\0\0\0\0\0\0\4\0\0\0\0\0\0\0Q\345td\6\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\20\=
0\0\0\0\0\0\0R\345td\4\0\0\0\340\245\33\0\0\0\0\0\340\265\33\0\0\0\0\0\340\=
265\33\0\0\0\0\0 *\0\0\0\0\0\0 *\0\0\0\0\0\0\1\0\0\0\0\0\0\0\4\0\0\0\24\0\0=
\0\3\0\0\0GNU\0T\356\365\316\226\3177\313\27[\r\223\30h6\312\34\257G\f\4\0\=
0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\371\3\0\0=
B\t\0\0\363\1\0\0:\3\0\0\4\t\0\0<\4\0\0", 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1839792, ...}) =3D 0
mmap(NULL, 1852680, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f36a=
2853000
mprotect(0x7f36a2878000, 1662976, PROT_NONE) =3D 0
mmap(0x7f36a2878000, 1355776, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x25000) =3D 0x7f36a2878000
mmap(0x7f36a29c3000, 303104, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE=
, 3, 0x170000) =3D 0x7f36a29c3000
mmap(0x7f36a2a0e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_DENYWRITE, 3, 0x1ba000) =3D 0x7f36a2a0e000
mmap(0x7f36a2a14000, 13576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7f36a2a14000
close(3)                                =3D 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f36a2850000
arch_prctl(ARCH_SET_FS, 0x7f36a2850740) =3D 0
mprotect(0x7f36a2a0e000, 12288, PROT_READ) =3D 0
mprotect(0x7f36a2a2e000, 4096, PROT_READ) =3D 0
mprotect(0x7f36a2a4e000, 4096, PROT_READ) =3D 0
mprotect(0x55dceffd6000, 4096, PROT_READ) =3D 0
mprotect(0x7f36a2a99000, 4096, PROT_READ) =3D 0
munmap(0x7f36a2a56000, 101487)          =3D 0
set_tid_address(0x7f36a2850a10)         =3D 709645
set_robust_list(0x7f36a2850a20, 24)     =3D 0
rt_sigaction(SIGRTMIN, {sa_handler=3D0x7f36a2a39690, sa_mask=3D[], sa_flags=
=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x7f36a2a46140}, NULL, 8) =3D 0
rt_sigaction(SIGRT_1, {sa_handler=3D0x7f36a2a39730, sa_mask=3D[], sa_flags=
=3DSA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=3D0x7f36a2a46140}, NULL, =
8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=3D8192*1024, rlim_max=3DRLIM64_I=
NFINITY}) =3D 0
getpid()                                =3D 709645
rt_sigaction(SIGUSR1, {sa_handler=3D0x55dceffcf640, sa_mask=3D[USR1], sa_fl=
ags=3DSA_RESTORER|SA_RESTART, sa_restorer=3D0x7f36a288ed60}, {sa_handler=3D=
SIG_DFL, sa_mask=3D[], sa_flags=3D0}, 8) =3D 0
rt_sigaction(SIGUSR2, {sa_handler=3D0x55dceffcf640, sa_mask=3D[USR2], sa_fl=
ags=3DSA_RESTORER|SA_RESTART, sa_restorer=3D0x7f36a288ed60}, {sa_handler=3D=
SIG_DFL, sa_mask=3D[], sa_flags=3D0}, 8) =3D 0
stat("/etc/nfs.conf", 0x7ffc080a6ca8)   =3D -1 ENOENT (No such file or dire=
ctory)
brk(NULL)                               =3D 0x55dcf1911000
brk(0x55dcf1932000)                     =3D 0x55dcf1932000
openat(AT_FDCWD, "/etc/nfs.conf.d", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTO=
RY) =3D -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/var/lib/nfs/export-lock", O_RDWR|O_CREAT, 0666) =3D 3
fcntl(3, F_SETLKW, {l_type=3DF_WRLCK, l_whence=3DSEEK_CUR, l_start=3D0, l_l=
en=3D0}) =3D 0
openat(AT_FDCWD, "/etc/exports", O_RDONLY) =3D 4
fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D389, ...}) =3D 0
read(4, "# /etc/exports: the access control list for filesystems which may =
be exported\n#\t\tto NFS clients.  See exports(5).\n#\n# Example for NFSv2 =
and NFSv3:\n# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname=
2(ro,sync,no_subtree_check)\n#\n# Example for NFSv4:\n# /srv/nfs4        gs=
s/krb5i(rw,sync,fsid=3D0,crossmnt,no_subtree_check)\n# /srv/nfs4/homes  gss=
/krb5i(rw,sync,no_subtree_check)\n#\n", 512) =3D 389
read(4, "", 512)                        =3D 0
close(4)                                =3D 0
openat(AT_FDCWD, "/etc/exports.d", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTOR=
Y) =3D 4
fstat(4, {st_mode=3DS_IFDIR|0755, st_size=3D4, ...}) =3D 0
getdents64(4, 0x55dcf1911760 /* 4 entries */, 32768) =3D 120
getdents64(4, 0x55dcf1911760 /* 0 entries */, 32768) =3D 0
close(4)                                =3D 0
openat(AT_FDCWD, "/etc/exports.d/zfs.exports", O_RDONLY) =3D 4
fstat(4, {st_mode=3DS_IFREG|0644, st_size=3D784, ...}) =3D 0
read(4, "# !!! DO NOT EDIT THIS FILE MANUALLY !!!\n\n/mnt/filling/machine/1=
200-S121 *(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt,no_subtree_che=
ck,no_root_squash,async)\n/spaced\\040out *(sec=3Dsys,rw,no_subtree_check,m=
ountpoint,crossmnt)\n/dupa\\011#hehe\\040\\134\\134epsko\\040\\134053\\040\=
\040\\015 *(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)\n/dupa\\011#=
hehe\\040\\134\\134epsko\\040\\134053\\040\\040\\015\\040\320\264\320\276\3=
21\201\321\202\320\276\320\277\321\200\320\270\320\274\320\265\321\207\320\=
260\321\202\320\265\320\273\321\214\320\275\320\276\321\201\321\202\320\270=
 *(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)\n/a\\040\\134134053\\=
040b 2(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)\n/a\\040\\1341341=
34053\\040b 3(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)\n/a\\040\\=
134134134134053\\040b 4(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)\=
n/a\\040\\134053\\040b *(sec=3Dsys,rw,no_subtree_check,mountpoint,crossmnt)=
\n", 1024) =3D 784
openat(AT_FDCWD, "/proc/fs/nfsd/export_features", O_RDONLY) =3D 5
read(5, "0x3feff 0xf\n", 50)            =3D 12
close(5)                                =3D 0
lstat("/mnt", {st_mode=3DS_IFDIR|0755, st_size=3D3, ...}) =3D 0
lstat("/mnt/filling", {st_mode=3DS_IFDIR|0755, st_size=3D7, ...}) =3D 0
lstat("/mnt/filling/machine", {st_mode=3DS_IFDIR|0755, st_size=3D4, ...}) =
=3D 0
lstat("/mnt/filling/machine/1200-S121", {st_mode=3DS_IFDIR|0755, st_size=3D=
26, ...}) =3D 0
lstat("/spaced out", {st_mode=3DS_IFDIR|0755, st_size=3D2, ...}) =3D 0
lstat("/dupa\t#hehe \\\\epsko +  \r", 0x7ffc080a5a30) =3D -1 ENOENT (No suc=
h file or directory)
lstat("/dupa\t#hehe \\\\epsko +  \r \320\264\320\276\321\201\321\202\320\27=
6\320\277\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\3=
20\273\321\214\320\275\320\276\321\201\321\202\320\270", 0x7ffc080a5a30) =
=3D -1 ENOENT (No such file or directory)
lstat("/a + b", 0x7ffc080a5a30)         =3D -1 ENOENT (No such file or dire=
ctory)
lstat("/a + b", 0x7ffc080a5a30)         =3D -1 ENOENT (No such file or dire=
ctory)
lstat("/a + b", 0x7ffc080a5a30)         =3D -1 ENOENT (No such file or dire=
ctory)
lstat("/a + b", 0x7ffc080a5a30)         =3D -1 ENOENT (No such file or dire=
ctory)
read(4, "", 1024)                       =3D 0
close(4)                                =3D 0
stat("/a + b", 0x7ffc080a7910)          =3D -1 ENOENT (No such file or dire=
ctory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /a + b: No such file or directory", 48) =3D 48
write(2, "\n", 1)                       =3D 1
stat("/a + b", 0x7ffc080a7910)          =3D -1 ENOENT (No such file or dire=
ctory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /a + b: No such file or directory", 48) =3D 48
write(2, "\n", 1)                       =3D 1
stat("/a + b", 0x7ffc080a7910)          =3D -1 ENOENT (No such file or dire=
ctory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /a + b: No such file or directory", 48) =3D 48
write(2, "\n", 1)                       =3D 1
stat("/a + b", 0x7ffc080a7910)          =3D -1 ENOENT (No such file or dire=
ctory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /a + b: No such file or directory", 48) =3D 48
write(2, "\n", 1)                       =3D 1
stat("/dupa\t#hehe \\\\epsko +  \r \320\264\320\276\321\201\321\202\320\276=
\320\277\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\32=
0\273\321\214\320\275\320\276\321\201\321\202\320\270", 0x7ffc080a7910) =3D=
 -1 ENOENT (No such file or directory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /dupa\t#hehe \\\\epsko +  \r \320\264\320\276\321\=
201\321\202\320\276\320\277\321\200\320\270\320\274\320\265\321\207\320\260=
\321\202\320\265\320\273\321\214\320\275\320\276\321\201\321\202\320\270: N=
o such file or directory", 109) =3D 109
write(2, "\n", 1)                       =3D 1
stat("/dupa\t#hehe \\\\epsko +  \r", 0x7ffc080a7910) =3D -1 ENOENT (No such=
 file or directory)
write(2, "exportfs: ", 10)              =3D 10
write(2, "Failed to stat /dupa\t#hehe \\\\epsko +  \r: No such file or dire=
ctory", 66) =3D 66
write(2, "\n", 1)                       =3D 1
stat("/spaced out", {st_mode=3DS_IFDIR|0755, st_size=3D2, ...}) =3D 0
openat(AT_FDCWD, "/proc/net/rpc/auth.unix.ip/channel", O_WRONLY) =3D 4
write(4, "nfsd 0.0.0.0 2147483647 -test-client-\n", 38) =3D 38
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.export/channel", O_WRONLY) =3D 4
close(4)                                =3D 0
statfs("/spaced out", {f_type=3DZFS_SUPER_MAGIC, f_bsize=3D131072, f_blocks=
=3D386359, f_bfree=3D386357, f_bavail=3D386357, f_files=3D98907574, f_ffree=
=3D98907568, f_fsid=3D{val=3D[0x20b42459, 0xe98921]}, f_namelen=3D255, f_fr=
size=3D131072, f_flags=3DST_VALID|ST_RELATIME}) =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.export/channel", O_WRONLY) =3D 4
write(4, "-test-client- /spaced\\040out  3 25636 65534 65534 0\n", 52) =3D =
52
close(4)                                =3D 0
stat("/mnt/filling/machine/1200-S121", {st_mode=3DS_IFDIR|0755, st_size=3D2=
6, ...}) =3D 0
openat(AT_FDCWD, "/proc/net/rpc/auth.unix.ip/channel", O_WRONLY) =3D 4
write(4, "nfsd 0.0.0.0 2147483647 -test-client-\n", 38) =3D 38
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.export/channel", O_WRONLY) =3D 4
close(4)                                =3D 0
statfs("/mnt/filling/machine/1200-S121", {f_type=3DZFS_SUPER_MAGIC, f_bsize=
=3D131072, f_blocks=3D113747260, f_bfree=3D113742634, f_bavail=3D113742634,=
 f_files=3D29118140574, f_ffree=3D29118114449, f_fsid=3D{val=3D[0x18be26f2,=
 0x9f0cd8]}, f_namelen=3D255, f_frsize=3D131072, f_flags=3DST_VALID|ST_RELA=
TIME}) =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.export/channel", O_WRONLY) =3D 4
write(4, "-test-client- /mnt/filling/machine/1200-S121  3 25648 65534 65534=
 0\n", 68) =3D 68
close(4)                                =3D 0
openat(AT_FDCWD, "/var/lib/nfs/.etab.lock", O_RDWR|O_CREAT, 0600) =3D 4
fcntl(4, F_SETLKW, {l_type=3DF_WRLCK, l_whence=3DSEEK_SET, l_start=3D0, l_l=
en=3D0}) =3D 0
openat(AT_FDCWD, "/var/lib/nfs/etab.tmp", O_WRONLY|O_CREAT|O_TRUNC, 0666) =
=3D 5
fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
write(5, "/a\\040+\\040b\t2(rw,sync,wdelay,hide,crossmnt,secure,root_squash=
,no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=
=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a=
\\040+\\040b\t3(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squa=
sh,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,ano=
ngid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b=
\t4(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtre=
e_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534=
,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b\t*(rw,sync,=
wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check,secu=
re_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,r=
w,secure,root_squash,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsk=
o\\040+\\040\\040\\015\\040\320\264\320\276\321\201\321\202\320\276\320\277=
\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\320\273\32=
1\214\320\275\320\276\321\201\321\202\320\270\t*(rw,sync,wdelay,hide,crossm=
nt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pn=
fs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squa=
sh,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsko\\040+\\040\\040\=
\015\t*(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_su=
btree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6=
5534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/spaced\\040out\t*(rw,=
sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check=
,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3D=
sys,rw,secure,root_squash,no_all_squash)\n/mnt/filling/machine/1200-S121\t*=
(rw,async,wdelay,hide,crossmnt,secure,no_root_squash,no_all_squash,no_subtr=
ee_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6553=
4,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)\n", 1775) =3D 1775
close(5)                                =3D 0
openat(AT_FDCWD, "/var/lib/nfs/etab.tmp", O_RDONLY) =3D 5
openat(AT_FDCWD, "/var/lib/nfs/etab", O_RDONLY) =3D 6
read(5, "/a\\040+\\040b\t2(rw,sync,wdelay,hide,crossmnt,secure,root_squash,=
no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=
=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a=
\\040+\\040b\t3(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squa=
sh,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,ano=
ngid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b=
\t4(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtre=
e_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534=
,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b\t*(rw,sync,=
wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check,secu=
re_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,r=
w,secure,root_squash,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsk=
o\\040+\\040\\040\\015\\040\320\264\320\276\321\201\321\202\320\276\320\277=
\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\320\273\32=
1\214\320\275\320\276\321\201\321\202\320\270\t*(rw,sync,wdelay,hide,crossm=
nt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pn=
fs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squa=
sh,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsko\\040+\\040\\040\=
\015\t*(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_su=
btree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6=
5534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/spaced\\040out\t*(rw,=
sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check=
,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3D=
sys,rw,secure,root_squash,no_all_squash)\n/mnt/filling/machine/1200-S121\t*=
(rw,async,wdelay,hide,crossmnt,secure,no_root_squash,no_all_squash,no_subtr=
ee_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6553=
4,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)\n", 4096) =3D 1775
read(6, "/a\\040+\\040b\t2(rw,sync,wdelay,hide,crossmnt,secure,root_squash,=
no_all_squash,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=
=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a=
\\040+\\040b\t3(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squa=
sh,no_subtree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,ano=
ngid=3D65534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b=
\t4(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtre=
e_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534=
,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/a\\040+\\040b\t*(rw,sync,=
wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check,secu=
re_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,r=
w,secure,root_squash,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsk=
o\\040+\\040\\040\\015\\040\320\264\320\276\321\201\321\202\320\276\320\277=
\321\200\320\270\320\274\320\265\321\207\320\260\321\202\320\265\320\273\32=
1\214\320\275\320\276\321\201\321\202\320\270\t*(rw,sync,wdelay,hide,crossm=
nt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,acl,no_pn=
fs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3Dsys,rw,secure,root_squa=
sh,no_all_squash)\n/dupa\\011\\043hehe\\040\\134\\134epsko\\040+\\040\\040\=
\015\t*(rw,sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_su=
btree_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6=
5534,sec=3Dsys,rw,secure,root_squash,no_all_squash)\n/spaced\\040out\t*(rw,=
sync,wdelay,hide,crossmnt,secure,root_squash,no_all_squash,no_subtree_check=
,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D65534,sec=3D=
sys,rw,secure,root_squash,no_all_squash)\n/mnt/filling/machine/1200-S121\t*=
(rw,async,wdelay,hide,crossmnt,secure,no_root_squash,no_all_squash,no_subtr=
ee_check,secure_locks,acl,no_pnfs,mountpoint,anonuid=3D65534,anongid=3D6553=
4,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)\n", 4096) =3D 1775
read(5, "", 4096)                       =3D 0
read(6, "", 4096)                       =3D 0
close(5)                                =3D 0
close(6)                                =3D 0
unlink("/var/lib/nfs/etab.tmp")         =3D 0
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/auth.unix.ip/flush", O_RDWR) =3D 4
write(4, "1646076578\n", 11)            =3D 11
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/auth.unix.gid/flush", O_RDWR) =3D 4
write(4, "1646076578\n", 11)            =3D 11
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.fh/flush", O_RDWR) =3D 4
write(4, "1646076578\n", 11)            =3D 11
close(4)                                =3D 0
openat(AT_FDCWD, "/proc/net/rpc/nfsd.export/flush", O_RDWR) =3D 4
write(4, "1646076578\n", 11)            =3D 11
close(4)                                =3D 0
fcntl(3, F_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_CUR, l_start=3D0, l_le=
n=3D0}) =3D 0
close(3)                                =3D 0
exit_group(1)                           =3D ?
+++ exited with 1 +++

--65m2ezorwnvfs6y6--

--sgfxbmsll2gwt67h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmIdI1EACgkQvP0LAY0m
WPFARw//Q8Jff1IZxnF28XQqc8n46mrTNp5Oa3GNJAYdtT8KvJNCgYHj6unYlk+K
97pC+Vg6gf6+YC32xoedZoZ/nrf4PNUU+t4I+0v2lslZE52oBUUEiaIAndLpbndY
mzGKYeBzk4EKJVCcmJBgT/eqobivTc/ysFy+reBY+p6jeAY2jmiAAa9jHxUlJsNY
xzR/sPD/zbtwWteHG89S0w4YiJ+WnuGlRwIxHOQe/NZOzLxnJjn2k2lHDs5USuXb
FuvTUDUAiKiyqZSQWfTNBPKls2tQ5wW5wMIndE4ij7wvkiIp8ZWPuv2nEwoyPmOt
1QhnkeuUWJKz9dKIudKYFWbrYuMwkSZgbVJOkO4j7MZ57tJNEX/qCvrKD5kyN1GM
OtQ+im4t0VN2pYMUSMvRNTkE99FEYy1O1oGlrxi6H+y3Q4+5r6eqcPm/ASzPoGOK
oqE7sAMf8ffBNEm2kuSyZDKVvGWAhhKMONa2M8sNlImXnaparVc0RXTeemrccqDV
O9xCGrvHnr+Vxukf5rqpmLLOeH2tr6JJkokvD/6N0dEyBRj6RwrRIloxEgKSpx9F
UpBPCepF1FPu8gGRwZZJYH345xp5ccUG8SwLaqPpA+XVRoha1HDuUrDxjaranpEv
iggnQO/WeSQFdqvYCrXC+Vyl30rYYAAkdh2x/7fbaMn+KTivmOo=
=pzA1
-----END PGP SIGNATURE-----

--sgfxbmsll2gwt67h--
