Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C6202B40
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2020 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgFUO7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Jun 2020 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgFUO7j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Jun 2020 10:59:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8DC061794;
        Sun, 21 Jun 2020 07:59:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l188so358126qkf.10;
        Sun, 21 Jun 2020 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AI+XwSIrjxiPwArk1egrpcmul8nmBInRkhXDyTlJZ48=;
        b=E9qE/+BS+cuW3iPQoO3O4EaP/XvldbAj+96CMiF1bzqZsHHrRkxr98CA8CJ9gO+FiR
         k2s7k1f66hL5EeRl2RjTfJOvqzMkKAplOzguKyD6NxpJx6FGrmr5NQxDrABE34x7BIHT
         1gJJt+rM2pRR9nncSzrZXkjYj6/enid2HF5XcF4dhHSHxgBssTJYX44HmE8ff14Y9V8n
         jTx6wD0UYTLdDGRCyh4XIXG+FinSj5cpztLFsbAgccuDp5LBjNSftd/eFafjleO5vgMn
         +lwf+7h9JnjDAGi2LJlrQyl/GbUoKuO6iKSy1qA93SN9jnCtTbmAJUler/bBd3Ayh0jb
         CB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AI+XwSIrjxiPwArk1egrpcmul8nmBInRkhXDyTlJZ48=;
        b=do+KpLIlZRhstGyNQRe8Zh0tEJhPNNjvshOQP+O7KN1fLTeXyMGtphBFO/Z1Kn2uFi
         IIRV/m6ah+bRqsdj7F+Wl7KEJ8rM4ma6kPEpoxQGfJekS6fW4rCd+QM2CfPQcxSSwz12
         OpJrdGaqHWozKH0nVLh3818QGdWqOlCkuPRLMyaFeNsbEOr22LcGft0MjsgQ2crpfbf6
         bWNImPsW2c8r4mxXy2xcr+7z8DTWKp51Cb3XwUmPPFfRPQXke2Hw6wLYEKJqxWWHkLJh
         1fJuj3aVVf4DhRzcX/UdR+XFYZ3YqP1pTrSiuShcFcMir+lTxGR20iRmZSxzhqIHtcOC
         gquA==
X-Gm-Message-State: AOAM5322G9ziQZKyOazMxbd54x4Fgr3A5uoQkWuNaV4mLjfVNWmtBsSU
        a23/VZzBgpcakcjcGTDjl+A=
X-Google-Smtp-Source: ABdhPJyEfk/9iHCtiiRvuKWSudQiOi3+BWwVYEIRIEOyRoj5d6MCSEuPsO4RPbrcWCh98VFz2cV+wg==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr11863661qkj.456.1592751576677;
        Sun, 21 Jun 2020 07:59:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g13sm11425192qki.95.2020.06.21.07.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 07:59:36 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05LExY53014413;
        Sun, 21 Jun 2020 14:59:35 GMT
Subject: [PATCH] xprtrdma: Ensure connect worker is awoken after connect
 error
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 21 Jun 2020 10:59:34 -0400
Message-ID: <20200621145934.4069.31886.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Dan Aloni <dan@kernelim.com>

The connect worker sleeps waiting for either successful connection
establishment or an error. Commit e28ce90083f0 ("xprtrdma: kmalloc
rpcrdma_ep separate from rpcrdma_xprt") mistakenly removed the
wake-up in cases when connection establishment fails.

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Dan Aloni <dan@kernelim.com>
[ cel: rebased on recent fixes to 5.8-rc; patch description rewritten ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2198c8ec8dff..54c6809bf06e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -296,6 +296,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		rpcrdma_force_disconnect(ep);
+		wake_up_all(&ep->re_connect_wait);
 		return rpcrdma_ep_put(ep);
 	default:
 		break;

