Return-Path: <linux-nfs+bounces-11038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E48A7FC2F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B323417CC09
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A826739B;
	Tue,  8 Apr 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcz+t0rM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFF265CDF
	for <linux-nfs@vger.kernel.org>; Tue,  8 Apr 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108296; cv=none; b=mV6EntcWUMijiK9oBchWxZdODzwmXbxx1usHSpKJbSpLUakTsN+etP9iIoiYFoPc+V+DxHHOycNAHoNZPnm4srY2RwQTLWNFZYqgk0V4psMRr1qUmwF9umAqqcBTEM3szV5K7NFyjVLYndwX2PuzD0OFK7VQwjuYYPJDEJSJ+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108296; c=relaxed/simple;
	bh=oI20pcewXYpP3qfBG6PL8nPGzX80KkiGtK7/hps0xUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHxsln7MQfbUFJFIw/cIB/RFSgyhnfnZ8TLgvp+IzEAGwoqgeRLTFJ6hz80cVNMIAJCilgMOIzNVqordEwg/5NNJgt/dOlkMVBAhtI5BxpUomIv+G+ZDbS7WC8euDruNwYWUvC6xfY+D7OAA+G7RYgTuhkI5205CSL8ETOAdCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcz+t0rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E46C4CEE8;
	Tue,  8 Apr 2025 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744108296;
	bh=oI20pcewXYpP3qfBG6PL8nPGzX80KkiGtK7/hps0xUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rcz+t0rMQuIzdQa4Hn1qBuEgMMNDOcVh7rPDohHTuc5ktBxQMQQfxtnvXQiqkby4y
	 WsCGZX3SUvqZndpjJaqPlS/uQP+QIIWad6ZeDs8trCGmpjeUhqeOQJrcjqBhe+YDav
	 LPWN8mr4JjnYYuRVBuMxRhOtxWxQrtDq3eAfgnd2Lk1C9HoSR0l9ZwVU8B4XqldYCx
	 BgvNHQ0j7IfyX3aMBbc3Wed2R8jzIKTZDF41kF3R6BfiylhUiQYLMVO20wBlmcHcWw
	 tarYqOngyzzs4D28oX92UTyZ0xyRrWViUKTNHuxPdr2rCykB5GCsypj2KUW5Mq2IHv
	 AHRAZSZUsNyLw==
Date: Tue, 8 Apr 2025 11:31:32 +0100
From: Mark Brown <broonie@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Message-ID: <7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk>
References: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Xz5Gb6lRLhhmRUb"
Content-Disposition: inline
In-Reply-To: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
X-Cookie: Jenkinson's Law:


--7Xz5Gb6lRLhhmRUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Once a task calls exit_signals() it can no longer be signalled. So do
> not allow it to do killable waits.

We're seeing the LTP acct02 test failing in kernels with this patch
applied, testing on systems with NFS root filesystems:

10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60f=
e84aaf
10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1=
 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/pro=
c/config.gz'
10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0=
h 01m 30s
10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/pro=
c/config.gz'
10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=3Dy
10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
10280 05:03:10.064653  acct02.c:193: TINFO: =3D=3D entry 1 =3D=3D
10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm !=3D 'acct02_helper' ('a=
cct02')
10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode !=3D 32768 (0)
10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid !=3D 2466 (2461)
10284 05:03:10.076572  acct02.c:183: TFAIL: end of file reached
10285 05:03:10.076790 =20
10286 05:03:10.087439  HINT: You _MAY_ be missing kernel fixes:
10287 05:03:10.087741 =20
10288 05:03:10.087979  https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git/commit/?id=3D4d9570158b626
10289 05:03:10.088201 =20
10290 05:03:10.088414  Summary:
10291 05:03:10.088618  passed   0
10292 05:03:10.098852  failed   1
10293 05:03:10.099212  broken   0
10294 05:03:10.099454  skipped  0
10295 05:03:10.099675  warnings 0

I ran a bisect which zeroed in on this commit (log below), I didn't look
into it properly but the test does start and exit a test program to
verify that accounting records get created properly which does look
relevant.

git bisect start
# status: waiting for both good and bad commits
# bad: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
git bisect bad 0af2f6be1b4281385b618cb86ad946eded089ac8
# status: waiting for good commit(s), bad commit known
# good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
# good: [fd71def6d9abc5ae362fb9995d46049b7b0ed391] Merge tag 'for-6.15-tag'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good fd71def6d9abc5ae362fb9995d46049b7b0ed391
# good: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-nex=
t-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
git bisect good 93d52288679e29aaa44a6f12d5a02e8a90e742c5
# good: [2cd5769fb0b78b8ef583ab4c0015c2c48d525dac] Merge tag 'driver-core-6=
=2E15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-c=
ore
git bisect good 2cd5769fb0b78b8ef583ab4c0015c2c48d525dac
# bad: [25757984d77da731922bed5001431673b6daf5ac] Merge tag 'staging-6.15-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 25757984d77da731922bed5001431673b6daf5ac
# good: [28a1b05678f4e88de90b0987b06e13c454ad9bd6] Merge tag 'i2c-for-6.15-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 28a1b05678f4e88de90b0987b06e13c454ad9bd6
# good: [92b71befc349587d58fdbbe6cdd68fb67f4933a8] Merge tag 'objtool-urgen=
t-2025-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 92b71befc349587d58fdbbe6cdd68fb67f4933a8
# good: [5e17b5c71729d8ce936c83a579ed45f65efcb456] Merge tag 'fuse-update-6=
=2E15' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
git bisect good 5e17b5c71729d8ce936c83a579ed45f65efcb456
# good: [344a50b0f4eecc160c61d780f53d2f75586016ce] staging: gpib: lpvo_usb_=
gpib: struct gpib_board
git bisect good 344a50b0f4eecc160c61d780f53d2f75586016ce
# bad: [9e8f324bd44c1fe026b582b75213de4eccfa1163] NFSv4: Check for delegati=
on validity in nfs_start_delegation_return_locked()
git bisect bad 9e8f324bd44c1fe026b582b75213de4eccfa1163
# good: [df210d9b0951d714c1668c511ca5c8ff38cf6916] sunrpc: Add a sysfs file=
 for adding a new xprt
git bisect good df210d9b0951d714c1668c511ca5c8ff38cf6916
# good: [bf9be373b830a3e48117da5d89bb6145a575f880] SUNRPC: rpc_clnt_set_tra=
nsport() must not change the autobind setting
git bisect good bf9be373b830a3e48117da5d89bb6145a575f880
# good: [c81d5bcb7b38ab0322aea93152c091451b82d3f3] NFSv4: clp->cl_cons_stat=
e < 0 signifies an invalid nfs_client
git bisect good c81d5bcb7b38ab0322aea93152c091451b82d3f3
# bad: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiti=
ng for exiting tasks
git bisect bad 14e41b16e8cb677bb440dca2edba8b041646c742
# good: [0af5fb5ed3d2fd9e110c6112271f022b744a849a] NFSv4: Treat ENETUNREACH=
 errors as fatal for state recovery
git bisect good 0af5fb5ed3d2fd9e110c6112271f022b744a849a
# first bad commit: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don'=
t allow waiting for exiting tasks

--7Xz5Gb6lRLhhmRUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf0+wMACgkQJNaLcl1U
h9COfAf+M+NU6IMgaG6gGEnTOCaF2x+NRNKOVGdCJjORES3tqWP45Qfv9PcTBn/R
yUU5SBKglnA0bTkKK/T8pL9oFt/5/W7XQZrqsiMkJEe4NB9L9zYviTtneqXT+DoI
aysxCTs1uwaBHF4BN2xls0CN/JGLfAhtHh/GInJx2ywbH2m7zltItVTYvAdsjSc/
ii3L/G6wV2eZXx0CO1ywIOpoaQduN+9HnmTyWu786aTg/qF2qOhnKQ1BLkq0gx69
w1yvsF424ozIGokngE/Mt2BafXHoMelY5POHZJ+HJy57ANSZ7qnJEKybS0ndzA0p
OUPllA+zliXWNqf0WxojH4nHIDUN1A==
=OHSi
-----END PGP SIGNATURE-----

--7Xz5Gb6lRLhhmRUb--

