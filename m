Return-Path: <linux-nfs+bounces-12561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFCADEDA3
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102187A7E0F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD62E9729;
	Wed, 18 Jun 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4lChnUW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABB2E92AA;
	Wed, 18 Jun 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252775; cv=none; b=RTIafBVZpZc/tbUzjmu4VCLi13s7SC3H7HvJJ+YGEQ4qQ1isSSxMoADOj/dwRcf289PU4H4wz6Xvbbep9lBdQNDafCMZ+UnD9FDn/t4cJqmg0+MZLEsUjaYXjubr2X4esvEUNn5eL2X6PqlVUa/1vAmOq6q80ZQnVHHSXL4wBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252775; c=relaxed/simple;
	bh=cwCmH1wT+8CM+8/GoOJM2ceta//abzeWLzZBBxZrVDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKCE+iGbHp/ylYfyESucwbEIjEc1UapLDrJOwG+pN5cMxG67DnMsjN0FD3gGZFK7iRUqOUBE11NG8UyqDXZl2xvQOSRPICiY3ybllJ/J5k+CY3FjUhaS5QdZRlRrD7pP/39XhR7p/vz/Ul/2L9IivW17xZeNBr3GwRiwpsEbLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4lChnUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC770C4CEEE;
	Wed, 18 Jun 2025 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252775;
	bh=cwCmH1wT+8CM+8/GoOJM2ceta//abzeWLzZBBxZrVDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I4lChnUWD84i2MRvP0Jpbq9Ub0X8h4tZu+28iRC/ZaExzqQS3eqNikiFHVUJYbJDx
	 2y3hSiWeffVFEXcNbJH838jRJ3uFcN6Fh4vWM227YQVtp5ib4WMB0KMrwTNThHcRJg
	 e9eI/S+HpIYNpQWg8d5qSU8FJOynybY0Hfn8A5BzGDlyciqaLlti0+AUE88EiqRIKZ
	 jX+Cajci6AEkjudELJxYlYhgNSVbm4FT6XCBBwAfbYXrwfVV/esueBPmWzeFSTf8lY
	 3gZJ/dcCWy8QBPQnQNsDieJvNEDXWdxv3nBc2KyOtwIistzbmvLr2PMQ1p/xAl0U3J
	 GCeUd67/27EEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 09:19:14 -0400
Subject: [PATCH v2 3/4] nfs: new tracepoint in nfs_delegation_need_return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-nfs-tracepoints-v2-3-540c9fb48da2@kernel.org>
References: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
In-Reply-To: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Coddington <bcodding@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cwCmH1wT+8CM+8/GoOJM2ceta//abzeWLzZBBxZrVDw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUrzk4OHQdlsK4ySvKd1y/tGnkzQca3XSOBVo6
 zjxkZCsHjKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFK85AAKCRAADmhBGVaC
 FbqPEACy6NkjlK0wd8ZUWfksCGuzbcUO5sZIwNSfLVwB0uUpofepFBhLkmZRySMs20C/0LIrSYd
 SrazdYVlzMD6aZpBSTivfGSfjegPIRWsnpEzL2s1w+ywyNEmJxYlV38MJ/Oj2CLUzqsEtFT9g88
 f9M70tWuxpwEwSth5mgZFP/AnQ8Q1O+naS75tMGJG7ns7h97YI0ksn8NEGULWC63TuPXwbmK4ue
 k+nvpJRzhAdj9YkaWpZlzUcUxTap6/GU2rsQlHsUADRHQWsn/YBQG+fM24L5hRIvDHIHfM+WDxV
 gFQV1/faMzQN7KA8kW+xCf6yN87arN4sKv6Lfmb/iPbPP0RoidioWTaP9XYYv5uVEHVj61SxLwc
 cJLKrnBr3FsUDmpfWarVqHMcFrXEEigUekL/mtyOVDVhsWL1QY5poTu+grIe2uk0tH3GC5CnivO
 oztisDChXeGkEFdho+haN2ns77osU30Xjgd7xYOu26PEdpLth0JY5boT2LVJ/PLH9H/cFqyLcFr
 gjCeVWSy8qoRdpzy6YhWRKgDRnosA51gajL6WzhMntJi93lYCsGAZqJd8lsmD5ObpldO7cqR9bm
 9At/sT2aO4tRgSKOdijCZ97M3+et7yxPe69EBxrNYRwb0UOO9xHrhbV+M5fvHQin1qni9HtenfC
 ssFgkvgSFdsew1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a tracepoint in the function that decides whether to return a
delegation to the server.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  2 ++
 fs/nfs/nfs4trace.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 78a97d340bbd98390ca8302176c17caf08dcab4a..6f136c47eed7f1801af337f0e88f1a6bf477d0c6 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -594,6 +594,8 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 {
 	bool ret = false;
 
+	trace_nfs_delegation_need_return(delegation);
+
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6e1c4590ef9bf60eac994e85be816e82f5e0c741..73a6b60a848066546c2ae98b4982b0ab36bb0f73 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -14,6 +14,8 @@
 #include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 
+#include "delegation.h"
+
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
 		{ NFS_ATTR_FATTR_TYPE, "TYPE" }, \
@@ -958,6 +960,51 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_set_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_reclaim_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 
+#define show_delegation_flags(flags) \
+	__print_flags(flags, "|", \
+		{ BIT(NFS_DELEGATION_NEED_RECLAIM), "NEED_RECLAIM" }, \
+		{ BIT(NFS_DELEGATION_RETURN), "RETURN" }, \
+		{ BIT(NFS_DELEGATION_RETURN_IF_CLOSED), "RETURN_IF_CLOSED" }, \
+		{ BIT(NFS_DELEGATION_REFERENCED), "REFERENCED" }, \
+		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
+		{ BIT(NFS_DELEGATION_REVOKED), "REVOKED" }, \
+		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" }, \
+		{ BIT(NFS_DELEGATION_INODE_FREEING), "INODE_FREEING" }, \
+		{ BIT(NFS_DELEGATION_RETURN_DELAYED), "RETURN_DELAYED" })
+
+DECLARE_EVENT_CLASS(nfs4_delegation_event,
+		TP_PROTO(
+			const struct nfs_delegation *delegation
+		),
+
+		TP_ARGS(delegation),
+
+		TP_STRUCT__entry(
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+		),
+
+		TP_fast_assign(
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(delegation->inode));
+			__entry->fmode = delegation->type;
+			__entry->flags = delegation->flags;
+		),
+
+		TP_printk(
+			"fhandle=0x%08x fmode=%s flags=%s",
+			__entry->fhandle, show_fs_fmode_flags(__entry->fmode),
+			show_delegation_flags(__entry->flags)
+		)
+);
+#define DEFINE_NFS4_DELEGATION_EVENT(name) \
+	DEFINE_EVENT(nfs4_delegation_event, name, \
+			TP_PROTO( \
+				const struct nfs_delegation *delegation \
+			), \
+			TP_ARGS(delegation))
+DEFINE_NFS4_DELEGATION_EVENT(nfs_delegation_need_return);
+
 TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_PROTO(
 			const struct nfs4_delegreturnargs *args,

-- 
2.49.0


