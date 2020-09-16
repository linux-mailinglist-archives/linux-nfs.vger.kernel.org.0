Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469D426CEA2
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIPWXR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC042C0698C8
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:44:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so9978543iol.10
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y4jfhY8r5LJIPrBu+UFDSeKrdf8DEzWa1S4iXt35jgI=;
        b=d3jCHm7wxwYqf4pb3/qW0iL6UZH0CEFfz15K5AE3Ms9ze5akV6OADVAqo48smhSlE6
         gyGtGc4imG8Tf3G7s36jZ7Xmo3T92WsqIpdnwEXZU/7e0+60xYg/g66MdYEt3F+hlLoE
         7Jb98Rst+1PMgB0Tl1OWXYOIPTJfTpvIACBB141DMVH97273pYatQAYLBLEjjAz3S0rx
         FVt80c6g6FhYE/N9LgTkY4L6mb6HJN0xvx0Dt+JZvIJ/sEz8mBrF5iXrja6avgaAAD1K
         ZL26endxTKGOWYKHfSgw2MYPjSGslGUNGJag08hP8WjqcO84O4A1wdEIGe095MXzcY5a
         x4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=y4jfhY8r5LJIPrBu+UFDSeKrdf8DEzWa1S4iXt35jgI=;
        b=QwtZPmNYGXjZ0NHXL6ufLVg/ydubFPYFr199exNcTbO3DJB7/kKfQuLCUFFvJVPg38
         pwVpDQ4yDbUE7CEFcntcca8v6sLjU5Ub4lTzw9ymmgT3Uyr8T13wEnONoxi5oupBfsqt
         r0qTyshrcltxysObD+eV3H5lef44YDhiEVqEz9GDDq/vGXaDSQVdidoJMmNifRwNjjrb
         pfzug5a0SJt+Y4XJlYL4yBJMOZXhyX0w+Hb1DeBeoH50tnp2wcbYuhOYB4uQ2SrKMOQu
         Y+Juog+17N+03fRCibRlGL9KZdwBy3n/OYi0+VAsmXUA8G1idNT3APqqgWi6R16CURHC
         EzyA==
X-Gm-Message-State: AOAM530njVV5C+6Bk1+x0R0RDirl5meI2uP8rOAjWkhQIXvGXI+D0JhV
        0vBYhQ35Jm4SPLJBREthIhk=
X-Google-Smtp-Source: ABdhPJx1YcYdjUUmfm3XI3na92MqkmzeoGe39qEEZK4AKPEYrxvWpcAZ0tnBaj0/oLH3ahCxZlOiXQ==
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr21336530iod.165.1600292640226;
        Wed, 16 Sep 2020 14:44:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r8sm9520400iot.51.2020.09.16.14.43.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:59 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhw6Q023038;
        Wed, 16 Sep 2020 21:43:58 GMT
Subject: [PATCH RFC 20/21] NFSD: Add tracepoints to record the result of
 TEST_STATEID and FREE_STATEID
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:58 -0400
Message-ID: <160029263880.29208.946038211132453116.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These tracepoints record information about NFSv4 state recovery.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    6 +++++
 fs/nfsd/trace.h     |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b7c99fe8bdd0..9521d05cfb6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5945,9 +5945,11 @@ nfsd4_test_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_test_stateid_id *stateid;
 	struct nfs4_client *cl = cstate->session->se_client;
 
-	list_for_each_entry(stateid, &test_stateid->ts_stateid_list, ts_id_list)
+	list_for_each_entry(stateid, &test_stateid->ts_stateid_list, ts_id_list) {
 		stateid->ts_id_status =
 			nfsd4_validate_stateid(cl, &stateid->ts_id_stateid);
+		trace_nfsd4_test_stateid(rqstp, stateid);
+	}
 
 	return nfs_ok;
 }
@@ -5992,6 +5994,8 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *cl = cstate->session->se_client;
 	__be32 ret = nfserr_bad_stateid;
 
+	trace_nfsd4_free_stateid(rqstp, stateid);
+
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c345a73a818f..d52c0ed5ce4a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1670,6 +1670,62 @@ TRACE_EVENT(nfsd4_locku,
 	)
 );
 
+TRACE_EVENT(nfsd4_test_stateid,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_test_stateid_id *stateid
+	),
+	TP_ARGS(rqstp, stateid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		const stateid_t *stp = &stateid->ts_id_stateid;
+
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->status = be32_to_cpu(stateid->ts_id_status);
+	),
+	TP_printk("xid=0x%08x client=%08x:%08x stateid=%08x:%08x status=%d",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation, __entry->status
+	)
+);
+
+TRACE_EVENT(nfsd4_free_stateid,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const stateid_t *stp
+	),
+	TP_ARGS(rqstp, stp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+	),
+	TP_printk("xid=0x%08x client=%08x:%08x stateid=%08x:%08x",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


