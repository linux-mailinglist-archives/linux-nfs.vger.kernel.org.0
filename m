Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7ADADCF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394182AbfJQNF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 09:05:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36509 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJQNFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 09:05:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so1778156qkc.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Hbi0LxoIEjtB80FxOJFZ9KyTGmSEe2iec6SZ8Suep4=;
        b=c07EppAXnzhpBgw0Dr/JCbeF/MWxeEEYJjiOXY+k5aS8Ydq1DTHxD8lolvUksPD/pW
         4VRQ3QEm1FWrfTCI3hgRjpxzJlvjvjAmgna2E0964EWLcBFMxh0YCOjv5+o4BHucrp7A
         +s38f1HtvFtGQ38dsufRPi/zLfY5rNBiqlGptAPodTaRplAn9T1zdYtVXnnRENm33GxU
         rTUTzxX+7adY0yMQy3Gd+GPYUTaEXnT/yFuGn8nloM811G2N0zLJ4WVlmJX7CJinxn57
         n1CFfaT4H43XMFVbyNboga4tRzAmUo92Tjd9+Z4VFBMvzVOEHfnHz+NwYVVg1qt/FQLU
         uFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Hbi0LxoIEjtB80FxOJFZ9KyTGmSEe2iec6SZ8Suep4=;
        b=QIt0ovAdFH2nBscHXnqBPxt6gmbEN+cFZAYmmalgEUdWJPY4i5PTM67VJ8Qh0ahKsf
         TOW33JbijeHp1ZH/dQHn3Jh4+KsgPZVZPVu9GwfDwLMAmqXyfwOPAJUvFEsBLDUZP+fB
         q4bg+yXy/hobz7JyhMbK3rjKhPgDA+1Mvsc0C14EXRU/gFjl9vlxL5WQSf403i8VmoMH
         ySfkRsyRUD+rwlj7Az7bFrcRChH4UZjdhpGMuprJ7+RAaUp905E/HUzKv9nL7Gz9KlVO
         Gg9cRIZPA4K/3ccsrae90uN1beo8Ka6M40oBT5mSR7RWJF5zEBSHg4dPmAS07+QtGkhA
         AUHw==
X-Gm-Message-State: APjAAAWGda0Y63bBu89dnCeZp3fevczrsfYImHu7O7A2C8Xn0/7rEZ7C
        7EbVohnVG1SNkjiYQEdAaG8urj8=
X-Google-Smtp-Source: APXvYqyhsJvU3sV4lU8ZUnSgS9hgEP0UQDG4XdjnOca8RVo8aQhSKn9qyMdFuWzvv0MQDjGrzTzEZw==
X-Received: by 2002:a37:7906:: with SMTP id u6mr3287888qkc.5.1571317553569;
        Thu, 17 Oct 2019 06:05:53 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g194sm1326648qke.46.2019.10.17.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:05:52 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v2 3/3] SUNRPC: Destroy the back channel when we destroy the host transport
Date:   Thu, 17 Oct 2019 09:02:21 -0400
Message-Id: <20191017130221.7924-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017130221.7924-3-trond.myklebust@hammerspace.com>
References: <20191017130221.7924-1-trond.myklebust@hammerspace.com>
 <20191017130221.7924-2-trond.myklebust@hammerspace.com>
 <20191017130221.7924-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we're destroying the host transport mechanism, we should ensure
that we do not leak memory by failing to release any back channel
slots that might still exist.

Reported-by: Neil Brown <neilb@suse.de>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/bc_xprt.h | 5 +++++
 net/sunrpc/backchannel_rqst.c  | 2 +-
 net/sunrpc/xprt.c              | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index 87d27e13d885..d796058cdff2 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -64,6 +64,11 @@ static inline int xprt_setup_backchannel(struct rpc_xprt *xprt,
 	return 0;
 }
 
+static inline void xprt_destroy_backchannel(struct rpc_xprt *xprt,
+					    unsigned int max_reqs)
+{
+}
+
 static inline bool svc_is_backchannel(const struct svc_rqst *rqstp)
 {
 	return false;
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 7eb251372f94..195b40c5dae4 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -220,7 +220,7 @@ void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs)
 		goto out;
 
 	spin_lock_bh(&xprt->bc_pa_lock);
-	xprt->bc_alloc_max -= max_reqs;
+	xprt->bc_alloc_max -= min(max_reqs, xprt->bc_alloc_max);
 	list_for_each_entry_safe(req, tmp, &xprt->bc_pa_list, rq_bc_pa_list) {
 		dprintk("RPC:        req=%p\n", req);
 		list_del(&req->rq_bc_pa_list);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 8a45b3ccc313..41df4c507193 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1942,6 +1942,11 @@ static void xprt_destroy_cb(struct work_struct *work)
 	rpc_destroy_wait_queue(&xprt->sending);
 	rpc_destroy_wait_queue(&xprt->backlog);
 	kfree(xprt->servername);
+	/*
+	 * Destroy any existing back channel
+	 */
+	xprt_destroy_backchannel(xprt, UINT_MAX);
+
 	/*
 	 * Tear down transport state and free the rpc_xprt
 	 */
-- 
2.21.0

