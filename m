Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED895105
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfHSWnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:43:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39776 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWnk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:43:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id b1so3235894otp.6;
        Mon, 19 Aug 2019 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s9bIFjIETVLbW91cl2wEIB0Q9eUpvnPCnK8hNB6ULRg=;
        b=QSsPnzfjHMjaka59dEObAA8y70A1WlqtroaOEVml3m47y8HQzivyqIDmW7DpxkFtR2
         KNmLW+xjiXLxz3TKEIOXrxD+pPDVMMhfC3pOhLkU3+X2Ts6dmxAIziiWVEBobvSS/HiP
         lvqnXl2VFi0moj9ijGft57j9q1MbcJSjMUcGkhmQVnRkxfEC8HvM9CDfvDw5FqW5JqTc
         ygnlijfa9We2z28K20tL63jXawLrvMH951T26wOn+TiDgAM9FkE7SEo3GqLp/IipgBgP
         PXpNqy3INFvWvDn73lY9C7dn4PDDeyL8dhKI21fvlA22uAogA5h+C7u1QgHfUWxozaSu
         eFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=s9bIFjIETVLbW91cl2wEIB0Q9eUpvnPCnK8hNB6ULRg=;
        b=fQnPgHYMFSo1ppF6xG4QOQ7lcJxpDsaFHvmWYjjGFgmNbI7yYrlJ24ZVsfhnn/QOAa
         Qps/E45DnQNRS3Iwl6WN/eBTOiPGdiRDmMhscdrEdpJcONAEDnIe75428OZxOgDxIoXb
         uQUQ2Ehaayvloe7S3EWChQy4QRHkDMYUqoskZDZs95guR2N37/Vg+zyaPC1sJ2gQwsBg
         FX1sp83V31KIe+ZE7k5tEmGbO0adHkE107zq53Z2u3oE1Xjr+uFDy+VwQdEpef3hQU4U
         YptnAsA39/o4hf/gri2Xw9S/cZVfX031jg93GkfrMEBO7Tp4Yq1MABkXasLxIMPvKTtv
         DriQ==
X-Gm-Message-State: APjAAAUA1LjU/XRRbyOHqsu4LS6ujd9BSnjmvZ07wjqwLhf9L3A6A0hn
        E61BPCwbOK3l5aiWzWC/omownZV0
X-Google-Smtp-Source: APXvYqxvKvTjJI57D4KMVzEgC6wGevPMdgTgFF67L0OG/s1Rw0CXuqR/SkzfhCk5iQKpKmqXabjKDQ==
X-Received: by 2002:a05:6830:22e3:: with SMTP id t3mr2134022otc.347.1566254619040;
        Mon, 19 Aug 2019 15:43:39 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id 11sm6097897otc.45.2019.08.19.15.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:43:38 -0700 (PDT)
Subject: [PATCH v2 10/21] xprtrdma: Toggle XPRT_CONGESTED in xprtrdma's slot
 methods
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:43:17 -0400
Message-ID: <156625457758.8161.9892376897799599275.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 48be539dd44a ("xprtrdma: Introduce ->alloc_slot call-out for
xprtrdma") added a separate alloc_slot and free_slot to the RPC/RDMA
transport. Later, commit 75891f502f5f ("SUNRPC: Support for
congestion control when queuing is enabled") modified the generic
alloc/free_slot methods, but neglected the methods in xprtrdma.

Found via code review.

Fixes: 75891f502f5f ("SUNRPC: Support for congestion control ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 2ec349ed4770..f4763e8a6761 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -571,6 +571,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	return;
 
 out_sleep:
+	set_bit(XPRT_CONGESTED, &xprt->state);
 	rpc_sleep_on(&xprt->backlog, task, NULL);
 	task->tk_status = -EAGAIN;
 }
@@ -589,7 +590,8 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 
 	memset(rqst, 0, sizeof(*rqst));
 	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	rpc_wake_up_next(&xprt->backlog);
+	if (unlikely(!rpc_wake_up_next(&xprt->backlog)))
+		clear_bit(XPRT_CONGESTED, &xprt->state);
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,

