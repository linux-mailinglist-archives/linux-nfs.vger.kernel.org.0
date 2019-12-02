Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2550A10ED26
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2019 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLBQ2m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Dec 2019 11:28:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44904 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLBQ2m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Dec 2019 11:28:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so1466890ywc.11;
        Mon, 02 Dec 2019 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lx2ByXRb2E6HSft0879G0aUxzQETJaxyjGgs2Ax3D8Y=;
        b=ZbuXnmgkzdbEsTQ7AMRSky6WRhbyvBp7A9IG/pDEPyPDw3t5FSI7PUoNll1MzvxDN0
         PzBxCzGLQx5F4k7JZjYJjWGzxrxhE/TDSud4cGmtqk0Qk8Azegx7wlc8+OMpKDm2AJiJ
         U32RSFMsIuBcgf2bEfT3ShXuznK8DA8iZ8TCkEcjONqK/Tj/UuMy3b3k/TZqpy+/kcrp
         Q0ig6yIMSJebby4mgGrPJNeLZbwvAp2C9O8+FodNueosUS9+2/AurlKU+qITZWCLM5+R
         2xFdA4t7NBSH/6RI7aGMyi6iYKOIVJ8K1ocf0nBwtxucyOvkpQWSBnM37Q4tb55OQ0nP
         i3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lx2ByXRb2E6HSft0879G0aUxzQETJaxyjGgs2Ax3D8Y=;
        b=CLBNKDSG9uIomqFmwfkvnY4jumgHC+ClRlLqzQ8Os51Q5bMDdKmiyqfjk+yJgfj1VL
         jCQvN+/SrATjbQZAYuXSvJ7RrNTrAlQgD/B7weEFq+C5hdIOlMJbQEqg/Kc3n1t1mjeC
         Q+Em+vVPYvZfgNbXttlKzdCDn5k6elsE9+JvZjjdxr2rijSpABwUf6ICIsFJm+nrzHo7
         LiBwQfbb1Pi6ttDxf+yFCG60EgEMdvpmzc+EvCmyewhuDZyMWV60yGWbFf7RrHJ6bNi4
         Q2keI2LsWznNGKs39PV+PCwIlXhOFpThiZW6mApsS/2SCbEt0z2AvGZdHlMbLbeaGfGF
         jK9w==
X-Gm-Message-State: APjAAAWggEwj01lSKx3NsRUOrEEneML/6LtyhndQ1PAIu3xmwX+V48bR
        sCtC7NJkAfwqdB8xwQSEebA=
X-Google-Smtp-Source: APXvYqyOirV4Xfl65Q0mRFxwmS6HGwskGAy4LruWI2PuQXNyWPAvhx76zoJHLAnhO4AxrkOMyYxNgQ==
X-Received: by 2002:a81:3c88:: with SMTP id j130mr2355783ywa.113.1575304121372;
        Mon, 02 Dec 2019 08:28:41 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n129sm34724ywb.75.2019.12.02.08.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:28:40 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GSdeq014261;
        Mon, 2 Dec 2019 16:28:39 GMT
Subject: [PATCH 1/2] xprtrdma: Fix create_qp crash on device unload
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:28:39 -0500
Message-ID: <20191202162839.4115.10995.stgit@manet.1015granger.net>
In-Reply-To: <20191202162242.4115.94732.stgit@manet.1015granger.net>
References: <20191202162242.4115.94732.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
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

