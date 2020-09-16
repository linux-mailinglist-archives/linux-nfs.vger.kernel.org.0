Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE026CEA9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIPWXc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF46C0698C0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:18 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h11so243441ilj.11
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2V0cWFloxSr2HwFHlJuVbFbY8N1g5HU2uyUXmgJD/58=;
        b=ndE17coyXoz7RwjF5vC3lLLk6ZllT80KQ/m4PtwY9FeawMoUX1Ohk6VV3q+BjFYHI6
         u9aHqdD8oFxMR2oWfjT8emU3RXIbSuZ6W42hsWsFX/ilMd9ZxxeXLSbfZ8YPvQE6SFJ/
         BgqNd9qY3FcvuYoE490h2Ibx0rEg7QPc14IF5Gpzxoy4vIE7zx58AhOaMHqoDrDlLak1
         M7DSz4VcSrsM0TPegRHtvVnWblYsM39ePsDf3bKQHx8x3YTvRl67eNXS7b3TemP7WCah
         e7kYKBXDtHB84dpUvXclBQkv1QBrQguFWSqFlPoJVSmJc7XlMPzit/QPf/dD/Q/VyAdd
         msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2V0cWFloxSr2HwFHlJuVbFbY8N1g5HU2uyUXmgJD/58=;
        b=q5Rn4O0TWuSU11ivdIyofovOXN2aXzelV8l4hJGqAfujFaGcGk0ZbT8HZlw8rdqiHV
         1f0kDG9xpyZJl4NTDz+t3xqSMwWJBZH2q+zahy8SnV/SwyvP4FPbSBWqUpg6bMgAkvY3
         o+As9C+UoSQCBUgdRqDVS1T3wyDvjY1k3VbYFjNzjp198UY2RS3fbYJVZjOvDPUmlCky
         7s2Q91Pl0JA/+FACS6n9Pwa1yT3hgAONArud67SjOVPmxIlFJkibxD5bqNRVDt8cHp+S
         tF+rACpOlsMXRcE6VqwQj4e9KI61WaFWsgiT4U1/4XH4WsQh5+CqwPNBLBPor3VGTIdJ
         25fA==
X-Gm-Message-State: AOAM5318XdKouuH7kFOMk+jiogRoS9k2HGuXRNFLHhLKuHZs9i7QNu9w
        GZ8mJIBOBfzdv5WCcAw/s9U=
X-Google-Smtp-Source: ABdhPJw43kGFs4AjaR5WDINOACeXNs0hCvNSVU6ecR465B+P7qVPtvxdVHnWO9fHLB5K2H1Lgn3wfw==
X-Received: by 2002:a92:3302:: with SMTP id a2mr1091466ilf.84.1600292598216;
        Wed, 16 Sep 2020 14:43:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z72sm9817781iof.29.2020.09.16.14.43.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:17 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhGAY023014;
        Wed, 16 Sep 2020 21:43:16 GMT
Subject: [PATCH RFC 12/21] NFSD: Add a tracepoint to report the current
 filehandle
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:16 -0400
Message-ID: <160029259649.29208.5584223073609480101.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Expose the "current_fh", which is an implicit argument in many NFSv4
operations. I've tried to insert this tracepoint at each place that
can change the current filehandle. Typically:

nfsd-1034  [000]   165.214516: nfsd_compound:        xid=0x012e9610 opcnt=3
nfsd-1034  [000]   165.214518: nfsd_fh_current:      xid=0x012e9610 fh_hash=0x90351828 name=Makefile
nfsd-1034  [000]   165.214581: nfsd_compound_status: xid=0x012e9610 op=1/3 OP_PUTFH status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   22 ++++++++++++++++++----
 fs/nfsd/trace.h    |   30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3d6ca1bfb730..a718097b5330 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -467,6 +467,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 	return status;
 }
 
@@ -517,6 +518,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		ret = 0;
 	}
 #endif
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 	return ret;
 }
 
@@ -528,6 +530,7 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	fh_put(&cstate->current_fh);
 	status = exp_pseudoroot(rqstp, &cstate->current_fh);
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 	return status;
 }
 
@@ -543,6 +546,7 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
 		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
 	}
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 	return nfs_ok;
 }
 
@@ -687,6 +691,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_unlock(&cstate->current_fh);
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 out:
 	fh_put(&resfh);
 out_umask:
@@ -751,16 +756,24 @@ static __be32
 nfsd4_lookupp(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
-	return nfsd4_do_lookupp(rqstp, &cstate->current_fh);
+	__be32 status;
+
+	status = nfsd4_do_lookupp(rqstp, &cstate->current_fh);
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
+	return status;
 }
 
 static __be32
 nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
-	return nfsd_lookup(rqstp, &cstate->current_fh,
-			   u->lookup.lo_name, u->lookup.lo_len,
-			   &cstate->current_fh);
+	__be32 status;
+
+	status = nfsd_lookup(rqstp, &cstate->current_fh,
+			     u->lookup.lo_name, u->lookup.lo_len,
+			     &cstate->current_fh);
+	trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
+	return status;
 }
 
 static __be32
@@ -928,6 +941,7 @@ nfsd4_secinfo_no_name(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat
 		err = nfsd4_do_lookupp(rqstp, &cstate->current_fh);
 		if (err)
 			return err;
+		trace_nfsd4_fh_current(rqstp, &cstate->current_fh);
 		break;
 	default:
 		return nfserr_inval;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index dbbc45f22a80..8da691b642ac 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -888,6 +888,36 @@ TRACE_EVENT(nfsd_cb_done,
 		__entry->status)
 );
 
+TRACE_EVENT(nfsd4_fh_current,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp
+	),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__dynamic_array(unsigned char, name,
+				fhp->fh_dentry ?
+				fhp->fh_dentry->d_name.len + 1 : 0)
+	),
+	TP_fast_assign(
+		const struct dentry *dentry = fhp->fh_dentry;
+
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		if (dentry) {
+			memcpy(__get_str(name), dentry->d_name.name,
+			       dentry->d_name.len);
+			__get_str(name)[dentry->d_name.len] = '\0';
+		} else {
+			__get_str(name)[0] = '\0';
+		}
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		__entry->xid, __entry->fh_hash, __get_str(name))
+);
+
 TRACE_EVENT(nfsd_setattr_args,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


