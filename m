Return-Path: <linux-nfs+bounces-848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BD820B75
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 14:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72240B2112B
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139ED443D;
	Sun, 31 Dec 2023 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZGSSycWL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124763A4;
	Sun, 31 Dec 2023 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704030977; x=1704635777; i=markus.elfring@web.de;
	bh=nEsttUe5CEeUqngGIn4dzPSKvNy9/cvmNlkaVhhQ/RI=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ZGSSycWLpylunPskg+Jfpa5BqMEB6fl2Fmr86fzW43GthcPpO+0bGH2uuOd8E5V0
	 o7NHzJjTIoGxkimBoFgLVhQw7sSaG4dfn9/5kXZyFXw9QTupEK0+ta7e7u8qWSmrD
	 b8PqqjRzFFfDNUinGbokp7s9Orqr6Pn5hkWxqjfJsoLBsvXfQlPW3IlEKfliYnuZ/
	 omg2wgpUfwmVXOnINBJSEPY2CoS4Sqsq+hVtvX6OcKlbhjw99GzALOV7b1uZPb2bT
	 AkThayunimX4O0HvN9PcJlQDHzAhMdtWn9VaizZgFj1uEULUyl4q9bY6l+lyfKzbw
	 +Tir+rZTsvhlvGAjfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3US-1r2PTt1ebo-00rCuf; Sun, 31
 Dec 2023 14:56:17 +0100
Message-ID: <9561c78e-49a2-430c-a611-52806c0cdf25@web.de>
Date: Sun, 31 Dec 2023 14:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Paolo Abeni <pabeni@redhat.com>,
 Simo Sorce <simo@redhat.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sunrpc: Improve exception handling in krb5_etm_checksum()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o+3oZXM5aXP/oMmDGvXATTeotOUUcg2HhBC82RxxTCVtwusv7eB
 eshDx6Ds/r1WrT4BxuV7iTY4+ztBXSrVSWl/npez0TvP14HaKWEYqJfsCNC9+l55IIk7SQo
 mohd9UUyH+SiSKlfDAG4iCNw37UT9/bL+xedA9g5wC5XYMN4ZobjN0qJW4iW7U3xbQK0b6/
 F4wmIoQJZl1rzSElX2uRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JhErPCm2gD8=;niu1kNu3Lld8W+IjwHnupI/88oo
 TljVn9uu+ZniZOxStJvZucN2ftjtVSru+w19o9A1jkY6reneqHYApyyBZE84AhsRZ3WaJQPuv
 z9UNN70vfNwKk4J6gxpDiMr/nRUoQqghPeM8QL25Wpi31Nk/ARkKzl7Ds9EpgDeJDYoFvpi+K
 dXpWrmqja/Y2VQTqeM1tC1NRTlBlrdH7O+m60xkSZCJDOeq0Er3G9fbV5QVg+H7zVuAMLMaTI
 lgnFuheBryWGXQDpQU8bA7SYbhoWR4dswhg7ln1I0wF2mGu5RAi6sHX6M9BX68M1XiRxZ0F4h
 tu0nqJJolvEYG2JALwp7z6oM6AX63gpWnNVMLxRmNDQk8kETV3Gw6hEF2JHFY9OFTzpuMtMIn
 uLOBipgLMJmfZcc7mKJHHerYk4c6e44RTKTu6OVgfn1oYO+xBhbzHDdt9rASuvlT6ohtcinVf
 QsYdcKTcJ3U0bDw88hnAsUS6xOzfcajdnjvYm+pxfITL63zrSwAC8VrrFq+F/CKHndmTGknxV
 b17NSyq6efTIKcCEYF9vbqBUEMb+xWSfsjs5evUwcjRu7kn/OsAO848sxbU+Xf21myLOpOCQ2
 a7Pbqqyg8Aq6g1BplUrLLvhu2KVBvjOPCz6y5il921tUl02+iCaNIQ8K+GLPFQaonTyuhwfNf
 1ImIOa2d40U59iYTqB+3GxwIG4Y6x2lIFhGb+qJNWBJsTZo+hdxg3+vl6tfdKvmtFEK76qqNL
 QoWag+rYgDUKOUri45VnrZ6na0wDH0uAQeT9GLDYNO8lyYWSXoodcRkU1+nngZeCR2B/uPw5m
 SLwjXY1mwsLjOxJ9l87fTLKc5vsswWbBHSUk7tmxe0IJGFAhSYnDxkYOxGFnjjDysPa+7oHWw
 9FmBlj3SFAZNrsFZO01Hht+GbAkr5Bx1T7rY2MkAXz3dQ8Eydv9ihHDy5YEVBlW9Ks8YIOBcW
 o4RNEQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 14:43:05 +0100

The kfree() function was called in one case by
the krb5_etm_checksum() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/g=
ss_krb5_crypto.c
index d2b02710ab07..5e2dc3eb8545 100644
=2D-- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -942,7 +942,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cip=
her,
 	/* For RPCSEC, the "initial cipher state" is always all zeroes. */
 	iv =3D kzalloc(ivsize, GFP_KERNEL);
 	if (!iv)
-		goto out_free_mem;
+		goto out_free_checksum;

 	req =3D ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
@@ -972,6 +972,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cip=
her,
 	ahash_request_free(req);
 out_free_mem:
 	kfree(iv);
+out_free_checksum:
 	kfree_sensitive(checksumdata);
 	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
 }
=2D-
2.43.0


