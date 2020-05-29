Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B931E71E1
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 03:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438206AbgE2BFp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 21:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438203AbgE2BFo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 May 2020 21:05:44 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DEC08C5C6;
        Thu, 28 May 2020 18:05:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y5wM48S4z9sSm;
        Fri, 29 May 2020 11:05:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590714340;
        bh=Z20gFtDzP5c0COPxIaNotJ+e2emc7JlN6W9UKhFm/ys=;
        h=Date:From:To:Cc:Subject:From;
        b=VYrurR55T1tiJOS0rPb3cKu32pwneL2cf1e40/C2YzRpiYf7wCUJQyAnJH4IzpcU7
         QgiXSOxFhMmLiXEfbeexuR9byrJZ3FUIFEah6CN6OiMTAPADw7MX+YoW37FoQM8vyB
         g2Aot5yVvyu+IP+wG2C6H+FF6PM8jzNL66XuXzVeWbqQaayWojAY2avMigRboEztaK
         hCtAu7trxm6Z8ymaqfyRi2KIdHMFzhUZjo89YOq/KnXwd8S43SmEtMk23NGwy9psgw
         aHmaYVZTTiFZ+0agPpVfeiD2EhT9GyV5F5dU7Ha4GYkKeByVDn1dbtm2LRPzNuVmPu
         oC10srNwRpEZw==
Date:   Fri, 29 May 2020 11:05:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: linux-next: manual merge of the nfsd tree with the nfs-anna tree
Message-ID: <20200529110538.73d3fecb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NW_NhJTiMGTvMnqUr88BAds";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/NW_NhJTiMGTvMnqUr88BAds
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  net/sunrpc/svc_xprt.c

between commit:

  2baebf955125 ("SUNRPC: Split the xdr_buf event class")

from the nfs-anna tree and commit:

  ca4faf543a33 ("SUNRPC: Move xpt_mutex into socket xpo_sendto methods")

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

diff --cc net/sunrpc/svc_xprt.c
index 8ef44275c255,c1ff8cdb5b2b..000000000000
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@@ -913,17 -906,11 +906,11 @@@ int svc_send(struct svc_rqst *rqstp
  	xb->len =3D xb->head[0].iov_len +
  		xb->page_len +
  		xb->tail[0].iov_len;
 -	trace_svc_sendto(xb);
 +	trace_svc_xdr_sendto(rqstp, xb);
-=20
- 	/* Grab mutex to serialize outgoing data. */
- 	mutex_lock(&xprt->xpt_mutex);
  	trace_svc_stats_latency(rqstp);
- 	if (test_bit(XPT_DEAD, &xprt->xpt_flags)
- 			|| test_bit(XPT_CLOSE, &xprt->xpt_flags))
- 		len =3D -ENOTCONN;
- 	else
- 		len =3D xprt->xpt_ops->xpo_sendto(rqstp);
- 	mutex_unlock(&xprt->xpt_mutex);
+=20
+ 	len =3D xprt->xpt_ops->xpo_sendto(rqstp);
+=20
  	trace_svc_send(rqstp, len);
  	svc_xprt_release(rqstp);
 =20

--Sig_/NW_NhJTiMGTvMnqUr88BAds
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QX+IACgkQAVBC80lX
0Gyt1gf+OMS3j3SLMuMh+LFnRiOzJF2bVDwyuFIN+f+eep4ykrPs6DsasAcw0FiY
iI5hKJOAiAQTIw0mN2QS04dB9ZWhD8J6aZHc+mKXw6PqOEqaT+aMtQiNjtPmdXkI
PuDxHRMzeUcjr0Ov9TQl0U32Angg+lDERNaoZ8td4QUh//rCR2ljXsLjzYTXca3J
bVf7uaxPFmZhfYHiCg0SEDhWlyWHOz0mtBsxPha7JUt9fqfSTsWCCecEjShrzJUa
yGiiA6+x6sTtgkhRIiHOrRSe2rFnHLBefp/Lutw+oyYHE8OeHWcCZbCzxoAziEDf
zP7OD067BAQw1EXFAXVo/C1k5HBWgQ==
=jAGc
-----END PGP SIGNATURE-----

--Sig_/NW_NhJTiMGTvMnqUr88BAds--
