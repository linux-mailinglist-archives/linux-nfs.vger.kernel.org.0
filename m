Return-Path: <linux-nfs+bounces-1614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470C843708
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 07:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10F81F2564E
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76E4D5A6;
	Wed, 31 Jan 2024 06:57:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDA4D5A1;
	Wed, 31 Jan 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684233; cv=none; b=Uy7wlNETRQ41nrjaIPztAdhf84umk/hKiENEcFtp6in/h5iD5d4G02RRntcHrdYs5tY8J7Rh92kMa1HgKsWJYAmEEAccwRdBSQQKAj5IX+/FjYdaWb1Ma/thuuZMRnQ5MLi7eYhJqY+yPhvNgM9evdQkneEyozusc67CLaLJpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684233; c=relaxed/simple;
	bh=qKC9t9E0Iev+prafUySOXYdL+8eIhGshD4DwVncQIyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dPn1nEtkUDIsogNqlG3tDItIiuAuEDMyW+N7NLV9ogBltvGTbhlZMJzoJlX1A5vDHESQI325/3H2J/gjoD901nYe1W8TQGKlP0sTN2K8SCVNOruXK45h+VdeVLYGG+tIaoFLQV5jZV/8e7fpmXxydjHnyaTbNc6CVwLVjI1o0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d5b3121e8254e09b1ef0a6acc8e7c63-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ec6917ae-c6ce-42b1-9821-a08a794feabb,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:ec6917ae-c6ce-42b1-9821-a08a794feabb,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:ecabf37f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240131145702MPGTLB1E,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5d5b3121e8254e09b1ef0a6acc8e7c63-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 361959448; Wed, 31 Jan 2024 14:56:59 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B1900E000EB9;
	Wed, 31 Jan 2024 14:56:59 +0800 (CST)
X-ns-mid: postfix-65B9EF3B-525324350
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 88335E000EB9;
	Wed, 31 Jan 2024 14:56:58 +0800 (CST)
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
Subject: [PATCH] nfsd: Simplify the allocation of slab caches in nfsd_file_cache_init
Date: Wed, 31 Jan 2024 14:56:53 +0800
Message-Id: <20240131065653.133965-1-chentao@kylinos.cn>
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
 fs/nfsd/filecache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8d9f7b07e35b..f3a642fd0eca 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -722,15 +722,13 @@ nfsd_file_cache_init(void)
 		return ret;
=20
 	ret =3D -ENOMEM;
-	nfsd_file_slab =3D kmem_cache_create("nfsd_file",
-				sizeof(struct nfsd_file), 0, 0, NULL);
+	nfsd_file_slab =3D KMEM_CACHE(nfsd_file, 0);
 	if (!nfsd_file_slab) {
 		pr_err("nfsd: unable to create nfsd_file_slab\n");
 		goto out_err;
 	}
=20
-	nfsd_file_mark_slab =3D kmem_cache_create("nfsd_file_mark",
-					sizeof(struct nfsd_file_mark), 0, 0, NULL);
+	nfsd_file_mark_slab =3D KMEM_CACHE(nfsd_file_mark, 0);
 	if (!nfsd_file_mark_slab) {
 		pr_err("nfsd: unable to create nfsd_file_mark_slab\n");
 		goto out_err;
--=20
2.39.2


