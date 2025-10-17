Return-Path: <linux-nfs+bounces-15342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD444BEBB72
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F254E2784
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37472417DE;
	Fri, 17 Oct 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbk+trlJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E21DE89A
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733868; cv=none; b=LYoroyVT/gymvEwpprdVCRiqBXqadEG5RHfwjg8ITQg/5yKKZH//dwa8ok3zEkM3mY6FYpzirDNUuStW/ycsGYWVY8vZdh1zUpBI7oDNo/cPjrOnjrb4i3yWkSC3DwCGK6VPRLtokrUpOVyBMMbDGOmI+SXYPBiU/qPGS61ZG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733868; c=relaxed/simple;
	bh=9wgrLby4tAzkE4Rxorg7kGIMJv6LjLCmABpV2dYaDwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpTqWF9yrKhxAzuTjpaMQ9F+QwlvrNkO483KUHkGnJc25UBT7yoaMfnznBqeNk6qcVNm2fE7G2qjj1uHPAhRS4VW3luUTDNRp9/I/b3mLly04TdM8ISioDEbuAuN7XpsD8c6L9BUIzGN2qwN+PUxozJhpGblpeLhQ2fSiyCehp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbk+trlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E31C4CEE7;
	Fri, 17 Oct 2025 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760733868;
	bh=9wgrLby4tAzkE4Rxorg7kGIMJv6LjLCmABpV2dYaDwA=;
	h=From:To:Cc:Subject:Date:From;
	b=Bbk+trlJb2wCLRwKc4xOudTNYLjPiimbYQjg+E7+r03o61YprgXIfQdQaC8LYhgGK
	 8TeLk449pet7xf/atJExa+9JxdrKe2oJkJf78k0dHokKBTVXMkUMWb6iMn0z0zuxW+
	 CnToPEerkayOk4hOErO7NrUuKYI3Pzpr7pWZVQeJM/525DDBfER6aLd4OvJ852nGrE
	 XVTDD6WgAa0o4D4PUwOdxkdMB0GbJupC3BdqGS5hN9ObQ5GR0TiOubXD3W8SLrW2Fc
	 YcbtTvr7BlWY09yXFKsugKnovNrT7Kst9Pv0sUX+dCbmypD+36WvAz8dQRqWeT3F7/
	 hbx8RIj4GMiwg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.18-rc
Date: Fri, 17 Oct 2025 16:44:26 -0400
Message-ID: <20251017204426.355167-1-anna@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-2

for you to fetch changes up to 9bb3baa9d1604cd20f49ae7dac9306b4037a0e7a:

  NFS4: Fix state renewals missing after boot (2025-10-13 14:33:00 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.18-rc

Bugfixes:
 * Fix for FlexFiles mirror->dss allocation
 * Apply delay_retrans to async operations
 * Check if suid/sgid is cleared after a write when needed
 * Fix setting the state renewal timer for early mounts after a reboot

Thanks,
Anna

----------------------------------------------------------------
Joshua Watt (2):
      NFS4: Apply delay_retrans to async operations
      NFS4: Fix state renewals missing after boot

Mike Snitzer (1):
      NFSv4/flexfiles: fix to allocate mirror->dss before use

Scott Mayhew (1):
      NFS: check if suid/sgid was cleared after a write as needed

 fs/nfs/flexfilelayout/flexfilelayout.c | 35 ++++++++++++++++++++--------------
 fs/nfs/nfs4client.c                    |  1 +
 fs/nfs/nfs4proc.c                      | 13 +++++++++++++
 fs/nfs/write.c                         |  3 ++-
 include/linux/nfs_xdr.h                |  1 +
 5 files changed, 38 insertions(+), 15 deletions(-)

