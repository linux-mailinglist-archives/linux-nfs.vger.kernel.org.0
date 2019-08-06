Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C737835DB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfHFPy1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35465 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPy1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so17025471otq.2;
        Tue, 06 Aug 2019 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UWMhZ7FDwHIPga5aDO4bpscbeQkan5+u+btHf5zzbAw=;
        b=Yj9JgjZIHKj18vwfQylQFXRPU6WlmZ6xMcRUOB45mVcd5N6G+XXSZ0Q2zi3GRJTlfu
         H81iFvRwllY3RZID6YMeBqm/pW1MmRrWufjVHC/A5D7aLRFR+foC9iNjdJ2xpOn+Ywbb
         AM/h9MzSYDhZo7yWq8snTUib1N9WIYnDy3TuHfZqcYn85/oOJXhm0v1A3xaa8uDHU8xx
         vpxFtL1bR6NKuqvsqDNDaY0OLXbsLvl5LYcibdM2ptF7aj5KtYam4BRXgUwavB5rj6h1
         NT55avOD1tuKY6k2g18O2slFCa72xZOfhdFbDv51DgJTSpX4zcrrxBle0N8BBiIb61cu
         EA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UWMhZ7FDwHIPga5aDO4bpscbeQkan5+u+btHf5zzbAw=;
        b=S9qOEq9m/6Nq6t8njWB6BE73RzsiXGkwuYr1Cs3cVoXTXXuM9RQTjHCossAN12kCX7
         WnjUgFDDkXpkwBuCPBugOZAw4DLknXRmlPgu9HAAcRgFkfgK1PucfTgc7kUKGpraWw+O
         IQcUjZhFo8Mu6YpHVaEs8FEp8boi3CLKLAoYXuLha91f7hbEHN7B/9v4TyzVSTOFMZHd
         zVNpDZDnhmIfi1eltwhvAOs8QfxqaxVwaRZPDZJcjTJNBKgjescN8KjEFMLwFhqUHHQm
         qmH2W3+QTnkylo0jPleF5MBxEnsOE0imoTXExKl9o1N+nr2xSQDp7MoO3mtgcMIXgrDP
         72iQ==
X-Gm-Message-State: APjAAAVhaZwj37+kUrQCpYLgwNcOdE2fuu1NzEs4guosbnlGlB06LRUj
        IoTQWJDbtwpcxNDLO6O2DxW3esoF
X-Google-Smtp-Source: APXvYqxCaBowDfzGThZjvFDgDoxz9FEG419g3Bd6UZEg3xLij8fT/Y8klagwHOQTmP/6nz77QioMTA==
X-Received: by 2002:a5d:8e16:: with SMTP id e22mr4285066iod.171.1565106865147;
        Tue, 06 Aug 2019 08:54:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b8sm71102714ioj.16.2019.08.06.08.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:24 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsNmM011532;
        Tue, 6 Aug 2019 15:54:23 GMT
Subject: [PATCH v1 07/18] xprtrdma: Toggle XPRT_CONGESTED in xprtrdma's slot
 methods
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:23 -0400
Message-ID: <20190806155423.9529.54483.stgit@manet.1015granger.net>
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
index 2ec349e..f4763e8 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -571,6 +571,7 @@ static void xprt_rdma_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 	return;
 
 out_sleep:
+	set_bit(XPRT_CONGESTED, &xprt->state);
 	rpc_sleep_on(&xprt->backlog, task, NULL);
 	task->tk_status = -EAGAIN;
 }
@@ -589,7 +590,8 @@ static void xprt_rdma_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 
 	memset(rqst, 0, sizeof(*rqst));
 	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	rpc_wake_up_next(&xprt->backlog);
+	if (unlikely(!rpc_wake_up_next(&xprt->backlog)))
+		clear_bit(XPRT_CONGESTED, &xprt->state);
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,

