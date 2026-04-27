Return-Path: <linux-nfs+bounces-21156-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGbyIRYC72lz3QAAu9opvQ
	(envelope-from <linux-nfs+bounces-21156-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:28:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29A346D8D1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F063002F9A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA1370D54;
	Mon, 27 Apr 2026 06:28:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F32548EE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271284; cv=none; b=bWfsE1EqAzykB13K9C8QmalZSEky4fn+ufbVCeKO4zkj4tj7YjuNAeCbNufFTmxHkOpxkDrwjJk+qOby2AXQtfg0YLNdh6T3EtD+UmM5fmJreWLWTuIUIhOUXAdnHD6ztiWYw5OcznhfQVOVYonUYRJ+R/mdLm7y5hW++a6sDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271284; c=relaxed/simple;
	bh=IDGurBxvR2iP+K+F0cO45NwZ8M+FYYqEqQX9lZtEZxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sj3uD1r5Y6rSxb4J05vPYaduaCzs+en/l9Cb3SNp/3BqTPsvwRFPLThVti4xIUIvMtDPXjU+rmloto8TEMEwEqkDRc+dgVB2HKXU5/AsLhvaJa56bMYs5r+awpZvnUc98FVme8S7Uh1OrMr/AM2DVwHtGUtFbKOXFM817Fl8MjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso47659545e9.3
        for <linux-nfs@vger.kernel.org>; Sun, 26 Apr 2026 23:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777271280; x=1777876080;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHMJM6JEVrjh5hymm+0hGF3UrSihsUEGjS68DjrvfRM=;
        b=HG4XFQy485MjPL2XQ0JMgRVnely9+qRfbG7+K2QP3mvnwwqumFkY+Mw8FUSHJUylHJ
         Giaw2YBX/DrOtnvx4uukC4xkQaGPC/n20Xwhai9CtOwRYwnuiTLMT6HrvxaSbNHTl5sj
         YlRNbS59pj5bQ3g/EDDEwwZzS6Bh9wtrSVBUja1c9yv/BYFbutT2kwDPWh1bMI1+Sy/s
         sELk/d5GgVPQXUw2wF2vcQRp9QB/S3tcDkLUp5+kxugx2w5IKCo/XfO1CHuEFRACwcwX
         pKA5PamxuHaYJ++AOQo6Ocqsek5euRwMZFael87cTUiZ6CuV7Ap/5l1xxq9xWxrfc96m
         8zwQ==
X-Gm-Message-State: AOJu0YwMSwrAEQ7xcF4W2aGSC4YlNVAp9rrXRsaooZ/kWGXSmEj4JunZ
	czCwrMnDziT3D32Hy2v6lqauBjhNuV+mmFij1tdUZWz/3VFCxTGLQetnIxivNA==
X-Gm-Gg: AeBDiesxW/Z0wYzUk5y2Qjx25mjLcyKVh37GF6pZva/Lyc7qWo5y9xpBDS45LHtn4Qa
	2YtilhmgiA+UEUS0aR9qvX0F8tZ1876wj+2hXYZQkdH1pKyDrNkRhsNtbMcIoMb2gZGKFB13Pwr
	rbwVbIhLo59SuZLOhCRwRA8J+K9WrMLP855CMmq7JpaW2jvyVAljzLAD6rXXPHjNEETRIeS6j/K
	oIRBgwFYzt9WBGFv8HrXSRQ49iVNiT0A1wOqRFNQyTz12evL8M+EfiUo6M3fEDwdtXi5AjexkUy
	fp2UMKQAN04ss3kBf1w8QyYOSG5XY4mvaRO/axOQCRUIAwgFNNn6y7qZ3MHCqy97XX8+ca1hPcv
	Jh7coWPJ71tpY52vvuAjh1QA53xCE6skjoT8KjRFXgXYMk3GTKoXVeo8uGixxrW8iyx3B6cCCgM
	8F9vo+kfvqYCe2mwHUyUdKdDTXBhCZA7ETecGJAC8UxrK4AUHQs0C1s+PO8sB5OOuiKxHoUAKz7
	ZJ7TuQKjyRoD4hlKeNZmCez8qYCfNRy9Gk=
X-Received: by 2002:a05:600c:5295:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488fb77d0fdmr589363075e9.17.1777271280136;
        Sun, 26 Apr 2026 23:28:00 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm707258205e9.15.2026.04.26.23.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:27:59 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] pNFS/filelayout: fix cheking if a layout is striped
Date: Mon, 27 Apr 2026 09:27:57 +0300
Message-ID: <20260427062757.647256-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E29A346D8D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21156-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.942];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

A layout can be striped with num_fh = 1. It is perfectly possible that
both MDS and DSs can handle the same filehandle, which is exactly the
case in vast pnfs layouts. Hence check according to stripe_count > 1,
which is the correct check to begin with.

We should not be called with flseg->dsaddr = NULL, but if for some reason
we do, return our best guess with is flseg->num_fh > 1.

Fixes: a6b9d2fa0024 ("pNFS/filelayout: Fix coalescing test for single DS")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/filelayout/filelayout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 90a11afa5d05..c28b3d5bfa8c 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -778,6 +778,8 @@ filelayout_alloc_lseg(struct pnfs_layout_hdr *layoutid,
 static bool
 filelayout_lseg_is_striped(const struct nfs4_filelayout_segment *flseg)
 {
+	if (flseg->dsaddr)
+		return flseg->dsaddr->stripe_count > 1;
 	return flseg->num_fh > 1;
 }
 
-- 
2.43.0


