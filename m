Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30822731AE
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgIUSMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUSMx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746CC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so9709731iom.6
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7qkt9yVb8hfYkyFBUp1iQ3bQbwLq1eS5vh1s8kDKffw=;
        b=fQVRo38imKLl8lzUAvfcnAO6QBxFDTtoRt84rpCNDGTkuyGxcvK376Rx9Z+ypYFoWP
         o/226XFt7Vh8/bN0PWxAP38OPLxKbNQNqQreyo7zUw518gw2S+DA/9jYDklID8//a6vF
         TYvHlGpffvJ71CLpSTodjO2//tI7cX6jOclHkg7jwn+wJXong0LlMnHoGojGxAMQMN+W
         IUcmI+XSf8bcYKtu7bZ+JBgFMdP8FWHM3zsw+9lPh/18jEC/0HT0WPoWrXeMqaXWo+Y0
         C3sHssPgCX8fEw09HEtbd/Q8K4sTbYe27N/Qcb0D13+kxeCGOX8HJHSlkCbf6FJCOEYs
         PmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7qkt9yVb8hfYkyFBUp1iQ3bQbwLq1eS5vh1s8kDKffw=;
        b=it5b0cl1II7IKBzr8uXfnrGW3/2fjR32HBh2+V1Pyiax67hn5cmibHmDbstC25KdnF
         FRijRMVPm75ymFkmiFokTGZluCWvhkEekNEkfI4LH9Vy1j0N4udTn4ubJ7WJZQYg1rBw
         2unYC/gER4GUQyKbqv50p6o+9ZS0mg99+SkEaNbJgBHCWAy4Yn6ObxvWvO9VEs+GGvWU
         ikOWMoDj1O+xy7Vy2+JOKZ6qU0NOR4Iz24uDQKPlXHW1HcD3MMV9HIIaD1NX9UVNa4hY
         jvwK4u7sLpuCxlxLUnTaiHiIxoO3Obv6dLzsqFsU52Lkc7TRuLiragXYlBYI0fbAxUTR
         DMCA==
X-Gm-Message-State: AOAM531X6+FtJWgXsInGZEfoE0CR9WonK2b+LJVCfJwVfvBeSFD7bMDo
        Ts+SqmXQ2ERQCoCgREqN96Q=
X-Google-Smtp-Source: ABdhPJyNNfvlYHLPGbgSynuqmPebk2jxJ39c9SPiKBwkMxEnAVcwv9luu7nADvTGOZSbEfwrGtTl7w==
X-Received: by 2002:a6b:c843:: with SMTP id y64mr500618iof.47.1600711973125;
        Mon, 21 Sep 2020 11:12:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q19sm7162527ili.74.2020.09.21.11.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:52 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICpsk003911;
        Mon, 21 Sep 2020 18:12:51 GMT
Subject: [PATCH v2 23/27] NFSD: Add lock and locku tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:51 -0400
Message-ID: <160071197146.1468.16083294924575785189.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record lock metadata.

nfsd-1035  [003]   842.934033: nfsd4_lock:           xid=0xf9651b20 type=WRITE start=2 length=1 (not new)
nfsd-1035  [003]   842.934055: nfsd4_seqid_prep:     seqid=0 client 5f68de0f:f04d8b18 stateid 00000014:00000001
nfsd-1035  [003]   842.934089: nfsd_file_put:        hash=0x6ca inode=0xffff88873c0953f0 ref=4 flags=HASHED|REFERENCED may=WRITE|READ file=0xffff888708173400
nfsd-1035  [003]   842.934095: nfsd4_compoundstatus: xid=0xf9651b20 op=3/3 OP_LOCK status=OK

nfsd-1035  [003]   842.937579: nfsd4_locku:          xid=0xff651b20 start=0 length=1
nfsd-1035  [003]   842.937580: nfsd4_seqid_prep:     seqid=0 client 5f68de0f:f04d8b18 stateid 00000014:00000002
nfsd-1035  [003]   842.937611: nfsd_file_put:        hash=0x6ca inode=0xffff88873c0953f0 ref=3 flags=HASHED|REFERENCED may=WRITE|READ file=0xffff888708173400
nfsd-1035  [003]   842.937616: nfsd4_compoundstatus: xid=0xff651b20 op=3/3 OP_LOCKU status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c        |    8 ++-----
 fs/nfsd/trace.h            |   48 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/nfs.h |   14 +++++++++++++
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 992ac867e52e..79fe2ab2e773 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6702,9 +6702,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
-		(long long) lock->lk_offset,
-		(long long) lock->lk_length);
+	trace_nfsd4_lock(rqstp, lock);
 
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
@@ -7002,9 +7000,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int err;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_locku: start=%Ld length=%Ld\n",
-		(long long) locku->lu_offset,
-		(long long) locku->lu_length);
+	trace_nfsd4_locku(rqstp, locku);
 
 	if (check_lock_length(locku->lu_offset, locku->lu_length))
 		 return nfserr_inval;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5c37112106c6..e933464316d7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -736,6 +736,54 @@ TRACE_EVENT(nfsd4_stateid_prep,
 	)
 );
 
+TRACE_EVENT(nfsd4_lock,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_lock *lock
+	),
+	TP_ARGS(rqstp, lock),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(unsigned long, type)
+		__field(bool, new)
+		__field(long long, start)
+		__field(long long, length)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->type = lock->lk_type;
+		__entry->new = lock->lk_is_new;
+		__entry->start = lock->lk_offset;
+		__entry->length = lock->lk_length;
+	),
+	TP_printk("xid=0x%08x type=%s start=%Ld length=%Ld (%s)",
+		__entry->xid, show_nfs4_lock_type(__entry->type),
+		__entry->start, __entry->length,
+		__entry->new ? "new" : "not new"
+	)
+);
+
+TRACE_EVENT(nfsd4_locku,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_locku *locku
+	),
+	TP_ARGS(rqstp, locku),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(long long, start)
+		__field(long long, length)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->start = locku->lu_offset;
+		__entry->length = locku->lu_length;
+	),
+	TP_printk("xid=0x%08x start=%Ld length=%Ld",
+		__entry->xid, __entry->start, __entry->length
+	)
+);
+
 TRACE_EVENT(nfsd4_delegreturn,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
index e6da77eb95b5..235ec353d90a 100644
--- a/include/trace/events/nfs.h
+++ b/include/trace/events/nfs.h
@@ -495,3 +495,17 @@ TRACE_DEFINE_ENUM(NFS4_OPEN_CLAIM_DELEG_PREV_FH);
 		{ NFS4_SHARE_ACCESS_READ,		"READ" }, \
 		{ NFS4_SHARE_ACCESS_WRITE,		"WRITE" }, \
 		{ NFS4_SHARE_ACCESS_BOTH,		"BOTH" })
+
+TRACE_DEFINE_ENUM(NFS4_UNLOCK_LT);
+TRACE_DEFINE_ENUM(NFS4_READ_LT);
+TRACE_DEFINE_ENUM(NFS4_WRITE_LT);
+TRACE_DEFINE_ENUM(NFS4_READW_LT);
+TRACE_DEFINE_ENUM(NFS4_WRITEW_LT);
+
+#define show_nfs4_lock_type(x) \
+	__print_symbolic(x, \
+		{ NFS4_UNLOCK_LT,			"UNLOCK" }, \
+		{ NFS4_READ_LT,				"READ" }, \
+		{ NFS4_WRITE_LT,			"WRITE" }, \
+		{ NFS4_READW_LT,			"READW" }, \
+		{ NFS4_WRITEW_LT,			"WRITEW" })


