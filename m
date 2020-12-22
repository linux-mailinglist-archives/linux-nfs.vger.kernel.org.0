Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307932E03DD
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Dec 2020 02:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLVBau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Dec 2020 20:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBau (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Dec 2020 20:30:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E78C0613D6;
        Mon, 21 Dec 2020 17:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SPEekCUlP5EepqS+NpFPHTDRZT4zd4fy5R0X1xpQKM4=; b=nxNlGHkczLSJQ45OJVGvdVZcT1
        MWRDtfafbeRUw/E5c/8KpyEtiHZLMf30YxuTvyI9uAP1E29pXyfQW1LXMi7V8brUcojnZDnRyUGst
        G5+ywPKEFLnOM2paJ4OaiPRuyi7cuV5VPDLBCgDvHY5V8oU8XUq8sTE6UYPcDrhqBk49VDym9emjI
        vUGEd9/GGy/wEm6huJIJG62lxS0qYR5PPnK1Eiyg+vJFixZdu391PwTXw59R/rv1obT7Ud72EBEI3
        6sszmeutQ9kalvOt3vKOy55WyOL5+2MOOWzmWdDXki6FKZ+SrkQaWLdpE0hsqNciNk6QGv0HoY9US
        1jSIQDIw==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krWV0-0002zB-17; Tue, 22 Dec 2020 01:30:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        syzbot+ba2e91df8f74809417fa@syzkaller.appspotmail.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH] SUNRPC: xprt: prevent shift-out-of-bounds
Date:   Mon, 21 Dec 2020 17:29:54 -0800
Message-Id: <20201222012954.28713-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prevent a UBSAN shift-out-of-bounds warning:

UBSAN: shift-out-of-bounds in net/sunrpc/xprt.c:658:14
shift exponent 536871232 is too large for 64-bit type 'long unsigned int'

If to_exponential is true and to_retries is >= BITS_PER_LONG,
this will cause an invalid shift value when calculating the
new majortimeo value.
In this case, when to_retries >= BITS_PER_LONG, cap (new local) retry
at BITS_PER_LONG - 1 and continue.

Fixes: da953063bdce ("SUNRPC: Start the first major timeout calculation at task creation")
Link: https://syzkaller.appspot.com/bug?extid=ba2e91df8f74809417fa
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: syzbot+ba2e91df8f74809417fa@syzkaller.appspotmail.com
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
---
a shortcut if desired: (also drop local 'retry' & change it back to
				'to->to_retries')
		if (to->to_retries >= BITS_PER_LONG)
			goto set_maxval;
...
set_maxval:
 		majortimeo = to->to_maxval;

 net/sunrpc/xprt.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- lnx-510.orig/net/sunrpc/xprt.c
+++ lnx-510/net/sunrpc/xprt.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 
 #include <linux/types.h>
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/net.h>
@@ -593,10 +594,15 @@ static unsigned long xprt_calc_majortime
 	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
 	unsigned long majortimeo = req->rq_timeout;
 
-	if (to->to_exponential)
-		majortimeo <<= to->to_retries;
-	else
+	if (to->to_exponential) {
+		unsigned int retry = to->to_retries;
+
+		if (retry >= BITS_PER_LONG)
+			retry = BITS_PER_LONG - 1;
+		majortimeo <<= retry;
+	} else {
 		majortimeo += to->to_increment * to->to_retries;
+	}
 	if (majortimeo > to->to_maxval || majortimeo == 0)
 		majortimeo = to->to_maxval;
 	return majortimeo;
