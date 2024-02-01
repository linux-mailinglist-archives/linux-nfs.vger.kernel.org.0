Return-Path: <linux-nfs+bounces-1688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB18452DA
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 09:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44459290BD9
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9B159568;
	Thu,  1 Feb 2024 08:38:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79575FEE0;
	Thu,  1 Feb 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776691; cv=none; b=o74eSOKEFVCJ6s3AFWtMDyLKQEBjEJyLVy3XOpiBPFhP8Lhk4gtvr+4lEMF8RmHudiB205IoTr9aN98V2dB+MyjE/QGY7XmO1TdEAtBxm5uGg7feuAc6rUuhjWq3ayWfg5MVbgsQyNgpXB0kZLytutnHq4I1R+g7ZIVLIH3RTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776691; c=relaxed/simple;
	bh=xoLqq+G2R7a019kwkDlRwcP5gqVvPPSUCr/nZloRuOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hyGCZKmTI/syTey93Z+ISHlyS4+QgevHpZS5QJdT8d2vkif/Sdmg4fGt52ary3jnF+51TaVHhQ/hki2V7vbQGhl+qiQilvZVllDfLAzlwq3S4vwfXM/smf6u3pOT1xzvEHFtkU2rCJQv2hZ02TrtOT/cxX7VoqeeRcc1hRPPulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 009a0533c1ce4205ade393707737c450-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f578277d-d200-4be3-89f5-2245c4cbd187,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:f578277d-d200-4be3-89f5-2245c4cbd187,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:36c30080-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240201163757JXDUAOI2,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 009a0533c1ce4205ade393707737c450-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1794093708; Thu, 01 Feb 2024 16:37:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4E5CEE000EB9;
	Thu,  1 Feb 2024 16:37:55 +0800 (CST)
X-ns-mid: postfix-65BB5863-210300910
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 12A67E000EB9;
	Thu,  1 Feb 2024 16:37:54 +0800 (CST)
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
Subject: [PATCH] nfsd: Simplify the allocation of slab caches in nfsd4_init_slabs
Date: Thu,  1 Feb 2024 16:37:52 +0800
Message-Id: <20240201083752.201727-1-chentao@kylinos.cn>
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
Make the code cleaner and more readable.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/nfsd/nfs4state.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7d561b29fb0..6ac343a5d9db 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4352,32 +4352,25 @@ nfsd4_free_slabs(void)
 int
 nfsd4_init_slabs(void)
 {
-	client_slab =3D kmem_cache_create("nfsd4_clients",
-			sizeof(struct nfs4_client), 0, 0, NULL);
+	client_slab =3D KMEM_CACHE(nfs4_client, 0);
 	if (client_slab =3D=3D NULL)
 		goto out;
-	openowner_slab =3D kmem_cache_create("nfsd4_openowners",
-			sizeof(struct nfs4_openowner), 0, 0, NULL);
+	openowner_slab =3D KMEM_CACHE(nfs4_openowner, 0);
 	if (openowner_slab =3D=3D NULL)
 		goto out_free_client_slab;
-	lockowner_slab =3D kmem_cache_create("nfsd4_lockowners",
-			sizeof(struct nfs4_lockowner), 0, 0, NULL);
+	lockowner_slab =3D KMEM_CACHE(nfs4_lockowner, 0);
 	if (lockowner_slab =3D=3D NULL)
 		goto out_free_openowner_slab;
-	file_slab =3D kmem_cache_create("nfsd4_files",
-			sizeof(struct nfs4_file), 0, 0, NULL);
+	file_slab =3D KMEM_CACHE(nfs4_file, 0);
 	if (file_slab =3D=3D NULL)
 		goto out_free_lockowner_slab;
-	stateid_slab =3D kmem_cache_create("nfsd4_stateids",
-			sizeof(struct nfs4_ol_stateid), 0, 0, NULL);
+	stateid_slab =3D KMEM_CACHE(nfs4_ol_stateid, 0);
 	if (stateid_slab =3D=3D NULL)
 		goto out_free_file_slab;
-	deleg_slab =3D kmem_cache_create("nfsd4_delegations",
-			sizeof(struct nfs4_delegation), 0, 0, NULL);
+	deleg_slab =3D KMEM_CACHE(nfs4_delegation, 0);
 	if (deleg_slab =3D=3D NULL)
 		goto out_free_stateid_slab;
-	odstate_slab =3D kmem_cache_create("nfsd4_odstate",
-			sizeof(struct nfs4_clnt_odstate), 0, 0, NULL);
+	odstate_slab =3D KMEM_CACHE(nfs4_clnt_odstate, 0);
 	if (odstate_slab =3D=3D NULL)
 		goto out_free_deleg_slab;
 	return 0;
--=20
2.39.2


