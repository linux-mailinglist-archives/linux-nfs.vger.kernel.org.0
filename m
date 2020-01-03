Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AD12FAF2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgACQ5H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:57:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41128 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgACQ5G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:57:06 -0500
Received: by mail-yw1-f66.google.com with SMTP id l22so18749566ywc.8;
        Fri, 03 Jan 2020 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=do4XYB3cetSwSCpHsQwhYK9wBCxtcun36fD+roGwm0o=;
        b=aL416D7qAa6kasaUjy8jxOnm14XtSXL76EzyRBeMq66iggapMNyEELX0vZS/eHYTq/
         PpdsZzu4v63cGMhvETY/UKsT2YaFg7Qt64plUUGq1PQCmAdc4WEmaa2AUrY6wZ6ilH7e
         dwMWXpzpzxSTdNTWbMUwwRKwh3+Jfu2cxCNRpw6H9ffLww62iJRT8NkALLR6aXkh5M25
         KMSiCXLHkcE8AjqWzbhOyPSYgPi14BTKPeKPpr53lAAhJJ+yKgdoiAd0WPUGe0qJipIo
         3KcoKftjhus2FtmZ0ub45+KeGh/EdTiCZl8a1mwsg6gFo5xaTA5OAYRAFamXGshNFdVF
         rN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=do4XYB3cetSwSCpHsQwhYK9wBCxtcun36fD+roGwm0o=;
        b=acB53jTBV9yBYHP0eafq9iSNUAzHJVHszn3vpo3hA4UQMMrK2yMZse2ZjkO0uNoQVN
         0NJlRYYH1U3mNMolvpOTfFsfusY0gbH5ueU7NFbMGnMyuDyCAN/p+yvWrs5Cw1CsSGpe
         PKesVDTxVsJV8q5YrXEhYpP27/6XHLvQMi/WNoXBmOZ5D8NOFjvtE7+ri84t6r7HRKGx
         dDSeM/SWr0RU5fcEznDve5br/kiEPwijEk0MzD9HtBbA8m/NPpmutJ7kanxOw9cOGjtL
         mxf3DMROtUucKvqu/GOu2S0TBcjgSEQPnVA3UDCHFblnXb6mJHhcCeu4oF+pypRyIfa4
         JNiw==
X-Gm-Message-State: APjAAAWJEhRGkf0kFLunF3SH2HcxCmBgBuA/dArkDqzxn8Wpo+++7Q18
        1C+mUQO4JOzbsNnfJHZkun+hYZCu
X-Google-Smtp-Source: APXvYqzwEz1aBNgEg7xNWVfAj1TCRciP0DA7KomCVZA3/o6qi+8iGS80/nbcb7FxpfA8/6NZzU4yXA==
X-Received: by 2002:a81:9c14:: with SMTP id m20mr64492596ywa.143.1578070625398;
        Fri, 03 Jan 2020 08:57:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a23sm23502387ywa.32.2020.01.03.08.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:57:05 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003Gv4Hi016404;
        Fri, 3 Jan 2020 16:57:04 GMT
Subject: [PATCH v1 8/9] xprtrdma: Destroy reps from previous connection
 instance
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:57:04 -0500
Message-ID: <157807062412.4606.7516445302332824137.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To safely get rid of all rpcrdma_reps from a particular connection
instance, xprtrdma has to wait until each of those reps is finished
being used. A rep may be backing the rq_rcv_buf of an RPC that has
just completed, for example.

Since it is safe to invoke rpcrdma_rep_destroy() only in the Receive
completion handler, simply mark reps remaining in the rb_all_reps
list after the transport is drained. These will then be deleted as
rpcrdma_post_recvs pulls them off the rep free list.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 269df615a024..3169887f8547 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1173,8 +1173,10 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
-	list_for_each_entry(rep, &buf->rb_all_reps, rr_all)
+	list_for_each_entry(rep, &buf->rb_all_reps, rr_all) {
 		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
+		rep->rr_temp = true;
+	}
 }
 
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)


