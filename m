Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA7D9384
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbfJPOR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 10:17:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45306 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfJPOR6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Oct 2019 10:17:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so36264992qtj.12
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2019 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muyrwKCkKeapXczyZQbXCsQey1nBdQol/tef0UdG3SI=;
        b=GM5TrleVwG9yaVD6iv+CS/z0xrNsp6+EmNZUcfcs7pyIzYnoe5MCyLcFIB7EPdyl89
         vVo2lZ4siRmS2ALccwmEZWtZ30iIJi9HgTRGMBgOj8caUgSBiMVAxgbHvHAxaTA+qgWn
         IdV9ev5VFjPGaiGcUU3E3CQ9YRNTamU7hkokIdUo7N06XJzoBQxWZjz2v6UtoTIpEVOV
         +v+BOgK9IJ/8OSWb4uOhyNzBsTRbpKDRzUShJ4bXGzTEUnhaCrInpGQ/3szoIWB+q2s1
         Rgbpfd/02/w9ArhEFRojrLxSBdvEp+t2/WqCNRqLeUc2/9HT6GOZEkYPGc9rY19OWo1L
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muyrwKCkKeapXczyZQbXCsQey1nBdQol/tef0UdG3SI=;
        b=kzEHad8JFsttrcszvx+lV3JrbR9FNUKf52TnYQsslI0c4jvCOcAKWcz9A4g5SWiOXe
         NwEsxH8q/H+kl9npW26ZC6LqZ/chQz/vgHz4g+X/AwkqbEOt3Vebl07S7CSBth1g3XjG
         J9ZtT7C1ja+uel6MhHvXFhGtAlXSCuc1Pmi6IhdvNkTVYDJU0vK8B58X/nN0LLRTrJuV
         OJ9pT1///nbX5C9OVy/th+k1LStf/JqBaRuNwEHa81H/Wb7c+Q5HLNFumHmSRcrOpQdl
         3RrF9LOlndpthbq1pM8tfOYibFn8T6ufAJGAH8xjYbJ5ZNNf7k9fQzdSZZngN5n7L4ZI
         pRWg==
X-Gm-Message-State: APjAAAUjvnF6VNWWTdrYXM9PuyQGiJAvFFHFtmGar9qsLsoy7rGzyfzY
        m3HtihvFtny+3b8W4tUfCi0qPhY=
X-Google-Smtp-Source: APXvYqwYmnLzikNE6Lv0RunAhR3vjALRoakiYvgVeGAk7t9RtZuyxYzldfbA8yNTcflyZRuWKOmHVw==
X-Received: by 2002:a05:6214:841:: with SMTP id dg1mr41838943qvb.55.1571235476441;
        Wed, 16 Oct 2019 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g31sm14925361qte.78.2019.10.16.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:17:55 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/3] SUNRPC: The TCP back channel mustn't disappear while requests are outstanding
Date:   Wed, 16 Oct 2019 10:15:44 -0400
Message-Id: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If there are TCP back channel requests either being processed by the
server threads, then we should hold a reference to the transport
to ensure it doesn't get freed from underneath us.

Reported-by: Neil Brown <neilb@suse.de>
Fixes: 2ea24497a1b3 ("SUNRPC: RPC callbacks may be split across several..")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/backchannel_rqst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 339e8c077c2d..7eb251372f94 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -307,8 +307,8 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
 		 */
 		dprintk("RPC:       Last session removed req=%p\n", req);
 		xprt_free_allocation(req);
-		return;
 	}
+	xprt_put(xprt);
 }
 
 /*
@@ -339,7 +339,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
 		spin_unlock(&xprt->bc_pa_lock);
 		if (new) {
 			if (req != new)
-				xprt_free_bc_rqst(new);
+				xprt_free_allocation(new);
 			break;
 		} else if (req)
 			break;
@@ -368,6 +368,7 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 	set_bit(RPC_BC_PA_IN_USE, &req->rq_bc_pa_state);
 
 	dprintk("RPC:       add callback request to list\n");
+	xprt_get(xprt);
 	spin_lock(&bc_serv->sv_cb_lock);
 	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
 	wake_up(&bc_serv->sv_cb_waitq);
-- 
2.21.0

