Return-Path: <linux-nfs+bounces-663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7D8154A7
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 00:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E50C1F25863
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF302C699;
	Fri, 15 Dec 2023 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="ALLplDil"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6249F61;
	Fri, 15 Dec 2023 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702684425;
	bh=Rp8yaDPkB4QdC5rV4rYLgAqrcv6iNuhHVPicafTNPjA=;
	h=Date:From:Cc:Subject:From;
	b=ALLplDilttu5v8rqxLa6CwJtIrwuJP315MxWVHc7kAmGUMtCESeRMxJJKx//uddqP
	 YcCPENjMBMXJxfHq0jP8o+iUCLyH3eEAFrqTRwXk2l6ce658bdaGBGsnTAwEKA3e35
	 M1qGj+ioDQOY/FF6TwSy8BACJc46tKJQQGTXETuJYb42Q66j12hIWj/5HbySwik3Rq
	 1RAE5JsMOXMxZ70/mYf33JVw1C8rek5tApnMlnXPcz0C2nl7G3CHZ+Qay2cHiY4Km2
	 OuLbW5mgmoXiW+TgjgI2ZnYcCH3NDCgtAc3Tfd8g6AhgSLjdN+S2sEy7gawLVbOJJS
	 zUIJ1Nc3AdEGA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E14E3131E6;
	Sat, 16 Dec 2023 00:53:45 +0100 (CET)
Date: Sat, 16 Dec 2023 00:53:45 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: sunrpc: sizeof('\0') is 4, not 1
Message-ID: <4zlmy3qwneijnrsbygfr2wbsnvdvcgvjyvudqnuxq5zvwmyaof@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pluqraly4f3xucjm"
Content-Disposition: inline
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--pluqraly4f3xucjm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To make it self-documenting, the referenced commit added the space
for the null terminator as sizeof('\0'). The message elaborates on
why only one byte is needed, so this is clearly a mistake.
Spell it as 1 /* NUL */ instead.

This is the only result for git grep "sizeof.'" in the tree.

Fixes: commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in
 rpc_uaddr2sockaddr()")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/sunrpc/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index d435bffc6199..c4ba342f6866 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -311,7 +311,7 @@ size_t rpc_uaddr2sockaddr(struct net *net, const char *=
uaddr,
 			  const size_t uaddr_len, struct sockaddr *sap,
 			  const size_t salen)
 {
-	char *c, buf[RPCBIND_MAXUADDRLEN + sizeof('\0')];
+	char *c, buf[RPCBIND_MAXUADDRLEN + 1 /* NUL */];
 	u8 portlo, porthi;
 	unsigned short port;
=20

base-commit: 26aff849438cebcd05f1a647390c4aa700d5c0f1
--=20
2.39.2

--pluqraly4f3xucjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV85wkACgkQvP0LAY0m
WPE6lQ/+NHjguNV1PqOjyvFWculazWD9CBMypIE2ibK1lYsJl5ekrN1odp5UGdUI
fmFemQFGcWnzmxKU/P1iBJwn7TRmuoPKiUnq+MFmGVEtBserGOGbwIxJnPlGIMhW
nSA/7lyUJHR3xYc57YLSmnRPtpfiuNPpyCASKuuRh1TLJ6NMMS0qCg68thTGvQ0+
K8mT7tRhplYx83TTKJmp0B39sKtEy/tY1nYGGoKEtNEYs0W9AVHBX23qHGcgJ5y+
UMxsiJjVYtw1IOR1/hZ6JVUKxre/kewUUrdr4/F5J0SAu7j/a+ygjXZKlGDv19Ik
eEetfCwBEknB3M0WhldRBnqo9LsJSJM55B06L0yCeUByqIp/PUN88IXNDIBK79yO
k54V72jJAU4E5ylYJ1CADP2KwW6aUQIFHpIX8eEip89VOMMZIw9I5OB5dvICKdDO
TQ14LcGiJuuB0mnEJmaYIzuo1jdr1rXXqlejxr+K3Rn7ZjlwRNRQXZ6RXQPvTilO
gtW7MH2XJHEzmZHHALwnX5wk8jukengejSDN2fJodbCnMumR6mqj/VvWyxdmPOg+
WlAKqq5pH7nIVumoD3NGC0S3qysJ2EnmzzmjoPmtBX9GxwIVzidRaXdbOVrD31tE
LZhdmnzdXIS6T69P5LNUJq5gc+EIvU5QikLgweAx3SSgbp4MegM=
=civI
-----END PGP SIGNATURE-----

--pluqraly4f3xucjm--

