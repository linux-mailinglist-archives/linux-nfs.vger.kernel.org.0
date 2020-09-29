Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0866327D07B
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgI2OEW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1201C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e5so2051808ils.10
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uOznGB4P4Ui9gKYW2dTlrXuCNu7sERkmQkAAQJFtOyM=;
        b=VUl+ndd0a/zEYO6z0ZwvJENg5AjO6t80pALjXtSslTRYRds9YISVaDBWlhTOqoS1zt
         gKEq18teAzZHPA9Zb3wXQdpVBzISyrylPoocWIWc6EnEDHQoY6EpwSX/BEaYgpCb9awJ
         WlAEoimgRIjdwHq2hizc2/lavSdjUWt9Fsgzm7IXoR/wUo/hf8BYcMXOxpfM384D7rC0
         d0k/25BYpHWEXQ+8XaiNwac76XEDtrjNohATay5XYWpxo7ZZPcNtWE8ZafRvrpVzzNc2
         Rph1+eVOHl5RgwaUpXDr/pKpfQjlb6hqvqNcn+M7ESvbYvLiC48ZFOLQxU1Gw+XBqZ5V
         ZMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uOznGB4P4Ui9gKYW2dTlrXuCNu7sERkmQkAAQJFtOyM=;
        b=mF7uA0uS+NNdXYcvZpVM+az3V0fvWgVxTEQhHdL0NKfqzXvjjGSbYiBwJqn6nAI7M+
         JYpRibrl/zbr45fen7gjVW8QnGdLFp98sDAFrEr+VOdSAl7HDAh67THWixRcC6Wq8PRv
         nwLsxSyL51ttrAGp5CUOgaA1DRh6sDN8lfuJGhU7NlVvKaNX0PqFkhY+1PW2uySMixfz
         LJZB15mm5/yMKoRclW2YHet+1h8dATQZ4MiCSL03L9J2AjJtCvorh+9f+dtkrVANiYmt
         9Ja+6hSGp5QVlwkoFbulbfJ9VNfsnx58fxmmW7o7JBZhowZ9st4GiMSe9hfgeNm2u/+8
         YjCA==
X-Gm-Message-State: AOAM531a7H+UPxk92px1CJS0JTnFIdVpIl3Ju06KtdZbs/UfkuFPWKhd
        dvoPKpr5UqjcRb/59cwbxPm/y7HvmJvZ9A==
X-Google-Smtp-Source: ABdhPJzxSqSBBI9hKknVyUgWFohCwblY8vztQr8u4tqipMukJBImR0pBoPyxcckPTqZcqhD3++sCgw==
X-Received: by 2002:a92:d8d0:: with SMTP id l16mr3269908ilo.47.1601388261179;
        Tue, 29 Sep 2020 07:04:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l6sm2393959ilo.21.2020.09.29.07.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:20 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE4JEE026436;
        Tue, 29 Sep 2020 14:04:19 GMT
Subject: [PATCH v2 08/11] NFSD: Refactor nfsd_dispatch() error paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:19 -0400
Message-ID: <160138825933.2558.7100398429811622816.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_dispatch() is a hot path. Ensure the compiler takes the
processing of infrequent errors out of line.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   60 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 18ec22a8580a..283d29ecae43 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1021,29 +1021,24 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
 
-	if (nfs_request_too_big(rqstp, proc)) {
-		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	if (nfs_request_too_big(rqstp, proc))
+		goto out_too_large;
+
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	if (!proc->pc_decode(rqstp, argv->iov_base)) {
-		dprintk("nfsd: failed to decode arguments!\n");
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	if (!proc->pc_decode(rqstp, argv->iov_base))
+		goto out_decode_err;
 
 	switch (nfsd_cache_lookup(rqstp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:
-		return 1;
+		goto out_cached_reply;
 	case RC_DROPIT:
-		return 0;
+		goto out_dropit;
 	}
 
 	/*
@@ -1055,11 +1050,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
 	nfserr = proc->pc_func(rqstp);
 	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
-	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags)) {
-		dprintk("nfsd: Dropping request; may be revisited later\n");
-		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-		return 0;
-	}
+	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags))
+		goto out_update_drop;
 
 	if (rqstp->rq_proc != 0)
 		*p++ = nfserr;
@@ -1067,16 +1059,34 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	/*
 	 * For NFSv2, additional info is never returned in case of an error.
 	 */
-	if (!(nfserr && rqstp->rq_vers == 2)) {
-		if (!proc->pc_encode(rqstp, p)) {
-			dprintk("nfsd: failed to encode result!\n");
-			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-			*statp = rpc_system_err;
-			return 1;
-		}
-	}
+	if (!(nfserr && rqstp->rq_vers == 2))
+		if (!proc->pc_encode(rqstp, p))
+			goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
+out_cached_reply:
+	return 1;
+
+out_too_large:
+	dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_decode_err:
+	dprintk("nfsd: failed to decode arguments!\n");
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_update_drop:
+	dprintk("nfsd: Dropping request; may be revisited later\n");
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+out_dropit:
+	return 0;
+
+out_encode_err:
+	dprintk("nfsd: failed to encode result!\n");
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	*statp = rpc_system_err;
 	return 1;
 }
 


