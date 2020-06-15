Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C301F9846
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgFONVP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgFONVO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:21:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244CC061A0E;
        Mon, 15 Jun 2020 06:21:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so17730076iow.8;
        Mon, 15 Jun 2020 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SjNLJ91cqhULMfUPkTYp0OY2T4Mkc4LkzZDNbiHB4Nc=;
        b=RZRksO3ycfjFO3RdOXuk4Sqo3hGvAP0JdBG1HwHx0N7aMiwfdfwhqtpHhBrfFgw5Rf
         Z24Gc+8gNSnayDv08TDxtrv8oHiZouCQGV4bqy7ate9Jq6Zm2FtY+DPmCEGLrod91UkI
         RcksliCk0ZOnLSrdH4+galCNZdAGNi7DRreCgZ9VwvixC8AjWn91YYYdNYXyhjRmOD8g
         GW7tdRDzoETsJnAbFGqCbqQLuRfXEHDG1/ykIOQyzCmZA0OK/CGz/ZnOfrDk23Xvy7LE
         izXj32JRf6CGPyDkgWokdsXRtp41PqOwp2F84RBCIUJmWOEgUZoFCd9xCLisRYwGs1Vr
         GnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SjNLJ91cqhULMfUPkTYp0OY2T4Mkc4LkzZDNbiHB4Nc=;
        b=C9zFCf1DwrygloAxrXFCfKMPAYpMkkutLTZqZ2o/xqFGaU46tsaDpjhphqX9WnuuVu
         HTLoPWhe+qw19jwPb9h3ZrV1kamEpLo9X2NaynU4UGV6BCPep1c50auPVJp8ZJ126U+r
         1EvVgfInbAIgTmPtsiaeX0Ks+Zua1sdkiPpSF4jAhoyhxirYDh09fT5/Dj/73+XzOstw
         bn+BPkWx7RlaitDKRGqOPWF88zGWmnP01J2VDpKc7jj8BkFLF84J9WPntPp0ErgULLsz
         aRNfgcRG4F3jjcrUnUDdyOPwcin9Be+szkVVyk3Ejey6JL2ljxM5cJDLqPUjWaUhHZ8I
         9NDw==
X-Gm-Message-State: AOAM532n39YQAC33aG0mLxxGAODNfwLheHJ9P32dbocO6UmQCRcBH9yo
        NQSFkpHhM+2C8xaAPR7oH3g=
X-Google-Smtp-Source: ABdhPJzEqhCJ0I+jhP7ALxkXT4AJX7Ap4ce+fcHr0aiFji2tihBExiJWNW532uyhMnt5GkS5Mv8XMw==
X-Received: by 2002:a6b:630d:: with SMTP id p13mr27599094iog.145.1592227274182;
        Mon, 15 Jun 2020 06:21:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n4sm8106768ioc.8.2020.06.15.06.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:21:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDLDbi018444;
        Mon, 15 Jun 2020 13:21:13 GMT
Subject: [PATCH v1 5/5] xprtrdma: Fix handling of RDMA_ERROR replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:21:13 -0400
Message-ID: <20200615132113.11800.52604.stgit@manet.1015granger.net>
In-Reply-To: <20200615131642.11800.27486.stgit@manet.1015granger.net>
References: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The RPC client currently doesn't handle ERR_CHUNK replies correctly.
rpcrdma_complete_rqst() incorrectly passes a negative number to
xprt_complete_rqst() as the number of bytes copied. Instead, set
task->tk_status to the error value, and return zero bytes copied.

In these cases, return -EIO rather than -EREMOTEIO. The RPC client's
finite state machine doesn't know what to do with -EREMOTEIO.

Additional clean ups:
- Don't double-count RDMA_ERROR replies
- Remove a stale comment

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@kernel.vger.org>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 2081c8fbfa48..935bbef2f7be 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1349,8 +1349,7 @@ rpcrdma_decode_error(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 			be32_to_cpup(p), be32_to_cpu(rep->rr_xid));
 	}
 
-	r_xprt->rx_stats.bad_reply_count++;
-	return -EREMOTEIO;
+	return -EIO;
 }
 
 /* Perform XID lookup, reconstruction of the RPC reply, and
@@ -1387,13 +1386,11 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	spin_unlock(&xprt->queue_lock);
 	return;
 
-/* If the incoming reply terminated a pending RPC, the next
- * RPC call will post a replacement receive buffer as it is
- * being marshaled.
- */
 out_badheader:
 	trace_xprtrdma_reply_hdr(rep);
 	r_xprt->rx_stats.bad_reply_count++;
+	rqst->rq_task->tk_status = status;
+	status = 0;
 	goto out;
 }
 

