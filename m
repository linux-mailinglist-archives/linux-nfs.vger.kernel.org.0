Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB16B26CEA7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIPWX3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgIPWXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C446C0698C6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j2so9990722ioj.7
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2dJl7PpUun3XU1atrcqAO6drLpoH7bw0Ab0zArC7J0M=;
        b=leGuhH2XhYfu2iyY6v+MnNQvlz62GCIwUWJpopH/0lHxHyAf4bVrIUSQNDObOdUuP+
         fjbp4TT+xytm0uOnj2BjUXOMdHX5xMupM092agzhraCaedd1hsw0FBqAOuxiWnL+nppn
         VqS1Qp/T5rz6/Gs7ukML4w9VMriQeoVUIQOrQV9oI+pLMDAAAABQlE0EKX6LglfB1QWR
         Zh9rnONfu0vlpsXAvBysnCa/ksl2pRWYq7rlXZMLhp68ZgaxEtowlsfjCJCWfbTAbJFc
         Nw1UZMZrS7VqR/2eFaZvmhF1JEuJ6n1JeK36ofe9ASvA5iPv/Nq8PTgPq0Gk14J0Qdv6
         AbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2dJl7PpUun3XU1atrcqAO6drLpoH7bw0Ab0zArC7J0M=;
        b=TuSgC9NNzdxSci4avmGgLFNvhV4Ur2S2XyaAYD8abv9Wy19BvvdZJY2WoK7WFtxMQS
         DMmJGANNVBBFG5m2O9iwQ0yBskwmsysxmUnncSjTO5MpzDWEUI+4b+jP82CEP+seM43W
         j9es2g3Gt5dgknE184gYVg9coLv/CXSSqke2XfIwUkfFH4AouvDdLfGXl8RRWOLLuQ6n
         80abTL6gLAzmy/pEYDEszXU8tMgNscD4rP6ukXsW7FLAnUr44cCKBwHpjYWr2AmbccAH
         6h22RrVRlq0/nDPTgjpWvbGB2iiafoVXMyRP7FUqyuspSPtetUPBOPHX03SuMRK8dVqM
         6VzQ==
X-Gm-Message-State: AOAM532OCm4escCJhc6peKie0J0aRxJdTdGTi1lInZ4PZRZOEOt3tDSI
        Qmixlgwqu6XRnFrvuxHL++E=
X-Google-Smtp-Source: ABdhPJwB9/Xm/L/79FyBhgKVMw9dFLAWs32wPI+8F8ygAPgT33tbla6Wy1iPoE/z4TISLgQmPcpeIw==
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr23620779jas.109.1600292629843;
        Wed, 16 Sep 2020 14:43:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k1sm11327187ilq.59.2020.09.16.14.43.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:49 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhmk6023032;
        Wed, 16 Sep 2020 21:43:48 GMT
Subject: [PATCH RFC 18/21] NFSD: Add a lookup tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:48 -0400
Message-ID: <160029262819.29208.17665617722550630287.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Unfortunately, some callers pass the same memory as the input and
result FH argument. This means we can't capture both and the status
code with a single tracepoint. The status code is recorded by other
existing tracepoints (for example in the SVC layer).

Also note that RFC 5661 S. 18.13.3 explicitly states that:

"if the object exists, the current filehandle is replaced with the
component’s filehandle... " otherwise "... an error will be returned
and the current filehandle will be unchanged."

Given that nfsd4_lookup() passes &cstate->current_fh as both the
input and output arguement, the current filehandle is set even in
the error case. This is probably not behaviorally consequential
because COMPOUND processing stops as soon as an operation fails, but
it is not compliant with the spec language.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    3 +++
 fs/nfsd/nfs4proc.c |    1 +
 fs/nfsd/nfsproc.c  |    3 +++
 fs/nfsd/trace.h    |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      |   18 +++++++++++++----
 5 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 288bc76b4574..e2420d9f5db9 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -12,6 +12,7 @@
 #include "cache.h"
 #include "xdr3.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -102,6 +103,8 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 				    argp->name,
 				    argp->len,
 				    &resp->fh);
+	trace_nfsd_lookup(rqstp, &resp->dirfh, argp->name, argp->len,
+			  &resp->fh, nfserr);
 	RETURN_STATUS(nfserr);
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index da94d769ed0a..379077254f9a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -772,6 +772,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfsd_lookup(rqstp, &cstate->current_fh,
 			     u->lookup.lo_name, u->lookup.lo_len,
 			     &cstate->current_fh);
+	trace_nfsd4_lookup(rqstp, u->lookup.lo_name, u->lookup.lo_len, status);
 	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 	return status;
 }
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6e0b066480c5..c822ee2ef8ae 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "xdr.h"
 #include "vfs.h"
+#include "trace.h"
 
 typedef struct svc_rqst	svc_rqst;
 typedef struct svc_buf	svc_buf;
@@ -137,6 +138,8 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS_FHSIZE);
 	nfserr = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
 				 &resp->fh);
+	trace_nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
+			  &resp->fh, nfserr);
 
 	fh_put(&argp->fh);
 	return nfsd_return_dirop(nfserr, resp);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2e4697324aa8..fd212fc1fd2a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1105,6 +1105,62 @@ TRACE_EVENT(nfsd4_fh_current,
 		__entry->xid, __entry->fh_hash, __get_str(name))
 );
 
+TRACE_EVENT(nfsd_lookup,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *parent,
+		const char *name,
+		unsigned int namelen,
+		const struct svc_fh *result,
+		__be32 status
+	),
+	TP_ARGS(rqstp, parent, name, namelen, result, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, parent)
+		__field(u32, result)
+		__field(int, status)
+		__dynamic_array(unsigned char, name, namelen + 1)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->parent = knfsd_fh_hash(&parent->fh_handle);
+		__entry->result = (status == nfs_ok) ?
+					knfsd_fh_hash(&result->fh_handle) : 0;
+		__entry->status = be32_to_cpu(status);
+		memcpy(__get_str(name), name, namelen);
+		__get_str(name)[namelen] = '\0';
+	),
+	TP_printk("xid=0x%08x parent fh_hash=0x%08x name=%s result fh_hash=0x%08x status=%d",
+		__entry->xid, __entry->parent, __get_str(name),
+		__entry->result, __entry->status
+	)
+);
+
+TRACE_EVENT(nfsd4_lookup,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const char *name,
+		unsigned int namelen,
+		__be32 status
+	),
+	TP_ARGS(rqstp, name, namelen, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(int, status)
+		__dynamic_array(unsigned char, name, namelen + 1)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->status = be32_to_cpu(status);
+		memcpy(__get_str(name), name, namelen);
+		__get_str(name)[namelen] = '\0';
+	),
+	TP_printk("xid=0x%08x name=%s status=%d",
+		__entry->xid, __get_str(name), __entry->status
+	)
+);
+
 /*
  * from include/linux/nfs4.h
  */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0d354531ed19..20853ab87908 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -106,6 +106,9 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 	}
 	path_put(&path);
 	exp_put(exp2);
+	if (err != nfs_ok)
+		trace_printk("xid=0x%08x status=%d",
+			be32_to_cpu(rqstp->rq_xid), be32_to_cpu(err));
 out:
 	return err;
 }
@@ -179,8 +182,6 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
-	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
-
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);
 
@@ -234,14 +235,23 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfserrno(host_err);
 }
 
-/*
- * Look up one component of a pathname.
+/**
+ * nfsd_lookup - Look up one component of a pathname
+ * @rqstp: RPC Call being processed
+ * @fhp: file handle of parent directory
+ * @name: non-terminated C string of file name to look up
+ * @len: length of @name
+ * @resfh: on success, file handle of the looked-up object
+ *
  * N.B. After this call _both_ fhp and resfh need an fh_put
+ * When callers pass the same memory for @fhp and @resfh,
+ * fh_compose() fh_put's @fhp before overwritting it.
  *
  * If the lookup would cross a mountpoint, and the mounted filesystem
  * is exported to the client with NFSEXP_NOHIDE, then the lookup is
  * accepted as it stands and the mounted directory is
  * returned. Otherwise the covered directory is returned.
+ *
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
  *      NeilBrown <neilb@cse.unsw.edu.au>


