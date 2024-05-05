Return-Path: <linux-nfs+bounces-3158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925078BC06A
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D5B1C20A6F
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F5F9F5;
	Sun,  5 May 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="Uh3FW+WB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A1A21
	for <linux-nfs@vger.kernel.org>; Sun,  5 May 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714913356; cv=none; b=t53Orqiv5g5uWQKzD4duuyfqVHXWkLD6f6YI4O59+a/8Q2+kpv+acqMXnPvcyt4/YHF7j7nP9dKXaVB8IMd3492oyBTtyvE1EidtZ3FNChQhnBaAdMgSpq5q8sEKWszzZ5anRqnshSb3hkBsR+Zzbn7CzvGv1IlX632hsvkchTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714913356; c=relaxed/simple;
	bh=40U5uCr6HFxty6rnp8cn6SOsTTy7HZkcXwiDH7gOqQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=riN/elL1mu0CQB+eYzClO9G708lL/URc9Ji89Fqx5evSboxG3olmS1J3UNehLs3yDhqaZzb5w9gW6TdfYl0erc8W3UpMMk/nmyOa7d+Ybr6o7HV4yqWCw/40dBThQlbCF2CczDBrejLQwCBM5Nnd+c7cgV9tnacscfJxHqt4WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=Uh3FW+WB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso5449345e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 05 May 2024 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714913352; x=1715518152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdeAMf5sz4+i5RMeVeVaG55G2J6u11a1J/yv9xEhKLc=;
        b=Uh3FW+WBVdslDKfVhmrMEg1zL9p2c89XYNjVFXbBcM148GFQw5zR1jSoyHM88cnGll
         7E3xLaW9SsYkOyK5Tta5z7Akw5koBA/XH/TPsfSerseOv4+Xi53PCC0XhbKJLIDzzPBk
         IzpD4hEVz4QB4Up6vMZckmH9An/2PQ3ZeEXK8x6WRdWe3AGAtUiK2u5iSwuGDPY4qi/w
         2NorKQTFAKZU8Iosroj/vhO5tFsbyYiXj1uz4z1gfMoGwqg8SNMomlZw1zptM9oDQkj+
         Pgjtoohyir7GjQyoQH2Q5kTcVgG0FiKYCMSU8Pnl0qvSvbz6n5gfM7J0J55zCz6ZYQts
         BFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714913352; x=1715518152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdeAMf5sz4+i5RMeVeVaG55G2J6u11a1J/yv9xEhKLc=;
        b=bwXFvr5XhV95mLyCOUxvR6BzI9l8+ygVtCNwrx5g0fKLgkD9X/Kqnf2MyCO4UgTixg
         wr8j4ECFQNN58fpbtqno1IfC9TNBkhTyg+r85UYVDNyNXoIIjNKzyoNRDxzS3Fa5pi79
         NS5PLDBAVQx6EJjCxQQmk89h6nNYvlGwMp05OfVYxM82tdW9DyHWpA9UEcyhhTi2m3jt
         b1Ex14ZEMUuz+KJSq5CbsfigNmF+5i0mY2eP7jFkwkAwD56HeSDNuP6J5+f89+P9RX7C
         Ov948xeh479B9vsRxQEBl9O9fSD+i3zHssMs/EI2kplmao74GfIimWn8IRjfi4SvEYK0
         0gdA==
X-Gm-Message-State: AOJu0YzdSmoNCLlXq8QXuCHCrSotPAXzWTXWldzCIAefujIc4SB/99Al
	Tgik+tVuzZKBJhcRuIGHq5Ev8bOB0NA4rPlS58Z4Wzr0Sv5xppMNOuI56p3RdcvkO724usqd0QR
	M
X-Google-Smtp-Source: AGHT+IFshZ93QCM7w0Mnhl1enwvJJxVIE0r7X10CqpOEIzNfzxJqbdpTXWmTYaN3dwIySo9ZS+f0Cw==
X-Received: by 2002:a05:600c:4f87:b0:41b:f30a:4221 with SMTP id n7-20020a05600c4f8700b0041bf30a4221mr9716104wmq.15.1714913352251;
        Sun, 05 May 2024 05:49:12 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b00418db9e4228sm12481315wmb.29.2024.05.05.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 05:49:11 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Date: Sun,  5 May 2024 15:49:10 +0300
Message-Id: <20240505124910.1877325-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found a case where `RDMA_CM_EVENT_DEVICE_REMOVAL` causes a refcount
underflow.

The specific scenario that caused this to happen is IB device bonding,
when bringing down one of the ports, or all ports. The situation is not
just a print - it also causes a non-recoverable state it is not even
possible to complete the disconnect and shut it down the mount,
requiring a reboot, suggesting that tear-down is also incomplete in this
state.

The trivial fix seems to work as such - if we did not receive a
`RDMA_CM_EVENT_ESTABLISHED`, we should not decref the EP, otherwise
`rpcrdma_xprt_drain` kills the EP prematurely in from the context of
`rpcrdma_xprt_disconnect`.

Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')

Example crash:

rpcrdma: removing device mlx5_3 for 172.21.208.2:20049
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 60 PID: 19700 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
Modules linked in: mst_pciconf(OE) nfsv3(OE) nfs_acl(OE) rpcsec_gss_krb5(OE) auth_rpcgss(OE) nfsv4(OE) dns_resolver rpcrdma(OE) nfs(OE) lockd(OE) grace compat_nfs_ssc(OE) snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore uio_pci_generic uio vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_>
isst_if_mmio mei isst_if_common i2c_smbus intel_pch_thermal intel_vsec ipmi_msghandler acpi_power_meter xfs libcrc32c mlx5_ib(OE) ib_uverbs(OE) ib_core(OE) sd_mod t10_pi sg mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ahci libahci drm crct10dif_pclmul mlx>
CPU: 60 PID: 19700 Comm: kworker/u132:4 Kdump: loaded Tainted: G        W  OE    --------  ---  5.14.0-284.11.1.el9_2.x86_64 #1
Hardware name: Dell Inc. PowerEdge C6520/0TY3YW, BIOS 1.8.2 09/14/2022
Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
RIP: 0010:refcount_warn_saturate+0xba/0x110
Code: 01 01 e8 27 e1 56 00 0f 0b c3 cc cc cc cc 80 3d b8 29 9b 01 00 75 85 48 c7 c7 38 ec 04 93 c6 05 a8 29 9b 01 01 e8 04 e1 56 00 <0f> 0b c3 cc cc cc cc 80 3d 93 29 9b 01 00 0f 85 5e ff ff ff 48 c7
RSP: 0018:ff34fa4968cafe10 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ff1210404a15e000 RCX: 0000000000000027
RDX: ff12103f803998a8 RSI: 0000000000000001 RDI: ff12103f803998a0
RBP: ff1210404a15e648 R08: 0000000000000000 R09: 00000000ffff7fff
R10: ff34fa4968cafcb0 R11: ffffffff939e9608 R12: 0000000000000000
R13: dead000000000122 R14: dead000000000100 R15: ff1210404a15e928
FS:  0000000000000000(0000) GS:ff12103f80380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f170f8a5000 CR3: 00000001c3adc002 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
rpcrdma_ep_put+0x42/0x50 [rpcrdma]
rpcrdma_xprt_disconnect+0x303/0x3b0 [rpcrdma]
xprt_rdma_connect_worker+0xc8/0xd0 [rpcrdma]
process_one_work+0x1e5/0x3c0
? rescuer_thread+0x3a0/0x3a0
worker_thread+0x50/0x3b0
? rescuer_thread+0x3a0/0x3a0
kthread+0xd6/0x100
? kthread_complete_and_exit+0x20/0x20
ret_from_fork+0x1f/0x30
</TASK>

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c     | 5 ++++-
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f8d7efa469f..19996515da94 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -250,6 +250,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		rpcrdma_ep_get(ep);
+               ep->re_connect_ref = true;
 		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(ep, &event->param.conn);
 		trace_xprtrdma_inline_thresh(ep);
@@ -272,7 +273,9 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		rpcrdma_force_disconnect(ep);
-		return rpcrdma_ep_put(ep);
+		if (ep->re_connect_ref)
+			return rpcrdma_ep_put(ep);
+		return 0;
 	default:
 		break;
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index da409450dfc0..1553ef69a844 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -84,6 +84,7 @@ struct rpcrdma_ep {
 	unsigned int		re_max_inline_recv;
 	int			re_async_rc;
 	int			re_connect_status;
+	bool			re_connect_ref;
 	atomic_t		re_receiving;
 	atomic_t		re_force_disconnect;
 	struct ib_qp_init_attr	re_attr;
-- 
2.39.3


