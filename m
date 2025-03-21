Return-Path: <linux-nfs+bounces-10745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA480A6BE3B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CCA170E55
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06021DDC11;
	Fri, 21 Mar 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU4NXzY8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E41D95A9
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570466; cv=none; b=dlCbJHoMsX1fimwjgy27iGpGBQxt0NRqgSMcoliwwvkTCJO87/VRvueQPqetkEgz7aftu6NeF3iYjMBPAF7tkGTdl5PVp1I1b4yZz8Qjs18jMoDtFzFrXcooRAztSp5GLD0CKY3IyxaXDM1WlZ14eqbBYkx47NHZ0S3ONyQX5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570466; c=relaxed/simple;
	bh=s8wofwSNOGA5PRhT+WHd0IkMu1ziHuIg4ppVZTa6I8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYSTz+cW3OJ9Ld+eFVYg0vOz/dFVarAlPiko36xuh7x1EY+pVCnx3bxh1FTdqYcisy2FGMrmQuHmwFuqGqzo2CeL+Rq2k31L9B6d7fsX0iJ1Vvu4/4GHR6E7DEZE+Qt3LrBcmAFmA7zHNaHU4QSBeRwR8rOP3BiqxAy9+2bI2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU4NXzY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC1C4CEE3;
	Fri, 21 Mar 2025 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742570466;
	bh=s8wofwSNOGA5PRhT+WHd0IkMu1ziHuIg4ppVZTa6I8M=;
	h=From:To:Cc:Subject:Date:From;
	b=LU4NXzY8+IMqlLzmjrvK1FeCOtPKRltzHK+r3ds4UbR6/3N3/vMvg8BuNkc9UPqDb
	 cAEN+0YTGW8HUIK86YLYvZzmiqUUtP3fW0Iwr8Mq0YBCRF82E/J8IQ4fwzTh1nRtl/
	 /7eZ0XezGalIx6+65jxkWVaEWq+ytcG7RIoSBZKtcTFk8P2fSfosKpXYIjyxPUesSq
	 ABdUx2KP3ZeDtM6pMMdksnaU5yS8M6CE6zjS/CTr7foCNTCCWrvK88eXQoXQL7QyFQ
	 bqblBimfjHvhwVWNwRxLFs9TyEl/sJO8WSbHuOm/cbcezA4AaVqpqiaV7e1tYcfM5a
	 aZk34vic9y9zg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 0/4] Containerised NFS clients and teardown
Date: Fri, 21 Mar 2025 11:21:00 -0400
Message-ID: <cover.1742570192.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
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

In order to do so, a new mount option "fatal_neterrors" is introduced,
which can take the values "default", "none" and "ENETDOWN:ENETUNREACH".
The value "none" forces the existing behaviour, whereby hard mounts are
unaffected by the ENETDOWN and ENETUNREACH errors.
The value "ENETDOWN:ENETUNREACH" forces ENETDOWN and ENETUNREACH errors
to always be fatal.
If the user does not specify the "fatal_neterrors" option, or uses the
value "default", then ENETDOWN and ENETUNREACH will be fatal if the
mount was started from inside a network namespace that is not
"init_net", and otherwise not.

The expectation is that users will normally not need to set this option,
unless they are running inside a container, and want to prevent ENETDOWN
and ENETUNREACH from being fatal by setting "-ofatal_neterrors=none".

---
v2:
- Fix NFSv4 client cl_flag initialisation
- Add RPC task flag trace decoding
v3:
- Fix a copy/paste error in nfs4_set_client() (Thanks, Jeff Layton!)
- Fix the mount option name to be "fatal_neterrors".
- Capitalise ENETDOWN and ENETUNREACH in the fatal_neterrors parameter
  list to make it more obvious this refers to the POSIX networking
  errors.
- Always display the "fatal_neterrors" setting in /proc/mounts

Trond Myklebust (4):
  NFS: Add a mount option to make ENETUNREACH errors fatal
  NFS: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Report ENETDOWN as a connection error

 fs/nfs/client.c                        |  5 ++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 24 ++++++++++++++--
 fs/nfs/fs_context.c                    | 39 ++++++++++++++++++++++++++
 fs/nfs/nfs3client.c                    |  2 ++
 fs/nfs/nfs4client.c                    |  7 +++++
 fs/nfs/nfs4proc.c                      |  3 ++
 fs/nfs/super.c                         |  3 ++
 include/linux/nfs4.h                   |  1 +
 include/linux/nfs_fs_sb.h              |  2 ++
 include/linux/sunrpc/clnt.h            |  5 +++-
 include/linux/sunrpc/sched.h           |  1 +
 include/trace/events/sunrpc.h          |  1 +
 net/sunrpc/clnt.c                      | 30 ++++++++++++++------
 13 files changed, 112 insertions(+), 11 deletions(-)

-- 
2.49.0


