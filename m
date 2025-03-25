Return-Path: <linux-nfs+bounces-10881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035CA70CFC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB3A189B80E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA626A095;
	Tue, 25 Mar 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o57butJK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829426A0A5
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942129; cv=none; b=j389Qd964yXSY0ZHCKn/oIh4fRU/VDvicU4OqpC0tglYVBXPxmCpRR0Q7GDCtv0bM7kunrD1IgGPvrVjgN1aq4OGgiB0mDPCGo1P4U0XoZPIeeltf/AkfNwwRa4MA8MYcaQnvJvIJW74ghR3yLqtRhBzRNvrrR7YsdHlDXV5itM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942129; c=relaxed/simple;
	bh=aEopn8cIMK9pMhnOkmvKpNbi/Mw4J1E4tnmr2IjKkPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2YZ+RxNVzpWSM43smHoUGCAND6L6ZlORgmTe1+j+IblPC0UMwceHoM+0jxGz9FTWamCTtl8Dwf1ZdxzB/Ugkp8eUwQdmaAXmxRveTXnNFnmEKoRB0elkQ/rJtKZyoHRhrjLvWCa7/rr3h6ojtJ71YgQCMT/gGR9CP+N1Eh1Eps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o57butJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26066C4CEE9;
	Tue, 25 Mar 2025 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942128;
	bh=aEopn8cIMK9pMhnOkmvKpNbi/Mw4J1E4tnmr2IjKkPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o57butJKTIY4DyEsbrMpNa468z2Atso57Tpi2WVROdtGtVjQOqNkIUSpUCh9QhGAC
	 oQCgd3XHvBSZ2aWYmxBKbQFDUxOBT6kBFX8iUX5X8IorZuZAPPyETVe1LEPfhh4HjB
	 /PhRA0PqiOu4hF9BWF8ag2nmoHcGrxCxSZH5/4A3Cpwifr08coB5RMQpjdyTsJSXYz
	 51PHSb6ZQUXuvBQe/otb+SWuuouxdbJtCbYDAqQKgzyYaX+XizXPxdFRPd+xI3QJ4Z
	 C4FVz8a1Zjk1e4Bbg8xQpHdDd/mF1sQqr+Tglqk/NtlVhyqXeSM6R8Ug2eLJO3s50K
	 qHD6nIfaOfY9A==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 6/6] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
Date: Tue, 25 Mar 2025 18:35:23 -0400
Message-ID: <ea44b46c7546579386d8d9e1a2b62c152534b6cc.1742941932.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a containerised process is killed and causes an ENETUNREACH or
ENETDOWN error to be propagated to the state manager, then mark the
nfs_client as being dead so that we don't loop in functions that are
expecting recovery to succeed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 272d2ebdae0f..7612e977e80b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2739,7 +2739,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
-- 
2.49.0


