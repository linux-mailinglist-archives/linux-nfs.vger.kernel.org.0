Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D3B19E157
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDCXOM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 19:14:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41715 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCXOM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 19:14:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so7961770qtv.8
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ysbWFJcfmL3+nQsZbWs1ie6jge4MPDhQwiHd9EV9YsM=;
        b=il9am/ERPkA35XdmgyiT2pFr2YO8YZPKFogC4jZkPqd9d4U1+UojXi5iKx/Ije/MbO
         TEkX+3HQoU2NxnUqXXXmRcHdP9V2tS1eC3Im6/uiswoY7mfqT0qmXmJp0htQSvBGLtn0
         q3k2GRPt6grtrFCJ+/XwmKrdfGraVQas2aWh+rnNbJKLU7XweXw81c+ho5ErZ1SC9i8U
         qhlOBs1pZOETkfTheG7gx7HfpCrSS9DBTNB2Bzb8YPW4CoCwsMUj5CpPu/PG8TP+3Gig
         DDyFtrmtnvC4FQLenaWzMenUlKYrWo/ozHw6qxlbusnmuKLPwirDjRE3YlqPQnopcwg3
         UvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ysbWFJcfmL3+nQsZbWs1ie6jge4MPDhQwiHd9EV9YsM=;
        b=YmvsZtXoVJFYxOplYfkV+uH4CAmWQokZzNquKjDoFj6RCprfWEKxu8/58zLwdiUsTH
         PcqAkoQQQtK09WuQNdtsG8u3n+nLNhk3QNrYtBD23c3coUFKrx6xTKIWeKdIRYda/bPU
         uj1NhRQLmPRlgWiKQJ9sPA4MypkmWiByfKlasJK5TahccwIzsg+hLhTwjhRzFhgfb+mN
         Aa7XAaVac6quF0oBbg0DnXUZjSZUZHWRSjmVzlKzXrr/hm1CecLulkz8WgxkWTBEKVV1
         lzshUPnie6jZapYgDy1LrGC863svrKR5m4M6+0TqMIhWVYFKAv4Oocbnzwa8r1v8ck9B
         2i2w==
X-Gm-Message-State: AGi0Pua9QzyEfnNkgcEMeImypIDS8ljb8W9llBxQsccAhjXdXAePbr4N
        5sXZwUrNUQEVCEsJvCTufWHltjGD
X-Google-Smtp-Source: APiQypKhETC5t/W403HRPW5pI135HoksQQFU9rZOcQ/1fYxUrhOR89MheIvWvFIYx4dzmG+2Pee1JQ==
X-Received: by 2002:aed:3169:: with SMTP id 96mr4889767qtg.141.1585955650607;
        Fri, 03 Apr 2020 16:14:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y127sm7647187qkb.76.2020.04.03.16.14.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 16:14:09 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 033NE81E029955
        for <linux-nfs@vger.kernel.org>; Fri, 3 Apr 2020 23:14:08 GMT
Subject: [PATCH v2] SUNRPC: Backchannel RPCs don't fail when the transport
 disconnects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Apr 2020 19:14:08 -0400
Message-ID: <20200403231352.2371.88778.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-7-g1113
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, when the forward channel conneciton goes away,
backchannel operations are causing hard loops on the server because
call_transmit_status's SOFTCONN logic ignores ENOTCONN and the
backchannel Call is repeatedly retried.

Backchannel Calls instead should use RPC_TASK_NOCONNECT rather than
RPC_TASK_SOFTCONN. If there is no forward connection, the server
side is not capable of establishing a connection back to the client,
thus that backchannel request should fail before the server attempts
to send it. Commit 58255a4e3ce5 ("NFSD: NFSv4 callback client should
use RPC_TASK_SOFTCONN") was merged several years before
RPC_TASK_NOCONNECT was available.

Note that for NFSv4.0, a callback request on a broken connection will
fail quickly, and the server should invoke nfsd4_process_cb_update()
to establish a fresh callback channel.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 58255a4e3ce5 ("NFSD: NFSv4 callback client should use RPC_TASK_SOFTCONN")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Here's the one-liner, just for the sake of argument.

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c3b11a715082..e87e16b65463 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1340,7 +1340,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	}
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
-	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
+	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | RPC_TASK_NOCONNECT,
 			cb->cb_ops ? &nfsd4_cb_ops : &nfsd4_cb_probe_ops, cb);
 }
 

