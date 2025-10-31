Return-Path: <linux-nfs+bounces-15853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964AC25C04
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA224FB316
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF162D23A3;
	Fri, 31 Oct 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLc6ovpy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497652D193B
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922305; cv=none; b=exi7Qu5ZQOeNN/hrqfe9yKbSJGRwiy7BJ9xet9NAahtocGSsztH3JMrmfmYsTJv9a2DEfUKejuq+1FT9Rdo1Bk+qZMId35sU2g+4a90HZbD+myyy8nzenmhl7dDd8wL7M33i29CrRpQiHsINs4r/sylxfk7Fu5tbm0kDVMPYfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922305; c=relaxed/simple;
	bh=b06gnHFhhRUcOnnYqmWJGPstpWO0QYzGm5yYSBwTjaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSHxmL++V0NRJNRVOHb0nabF15vyYt9CmLOp0s4RAuxb0T31ar5o3QHXQTvgI0w7dMyDWva4ezDSliUx4nqSJH7UnnXN91kxL8dAInD7Nw8AdaBOTm5RvrLWDwUpj26BxKY5KblQq1xwfYXEAZqoeSEOVdLHHrxvsyRpEw6gStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLc6ovpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6653BC4CEE7;
	Fri, 31 Oct 2025 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761922304;
	bh=b06gnHFhhRUcOnnYqmWJGPstpWO0QYzGm5yYSBwTjaU=;
	h=From:To:Cc:Subject:Date:From;
	b=KLc6ovpylVwc3b1PQN7dFdjqGdQOK9kos3HLl4mJ1IQxeJKdmeZEjbLIAnjLhk31a
	 JTL6RY0ERShAjnyzaN0fUdRivw/eWCDPLXAtse7JEAe9inECLr2BpjIGehBlEU+7q4
	 NJUu2JlhrY3NQsUcds/+xhxjBHFzM7SKhyPEzRazyl2snrSVRZxezwrb6fltc+a5Gv
	 UylJLVPq2InMTLz8KmC/62GUcT2GeuUkgblgivrnhcrBRyQFBzwyEJu1TEG/GGAx2U
	 joC8HALOtl+l3+QHBszaqCZTRk4Lm4C2DLjo5eZSRxEzv6UpMky21x8BQY9VB2xRFC
	 PFHhQioFghnrw==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] NFSv4: Fix an incorrect parameter when calling nfs4_call_sync()
Date: Fri, 31 Oct 2025 10:51:42 -0400
Message-ID: <25c401a00c82f9c2bee221374fdd3bf45abba0d7.1761922220.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The Smatch static checker noted that in _nfs4_proc_lookupp(), the flag
RPC_TASK_TIMEOUT is being passed as an argument to nfs4_init_sequence(),
which is clearly incorrect.
Since LOOKUPP is an idempotent operation, nfs4_init_sequence() should
not ask the server to cache the result. The RPC_TASK_TIMEOUT flag needs
to be passed down to the RPC layer.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Fixes: 76998ebb9158 ("NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in _nfs4_proc_lookupp")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 411776718494..93c6ce04332b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4715,16 +4715,19 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	};
 	unsigned short task_flags = 0;
 
-	if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+	if (server->flags & NFS_MOUNT_SOFTREVAL)
 		task_flags |= RPC_TASK_TIMEOUT;
+	if (server->caps & NFS_CAP_MOVEABLE)
+		task_flags |= RPC_TASK_MOVEABLE;
 
 	args.bitmask = nfs4_bitmask(server, fattr->label);
 
 	nfs_fattr_init(fattr);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 
 	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
-	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args,
-				&res.seq_res, task_flags);
+	status = nfs4_do_call_sync(clnt, server, &msg, &args.seq_args,
+				   &res.seq_res, task_flags);
 	dprintk("NFS reply lookupp: %d\n", status);
 	return status;
 }
-- 
2.51.1


