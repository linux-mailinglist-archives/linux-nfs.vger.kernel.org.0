Return-Path: <linux-nfs+bounces-12082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3CACCE95
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384507A5F83
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF31F12F4;
	Tue,  3 Jun 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF8Q8N9V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD61E5B62
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984619; cv=none; b=gAyTNf8anRbQvqWheGiSchCSmlJlp8QpZlZ4XztHcvosjtX1IVLr9IX/Q1XqgJ35/OBjZyhFUFSgQ1ncOaaziWcS+Md9WYSZrT+N1cVPjBhVqBdQe8+nOPxwXSlup/Exh1A12RCqttYSFjdzVTFBtDTGbzC4ML4lIwo1juOqyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984619; c=relaxed/simple;
	bh=yFqftGmdsD1PDYbYe01PETkpGsqspVkqAqhZhJ4uRME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxTJpt8ZehQLlMOuu0C4hKvOe+btKUpO0s9wLBh10I85Q4FScol5Sp0dzBMqUKXBKfjFFDFxTyR7PRSxgVIuSYGwG2oJRJaZ+dFocgWaQd99V9t/RCzzMgPgwFlkpBIidMhNXzHtunvlz0sKYDgJ65slsQgzT4W4ayNb0ClScnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF8Q8N9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D1C4CEF1;
	Tue,  3 Jun 2025 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748984619;
	bh=yFqftGmdsD1PDYbYe01PETkpGsqspVkqAqhZhJ4uRME=;
	h=From:To:Cc:Subject:Date:From;
	b=LF8Q8N9VLpQVyA3965tNcTVk8avV1FLqMpKhdaZHVCzIL+trUbQbA/iLFaMvkx81y
	 zYSAIwMbN1uDBKLreBPqzoT1dLWqMwNyu9eRqwj5Ld37fimHhfpq39kVMcNpqootAP
	 VSWO688uVlys+DESIZWvMAoVonluYcHG5TUlxaY8Z/hKwsvFIGX10nxbt+UTRDMJ5H
	 qqf/0o1MhLz9F/pCPCqVALG+zBuAf6MzeA8BWuS0SBYacfYCjRPUsGzqBQ0GUTHMBv
	 vXSQVNGNYcLt1+QjdKKOyMcxUO5NlSpIfPmgh0cLOVyGsIm0EG6dhzCB0P7xs4HZg7
	 U7qAL6oyYExWA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client Updates for Linux 6.16
Date: Tue,  3 Jun 2025 17:03:37 -0400
Message-ID: <20250603210337.584100-1-anna@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-1

for you to fetch changes up to e3e3775392f3f0f3e3044f8c162bf47858e01759:

  flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes (2025-05-28 17:17:14 -0400)

----------------------------------------------------------------
NFS Clent Updates for Linux 6.16

New Features:
  * Implement the Sunrpc rfc2203 rpcsec_gss sequence number cache
  * Add support for FALLOC_FL_ZERO_RANGE on NFS v4.2
  * Add a localio sysfs attribute

Stable Fixes:
  * Fix double-unlock bug in nfs_return_empty_folio()
  * Don't check for OPEN feature support in v4.1
  * Always probe for LOCALIO support asynchronously
  * Prevent hang on NFS mounts with xprtsec=[m]tls

Other Bugfixes:
  * xattr handlers should check for absent nfs filehandles
  * Fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
  * Fix listxattr to return selinux security labels
  * Connect to NFSv3 DS using TLS if MDS connection uses TLS
  * Clear SB_RDONLY before getting a superblock, and ignore when remounting
  * Fix incorrect handling of NFS error codes in nfs4_do_mkdir()
  * Various nfs_localio fixes from Neil Brown that include fixing an
      rcu compilation error found by older gcc versions.
  * Update stats on flexfiles pNFS DSes when receiving NFS4ERR_DELAY

Cleanups:
  * Add a refcount tracker for struct net in the nfs_client
  * Allow FREE_STATEID to clean up delegations
  * Always set NLINK even if the server doesn't support it
  * Cleanups to the NFS folio writeback code
  * Remove dead code from xs_tcp_tls_setup_socket()

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      NFS: Add support for fallocate(FALLOC_FL_ZERO_RANGE)

Benjamin Coddington (1):
      NFSv4: Allow FREE_STATEID to clean up delegations

Christoph Hellwig (4):
      nfs: fold nfs_page_async_flush into nfs_do_writepage
      nfs: don't return AOP_WRITEPAGE_ACTIVATE from nfs_do_writepage
      nfs: refactor nfs_do_writepage
      nfs: use writeback_iter directly

Chuck Lever (2):
      SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
      SUNRPC: Remove dead code from xs_tcp_tls_setup_socket()

Han Young (1):
      NFSv4: Always set NLINK even if the server doesn't support it

Jeff Layton (1):
      nfs: add a refcount tracker for struct net as held by the nfs_client

Li Lingfeng (2):
      nfs: clear SB_RDONLY before getting superblock
      nfs: ignore SB_RDONLY when remounting nfs

Max Kellermann (1):
      fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()

Mike Snitzer (3):
      NFS: add localio to sysfs
      pnfs/flexfiles: connect to NFSv3 DS using TLS if MDS connection uses TLS
      NFS: always probe for LOCALIO support asynchronously

NeilBrown (7):
      nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()
      nfs_localio: use cmpxchg() to install new nfs_file_localio
      nfs_localio: always hold nfsd net ref with nfsd_file ref
      nfs_localio: simplify interface to nfsd for getting nfsd_file
      nfs_localio: duplicate nfs_close_local_fh()
      nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()
      nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer

Nikhil Jha (2):
      sunrpc: implement rfc2203 rpcsec_gss seqnum cache
      sunrpc: don't immediately retransmit on seqno miss

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Sagi Grimberg (1):
      NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated

Scott Mayhew (2):
      NFSv4: xattr handlers should check for absent nfs filehandles
      NFSv4: Don't check for OPEN feature support in v4.1

Tigran Mkrtchyan (1):
      flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes

 fs/nfs/client.c                           |  6 +-
 fs/nfs/delegation.c                       | 25 +++++---
 fs/nfs/flexfilelayout/flexfilelayout.c    |  2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  2 +-
 fs/nfs/inode.c                            | 51 ++++++++++++++--
 fs/nfs/internal.h                         |  1 -
 fs/nfs/localio.c                          | 51 ++++++----------
 fs/nfs/nfs42.h                            |  1 +
 fs/nfs/nfs42proc.c                        | 29 ++++++++-
 fs/nfs/nfs42xdr.c                         | 64 ++++++++++++++++++++
 fs/nfs/nfs4_fs.h                          |  3 +-
 fs/nfs/nfs4file.c                         | 10 +++-
 fs/nfs/nfs4proc.c                         | 75 +++++++++++++++--------
 fs/nfs/nfs4xdr.c                          |  1 +
 fs/nfs/pnfs_nfs.c                         | 11 +++-
 fs/nfs/read.c                             |  3 +-
 fs/nfs/super.c                            | 19 ++++++
 fs/nfs/sysfs.c                            | 28 +++++++++
 fs/nfs/write.c                            | 54 ++++++-----------
 fs/nfs_common/nfslocalio.c                | 99 ++++++++++++++++++++-----------
 fs/nfsd/filecache.c                       | 32 +++++++++-
 fs/nfsd/filecache.h                       |  3 +-
 fs/nfsd/localio.c                         | 70 ++++++++++++++++------
 include/linux/nfs4.h                      |  2 +
 include/linux/nfs_fs_sb.h                 |  2 +
 include/linux/nfslocalio.h                | 26 ++++----
 include/linux/sunrpc/xprt.h               | 17 +++++-
 include/trace/events/rpcgss.h             |  4 +-
 include/trace/events/sunrpc.h             |  2 +-
 net/sunrpc/auth_gss/auth_gss.c            | 59 +++++++++++-------
 net/sunrpc/clnt.c                         |  9 ++-
 net/sunrpc/xprt.c                         |  3 +-
 net/sunrpc/xprtsock.c                     | 16 ++---
 33 files changed, 554 insertions(+), 226 deletions(-)

