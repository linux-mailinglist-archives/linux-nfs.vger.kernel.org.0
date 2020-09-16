Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72E26CEAE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIPWXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIPWXF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA36C0698C4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:39 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q4so281552ils.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YVe7K407MPmMCUFBdDJOKKyhj4+ELuRupMkeZa5wOGA=;
        b=Ej3SV/EwGejCfJqZ0uUGrQytMLkiawURztJgXHfZQuq060jYdD0MC44LIgYF7cFMcA
         w8zVzaMHeiTQjPW/6/x6pUQF4CZp3DBh+RCFSst05RaemGDVaSHqb1toCvnuInNOtkz3
         Rl+cy9QiK6wm3++qrX81PFFfVaiJFdbiHqcUIk2uSAIHB9UwqzBYxMZmtxew6yEIS6IQ
         PwAYBn4f01np7Ze9G+f7v9b5Sv9jh6chquf2cAWZkVcDpMCGf2teBIx4jRC0v/CIaa9H
         pGYkOMko3SobKBhCeDZ0qYBHxyuN+PZPLJNdIvFF1S0iOtIp+qjvv/lwS13KDT3e7Fnw
         7vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YVe7K407MPmMCUFBdDJOKKyhj4+ELuRupMkeZa5wOGA=;
        b=Uxcst0z/n+Aeecu/5NbqAgNY9dtExnqLnNo5IsaJAwb28VL8AotLOz4BECzhpndipb
         tjPUxE/qzusBbj1aGOaA5aMvstOphVdJIHsy814ieggsywINPNRTDKGEZpnORE4sx9Gh
         lXVURtISPSLwxiDANthTtnOXNEFQYoPyLhdJ1SVPlP9QvddRAKqKQA9b6snG/mo3N7h8
         6Y/qw3vcZNiH32sMcWykrsrdBHvsyOMeecKimLqr2UVKWhCTlZcfEtT2av5YYT4jUzHj
         O5k/DETIwhHTIGVXr6Nr0Y2+0MlIHEgPzAyzo2N2/c378HkoAvMBzCAVpj4hbn13IYTz
         m1nA==
X-Gm-Message-State: AOAM53062EReVWhWzjStvzyI4xt/0EbFUxH2LV8eZ0OK3gGnQuJVkY7R
        j2vaUQB/IngWfsVtVFHUm8TVfR/1BKI=
X-Google-Smtp-Source: ABdhPJzKCSKsgbAfSPhVRhvu9CVyhV1navsXDmPOzoXcY/NHNpEjMredI0MfSJR3WV3EqwBap7BAUQ==
X-Received: by 2002:a92:9fcc:: with SMTP id z73mr15884827ilk.234.1600292619174;
        Wed, 16 Sep 2020 14:43:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u15sm9770592ior.6.2020.09.16.14.43.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:38 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhbim023026;
        Wed, 16 Sep 2020 21:43:37 GMT
Subject: [PATCH RFC 16/21] NFSD: Add CLOSE tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:37 -0400
Message-ID: <160029261781.29208.12239350175590800182.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the state ID being closed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    3 +--
 fs/nfsd/trace.h     |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 47790c7a29a3..6509e431ddd2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6253,8 +6253,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_close on file %pd\n", 
-			cstate->current_fh.fh_dentry);
+	trace_nfsd4_close(rqstp, close);
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
 					&close->cl_stateid,
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3c587d5076f7..cf350f37ddc9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -450,6 +450,37 @@ TRACE_EVENT(nfsd4_open_downgrade,
 	)
 );
 
+TRACE_EVENT(nfsd4_close,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_close *close
+	),
+	TP_ARGS(rqstp, close),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+	),
+	TP_fast_assign(
+		const stateid_t *stp = &close->cl_stateid;
+
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqid = close->cl_seqid;
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+	),
+	TP_printk("xid=0x%08x seqid=%u client %08x:%08x stateid %08x:%08x",
+		__entry->xid, __entry->seqid,
+		__entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation
+	)
+);
+
 TRACE_EVENT(nfsd4_stateid_prep,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


