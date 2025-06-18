Return-Path: <linux-nfs+bounces-12551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16411ADE954
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D823189EF42
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8B2853E0;
	Wed, 18 Jun 2025 10:43:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F343ABC;
	Wed, 18 Jun 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243392; cv=none; b=MzO6dQkw++XduhwffR+OkAXo7IRCpM4FTtKMoaiRbHn/DONaX1u5AlG1TOYNRSgrdwvmolsWxav72mZKcBOa6XNe8z5oTHp2teIzpZRD1WdhRHzcM4ilZufvPoimHBO7RpRJNtZPDJwiHu1+Hn2jcqLoDCLuVZrRgmPWXHKACFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243392; c=relaxed/simple;
	bh=HQNzCf9W+TvtTlIVbFrZdcvENFHgVOktxsslslOxWZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SgxhRH9Sccwz1v3z1QafDoYDixLSJ3JOtMeuNGSfWeFKXdFLEA45m9k53Wheoe0habicnJz7IXivtT7eYsJO6V4w08Xv6RRGXseAz+vyG+DwkmNmNS9hfW8J8loNcnis0Op+0E8H9iaLHTXFSAyuqH8odK2Akc6w1B2LWM5jILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: zesmtpsz5t1750243302tc8a57417
X-QQ-Originating-IP: keGGq+YFE8tuNqfk6RF7BzZPicjKU8gJijQIAgqUiEM=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Jun 2025 18:41:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7749049518741644067
From: chenxiaosong@chenxiaosong.com
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhai@kylinos.cn,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [RFC PATCH] nfsd: convert the nfsd_users to atomic_t
Date: Wed, 18 Jun 2025 18:41:23 +0800
Message-Id: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NDxI9psdf3YVkghZd/8w03o1VRbUTcYZexEEkgrJykEbCTHmo6Zqi28h
	xuocd2vZcuWl6GpMJRntzueYp2Lao35zevNIj8liiHlgLfEEtjxaZx5oVe+qANtupf20KfI
	FYFgpXi3Qh/nRgHppEp9lPgl7s0bhwKv6njgbdtTD9XFqoXisQF9kcIqZG0YFcTXz64b27u
	fgrXiCfNNAHwTCp9AnLXJFOxyoGyZkcIukAcPvVjkJ37iJy+4MDMA75yb++NdV/SJKTK4+B
	wsV9+/wiXcixPldFEmfK+YlHnKh5+uxNPZ/V5awMfYOXL6/y/4SyWhNYrg4f5nH/NlsQooD
	YLnfnNsPslTMYSYx+u/T4IE+y3/KD+0zvuguDn1wmMkh33OblixlFK1wuIb2vW0Dl2KSCD8
	Tv7mc9zZhgje+mRkbL2P6EiLR4cbAbuWoXwjctda51zECDxPWJO7z9etInlwL3zfTztyuqt
	P+v3xW4ZsbgKxbsinqG+PyD9qOj04I5WkdOFvdAltp/goqUXMxjDy29EsZrgMTLLDZ6zWow
	CypOsVWLVxs1ykdEJf4SML/S/dVtVy04HEg76KEf1/ogyvG+00Zp5F6WRTBNC2wl/c3srrr
	efzURwKcj+rOHPIY+MWrXdPYk73D2dBvcAeqHb92CIHzFjYwGRqFp1XsRy0dN3mWbj78Wq5
	qaADzNTuscaPKf4g8qpkoGVwoPftlYWO5IObRb6Gqj3QjOuLtxHstmpyfYp1VydsN17VwJd
	QkUbIZMRSSKuAuq3scy+6xI8nCKi60WQ8madN+LLEYTsQmNULxZl72voLnL4WX+atg1vvoi
	BJf+xUHAZBTHKndFWxm5Z90xRhkxTJYe3UJJfuwjkaoucdIHf2fv1goqjeyWm4Aq8gwZgqW
	5/ggdzhDkRK/xnX/EDzOjWERCkCtlMET6u2Atgy3xvNueYa4OrdJMIJC9a2kgCD2ZAIcyrW
	XFtaY/JtQK6aW5TIlUKmVRWUhRCafYC6rXFiSFGnf3evEkBeFp29WHUOpYJJSyF/DyL0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Before commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_client"),
we had a null-ptr-deref in nfsd4_probe_callback() (Link[1]):

 nfsd: last server has exited, flushing export cache
 NFSD: starting 90-second grace period (net f0000030)
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
 ...
 Call trace:
  __queue_work+0xb4/0x558
  queue_work_on+0x88/0x90
  nfsd4_probe_callback+0x4c/0x58 [nfsd]
 NFSD: starting 90-second grace period (net f0000030)
  nfsd4_probe_callback_sync+0x20/0x38 [nfsd]
  nfsd4_init_conn.isra.57+0x8c/0xa8 [nfsd]
  nfsd4_create_session+0x5b8/0x718 [nfsd]
  nfsd4_proc_compound+0x4c0/0x710 [nfsd]
  nfsd_dispatch+0x104/0x248 [nfsd]
  svc_process_common+0x348/0x808 [sunrpc]
  svc_process+0xb0/0xc8 [sunrpc]
  nfsd+0xf0/0x160 [nfsd]
  kthread+0x134/0x138
  ret_from_fork+0x10/0x18
 Code: aa1c03e0 97ffffba aa0003e2 b5000780 (f9400262)
 SMP: stopping secondary CPUs
 Starting crashdump kernel...
 Bye!

One of the cases is:

    task A (cpu 1)    |   task B (cpu 2)     |   task C (cpu 3)
 ---------------------|----------------------|---------------------------------
 nfsd_startup_generic | nfsd_startup_generic |
   nfsd_users == 0    |  nfsd_users == 0     |
   nfsd_users++       |  nfsd_users++        |
   nfsd_users == 1    |                      |
   ...                |                      |
   callback_wq == xxx |                      |
 ---------------------|----------------------|---------------------------------
                      |                      | nfsd_shutdown_generic
                      |                      |   nfsd_users == 1
                      |                      |   --nfsd_users
                      |                      |   nfsd_users == 0
                      |                      |   ...
                      |                      |   callback_wq == xxx
                      |                      |   destroy_workqueue(callback_wq)
 ---------------------|----------------------|---------------------------------
                      |  nfsd_users == 1     |
                      |  ...                 |
                      |  callback_wq == yyy  |

After commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_client"),
this issue no longer occurs, but we should still convert the nfsd_users
to atomic_t to prevent other similar issues.

Link[1]: https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe_callback.html
Co-developed-by: huhai <huhai@kylinos.cn>
Signed-off-by: huhai <huhai@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/nfsd/nfssvc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9b3d6cff0e1e..08b1f9ebdc2a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -270,13 +270,13 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 	return 0;
 }
 
-static int nfsd_users = 0;
+static atomic_t nfsd_users = ATOMIC_INIT(0);
 
 static int nfsd_startup_generic(void)
 {
 	int ret;
 
-	if (nfsd_users++)
+	if (atomic_fetch_inc(&nfsd_users))
 		return 0;
 
 	ret = nfsd_file_cache_init();
@@ -291,13 +291,13 @@ static int nfsd_startup_generic(void)
 out_file_cache:
 	nfsd_file_cache_shutdown();
 dec_users:
-	nfsd_users--;
+	atomic_dec(&nfsd_users);
 	return ret;
 }
 
 static void nfsd_shutdown_generic(void)
 {
-	if (--nfsd_users)
+	if (atomic_dec_return(&nfsd_users))
 		return;
 
 	nfs4_state_shutdown();
-- 
2.34.1


