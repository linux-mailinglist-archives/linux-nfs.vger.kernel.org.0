Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2517389B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgB1Noc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:44:32 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.33]:46861 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgB1Noc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:44:32 -0500
X-Greylist: delayed 1441 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 08:44:31 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 2F4C92ED332
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 07:20:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7fZ8jI9I6RP4z7fZ8jgYWM; Fri, 28 Feb 2020 07:20:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vHClNfI7Qt5b0uR7/2n+CnDKDelWTosbitfxyh2nN0A=; b=Q3cFP3w1ZSCtsPw8tSf3hEQPhI
        o4fh9MiD6FQJUJlfdY0vG3LSu7+32VHQB/fz/w5bxSB/8C09WWZfH21gVePxit9L5Usf28+Y5bGEZ
        lMO1R2VnPt5qIJXvuqCTMRUx0ADwvdUY3CMMTX9CuVHdSNFLYQZRMuzWgdCEg9VbBVIySUMOazeNa
        YxakP40SINiiWOkq7FzX14iMlwxp0lpnrnbdreiV85ox/wUzyv4QL7yyr3UXkLevaB2jICeseKwtT
        ZmUw+KK7iAuDFJHVut86Dx/ATtXag5JC+2PG6yWy6OOlRNk1oN6sCE1FznP2OmDZHzliX1bSyYuG8
        1e14WpSg==;
Received: from [201.162.240.44] (port=7869 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7fZ5-001Geq-SP; Fri, 28 Feb 2020 07:20:28 -0600
Date:   Fri, 28 Feb 2020 07:23:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] sunrpc: Replace zero-length array with flexible-array
 member
Message-ID: <20200228132323.GA20181@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.44
X-Source-L: No
X-Exim-ID: 1j7fZ5-001Geq-SP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.44]:7869
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1afe38eb33f7..7f0a83451bc0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -380,7 +380,7 @@ struct svc_deferred_req {
 	struct cache_deferred_req handle;
 	size_t			xprt_hlen;
 	int			argslen;
-	__be32			args[0];
+	__be32			args[];
 };
 
 struct svc_process_info {
-- 
2.25.0

