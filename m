Return-Path: <linux-nfs+bounces-22937-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bYzzJObDRWpzEwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22937-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:50:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C56F2E04
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:50:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22937-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22937-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B06F5301A44B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F62C21E6;
	Thu,  2 Jul 2026 01:50:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E529B79B;
	Thu,  2 Jul 2026 01:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957026; cv=none; b=USWmWg28IRHiM7O04fWLi6drrkKr2CBRdMC2CoiRS5HkzxX5Ga/SoOdRcBC79C+InMtuBNwUdhUrfJOdZo+GAoe3OzLi2HIeF5fvZIMmwqs9LNn/BeF4h8442ZKJeH2FxAsNf+zKh4dm50gbI3izkB0AIj/UFdO0mUZa9LWOsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957026; c=relaxed/simple;
	bh=EYK5gGhf2WCP8XECD+MQ+3RLd6xkWWgez07E0AmpYHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5U2NFisgQecYhAdumbzQtxnXHvQG2qgMNLZqpWi94oY3Q/B6WICsB9IWridjImK8hIuUsGE7lOxvOpKid6NBHbIYT/nxPb2Ou7rUIDVsTSZ7hLqgS4eVJqjb1+zYe04TFDSm5hgRYXDPFy2NAn4ftNqG0IVit8u9pmxZZHIoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 610a885475b811f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0130af7c-4e88-4dcc-9800-a4894c0a2bf4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:04db85e218a4687316c40f98d044e792,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 610a885475b811f1aa26b74ffac11d73-20260702
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1213473515; Thu, 02 Jul 2026 09:50:18 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] NFS: fix folio dereference before NULL check in nfs_inode_remove_request()
Date: Thu,  2 Jul 2026 09:50:14 +0800
Message-Id: <20260702015014.192357-1-yijiangshan@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22937-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,163.com,kylinos.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yijiangshan@kylinos.cn,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:gregkh@linuxfoundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:13667453960@163.com,m:yijiangshan@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yijiangshan@kylinos.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 386C56F2E04

nfs_inode_remove_request() obtains the folio for the head request via
nfs_page_to_folio(), which returns NULL when the PG_FOLIO flag is not
set on req->wb_head.

The presence of the "if (likely(folio))" check shows the code already
assumes folio can be NULL. However, folio was dereferenced before that
check:

        folio = nfs_page_to_folio(req->wb_head);
        mapping = folio->mapping;                       /* deref */

        spin_lock(&mapping->i_private_lock);
        if (likely(folio)) {                            /* too late */

folio->mapping is read (and mapping->i_private_lock is taken, and
folio_end_dropbehind(folio) is called outside the check) before folio
is validated, so a NULL folio would crash before the guard is ever
reached, rendering the check useless.

Move the folio->mapping read, the i_private_lock section and the
folio_end_dropbehind() call inside the "if (likely(folio))" block so
the folio is only dereferenced after it has been confirmed non-NULL.
The behaviour is unchanged when folio is non-NULL.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/nfs/write.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fcffb8c9e9df..33d51eb9a3a4 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -739,17 +739,18 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	nfs_page_group_lock(req);
 	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
-		struct address_space *mapping = folio->mapping;
 
-		spin_lock(&mapping->i_private_lock);
 		if (likely(folio)) {
+			struct address_space *mapping = folio->mapping;
+
+			spin_lock(&mapping->i_private_lock);
 			folio->private = NULL;
 			folio_clear_private(folio);
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
-		}
-		spin_unlock(&mapping->i_private_lock);
+			spin_unlock(&mapping->i_private_lock);
 
-		folio_end_dropbehind(folio);
+			folio_end_dropbehind(folio);
+		}
 	}
 	nfs_page_group_unlock(req);
 
-- 
2.25.1


