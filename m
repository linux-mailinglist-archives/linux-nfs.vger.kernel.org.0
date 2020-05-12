Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B361D0067
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgELVM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELVM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:12:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663BC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:12:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s186so13394170qkd.4
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AhcdYE40tHfZYDkvbctVBwWHvI/JJL8NOpiqSq0yGdA=;
        b=dRro5o7EPSZqTRepcnTEo3X2v2/AniVRbbp47yL2cX9VHoCvl5KPWHtM8xD73+lrXd
         hJTTFOhyymxTPLQfPJUNU5STzF2VhgXeAeMziTzm1H7xjf2MmZuMCDx/2zyVRX4khhh4
         v7paOVXsQMHrCLJQKIVWMLRhM5aoVacCV7ydSHIWFoSYFKqElrGfMZJEktgwwdt3tBEO
         LLntM8iFtfzKG6JR3dqnRe/sYHN2NH0DblYtCup6C418b5GRYVXezYHbG+bTogkVlDDY
         lE9APlh/Uy5eb/v3fneehRcWz50wjABt5nxCjsp4Yjau7SxpLNGpfYp+jlfHmzfTdl0q
         6SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AhcdYE40tHfZYDkvbctVBwWHvI/JJL8NOpiqSq0yGdA=;
        b=kzCPB2odbgEa4YJUBlWSP/siPA/D1ImY8TLz8ZBj3C3EsALMAsX7FZrmO/xG0pPXV2
         nBPvp/nwZNlr7C3jeADxfZqGFusk+4iiMswSMxIxDiJf0+8ey1rHZ6NaurBlh3nmSQZL
         T8bWmy7FPV7NjXnRKoSwR09wOt+WRFRMZ+4KNmy4vbBbzOJwh2w57C2+N39VHlIZsTrL
         aQ5diq1Uw1Nn+JEb72kpFcrVAALBruQ11tMKAiCbETjoCMTmljSNZqxznjWTa2CbJ0nX
         xpiRn+k1zScaC3gQQPgmJiDShOLwk5f/imI3kyBpTlVxi48zHEb8wnYMKZdap6+4oHEf
         tAWg==
X-Gm-Message-State: AGi0PuZl+r49/cY3Bo/gBbqSAT94BhqFLdfN4rdJSu8O2tKPSqchrRWd
        fhGGmrjv2PbpR1C7KMWuT159+sUT
X-Google-Smtp-Source: APiQypKqns6EE4lIUS8TT4CJtcu3gLvltNwoJ0+8ZaZGb01mJ0yDwpcRfyNe73A6T/ncJcvd7tMb/w==
X-Received: by 2002:a37:96c4:: with SMTP id y187mr23342969qkd.126.1589317978244;
        Tue, 12 May 2020 14:12:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a16sm11863120qko.92.2020.05.12.14.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:12:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLCuJF009786;
        Tue, 12 May 2020 21:12:56 GMT
Subject: [PATCH v1 01/15] SUNRPC: Signalled ASYNC tasks need to exit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:12:56 -0400
Message-ID: <20200512211256.3288.57171.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
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
the check is instead introduced into the client's finite state
machine.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8350d3a2e9a7..456e64ca14bc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2433,6 +2433,11 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
+	if (RPC_SIGNALLED(task)) {
+		rpc_call_rpcerror(task, -ERESTARTSYS);
+		return;
+	}
+
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
 

