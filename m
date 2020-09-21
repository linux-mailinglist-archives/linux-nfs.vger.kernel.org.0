Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24B2731A7
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIUSMW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUSMW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB0C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y9so14714745ilq.2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CGkRMwjCkLRGTUZw2IuwoGMwMigrbCn91mR/1N3ho4o=;
        b=pwykTnbTqyDFneyKPs7DixySSjKeTIqNDtA4T7unpIxS5BmTXY/raLuy6AUcAnyjOz
         RZ5Dc+JKtc7sW7nY0ci9ynSriM9tFeAHovTf+w9bov1Uy3UsJ4rbzr8ZwpU1Hgmk0pK0
         B9lMykK9TEc2J1uRGUPF9cWErhTnrQtLCItUpc2Ps/5XBUX55k1pYCQeKJWRPfbKDVbe
         0w09Sdm42Ead9R73yFtmSfyjiYJotglvYAgcaLLUBRK7EYhXfdqUj6qEh2te5396/Fxc
         sspR6SUH9waN21nuMUpLsiq0A74Y7rCjoeUkyM9NUck9Pxc3aFPYJKS+zvDRLbhyGRGy
         U61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CGkRMwjCkLRGTUZw2IuwoGMwMigrbCn91mR/1N3ho4o=;
        b=Cf23MPip+91157sWi/3Dlcu6XliZVQ+b51Ku1oqbOGQEJaJzhNLDRlhmLClqzh/jHv
         L54blgDBpr6tEMF9GAy/t2OLzim9+pjqG2dR4zvVMYbk1/JdJKHzpyk+phpcvoLWCnSh
         72tSZyRLJpywkzXuTXIIhUqO1OqSpjFv/27rmJbM40G4eCPFCTo3fZzTEagrmYWGGcwe
         6tfq2+yHfPB95/mEZXVsl26hp//idLwqfUPA54zugUhfdFipCOajgHuXboTgIPDaBx4Z
         SOUOFzZaeQgnqQ7Bk0Y49WVVOe5M6lNnLTFRiXAXzETfyzvU3vhQUxIs0goxB7s1/v99
         9xfw==
X-Gm-Message-State: AOAM530aOzFEYVVU+biZWiVG3129VJwsGX9oRTgcqDE99xVxxC/dkgNL
        qmUbGq1/TbBMMLMdxg1yzYw=
X-Google-Smtp-Source: ABdhPJzyfvX8RcY7j4qnWMpJNhYJE/IpQTZdZ/m0tMoSAB0bl2nFBOKW1UWZar9aXv3j4+FrKZ60aQ==
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr1085027ilg.80.1600711941331;
        Mon, 21 Sep 2020 11:12:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m15sm7399630ild.8.2020.09.21.11.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:20 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICJ2B003893;
        Mon, 21 Sep 2020 18:12:19 GMT
Subject: [PATCH v2 17/27] NFSD: Add a tracepoint to report the current
 filehandle
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:19 -0400
Message-ID: <160071193964.1468.13674573350812472738.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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
nfsd-1034  [000]   165.214581: nfsd_compound_status: xid=0x012e9610 op=1/3 OP_PUTFH status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   22 ++++++++++++++++++----
 fs/nfsd/trace.h    |   31 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 17a627f97766..e378aa91ba46 100644
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
index 6f707e9f3786..c2e72b880e6a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -533,6 +533,37 @@ TRACE_EVENT(nfsd4_compoundstatus,
 	)
 )
 
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
+		__entry->xid, __entry->fh_hash, __get_str(name)
+	)
+);
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"


