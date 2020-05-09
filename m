Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85991CC39E
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2020 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEISHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 May 2020 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgEISHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 May 2020 14:07:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD58C061A0C
        for <linux-nfs@vger.kernel.org>; Sat,  9 May 2020 11:07:16 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so4435450qtu.8
        for <linux-nfs@vger.kernel.org>; Sat, 09 May 2020 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PLpNgI6NPoa9ofxmZ5ImM3R026fToUpVAHaI7CCPIT8=;
        b=HrCACWjvvrWOquXGvE16taH/HYI65rjN8gskAvzQPM5/mnYjw3T3SX5YCxNEaNMt6E
         5BmUgha0DgWz0C0kL8tZtwfWaWVwCJhkn4mTrCc6kqGxw4zRULSq4mL7C02eHmPb13J5
         kh4VsBEGzKh9moBG5TuD6Hmjes1RMt5kA7HfoO9kuaBxAV5kZ5x96BoOjW065yNqCG+F
         tnKbhtOwramFsGS5/BPNl0kz6RaTgAZIQopAEN39/LiEGrqd+gqa3AGis5dNXgqttklS
         vrTSDBuzo57z3VPxMING9TbmFWbH/g+3tYCPuX8EVWBodqMj+I7586TG24crNRKz/jiC
         MHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PLpNgI6NPoa9ofxmZ5ImM3R026fToUpVAHaI7CCPIT8=;
        b=JKTv9V+II5e5L1Q1qxDO+UKZqOrhQSu2Y5aCgw72HR1PF/ijGkSU4ux82aM0O3BBGw
         yYeDClJKV21c3wtA+aTcSM3uj+UiXQOiykgC8KQMB+3UiehzolhVAcixbdOo1JnMahuO
         85Er3LpwMYr4hhcw7mzKml2U7CPnAhwefYzAG2aBLCW6WNkOzRjjCHrDCaw76mcDmP+/
         btbJgUAcEVz0Ek2AAzmc0lkuuCMw3/Fgi1rHEmbFvXV7IYTNHQHq56JOfYfBixphjkBM
         uOYxYfB3RZRKj2j2BqR9CjvwwVmQZeIE0763zTrElZyW+baJsMIplXPyXIiNZSbaiJsK
         Fbzg==
X-Gm-Message-State: AGi0PuYm9ZcLRXCu6PNn1sBfJMBm9K0JhSkRJSTTsFMGTpnu3g2rUDI+
        L2p8Pc+eId/AQZ62iGfXyi3sU2VG
X-Google-Smtp-Source: APiQypKGXVt5rFaU9gMKlQHYbFtnbhfD1SA12Fmhz7fL6aDtvjwr8LNOB0I1+o4Og5YfoKr6eyt1aA==
X-Received: by 2002:ac8:3406:: with SMTP id u6mr9267507qtb.100.1589047636036;
        Sat, 09 May 2020 11:07:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h188sm4138940qke.82.2020.05.09.11.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2020 11:07:15 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 049I7Dgo023566;
        Sat, 9 May 2020 18:07:13 GMT
Subject: [PATCH RFC] SUNRPC: Signalled ASYNC tasks need to exit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 09 May 2020 14:07:13 -0400
Message-ID: <20200509180609.5185.37691.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that signalled ASYNC rpc_tasks exit immediately instead of
spinning until a timeout (or forever).

To avoid checking for the signal flag on every scheduler iteration,
the check is instead introduced in the client's finite state
machine.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 22d7e0a8694b..1b628b6aa172 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2430,6 +2430,11 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
+	if (RPC_SIGNALLED(task)) {
+		rpc_call_rpcerror(task, -ERESTARTSYS);
+		return;
+	}
+
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
 

