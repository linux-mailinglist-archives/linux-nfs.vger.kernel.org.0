Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2F2BB7B7
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgKTUnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgKTUna (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:30 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5816C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:28 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so5314095qvk.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zuWdv2Z/lVn8bz+jc6R0bamEX8fh2I8FV0vOWuV6Bto=;
        b=dte7G3GsAFRUiPyf5tw118Gd3lzEhkpQKUx5YtkGHULan94qCua6na8IBy4TAC4u9V
         NV3XBWv0LXkfe7H8N8WIUDcpDEchr0IV0/NSLHw92V0HPsLFyIsK6aVc2rNC7rkj1NBu
         4q6IwmHSlRuz/GacsxcsoB07XmMjrMWbISB9zjFKbzIPN7eKLbCip0QYfSdiE//6IkMb
         YJhfMvlECjrgXTwtb71k33SyCxN1ncVVNbdDEcxyCB1Wk+GWnrGRfQKcPuMl5F7cNiRE
         YfygSRPWvAQzqE3BbcU+TNipWxLmASBKZfKwrgL79QM1MsbqVTsfIHGy4gZmEPzWyzna
         o3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zuWdv2Z/lVn8bz+jc6R0bamEX8fh2I8FV0vOWuV6Bto=;
        b=Nyr0YQ1ywaQXdnvC2/E8mnm/Gs1qiWp/w8pdh2/YmRs6iuEtGkFlYrv009vmVfoZYm
         IQn+7HgyA3dtm8b767DCE6ax7qnBOGm0bIPhRFyWO3J+ZmKkT/qrW0KXEr4C5v8CetZL
         KSlCXH2sPv8UdvEgLgBQTjh+UiO7X/Jz6U0dPRSs8eJag/hQXTF6t+hVKwl7yL8hQWhB
         vBsFKx6sxTXZ/zzCyJM885tWNmbeH3NjlCi4ouH6Eq7BiyKNpOVq52D2F2Q1t+tpokrP
         nd7ERwUooTFAPX2EWKBB9JHr6O07sbHfk5cstySOLpq2iJrpwC8MB5guqUbuilrz763U
         TZJw==
X-Gm-Message-State: AOAM5303Egs0QAeug6pg4rJMOYPmohqa30sTZgou0I4gphz4VG/VrsEi
        3qid8wATkgqfqxdjWOaxZD0+Ugy+k94=
X-Google-Smtp-Source: ABdhPJy/E7z4nqy75mRoLzLI9h12xRm5xjoHRo/XHaVIr1IYfPBUMrqKsYvuRIvyuGttxv/rbAUVjA==
X-Received: by 2002:a05:6214:6a2:: with SMTP id s2mr18197023qvz.58.1605905007684;
        Fri, 20 Nov 2020 12:43:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm2796475qkd.74.2020.11.20.12.43.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhQVo029541
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:26 GMT
Subject: [PATCH v2 109/118] NFSD: Remove argument length checking in
 nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:26 -0500
Message-ID: <160590500604.1340.6630770609567437600.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the decoders for NFSv2, NFSv3, and NFSACL all use the
xdr_stream mechanism, the special length checking logic in
nfsd_dispatch() is no longer necessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cae6fbf10514..c51287de9a8d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -961,37 +961,6 @@ nfsd(void *vrqstp)
 	return 0;
 }
 
-/*
- * A write procedure can have a large argument, and a read procedure can
- * have a large reply, but no NFSv2 or NFSv3 procedure has argument and
- * reply that can both be larger than a page.  The xdr code has taken
- * advantage of this assumption to be a sloppy about bounds checking in
- * some cases.  Pending a rewrite of the NFSv2/v3 xdr code to fix that
- * problem, we enforce these assumptions here:
- */
-static bool nfs_request_too_big(struct svc_rqst *rqstp,
-				const struct svc_procedure *proc)
-{
-	/*
-	 * The ACL code has more careful bounds-checking and is not
-	 * susceptible to this problem:
-	 */
-	if (rqstp->rq_prog != NFS_PROGRAM)
-		return false;
-	/*
-	 * Ditto NFSv4 (which can in theory have argument and reply both
-	 * more than a page):
-	 */
-	if (rqstp->rq_vers >= 4)
-		return false;
-	/* The reply will be small, we're OK: */
-	if (proc->pc_xdrressize > 0 &&
-	    proc->pc_xdrressize < XDR_QUADLEN(PAGE_SIZE))
-		return false;
-
-	return rqstp->rq_arg.len > PAGE_SIZE;
-}
-
 /**
  * nfsd_dispatch - Process an NFS or NFSACL Request
  * @rqstp: incoming request
@@ -1013,9 +982,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
 
-	if (nfs_request_too_big(rqstp, proc))
-		goto out_too_large;
-
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
@@ -1053,11 +1019,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 out_cached_reply:
 	return 1;
 
-out_too_large:
-	dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-	*statp = rpc_garbage_args;
-	return 1;
-
 out_decode_err:
 	dprintk("nfsd: failed to decode arguments!\n");
 	*statp = rpc_garbage_args;


