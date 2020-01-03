Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4F12FAD2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgACQwO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:52:14 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38875 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQwO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:52:14 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so18746477ywv.5
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lx2ByXRb2E6HSft0879G0aUxzQETJaxyjGgs2Ax3D8Y=;
        b=RWASNqSp452XjftnMpTEHLWK/UXIsYOWAczclNA4+xSAJ97yyvst2pQUpICp4lkbpY
         2y5q6dB+CAtMh/HjNKMes5Au5Eu0ZINymzAhEQ/tf2dA0z+jS2LjgC+dBKnIsH7u/z1v
         RbXwXUPv4nIYL9XO0gxZD/EDZkx95vXnTtUyyJ0KCFz2JBKwC3tOZqUly/Z0ABeAztm8
         Xv62ZKvBVH7FIvLNjXCHSB3wniYOO1PvGpzKlgETRVmpjwMif+yZQgD7+hF+QiynStvi
         xtJf+Rcf72BYPEBXQCE53ygejxr0WkEfVMt72qRsUulwZjteLM5WVkMAkaX16+dZeguT
         6/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lx2ByXRb2E6HSft0879G0aUxzQETJaxyjGgs2Ax3D8Y=;
        b=qrqhaN59AawqUGeV/8ctWumg4V9ibYZUYrYuSfAVXnogHE29RrVFcwTaTMndJA9BIP
         mkGpVoI05Vyo/ZAVIDG6jZryineONwdkIEux0uHUcogSBLQiHw6DrZyzR1lixq7q5By8
         NcDQN3AR1jHVPOPHq8vV2gN/3bS3HQvfFgkRPypxAx/Y+Jn87kqw6NPoTzRixjsd48WA
         tPm/HBsLsyzSpZ0Dcl3yupIgURj0jD9Ucbt0WOo/q5W01Kw+7FFCwQqNihPe8ILSP4Vc
         EoNBHbKoOFf+E8xBet7qwzaUVmEy0BmxE0k2nbbIQr5aj163MtoCPW+mmTzTpzmbCU93
         iQGg==
X-Gm-Message-State: APjAAAVyrPFxXTBt4WMoKq53l5QcjMHE/naMrqkIt38UKgw+WqradA0H
        N0SV7J/RtPEAq1wIjVGDfjudWCjK
X-Google-Smtp-Source: APXvYqyQPbxk73awJP2lDE7y/nbon+cWitTWwiTeERy+JK0JOU6HVwAQWcEmxzypz6bCIoioPdS7QQ==
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr64758107ywe.33.1578070333541;
        Fri, 03 Jan 2020 08:52:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v38sm24520114ywh.63.2020.01.03.08.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:52:13 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GqC6H016369;
        Fri, 3 Jan 2020 16:52:12 GMT
Subject: [PATCH 1/3] xprtrdma: Fix create_qp crash on device unload
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:52:12 -0500
Message-ID: <157807033222.3637.2110603095451994959.stgit@morisot.1015granger.net>
In-Reply-To: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
References: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On device re-insertion, the RDMA device driver crashes trying to set
up a new QP:

Nov 27 16:32:06 manet kernel: BUG: kernel NULL pointer dereference, address: 00000000000001c0
Nov 27 16:32:06 manet kernel: #PF: supervisor write access in kernel mode
Nov 27 16:32:06 manet kernel: #PF: error_code(0x0002) - not-present page
Nov 27 16:32:06 manet kernel: PGD 0 P4D 0
Nov 27 16:32:06 manet kernel: Oops: 0002 [#1] SMP
Nov 27 16:32:06 manet kernel: CPU: 1 PID: 345 Comm: kworker/u28:0 Tainted: G        W         5.4.0 #852
Nov 27 16:32:06 manet kernel: Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
Nov 27 16:32:06 manet kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
Nov 27 16:32:06 manet kernel: RIP: 0010:atomic_try_cmpxchg+0x2/0x12
Nov 27 16:32:06 manet kernel: Code: ff ff 48 8b 04 24 5a c3 c6 07 00 0f 1f 40 00 c3 31 c0 48 81 ff 08 09 68 81 72 0c 31 c0 48 81 ff 83 0c 68 81 0f 92 c0 c3 8b 06 <f0> 0f b1 17 0f 94 c2 84 d2 75 02 89 06 88 d0 c3 53 ba 01 00 00 00
Nov 27 16:32:06 manet kernel: RSP: 0018:ffffc900035abbf0 EFLAGS: 00010046
Nov 27 16:32:06 manet kernel: RAX: 0000000000000000 RBX: 00000000000001c0 RCX: 0000000000000000
Nov 27 16:32:06 manet kernel: RDX: 0000000000000001 RSI: ffffc900035abbfc RDI: 00000000000001c0
Nov 27 16:32:06 manet kernel: RBP: ffffc900035abde0 R08: 000000000000000e R09: ffffffffffffc000
Nov 27 16:32:06 manet kernel: R10: 0000000000000000 R11: 000000000002e800 R12: ffff88886169d9f8
Nov 27 16:32:06 manet kernel: R13: ffff88886169d9f4 R14: 0000000000000246 R15: 0000000000000000
Nov 27 16:32:06 manet kernel: FS:  0000000000000000(0000) GS:ffff88846fa40000(0000) knlGS:0000000000000000
Nov 27 16:32:06 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 27 16:32:06 manet kernel: CR2: 00000000000001c0 CR3: 0000000002009006 CR4: 00000000001606e0
Nov 27 16:32:06 manet kernel: Call Trace:
Nov 27 16:32:06 manet kernel: do_raw_spin_lock+0x2f/0x5a
Nov 27 16:32:06 manet kernel: create_qp_common.isra.47+0x856/0xadf [mlx4_ib]
Nov 27 16:32:06 manet kernel: ? slab_post_alloc_hook.isra.60+0xa/0x1a
Nov 27 16:32:06 manet kernel: ? __kmalloc+0x125/0x139
Nov 27 16:32:06 manet kernel: mlx4_ib_create_qp+0x57f/0x972 [mlx4_ib]

The fix is to copy the qp_init_attr struct that was just created by
rpcrdma_ep_create() instead of using the one from the previous
connection instance.

Fixes: 98ef77d1aaa7 ("xprtrdma: Send Queue size grows after a reconnect")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 77c7dd7f05e8..3a56458e8c05 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -599,6 +599,7 @@ static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
 				    struct ib_qp_init_attr *qp_init_attr)
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc, err;
 
 	trace_xprtrdma_reinsert(r_xprt);
@@ -613,6 +614,7 @@ static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
 		pr_err("rpcrdma: rpcrdma_ep_create returned %d\n", err);
 		goto out2;
 	}
+	memcpy(qp_init_attr, &ep->rep_attr, sizeof(*qp_init_attr));
 
 	rc = -ENETUNREACH;
 	err = rdma_create_qp(ia->ri_id, ia->ri_pd, qp_init_attr);


