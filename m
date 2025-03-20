Return-Path: <linux-nfs+bounces-10729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B87A6AF45
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163668A683D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0057E212FB3;
	Thu, 20 Mar 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/+M+vjt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F11DDA39
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503223; cv=none; b=p/5TVxyEQUJ00WUlQ1jKlz0wPGEptQD4MOkXwptZEpeqciLxLm3i2FkqGJxIx7xf8FESC/ymwpmoiKWe4Th97nhCpvXM0J8gIGYnRATFoikxMxrnfgENRcJdzXpvrWubHUX06gM4Wmyhs+GQi8PKwbkEKBB7FTXLKVNtCeFUR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503223; c=relaxed/simple;
	bh=bI3RcUmczgi2480i+3FfaS8ThEHQBESt5u1yfY6Gly0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFAz3qLXNxatqinm4BasPoVZ0e+GuGLLZkvYRN0r5LENjz5Uoed991TG7KJ5ajBOg+I7mvXeHLyz1t40zb6szhR426corWBVOdU+LvvppCMu/udVk13LvjlMqClrQzr68Tx5wnD71bR/e4Idj5H1aNm1wks9EGdTl7RqEhzEIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/+M+vjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122CCC4CEDD;
	Thu, 20 Mar 2025 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503223;
	bh=bI3RcUmczgi2480i+3FfaS8ThEHQBESt5u1yfY6Gly0=;
	h=From:To:Cc:Subject:Date:From;
	b=M/+M+vjtsreNkyyexgtqtGrfxDIZ0wtNdBKlcJAfCoPz/A34yXaqPnktaMyAvNrfg
	 Vb9t3Sbz+E4RjQGpGNSulXMxANLZiw3dlxDTEZLJi/XdZUlCUGwyiwXHirHgeRNHSl
	 cGNNiBvozKdHGpt7OyBtZbjAF+4mjKRCfRKlxQXGCdoiyTumYGU5YJr3DsRQ8mOovI
	 gjpgj9gfDOw8njuOjlXJDHjvfnRaBu41MNJ9VSxcP5HH/T7jLv4J3rbZPVSheS65OD
	 J2UiePnGpBepasInd7b5mdwKDTNf9kqxz9cgVxJ7hqIVUuIBYLdRI0qjiYOh5Y8984
	 psVLst8D/mxRw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 0/4] Containerised NFS clients and teardown
Date: Thu, 20 Mar 2025 16:40:17 -0400
Message-ID: <cover.1742502819.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When a NFS client is started from inside a container, it is often not
possible to ensure a safe shutdown and flush of the data before the
container orchestrator steps in to tear down the network. Typically,
what can happen is that the orchestrator triggers a lazy umount of the
mounted filesystems, then proceeds to delete virtual network device
links, bridges, NAT configurations, etc.

Once that happens, it may be impossible to reach into the container to
perform any further shutdown actions on the NFS client.

This patchset proposes to allow the client to deal with these situations
by treating the two errors ENETDOWN  and ENETUNREACH as being fatal.
The intention is to then allow the I/O queue to drain, and any remaining
RPC calls to error out, so that the lazy umounts can complete the
shutdown process.

In order to do so, a new mount option "fatal_errors" is introduced,
which can take the values "default", "none" and "enetdown:enetunreach".
The value "none" forces the existing behaviour, whereby hard mounts are
unaffected by the ENETDOWN and ENETUNREACH errors.
The value "enetdown:enetunreach" forces ENETDOWN and ENETUNREACH errors
to always be fatal.
If the user does not specify the "fatal_errors" option, or uses the
value "default", then ENETDOWN and ENETUNREACH will be fatal if the
mount was started from inside a network namespace that is not
"init_net", and otherwise not.

The expectation is that users will normally not need to set this option,
unless they are running inside a container, and want to prevent ENETDOWN
and ENETUNREACH from being fatal by setting "-ofatal_errors=none".

---
v2:
- Fix NFSv4 client cl_flag initialisation
- Add RPC task flag trace decoding

Trond Myklebust (4):
  NFS: Add a mount option to make ENETUNREACH errors fatal
  NFS: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Report ENETDOWN as a connection error

 fs/nfs/client.c                        |  5 ++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 24 ++++++++++++++--
 fs/nfs/fs_context.c                    | 38 ++++++++++++++++++++++++++
 fs/nfs/nfs3client.c                    |  2 ++
 fs/nfs/nfs4client.c                    |  7 +++++
 fs/nfs/nfs4proc.c                      |  3 ++
 fs/nfs/super.c                         |  2 ++
 include/linux/nfs4.h                   |  1 +
 include/linux/nfs_fs_sb.h              |  2 ++
 include/linux/sunrpc/clnt.h            |  5 +++-
 include/linux/sunrpc/sched.h           |  1 +
 include/trace/events/sunrpc.h          |  1 +
 net/sunrpc/clnt.c                      | 30 ++++++++++++++------
 13 files changed, 110 insertions(+), 11 deletions(-)

-- 
2.48.1


