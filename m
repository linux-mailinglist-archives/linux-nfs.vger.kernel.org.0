Return-Path: <linux-nfs+bounces-22195-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB1HHpWWHmrPlAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22195-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 10:38:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF662AAFD
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E7E3085672
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590C36F901;
	Tue,  2 Jun 2026 08:32:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3C3C5DBE;
	Tue,  2 Jun 2026 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389138; cv=none; b=daSuhpqzfpbbBQD7iy7aZuwhcMlutX6YVFpSr2S+N+kXz9fRszWVp7Mh5K/xN+Cyda7Jcr29OD0vS/SDseNP8L4OeE4ef2Z2UuJTyxQSvHDJ8V3F017X9OurMzh4NLvnglThfXwtNX4R+U99qF3PMQ8hl9nEwLZkelaZ+5q6a10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389138; c=relaxed/simple;
	bh=IsyMWC1ykDaBmgFzN1yazxHHc0d6aG52NplrlIAR01k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJBLwyyLqk3fMHc+C11R84W5YoJnMgJ/mgMi4NPU6o187scXMp/dFa081/KAhb88Ij4Su1zxPTx8NRCTR4vtA5GU6v7k7UK6jEslHZktYjbmj831vdGOjGNNX0AsEWD8Jg5mc7mFyQaW5Zt0NLc+6InTQHnKJYNHQ2E5XECNu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c18e1ac5e5d11f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f9dc1260-f978-445f-8f76-bf83c48dc470,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:b0d2196e1c3d3982a0b7b15cc78b0136,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c18e1ac5e5d11f1aa26b74ffac11d73-20260602
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 5209442; Tue, 02 Jun 2026 16:32:10 +0800
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
	horms@kernel.org
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sunrpc: fix uninitialized xprt_create_args structure
Date: Tue,  2 Jun 2026 16:32:05 +0800
Message-Id: <20260602083205.183807-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22195-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 26CF662AAFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The xprt_create_args structure is allocated on the stack without
initialization in rpc_sysfs_xprt_switch_add_xprt_store(). While some
fields are manually populated, critical fields like srcaddr, bc_xps,
and flags contain uninitialized stack garbage.

This can lead to:
1. Kernel panic when xs_setup_xprt() dereferences garbage srcaddr
2. Information leak if srcaddr points to sensitive stack data
3. Unpredictable behavior if flags has random bits set

The fix is to zero-initialize the structure to ensure all unused
fields are NULL/0, preventing the transport setup code from acting
on garbage data.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 net/sunrpc/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index a90480f80154..0a99d0f1eb4c 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -333,6 +333,7 @@ static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
 	if (!xprt_switch)
 		return 0;
 
+	memset(&xprt_create_args, 0, sizeof(xprt_create_args));
 	xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
 	if (!xprt)
 		goto out;
-- 
2.25.1


