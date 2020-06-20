Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923CF202594
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 19:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgFTRTP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 13:19:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTRTO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Jun 2020 13:19:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id b6so12606266wrs.11
        for <linux-nfs@vger.kernel.org>; Sat, 20 Jun 2020 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2k3vIU9c+LdwXojoMKQGH+WFL/QVe2uY1qAr2lifYk=;
        b=rgXQ5z11fb1M8RfnQ+KmpWjmoLRC9XaSKf0d85gK9y6pusXXFP4d0NiCBy1Xh0Cuof
         B8Sf9ivHaWlVhrW6jCHQZvGem+kYBwR7xz22TaQQMBgZSLZU99jYxz7aVnf9UplftUj5
         ZvYcH2Eknr2eW9khksEb2QND+vifOnU71BdgbHYAK1XcRkA0ZFn5qzXNrYZNhhZzXwXS
         1MtFOWB41jlMA2a7MWOFNcd1CSga9EFLM6DDL0oH/eZXi2/zqEGpJngoqbk9pj3l6K7x
         5Xr7qfJl3XoYksDVVaU9l47zuJYwhufykXYekQnQ8L0Q5ceC3GfdAkO8/prSkg2UebOr
         DLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G2k3vIU9c+LdwXojoMKQGH+WFL/QVe2uY1qAr2lifYk=;
        b=tHWG0ZtOxPiAja6UQJgsVyF+cj1Y9XfkaKnWzPRY1bj7mR3SJLMk7ufeWsojWD1FGQ
         8i5N83zlaFlBuW5+NelFrqFIIsjH+cYZExem7DVj5UoSHy2Sj6zmjiLXTgSYQAHDDXWL
         jt21s0GcJ17iDfHn9H8Cya9eEG2FV1xr2SMpRMH4C6/uvCcyyTQwOvrq2z58oK59PIWL
         4BVKvThjVGKTySiScZEG+zOqypx0fxJdje004EE5K7t86wmlC8STRPhOEjzXQm8cZuFX
         bTdDpGzOoADZK/atcvWr9TUZzGdyD3DCzWZ0BLka0W7WHu1erIoXph0zcFMEKvZ2w4h1
         tZAg==
X-Gm-Message-State: AOAM5302chWQm43f8cfMr8eNnyyN+c79My1RxeARwMKPqykNG/SO0kNy
        TIQCi3uxITqetEGX/A1U/WfQOw==
X-Google-Smtp-Source: ABdhPJyidO21nR/04RYkzohY6xrpoo3CcglCIkjIqiQkqKfJ4FIUKQhTuzygxJdkwbj9urYGpUTQYQ==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr9941989wro.30.1592673491513;
        Sat, 20 Jun 2020 10:18:11 -0700 (PDT)
Received: from jupiter.home.aloni.org ([141.226.9.235])
        by smtp.gmail.com with ESMTPSA id p16sm12286218wru.27.2020.06.20.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 10:18:11 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] xprtrdma: Wake up re_connect_wait on disconnect
Date:   Sat, 20 Jun 2020 20:18:05 +0300
Message-Id: <20200620171805.1748399-1-dan@kernelim.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Given that rpcrdma_xprt_connect() happens from workqueue context, on cases where
connections don't succeeds, something needs to wake it up. In my case, this has
been observed when the CM callback received `RDMA_CM_EVENT_REJECTED`, and
`rpcrdma_xprt_connect()` slept forever.

This continues the fix in commit 58bd6656f808 ('xprtrdma: Restore wake-up-all to
rpcrdma_cm_event_handler()').

Signed-off-by: Dan Aloni <dan@kernelim.com>
CC: Chuck Lever <chuck.lever@oracle.com>
---

Notes:
    Hi Chuck,
    
    Maybe I missd something, as it is not clear to me how otherwise (without this
    patch), re_connect_wait can be woken up in this situation. Please explain?

 net/sunrpc/xprtrdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2ae348377806..8bd76a47a91f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -289,6 +289,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		xprt_force_disconnect(xprt);
+		wake_up_all(&ep->re_connect_wait);
 		return rpcrdma_ep_destroy(ep);
 	default:
 		break;
-- 
2.25.4

