Return-Path: <linux-nfs+bounces-1748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46454848AE2
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031F3289902
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 03:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5EC6119;
	Sun,  4 Feb 2024 03:28:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60A4430;
	Sun,  4 Feb 2024 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017313; cv=none; b=eSrDfc7Ba+2iWVmZPrJA6oFXGsLPwid8Ph+tbUPyQvAw7RGWZRjGN+nR0v+zPlLdySRkp7AWYeks3OV+ceH3SKRnP7S2RpLBa7YfKCqg6k+rAtGStS5Y/lH8votTJ7jdlruuB6P6Qc/DQpqnvY7gQInodg9gba2KBghbZCLXnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017313; c=relaxed/simple;
	bh=KUScJl7sbfdEzdna4/ZchgG/zaSIl2kgyy9+ZMbNI70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YEhghlV9lmMh07L7142pufvSHCl1zWymroiuaVPh+zX2oFuHJoE4JfLU4QFFVKGP9bTek01JBGIdm+S78Zjrz4TPwykl+yXgYRy6UGSqwchtPVkY2SWMmP+OORUKyMXByt0dpTf/5kU6lm/6igAclAVXFqLunyA48XWOW+7A1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0b6d2740fc424cae8b63c4694ef53a39-20240204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a4bed280-eab9-4c5b-bbbe-6af01d97ed3b,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:a4bed280-eab9-4c5b-bbbe-6af01d97ed3b,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:4a219783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240204112826L6KNZ1FE,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0b6d2740fc424cae8b63c4694ef53a39-20240204
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 155993714; Sun, 04 Feb 2024 11:28:24 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E2E14E000EBC;
	Sun,  4 Feb 2024 11:28:23 +0800 (CST)
X-ns-mid: postfix-65BF0457-718252327
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 31077E000EBC;
	Sun,  4 Feb 2024 11:28:23 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] nfsd: Simplify the allocation of slab caches in nfsd_drc_slab_create
Date: Sun,  4 Feb 2024 11:28:21 +0800
Message-Id: <20240204032821.349524-1-chentao@kylinos.cn>
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
And change cache name from 'nfsd_drc' to 'nfsd_cacherep'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
Changes in v2:
    - Update commit msg only.
---
 fs/nfsd/nfscache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 5c1a4a0aa605..64ce0cc22197 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -166,8 +166,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, stru=
ct nfsd_cacherep *rp,
=20
 int nfsd_drc_slab_create(void)
 {
-	drc_slab =3D kmem_cache_create("nfsd_drc",
-				sizeof(struct nfsd_cacherep), 0, 0, NULL);
+	drc_slab =3D KMEM_CACHE(nfsd_cacherep, 0);
 	return drc_slab ? 0: -ENOMEM;
 }
=20
--=20
2.39.2


