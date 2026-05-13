Return-Path: <linux-nfs+bounces-21598-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEUmCXxEBGqqGQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21598-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 11:29:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5A530A2A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8066A3095D72
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A223E8C7D;
	Wed, 13 May 2026 09:29:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29893019DC;
	Wed, 13 May 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664552; cv=none; b=KHMyT+MT5Okzujq2YqdGGBXcA1Rb3v+RxahCt3XYgj1JlBqGKkshYp7bidt+swBAYGcZSV59N23xCBvoadRNnjLKUBWb1mOjQRMVj+E9K4XNVytJNCAhCd7AJrSo+Z6L4FxxETnU4LLF9qsLJQh3Laqiq8CY0qBKZnCsi+NsuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664552; c=relaxed/simple;
	bh=iZdO5tfrEC0OdlmnndPXB576cc8IXVl/EBWV1fGg2nM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pU6QY5oupo0qTVD8bClC+pn6gXMEiD3/BtRt5D1C0AhzM8PyQM+TZiIhUcmugoDnQJ2ZfL4pPztV/WB4/sg7vYc4rXEji9s1CMUg/ZCSPoti6iQfaHeFyfWnFtsbNLxjMLIBAzEFUaXuGQqqL0qOL8jl542gFjcJzCrckn4TK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e923c044eae11f1aa26b74ffac11d73-20260513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:962183df-769f-4fc9-ae5d-57349e4edb99,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:74ee4adb473dd5d5ef253debbc8e454a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e923c044eae11f1aa26b74ffac11d73-20260513
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1572052449; Wed, 13 May 2026 17:29:03 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] sunrpc: Fix error handling in rpc_sysfs_xprt_switch_add_xprt_store()
Date: Wed, 13 May 2026 17:28:59 +0800
Message-Id: <20260513092859.175466-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADE5A530A2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21598-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

xprt_create_transport() never returns NULL, only valid pointers or
error pointers. Using IS_ERR_OR_NULL() is incorrect, and PTR_ERR(NULL)
would return 0, which indicates EOF in a sysfs store function.

Fix this by using IS_ERR() instead of IS_ERR_OR_NULL().

Fixes: df210d9b0951 ("sunrpc: Add a sysfs file for adding a new xprt")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 net/sunrpc/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index a90480f80154..49686bf740e6 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -348,7 +348,7 @@ static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
 	xprt_create_args.reconnect_timeout = xprt->max_reconnect_timeout;
 
 	new = xprt_create_transport(&xprt_create_args);
-	if (IS_ERR_OR_NULL(new)) {
+	if (IS_ERR(new)) {
 		count = PTR_ERR(new);
 		goto out_put_xprt;
 	}
-- 
2.25.1


