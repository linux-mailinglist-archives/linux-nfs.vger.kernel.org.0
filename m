Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48F361CAB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhDPJB2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 05:01:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47315 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240742AbhDPJB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 05:01:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EAF35C0091;
        Fri, 16 Apr 2021 05:00:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Apr 2021 05:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=4G80WgmZrbsLqASm8aHcQf2WuAVQOoavTsGWfKDN3yk=; b=jU6jt2ExiDvQ
        nPE+WGQvl9IioVFiy3faviG50IBqiTC69YPcZBP6FSvLVhCy7NT1pCRNzCy5n09X
        0QKma1nPsSLokgARrp8iEGLDrESPFGJICASgpY9GIEuiyvycvp1q0mhnqiba3lOn
        zyIAF579zCBNgivB+/iP1MHGEQGB3Hnp0hVLBkpC4kGtLJ/VnRzg8uhniVpVDEJW
        zaOeSn2NT5JJekhDXyqGdAQJziFzVTBYpgirwCjlYZntRKglNuJX0YGks6ja5NHX
        ZPWfL9Pli+D5n8KNmT0i2fyNC3L2MIWUfcQRk/Kz2Gf/ZzpBKwuRyjyr1sV3ZkAj
        B58LsDlI/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=4G80WgmZrbsLqASm8aHcQf2WuAVQO
        oavTsGWfKDN3yk=; b=tsKzSGoJrffLkr2/D3X8Wy/k8yNGMBiAS8q2AltvU30Ym
        wU7UtjORbi7daZBsZOfWsZ63oWkn/f3sqkguYsQJQ4FoqlRnCcDi3w/TuA4eaD4U
        ErmEPv/PibBY2GVR1KVYXFEY1oP3qJAcu4PWwOkhC5R1gsiNYID/koV5ghlUDjQS
        sbfoFLeyrs1KAr878MKQu8VBMGFgv/S9WT7BTD6pIbuvbdsgBgyltmsr3X4NNM8b
        ED7xYse0GcZYUt73IkS2HUqJ7k67GArzw9zQYsJOQatcIy1Nsed39ufXqYrd3YXX
        IwCvlPRbmiwwjcQI8Yo5cNoIqirjnruDLK8XQwW6A==
X-ME-Sender: <xms:S1J5YOPbTlioY2W-C5ebStspZjDUD0THKWISzEskqUdqBWRT4nYBSA>
    <xme:S1J5YK7ZnlgGRE759jm6YAm1DTz1zsvog4zaCGPteACqiD1Fq7OrI0Zs5ckxUiYY1
    wawYG6QguE043vb8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejieefvdeuleffgfejudffvdeghfeigfejgfdvvdefudevffefveffhffgkeeiffenucfk
    phepkeelrdduvddrfedtrddvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:S1J5YHlEDvu1ROt80StRsHEZZvzGWFxikM4dFPgpKCqKCaccT4bbaw>
    <xmx:S1J5YDQ45wxgDX1mG7Aw9BocOcClDp8LkUhXN-m4bEsF2T09JNGbWg>
    <xmx:S1J5YOEVzwYfo18qSdYvghYrGVLZb1bW0-jNPczrMDPBWaMXTQtemA>
    <xmx:S1J5YD86jA6s3xL0nZIt6Sw8dCFoREB4G6UXPVwOjidgUw-5Z1KObg>
Received: from vm-mail.pks.im (dynamic-089-012-030-238.89.12.pool.telefonica.de [89.12.30.238])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9ECDA108005B;
        Fri, 16 Apr 2021 05:00:58 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id cfb4c39e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Apr 2021 09:00:50 +0000 (UTC)
Date:   Fri, 16 Apr 2021 11:00:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH] Fix `statx()` emulation breaking exports
Message-ID: <a5547a1af1dc90d65100c873204a5b0912ecb9a8.1618563564.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cL/wszOrT/+3VUS"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--7cL/wszOrT/+3VUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ever since commit 76c21e3f (mountd: Check the stat() return values in
match_fsid(), 2020-05-08), it wasn't possible to export filesystems
on my musl based system anymore.

The root cause of this is the innocuous-looking change to decide based
on `errno` whether `is_mountpoint()` raised a real error or whether it
simply didn't match. The issue is that `is_mountpoint()` transitively
calls into our `xlstat()` wrapper, which either executes `statx()` if
the system supports it or otherwise falls back to `fstatat()`. But if
`statx()` is not supported, then we'll always first set `errno =3D ENOSYS`
before calling `fstatat()`. So effectively, all systems which do not
have `statx()` and whose `fstatat()` doesn't reset `errno` will cause us
to end up with errno set to `ENOSYS`.

Fix the issue by resetting `errno` before calling `fstatat()` in both
`xlstat()` and `xstat()`.

Fixes: 76c21e3f (mountd: Check the stat() return values in match_fsid(), 20=
20-05-08)
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 support/misc/xstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/support/misc/xstat.c b/support/misc/xstat.c
index a438fbcc..6f751f7f 100644
--- a/support/misc/xstat.c
+++ b/support/misc/xstat.c
@@ -85,6 +85,7 @@ int xlstat(const char *pathname, struct stat *statbuf)
 		return 0;
 	else if (errno !=3D ENOSYS)
 		return -1;
+	errno =3D 0;
 	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
 			AT_SYMLINK_NOFOLLOW);
 }
@@ -95,6 +96,7 @@ int xstat(const char *pathname, struct stat *statbuf)
 		return 0;
 	else if (errno !=3D ENOSYS)
 		return -1;
+	errno =3D 0;
 	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
 }
=20
--=20
2.31.1


--7cL/wszOrT/+3VUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB5UkAACgkQVbJhu7ck
PpQMPA//Y2sf85kEDNzNNhFKT8NdE8SMSRQuPByhHTAQ3pXxfJVZ6D+A5AD6SCWj
1yxru+xCtIZsdRQ5K7sJtNgiwF3bbAqzCv/uVVXBxz+l/wK5Dv8qN0/IvlYgIJ+N
Dd0yfRXIMXRjXMZG1Zre2hGn5AtVLTzRsOC3AxwesdztOAVo+9bUlNa35kGEvKQy
D/wfiwPKT0F6J6tYMx704j2eJ3LUiFv/G4H3sgfLVOjeftWTLh33PcCWfNvlDfGS
QrNWX26QZ1bvSbQlZKj3m0boTwyzt0PI067H4bPd3n5pyAO0u9dnk4gOPTodMZ72
2YnfqHhXsACXZ9tVj0d+u2dPetmRuIUWAVgfqVxSMVfQw3AB5zaJbWkYB4qCspXw
b4WyURcjkQ1tO8AO1loxdZy426XmRrBE/6JdFFBHDcu1KfiSBALx9F/72NH07lJB
gkpN8tIc0yhnnHE1eKtvwlc48zWmKhYEswPZzeiXvZd069FXunHz8wnjwG/GWP9F
+RuZHmLK4wnxxSoYntssdOGxsRCEb3yAOk6h35lwRql+H0f7LREuUPvIRo42pYYM
fGyLzISCqMn30R2paKuhFWGJTuNlD8D4XLfhhhTFF/K8IhbnzqNwSiIoYMKrLVks
G33Z8GBG0zm+KxyvSThF4PUC9NuF12s3fKIvp6luw3UBYHP4hpE=
=zDdZ
-----END PGP SIGNATURE-----

--7cL/wszOrT/+3VUS--
