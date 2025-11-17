Return-Path: <linux-nfs+bounces-16444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F5C6400A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F16F94E15FA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78E32B9A9;
	Mon, 17 Nov 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="AFpvQc6B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sender3-of-o55.zoho.com (sender3-of-o55.zoho.com [136.143.184.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478925785E;
	Mon, 17 Nov 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381516; cv=pass; b=gwKwJEiOTcuAVft/RikX1O93A+XR3mE9TBmTiCW1i6wppD88a2w2YLa8Ee5CfUg0yB0sbClDx5s5F0PDc2gxBdD24kL7f0x0MCfZdBEvzPnaV4UjxfKTP8+iNqnFkCjojyjm9Oy/TKnLsU569/LR30egFAlSSZal5ymp5DfBCEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381516; c=relaxed/simple;
	bh=EhTerH79VoQx9VliTCxbNbnvRa6nUhJiFCX59jlZO5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEk0pcNoPAlmBk0SH0sjA02XqiXGhdZuzl2Zj3Un/0Tswt/3QX7tZPoc66Cppt0ui/EnbXfLkbhUeNMZGnu3osrkg0K+lNRsdkAco8fkFMN4gjz/cBIBQk6ASitLdpsKzKkKwc/euYJNzQlybkzMiKMsJPLwvJEmFP16pA4Nbuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=AFpvQc6B; arc=pass smtp.client-ip=136.143.184.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1763381499; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IiwJZ5L3glxP61FowJuxXVoGvChFGj66GtUasO+vCtcl23aogTESVvXXjYFrm8L3TJTsjMWX5VdjDM+RjIhbcsBKMm62pbgszbhRrY4nAYDTfwliQhfVnRmki2fHDfgEC3yncxJCiK/CR9PQopHGuaX8ZVGjuhbshL2BvCMYz+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763381499; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XE8/FNEA85sgkHwXUarai2T9Ku0d//oFoFMvnfyKujo=; 
	b=HVMUwiqGDIs1fWoIbv+Bsc3w9gR2E9FTRFtgPndLBDKwFt3isPwZI+9N7RQFh52cIIzMeDP8I8zLNjdnMD38ORcRqJ8plar2Oup+TNQA2rl1PKAux4zw3pKVCLBTk6MQUHPbyh2RFsyN5ZoVT5DUZygPzNCsx/cUz4bnwLbEvfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763381499;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=XE8/FNEA85sgkHwXUarai2T9Ku0d//oFoFMvnfyKujo=;
	b=AFpvQc6B0/diCmrIOEflTkm55W3bosEX7KnOBwHE3aI5c62cVgAaE6pNhlLBsvej
	rq+CfREX/dd9lRuy4KoBEHnk31dtcBXMPbNpa7B+hfyT1QArGwMO+ocL6MgJLw+ofAu
	yPbuTlu5lL6WLC2p73QZNTmWRCRxE6xQ384JD9YU=
Received: by mx.zohomail.com with SMTPS id 1763381497132319.7100032746695;
	Mon, 17 Nov 2025 04:11:37 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: shardulsb08@gmail.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	janak@mpiricsoftware.com,
	shardul.b@mpiricsoftware.com
Subject: [PATCH] nfsd: fix memory leak in nfsd_create_serv error paths
Date: Mon, 17 Nov 2025 17:41:21 +0530
Message-Id: <20251117121121.3557585-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When nfsd_create_serv() calls percpu_ref_init() to initialize
nn->nfsd_net_ref, it allocates both a percpu reference counter
and a percpu_ref_data structure (64 bytes). However, if the
function fails later due to svc_create_pooled() returning NULL
or svc_bind() returning an error, these allocations are not
cleaned up, resulting in a memory leak.

The leak manifests as:
- Unreferenced percpu allocation (8 bytes per CPU)
- Unreferenced percpu_ref_data structure (64 bytes)

Fix this by adding percpu_ref_exit() calls in both error paths
to properly clean up the percpu_ref_init() allocations.

This patch fixes the percpu_ref leak in nfsd_create_serv() seen
as an auxiliary leak in syzbot report 099461f8558eb0a1f4f3; the
prepare_creds() and vsock-related leaks in the same report
remain to be addressed separately.

Reported-by: syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=099461f8558eb0a1f4f3
Fixes: 47e988147f40 ("nfsd: add nfsd_serv_try_get and nfsd_serv_put")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/nfsd/nfssvc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7057ddd7a0a8..32cc03a7e7be 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -633,12 +633,15 @@ int nfsd_create_serv(struct net *net)
 	serv = svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
 				 &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
-	if (serv == NULL)
+	if (serv == NULL) {
+		percpu_ref_exit(&nn->nfsd_net_ref);
 		return -ENOMEM;
+	}
 
 	error = svc_bind(serv, net);
 	if (error < 0) {
 		svc_destroy(&serv);
+		percpu_ref_exit(&nn->nfsd_net_ref);
 		return error;
 	}
 	spin_lock(&nfsd_notifier_lock);
-- 
2.34.1


