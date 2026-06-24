Return-Path: <linux-nfs+bounces-22798-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Qj8Hw1WO2psWQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22798-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 05:59:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56C6BB2D2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 05:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DAmoJvwB;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22798-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22798-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD3D303A8F8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 03:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E954366045;
	Wed, 24 Jun 2026 03:59:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7079263C8C
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 03:59:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782273547; cv=none; b=ug+7cTSnuVEDh3VbfMrYzi8sZ9bDrF0RzD9vSefDXkG6lVWAb2FVdY4rXFkrW34zw+JLKEs9amjzKQGSh42Fav+V8PdBS6WmL1iQ2mH4SnSlrqpJorNptDTWuQ2gq9n3SFeOKCa8ZfxpmUjWr2DNdvLmmoFw59ho/BAEdR4BjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782273547; c=relaxed/simple;
	bh=WPUce5p8c2EUssWotG0cGhNLvcSMZmlN2FpDZaWBlEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJT+yot1RXde4qsuBdGimMHrBvoztFQ3oiK8O9IvsEYARm197gllxiYFWteLY3q/07sMI56RZGna6cg2jp170y4bofKQC/PRy4ut8//eBUZ2JsPFYEP/KeZO0jk+dKTSbajZGIEndPI2jZuminNYs1Zz+Awwdlza1KaEG1Xy4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAmoJvwB; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf20f6be6bso3289545ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 20:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782273545; x=1782878345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aijuYlDBKVQj7gxHHfn1uzpu7gtBUKO8JKuffLd7lBI=;
        b=DAmoJvwBfioZNUohy0ImiwAhVhDsMmrg6pdlxPOmPL9XSCZ5ubnP7fHnF4e87hk/TF
         sjcWNPrVGTv9Kd6IZr17nieR4xLK8tnNMFrBgRyKOmPBXFcLDBdOrrREUEHpl9F+A92l
         9os3C5gk5aQDTsHLHwgDo+DIKqNHDM13jxWbE2kpHzqu+AjZBM/Re4kb1pHPL02bmBnP
         tG6XtzWsNr5tk5O+Ge5ucDesjiUW9t2FfezalWtcvcjj8wQvOids/w+nOM2YzuGCXi8L
         dX1gbZxuhtNO4nFNvh2oXH5jK4Rz096TJTFISRZcg+26PWnKIYI+Ph+HiQBreHijcd9s
         +1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782273545; x=1782878345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aijuYlDBKVQj7gxHHfn1uzpu7gtBUKO8JKuffLd7lBI=;
        b=VvF0aW6sZ5RInkVAK+MgdFzljMhwq83GES+iuVSxCwqfdP9WErnTjAQs/j6XphpNAm
         LGyUQ9gWWphRcFL8mgYzAybvowSNCBu1XTom+52ZHWXPTD/EYdmhNFwjrWsVxbsiGh/z
         VxwTdsVUmh+cLBkwH9nG74kq/nW9uPvYioF0hXnxoN3V728g1mNYgUCO2D4Z8+FgHKVL
         FAWvxCXBZAsXo3Aq0UXVzdegHPErrj9dvVe32KboP/rFno97sePBsBS2J6j+uaBPuYJF
         87dSanVmUyXF7FY2PilWyaMgqUgkY0gn5lHV9RbjRUJ5wm+u0FtYDKd8+d0OtFqCK3Cc
         Su0g==
X-Gm-Message-State: AOJu0YwC5YdW8/pnCII1J6/Q/UYQZBWmq6DLx+EIfS3mWydukmxg22Su
	fDqr8ql0RnhUJ+sZDBumaD1O1BMso+NnCdzZR3Ui7GFAB+3P0E2roHKUfNX9PVJF/YA=
X-Gm-Gg: AfdE7cnCodrwkC2l+2UGeJ11AzVRbyG/53hZZW2fYHcQRQ2ia8qSydWItlOIVDO8mAe
	bHwUIWiD8d84hrBrkgj5b7NBqch50hfzJK0xVf2CsDBLrhmSGfoaoqyX7/KL2zrc+2NOs2ZZNNW
	35IX+vn/9tR3uLPNudORYsWrbxM9B/brl0cLd1VKQ9dWwfu06LFa0VBokN+dSzeig+FjCdgPr7S
	cEzAWV3e/4E0UoVXYFbI8LGinfCSBEi7Cb6v0da0EY2CNM22qCn7JTRR/Aey19yQx2M0PZ9h37r
	gmi+IAn3y9fRxyJXvmE2Gn67MFq6CnTWU4A9X4iJ+zVnKIi1neQeSMLZSLNfUKTINVpRTx3RSmc
	NmFEj6fX06ibjpXNn5Vsdm1OdBF+wDr1w3KHI99YNIMLmRnyfZZ7xVby9Uhjo1klc8pwe52OYT5
	ec4XbUQun62nAecraLBneNHLRZQsQpqNV0
X-Received: by 2002:a17:903:244b:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c7e14ea7e2mr17342975ad.25.1782273544995;
        Tue, 23 Jun 2026 20:59:04 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:69f4:9671:af22:eb44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c742fdd411sm135555715ad.0.2026.06.23.20.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:59:04 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] NFSv4: remove callback IDR entry on client allocation failure
Date: Wed, 24 Jun 2026 11:58:58 +0800
Message-ID: <20260624035858.172129-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22798-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF56C6BB2D2

nfs4_alloc_client() allocates an NFSv4.0 callback identifier before it
finishes setting up the client. If any later initialization step fails,
the error path frees the nfs_client directly with nfs_free_client(). That
bypasses nfs_put_client(), which is where the callback IDR entry is
removed during normal teardown.

A failed allocation can therefore leave cb_ident_idr pointing at a freed
nfs_client. A later NFSv4.0 callback lookup by cb_ident would find the
stale pointer and take a reference to it.

Make the callback IDR removal helper callable by the allocation failure
path, and remove the callback identifier before freeing the client.

This was found by a local static-analysis checker for publish-before-free
lifetime bugs and confirmed by manual inspection.

Fixes: f4eecd5da342 ("NFS implement v4.0 callback_ident")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 fs/nfs/client.c     | 14 +++++++++++++-
 fs/nfs/internal.h   |  1 +
 fs/nfs/nfs4client.c |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4dcb91ab..60386330 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -215,9 +215,21 @@ static void nfs_cb_idr_remove_locked(struct nfs_client *clp)
 {
 	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
 
-	if (clp->cl_cb_ident)
+	if (clp->cl_cb_ident) {
 		idr_remove(&nn->cb_ident_idr, clp->cl_cb_ident);
+		clp->cl_cb_ident = 0;
+	}
+}
+
+void nfs_cb_idr_remove(struct nfs_client *clp)
+{
+	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
+
+	spin_lock(&nn->nfs_client_lock);
+	nfs_cb_idr_remove_locked(clp);
+	spin_unlock(&nn->nfs_client_lock);
 }
+EXPORT_SYMBOL_GPL(nfs_cb_idr_remove);
 
 static void pnfs_init_server(struct nfs_server *server)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index acaeff7d..a9b3023d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -225,6 +225,7 @@ void nfs_server_copy_userdata(struct nfs_server *, struct nfs_server *);
 
 extern void nfs_put_client(struct nfs_client *);
 extern void nfs_free_client(struct nfs_client *);
+void nfs_cb_idr_remove(struct nfs_client *clp);
 extern struct nfs_client *nfs4_find_client_ident(struct net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 71c271a1..aff019d2 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -261,6 +261,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	return clp;
 
 error:
+	nfs_cb_idr_remove(clp);
 	nfs_free_client(clp);
 	return ERR_PTR(err);
 }
-- 
2.51.0


