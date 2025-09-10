Return-Path: <linux-nfs+bounces-14250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ADAB52048
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1879F189B996
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DED2C15BA;
	Wed, 10 Sep 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSvRxbgt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E52BE63D;
	Wed, 10 Sep 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529297; cv=none; b=KgM4hFR6MQeBo0goRGO6GDhKfH2XVSt9nLZZ1MrzR/NkyvqFNaUhWOiJDw8zYbfezaG+pLy6TakChmi4ZVSCnEE/lQ+DlnCGT+r9IKmbmyh+TciIuhQAfEnaHGpkRIyAYLnb72nt2Vm2YJtMl5w9kYRnVRsdOqsOOxnCjAt8208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529297; c=relaxed/simple;
	bh=0P2NpjVBdNQMm+6O4M+C2QisLkYCsgHJydijWOfPe+I=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=O0bMhIsLjDB5Oltsy4TKAZn7jgZGQMj1W708y90IM7r0oSXQhH+6rIhhlILE/x21YoBKAYAdNCvSA+EKnjVWZ9puJ33bdfpHoygPMDTCQCendlvc49xdEdUm02zV8jXbwXvdH6k63midyL805GwK49WuxK3XTNichf9bxZHRXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSvRxbgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7CDC4CEEB;
	Wed, 10 Sep 2025 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757529297;
	bh=0P2NpjVBdNQMm+6O4M+C2QisLkYCsgHJydijWOfPe+I=;
	h=Subject:From:To:Cc:Date:From;
	b=cSvRxbgtXKVz672O2yuyqrEJIythunuF2MoILP9DxzT61HQ7Lng0Rd7ILLYGfBA3E
	 9Im7i2cjiLY+YWkex2ypVWEA5bpGdbMLPi1JgORyJKuzRSenv3lUkrI1OGqUF9yH1z
	 ay5WyqMnDWLE39uNvLVxB/QshruNZrxaBJPYvtSl9L75hQeySbUNlmPQWsp/CNQmkT
	 5inMFjhRaiZzNgrAE0zy9Bpz/GCeJQ8uKjg6MBCy5quFruuye4nHD1YXXJOC0gGCKL
	 nfL+GsYyObPnyTDBbWpgxGERVtG7PZItMNkWhs897zb10SasHfXbZhSBORDb90Ewpr
	 e9Dg6OASyjJfg==
Message-ID: <150cb132accb448dd29e30af08394548b26524d5.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 6.17
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Wed, 10 Sep 2025 14:34:55 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linus,

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00=
:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-=
3

for you to fetch changes up to dd2fa82473453661d12723c46c9f43d9876a7efd:

  NFSv4/flexfiles: Fix layout merge mirror check. (2025-09-08 14:37:55 -040=
0)

Thanks,
  Trond

----------------------------------------------------------------
NFS client bugfixes for Linux 6.17

Stable patches:
 - Revert "SUNRPC: Don't allow waiting for exiting tasks" as it is
   breaking ltp tests.

Bugfixes:
 - Another set of fixes to the tracking of NFSv4 server capabilities
   when crossing filesystem boundaries.
 - Localio fix to restore credentials and prevent triggering a BUG_ON().
 - Fix to prevent flapping of the localio on/off trigger.
 - Protections against 'eof page pollution' as demonstrated in xfstests
   generic/363.
 - Series of patches to ensure correct ordering of O_DIRECT i/o and
   truncate, fallocate and copy functions.
 - Fix a NULL pointer check in flexfiles reads that regresses 6.17.
 - Correct a typo that breaks flexfiles layout segment processing.

----------------------------------------------------------------
Jonathan Curley (1):
      NFSv4/flexfiles: Fix layout merge mirror check.

Justin Worrell (1):
      SUNRPC: call xs_sock_process_cmsg for all cmsg

Mike Snitzer (1):
      nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()

Scott Mayhew (1):
      nfs/localio: restore creds before releasing pageio data

Tigran Mkrtchyan (1):
      flexfiles/pNFS: fix NULL checks on result of ff_layout_choose_ds_for_=
read

Trond Myklebust (13):
      NFSv4: Don't clear capabilities that won't be reset
      NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
      NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
      NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
      NFS: Protect against 'eof page pollution'
      NFSv4.2: Protect copy offload and clone against 'eof page pollution'
      NFS: Serialise O_DIRECT i/o and truncate()
      NFSv4.2: Serialise O_DIRECT i/o and fallocate()
      NFSv4.2: Serialise O_DIRECT i/o and clone range
      NFSv4.2: Serialise O_DIRECT i/o and copy range
      NFS: nfs_invalidate_folio() must observe the offset and size argument=
s
      NFS: Fix the marking of the folio as up to date
      Revert "SUNRPC: Don't allow waiting for exiting tasks"

 fs/nfs/client.c                        |  2 ++
 fs/nfs/file.c                          | 40 +++++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.c | 21 +++++++++-----
 fs/nfs/inode.c                         | 13 +++++++--
 fs/nfs/internal.h                      | 12 ++++++++
 fs/nfs/io.c                            | 13 ++-------
 fs/nfs/localio.c                       | 21 +++++++-------
 fs/nfs/nfs42proc.c                     | 35 ++++++++++++++++------
 fs/nfs/nfs4file.c                      |  2 ++
 fs/nfs/nfs4proc.c                      |  7 +++--
 fs/nfs/nfstrace.h                      |  1 +
 fs/nfs/write.c                         | 53 ++++--------------------------=
----
 net/sunrpc/sched.c                     |  2 --
 net/sunrpc/xprtsock.c                  |  6 ++--
 14 files changed, 129 insertions(+), 99 deletions(-)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

