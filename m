Return-Path: <linux-nfs+bounces-22218-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S+GLOEaFH2oemwAAu9opvQ
	(envelope-from <linux-nfs+bounces-22218-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:37:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F463378B
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22218-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22218-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDC933016F87
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E1372054;
	Wed,  3 Jun 2026 01:37:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67C34AAE3;
	Wed,  3 Jun 2026 01:37:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450625; cv=none; b=CbJEphJrSDx4t6dVdkf6bQ+YNQsrRuGN1JO5WNrdIfZlioHtQTVfULNOVTp4FDR4bvKijrt2avmcTTwd77o7kyOtNAySfpPw4ko3RSEPUHv5XQLsW3gsc1o/2Jt83nXmG+HhdJKrHXP2oaoljpMJg7ERdCSzyEoJKnWkGAbZE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450625; c=relaxed/simple;
	bh=JH8p6nupcMUBqYj33I5eOiO6hzR7aTXI/GjmyJ0JzT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jN7M8jEFWok6yUw3JLhPNBV/JTthIRtl0HbD+oHrWV5Ar6AkkcesdbtuNJNUeYfxTIGgSuD4ma8PWKYSnh3t39DeQ3g1lmOVhG9W5dSdFkMIEkX7YMzaRRYz1B7qxG1YH/shryyoVLnaddPlCF99oMWporxwxjalokSv8o4HiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: b573e1de5eec11f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6846cdb4-b600-47ba-8e08-97aee3a6dd97,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:c948205c490dbae470ab7c7ddb3294dc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b573e1de5eec11f1aa26b74ffac11d73-20260603
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1357867210; Wed, 03 Jun 2026 09:36:57 +0800
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
Subject: [PATCH v2] sunrpc: fix uninitialized xprt_create_args structure
Date: Wed,  3 Jun 2026 09:36:52 +0800
Message-Id: <20260603013652.12904-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22218-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1F463378B

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
Suggested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
Changes in V2:
- Use designated initializer instead of memset, as suggested by
  Jeff Layton
- Add Reviewed-by tag

---
 net/sunrpc/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index a90480f80154..4669227a6de6 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -327,7 +327,7 @@ static ssize_t rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
 {
 	struct rpc_xprt_switch *xprt_switch =
 		rpc_sysfs_xprt_switch_kobj_get_xprt(kobj);
-	struct xprt_create xprt_create_args;
+	struct xprt_create xprt_create_args = {};
 	struct rpc_xprt *xprt, *new;
 
 	if (!xprt_switch)
-- 
2.25.1


