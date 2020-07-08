Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC38F219128
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHUJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHUJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE787C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k18so5261443qtm.10
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RMWz6mn9uzBS5WoNb8KCSjfxCulz3r904mY7bu74EnU=;
        b=HeRvcsrCO09iIZKoGPGvIhSEiXL1UHc5j/Pxsa2O/c5Opez1JoPA/rd6Hae6vNa4th
         VXy5gKb82/VXj0RjIkyfcMG6cBkIEtwiMzhhiX3XISc4aFVD9MO26AdK/IB0fFMy356F
         S04ubTiKwolZas4wAIDPKKvjJQU9lM08k0UmUwHaiY0fomopy6vbcDqUrg3mnBN46S+x
         bIxqiurq18gLoLP/YCvIyLtJ9MtfLnqEiE73xJwR8C1bvie9v4rHxzp8okXtZxoNO642
         bRwqCdnm99cUdx9yyEUgc447kPj56mjtO7sgTqTUtJzavpG3yCOQeYcEVat67EJCaEm6
         95Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RMWz6mn9uzBS5WoNb8KCSjfxCulz3r904mY7bu74EnU=;
        b=nID0kiPHFu5pEJN+u3PW4QNtOpIjlDz3NdlE8SM0f0gFA0R62+e9KBvFJAXUvmNMDa
         dY16cSeI8OHNtMrwYe3phDPPzrY8Pav10WtIo194qCgk74VAICwgkBCfy4XogkAMI/0N
         dTGI4sEi7qHRmDAQfex/Lo5pKpIVi3FnD2w/EfmxNX0ikB7f2Ee338/XPFCBPcqHrSAN
         C7dwkC+9koAo0Haqo+uWUzoeSBBwsS42vbjjPKuNLm6VuyG6Gj8DznNieilrZIx4cMVh
         3Jyh0gMwAn6DG+NDR9IizSimWr6GXMebylgbc8xyM89h8v6QvWBqlmtwusVrVO9bDxjS
         VuiA==
X-Gm-Message-State: AOAM530o+tcMHpsnSLu9V/otxHL+gAs49rc/hx426HhP+f9M3NEtObps
        UG2Jqk5zf1HLCop/V83p2/vcsDWs
X-Google-Smtp-Source: ABdhPJyqUHHoV+QZT+CLw1aijDhRNOP3O8OTreHy4hUv2KVteZoiZOQakjmbNLU8kl1OrOxPGT/MIg==
X-Received: by 2002:ac8:7ca7:: with SMTP id z7mr61940559qtv.275.1594238946836;
        Wed, 08 Jul 2020 13:09:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y12sm826190qto.87.2020.07.08.13.09.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K95ew006066
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:05 GMT
Subject: [PATCH v1 01/22] SUNRPC: Remove trace_xprt_complete_rqst()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:05 -0400
Message-ID: <20200708200905.22129.40143.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Request completion is already recorded by an "rpc_task_wakeup
queue=xprt_pending" trace record. A subsequent rpc_xdr_recvfrom
trace record shows the number of bytes received.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/xprt.c             |    2 --
 2 files changed, 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 6a12935b8b14..2a43ed40b7e3 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -969,7 +969,6 @@ DECLARE_EVENT_CLASS(rpc_xprt_event,
 
 DEFINE_RPC_XPRT_EVENT(timer);
 DEFINE_RPC_XPRT_EVENT(lookup_rqst);
-DEFINE_RPC_XPRT_EVENT(complete_rqst);
 
 TRACE_EVENT(xprt_transmit,
 	TP_PROTO(
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d5cc5db9dbf3..09bf7bf94adc 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1122,8 +1122,6 @@ void xprt_complete_rqst(struct rpc_task *task, int copied)
 	struct rpc_rqst *req = task->tk_rqstp;
 	struct rpc_xprt *xprt = req->rq_xprt;
 
-	trace_xprt_complete_rqst(xprt, req->rq_xid, copied);
-
 	xprt->stat.recvs++;
 
 	req->rq_private_buf.len = copied;

