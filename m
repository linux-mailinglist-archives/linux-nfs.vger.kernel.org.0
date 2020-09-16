Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7984326CEAB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIPWX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIPWXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410DC0698C7
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so10033767iof.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NuIAiN/1UVAd6SOLAMUMtbBqJvbGTZYkrGFIQef8tUQ=;
        b=lb3R7SM/CioOWnYjm4Hj6Qxy9yDwso5Zx2xODSmJJBZQN+HA6wFn0PCFFKFUbPz7Q+
         4/02IC3gvGrKuGrTWRXcDznr6sTui9tmdbgM4akhsUFMpmQmU1mA0sv/KVjIVjzH49Ye
         ojC9DUjIGoLQinuLPdsSGEF12fH6wJYhMthLmr4tH+maui5Iemjb8/EUGHwQ8GRwnZBm
         wGyhXprQPWIo6EqhrnhETZGYktxDuyw9ZN4u/9MKDvrX8uP6WPsF0q6KmxX60mLLm7Nv
         mnBq2Wlk4CwBWcuxgqPraUGeTvic5/vxl1ReHvAY//+Pli2ch8yniYAKnZHBHIJq3A4h
         uTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NuIAiN/1UVAd6SOLAMUMtbBqJvbGTZYkrGFIQef8tUQ=;
        b=k+LjSnrTDBkzlFBR5deqdcZBxgOGykTlWvkC1DshyPEoieWegH2S2jl8rTBT3jJh2S
         xTyPvD8PpSrcYsRbNr/D/Lcpa8VX7NGEawb6iVz0iZ6g+MYfz1+7AXr2fgYZrTlvPswY
         y7F0BzfX1rGX0apgaMhTzSlyQbaBcS+L20JSvC+JkuN2v3UTrUsIIP53crOAqAqsIkNz
         xT4SvGF959Kdp7bT6F/lpVjLF1FfBYDLOnx7ByCFYRTYwtERaMzn80t4dkFP9/fvZMGm
         QB23/mWvX0KRfLPkzIUZ8D+s0R7Vl8oS9fgtYNkRkZc7gTmijVL/XC8LuETaZft0NnB7
         +A3g==
X-Gm-Message-State: AOAM531rnvnew0P3E/8TzfakeQQh7AYLVg+oZBpIIh+WGR9GbTsMQy/v
        uycIKvjYegXdV+7W3U0PPUqxUQv+gng=
X-Google-Smtp-Source: ABdhPJzIEP3ce+HrBhZdKOsxFgixFmni6kmp6mimxA6KLT/6G0WrkovdtBtGJyM6pVz4LAR6YVPZow==
X-Received: by 2002:a5e:8c07:: with SMTP id n7mr14332526ioj.130.1600292635107;
        Wed, 16 Sep 2020 14:43:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a23sm9515686ioc.54.2020.09.16.14.43.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:54 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhrkX023035;
        Wed, 16 Sep 2020 21:43:53 GMT
Subject: [PATCH RFC 19/21] NFSD: Add lock and locku tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:53 -0400
Message-ID: <160029263350.29208.7239182282422599644.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record lock metadata.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    8 ++----
 fs/nfsd/trace.h     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8444e8b51fa8..b7c99fe8bdd0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6701,9 +6701,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
-		(long long) lock->lk_offset,
-		(long long) lock->lk_length);
+	trace_nfsd4_lock(rqstp, lock);
 
 	if (check_lock_length(lock->lk_offset, lock->lk_length))
 		 return nfserr_inval;
@@ -7001,9 +6999,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int err;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_locku: start=%Ld length=%Ld\n",
-		(long long) locku->lu_offset,
-		(long long) locku->lu_length);
+	trace_nfsd4_locku(rqstp, locku);
 
 	if (check_lock_length(locku->lu_offset, locku->lu_length))
 		 return nfserr_inval;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fd212fc1fd2a..c345a73a818f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1605,6 +1605,71 @@ TRACE_EVENT(nfsd4_exchange_id,
 	)
 );
 
+/*
+ * from include/linux/nfs4.h
+ */
+TRACE_DEFINE_ENUM(NFS4_UNLOCK_LT);
+TRACE_DEFINE_ENUM(NFS4_READ_LT);
+TRACE_DEFINE_ENUM(NFS4_WRITE_LT);
+TRACE_DEFINE_ENUM(NFS4_READW_LT);
+TRACE_DEFINE_ENUM(NFS4_WRITEW_LT);
+
+#define show_nfsd_lock_type(x)					\
+	__print_symbolic(x,					\
+		{ NFS4_UNLOCK_LT,	"UNLOCK" },		\
+		{ NFS4_READ_LT,		"READ" },		\
+		{ NFS4_WRITE_LT,	"WRITE" },		\
+		{ NFS4_READW_LT,	"READW" },		\
+		{ NFS4_WRITEW_LT,	"WRITEW" })
+
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
+		__entry->xid, show_nfsd_lock_type(__entry->type),
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
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


