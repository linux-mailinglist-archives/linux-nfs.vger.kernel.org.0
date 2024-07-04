Return-Path: <linux-nfs+bounces-4615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267F926CCF
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 02:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE392B22D28
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 00:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE34C92;
	Thu,  4 Jul 2024 00:55:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009523AD;
	Thu,  4 Jul 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054527; cv=none; b=Ufmbalm2FkBmL735sqdFdQUCUCnwLlr9hdQKunHlkc92mVavIeDkq4XT5/ozc5d2s5R1GjhuvSDtm6FRZVwqobkBwnCxM1f2g0EsZ/BXuA4Qopq3Tn8JFoBSkEeiNpy8VbDzby/KbFOU9XwX3OcP/XTNlNQNS1u02tjE7wAqq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054527; c=relaxed/simple;
	bh=axQyEzblYvbHETJ0gbmBRA+rd+VfcEu1m3BvOP9jEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgCsofL7ZK5uFajvTGBAvvNy5ihNTz3UAgumYTRRh0t0wXFwEgTGOzmitiZvWaruCvv1dM2fqkRd7Hz2/JMKReLURBq6Q9yDc8f7c1kf55b91jntjTmKP0GQIyndDReL7umTXcUNqQVsPGdoh1j+D9RWpP1gLW8NwAwDZ6/Wl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: db2219da399d11ef93f4611109254879-20240704
X-CID-CACHE: Type:Local,Time:202407040836+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:609fb93d-499c-441d-bd66-d59e0adbce4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:d57457d2ed1d8ecb447419be162a7b40,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: db2219da399d11ef93f4611109254879-20240704
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <liuhuan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1909068126; Thu, 04 Jul 2024 08:39:22 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id E46EB16002082;
	Thu,  4 Jul 2024 08:39:21 +0800 (CST)
X-ns-mid: postfix-6685EF39-6795893
Received: from localhost.localdomain (unknown [172.29.156.133])
	by node4.com.cn (NSMail) with ESMTPA id 649E916002082;
	Thu,  4 Jul 2024 00:39:21 +0000 (UTC)
From: liuh <liuhuan01@kylinos.cn>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuh <liuhuan01@kylinos.cn>
Subject: [PATCH] NFS: AIO doesn't require revert iterator
Date: Thu,  4 Jul 2024 08:40:02 +0800
Message-ID: <20240704004002.5787-1-liuhuan01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For AIO, nfs_direct_wait return -EIOCBQUEUED would be expected.
Revert iter is redundant.

Signed-off-by: liuh <liuhuan01@kylinos.cn>
---
 fs/nfs/direct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 90079ca13..1483f1965 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -469,7 +469,8 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
 			requested -=3D result;
 			iocb->ki_pos +=3D result;
 		}
-		iov_iter_revert(iter, requested);
+		if (is_sync_kiocb(iocb))
+			iov_iter_revert(iter, requested);
 	} else {
 		result =3D requested;
 	}
@@ -1028,7 +1029,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, s=
truct iov_iter *iter,
 			/* XXX: should check the generic_write_sync retval */
 			generic_write_sync(iocb, result);
 		}
-		iov_iter_revert(iter, requested);
+		if (is_sync_kiocb(iocb))
+			iov_iter_revert(iter, requested);
 	} else {
 		result =3D requested;
 	}
--=20
2.27.0


