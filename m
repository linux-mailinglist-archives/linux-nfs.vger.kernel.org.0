Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8863D03E
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbfFKPIG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:06 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:38925 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389076AbfFKPIF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:05 -0400
Received: by mail-it1-f180.google.com with SMTP id j204so5286386ite.4;
        Tue, 11 Jun 2019 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=jQfbtUts6XSGb6gHuI1L9Vk82UkyVRMmpiQpvZXhlEgq+6xUNh/kb5SrZN6uZK7XAZ
         hIuc5+GmpgBE+6iWwVgTEbeT8EfoEeeGbKJejZrAdvG7Rzi5hlZSyBnfO4UW4Y4u6BFD
         ckk9hRI65Odo8SvjVMJ9s8mp1cPS0/lo6MuxT19yHYBNVvYuppJaOFdfXJwGqRkhbGoe
         0GplJS/0tqRiW1KzkxaevBGYvNDatA2eDrRa3D/5ce6ExzUZbZfcC+aLkpF6wmgBnxeU
         dd3S2qPyaTkmS9pFdc+iKKS00W8dqIEIcjsI4x1NhWis04vmu1Cr4x3krc5pKn09zLdI
         hGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=YQMacN5eFPRaC+VEu2ykFAXvBVDEqRG3hdA5Fmy9qsNtUDMd/WbzNw+8q2rlFzU6sG
         72YthKJ2G29YFq+o06/EuwDbzvE5YXvh14uV/RJnJ4D0Ye5JtA3SaRyscJMqwcbCdtJD
         arcECnyPA3wKY1Wle27YSwjsr4iyMQi8rdFNscgVXvJwz+b8nRKUDlremC2qZQ6H7nEh
         3jhStpSoD9NAze8F9x+M6fTFXJra0zk9LthwssoZNXSVYqv8mzOjzKoO7s2/Ppvrya/0
         ky5sCKwYJSv1pBz7FXs7i5/q7Z+W0MCHXr530Ql0kPAai730Kdy7QsNRobtIVArl9r8Y
         P/Mw==
X-Gm-Message-State: APjAAAX0195Pr2IC2BfyWeBMekX2SovX4bj9xGSs4LGaE1WIGs7iVEkq
        qCdzxMG1NnEVDRNs+Wsj59uKYZ+Y
X-Google-Smtp-Source: APXvYqzJQHsLZ/LPfHSrFRBnN72sSuq9j3eb0N3wSDv7M8AKQklNk6mhSUW1/JqLXvnFSlI3JJiNog==
X-Received: by 2002:a24:4a8b:: with SMTP id k133mr18511282itb.98.1560265684668;
        Tue, 11 Jun 2019 08:08:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r143sm2015233ita.0.2019.06.11.08.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:04 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF83j4021728;
        Tue, 11 Jun 2019 15:08:03 GMT
Subject: [PATCH v2 01/19] xprtrdma: Fix a BUG when tracing is enabled with
 NFSv4.1 on RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:03 -0400
Message-ID: <20190611150803.2877.78364.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A backchannel reply does not set task->tk_client.

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index df9851cb..f0678e3 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -559,7 +559,8 @@
 		const struct rpc_rqst *rqst = &req->rl_slot;
 
 		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->client_id = rqst->rq_task->tk_client ?
+				     rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->req = req;
 		__entry->num_sge = req->rl_sendctx->sc_wr.num_sge;
 		__entry->signaled = req->rl_sendctx->sc_wr.send_flags &

