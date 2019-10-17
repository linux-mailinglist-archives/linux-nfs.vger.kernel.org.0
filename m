Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2979BDADCC
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbfJQNFw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 09:05:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39269 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJQNFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 09:05:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so1762077qki.6
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6BJ8UZmgpM+F3+lerDf1X37Zaq/sfSN3TB0kwtETXD4=;
        b=ZVYnWn4668stuOWg1A+AxWo2Hh+h0UpL+nyMyty9C+66/WJA7JBFAAng4ACfQRmNAo
         HGSXz2iVJMW1Q3nPlsuLljZECZTFVB3f+FX9md4/WRnFYsvFG+TMb0rdLXwSA/dLJx4o
         ZIgXxA4fHebJ0TqyEbHaiXExk6cOVsBdym4FLnyj+EBb745rSCj2jZcf9Z0lc/M8xmoc
         ZanA0Xr+ANhYO8ST5Kqp6wby4Yi3UoZ5+xqt+oVqK85M7bspA8IG+Svx7l/nO8xujiKr
         Usah0z47eSl+DMOcxTwbpr7K7CnwbBAYaxjzaO/5ThkjekE8yhc3xiMdr0kjwSYTtkxf
         /cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BJ8UZmgpM+F3+lerDf1X37Zaq/sfSN3TB0kwtETXD4=;
        b=YRq11n0kCt7uz4HUnZh9BY4P1wzlC6j6/8P/i0/ryPSFTKsPgREpOGENdLd/M3GN+4
         VRU4J9K/UcW1IOdHKMSslg5gDRKTQ/9F+CY/TznKe9OgsGEUWumNM2JlmLZ+/4FCSbnR
         4jKr3Gk6J8v4xXWC71ERujvr1OBRBXLeoqPLsV2IC7Hx1XnMRTcmOBg8T1I8e9TwOJxI
         glKioFGSdaoBzGBJ3q8F6x6ONUVzP+0i9vU79b19bJ9U6jQBLnTPk8WXg9i73hb94ExC
         gBq8IbrNQKQKWtrO+a+pSYnX6gFDiYaU42iJWWENX6wfX7CrQfVC/GbkhtXCLw2PqQUB
         KJlw==
X-Gm-Message-State: APjAAAUtjRnOXuNXp8xQOsx3RZ6DzYL5tr7LIzgiTXsUI2MXITjjSnyy
        DH6yvZHcDuqZui8L9G0uwsNO3VE=
X-Google-Smtp-Source: APXvYqyKp9OMJaLljXzlitz66+QyqnDeqdz0NzzUEcM4hxLOPAmVzzWrl5EExnerC3B6UZ0aKALSLw==
X-Received: by 2002:a37:507:: with SMTP id 7mr3193100qkf.107.1571317550957;
        Thu, 17 Oct 2019 06:05:50 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g194sm1326648qke.46.2019.10.17.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:05:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v2 1/3] SUNRPC: The TCP back channel mustn't disappear while requests are outstanding
Date:   Thu, 17 Oct 2019 09:02:19 -0400
Message-Id: <20191017130221.7924-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017130221.7924-1-trond.myklebust@hammerspace.com>
References: <20191017130221.7924-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If there are TCP back channel requests being processed by the
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

