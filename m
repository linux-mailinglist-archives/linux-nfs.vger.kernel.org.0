Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4D26CEA3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIPWXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD5C0698C3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so10012005ioe.5
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k47llWLEAthA+rnG5/+vtNqdOypblNpTxXEWYiL8xj0=;
        b=pVhqoyt+3Yldm8S5QMrIwip3n0HcepD4Wo+c8o+CRK/xKjFqFNnreV1TUbAo9oGxZ2
         G/03Etj20dx+fUAhpsvwSDsuXH6B52IeVdKdPVIh5Xrbi2CLcwkky9L2SIeLimrGSSO3
         +5c4LVmR5CYnQ14EgG3KV/EqtV4jKm8GarZ5+df4uOAg0C/gbd2kn/NW5CvgpdmxR3Pb
         oyT/i2W+9Jfin2isdy4uhb1Vo1MMieiSTSvIW4JsQ8GPvrjnRqihxMFEZY7vOZ3g9lla
         nHySGp3FRDYgIy/DNsecf7Q73QLqii4qNFf95X+oaYoYhUKbK+lY5yzCXxJHYhbaksGT
         AFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=k47llWLEAthA+rnG5/+vtNqdOypblNpTxXEWYiL8xj0=;
        b=SS1QBvI3qndz0kQ8FlC1rqQNmkHbQ2mT6camofBIP7p6n7IpVn7B1kgqzPH1tcaHB+
         10OdEzvPreqv4cOf/7QVMu1mkmHNc9lov79wjiIm/6bRL9LrX8f4Rhor9w9Nhv6QRGRC
         AAImNGdlXVOsqv2rYDlti0CZ102JI44KE/+t07z1FtkfegzzS7LHaWeL5SDKn17j+UrN
         ftKnESk5Je0wnYXJsu7seADzv1DjS9B0z3aZ2EW1JAk8gQ3N3WrMTsv44TbtqFLS1OVN
         URUe5KylXA8IgB/YJm8VYRykSv3f4807SrAVwk7cM/NrcK5Ma6gqnkp1yC5K/u1rr/U6
         mYjg==
X-Gm-Message-State: AOAM531Vcu4dDflJKB2MLSlRBFmxtKV8pi4xvgGdT+tBLkmbS/LlodTq
        Led3uLcIL+l7Z8wup3VFwOzZ8uhz+cI=
X-Google-Smtp-Source: ABdhPJwlFs5uzhRZGhuGCDeRd4PMZUo9Ew+qrBMw2maj1f87mEcCyaVqBUVS2AvjJvCjuTrp7ga5pg==
X-Received: by 2002:a6b:8ed2:: with SMTP id q201mr7881590iod.61.1600292614213;
        Wed, 16 Sep 2020 14:43:34 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o89sm10578039ili.51.2020.09.16.14.43.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:33 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhWol023023;
        Wed, 16 Sep 2020 21:43:32 GMT
Subject: [PATCH RFC 15/21] NFSD: Add tracepoint to report arguments to NFSv4
 OPEN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:32 -0400
Message-ID: <160029261250.29208.13662626992884110140.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Surface the open create type and claim type, as well as the XID and
the file handle and open sequence number.

            nfsd-1025  [001]   257.085227: nfsd_open_args:       xid=0x08157d7a fh_hash=0x1ac91976 seqid=97 type=CREATE claim=NULL

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |    4 +-
 fs/nfsd/nfs4state.c |    3 +-
 fs/nfsd/trace.h     |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6206ba7b1ac7..da94d769ed0a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -358,9 +358,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool reclaim = false;
 
-	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
-		(int)open->op_fname.len, open->op_fname.data,
-		open->op_openowner);
+	trace_nfsd4_open(rqstp, open);
 
 	/* This check required by spec. */
 	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0cc928328c22..47790c7a29a3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6184,8 +6184,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	struct nfs4_ol_stateid *stp;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_open_downgrade on file %pd\n", 
-			cstate->current_fh.fh_dentry);
+	trace_nfsd4_open_downgrade(rqstp, od);
 
 	/* We don't yet support WANT bits: */
 	if (od->od_deleg_want)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fc58e1a3ef60..3c587d5076f7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -348,6 +348,107 @@ DEFINE_NFSD_ERR_EVENT(write_err);
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"
+#include "xdr4.h"
+
+TRACE_DEFINE_ENUM(NFS4_OPEN_NOCREATE);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CREATE);
+
+#define show_open_create(x) \
+	__print_symbolic(x, \
+		{ NFS4_OPEN_NOCREATE, "NOCREATE" }, \
+		{ NFS4_OPEN_CREATE,   "CREATE" })
+
+#define OPEN_CLAIM_TYPE_LIST				\
+	open_claim_type(NULL)				\
+	open_claim_type(DELEGATE_PREV)			\
+	open_claim_type(PREVIOUS)			\
+	open_claim_type(DELEGATE_CUR)			\
+	open_claim_type(FH)				\
+	open_claim_type(DELEG_PREV_FH)			\
+	open_claim_type_end(DELEG_CUR_FH)
+
+#undef open_claim_type
+#undef open_claim_type_end
+#define open_claim_type(x)	TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_##x);
+#define open_claim_type_end(x)	TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_##x);
+
+OPEN_CLAIM_TYPE_LIST
+
+#undef open_claim_type
+#undef open_claim_type_end
+#define open_claim_type(x)	{ NFS4_OPEN_CLAIM_##x, #x },
+#define open_claim_type_end(x)	{ NFS4_OPEN_CLAIM_##x, #x }
+
+#define show_open_claimtype(x) \
+	__print_symbolic(x, OPEN_CLAIM_TYPE_LIST)
+
+/*
+ * from include/linux/nfs4.h
+ */
+TRACE_DEFINE_ENUM(NFS4_SHARE_ACCESS_READ);
+TRACE_DEFINE_ENUM(NFS4_SHARE_ACCESS_WRITE);
+TRACE_DEFINE_ENUM(NFS4_SHARE_ACCESS_BOTH);
+
+#define show_open_sharedeny_flags(x) \
+	__print_symbolic(x, \
+		{ NFS4_SHARE_ACCESS_READ,	"READ" }, \
+		{ NFS4_SHARE_ACCESS_WRITE,	"WRITE" }, \
+		{ NFS4_SHARE_ACCESS_BOTH,	"BOTH" })
+
+TRACE_EVENT(nfsd4_open,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_open *open
+	),
+	TP_ARGS(rqstp, open),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqid)
+		__field(unsigned long, create)
+		__field(unsigned long, claim)
+		__field(unsigned long, share)
+		__dynamic_array(unsigned char, name, open->op_fname.len + 1)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqid = open->op_seqid;
+		__entry->create = open->op_create;
+		__entry->claim = open->op_claim_type;
+		__entry->share = open->op_share_access;
+		memcpy(__get_str(name), open->op_fname.data,
+		       open->op_fname.len);
+		__get_str(name)[open->op_fname.len] = '\0';
+	),
+	TP_printk("xid=0x%08x seqid=%u type=%s claim=%s share=%s name=%s",
+		__entry->xid, __entry->seqid,
+		show_open_create(__entry->create),
+		show_open_claimtype(__entry->claim),
+		show_open_sharedeny_flags(__entry->share),
+		__get_str(name)
+	)
+);
+
+TRACE_EVENT(nfsd4_open_downgrade,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_open_downgrade *open
+	),
+	TP_ARGS(rqstp, open),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqid)
+		__field(unsigned long, share)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqid = open->od_seqid;
+		__entry->share = open->od_share_access;
+	),
+	TP_printk("xid=0x%08x seqid=%u share=%s",
+		__entry->xid, __entry->seqid,
+		show_open_sharedeny_flags(__entry->share)
+	)
+);
 
 TRACE_EVENT(nfsd4_stateid_prep,
 	TP_PROTO(


