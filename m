Return-Path: <linux-nfs+bounces-16414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEBC5F559
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 22:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF5144E1D7B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDA352924;
	Fri, 14 Nov 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMTz6n4c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809534FF67
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155018; cv=none; b=SyQ3n6uZV7tdwirSdItdtJKXyQC60kpvFU7XwCxBT5igTXXne/ly54RP8nHV93PSDuBtvTD6d+DKGOU47VUqjGsGeZ/hxpJT4n+8yMEaorYne4ZYQG7gtBrs5d8SCpdUfrlJ/Se00FwiTqEUzEKrDWMyo2V/w2rMvs3qP+XV81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155018; c=relaxed/simple;
	bh=kmjrG17CC8ZYK9Jn8eGfKQ+nmjY81Rxrm2F9sRKEt2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bgy9AUwcn5wGk2es6iTrsSZ93x7ctfCVQIh7/gR5bkhIK7EALAboNW5Z80Ft4Mb9i4aoHXIp/YCzm4E2P6teJ3o3DPrXbgB0mmQIeLCeauDq2WLeSmfYAxJveSAeHWWfCr9Bdva1wXGzqTQksM/5uwZ9825kXOuvdstd6iDePPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMTz6n4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EBBC4CEF1;
	Fri, 14 Nov 2025 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763155018;
	bh=kmjrG17CC8ZYK9Jn8eGfKQ+nmjY81Rxrm2F9sRKEt2U=;
	h=From:To:Cc:Subject:Date:From;
	b=hMTz6n4cx5lvyKTQ0yM4Ur+iS6msNwOiqVrOnxZO5pVI3JH1OzwM/dER6McbR/I9b
	 qdxMPfxMu/ue7gp1eV75vg38RFoqaFTz8hUqmcKWK3S7u7em0KFvozqPA4uQqtYM62
	 9JKZ8l5ua8vqg7yHOOGi4tcVOViX0Hx1EjWUjJkuf8xcAChlPbp/u7JbY29akrKqQR
	 UteDTrP2B0qXwMgjzhcAJC000RG6gPblVtRX3JAHsii0WVv8jnVxvgZuYuixzjejxb
	 z6RHfLbjVbApTXmFuckUXD1ZpMrQJFO6S+PI71C1qL6f36OV2/VSSWj4ucy5meS1/2
	 /qm1x41OOXhCA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull More NFS Client Bugfixes for Linux 6.18-rc
Date: Fri, 14 Nov 2025 16:16:57 -0500
Message-ID: <20251114211657.521976-1-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-3

for you to fetch changes up to b623390045a81fc559decb9bfeb79319721d3dfb:

  NFS: Fix LTP test failures when timestamps are delegated (2025-11-10 16:55:12 -0500)

----------------------------------------------------------------
More NFS Client Bugfixes for Linux 6.18-rc

Bugfixes:
 * Various fixes when using NFS with TLS
 * Localio direct-IO fixes
 * Fix error handling in nfs_atomic_open_v23()
 * Fix sysfs memory leak when nfs_client kobject add fails
 * Fix an incorrect parameter when calling nfs4_call_sync()
 * Fix a failing LTP test when using delegated timestamps

Thanks,
Anna

----------------------------------------------------------------
Dai Ngo (1):
      NFS: Fix LTP test failures when timestamps are delegated

Mike Snitzer (5):
      nfs/localio: remove unecessary ENOTBLK handling in DIO WRITE support
      nfs/localio: add refcounting for each iocb IO associated with NFS pgio header
      nfs/localio: backfill missing partial read support for misaligned DIO
      nfs/localio: Ensure DIO WRITE's IO on stable storage upon completion
      nfs/localio: do not issue misaligned DIO out-of-order

Trond Myklebust (6):
      pnfs: Fix TLS logic in _nfs4_pnfs_v3_ds_connect()
      pnfs: Fix TLS logic in _nfs4_pnfs_v4_ds_connect()
      pnfs: Set transport security policy to RPC_XPRTSEC_NONE unless using TLS
      NFS: Check the TLS certificate fields in nfs_match_client()
      NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
      NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()

Yang Xiuwei (1):
      NFS: sysfs: fix leak when nfs_client kobject add fails

 fs/nfs/client.c     |   8 ++
 fs/nfs/dir.c        |   7 +-
 fs/nfs/inode.c      |  18 ++--
 fs/nfs/localio.c    | 233 +++++++++++++++++++++++++++-------------------------
 fs/nfs/nfs3client.c |  14 +++-
 fs/nfs/nfs4client.c |  14 +++-
 fs/nfs/nfs4proc.c   |   9 +-
 fs/nfs/pnfs_nfs.c   |  66 ++++++++-------
 fs/nfs/sysfs.c      |   1 +
 9 files changed, 213 insertions(+), 157 deletions(-)

