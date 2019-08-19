Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A135950EA
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHSWjr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:39:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34968 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfHSWjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:39:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id g17so3236793otl.2;
        Mon, 19 Aug 2019 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bTFse4JKhV2BT/xERQHbbHpDOri/QkVxMmcYVlM2Efk=;
        b=XI455noKSKIgemwRKoRycfSkEoM4J7nMXYJ9p5+5yJpAwcX3SKbJ24ExvCwhqVUfAO
         Jy9cYq8XiRoo8p18MgtoB4zbupl9ZYoUVn+EHLLLOO6fsB/p47ZlYdN2HL8YrKzPNWR0
         VzNJIdcC2i+ZhRMmrINjLOFPFaa/pdoBAv9PqRTVWENQUFWXEmslO5JACuo7laJMAmcm
         NqqKRc2wTDlAqg8YqqBJlo3BAnDDBU4vJxJ14UFTNDKewVrZijFfPB3gsKtR8kxwa0Bn
         qknly/ku7n3EkbTF6uaYbNqgF/hKA5XK8C5gT4R98goYQTNH5MkHobJQHHlxoshp5Bi/
         vUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bTFse4JKhV2BT/xERQHbbHpDOri/QkVxMmcYVlM2Efk=;
        b=FTHV659YciLfftPY7Ms7y1FsgkiJtykiyPT1gPwCVlVPkQzZSmziZOETwAI+7gm7s7
         5b12h6JQGTjb9allof67/UJNmawJ1mE9DrxH3c+eH7LOk/V2JZJs6krBNTddkUJOr7UL
         O9evrdOW+iMdG6BO6IN3oY9NDXXQ9A74nFhkct3mrZuaQfKN8XCXz/4W44bsOBs+HLjM
         rmjGkt612ekmXTUUrNMl58KsRqfF0/FVlS0sy8DIrwEyGz4hdE+wGk6a7dRSHqhovxrA
         LNmZG3QpybcAXj5frg6mowLMQCkqhN1tMqTvV7aD5idViJbDkY2+elM9/wdI4kAwtTD6
         6eFg==
X-Gm-Message-State: APjAAAWIPwibiim89BfbVrPfh+hdPK4K+/1M6H2uIUy7NeelHSlZMQ5l
        hiOTpSP3iT9Eah6OyMYY9p+GqWON
X-Google-Smtp-Source: APXvYqzQ/FQcsGkbOOOKmkRElcP6WzfbaTVWChLnmzP16JdCSJ9A15K4e4SXLAP7UuVk+RuQdCPiUA==
X-Received: by 2002:a9d:6854:: with SMTP id c20mr14348094oto.120.1566254386384;
        Mon, 19 Aug 2019 15:39:46 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id w139sm5094055oiw.0.2019.08.19.15.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:39:46 -0700 (PDT)
Subject: [PATCH v2 05/21] xprtrdma: Fix calculation of ri_max_segs again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:39:25 -0400
Message-ID: <156625434505.8161.16198361086528272640.stgit@seurat29.1015granger.net>
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
index a30f2ae49578..3a10bfff2125 100644
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

