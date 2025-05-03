Return-Path: <linux-nfs+bounces-11413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB8AA8275
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4635A483A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD927FD40;
	Sat,  3 May 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chE3djJj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864327F758;
	Sat,  3 May 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302386; cv=none; b=VMLDCNPBY1CEDoWsjpCuI/r68BNYcHo8+fjbruEFpZ2foJR3ZJMC+KY39DZdovT6kpeG3nu3T0JDe7/W5dkGRyW2eqkx2iSzVxCo4yoB4Xkrj6BeUMNmuTD34BEeUkPHZk9Kv85lgV5OadC6QG+gYvvWU5HyqOOdKDj8R7zwexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302386; c=relaxed/simple;
	bh=GHYXZ2zNLrHq5EDH4LC00uVoAyQfqhDn50Mif6crpQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ9wFo0lllb76DrmwrKPtgkPpxnayQQAjVeLtk/owljuXwSHcKVtLFLuxLmTmUlQXis8BC5+1rr3TvvBCJjTbGkGL0PgLsqai5TlfhVTLpeyMM8F+81EEssdw39WlTZbB5+RZ1eLoSViEjcn4qlL07MIf7CKT9H606NopioBjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chE3djJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D3C4CEE9;
	Sat,  3 May 2025 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302386;
	bh=GHYXZ2zNLrHq5EDH4LC00uVoAyQfqhDn50Mif6crpQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chE3djJjMc7FW6JH8Zse+2CFV7jYRbD0ZhQQwFMqi6gfruOolrUFskDMvmCA+2KvH
	 wpx0LRvpmrUNg+DzNW0t6Q3a9c2yKq6SGZeSDkROP5MYNLZSoErzT7WpvDuP3psdHH
	 zwVK9TYf03uLqhMncb8gxva9EbZBf8HQcti5ngyaSUKWKdsEBWIMnaYmCt5lcShbtB
	 VO1vZ6EJVLFwmFsXNp3zPt6BPHh1h4oqgunWsF+nIENn5efcY+LvS7LXkcZhus/pYh
	 VB80mOEuT9GsPfXxxowy1IquA1ncZiBkdAXfdggnJuYy0g+/H/yyBuyqB26HTDI3SY
	 Rh2ZpmOofLK+A==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/18] nfsd: add nfsd_vfs_create tracepoints
Date: Sat,  3 May 2025 15:59:23 -0400
Message-ID: <20250503195936.5083-6-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observe the start of file and directory creation for all NFS
versions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  3 +++
 fs/nfsd/trace.h    | 27 +++++++++++++++++++++++++++
 fs/nfsd/vfs.c      |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..5d2b081072e8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -14,6 +14,7 @@
 #include "xdr3.h"
 #include "vfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -266,6 +267,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
+
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 661a870d62f5..a71d605fd7b7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2417,6 +2417,33 @@ TRACE_EVENT(nfsd_vfs_lookup,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_create,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		umode_t type,
+		const char *name,
+		unsigned int len
+	),
+	TP_ARGS(rqstp, fhp, type, name, len),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(umode_t, type)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->type = type;
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
+		__entry->xid, __entry->fh_hash,
+		show_fs_file_type(__entry->type), __get_str(name)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 657ba0c2da14..cc0efc47dc25 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1549,6 +1549,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, type, fname, flen);
+
 	if (isdotent(fname, flen))
 		return nfserr_exist;
 
-- 
2.49.0


