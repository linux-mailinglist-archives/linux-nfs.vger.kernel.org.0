Return-Path: <linux-nfs+bounces-17773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44DD14D3F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE3E23007653
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8FF305064;
	Mon, 12 Jan 2026 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MOoobwQ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA843876B6;
	Mon, 12 Jan 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244301; cv=none; b=jg7mDC8vJJcZUxR0RLAdn2uMIuKq+o1O50wgUMyAOuIIiB0E1E5a44GrU8nytoTjpkgpaM9cUqVct2YfG5NdpbChg+02hBaXQqxgIzgGjkpMEmjf657tAB5JNFwCCjzW9clTbhB3q0Z6a37laoT7Dk/DZQtmNNI1vIvi/WqIxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244301; c=relaxed/simple;
	bh=5+VsJG0Rg8JB/mewq1GlPwh9A0FPUV1k2l2NZ+ucIFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gL6bBD/tzzS/qBRvV3RpMjLObW96CD8ed1g7lW2LdhRzvxddmCotkXcf2kk/blFLwVqBby9ou+3aI1oT8zoknmF6VmoP2oQACuUGWosYuEww3clIEQJ8b7MABQ83vaH/BJvBonxtZcOQS2relEZcGrdSBd07aGueHMzbbGcwRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MOoobwQ2; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768244298; x=1799780298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QEE+RJAR5yb6rex3x+wM1xsedMUosH6xoJuNNn7yMjQ=;
  b=MOoobwQ2rYbAk2JNeh+YL6yVg2XFfAPiOah2ckmQWvAEaHQrGOEBORMk
   OYYeFyLPaUCzSqwnFl4I1IX+RwIydJTebXEE3AUXcKHp7sZ7EaCm2AN4E
   PHUwU6Fu3PJ01o4fzv/IUpsHjwXgIsTmT05nMOyeFKI5Zcdo7ZuRsfJZ5
   GPrrCb9O2bmGbof2j8ahpVsmnhypXSChoSPd4ZfntrjNXP9ar8QgOV1Py
   3ufq+YgjtI4WDO/0zze/5PPqggM2GBkT59BonUpz5B68OSIIbek0QMX7H
   9ocURHFoo6ZbuH/TQEZxtuawR+aNB+FPfPrTThbvg6mJhdC5hJKmkgG7U
   w==;
X-CSE-ConnectionGUID: G/mHgRa8QoOZ9Yo4YJF0cQ==
X-CSE-MsgGUID: pzUpUtKfSkiv4iCsilpt+A==
X-IronPort-AV: E=Sophos;i="6.21,221,1763424000"; 
   d="scan'208";a="10701428"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:58:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21252]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.55:2525] with esmtp (Farcaster)
 id d1bdffcc-cae7-4df2-86f9-c3afe15a6a01; Mon, 12 Jan 2026 18:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: d1bdffcc-cae7-4df2-86f9-c3afe15a6a01
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:58:16 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:58:16 +0000
From: Jay Wang <wanjay@amazon.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC: <eadavis@qq.com>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <snitzer@kernel.org>,
	<anna.schumaker@oracle.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 6.12] NFSD: net ref data still needs to be freed even if net hasn't startup
Date: Mon, 12 Jan 2026 18:58:13 +0000
Message-ID: <20260112185813.34595-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Edward Adam Davis <eadavis@qq.com>

When the NFSD instance doesn't to startup, the net ref data memory is
not properly reclaimed, which triggers the memory leak issue reported
by syzbot [1].

To avoid the problem reported in [1], the net ref data memory reclamation
action is moved outside of nfsd_net_up when the net is shutdown.

[1]
unreferenced object 0xffff88812a39dfc0 (size 64):
  backtrace (crc a2262fc6):
    percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210

BUG: memory leak

Reported-by: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ee3b889bdeada0a6226
Fixes: 39972494e318 ("nfsd: update percpu_ref to manage references on nfsd_net")
Cc: stable@vger.kernel.org
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 fs/nfsd/nfssvc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cc185c00e309..88c15b49e4bd 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -434,26 +434,26 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	if (!nn->nfsd_net_up)
-		return;
-
-	percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
-	wait_for_completion(&nn->nfsd_net_confirm_done);
-
-	nfsd_export_flush(net);
-	nfs4_state_shutdown_net(net);
-	nfsd_reply_cache_shutdown(nn);
-	nfsd_file_cache_shutdown_net(net);
-	if (nn->lockd_up) {
-		lockd_down(net);
-		nn->lockd_up = false;
+	if (nn->nfsd_net_up) {
+		percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
+		wait_for_completion(&nn->nfsd_net_confirm_done);
+
+		nfsd_export_flush(net);
+		nfs4_state_shutdown_net(net);
+		nfsd_reply_cache_shutdown(nn);
+		nfsd_file_cache_shutdown_net(net);
+		if (nn->lockd_up) {
+			lockd_down(net);
+			nn->lockd_up = false;
+		}
+		wait_for_completion(&nn->nfsd_net_free_done);
 	}
 
-	wait_for_completion(&nn->nfsd_net_free_done);
 	percpu_ref_exit(&nn->nfsd_net_ref);
 
+	if (nn->nfsd_net_up)
+		nfsd_shutdown_generic();
 	nn->nfsd_net_up = false;
-	nfsd_shutdown_generic();
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
-- 
2.47.3


