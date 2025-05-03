Return-Path: <linux-nfs+bounces-11418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B10AA8283
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CDF3B343F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE5281357;
	Sat,  3 May 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXE1ovg7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146928134F;
	Sat,  3 May 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302390; cv=none; b=J8KD0IiRxTnNjhnnAot2mjNgtRsC55MjUac6jE+VLPbDfJex9Cz4RSHa5Ap/7mASflviYOzHCGuVfN+05hPiyyU8Q1eg4e83DbqehSxNRDf/f7T1zqYuBqxh7aXOS2VPvXt1GxU/rzLSP6E4HJLHbSnHhIeKUA4AttwG4Vsd0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302390; c=relaxed/simple;
	bh=03R75VgnpBb44xGfvLWBoDvFeCj07/E0MngEVFGpsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtIaVcXdT8oEHvwpdllM2gc+fs35cByL75ZG+i/EDM19GwxokR9wUkD5ys5rJRlQ9bkE9+uyOes0Ok+6q0q6i9z8tFcdenqr/dM7vdvMdxBXdhcSpE661dEkWi23+hEepOyr9jY6M8Uxf6wWlzLM0hGg9BCOBmiB8o7PJoCVu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXE1ovg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02543C4CEEE;
	Sat,  3 May 2025 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302390;
	bh=03R75VgnpBb44xGfvLWBoDvFeCj07/E0MngEVFGpsRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXE1ovg7TpY8BqMQ0mV4mSC4e4KL9VBphKiFA2hxoLRhu6SRYu8EbXVwTBPoKWGHz
	 JNuYJp9aSNEXNFCH42GyIix4uG8eHaqG1s9N4c6cLY2NGzsInrdCw+oXFtWmSJLnrK
	 An0o453i7+BQMP5BM4abSYRvUsad8krX55WDIgt8NneFQhhrsL+CbHEoIZA+PyvpoC
	 sb8i9LoSpeGfCqwcKXd4FnWbkKBwP5aoLunHJSadvg1T+HiOeX0sWlo6pov+Vp8XY6
	 GuMRd1JX10zSUd3es2saqs5yTnFFyuevOIidoRCJtf1RQSqTTRtSki8tozRxF/LHcl
	 /C2/feFvUScmA==
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
Subject: [PATCH v4 10/18] nfsd: add tracepoint to nfsd_readdir
Date: Sat,  3 May 2025 15:59:28 -0400
Message-ID: <20250503195936.5083-11-cel@kernel.org>
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

Observe the start of NFS READDIR operations.

The NFS READDIR's count argument can be interesting when tuning a
client's readdir behavior.

However, the count argument is not passed to nfsd_readdir(). To
properly capture the count argument, this tracepoint must appear in
each proc function before the nfsd_readdir() call.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 ++
 fs/nfsd/nfs4proc.c |  3 +++
 fs/nfsd/nfsproc.c  |  2 ++
 fs/nfsd/trace.h    | 26 ++++++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 5d2b081072e8..80096a5c4865 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -625,6 +625,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
+	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
@@ -659,6 +660,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	dprintk("nfsd: READDIR+(3) %s %d bytes at %d\n",
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
+	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 77895e099673..483fd8b26f9d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -998,6 +998,9 @@ nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	u64 cookie = readdir->rd_cookie;
 	static const nfs4_verifier zeroverf;
 
+	trace_nfsd_vfs_readdir(rqstp, &cstate->current_fh,
+			       readdir->rd_maxcount, readdir->rd_cookie);
+
 	/* no need to check permission - this will be done in nfsd_readdir() */
 
 	if (readdir->rd_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..c561af30c37a 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "xdr.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -618,6 +619,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),		
 		argp->count, argp->cookie);
+	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 46091d7f2260..bed58cf55c10 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2553,6 +2553,32 @@ TRACE_EVENT(nfsd_vfs_rename,
 	)
 );
 
+TRACE_EVENT(nfsd_vfs_readdir,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		u32 count,
+		u64 offset
+	),
+	TP_ARGS(rqstp, fhp, count, offset),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(u32, count)
+		__field(u64, offset)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->count = count;
+		__entry->offset = offset;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu count=%u",
+		__entry->xid, __entry->fh_hash,
+		__entry->offset, __entry->count
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.49.0


