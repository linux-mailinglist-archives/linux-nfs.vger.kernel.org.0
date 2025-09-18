Return-Path: <linux-nfs+bounces-14554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16FB849AB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955861C823CC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8B2D3225;
	Thu, 18 Sep 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TamGKSEj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD87257853;
	Thu, 18 Sep 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198947; cv=none; b=ZIkdO6BbiKSsJPIcoz5ARNKLu6Z834Tg1JHi4+36GWCCh7m9KsYEM6iNNgrmc0eYza7IAppS9vgaTn1r4kwlqgaNS3oX8HcW6wQK4NMT+NAoPktq14dvbAnXKNW0RsqvWod1pRiTgsNx58w6Bmx2F3TytbWQIYonzjptIfH2d3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198947; c=relaxed/simple;
	bh=XMABYdCsaZ05yg+jZdDt4/GbQBY/OYuDjEEyFUkd+xo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LBeTjXUzNrtXiyXQWSSyDxQtokN0tD78lOCLcJwS3mb5fttvDBWonGR9ilkH4MGIjcINZBqEmxhSF+IVblclGgHoIL9IDvZbZNTX9b7dXfI8v0oA8N1w8WP+kUeoA5jTNT6jfcYjj2/XnemfhOjC/Ty5a0ms8FKyHY922c+Q9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TamGKSEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E55C4CEE7;
	Thu, 18 Sep 2025 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758198946;
	bh=XMABYdCsaZ05yg+jZdDt4/GbQBY/OYuDjEEyFUkd+xo=;
	h=Date:From:To:Cc:Subject:From;
	b=TamGKSEjbwZ7Cb6Qm9GkiTVILpAmcpN2rCR2GU1wEmIyvYjIXWMiUE3N87WSppu0R
	 +Rksr2shogCBMqzbtWcQ1Jrnay6hnQf0KkunRVO2T+qXEukrBWyVuR+3KGUqXuheXy
	 aP4eUWKzzblXCTV6N9t24LGpV/4D0EyDNdSLbVZU6+GQV+osBUYUtIFLxv9cJhEHKs
	 YxWyqmi64m+FeNJ6LqNoGnBCRw2g3ytu3RrCbAvrv/3CPUIjU9U+uvRAnkrPz5dKx5
	 Giy+9PKfGg+lwkUa3lxjTnPpsyw5CBQQzghZy4q1ycP9Gy4Qy8ypPEpxqVdXlAP+wc
	 lzWpTszerB8Ag==
Date: Thu, 18 Sep 2025 13:35:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>,
	NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jonathan Curley <jcurley@purestorage.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nfs-anna tree
Message-ID: <aMv8ncNIMJw58v4O@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fY1yt8U20mIVi2nD"
Content-Disposition: inline


--fY1yt8U20mIVi2nD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the nfs-anna tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from /tmp/next/build/arch/arm/include/asm/div64.h:114,
                 from /tmp/next/build/include/linux/math.h:6,
                 from /tmp/next/build/include/linux/kernel.h:27,
                 from /tmp/next/build/include/linux/uio.h:8,
                 from /tmp/next/build/include/linux/socket.h:8,
                 from /tmp/next/build/include/uapi/linux/in.h:25,
                 from /tmp/next/build/include/linux/in.h:19,
                 from /tmp/next/build/include/linux/nfs_fs.h:22,
                 from /tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:10:
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c: In function 'calc_mirror_idx_from_commit':
/tmp/next/build/include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
  183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
      |                                   ^~
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
  685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |         ^~~~~~
In file included from /tmp/next/build/include/linux/array_size.h:5,
                 from /tmp/next/build/include/linux/kernel.h:16:
/tmp/next/build/include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
  195 |         } else if (likely(((n) >> 32) == 0)) {          \
      |                                ^~
/tmp/next/build/include/linux/compiler.h:76:45: note: in definition of macro 'likely'
   76 | # define likely(x)      __builtin_expect(!!(x), 1)
      |                                             ^
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
  685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |         ^~~~~~
/tmp/next/build/include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
  199 |                 __rem = __div64_32(&(n), __base);       \
      |                                    ^~~~
      |                                    |
      |                                    u32 * {aka unsigned int *}
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
  685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |         ^~~~~~
/tmp/next/build/arch/arm/include/asm/div64.h:24:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
   24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
      |                                   ~~~~~~~~~~^
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c: In function 'calc_dss_id_from_commit':
/tmp/next/build/include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
  183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
      |                                   ^~
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
  696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |                ^~~~~~
/tmp/next/build/include/asm-generic/div64.h:195:32: warning: right shift count >= width of type [-Wshift-count-overflow]
  195 |         } else if (likely(((n) >> 32) == 0)) {          \
      |                                ^~
/tmp/next/build/include/linux/compiler.h:76:45: note: in definition of macro 'likely'
   76 | # define likely(x)      __builtin_expect(!!(x), 1)
      |                                             ^
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
  696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |                ^~~~~~
/tmp/next/build/include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
  199 |                 __rem = __div64_32(&(n), __base);       \
      |                                    ^~~~
      |                                    |
      |                                    u32 * {aka unsigned int *}
/tmp/next/build/fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
  696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |                ^~~~~~
/tmp/next/build/arch/arm/include/asm/div64.h:24:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
   24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
      |                                   ~~~~~~~~~~^
make[6]: *** [/tmp/next/build/scripts/Makefile.build:287: fs/nfs/flexfilelayout/flexfilelayout.o] Error 1

Caused by commit

   67ee714244dfb ("NFSv4/flexfiles: Commit path updates for striped layouts")

I have used the tree from yesterday instead.

--fY1yt8U20mIVi2nD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjL/J0ACgkQJNaLcl1U
h9C/igf/Z9g54/pzM3yurEyLhVZb5OvGo/HZ/WrqTgSBzQaHKxxddNDVin/XYfZ8
ZlqDqIPfIBUe9XAjskU1meGI1KHZJYxTxLdwHX6QrcQuA5+azBUB5PAX/Xbombqp
jQAfP0aA9lJ7ggOQmqD8JZhUlRH7K76BIrkaQzGr9u2g+fAaa3Oa7TKpR0cuQRzQ
Gcy3J56So1QfC/hcdGBEBZUmsO08sRsyYbP5ZBH7g43OI7F+5GyFHC0dJwbbAw2V
3pvJBfennJkJK9VWwLuyGSyc+9YnktlvBb7B0qaXbCATnYuPGrMnFSt80DgiKABn
tjm6K2GxT3cMJ3p+fVsxwLjLj1cKEw==
=KaX4
-----END PGP SIGNATURE-----

--fY1yt8U20mIVi2nD--

