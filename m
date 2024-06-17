Return-Path: <linux-nfs+bounces-3860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033BE90A1B1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192371C20D82
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9719468E;
	Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+s9rl+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E233E7
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587510; cv=none; b=VNUKFx9w+HPoX5pjwoT8hvz+qMWY6sD9U4BuLFD8kOZHSNQ/45gzesvMgRxwpb6XOe6Zi84usxfjU5gjzTXN8u0SYz1U1SFoPB/MwfgRLCuuGyzUYRW5hvcjO7ze4y6SVByM61a7JugBbOXRbpOa5L1d9f8GqwboqG6QtYa0+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587510; c=relaxed/simple;
	bh=EvNQtMdJaMMHPFFjdG0pNphrouB80bY49YOiwanq22c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pw4QPrtvYMi0Bu9BKhT3jkgUal2nAnoLoN3PbHdbgj+sAanhWvf8z+Wz2xYLekgsRBOoNfTqFebatTToMFthwXwZY2RK9x+T9Alc7f9Pvo2/tf/QZSanJhfYb9gAf+jMAGc7+UAav+uZHeMlQACiWeHy7Z/iSiGx+j0Zx4wROAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+s9rl+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E0DC2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587509;
	bh=EvNQtMdJaMMHPFFjdG0pNphrouB80bY49YOiwanq22c=;
	h=From:To:Subject:Date:From;
	b=R+s9rl+vMUehuDHyw2KOLJi7/l+HTvYEeN9VdvdppcBjnJwJorEqeOnQKYHrUxEM+
	 SkiFuvlFciqMcSof6/yvOR4bOL4qSDNNx08+Wqq3e5CK/PTydsRi4uYLbB0ex3CZVA
	 EVgx3/FSrz6Gr/1tOHXH6qzj+1KKeFdB0kdMUlmQI197DHAJcJE5KPrcFlyRSzh388
	 FmumCL65hL0IQATyZwUqKXX/BugCGg5bDnRUhiAAKs3TJ8BHdufunl8f2YJlFCoy+W
	 0o85aBSDUYrSTrTIM6TwNRSbXskDzTktutnBPglLkr+2YaWIELbJa1VVqXZgupRpk7
	 VKLkfLS8Jx7qg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/19] OPEN optimisations and Attribute delegations
Date: Sun, 16 Jun 2024 21:21:18 -0400
Message-ID: <20240617012137.674046-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/ is
mostly done with the review process, it is time to look at pushing the
client implementation that we've been working on upstream.

The following patch series therefore adds support for the NFSv4.2
extension to OP_OPEN to allow the client to request that the server
return either an open stateid or a delegation instead of always sending
the open stateid whether or not a delegation is returned.
This allows us to optimise away CLOSE, and hence makes small or cached
file access significantly more efficient.

It also adds support for attribute delegations, which allow the client
to manage the atime and mtime, and simply inform the server at file
close time what the values should be. This means that most GETATTR
operations to retrieve the atime/mtime values while the file is under
I/O can be optimised away.

Finally, we also add support for the detection mechanism that allows the
client to determine whether or not the server supports the above
functionality.

v2:
 - Fix issues when compiling without CONFIG_NFS_V4
 - Update "NFSv4: Fix up delegated attributes in nfs_setattr" to fix
   regressions pointed out by Anna Schumaker
 - Squash commits "NFSv4: Ask for a delegation or an open stateid in
   OPEN" and "Return the delegation when deleting the sillyrenamed file"
   as suggested by Jeff Layton
 - Add "NFSv4: Don't send delegation-related share access modes to
   CLOSE"

Lance Shelton (1):
  Return the delegation when deleting sillyrenamed files

Trond Myklebust (18):
  NFSv4: Clean up open delegation return structure
  NFSv4: Refactor nfs4_opendata_check_deleg()
  NFSv4: Add new attribute delegation definitions
  NFSv4: Plumb in XDR support for the new delegation-only setattr op
  NFSv4: Add CB_GETATTR support for delegated attributes
  NFSv4: Add a flags argument to the 'have_delegation' callback
  NFSv4: Add support for delegated atime and mtime attributes
  NFSv4: Add recovery of attribute delegations
  NFSv4: Add a capability for delegated attributes
  NFSv4: Enable attribute delegations
  NFSv4: Delegreturn must set m/atime when they are delegated
  NFSv4: Fix up delegated attributes in nfs_setattr
  NFSv4: Don't request atime/mtime/size if they are delegated to us
  NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
  NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
  NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
  NFSv4: Ask for a delegation or an open stateid in OPEN
  NFSv4: Don't send delegation-related share access modes to CLOSE

 fs/nfs/callback.h         |   5 +-
 fs/nfs/callback_proc.c    |  14 ++-
 fs/nfs/callback_xdr.c     |  39 +++++-
 fs/nfs/delegation.c       |  67 ++++++----
 fs/nfs/delegation.h       |  45 ++++++-
 fs/nfs/dir.c              |   2 +-
 fs/nfs/file.c             |   4 +-
 fs/nfs/inode.c            |  86 +++++++++++--
 fs/nfs/nfs3proc.c         |  10 +-
 fs/nfs/nfs4proc.c         | 248 ++++++++++++++++++++++++++++----------
 fs/nfs/nfs4xdr.c          | 131 +++++++++++++++-----
 fs/nfs/proc.c             |  10 +-
 fs/nfs/read.c             |   3 +
 fs/nfs/unlink.c           |   2 +
 fs/nfs/write.c            |  11 +-
 include/linux/nfs4.h      |  11 ++
 include/linux/nfs_fs_sb.h |   2 +
 include/linux/nfs_xdr.h   |  45 ++++++-
 include/uapi/linux/nfs4.h |   4 +
 19 files changed, 589 insertions(+), 150 deletions(-)

-- 
2.45.2


