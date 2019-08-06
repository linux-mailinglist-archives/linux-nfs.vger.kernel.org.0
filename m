Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324D9835CD
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfHFPx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:53:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40484 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:53:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so36442948oth.7;
        Tue, 06 Aug 2019 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oumuLHmmSckdgQ9A4wG9ElG9WY8K/x8ZLGuJfFGEfss=;
        b=ACTCizmXX+sLwmV4uf4qm8fQKQlxvchoE+HqVXu3cMwNNzY9WZ9FwJDdQL09KfmRh2
         +qjYAbU6ZQR7GJRcdGQy0xe+w3Unr9elaDiPTEW5g2pBCYPhX3Ec452DEPgmGGh/lz1d
         fec3Lg22GOY62CLv+N2jcSrv9/XStTbizKWvJTqlij4Yo2oruy3Q8qqzmFSrahmKfIDX
         6FPgjnWKCHTaBsFHumEO4Zd+kMvczEL1D1nkClwbXaL9We6XJMcQFtdehExsI++T4Ell
         gzjKv/s5CdUILf0TsgY2nJ7LprKZSL9qpOFMcZciM86LGfO/Jc5l1Pco/hrLg033fKDr
         M7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=oumuLHmmSckdgQ9A4wG9ElG9WY8K/x8ZLGuJfFGEfss=;
        b=QqvuZXC47r84pjPQH6N1KnNE8lnzlND2XJ8flIcX9AWQ439yUjFIQBGSnHtXY+4DYd
         B0LAiScIoivNGnjJmIzzjIzcujjJqAl3RSNzkPZKEd/DPB3O+RYJO89++Vn4Pk5aILyh
         BoV9Q2jmDyuGKWfol9rS0NceDWgXvWcGDtsXhwGz0tK6NxdeFcrR+Js7yxWrkC99sKvO
         AjE49weYp6FQQEKxiLI6YhZGSOXaxKL8wDeflq2AtjfOVmbIqI89i7jgvqTEJZ74H5NM
         S4CA5H+8QPuzAtqqcL5tA/7l7JHhtehQfVq6efeGJqiidSNKVYIFD7x6HA2sncwMZX+2
         oY1A==
X-Gm-Message-State: APjAAAU6uSv8GaDZAePeLqO9sZwaUVq2VTK+PF+Pie4XuwRkoYLkeN9u
        paBNj8+JOa6F28G0V6lYHBwWfURf
X-Google-Smtp-Source: APXvYqyoRcT7jDv6ipBhdylHv//X5vzXkIY1kXyLXjpaPVRUg9Il9kY4nJ/QJc6REtx4dh6+t64BXg==
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr4046968ioi.217.1565106838452;
        Tue, 06 Aug 2019 08:53:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l5sm158453211ioq.83.2019.08.06.08.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:53:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FrvpT011517;
        Tue, 6 Aug 2019 15:53:57 GMT
Subject: [PATCH v1 02/18] xprtrdma: Fix calculation of ri_max_segs again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:53:57 -0400
Message-ID: <20190806155357.9529.18087.stgit@manet.1015granger.net>
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

Commit 302d3deb206 ("xprtrdma: Prevent inline overflow") added this
calculation back in 2016, but got it wrong. I tested only the lower
bound, which is why there is a max_t there. The upper bound should be
rounded up too.

Now, when using DIV_ROUND_UP, that takes care of the lower bound as
well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index a30f2ae..3a10bff 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -260,8 +260,8 @@ int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep)
 	ep->rep_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
 	ep->rep_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
-	ia->ri_max_segs = max_t(unsigned int, 1, RPCRDMA_MAX_DATA_SEGS /
-				ia->ri_max_frwr_depth);
+	ia->ri_max_segs =
+		DIV_ROUND_UP(RPCRDMA_MAX_DATA_SEGS, ia->ri_max_frwr_depth);
 	/* Reply chunks require segments for head and tail buffers */
 	ia->ri_max_segs += 2;
 	if (ia->ri_max_segs > RPCRDMA_MAX_HDR_SEGS)

