Return-Path: <linux-nfs+bounces-19228-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGMWGwRvnmk+VQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19228-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:39:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50011913CA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 04:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042E830833B0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 03:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDE2BE031;
	Wed, 25 Feb 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6S3wZ3H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120A2BEC3F
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990733; cv=none; b=T+4T6Nb4bQRY6VimxS3JK1G+zie1ZgfDVKgapdbuh/ej29ImFDmDyD5v5Fm6SlnuCQByVuFozcQyw8JDeihq64PRHYk7+Hzd2HbtAZHkWoO1nRFnKqVYxN/nmqGPuUcOr3nGvnntzvipwFW4+xGAozEZQaNvyAWsYAk2N6n0yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990733; c=relaxed/simple;
	bh=UzebxA6/a7fg3sjOiWp/u7lzb1dFODtxX1sVJYsce3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAba/g2iycDHs7UcMZwZkW+oY5Qs6fGaVn6btBs8AUic1t9SYQ3o1Ar0oiZVdJtdwZc1MMv7V+z5w4NxQa6vwGiyvX0JNPPZex8m3MXA9n6cKtk8mTbMEtG9blvTvoRcmfOOAmZ+UA1m0X+mIteVRE0g5uugiKPoCESAxocuf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6S3wZ3H; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2170474a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990731; x=1772595531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=k6S3wZ3H77CAxACFcz+o72T6A6R+BsHZBrvPdcvF7tvFLxxp+fSNCau7O67NC9Ve95
         1yKvbrnImEVYaubbGKPND4duldzGqHnxm9KJHzlnoaPc1634VPnoN5MkBwWc1rjhEXBF
         57aZyVNEXB5s50xJupBvdv7xvBCPgtVJIpiQQXN5+aSZ8ImqM2ZkUJHpAZXx9vh64jqh
         e4rG+hBhdR19sJgWdhhjlnEHzM2SXDJn7s0HxAIJEqtt4y/VBnjYwMn6higD48rWGyJy
         Nqzntkgw2huX2R3OBlY4MY0CH1mZH0Nut+IuQiQ/ST74FB9wf3Jhi90VYK26O1sYJSdW
         3R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990731; x=1772595531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqCX+A7B/xYK3O+/EJk4ZtsIswe0wWdZp+sEMdt10Pc=;
        b=eq1MQ7f1xxgOf52GDTPYN0z1B4Ngja3kZRxCSWySnmsld55AvS2kiONfIqrLcfuEIb
         9mC9F1RaiJme9n204Q/HFeBmNIJ9RMwAN98h4UWH8DRUC0J8HpN5cwU4hMWL6XrxpyY3
         Ys4KE1KujM/5uh7rOHV+oHVBFVOd8WYWT8XOFGjya/8Ts78aVF4VDwRqWApTTCPlpmJe
         hGTqlw/ZAmAc0W+J4MIi6/iMZisZIO3tYK58lJ90FdJMj8DLYIC+fgx/+JaWJMkjcQUJ
         zbD00YkSP7ce9EgzOA0DvesTAB2y1BUk+AEUbMwnEuWSmXxtYFnJm7q5kjSjnl5h/Y8s
         8opA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ69u65Y0svW1gCT1/XQtgeDJW3is3WT4LMqoA0xOjInHxHgwdwBUejYjsaBe5JvsXKXgN2Hwftr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRWBJhuqVNkCByOmdetjUklgrAOiWJD0uE/HsdSOnil0Tfi0q
	aWBUOgCG2kX3b7ghztrdkkyu9NNzmz5Z/tSDPRLEt6UjWF0uqId6wvOR
X-Gm-Gg: ATEYQzwfB6Ne/7kaYGlrYW5hY9Jqn9cHNvlKffHYh0PX5Tg28BMCaU1GzmxViLA8XIo
	ms+zG+jXrhLCdr5n1suUPWfIvJSj53JGehROWTTH1UfaE4D6WX18/2+7slbO2yIb9ldurB2kCmy
	0P2EEW7AP5wlM0tR8cDQ2Dgt9vaXhF3XgQnXcVUuSdo7ISGy3zTT6NJTsm4Ilel9k6mvHxRi4Uf
	ACRTfZisxBlmdLz2kbzxLvFgoxIIZWGmmgi8dxoiayWWCIMvv5lgc1kkorhGQqAzoBpdVH/hvjD
	uhAVIteJJkFH4IUPDtVRZcfCi3+0vrEib/IoqkelmiDbZJ8XModGqt5sZDC/+PsSpFOAU7eryjG
	j7n/TV6e+Qc8jGub7VfM80h5FKFd+o716Ieg5EI35yDurY7fuksqXNviLWOfMYmc7TuzI137RFG
	51uq9qK08GhAEEPivj/aMzVWCmWw/uTS88HfRzLa1eyEDohhlAFWSqrwmhxEoq4CdSFr2J2Fo6H
	XWHx514
X-Received: by 2002:a17:90a:c887:b0:356:23be:7ecb with SMTP id 98e67ed59e1d1-358ae808fb4mr11595307a91.12.1771990731279;
        Tue, 24 Feb 2026 19:38:51 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:50 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 1/4] 9p/trans_xen: make cleanup idempotent after dataring alloc errors
Date: Wed, 25 Feb 2026 11:38:37 +0800
Message-ID: <20260225033840.33000-2-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3411; i=ericterminal@gmail.com; h=from:subject; bh=Gu0MyqKlwATaZLTHkAVxYELyEu7nRq9nuCfzTHc2Ad8=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5NTm/gzgiOsN2hHx4cJz7fzhr19LZHb++7ufoVZo snTztnZdZSyMIhxMciKKbLc/b9vbq7XrTnXuQ/nwsxhZQIZwsDFKQATuWbAyHDC3ICJlbVC0rBZ fRMn18uDx4MObX75UfXy+stNxZIpL/4y/BXwOLHVb3ZcItMd+/SAj2IK0WHehYmHLjAYvrrHufu tEDsA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19228-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50011913CA
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

xen_9pfs_front_alloc_dataring() tears down resources on failure but
leaves ring fields stale. If xen_9pfs_front_init() later jumps to the
common error path, xen_9pfs_front_free() may touch the same resources
again, causing duplicate/invalid gnttab_end_foreign_access() calls and
potentially dereferencing a freed intf pointer.

Initialize dataring sentinels before allocation, gate teardown on those
sentinels, and clear ref/intf/data/irq immediately after each release.

This keeps cleanup idempotent for partially initialized rings and
prevents repeated teardown during init failure handling.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/9p/trans_xen.c | 51 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 47af5a10e..85b9ebfaa 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -283,25 +283,33 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 
 			cancel_work_sync(&ring->work);
 
-			if (!priv->rings[i].intf)
+			if (!ring->intf)
 				break;
-			if (priv->rings[i].irq > 0)
-				unbind_from_irqhandler(priv->rings[i].irq, ring);
-			if (priv->rings[i].data.in) {
-				for (j = 0;
-				     j < (1 << priv->rings[i].intf->ring_order);
+			if (ring->irq >= 0) {
+				unbind_from_irqhandler(ring->irq, ring);
+				ring->irq = -1;
+			}
+			if (ring->data.in) {
+				for (j = 0; j < (1 << ring->intf->ring_order);
 				     j++) {
 					grant_ref_t ref;
 
-					ref = priv->rings[i].intf->ref[j];
+					ref = ring->intf->ref[j];
 					gnttab_end_foreign_access(ref, NULL);
+					ring->intf->ref[j] = INVALID_GRANT_REF;
 				}
-				free_pages_exact(priv->rings[i].data.in,
-				   1UL << (priv->rings[i].intf->ring_order +
-					   XEN_PAGE_SHIFT));
+				free_pages_exact(ring->data.in,
+						 1UL << (ring->intf->ring_order +
+							 XEN_PAGE_SHIFT));
+				ring->data.in = NULL;
+				ring->data.out = NULL;
+			}
+			if (ring->ref != INVALID_GRANT_REF) {
+				gnttab_end_foreign_access(ring->ref, NULL);
+				ring->ref = INVALID_GRANT_REF;
 			}
-			gnttab_end_foreign_access(priv->rings[i].ref, NULL);
-			free_page((unsigned long)priv->rings[i].intf);
+			free_page((unsigned long)ring->intf);
+			ring->intf = NULL;
 		}
 		kfree(priv->rings);
 	}
@@ -334,6 +342,12 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 	int ret = -ENOMEM;
 	void *bytes = NULL;
 
+	ring->intf = NULL;
+	ring->data.in = NULL;
+	ring->data.out = NULL;
+	ring->ref = INVALID_GRANT_REF;
+	ring->irq = -1;
+
 	init_waitqueue_head(&ring->wq);
 	spin_lock_init(&ring->lock);
 	INIT_WORK(&ring->work, p9_xen_response);
@@ -379,9 +393,18 @@ static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
 		for (i--; i >= 0; i--)
 			gnttab_end_foreign_access(ring->intf->ref[i], NULL);
 		free_pages_exact(bytes, 1UL << (order + XEN_PAGE_SHIFT));
+		ring->data.in = NULL;
+		ring->data.out = NULL;
+	}
+	if (ring->ref != INVALID_GRANT_REF) {
+		gnttab_end_foreign_access(ring->ref, NULL);
+		ring->ref = INVALID_GRANT_REF;
+	}
+	if (ring->intf) {
+		free_page((unsigned long)ring->intf);
+		ring->intf = NULL;
 	}
-	gnttab_end_foreign_access(ring->ref, NULL);
-	free_page((unsigned long)ring->intf);
+	ring->irq = -1;
 	return ret;
 }
 
-- 
2.47.3


