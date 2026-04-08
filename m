Return-Path: <linux-nfs+bounces-20763-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLI9CD5/1mmQFwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20763-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 18:15:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6A3BEBEC
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5DCE303EEBC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8734CFD6;
	Wed,  8 Apr 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MALP3S+N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E934C981
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664885; cv=none; b=dN8JIaXxkO1X2CJPSAKU501dGvvQqLl4h3DDM///lPay6a/2Aw/GY9LU7DeZZtYn+epTikXxRTX5/Od1L1d/eAVYOZ2gEliUxBznhjvonU7Jup5CiG869UyT9IB6bMXof9gNyTwj4vlpiZidhIkfKF4uwE99lNARP/xt0VcTTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664885; c=relaxed/simple;
	bh=HE0L2TlxZki+exNOI5hLEfBmSPglXZVfQqXoDdp0Cow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAOzdwfTon6Qkb+E9rcGx/CX3BVU1lWLar2yIovuNBdMSwumJBwfCYiMMXnGeVCe/mrS4NeJoUN4DIV57WZKXEezY5Bxra1VmOTnXF1cVjFMyEY9dcUmR4wHH1U9SGsvM0Lqg7dt4Ya8SUC/kAA4/xLtLBITPr70uBcyl06BrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MALP3S+N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823c56765fdso3344853b3a.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775664884; x=1776269684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YPjAZrC/fQAxlJwQXqKMryLnvq1TdnW5Tuxqia5KaU=;
        b=MALP3S+NPtmhHfBLK6YKNYPEopxgDOrEcufiRqADJRHPwWDNlknSoHehTKOtQQ/qUH
         eKLzDhAnD5O3gxfpnp5rEaHET9ibKhjKfe+QYwWWfKGtanFu8pKZgQ25yo69SDuGuTMM
         s986dYV4FCtiYf4SpbxQ1iVoqtjUNsyOP7lSUbXSZqkK2ghXaK8FLx+B5h/L+E1OGoOF
         jDQbcJ1gUM6+TIUBycr5sZhco6pLfm6MFTjNyIVjFWVFclzDX5GakRfbYYAl4gdJVkgZ
         HOBA3CavKQO8a+ESE0GEKrdljA8TOZZaYIX3f6MvDwd9wN6d0cZs1+mxkD+Ew3fPyetR
         bTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775664884; x=1776269684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YPjAZrC/fQAxlJwQXqKMryLnvq1TdnW5Tuxqia5KaU=;
        b=RrfAw/VAjdZxTlc6ryHYda+nBGL0Q27ZmtY85BR1vz9YrN8UnsCXGFqEx7xzr8SCSr
         c80n37xAglDWpJRi8ylE8EecKypiasbZb5hLWK+HBRy6k0qcTFhkYCCDeaj489xn3kVU
         heiuEtg3m9JKJ2+YRD96CwlWYa2uNcPb79pA0cuUhSx8hGtKO6KZj6IKBjao224gA8Vc
         SViryVqkxgtWcmY4i61SxaZ5GMSxtHffzw243pqBPEvp+k4V9hqCkGLCj2C8ilGuwjAX
         TaLYQ/Nhb0NU9bgxLvFax7M6yXxm+Fh8pq+hSn9WRewI1exr8VSjBgqP20S2rsvDgVpN
         hAcA==
X-Gm-Message-State: AOJu0YyK4rQyop8wNJTVzBvdOim/WsirTLeYQqbeobLJ634TBCqx0vUf
	vpSc2EwyMWeYyVROWjGlaDaMVd8ettDWnBnxQlR71taeUZEDy9chWrbj
X-Gm-Gg: AeBDievHUifOFFr4y5aQN6lvSUzBqnAnHctE/2KkIc887iU32T1wg5i40X+4DvH3nzd
	EeI1OdCf7i/kmof5THvdOZOYox+8ArS798LxpuCbyQaWnT6YWCEne718Etu3uTWH6TEEZKz+IxV
	GunHriwagEF86BS/rn3CO31ZbgD5ecbp3xE7IW4v8Go4sojk6nGjCHh2c2hOp+jhs52fx+i3NUF
	vapvJW/PIXcJkXFYxgOx1a56F1Aa4Xb3zE/HP94hQZTcPExSMEj5vL8/f0Sf0yiL44e+JOTpxev
	zK1KrPnAEPDcaPSEd61mY7PMVCNKEyaGA999p8JHUlDXjK6NLqfvC3vSqVBlr+STvJjQgNZZsFP
	zY0+UinWt+tMihYf2LjzhNZrAAwfCRLDYqr1u4aMnOtB8YVwMgp6F8AXTEeSn6zIr9jzAPEkOFq
	IQS95vGyCd2D2WOqbNAsJhB34pQAprvAvm5lZie97fL3QZVYY/wbsXcE7ob1GIGz2fJzia2fclY
	g==
X-Received: by 2002:a05:6a00:9151:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-82d62edb767mr3429681b3a.45.1775664883837;
        Wed, 08 Apr 2026 09:14:43 -0700 (PDT)
Received: from sean-All-Series.. (59-115-195-252.dynamic-ip.hinet.net. [59.115.195.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm21916840b3a.61.2026.04.08.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:14:43 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1 2/2] NFS: use unsigned long for req field in nfs_page_class
Date: Thu,  9 Apr 2026 00:14:28 +0800
Message-Id: <20260408161428.155169-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408161428.155169-1-seanwascoding@gmail.com>
References: <20260408161428.155169-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20763-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FB6A3BEBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nfs_page_class tracepoint used a pointer for the req field. This
caused Sparse to complain about dereferencing a pointer marked as
__private within the trace ring buffer context.

Change the field type to unsigned long to store the address of the
request without dereferencing it. Update TP_printk to use 0x%lx for
consistent hexadecimal output, allowing for unique identification of
requests across the trace log.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/nfstrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 9f9ce4a565ea..4150bbd99cfa 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1496,7 +1496,7 @@ DECLARE_EVENT_CLASS(nfs_page_class,
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
-			__field(const struct nfs_page *__private, req)
+			__field(unsigned long, req)
 			__field(loff_t, offset)
 			__field(unsigned int, count)
 			__field(unsigned long, flags)
@@ -1509,14 +1509,14 @@ DECLARE_EVENT_CLASS(nfs_page_class,
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
-			__entry->req = req;
+			__entry->req = (unsigned long)req;
 			__entry->offset = req_offset(req);
 			__entry->count = req->wb_bytes;
 			__entry->flags = req->wb_flags;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x req=%p offset=%lld count=%u flags=%s",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x req=0x%lx offset=%lld count=%u flags=%s",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid, __entry->fhandle,
 			__entry->req, __entry->offset, __entry->count,
-- 
2.34.1


