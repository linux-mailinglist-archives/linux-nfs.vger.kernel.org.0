Return-Path: <linux-nfs+bounces-13168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70649B0CD37
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9227B1670F3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3A2F41;
	Mon, 21 Jul 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYH3X5Cs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F12E3716
	for <linux-nfs@vger.kernel.org>; Mon, 21 Jul 2025 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753136196; cv=none; b=MoInlzvIrdDJl7AOIxugU2TOYhUvalOywl7X10zBpjd3Mu8a3f7horlSVk63jotBUSBONFKHbk1fIONOtrjIgW1E/548rRe3YUmcQA4IUsM0EKF/LtU7BRx9KclJXMCDzGn2GpOaPaiSrPB69hRJG+fDepzQtEH1pjwwEdSZRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753136196; c=relaxed/simple;
	bh=kEyhaghdjB3rrJwK95bC45yGpnswbrBmpqtyWhTRNYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq0I3vcdGrmXohjnWZM7Q25lB/JjlnRZ6FFXy0GIfFnZvGE8B2bKJC62nh3F9Kbh0fSyOnb3+2ABp8vjIvgfCOTjlUga5Wl2dHWxpD/Kr/PobJkIiqohCZPiEM54uZfekpjCqPGoHuxFYkW5d7F84jgozDUhcrNzEl78QNGmrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYH3X5Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A31C4CEED;
	Mon, 21 Jul 2025 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753136195;
	bh=kEyhaghdjB3rrJwK95bC45yGpnswbrBmpqtyWhTRNYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYH3X5CsFo70qeep5+lELEoZAowyygIM199ksTe2F19M0BEwVqDf8IgZo5huzLWCa
	 LQh3nR2amkJ12JwRZjF7pocJHwnTv1owOUrBdOLApVYqRbpR9bI3xBJ3mzUAAyy4Nw
	 BtmNY86/vnZdzK87QeggBMmS1j1J7EkiZrrTCyHtSCKSdFcwgyDOMhoY2gH6AVQ4x+
	 QsGpzEwZR+YgdjgzlOahKSM39fbJpAx6jfpDHMVn4+BxEaOWVGlD4RoChJ7rLwsfd1
	 aXBaHlpAY7R9ckemTCOBXNx3q4Mm1jxt4l+MvjtPxAN00iVzVE2caU08T2JCPGI8BS
	 kHX76Rm6lYzwQ==
Date: Mon, 21 Jul 2025 23:16:30 +0100
From: Mark Brown <broonie@kernel.org>
To: zhangjian <zhangjian496@huawei.com>
Cc: steved@redhat.com, joannelkoong@gmail.com, chuck.lever@oracle.com,
	djwong@kernel.org, jlayton@kernel.org, okorniev@redhat.com,
	Aishwarya.Rambhadran@arm.com, linux-nfs@vger.kernel.org,
	lilingfeng3@huawei.com
Subject: Re: [PATCH V2] nfs:check for user input filehandle size
Message-ID: <f08bb3e3-3b02-4d00-a787-34b5fc30da1b@sirena.org.uk>
References: <20250628213107.2765337-1-zhangjian496@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+RYd9gDRMT5E5xH"
Content-Disposition: inline
In-Reply-To: <20250628213107.2765337-1-zhangjian496@huawei.com>
X-Cookie: panic: kernel trap (ignored)


--o+RYd9gDRMT5E5xH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 05:31:07AM +0800, zhangjian wrote:
> Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memory
> of server_fh is not passed from user space. So I add a check for input si=
ze.
>=20
> Log is snipped as following:

We've been seeing failures in -next on LTP on a range of arm64 systems
with NFS roots in the name_to_handle_at01, open_by_handle_at01 and
open_by_handle_at02 tests.  I bisected the first of these to this patch
which is in -next as e29be1f394a3dbadc4e and does look rather plausible.

Test log:

       25455 19:32:08.444643  tst_tmpdir.c:316: TINFO: Using /ltp-tmp/ltp-h=
YUZKTq9fM/LTP_namNHNk6a as tmpdir (nfs filesystem)
        25456 19:32:08.456042  tst_test.c:1900: TINFO: LTP version: 2025013=
0-1-g60fe84aaf
        25457 19:32:08.467435  tst_test.c:1904: TINFO: Tested kernel: 6.16.=
0-rc6-next-20250716 #1 SMP PREEMPT Wed Jul 16 13:20:00 UTC 2025 aarch64
        25458 19:32:08.467734  tst_kconfig.c:88: TINFO: Parsing kernel conf=
ig '/proc/config.gz'
        25459 19:32:08.478825  tst_test.c:1722: TINFO: Overall timeout per =
run is 0h 01m 30s
        25460 19:32:08.479124  tst_buffers.c:57: TINFO: Test is using guard=
ed buffers
        25461 19:32:08.490212  name_to_handle_at01.c:94: TFAIL: open_by_han=
dle_at() failed (0): ESTALE (116)
        25464 19:32:08.501869  name_to_handle_at01.c:94: TFAIL: open_by_han=
dle_at() failed (3): ESTALE (116)
        25465 19:32:08.512847  name_to_handle_at01.c:94: TFAIL: open_by_han=
dle_at() failed
        25489 19:32:08.672266  Summary:
        25490 19:32:08.672558  passed   0
        25491 19:32:08.672788  failed   27
        26185 19:33:10.208358  tst_tmpdir.c:316: TINFO: Using /ltp-tmp/ltp-=
hYUZKTq9fM/LTP_opeiSM8q7 as tmpdir (nfs filesystem)
        26188 19:33:10.231165  tst_kconfig.c:88: TINFO: Parsing kernel conf=
ig '/proc/config.gz'
        26189 19:33:10.231460  tst_test.c:1722: TINFO: Overall timeout per =
run is 0h 01m 30s
        26190 19:33:10.242485  tst_buffers.c:57: TINFO: Test is using guard=
ed buffers
        26191 19:33:10.253938  open_by_handle_at02.c:98: TPASS: invalid-dfd=
: open_by_handle_at() failed as expected: EBADF (9)
        26192 19:33:10.254233  open_by_handle_at02.c:98: TPASS: stale-dfd: =
open_by_handle_at() failed as expected: ESTALE (116)
        26196 19:33:10.288302  tst_capability.c:29: TINFO: Dropping CAP_DAC=
_READ_SEARCH(2)
        26197 19:33:10.299325  tst_capability.c:41: TINFO: Permitting CAP_D=
AC_READ_SEARCH(2)
        26198 19:33:10.310836  open_by_handle_at02.c:98: TPASS: no-capabili=
ty: open_by_handle_at() failed as expected: EPERM (1)
        26199 19:33:10.311132  open_by_handle_at02.c:92: TFAIL: symlink: op=
en_by_handle_at() should fail with ELOOP: ESTALE (116)
        26201 19:33:10.311579  Summary:
        26202 19:33:10.311782  passed   6
        26203 19:33:10.322143  failed   1
        26163 19:33:10.106087  tst_tmpdir.c:316: TINFO: Using /ltp-tmp/ltp-=
hYUZKTq9fM/LTP_opeJvSZuG as tmpdir (nfs filesystem)
        26166 19:33:10.117795  tst_kconfig.c:88: TINFO: Parsing kernel conf=
ig '/proc/config.gz'
        26167 19:33:10.128809  tst_test.c:1722: TINFO: Overall timeout per =
run is 0h 01m 30s
        26168 19:33:10.129102  tst_buffers.c:57: TINFO: Test is using guard=
ed buffers
        26169 19:33:10.140117  open_by_handle_at01.c:93: TFAIL: open_by_han=
dle_at() failed (0): ESTALE (116)
        26170 19:33:10.151537  open_by_handle_at01.c:93: TFAIL: open_by_han=
dle_at() failed (1): ESTALE (116)
        26177 19:33:10.197165  open_by_handle_at01.c:93: TFAIL: open_by_han=
dle_at() failed (8): ESTALE (116)
        26179 19:33:10.197714  Summary:
        26180 19:33:10.197929  passed   0
        26181 19:33:10.198134  failed   9

Bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [97987520025658f30bb787a99ffbd9bbff9ffc9d] Add linux-next specific f=
iles for 20250721
git bisect bad 97987520025658f30bb787a99ffbd9bbff9ffc9d
# status: waiting for good commit(s), bad commit known
# good: [922467c8223bfa20435da8c9b1c99285aac735ff] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 922467c8223bfa20435da8c9b1c99285aac735ff
# bad: [73d0e6df78d50bd07d097a76eddc99cd89864d09] Merge branch 'main' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 73d0e6df78d50bd07d097a76eddc99cd89864d09
# bad: [4ff8b17af7757fd16152eb8262c599129c8f5498] Merge branch 'fs-next' of=
 linux-next
git bisect bad 4ff8b17af7757fd16152eb8262c599129c8f5498
# good: [13c60604ff678ac477521d9846fc2f75f0972e4b] Merge branch 'for-next' =
of https://github.com/sophgo/linux.git
git bisect good 13c60604ff678ac477521d9846fc2f75f0972e4b
# bad: [dce9a77d74cf572c1348d9d47cd79e7b61580f56] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
git bisect bad dce9a77d74cf572c1348d9d47cd79e7b61580f56
# good: [11581c89066a19d050d12b002609ade30bb39ece] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
git bisect good 11581c89066a19d050d12b002609ade30bb39ece
# good: [1d4e5eefd114eeb35449a8bcbbaa968baaa591e3] Merge branch 'dev' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
git bisect good 1d4e5eefd114eeb35449a8bcbbaa968baaa591e3
# bad: [38a098af636b698e5e14978de4accdc8a5173e24] Merge branch 'linux-next'=
 of git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
git bisect bad 38a098af636b698e5e14978de4accdc8a5173e24
# good: [bce0d4cf481614eb1f0817a233d9479d609bd0a8] Merge branch 'ksmbd-for-=
next' of https://github.com/smfrench/smb3-kernel.git
git bisect good bce0d4cf481614eb1f0817a233d9479d609bd0a8
# good: [90c9550a8d65fb9b1bf87baf97a04ed91bf61b33] NFS: support the kernel =
keyring for TLS
git bisect good 90c9550a8d65fb9b1bf87baf97a04ed91bf61b33
# good: [d897d81671bc4615c80f4f3bd5e6b218f59df50c] pNFS: Handle RPC size li=
mit for layoutcommits
git bisect good d897d81671bc4615c80f4f3bd5e6b218f59df50c
# bad: [e29be1f394a3dbadc4e5d198dfc822d49569bb52] nfs:check for user input =
filehandle size
git bisect bad e29be1f394a3dbadc4e5d198dfc822d49569bb52
# good: [7db6e66663681abda54f81d5916db3a3b8b1a13d] pNFS: Fix disk addr rang=
e check in block/scsi layout
git bisect good 7db6e66663681abda54f81d5916db3a3b8b1a13d
# first bad commit: [e29be1f394a3dbadc4e5d198dfc822d49569bb52] nfs:check fo=
r user input filehandle size

--o+RYd9gDRMT5E5xH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+vD0ACgkQJNaLcl1U
h9Cnegf4kjFO+smA/i6ra3wGiNsXb0hSKrdkipk96HGczSA7aZx8Hhgoug6dtLqI
5s3Df+2C82NJZA3JgJ+yk6knpvqyTED3Dl4DpFyCkcW336HV06lJWWu6N/y5TwdX
QmdMuSPzHUX4O3LaWokLyvTHJ4nysU1mtjnnfjaZVqE7IVUqGgevukmSFZ/RAmV8
v0329Oyrs9lddL9sqAwH6IxJmeUUT4wZmp9XRXvP9AmXXnWmT+Lwwwt9WWMFcDBQ
8MdqbYUz/5+p2rbaQHrJBc/JW3QBZXuBkF115Act0Emgh2NvhfhPtdgAtWStxlD9
Ln2/W3AHIgFr97JHQoCMm/xltzIK
=e/qx
-----END PGP SIGNATURE-----

--o+RYd9gDRMT5E5xH--

