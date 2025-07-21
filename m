Return-Path: <linux-nfs+bounces-13169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68FB0CD91
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2028E1774E3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A791EF1D;
	Mon, 21 Jul 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0XaUyae"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3223C8D3
	for <linux-nfs@vger.kernel.org>; Mon, 21 Jul 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139322; cv=none; b=NEDJrRvZamVje5dQ6GCWUu9SHia9Leuw5lZ7ywNJtIdxyiz6vavhWZBnTNqbqc+6nBoIeMxQTgw6orrQepklJKeqyvwb3Sp0qCdzuKr135JWtVeHNLJ4UYivIABZxVRQtqm+iiBv+QEUsP/XwUDtT3PAsN3zpejOqVMv4Y7VkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139322; c=relaxed/simple;
	bh=42kDsCqFABCtbPKeDQJKIvyfwUzbsqf/eoZy+KMN8gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GqcGQITI+n3u5wjpQJCOmslMSoh+x0sX7tcDl34B/QxIt67r9dI8bGSIx5bxRyx8XKlOf8EwfehaygJoA0F9aT4w60x9lh0jzbqqbFBbePxfwBar+6w8IjOCHTvUKPBuBPxuAetPy7C5cfmF94sbCV0eDleWJz5rSfQMXYGmUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0XaUyae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0816CC4CEED;
	Mon, 21 Jul 2025 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139321;
	bh=42kDsCqFABCtbPKeDQJKIvyfwUzbsqf/eoZy+KMN8gg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D0XaUyaezQ+WogIq9uxkul17hyuinEGwUMrDkCbmou1UWWSyGqopvK1hEaRICN8LJ
	 faiu+NJY5Wj2AtXQTbcqSiYFeTFNw61J+niY3Zbq3knC1pj7vmZdA97ZNT2rqsxEBj
	 CrfnBZlSczpI9/xRtEL9Z18DwV5qtcqjEM9yn9AProoDIZw9SqOb2/Xt24Gtw2WuiH
	 kVq2fVwj+LJSuz6pFL04+rJo85PUcWdL5bQCmMjrTnuYdrz4fEQzL3Hnk+pT8mons4
	 NCpDiaBlabLujzL+McxCPD1AW/cJ7CYZ6xhxElbzmg5S5+xdBLVv126hjjT1WItauL
	 uMFth4R0zJQ/A==
Message-ID: <e988251e8c5912a8e2c34ce8efbdcee239e25a59.camel@kernel.org>
Subject: Re: [PATCH V2] nfs:check for user input filehandle size
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Brown <broonie@kernel.org>, zhangjian <zhangjian496@huawei.com>
Cc: steved@redhat.com, joannelkoong@gmail.com, chuck.lever@oracle.com, 
	djwong@kernel.org, jlayton@kernel.org, okorniev@redhat.com, 
	Aishwarya.Rambhadran@arm.com, linux-nfs@vger.kernel.org,
 lilingfeng3@huawei.com
Date: Mon, 21 Jul 2025 19:07:59 -0400
In-Reply-To: <f08bb3e3-3b02-4d00-a787-34b5fc30da1b@sirena.org.uk>
References: <20250628213107.2765337-1-zhangjian496@huawei.com>
	 <f08bb3e3-3b02-4d00-a787-34b5fc30da1b@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 23:16 +0100, Mark Brown wrote:
> On Sun, Jun 29, 2025 at 05:31:07AM +0800, zhangjian wrote:
> > Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the
> > memory
> > of server_fh is not passed from user space. So I add a check for
> > input size.
> >=20
> > Log is snipped as following:
>=20
> We've been seeing failures in -next on LTP on a range of arm64
> systems
> with NFS roots in the name_to_handle_at01, open_by_handle_at01 and
> open_by_handle_at02 tests.=C2=A0 I bisected the first of these to this
> patch
> which is in -next as e29be1f394a3dbadc4e and does look rather
> plausible.
>=20
> Test log:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25455 19:32:08.444643=C2=A0 tst_tmpd=
ir.c:316: TINFO: Using /ltp-
> tmp/ltp-hYUZKTq9fM/LTP_namNHNk6a as tmpdir (nfs filesystem)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25456 19:32:08.456042=C2=A0 ts=
t_test.c:1900: TINFO: LTP version:
> 20250130-1-g60fe84aaf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25457 19:32:08.467435=C2=A0 ts=
t_test.c:1904: TINFO: Tested kernel:
> 6.16.0-rc6-next-20250716 #1 SMP PREEMPT Wed Jul 16 13:20:00 UTC 2025
> aarch64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25458 19:32:08.467734=C2=A0 ts=
t_kconfig.c:88: TINFO: Parsing
> kernel config '/proc/config.gz'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25459 19:32:08.478825=C2=A0 ts=
t_test.c:1722: TINFO: Overall
> timeout per run is 0h 01m 30s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25460 19:32:08.479124=C2=A0 ts=
t_buffers.c:57: TINFO: Test is using
> guarded buffers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25461 19:32:08.490212=C2=A0 na=
me_to_handle_at01.c:94: TFAIL:
> open_by_handle_at() failed (0): ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25464 19:32:08.501869=C2=A0 na=
me_to_handle_at01.c:94: TFAIL:
> open_by_handle_at() failed (3): ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25465 19:32:08.512847=C2=A0 na=
me_to_handle_at01.c:94: TFAIL:
> open_by_handle_at() failed
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25489 19:32:08.672266=C2=A0 Su=
mmary:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25490 19:32:08.672558=C2=A0 pa=
ssed=C2=A0=C2=A0 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25491 19:32:08.672788=C2=A0 fa=
iled=C2=A0=C2=A0 27
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26185 19:33:10.208358=C2=A0 ts=
t_tmpdir.c:316: TINFO: Using /ltp-
> tmp/ltp-hYUZKTq9fM/LTP_opeiSM8q7 as tmpdir (nfs filesystem)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26188 19:33:10.231165=C2=A0 ts=
t_kconfig.c:88: TINFO: Parsing
> kernel config '/proc/config.gz'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26189 19:33:10.231460=C2=A0 ts=
t_test.c:1722: TINFO: Overall
> timeout per run is 0h 01m 30s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26190 19:33:10.242485=C2=A0 ts=
t_buffers.c:57: TINFO: Test is using
> guarded buffers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26191 19:33:10.253938=C2=A0 op=
en_by_handle_at02.c:98: TPASS:
> invalid-dfd: open_by_handle_at() failed as expected: EBADF (9)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26192 19:33:10.254233=C2=A0 op=
en_by_handle_at02.c:98: TPASS:
> stale-dfd: open_by_handle_at() failed as expected: ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26196 19:33:10.288302=C2=A0 ts=
t_capability.c:29: TINFO: Dropping
> CAP_DAC_READ_SEARCH(2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26197 19:33:10.299325=C2=A0 ts=
t_capability.c:41: TINFO: Permitting
> CAP_DAC_READ_SEARCH(2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26198 19:33:10.310836=C2=A0 op=
en_by_handle_at02.c:98: TPASS: no-
> capability: open_by_handle_at() failed as expected: EPERM (1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26199 19:33:10.311132=C2=A0 op=
en_by_handle_at02.c:92: TFAIL:
> symlink: open_by_handle_at() should fail with ELOOP: ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26201 19:33:10.311579=C2=A0 Su=
mmary:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26202 19:33:10.311782=C2=A0 pa=
ssed=C2=A0=C2=A0 6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26203 19:33:10.322143=C2=A0 fa=
iled=C2=A0=C2=A0 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26163 19:33:10.106087=C2=A0 ts=
t_tmpdir.c:316: TINFO: Using /ltp-
> tmp/ltp-hYUZKTq9fM/LTP_opeJvSZuG as tmpdir (nfs filesystem)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26166 19:33:10.117795=C2=A0 ts=
t_kconfig.c:88: TINFO: Parsing
> kernel config '/proc/config.gz'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26167 19:33:10.128809=C2=A0 ts=
t_test.c:1722: TINFO: Overall
> timeout per run is 0h 01m 30s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26168 19:33:10.129102=C2=A0 ts=
t_buffers.c:57: TINFO: Test is using
> guarded buffers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26169 19:33:10.140117=C2=A0 op=
en_by_handle_at01.c:93: TFAIL:
> open_by_handle_at() failed (0): ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26170 19:33:10.151537=C2=A0 op=
en_by_handle_at01.c:93: TFAIL:
> open_by_handle_at() failed (1): ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26177 19:33:10.197165=C2=A0 op=
en_by_handle_at01.c:93: TFAIL:
> open_by_handle_at() failed (8): ESTALE (116)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26179 19:33:10.197714=C2=A0 Su=
mmary:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26180 19:33:10.197929=C2=A0 pa=
ssed=C2=A0=C2=A0 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26181 19:33:10.198134=C2=A0 fa=
iled=C2=A0=C2=A0 9
>=20
> Bisect log:
>=20
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [97987520025658f30bb787a99ffbd9bbff9ffc9d] Add linux-next
> specific files for 20250721
> git bisect bad 97987520025658f30bb787a99ffbd9bbff9ffc9d
> # status: waiting for good commit(s), bad commit known
> # good: [922467c8223bfa20435da8c9b1c99285aac735ff] Merge branch 'for-
> linux-next-fixes' of
> https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect good 922467c8223bfa20435da8c9b1c99285aac735ff
> # bad: [73d0e6df78d50bd07d097a76eddc99cd89864d09] Merge branch 'main'
> of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad 73d0e6df78d50bd07d097a76eddc99cd89864d09
> # bad: [4ff8b17af7757fd16152eb8262c599129c8f5498] Merge branch 'fs-
> next' of linux-next
> git bisect bad 4ff8b17af7757fd16152eb8262c599129c8f5498
> # good: [13c60604ff678ac477521d9846fc2f75f0972e4b] Merge branch 'for-
> next' of https://github.com/sophgo/linux.git
> git bisect good 13c60604ff678ac477521d9846fc2f75f0972e4b
> # bad: [dce9a77d74cf572c1348d9d47cd79e7b61580f56] Merge branch 'for-
> next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
> git bisect bad dce9a77d74cf572c1348d9d47cd79e7b61580f56
> # good: [11581c89066a19d050d12b002609ade30bb39ece] Merge branch 'for-
> next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
> git bisect good 11581c89066a19d050d12b002609ade30bb39ece
> # good: [1d4e5eefd114eeb35449a8bcbbaa968baaa591e3] Merge branch 'dev'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
> git bisect good 1d4e5eefd114eeb35449a8bcbbaa968baaa591e3
> # bad: [38a098af636b698e5e14978de4accdc8a5173e24] Merge branch
> 'linux-next' of git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
> git bisect bad 38a098af636b698e5e14978de4accdc8a5173e24
> # good: [bce0d4cf481614eb1f0817a233d9479d609bd0a8] Merge branch
> 'ksmbd-for-next' of https://github.com/smfrench/smb3-kernel.git
> git bisect good bce0d4cf481614eb1f0817a233d9479d609bd0a8
> # good: [90c9550a8d65fb9b1bf87baf97a04ed91bf61b33] NFS: support the
> kernel keyring for TLS
> git bisect good 90c9550a8d65fb9b1bf87baf97a04ed91bf61b33
> # good: [d897d81671bc4615c80f4f3bd5e6b218f59df50c] pNFS: Handle RPC
> size limit for layoutcommits
> git bisect good d897d81671bc4615c80f4f3bd5e6b218f59df50c
> # bad: [e29be1f394a3dbadc4e5d198dfc822d49569bb52] nfs:check for user
> input filehandle size
> git bisect bad e29be1f394a3dbadc4e5d198dfc822d49569bb52
> # good: [7db6e66663681abda54f81d5916db3a3b8b1a13d] pNFS: Fix disk
> addr range check in block/scsi layout
> git bisect good 7db6e66663681abda54f81d5916db3a3b8b1a13d
> # first bad commit: [e29be1f394a3dbadc4e5d198dfc822d49569bb52]
> nfs:check for user input filehandle size

Thanks for the heads-up Mark! I'll back this patch out for now.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

