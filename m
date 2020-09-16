Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7526CEA6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIPWX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIPWXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8BC0698C2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a19so250432ilq.10
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EeKEBXZoBdpAlvinxANCPZH00J7GsT/y+yHphwVOXFQ=;
        b=CJ57SZmbvt9QP+8+menJSL8v6Pf1efFk5G/EjKkUlacslbWM7YfrXgJvYOhUVMyHT6
         EA6w/aPRRzf0em2Px4S4BSMSpwOKFhtQaWP+8+1VeLuOpBzGmh+Q24CnULi0/1RVvI9k
         QnpKOcyR3x3fiTgMAXJSmjr20YXV9Mb1lQ2zqXxcrYpucvuBGrBIjUGrvXhkvPrYXtZ4
         jUDyJ0XJZBGvf8YjdmxQ6VjcuS3pzyJySaadOo5TwOV/TLu+Ma4+huFkprqbU9VKmBEb
         K3IIonzgYpXZhMtyWntzTk1ghcQQfrFmeGohJfp3V51xpN03DEC7/QLC9jymxbWJMrZE
         2H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EeKEBXZoBdpAlvinxANCPZH00J7GsT/y+yHphwVOXFQ=;
        b=k4jTsWdnFE1wCskjE8SiG+wZrDKdHz2HXCPXn+IsnDckx427jh8Z+pxdmHBJpuWI0g
         ivaEN6rITRGd5Ulwxpuzb5SSICrtPUKR4Iz653PU/9Z+e4CpHU/yglzgK6L67rd25NXo
         re5gIQP40sNmpEIBIPqwgaYsRFwcrPSXawMQLnECLC8D+8jxDeiOJKp2yJv8if8QNOxK
         glvuIsDelwlJRiqqYFckBjmzqRcdx3OpsDbis6GK32senz8JLHfONLRrNksWdxHS2lwx
         NAAF+oMz1Y+ACytJWtYk8bgpNbCYeQMN4znQd2hniKgnxWz4H1uAQwFAoQzrbaS73ayl
         tUGg==
X-Gm-Message-State: AOAM532tBa4M/Ib9mX9lnsCZRhAfoU2YWse50yMxPj/OxdZmcLp929eW
        0XWDwGP0xsB9UK19BELEeQ4=
X-Google-Smtp-Source: ABdhPJya9qLP66DK0uhckyLj4RpRYB8kSVeJPg8yyKx566/MNXFb/U31iFKuM6r11pKMq+xfZH8FmQ==
X-Received: by 2002:a92:2001:: with SMTP id j1mr20109612ile.56.1600292608827;
        Wed, 16 Sep 2020 14:43:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k11sm9932082iof.40.2020.09.16.14.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:28 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhRdo023020;
        Wed, 16 Sep 2020 21:43:27 GMT
Subject: [PATCH RFC 14/21] NFSD: Add tracepoint in nfsd4_stateid_preprocess()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:27 -0400
Message-ID: <160029260719.29208.4903056291857984843.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the stateid being processed by each COMPOUND.

nfsd-1033  [003]   165.199589: nfsd_stateid_prep:    xid=0xeb2d9610 client 5f4fdc70:dbdb3569 stateid 00000001:00000002 status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   24 ++++++++++++++----------
 fs/nfsd/trace.h     |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f101202ed536..0cc928328c22 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5881,12 +5881,14 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (grace_disallows_io(net, ino))
-		return nfserr_grace;
+	if (grace_disallows_io(net, ino)) {
+		status = nfserr_grace;
+		goto out;
+	}
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
-		goto done;
+		goto out_check;
 	}
 
 	status = nfsd4_lookup_stateid(cstate, stateid,
@@ -5895,11 +5897,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (status == nfserr_bad_stateid)
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
-		return status;
+		goto out;
 	status = nfsd4_stid_check_stateid_generation(stateid, s,
 			nfsd4_has_session(cstate));
 	if (status)
-		goto out;
+		goto out_put;
 
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
@@ -5914,19 +5916,21 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		break;
 	}
 	if (status)
-		goto out;
+		goto out_put;
 	status = nfs4_check_fh(fhp, s);
 
-done:
+out_check:
 	if (status == nfs_ok && nfp)
 		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
-out:
+out_put:
 	if (s) {
 		if (!status && cstid)
 			*cstid = s;
 		else
 			nfs4_put_stid(s);
 	}
+out:
+	trace_nfsd4_stateid_prep(rqstp, stateid, status);
 	return status;
 }
 
@@ -6066,7 +6070,7 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	struct nfs4_stid *s;
 	struct nfs4_ol_stateid *stp = NULL;
 
-	trace_nfsd_preprocess(seqid, stateid);
+	trace_nfsd4_seqid_prep(seqid, stateid);
 
 	*stpp = NULL;
 	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
@@ -6135,7 +6139,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
 	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
-	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
+	trace_nfsd4_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
 	status = nfs_ok;
 put_stateid:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 48250610dfa4..fc58e1a3ef60 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -349,6 +349,35 @@ DEFINE_NFSD_ERR_EVENT(write_err);
 #include "filecache.h"
 #include "vfs.h"
 
+TRACE_EVENT(nfsd4_stateid_prep,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const stateid_t *stp,
+		__be32 status
+	),
+	TP_ARGS(rqstp, stp, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->status = be32_to_cpu(status);
+	),
+	TP_printk("xid=0x%08x client %08x:%08x stateid %08x:%08x status=%d",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation, __entry->status
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),
@@ -415,11 +444,11 @@ DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
 )
 
 #define DEFINE_STATESEQID_EVENT(name) \
-DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
+DEFINE_EVENT(nfsd_stateseqid_class, nfsd4_##name, \
 	TP_PROTO(u32 seqid, const stateid_t *stp), \
 	TP_ARGS(seqid, stp))
 
-DEFINE_STATESEQID_EVENT(preprocess);
+DEFINE_STATESEQID_EVENT(seqid_prep);
 DEFINE_STATESEQID_EVENT(open_confirm);
 
 DECLARE_EVENT_CLASS(nfsd_clientid_class,


