Return-Path: <linux-nfs+bounces-1687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4C84528D
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23291C25967
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A396158D85;
	Thu,  1 Feb 2024 08:19:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C39158D76;
	Thu,  1 Feb 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775591; cv=none; b=iAnXxhQSTL20GBZ2Awcmhqf43KKrM43GigNROtdi6OTmVFJnGHQtamKY0KYdfnCiAPuLAjUh/bA1tSAp6gvsuEMjrq+GJeq7Urju80R17T7DgoCgdOGdkXPPhX50G21ihOoas93+KQfqO1pEkSA5Flxvt8103+sr11l4znMsEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775591; c=relaxed/simple;
	bh=dpj7BQrTh0UjOXplbKxWBBtt23WR/YSUKBByrVjv5Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YrMUXOS07S0Q7WPqlIQVChb2MbYeMeFzohU7NUmvJg9Jr/hp0VorxtLbHapNRHIQC6/lpANbaB6xgMpAIUrW/WQ/ETJGfbNLwWLc2xbi4p0TtXq8sPNYt2h42S3ikIGay7+5No/sC4m63b20BlVSwRagMIbTN/4NsHaTUL2VIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37791ac224ac437d8b6e2347458ab69e-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2050252c-341c-4a4e-8f25-f548989288d7,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:2050252c-341c-4a4e-8f25-f548989288d7,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:738965fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:24020116194210GQBIOB,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 37791ac224ac437d8b6e2347458ab69e-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1346395004; Thu, 01 Feb 2024 16:19:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id F250CE000EB9;
	Thu,  1 Feb 2024 16:19:39 +0800 (CST)
X-ns-mid: postfix-65BB541B-786294796
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 82DABE000EB9;
	Thu,  1 Feb 2024 16:19:37 +0800 (CST)
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
Subject: [PATCH] nfsd: Simplify the allocation of slab caches in nfsd_drc_slab_create
Date: Thu,  1 Feb 2024 16:19:35 +0800
Message-Id: <20240201081935.200031-1-chentao@kylinos.cn>
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


