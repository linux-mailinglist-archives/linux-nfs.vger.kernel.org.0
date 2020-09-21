Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E902731AD
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgIUSMt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUSMt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:49 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193DC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:48 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q4so14692073ils.4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pzQaWwYSuhjPhRS4/ZFfFzLZh9uoaX+NQjAG7FA8L2M=;
        b=tEADCb4zjzAftcSzCBekpxji7nEuVkS04SE+D/5LUESmUU9QbSzyMdkxj8OqkUtLfP
         yQ+ars2qXRB4Cs6oz2qORnOXue3GRg11Bf/nch1wf/Rxl93+RcErAPzWaMmLZRVdSCu4
         ZJWE+cnfwHsw33Y88LAbs+FGltWfvkKiyyGNxk2f3TVZaXNhdhjw4QjWY6yO/DN2Afy1
         YcJUt5BLAeLOBAOjS/68TKdLrgkRFPK7wZ+dp4NpsLLXP1jdtA9p0sQlf1Gfez6visNL
         aXMbcIgHgdDFouiZwWLYYRVmVgf89lcSH/hqtbd9uoeko3ltQcF5Fdth9cvW8mkNMjy7
         yneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pzQaWwYSuhjPhRS4/ZFfFzLZh9uoaX+NQjAG7FA8L2M=;
        b=aEQ54Si952zEeyE3VEST9i+XpUsP3O9udYP0z7Xs8vq4Bp1inuNeqvYkpziTQtP5Lo
         ixwBmngDxxEvJZoW2SZOH/n8xmZbLQ9vVGOj3yV9lnEEcI2Hpt7M7Ohag0Q2o7133nE/
         pNsnNnhvEnHNruDZTTP4c2L8aa8IO3V6/dDw/u+13CUx+P6yy5mchCH6snLOaO1RtAa5
         N9xxrrboxkUh+3NhtgQeJ71myo3JajPkxAMeAEDLcaCxeIHOKMlKH8N4HBcXJ2y2HQQY
         3++BEds5JQ1JqL4VD2kbVcQn/iRmWVhCEuBLgE6XmJKZmiBiYWlBUMuLsBodyY+Yqsr1
         ACKw==
X-Gm-Message-State: AOAM530xRqHtp51n1DikBXvVH61s0ICbeKIRNuxpYpQNZyaeu6qKYayY
        ufLhCAFjZcrsjRQEkwOviOQ=
X-Google-Smtp-Source: ABdhPJySLfvnTmg8LKGyBupyPWP+3msZD79qR/+2mkXvELqhwc/HUzg2iCO1Lxdo7+/03NZVjf0bsA==
X-Received: by 2002:a92:9fcc:: with SMTP id z73mr1106180ilk.234.1600711968151;
        Mon, 21 Sep 2020 11:12:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j20sm7518822ilq.6.2020.09.21.11.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:47 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICkJJ003908;
        Mon, 21 Sep 2020 18:12:46 GMT
Subject: [PATCH v2 22/27] NFSD: Add a lookup tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:46 -0400
Message-ID: <160071196615.1468.13191465768726286313.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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

NFSv2/3:
nfsd-1035  [001]  1162.390149: nfsd_lookup:          xid=0x8c2e5fd5 parent fh_hash=0xcf756a3e \
	name=Makefile result fh_hash=0x00000000 status=NOENT


NFSv4:
nfsd-1035  [003]    72.687149: nfsd4_lookup:         xid=0x8673fc16 name=Makefile status=ENOENT
nfsd-1035  [003]    72.687150: nfsd4_fh_current:     xid=0x8673fc16 fh_hash=0x5f73bc5d name=Makefile
nfsd-1035  [003]    72.687151: nfsd4_compoundstatus: xid=0x8673fc16 op=3/5 OP_LOOKUP status=ENOENT

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    3 +++
 fs/nfsd/nfs4proc.c |    1 +
 fs/nfsd/nfsproc.c  |    3 +++
 fs/nfsd/trace.h    |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      |   15 ++++++++++----
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 02f6bb6d749e..7d6667024440 100644
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
index 914eb3f2a233..c4fa121560ae 100644
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
index fd78651bd21d..5657f2523559 100644
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
index 234b4ea7a4c7..5c37112106c6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -76,6 +76,38 @@ TRACE_EVENT(nfsd_access,
 	)
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
+		__field(unsigned long, status)
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
+	TP_printk("xid=0x%08x parent fh_hash=0x%08x name=%s result fh_hash=0x%08x status=%s",
+		__entry->xid, __entry->parent, __get_str(name),
+		__entry->result, show_nfs_status(__entry->status)
+	)
+);
+
 TRACE_EVENT(nfsd_setattr_args,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
@@ -564,6 +596,31 @@ TRACE_EVENT(nfsd4_fh_current,
 	)
 );
 
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
+		__field(unsigned long, status)
+		__dynamic_array(unsigned char, name, namelen + 1)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->status = be32_to_cpu(status);
+		memcpy(__get_str(name), name, namelen);
+		__get_str(name)[namelen] = '\0';
+	),
+	TP_printk("xid=0x%08x name=%s status=%s",
+		__entry->xid, __get_str(name),
+		show_nfs4_status(__entry->status)
+	)
+);
+
 TRACE_EVENT(nfsd4_getattr,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0d354531ed19..db61cfb521f9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -179,8 +179,6 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
-	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
-
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);
 
@@ -234,14 +232,23 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


