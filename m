Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32722731A5
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgIUSMR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUSMQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q4so7094901iop.5
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dCxOHTpGXH+AsYrOMXwPSIUlZKl7erAYk0hY3DF41y4=;
        b=EQGFPek0VUSq5nC9n4bIFvs23dxizP0EqXpOMQy2fQtQ0GVgH/8m20cClJV2mhDziq
         s2OJGUKX5U2ueN9jLYoMfw5R30qCQWqTeYeTM793vsho1PM1JG8zK84SaaUJNBTueS4V
         GEB/bZr2OfChwlsBH3bTBecqCWJVGr/y88avlVVwo4QXJlmN0uQTbqT50Tw5EsOdJSA0
         xS/WQX4U3COOv7EkgupJU2b3hhQsB6VtWM+Qu7KHgevRwaZJhLDHPL54y6h1m7I+gP3g
         aGGF0k7wjXb9W5t3zmIq1gOgvFfZNYK2kIQV39kGgPyeAXL7HtZrGcAG6sc25hFs43nT
         0YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dCxOHTpGXH+AsYrOMXwPSIUlZKl7erAYk0hY3DF41y4=;
        b=HHjGAviGdbuHlklMKyDUc/QO7cOpn0CK9j5vffkz3CiXTI9kwEZKaySe8ddcvVSln5
         GbeSOh1F7WAwZ/Rd+6so505H2TvmUPEHRlIfJiVvfT2qZQlgiUA43UhN8PTVdo/mAEm5
         UVw+GDzu5kNzSMPjXdz9UqQl2S7kD7IwnQ3c02gplYje4zr7hyrjL1jKgVsCpNtHWBS9
         I6x8D3QashZELOUU9TaIqaRJcd5BkmnUl8RzpuPrmrNmKO7XC4WZuR+/i17balVzsSe8
         HPUk91wcItUS2GIrxcj6WnY4oXYhXA424Utf7cv9uZKZfH56u8PHiuoiFo8A6YPlMLTL
         j93Q==
X-Gm-Message-State: AOAM531yqC0fIle97aDEQBzXwkRVTEQrZI+qhn8i9k+7Fh0LCCJRPDUz
        ZYh97nT10zioIWM8pdhZ47U=
X-Google-Smtp-Source: ABdhPJwAWRH/iv6en3ZUrmeln+YscMt60mmDryuzl1fbTbJtRyFgMnmitDJFRnA71imHrU55w3x8Pg==
X-Received: by 2002:a02:a30b:: with SMTP id q11mr1029460jai.77.1600711936025;
        Mon, 21 Sep 2020 11:12:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e22sm6214100ioc.43.2020.09.21.11.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:15 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICERP003890;
        Mon, 21 Sep 2020 18:12:14 GMT
Subject: [PATCH v2 16/27] NFSD: Add tracepoints to report NFSv4 session state
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:14 -0400
Message-ID: <160071193428.1468.9136162844041249865.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These record the SEQ4 status flags and session slot and sequence
information for debugging purposes. Examples:

nfsd-1034  [001]   217.828352: nfsd4_create_session: xid=0x0059d52e client 5f611a66:37899067 sessionid=661a615f679089370300000000000000
nfsd-1034  [001]   217.830900: nfsd4_sequence:       xid=0x0159d52e sessionid=661a615f679089370300000000000000 seqid=1 slot=0/30 flags=

 ...

nfsd-1034  [002]   627.709041: nfsd4_destroy_session: xid=0x54bed52e sessionid=661a615f679089370300000000000000

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c        |    6 ++
 fs/nfsd/trace.h            |  118 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/nfs.h |    7 +++
 3 files changed, 131 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 974b3303d2fc..f101202ed536 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3446,6 +3446,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	nfsd4_put_session(new);
 	if (old)
 		expire_client(old);
+	trace_nfsd4_create_session(rqstp, cr_ses);
 	return status;
 out_free_conn:
 	spin_unlock(&nn->client_lock);
@@ -3545,6 +3546,8 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	trace_nfsd4_bind_conn_to_session(rqstp, bcts);
+
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
 	spin_lock(&nn->client_lock);
@@ -3591,6 +3594,8 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	trace_nfsd4_destroy_session(r, sessionid);
+
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
 		if (!nfsd4_last_compound_op(r))
@@ -3812,6 +3817,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	trace_nfsd4_sequence(rqstp, seq);
 out_no_session:
 	if (conn)
 		free_conn(conn);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 192d039da0ec..6f707e9f3786 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -368,6 +368,124 @@ TRACE_EVENT(nfsd4_exchange_id,
 	)
 );
 
+TRACE_EVENT(nfsd4_create_session,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_create_session *cr_ses
+	),
+	TP_ARGS(rqstp, cr_ses),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, sessionid, NFS4_MAX_SESSIONID_LEN)
+
+		__field(u32, fore_maxreqsz)
+		__field(u32, fore_maxrespsz)
+		__field(u32, fore_maxops)
+		__field(u32, fore_maxreps)
+
+		__field(u32, back_maxreqsz)
+		__field(u32, back_maxrespsz)
+		__field(u32, back_maxops)
+		__field(u32, back_maxreps)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = cr_ses->clientid.cl_boot;
+		__entry->cl_id = cr_ses->clientid.cl_id;
+		memcpy(__entry->sessionid, &cr_ses->sessionid,
+		       NFS4_MAX_SESSIONID_LEN);
+		__entry->fore_maxreqsz = cr_ses->fore_channel.maxreq_sz;
+		__entry->fore_maxrespsz = cr_ses->fore_channel.maxresp_sz;
+		__entry->fore_maxops = cr_ses->fore_channel.maxops;
+		__entry->fore_maxreps = cr_ses->fore_channel.maxreqs;
+		__entry->back_maxreqsz = cr_ses->back_channel.maxreq_sz;
+		__entry->back_maxrespsz = cr_ses->back_channel.maxresp_sz;
+		__entry->back_maxops = cr_ses->back_channel.maxops;
+		__entry->back_maxreps = cr_ses->back_channel.maxreqs;
+	),
+	TP_printk("xid=0x%08x client=%08x:%08x sessionid=%s",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__print_hex_str(__entry->sessionid, NFS4_MAX_SESSIONID_LEN)
+	)
+);
+
+TRACE_EVENT(nfsd4_bind_conn_to_session,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_bind_conn_to_session *bcts
+	),
+	TP_ARGS(rqstp, bcts),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(unsigned long, dir)
+		__array(unsigned char, sessionid, NFS4_MAX_SESSIONID_LEN)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->dir = bcts->dir;
+		memcpy(__entry->sessionid, &bcts->sessionid,
+		       NFS4_MAX_SESSIONID_LEN);
+	),
+	TP_printk("xid=0x%08x sessionid=%s, dir=%s",
+		__entry->xid,
+		__print_hex_str(__entry->sessionid, NFS4_MAX_SESSIONID_LEN),
+		show_nfs4_bcts_dir(__entry->dir)
+	)
+);
+
+TRACE_EVENT(nfsd4_destroy_session,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfs4_sessionid *sessionid
+	),
+	TP_ARGS(rqstp, sessionid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__array(unsigned char, sessionid, NFS4_MAX_SESSIONID_LEN)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		memcpy(__entry->sessionid, sessionid, NFS4_MAX_SESSIONID_LEN);
+	),
+	TP_printk("xid=0x%08x sessionid=%s",
+		__entry->xid,
+		__print_hex_str(__entry->sessionid, NFS4_MAX_SESSIONID_LEN)
+	)
+);
+
+TRACE_EVENT(nfsd4_sequence,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_sequence *seq
+	),
+	TP_ARGS(rqstp, seq),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqid)
+		__field(u32, slotid)
+		__field(u32, maxslots)
+		__field(unsigned long, flags)
+		__array(unsigned char, sessionid, NFS4_MAX_SESSIONID_LEN)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqid = seq->seqid;
+		__entry->slotid = seq->slotid;
+		__entry->maxslots = seq->maxslots;
+		__entry->flags = seq->status_flags;
+		memcpy(__entry->sessionid, &seq->sessionid,
+		       NFS4_MAX_SESSIONID_LEN);
+	),
+	TP_printk("xid=0x%08x sessionid=%s slot=%u/%u seqid=%u flags=%s",
+		__entry->xid,
+		__print_hex_str(__entry->sessionid, NFS4_MAX_SESSIONID_LEN),
+		__entry->slotid, __entry->maxslots, __entry->seqid,
+		show_nfs4_seq4_status(__entry->flags)
+	)
+);
+
 TRACE_EVENT(nfsd4_compound,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
index 76f661e8cdf4..a152ed94e538 100644
--- a/include/trace/events/nfs.h
+++ b/include/trace/events/nfs.h
@@ -381,3 +381,10 @@ TRACE_DEFINE_ENUM(SP4_SSV);
 		{ SP4_NONE,				"NONE" }, \
 		{ SP4_MACH_CRED,			"MACH_CRED" }, \
 		{ SP4_SSV,				"SSV" })
+
+#define show_nfs4_bcts_dir(x) \
+	__print_symbolic(x, \
+		{ NFS4_CDFC4_FORE,			"FORE" }, \
+		{ NFS4_CDFC4_BACK,			"BACK" }, \
+		{ NFS4_CDFC4_FORE_OR_BOTH,		"FORE_OR_BOTH" }, \
+		{ NFS4_CDFC4_BACK_OR_BOTH,		"BACK_OR_BOTH" })


