Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78BD10ED28
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2019 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLBQ2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Dec 2019 11:28:49 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45145 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLBQ2t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Dec 2019 11:28:49 -0500
Received: by mail-yw1-f68.google.com with SMTP id d12so1093431ywl.12;
        Mon, 02 Dec 2019 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1KMF89ftAC0pRgaGlDtXn05bQOnIkD3TExE/eWsb9wc=;
        b=e25RtPl3HW25pK8+g3gg1ukJIsvLP6akRp0ao9tjWVVWlSKXlxOLstsnd76Tocrdnf
         hksXYtpweOWt11ZchBVRzDbu/u/NyqwNNzZjCDJxBGSJ86SLjKVwp/iCoipLX9J0jM5E
         bwgcx+4DU4oU3QNSj4t6qE+kjGIliQOqYAJT2JseUq38OIsaCJ6NVA1X1ZauCuOS2P+x
         x404KUdVbTDk27Q5b7h6cl0Cs43aW6hcePNFhxdMUgWX3LY7lxxRUmf+pQO4muSi4DYN
         F4DBPJm0yilrgIY97dGE6pJAMcydO8sRsOn9eNVFWRJbJ/wsxnvoU1GfBWuMuhHRY2UG
         q7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1KMF89ftAC0pRgaGlDtXn05bQOnIkD3TExE/eWsb9wc=;
        b=nhnnIVg5dq6SAoQ7Z5FRb1zlI9OnB8wif6yOjiXgK7uCkHxZQriC1vE9qpMz3+puCO
         ZeZJjPhNyZMlOrAeQY38pT4QYcHmTvjPo2g34mPi9+PK0+OJh+WVtvurSUPVRcRnsCIl
         j4pFNIaXXC2YxGHubXym5Ig3wIZaxvm3wa+F2fBeMe4bX4HdM+kbtSqqGLpilZgpYM+b
         OefA7C3LEycjU3nd3z3ZmCvNRWFWzUGxtU70J/g2ycj2cfINdc9Sgj/puyxUuadatYMe
         Ll+2vUVnTVqsUyWSU6fzXOyJRcKqhOsapelr0VG8rM/O28hLCaCcD5EZ4FQNzu0ANEoe
         n5CQ==
X-Gm-Message-State: APjAAAWZSRzOg0l5fdBoo1DtXw5QQi7hKdI/coKFHG3nwexzzOt18kYQ
        UvraS6fNYZQa5AXF7fBxvwTsfBwf
X-Google-Smtp-Source: APXvYqxYqeQmFdx5f0sk2cZnfBtQRF7EmhBh0LI5ZgGN4rzjDGARfoT+yVhVzVdadrczbOvkCWMogw==
X-Received: by 2002:a0d:e107:: with SMTP id k7mr23717024ywe.399.1575304126754;
        Mon, 02 Dec 2019 08:28:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c188sm40326ywb.56.2019.12.02.08.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:28:46 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GSiJS014264;
        Mon, 2 Dec 2019 16:28:44 GMT
Subject: [PATCH 2/2] xprtrdma: Fix completion wait during device removal
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:28:44 -0500
Message-ID: <20191202162844.4115.30993.stgit@manet.1015granger.net>
In-Reply-To: <20191202162242.4115.94732.stgit@manet.1015granger.net>
References: <20191202162242.4115.94732.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've found that on occasion, "rmmod <dev>" will hang while if an NFS
is under load.

Ensure that ri_remove_done is initialized only just before the
transport is woken up to force a close. This avoids the completion
possibly getting initialized again while the CM event handler is
waiting for a wake-up.

Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from under an NFS mount")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3a56458e8c05..2c40465a19e1 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,6 +244,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 			ia->ri_id->device->name,
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
 #endif
+		init_completion(&ia->ri_remove_done);
 		set_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags);
 		ep->rep_connected = -ENODEV;
 		xprt_force_disconnect(xprt);
@@ -297,7 +298,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	int rc;
 
 	init_completion(&ia->ri_done);
-	init_completion(&ia->ri_remove_done);
 
 	id = rdma_create_id(xprt->rx_xprt.xprt_net, rpcrdma_cm_event_handler,
 			    xprt, RDMA_PS_TCP, IB_QPT_RC);

