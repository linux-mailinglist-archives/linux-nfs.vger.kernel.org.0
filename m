Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39414521D7D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiEJPJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbiEJPIv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 11:08:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F102EA12
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:38:36 -0700 (PDT)
Date:   Tue, 10 May 2022 16:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652193515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31g7eWk4xretou/XK6zSe6TCkpbduM7/BuIMQUtcTPg=;
        b=oGtm+JfktPGDamyu9p5FJpUdfEfImJJwoVd57Hgr+6KBqL4ZoQr6OOGdvLMZZKD8iKDPiU
        hs3dO2Nx+/1qMvWXw7nb0jhfuNibdS1ww/F8444niQ+vz24lyfqZFc27JdnXnVwSjRcsL9
        G2zNdG7VndmgzYjubWV7eg9ai9CW5SBCwWkzke54d2tNoVlPYeIEMYo/7iKh5Lq8hNFrDw
        E9ov8i6ljuGJZ2rjEcRevjVmV3LPlISyueFxX7Paf4ZowdQU/JlsTB6612B/3q+4wy/D7W
        4dOijX7lwe9keeME8FafXyJnZ7Ui10BXHkviRnMMY9V4aFOU0mc/f7IMtlMjkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652193515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31g7eWk4xretou/XK6zSe6TCkpbduM7/BuIMQUtcTPg=;
        b=vFClhc3QuSHPv7ID348d7OdTXSgL3rO+FmNVnlqFjszQ6sDbqZGhFT3JQnFbS5xAXlgFjX
        J7jnlLTrw05hZbBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH v2] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Message-ID: <Ynp46bc5Rt54skl8@linutronix.de>
References: <YnK2ujabd2+oCrT/@linutronix.de>
 <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
 <YnpURpp14qNi7TnI@linutronix.de>
 <73B0E604-D839-4F66-A19C-2C2B4CD57DEA@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <73B0E604-D839-4F66-A19C-2C2B4CD57DEA@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_xprt_enqueue() disables preemption via get_cpu() and then asks
for a pool of a specific CPU (current) via svc_pool_for_cpu().
While preemption is disabled, svc_xprt_enqueue() acquires
svc_pool::sp_lock with bottom-halfs disabled, which can sleep on
PREEMPT_RT.

Disabling preemption is not required here. The pool is protected with a
lock so the following list access is safe even cross-CPU. The following
iteration through svc_pool::sp_all_threads is under RCU-readlock and
remaining operations within the loop are atomic and do not rely on
disabled-preemption.

Use raw_smp_processor_id() as the argument for the requested CPU in
svc_pool_for_cpu().

Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
   - Reword the first part of the commit message as per Chuck Lever III.

 net/sunrpc/svc_xprt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5b59e2103526e..79965deec5b12 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -448,7 +448,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 {
 	struct svc_pool *pool;
 	struct svc_rqst	*rqstp =3D NULL;
-	int cpu;
=20
 	if (!svc_xprt_ready(xprt))
 		return;
@@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
 		return;
=20
-	cpu =3D get_cpu();
-	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
+	pool =3D svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());
=20
 	atomic_long_inc(&pool->sp_stats.packets);
=20
@@ -485,7 +483,6 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	rqstp =3D NULL;
 out_unlock:
 	rcu_read_unlock();
-	put_cpu();
 	trace_svc_xprt_enqueue(xprt, rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
--=20
2.36.0

