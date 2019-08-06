Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EE835F1
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfHFPzY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43923 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPzY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so67351599oif.10;
        Tue, 06 Aug 2019 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R4iZx0COrHfQ1YO0z4V/oENEdXcG7j+Gflb0UFePd/k=;
        b=SOWAI7kWYER3fLmidQaUgow0X4fneNiL6OZJyV/9OLkxBEqw0/Kl6rNh17rgrkEy7l
         1u2ix7PasZJhH/Zaru8307TAG6bt6mnjJ4TIiVffVd+Sk4IwZnO1Vq2xsrKcbTvh6ZEU
         WgO8+jPCPMsG6XWPOw5biMdVoiXoJR+dijJSAvCpDa1AH+vPihryxHdXu+/zTmuQ9BZF
         bqvClpONSCXRjYda+EWIMnB+O1dQs/BbZf6stG3xdXfxR2i9NM482wD8emVbo+i0xES7
         Cf05i+0v/lPCYeegyQAQ7VXUVCTF0EjYsFiTxJqxuVp3Ex9ZkP+U7avmM6w8BuJ7su29
         67sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R4iZx0COrHfQ1YO0z4V/oENEdXcG7j+Gflb0UFePd/k=;
        b=PO3ttQ+81co3VuqxeN0dAAtZiGksO1IL24zNN5gKA9LGRtwYcJOrZ15lVxriX2EbzP
         u4a+yAbSs8hqd0SnUKtwTjD+nBPhsrj5GgzjGS+U5/aO9I64WpDs2KctRyEYqSjMKYGa
         /6O54RlNEa+KUnhquPQeqyWk2NTaTzWEa+yOtMDvrVyyxr5JenTKAnJOpMCy0z0PkDad
         LqyyfL3PAgG8ymDkNcBVXOrhkRL75cS7B3dKRYV5R2wCaY2mg64UQG97tTtTJuRSYJls
         rCZ31PpoJvKAK3piiSgB/01vlOWwLrX8V4jVbCTYx6WcrmnmDcLRpeiQQG+W4fe3rfww
         x+xA==
X-Gm-Message-State: APjAAAXlLweJdgEYhsGKoniLDoj6OK+C7NtHdvIOG7PCT2v5JaREKEVJ
        /Y79VI0awXUA92WVbAkncOO9uRgo
X-Google-Smtp-Source: APXvYqypW7oPGNDiTEPOmZFPfV55NcSDm8ju3LuO+SazAoV77Y/lUPdUJ/winVbw9O0+20UCje/3YQ==
X-Received: by 2002:a02:a703:: with SMTP id k3mr4860732jam.12.1565106923170;
        Tue, 06 Aug 2019 08:55:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k3sm468949ioq.18.2019.08.06.08.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:55:22 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FtMmu011565;
        Tue, 6 Aug 2019 15:55:22 GMT
Subject: [PATCH v1 18/18] xprtrdma: Optimize rpcrdma_post_recvs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:55:22 -0400
Message-ID: <20190806155521.9529.80398.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: In rpcrdma_post_recvs, since commit e340c2d6ef2a
("xprtrdma: Reduce the doorbell rate (Receive)"), the common case is
to return without doing anything. Found with perf.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4112b8a..36e840b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1457,7 +1457,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	count = 0;
 
 	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
-	if (ep->rep_receive_count > needed)
+	if (likely(ep->rep_receive_count > needed))
 		goto out;
 	needed -= ep->rep_receive_count;
 	if (!temp)

