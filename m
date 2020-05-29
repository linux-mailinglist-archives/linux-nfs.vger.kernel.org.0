Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E871E71D2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 02:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438189AbgE2A7Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 20:59:24 -0400
Received: from ozlabs.org ([203.11.71.1]:47263 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438188AbgE2A7Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 May 2020 20:59:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y5n31b4zz9sRK;
        Fri, 29 May 2020 10:59:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590713960;
        bh=YSNC8nJ5eu33vdCCoyFy+TEvR5PMySe/tykBI2tGyVs=;
        h=Date:From:To:Cc:Subject:From;
        b=ti79V7IIVSe002hM3tjAgeStpzQdnRUmAIe9PN0EJh++vSSCqqD2zNgj7QCRjEIeJ
         XzRw0VD78NGLrZ9L6+i2e5exKTI+8raXmsLTOTrG7W7td4qqZtQCD86J9DVmGX1CSS
         rHvl0QmL9BhiMoS6bplpOiJ+JeF63EpyCamd0B5CeqTru9Oo98O5nET5zujFLALq2Y
         o+dctlpM+YFcwVZGG/lQnAKiGrwbYWVu9P4TETt+CzEQkX7aXSgjIWkwjUaNKuAydy
         6tU6VBzEWamJPw9Y73M5YGlFh9UOk+IZSPnveG5YEaXCeGxhqtGHyOld3CWrBzYbZ9
         82aSwC/q6MKnw==
Date:   Fri, 29 May 2020 10:59:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: linux-next: manual merge of the nfsd tree with the nfs-anna tree
Message-ID: <20200529105917.50dfc40f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lwn4Kbrbx_Hd18XI5zJbk85";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/lwn4Kbrbx_Hd18XI5zJbk85
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  include/trace/events/sunrpc.h

between commit:

  2baebf955125 ("SUNRPC: Split the xdr_buf event class")

from the nfs-anna tree and commit:

  998024dee197 ("SUNRPC: Add more svcsock tracepoints")

from the nfsd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/trace/events/sunrpc.h
index 73193c79fcaa,852413cbb7d9..000000000000
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@@ -14,9 -14,41 +14,42 @@@
  #include <linux/net.h>
  #include <linux/tracepoint.h>
 =20
+ TRACE_DEFINE_ENUM(SOCK_STREAM);
+ TRACE_DEFINE_ENUM(SOCK_DGRAM);
+ TRACE_DEFINE_ENUM(SOCK_RAW);
+ TRACE_DEFINE_ENUM(SOCK_RDM);
+ TRACE_DEFINE_ENUM(SOCK_SEQPACKET);
+ TRACE_DEFINE_ENUM(SOCK_DCCP);
+ TRACE_DEFINE_ENUM(SOCK_PACKET);
+=20
+ #define show_socket_type(type)					\
+ 	__print_symbolic(type,					\
+ 		{ SOCK_STREAM,		"STREAM" },		\
+ 		{ SOCK_DGRAM,		"DGRAM" },		\
+ 		{ SOCK_RAW,		"RAW" },		\
+ 		{ SOCK_RDM,		"RDM" },		\
+ 		{ SOCK_SEQPACKET,	"SEQPACKET" },		\
+ 		{ SOCK_DCCP,		"DCCP" },		\
+ 		{ SOCK_PACKET,		"PACKET" })
+=20
+ /* This list is known to be incomplete, add new enums as needed. */
+ TRACE_DEFINE_ENUM(AF_UNSPEC);
+ TRACE_DEFINE_ENUM(AF_UNIX);
+ TRACE_DEFINE_ENUM(AF_LOCAL);
+ TRACE_DEFINE_ENUM(AF_INET);
+ TRACE_DEFINE_ENUM(AF_INET6);
+=20
+ #define rpc_show_address_family(family)				\
+ 	__print_symbolic(family,				\
+ 		{ AF_UNSPEC,		"AF_UNSPEC" },		\
+ 		{ AF_UNIX,		"AF_UNIX" },		\
+ 		{ AF_LOCAL,		"AF_LOCAL" },		\
+ 		{ AF_INET,		"AF_INET" },		\
+ 		{ AF_INET6,		"AF_INET6" })
+=20
 -DECLARE_EVENT_CLASS(xdr_buf_class,
 +DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
  	TP_PROTO(
 +		const struct rpc_task *task,
  		const struct xdr_buf *xdr
  	),
 =20

--Sig_/lwn4Kbrbx_Hd18XI5zJbk85
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QXmUACgkQAVBC80lX
0GwH9wf/VHUVSU/pbcwDqZjofwf4zlhrQSB9ORfxA2jlejCbFWqAKNAgubNlNzIs
Nwm+mGiChH9vbIGIb41/3YZPM2cJdDfob1lbspFxU62HXV0+Sg7F7PQ+TBX80XSx
XhDKPaN2Vg3LoXTn5qmBIyIF7SUQKISDWSyoj5kIpGCzrFIQlikELJtqxCDcUv+D
J93pVASn8wOoOgM7uWbSQo+EVHyG7Aaj/U2sFMxmtPHrgRJPkv+hkXYqHGrffERT
6qCMxpwrp+zU8pd5chnh1Q/E+kFrslOX6N/Q67eUueEtO4XPUdlVOkSX5hX/B+/1
ikTKFuSFCZbEvOd2sRayumqYnjxibg==
=8UOS
-----END PGP SIGNATURE-----

--Sig_/lwn4Kbrbx_Hd18XI5zJbk85--
