Return-Path: <linux-nfs+bounces-21731-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMnGC2XLDWqq3QUAu9opvQ
	(envelope-from <linux-nfs+bounces-21731-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:55:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71C2590436
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160BC3274578
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F53EF647;
	Wed, 20 May 2026 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb6/y6W7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72E3E2ACD;
	Wed, 20 May 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287520; cv=none; b=K7GI/hiUKrizoOVL5hTPQc+KhByV/xLOYiAHyepxpJu+x42PZ6To/iyv2TqIR1OOCVcVwASO20btiU7xzqAYyhZfR2hUASDgOfQCH+UZdRS0NhYdozosQKbb6OJi5sPTDABHuGM6hzOdQ2Vj+QLu7ElFjZjU7E+n6OfxBUZ72os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287520; c=relaxed/simple;
	bh=aJ/HkvCIlSs8z3YWz3Z5JfGNPHb7A0Vul9cplEZ5KYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMGCiaS3iTSAcYnBuAGt6SPx++sZNSfX3EeZu9l8dKx57ImZY8PNoPy2e4MNGCHxUMefkxJlf4ZwRJkDXcEcU7R6zdum3toeo9Te9SseWcPdERwQJ6TOqDTe1ONqofdKb588f3zmasUHxg4ySBC/ezJXxzMiL4uK8YPDUUPX/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb6/y6W7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88A1F000E9;
	Wed, 20 May 2026 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287517;
	bh=ErGeZjBujVCDw+tIBUMwUQ/ieYQ/G25L4GkC/HRjWR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fb6/y6W7lesYX2qA6apxZkVCqPfIDWJwHW4IQCUYQoqCwwQp2u+HD+p96akML/v+d
	 ap87OQCkBjPD35ZPv9tGs7SXT+Gi4Wa3a8bGQmbGS+K0VIkGeLtrV3NlOp/piFWl0j
	 SCMCaNsPnYQOlhhUIpuJT0rxK5Fb2RI+2D2xagucuWnA8JrHVtt5FfQHatQdyNoK+/
	 b9AS4i2AnFW5nIO5pb97yWFhHte23l3vVJkALXzb4LTrmhXeBmcSgODW6B4/Di4Aa9
	 ObG/IxvN8M3QSNC2sg8H7DKBGjVWq0SjDJujUgDqqiBVu60vMsZYOrKwjGDMceaY25
	 yEFnwgaJHmGdA==
Date: Wed, 20 May 2026 15:31:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH v14 03/15] fat: Implement fileattr_get for case
 sensitivity
Message-ID: <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EE3WBxe127Z9kpbN"
Content-Disposition: inline
In-Reply-To: <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
X-Cookie: There's no time like the pleasant.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21731-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,gitlab.freedesktop.org:url,sirena.org.uk:url,sirena.org.uk:mid]
X-Rspamd-Queue-Id: C71C2590436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--EE3WBxe127Z9kpbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 04:52:56AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Report FAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> and FS_XFLAG_CASENONPRESERVING flags. FAT filesystems are
> case-insensitive by default.
>=20
> MSDOS supports a 'nocase' mount option that enables case-sensitive
> behavior; check this option when reporting case sensitivity.
>=20
> VFAT long filename entries preserve case; without VFAT, only
> uppercased 8.3 short names are stored. MSDOS with 'nocase' also
> preserves case since the name-formatting code skips upcasing when
> 'nocase' is set. Check both options when reporting case preservation.

I'm seeing a regression in -next with the LTP statx04 test which bisects
to this commit:

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sta8hUyB4 as tmpdir (tmpfs filesyst=
em)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:2047: TINFO: LTP version: 20260130
tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc4-next-20260520 #1 SMP PREEM=
PT @1779279361 aarch64

=2E..

tst_test.c:1985: TINFO: =3D=3D=3D Testing on vfat =3D=3D=3D
tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra opt=
s=3D''
tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_sta8hUyB4/mntpoint =
fstyp=3Dvfat flags=3D0
statx04.c:121: TFAIL: STATX_ATTR_COMPRESSED not supported
statx04.c:121: TFAIL: STATX_ATTR_APPEND not supported
statx04.c:121: TFAIL: STATX_ATTR_IMMUTABLE not supported
statx04.c:121: TFAIL: STATX_ATTR_NODUMP not supported

Full log:

   https://lava.sirena.org.uk/scheduler/job/2778994#L6373

bisect log, with links to intermediate test results:

# bad: [687da68900cd1a46549f7d9430c7d40346cb86a0] Add linux-next specific f=
iles for 20260520
# good: [2b248ec57f3dcb99f2ce423b72eb3b77553e90a0] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [1c9631527427d35668eeb7236803cc4b18f950a8] Merge branch 'vfs-7.2.pr=
ocfs' into vfs.all
# good: [3035e4454142327ec5faee2ff57ab7cb1e9fc712] fs: Add case sensitivity=
 flags to file_kattr
git bisect start '687da68900cd1a46549f7d9430c7d40346cb86a0' '2b248ec57f3dcb=
99f2ce423b72eb3b77553e90a0' '1c9631527427d35668eeb7236803cc4b18f950a8' '303=
5e4454142327ec5faee2ff57ab7cb1e9fc712'
# test job: [1c9631527427d35668eeb7236803cc4b18f950a8] https://lava.sirena.=
org.uk/scheduler/job/2774081
# test job: [3035e4454142327ec5faee2ff57ab7cb1e9fc712] https://lava.sirena.=
org.uk/scheduler/job/2774556
# test job: [687da68900cd1a46549f7d9430c7d40346cb86a0] https://lava.sirena.=
org.uk/scheduler/job/2778994
# bad: [687da68900cd1a46549f7d9430c7d40346cb86a0] Add linux-next specific f=
iles for 20260520
git bisect bad 687da68900cd1a46549f7d9430c7d40346cb86a0
# test job: [8d97e7babd9a9ff8b5be4e4105d24ad3514044ff] https://lava.sirena.=
org.uk/scheduler/job/2774206
# bad: [8d97e7babd9a9ff8b5be4e4105d24ad3514044ff] Merge branch 'vfs-7.2.cas=
efold' into vfs.all
git bisect bad 8d97e7babd9a9ff8b5be4e4105d24ad3514044ff
# test job: [f9eba293ae7ca289e587985f94d84a390949ea31] https://lava.sirena.=
org.uk/scheduler/job/2773899
# bad: [f9eba293ae7ca289e587985f94d84a390949ea31] Merge branch 'kernel-7.2.=
misc' into vfs.all
git bisect bad f9eba293ae7ca289e587985f94d84a390949ea31
# test job: [eeb7b37b9700f0dbb3e6fe7b9e910b466ac190dd] https://lava.sirena.=
org.uk/scheduler/job/2774402
# bad: [eeb7b37b9700f0dbb3e6fe7b9e910b466ac190dd] ntfs3: Implement fileattr=
_get for case sensitivity
git bisect bad eeb7b37b9700f0dbb3e6fe7b9e910b466ac190dd
# test job: [c92db2ca726fe61a66580d30ecff8c192a791935] https://lava.sirena.=
org.uk/scheduler/job/2774955
# bad: [c92db2ca726fe61a66580d30ecff8c192a791935] fat: Implement fileattr_g=
et for case sensitivity
git bisect bad c92db2ca726fe61a66580d30ecff8c192a791935
# first bad commit: [c92db2ca726fe61a66580d30ecff8c192a791935] fat: Impleme=
nt fileattr_get for case sensitivity
# test job: [b6fe046c30236e37e3f8c500cf5b1297c317c5ee] https://lava.sirena.=
org.uk/scheduler/job/2776383
# bad: [b6fe046c30236e37e3f8c500cf5b1297c317c5ee] hfs: Implement fileattr_g=
et for case sensitivity
git bisect bad b6fe046c30236e37e3f8c500cf5b1297c317c5ee
# test job: [27e0b573dd4aa927670fbfd84732e569fde72078] https://lava.sirena.=
org.uk/scheduler/job/2774607
# bad: [27e0b573dd4aa927670fbfd84732e569fde72078] exfat: Implement fileattr=
_get for case sensitivity
git bisect bad 27e0b573dd4aa927670fbfd84732e569fde72078
# test job: [ef14aa143f1dd8adcba6c9277c3bbed2fe0969b4] https://lava.sirena.=
org.uk/scheduler/job/2774344
# bad: [ef14aa143f1dd8adcba6c9277c3bbed2fe0969b4] vboxsf: Implement fileatt=
r_get for case sensitivity
git bisect bad ef14aa143f1dd8adcba6c9277c3bbed2fe0969b4
# test job: [b6fe046c30236e37e3f8c500cf5b1297c317c5ee] https://lava.sirena.=
org.uk/scheduler/job/2776383
# bad: [b6fe046c30236e37e3f8c500cf5b1297c317c5ee] hfs: Implement fileattr_g=
et for case sensitivity
git bisect bad b6fe046c30236e37e3f8c500cf5b1297c317c5ee
# test job: [27e0b573dd4aa927670fbfd84732e569fde72078] https://lava.sirena.=
org.uk/scheduler/job/2774607
# bad: [27e0b573dd4aa927670fbfd84732e569fde72078] exfat: Implement fileattr=
_get for case sensitivity
git bisect bad 27e0b573dd4aa927670fbfd84732e569fde72078
# test job: [c92db2ca726fe61a66580d30ecff8c192a791935] https://lava.sirena.=
org.uk/scheduler/job/2774955
# bad: [c92db2ca726fe61a66580d30ecff8c192a791935] fat: Implement fileattr_g=
et for case sensitivity
git bisect bad c92db2ca726fe61a66580d30ecff8c192a791935
# first bad commit: [c92db2ca726fe61a66580d30ecff8c192a791935] fat: Impleme=
nt fileattr_get for case sensitivity

--EE3WBxe127Z9kpbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoNxdMACgkQJNaLcl1U
h9AR/gf+PBemUL4ODlI4Hfs3EledyCUDFVjnqUwLIFBkxy8s3uvAc7gM+MU52I8G
Xuldrsvs3M0XV6Zmn8D6UsctYcsfsCNIOut25z7stoiQ/hv5UJlpOuogkdIAS0yp
yzWi3zCVnFCbFRGKk67Ep5TDAdUyg62Qx+g8/1uzsg7UbWNIGaRO1OBw8Ea/xlJE
7BHE60VBroQ4GdwGXSVoXzxYwZeKjXqUi3cTxkVWWvSZI7ncyZofjPRii2Wb6sqN
w6Msvqsvok/CVV9yLbrV4sj27+K+bbPJ79KrOfePpj25RNwSnWBPcEfpLsgtoHCU
UHg4hene6OTPk57+fNNXVpWKwHBuZw==
=9Yxi
-----END PGP SIGNATURE-----

--EE3WBxe127Z9kpbN--

