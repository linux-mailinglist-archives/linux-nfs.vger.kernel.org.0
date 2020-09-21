Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7942731AB
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgIUSMi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUSMi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BCC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q5so8170761ilj.1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jwBl5uWWZwmQG7Zrigts4izLSYbMWFsNdzPM00YxQbg=;
        b=RGyi8mDkzuCMKAV67u/kfGG2NBCdAIjfsG5uCwrYohLMO+//BWpT+i8fx9fXPn3k9E
         pPxSMlUh7/cThZcxSt/KTm70/yKkF1Sp1qqOlRcR5nC4g2q7Z1WkTEOgm3zxrtXbDpaV
         zdY8qgv2gsVCbpbZB2tEaj8xtPuYIQ3+qHq2HZn9E+ASjOzt7ZuLy7H03KWf5M7fdaG8
         jLxSXqmfOUNBUw7kyl6omJeG+ipaG3g9+I+Hsy8cU/uNd/rAcYMDpjJnRdd7dtfdSAH5
         qta6214iV0QAnsYFFzbx5k8tNCwbMldZUibZeow7286cY/bt0jncMUpODNkonTZnJZhl
         8S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jwBl5uWWZwmQG7Zrigts4izLSYbMWFsNdzPM00YxQbg=;
        b=a97Tuq71L+O+whOnjTtY0ERea4VgnYeYSBjvO81qIowVRbKUQqWJIfvBf0GWKUWhum
         GhPwTMrdLjtUI9Sk6K321tjcK4VVm6c6l/UU3DK8/VHdi9qK4aIz/G+2EWu88FoxS1fa
         sf4Bron6/ZE6E2qsZrU4YKGlPXAu0DhZUnn5E3lz6UWvyzx3warkEN2N2CWoy0Txa3Pq
         AH+92Q1u0BB+HC6MZqgTAzkrYa6zDEuWZqDcNDR94tWDkbTO0ommrlQkWFTfciGegxTb
         320pVZ3w+4ui3OPJqwj+vyEhQwGraKpCJqeMQuC6O0G5EfjhUXs48eeWV1knnfZ9OLwt
         qxvw==
X-Gm-Message-State: AOAM531otZPzC4AqoeDUp5AVjrx6VKVVOEfY8yDeZH6DW8NlyQiAYUDK
        IBNuzInmv/lfdAKT+absukE=
X-Google-Smtp-Source: ABdhPJwjStWzehH8X+0E293l4xCYbXfIkQ7EBzeD9CN04x4zzYRQn8za3aq9d+utCiktCH4+0oo65A==
X-Received: by 2002:a92:d08f:: with SMTP id h15mr977130ilh.27.1600711957244;
        Mon, 21 Sep 2020 11:12:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e14sm6047830iow.16.2020.09.21.11.12.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:36 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICZuA003902;
        Mon, 21 Sep 2020 18:12:35 GMT
Subject: [PATCH v2 20/27] NFSD: Add tracepoint to report arguments to NFSv4
 OPEN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:35 -0400
Message-ID: <160071195553.1468.16911856526302012430.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4proc.c         |    4 +--
 fs/nfsd/nfs4state.c        |    3 +-
 fs/nfsd/trace.h            |   55 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/nfs.h |   32 ++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 065ed5930250..914eb3f2a233 100644
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
index be5fc0ce3c13..18b359a04d96 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -594,6 +594,61 @@ TRACE_EVENT(nfsd4_getattr,
 #include "filecache.h"
 #include "vfs.h"
 
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
+		show_nfs4_open_create(__entry->create),
+		show_nfs4_open_claimtype(__entry->claim),
+		show_nfs4_open_sharedeny_flags(__entry->share),
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
+		show_nfs4_open_sharedeny_flags(__entry->share)
+	)
+);
+
 TRACE_EVENT(nfsd4_stateid_prep,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
index 19f7444e4bb2..e6da77eb95b5 100644
--- a/include/trace/events/nfs.h
+++ b/include/trace/events/nfs.h
@@ -463,3 +463,35 @@ TRACE_DEFINE_ENUM(SP4_SSV);
 		{ FATTR4_WORD2_SECURITY_LABEL,		"SECURITY_LABEL" }, \
 		{ FATTR4_WORD2_MODE_UMASK,		"MODE_UMASK" }, \
 		{ FATTR4_WORD2_XATTR_SUPPORT,		"XATTR_SUPPORT" })
+
+TRACE_DEFINE_ENUM(NFS4_OPEN_NOCREATE);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CREATE);
+
+#define show_nfs4_open_create(x) \
+	__print_symbolic(x, \
+		{ NFS4_OPEN_NOCREATE,			"NOCREATE" }, \
+		{ NFS4_OPEN_CREATE,			"CREATE" })
+
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_NULL);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_PREVIOUS);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_DELEGATE_CUR);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_DELEGATE_PREV);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_FH);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_DELEG_CUR_FH);
+TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_DELEG_PREV_FH);
+
+#define show_nfs4_open_claimtype(x) \
+	__print_symbolic(x, \
+		{ NFS4_OPEN_CLAIM_NULL,			"NULL" }, \
+		{ NFS4_OPEN_CLAIM_PREVIOUS,		"PREVIOUS" }, \
+		{ NFS4_OPEN_CLAIM_DELEGATE_CUR,		"DELEGATE_CUR" }, \
+		{ NFS4_OPEN_CLAIM_DELEGATE_PREV,	"DELEGATE_PREV" }, \
+		{ NFS4_OPEN_CLAIM_FH,			"FH" }, \
+		{ NFS4_OPEN_CLAIM_DELEG_CUR_FH,		"DELEG_CUR_FH" }, \
+		{ NFS4_OPEN_CLAIM_DELEG_PREV_FH,	"DELEG_PREV_FH" })
+
+#define show_nfs4_open_sharedeny_flags(x) \
+	__print_symbolic(x, \
+		{ NFS4_SHARE_ACCESS_READ,		"READ" }, \
+		{ NFS4_SHARE_ACCESS_WRITE,		"WRITE" }, \
+		{ NFS4_SHARE_ACCESS_BOTH,		"BOTH" })


