Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CCB0E8B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfILMGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 08:06:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40769 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILMGh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 08:06:37 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so53781870iof.7
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dXWAStlMSQv9OSmQPKw8qPt6Fgo1E+MiUZj9GCes4LA=;
        b=iCBBBaN3x909az4qMPc/gVpclz/AHc/aD6Ibc4hhd+wb2A6EDbpzckaI0Shq2ftZs/
         1Ol+2c2VDP5XXxiekuC3NWl0obNwWKkIHwqOoBsmXh/tHu7PmKZsCon5NJ/HYbvbjHXF
         ggqekBkmEGpxI7pHFEbvYoxB38JT6dTVqWvPjLH/zAvsv8OLBvYt9eIj3retfwIsGLKx
         CwUEir0z9hCkqcdaFd2Xi7g3P0yw/0wiqikMH5ecIA7saIXMp2+3CeIE7aywKMlKztqr
         6dFPq/iFqOYE3qASiLL1capszrceG+6mjVstJp7hWpW8GhSLwHEhfhJjU4/Hhi8kKyuW
         1PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dXWAStlMSQv9OSmQPKw8qPt6Fgo1E+MiUZj9GCes4LA=;
        b=W7Xt0JkxX7yKLYEsmqO14UbUpeDh10TuYOkjKoqR+KNiSJtJCxtbSGpXtsE12CYQRE
         netxpkuD1PBtTMJpf982ctHrLcujzgCfawIzIuBt4oH+Dtaal73ZjnuOPctIA4ZfUtrF
         qiDDL3oypcgNEIaCqrrljFAUx8IrdOnjux/3R364BzYcIV7RUydgRFIMqjdzEde4wegt
         rDvcg8Oc4CUch6taFdjhyUvob6vImVPfkkQpIGjSvVTwacUV03tkIKgOio/t5QV0eEKe
         hSxga8C0TQ8oLgu/CK6nexaGiz9ZLF8DlKR2dkQHhoJ63PykY293y8xCgJo5D3R6UL5Z
         fDPQ==
X-Gm-Message-State: APjAAAXshn0Xn2HhKTVnlidZorCvfzjSe0sKxE6iotqYwLepB3fsWg//
        FimcZRuF2oPq6L0uLJWr9A==
X-Google-Smtp-Source: APXvYqwO8pklk1jzMoKm4i63NPLacB4mv1YJZXjI1+qXMNM47w1nSKZxQgm74q92a7abWV1VpOcyXg==
X-Received: by 2002:a5e:8307:: with SMTP id x7mr4122628iom.257.1568289995089;
        Thu, 12 Sep 2019 05:06:35 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id d20sm19963920ioh.2.2019.09.12.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 05:06:34 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Don't receive TCP data into a request buffer that has been reset
Date:   Thu, 12 Sep 2019 08:04:25 -0400
Message-Id: <20190912120425.11199-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we've removed the request from the receive list, and have added
it back after resetting the request receive buffer, then we should
only receive message data if it is a new reply (i.e. if
transport->recv.copied is zero).

Fixes: 277e4ab7d530b ("SUNRPC: Simplify TCP receive code by switching...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e2176c167a57..9ac88722fa83 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -562,10 +562,14 @@ xs_read_stream_call(struct sock_xprt *transport, struct msghdr *msg, int flags)
 		printk(KERN_WARNING "Callback slot table overflowed\n");
 		return -ESHUTDOWN;
 	}
+	if (transport->recv.copied && !req->rq_private_buf.len)
+		return -ESHUTDOWN;
 
 	ret = xs_read_stream_request(transport, msg, flags, req);
 	if (msg->msg_flags & (MSG_EOR|MSG_TRUNC))
 		xprt_complete_bc_request(req, transport->recv.copied);
+	else
+		req->rq_private_buf.len = transport->recv.copied;
 
 	return ret;
 }
@@ -587,7 +591,7 @@ xs_read_stream_reply(struct sock_xprt *transport, struct msghdr *msg, int flags)
 	/* Look up and lock the request corresponding to the given XID */
 	spin_lock(&xprt->queue_lock);
 	req = xprt_lookup_rqst(xprt, transport->recv.xid);
-	if (!req) {
+	if (!req || (transport->recv.copied && !req->rq_private_buf.len)) {
 		msg->msg_flags |= MSG_TRUNC;
 		goto out;
 	}
@@ -599,6 +603,8 @@ xs_read_stream_reply(struct sock_xprt *transport, struct msghdr *msg, int flags)
 	spin_lock(&xprt->queue_lock);
 	if (msg->msg_flags & (MSG_EOR|MSG_TRUNC))
 		xprt_complete_rqst(req->rq_task, transport->recv.copied);
+	else
+		req->rq_private_buf.len = transport->recv.copied;
 	xprt_unpin_rqst(req);
 out:
 	spin_unlock(&xprt->queue_lock);
-- 
2.21.0

