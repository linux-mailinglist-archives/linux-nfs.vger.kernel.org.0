Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE22731AF
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIUSM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgIUSM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so16441255ioj.7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GjmD8ryDEw+p3uuYaD0u88FCWjo7SXKDVl9aT3ZXdnE=;
        b=aAWpItmV8r/F5KEpU3bheTdPtjeWs/rRiWE5DUF/+0jCldiP6qRUxz4OSQ1g7xsWPF
         cBOE1MF64i1bBVPxlTHKY9DgpPSQ72GJaIEeJjEaa5//kK4FMzpINfYgq4PU2rh35zN6
         pxGB06Q/0Fx0YKjCMYXkL5QHmwgSO1EYxFnXTihwHozPq4jZoPyi87cdK2cjECr7JJfm
         wsCyl4rJL65D0qMLDKi35F6LJfmudfX8W7HGzFD7kuEbJp399TL0qbTlt5nqxq56y8Me
         ankMYu/vwQAZMsbfKoJJtC2mZYX4NODe8B53xMpIdt4HdNbDOiCVgC5LpJSF+vim9n7G
         S3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GjmD8ryDEw+p3uuYaD0u88FCWjo7SXKDVl9aT3ZXdnE=;
        b=NV0dqAsnzBMmu7F9HRhDYUo3BdcOS09xHm8PQHO4Lr5oreECa6e66qiy3wROCJ14B7
         qAbCSfmhBQQU+Mk3DoKE/e50YFa9aevMNkw9g0SUmEVhIzVtpDX+gIvaMZ5FcvABX8ug
         RKLteaqUbVUyacD6TY+UKajDpCUW6sj0k/1AzH2drn5H1BgMufaNdweUgcinCUFKheWI
         Z32otSwn83grRtHinKWhJJOosfUegF0q2JUNbz+a8bTuUXpL4T+Ha0Dn6NL839Eow3h7
         wbqMbXCbOe6oOTJwdZg50qEwl+L8Eg7FAF7FqI2AnpKLr/2CD0whmAkpQgOKw+3buwuN
         aDCQ==
X-Gm-Message-State: AOAM530Xjfbq+aBGAwd71FzyXpGqZh5Udw1kefZU0ALE83ipm9/uhJzZ
        n0kQ4GlQGXtg7j00dj7NZQM=
X-Google-Smtp-Source: ABdhPJwTHfxR2ThLQTvJh6WdCElBW3XH05khnCtjtIj1coBC7wFQ9w+9IWynDUYZSyhNKPqrVyZGeg==
X-Received: by 2002:a5d:9c87:: with SMTP id p7mr531417iop.138.1600711978276;
        Mon, 21 Sep 2020 11:12:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p8sm3542278ilj.36.2020.09.21.11.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:57 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICulD003914;
        Mon, 21 Sep 2020 18:12:56 GMT
Subject: [PATCH v2 24/27] NFSD: Add tracepoints to record the result of
 TEST_STATEID and FREE_STATEID
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:56 -0400
Message-ID: <160071197677.1468.2041968881033526045.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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
index 79fe2ab2e773..eaad1763d33a 100644
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
index e933464316d7..10927da9d016 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -784,6 +784,62 @@ TRACE_EVENT(nfsd4_locku,
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
 TRACE_EVENT(nfsd4_delegreturn,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


