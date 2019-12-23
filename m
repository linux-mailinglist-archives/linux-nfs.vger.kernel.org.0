Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8A129838
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2019 16:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWP2a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Dec 2019 10:28:30 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35856 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLWP2a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Dec 2019 10:28:30 -0500
Received: by mail-yb1-f194.google.com with SMTP id w126so5266698yba.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2019 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=T7F6czYRIpqG5UN+LaWDPcuvGw88vepT7p+4yFZ2tTs=;
        b=ZDh2F31pU7S+jx91JBkvQfC796x3DhcjbCPrFm0vaLubWMMcLkoV14WvXTRPBe/jxL
         GfOuUSh3rMBLNuvTW5Bci40Xc0+36g76GiQTMn6zhcKqPIIMtyRrLS+L1BimxTrUe9mb
         IPKC5R5l3no58riud+bfF+JCXe8qanh3mkrJtPxJ2A9HMELTr0bnT7QeI8I9UE3YcKfy
         V4HE7XVrMRQ0X45nxasTbUZb+7DKdOHVadUrx/QnlhyaQek0y3uqAS+qlj2J/5z1HVZY
         6d1kPMVywovTKxSmy8jrO9mAFIleon+3kgLlOkmiWHpcrZVWIxGNKfHIHnD0u8rcn+ly
         falA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=T7F6czYRIpqG5UN+LaWDPcuvGw88vepT7p+4yFZ2tTs=;
        b=jqPijh1YGqkHtP0KhC72Og9BzMOMZIsOCwfltJUnypArHSHezneptir5nJqkSmloNi
         /PEaBS4oUjGUhQfH12alw+Pe1JLFNzOpZX7YLMhjNGdL5DsoaUs9pwL/wHFEjKQ+lb5j
         geOkvn9Rxqb8AR0JYtaN1ErgAv0rGzUuFL5Ub9Up5909x9mzsAO8V3vp3tksotBWkqdf
         9+FWpeIyC20yePxoHPeo85hX6X5EPeJYv6aor7U+eW4nyxpzxFRQP5Rb2m0pBKs1+8EP
         6U4tDuKNkduBAhKhdnFMeg04CS2p26kIRYdSjv7Ty1Vzs7cEASXKNaiKCNgy+/SW9dMt
         Pvmg==
X-Gm-Message-State: APjAAAXMFenAYfqygmicQABiG/iP5URpzK3GtUAraXuNr2LQqKfjsAdJ
        p2oFK0DIfAqxgnfsyLxmYxQi0cBT
X-Google-Smtp-Source: APXvYqzSIdaJRlOMpK1ccumu3rPG+iFmJzxTWQFt1RyO2PESVggGW+ogF1An4yWmZ9HFrSTEBBygnA==
X-Received: by 2002:a25:f20d:: with SMTP id i13mr20763768ybe.162.1577114909572;
        Mon, 23 Dec 2019 07:28:29 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c66sm8060347ywf.96.2019.12.23.07.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:28:29 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBNFSSZU008877;
        Mon, 23 Dec 2019 15:28:28 GMT
Subject: [PATCH v1 1/4] SUNRPC: Capture signalled RPC tasks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Dec 2019 10:28:28 -0500
Message-ID: <20191223152828.17724.72543.stgit@manet.1015granger.net>
In-Reply-To: <20191223152539.17724.52438.stgit@manet.1015granger.net>
References: <20191223152539.17724.52438.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/sched.c            |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 8c73ffb5f7fd..ee993575d2fa 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -185,6 +185,7 @@
 DEFINE_RPC_RUNNING_EVENT(begin);
 DEFINE_RPC_RUNNING_EVENT(run_action);
 DEFINE_RPC_RUNNING_EVENT(complete);
+DEFINE_RPC_RUNNING_EVENT(signalled);
 DEFINE_RPC_RUNNING_EVENT(end);
 
 DECLARE_EVENT_CLASS(rpc_task_queued,
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9c79548c6847..55e900255b0c 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -846,6 +846,8 @@ void rpc_signal_task(struct rpc_task *task)
 
 	if (!RPC_IS_ACTIVATED(task))
 		return;
+
+	trace_rpc_task_signalled(task, task->tk_action);
 	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
 	smp_mb__after_atomic();
 	queue = READ_ONCE(task->tk_waitqueue);
@@ -949,7 +951,7 @@ static void __rpc_execute(struct rpc_task *task)
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-			dprintk("RPC: %5u got signal\n", task->tk_pid);
+			trace_rpc_task_signalled(task, task->tk_action);
 			set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
 			task->tk_rpc_status = -ERESTARTSYS;
 			rpc_exit(task, -ERESTARTSYS);

