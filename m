Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C226CEA5
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIPWX0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgIPWXF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E7C061D7F
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so10034505ioa.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jX10+7JlPXCMG9sNzUY3iR6CfLcxLZAoBGxLS8lkjB0=;
        b=GhXLRMYKdqITnerd8/nHqiYNv2LsGF+S/6hwdNQdVqCj1Q3X8iPVjJREtV8cPeD78w
         qKJDuXNfx4PROnFjH4Cz8jBENZbhs9skJ3J2vXint04PLCcMJlb6GSzinJhk68rwl00Y
         yVzHSKpjjYzTWeN2+z0CZDR422vnXqaZeASSxe350kg6xJuKACBetzSKQe0n04gEz01v
         67fZKoZh59QzK4Ay+iXfHYT6BHnILYX1LIZdcrLQgV7khnezQ1LyaVz55CztPqSaLUB3
         mhRzRpE56S0JgvnzJy2s61NXsDnUqvPMZWBbHyWHf0KzcGZEeFyc2lePq2MRVME0fm/9
         TUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jX10+7JlPXCMG9sNzUY3iR6CfLcxLZAoBGxLS8lkjB0=;
        b=N4K33X7ieYQTlZ7IxAHtp15aMTAZvidNDAuX9A8qxqZBEX5XSJeQBpRpql3Yn6RxrY
         4fHO9VOKorLfpHUSacymfqD8ZH/ozw6lgBA+/WTjWHjKPkD2IcWLryefyTPmEdlhDpNT
         y7AqTrreMDo2M4d5jvMDPgTW8IA5jMZGdJ75tXVHGyQ853PCwVt6Il1dz8Re1jJgjD0j
         v3wZqqiiGOxNt4Xt+GhOKyEaqEYvhrcVWVFODprPId49WNh2eDSAxJzeFkZG0xoFw7Nx
         tAO/WM6ExER9EX42ZfQvN7GIv/0SUfumMWXwd34/8C6UdZzEad92BsHvHNAyasX4Jl7o
         cpSg==
X-Gm-Message-State: AOAM533q2lslnlaln+WlJA3vyY/ZGGJsKjMowguh9ACLwpyNFvXXApGp
        zSWZ8Barg+FK6IUwVfXWrGQcwWtF8x8=
X-Google-Smtp-Source: ABdhPJwrPbYLcW82iCigvkU03f7NYVF5Rc6Jqjvtgj1tEU7pHyHvkspYzpGsqb2Z8wpALTQFFTfBXw==
X-Received: by 2002:a05:6602:2f0e:: with SMTP id q14mr20944583iow.110.1600292592900;
        Wed, 16 Sep 2020 14:43:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z15sm11369602ilb.73.2020.09.16.14.43.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:12 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhB0B023011;
        Wed, 16 Sep 2020 21:43:11 GMT
Subject: [PATCH RFC 11/21] NFSD: Add tracepoints to report NFSv4 session state
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:11 -0400
Message-ID: <160029259113.29208.736901808320139614.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
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
nfsd-1034  [001]   217.830900: nfsd4_sequence:       xid=0x0159d52e sessionid=661a615f679089370300000000000000 seqid=1 slot=0/30 status=

 ...

nfsd-1034  [002]   627.709041: nfsd4_destroy_session: xid=0x54bed52e sessionid=661a615f679089370300000000000000

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    6 ++
 fs/nfsd/trace.h     |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

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
index cbecefc3e112..dbbc45f22a80 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -911,6 +911,169 @@ TRACE_EVENT(nfsd_setattr_args,
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
+/*
+ * from include/uapi/linux/nfs4.h
+ */
+TRACE_DEFINE_ENUM(NFS4_CDFC4_FORE);
+TRACE_DEFINE_ENUM(NFS4_CDFC4_BACK);
+TRACE_DEFINE_ENUM(NFS4_CDFC4_BOTH);
+TRACE_DEFINE_ENUM(NFS4_CDFC4_BACK_OR_BOTH);
+
+#define show_nfsd_bcts_dir(x) \
+	__print_symbolic(x, \
+		{ NFS4_CDFC4_FORE,		"FORE" }, \
+		{ NFS4_CDFC4_BACK,		"BACK" }, \
+		{ NFS4_CDFC4_BOTH,		"BOTH" }, \
+		{ NFS4_CDFC4_BACK_OR_BOTH,	"BACK_OR_BOTH" })
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
+		show_nfsd_bcts_dir(__entry->dir)
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
+/*
+ * from include/uapi/linux/nfs4.h
+ */
+#define NFSD_SEQ4_FLAG_LIST \
+	nfsd_seq4_flag(CB_PATH_DOWN) \
+	nfsd_seq4_flag(CB_GSS_CONTEXTS_EXPIRING) \
+	nfsd_seq4_flag(CB_GSS_CONTEXTS_EXPIRED) \
+	nfsd_seq4_flag(EXPIRED_ALL_STATE_REVOKED) \
+	nfsd_seq4_flag(EXPIRED_SOME_STATE_REVOKED) \
+	nfsd_seq4_flag(ADMIN_STATE_REVOKED) \
+	nfsd_seq4_flag(RECALLABLE_STATE_REVOKED) \
+	nfsd_seq4_flag(LEASE_MOVED) \
+	nfsd_seq4_flag(RESTART_RECLAIM_NEEDED) \
+	nfsd_seq4_flag(CB_PATH_DOWN_SESSION) \
+	nfsd_seq4_flag_end(BACKCHANNEL_FAULT)
+
+#undef nfsd_seq4_flag
+#undef nfsd_seq4_flag_end
+#define nfsd_seq4_flag(x)	TRACE_DEFINE_ENUM(SEQ4_STATUS_##x);
+#define nfsd_seq4_flag_end(x)	TRACE_DEFINE_ENUM(SEQ4_STATUS_##x);
+
+NFSD_SEQ4_FLAG_LIST
+
+#undef nfsd_seq4_flag
+#undef nfsd_seq4_flag_end
+#define nfsd_seq4_flag(x)	{ SEQ4_STATUS_##x, #x },
+#define nfsd_seq4_flag_end(x)	{ SEQ4_STATUS_##x, #x }
+
+#define show_nfsd_seq4_status(x) __print_flags(x, "|", NFSD_SEQ4_FLAG_LIST)
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
+		show_nfsd_seq4_status(__entry->flags)
+	)
+);
+
 TRACE_EVENT(nfsd4_setclientid,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


