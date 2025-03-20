Return-Path: <linux-nfs+bounces-10721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF9A6AC51
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9940C188D797
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498B22576E;
	Thu, 20 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnpHAyTR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE932253A4
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492682; cv=none; b=YdqRVFTQxrlZHLw7mOVrINFN1Z92wpWh8tNLpeQzlF7RHrXgL0tas764Za7Zlcfxkm/0cLPZLNRNLCt4ZG8000dZzgFdeE8JGtFFtbpRQ7w5vhErRbIYeugGNUmHz2AyVoDICNd1wJN5bv0w0Zn1q1oAJybmkYdSBulpmscBsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492682; c=relaxed/simple;
	bh=n0tlSMcPC94ytxz6CUC5rK/IYdh4kQv8M9he2ygYvhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkiDHm9DZGso73ku8sHEtJb7mCE3Ohd4BsotVC0vmXni3jkq/7XkL1wQnmz3KK/0P1N1Zy9KZeLx0UiJhQmAlun4wKm1im9tSMOI24E188psR5n4vDQwGY9TTCcQ05QejElqr8o0bk2Mu8aDPrBbwnzigq0fVJVgCJRyUuAZSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnpHAyTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A74C4CEDD;
	Thu, 20 Mar 2025 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492682;
	bh=n0tlSMcPC94ytxz6CUC5rK/IYdh4kQv8M9he2ygYvhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DnpHAyTRXHYe0qW2ml30qJppnsFxgG+QUQmVUGA2tvtxtijBYX6LSJJFJsutBs4r7
	 mYugWX6QCtTwhgVpE6SEgSB1DWMvzP6PzjfIc15KOgvxNe5mm8Rg57szL0XDYZR6LI
	 hna6JT4tU+qFd93mNp4qwW9x2NeWklXPMUHRNd/wkGIRJxwX1xLapRvFRxQ3nlicds
	 lwkDnBpma6OMiziDDVWtkW7bh7MGlBB/Gl3emM+qWt77nJ9Sdr5PE5NbHvLst/nUZ6
	 KNDoKM2j74kM+MRI0+MufoK3vOiz/HD8e11FxYP+oolMUlXHdY4sVUp7qUaFARmaUF
	 mrx2YuyuLYzvg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 0/4] Containerised NFS clients and teardown
Date: Thu, 20 Mar 2025 13:44:36 -0400
Message-ID: <cover.1742490771.git.trond.myklebust@hammerspace.com>
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

Trond Myklebust (4):
  NFS: Add a mount option to make ENETUNREACH errors fatal
  NFS: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Treat ENETUNREACH errors as fatal in containers
  pNFS/flexfiles: Report ENETDOWN as a connection error

 fs/nfs/client.c                        |  5 ++++
 fs/nfs/flexfilelayout/flexfilelayout.c | 24 ++++++++++++++--
 fs/nfs/fs_context.c                    | 38 ++++++++++++++++++++++++++
 fs/nfs/nfs3client.c                    |  2 ++
 fs/nfs/nfs4client.c                    |  5 ++++
 fs/nfs/nfs4proc.c                      |  3 ++
 fs/nfs/super.c                         |  2 ++
 include/linux/nfs4.h                   |  1 +
 include/linux/nfs_fs_sb.h              |  2 ++
 include/linux/sunrpc/clnt.h            |  5 +++-
 include/linux/sunrpc/sched.h           |  1 +
 net/sunrpc/clnt.c                      | 30 ++++++++++++++------
 12 files changed, 107 insertions(+), 11 deletions(-)

-- 
2.48.1


