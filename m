Return-Path: <linux-nfs+bounces-1613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D997843694
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 07:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B291C2814F5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A583E481;
	Wed, 31 Jan 2024 06:22:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B283E477;
	Wed, 31 Jan 2024 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682177; cv=none; b=lQlW6CCKWzcLs6x5cpojbJfH72QxF8RO2pH9oGxBragN2P6tbycZQchjWtrbTnmrqsuTg0i1QfdHbdnUcju1MyeXbHpxVDddnyxJDQMioewMDh5KGYG3/Fi1xzUV+DEQjiU2WU6FGY7f4HQdI+huPbKjcnXWnJnzKAWIFurEsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682177; c=relaxed/simple;
	bh=BNG1PYjlKq0dn1rf9742m7PS1TbxWNZTEf/7YFKPEmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvksGN7pkWvBIfsWQ6m7DXNYDrdRm7CzLz7MTGo8AqgpIkRymPDvIEHO37dI8m+XIZFVVEvSKTj0G2nEzYeNHIzO49bmC0t44+l2/vAYHXW2+HpToITh8M6aDCrDxT1wVErZXCL0d3Qk0j3QdKinwQQulXF7BL6hkNHBRb97aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8668ff10992f427390129c709937f690-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f7b5f210-4503-4c84-acc9-7e554c948385,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:f7b5f210-4503-4c84-acc9-7e554c948385,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:f94058fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:2401311422466YU4ZA4Z,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8668ff10992f427390129c709937f690-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1747670609; Wed, 31 Jan 2024 14:22:43 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 66CF8E000EB9;
	Wed, 31 Jan 2024 14:22:43 +0800 (CST)
X-ns-mid: postfix-65B9E733-157518213
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id CF8CEE000EB9;
	Wed, 31 Jan 2024 14:22:41 +0800 (CST)
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
Subject: [PATCH] nfsd: Simplify the allocation of slab caches in nfsd4_init_pnfs
Date: Wed, 31 Jan 2024 14:22:27 +0800
Message-Id: <20240131062227.130725-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/nfsd/nfs4layouts.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..4116695e6aa3 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -756,13 +756,11 @@ nfsd4_init_pnfs(void)
 	for (i =3D 0; i < DEVID_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nfsd_devid_hash[i]);
=20
-	nfs4_layout_cache =3D kmem_cache_create("nfs4_layout",
-			sizeof(struct nfs4_layout), 0, 0, NULL);
+	nfs4_layout_cache =3D KMEM_CACHE(nfs4_layout, 0);
 	if (!nfs4_layout_cache)
 		return -ENOMEM;
=20
-	nfs4_layout_stateid_cache =3D kmem_cache_create("nfs4_layout_stateid",
-			sizeof(struct nfs4_layout_stateid), 0, 0, NULL);
+	nfs4_layout_stateid_cache =3D KMEM_CACHE(nfs4_layout_stateid, 0);
 	if (!nfs4_layout_stateid_cache) {
 		kmem_cache_destroy(nfs4_layout_cache);
 		return -ENOMEM;
--=20
2.39.2


