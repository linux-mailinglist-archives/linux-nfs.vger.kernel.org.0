Return-Path: <linux-nfs+bounces-1766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6884957E
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB6BB23CCB
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A462125A7;
	Mon,  5 Feb 2024 08:38:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE454125A1;
	Mon,  5 Feb 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122293; cv=none; b=d5CRgiq5MR/nSH5Z19eYiDrTpgAfPOsKowtd6jgwTnljF7M5TcHWSQAA2GxtE2Ba5xN3TJRsbyiFrNwGlZN9Hi27itXZhzpoZZe0sVZNaztaeEdJE6qxC214W0LmUnJBYyDVmrcjNWR7yIVMxYSh/Af+Wu12tcBNdoT6MXta2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122293; c=relaxed/simple;
	bh=lLc5BygeeOtVoQdbWSjoD3/s/gfWDJX3EsYjAce9Y1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4gcjVCSZfDJ5ahGPKnzIcC37JJVFH/Ap+MbQD7/RhaEKr4dBcEjAAFwoVblYCRCQrmnsKr9Kh3SIuCUpvb7y6AltNefBXUkO3XUnJK8iVPA7aJ6vRBt3SaqevZHiMhR/w87U756SUNYVd8YbUJ8RpwLLkMSFfTmDlmYkrsDSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3e0ccbd5b21146ff8736a8c4be8befcf-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7721643d-4003-4aa5-8b0e-03e804c7a185,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:7721643d-4003-4aa5-8b0e-03e804c7a185,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:77cc2180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402051638047OS757SN,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3e0ccbd5b21146ff8736a8c4be8befcf-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 964794710; Mon, 05 Feb 2024 16:38:03 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 97F32E000EBC;
	Mon,  5 Feb 2024 16:38:03 +0800 (CST)
X-ns-mid: postfix-65C09E6B-427681358
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2BFEAE000EBC;
	Mon,  5 Feb 2024 16:38:02 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] NFS: Simplify the allocation of slab caches in nfs_init_nfspagecache
Date: Mon,  5 Feb 2024 16:38:01 +0800
Message-Id: <20240205083801.437099-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/nfs/pagelist.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116..f04cc3274fda 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1561,10 +1561,7 @@ void nfs_pageio_stop_mirroring(struct nfs_pageio_d=
escriptor *pgio)
=20
 int __init nfs_init_nfspagecache(void)
 {
-	nfs_page_cachep =3D kmem_cache_create("nfs_page",
-					    sizeof(struct nfs_page),
-					    0, SLAB_HWCACHE_ALIGN,
-					    NULL);
+	nfs_page_cachep =3D KMEM_CACHE(nfs_page, SLAB_HWCACHE_ALIGN);
 	if (nfs_page_cachep =3D=3D NULL)
 		return -ENOMEM;
=20
--=20
2.39.2


