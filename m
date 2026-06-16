Return-Path: <linux-nfs+bounces-22638-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kzLxOQVTMWpEgwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22638-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:43:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFF6900A5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FLQ2NwDM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22638-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22638-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7836630B209A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E0340A47;
	Tue, 16 Jun 2026 13:40:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771430C345
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617221; cv=none; b=iGoQ6kw6/Rm3OmkaEzhCdlhnj845zKhHA1C9Mcdsx0MH2YIwm5TAJNLFlAgzdK+a52HASo69sps98oREcRRTpK0FybZZB8ymiZCL62qN0NAagGL0ZxnYu9WbKDMUnOa6lXsQzqmAvH8K4k920PfcexPLZmKgyEogOIK8twnVUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617221; c=relaxed/simple;
	bh=52Xcw20XizqMsLy6fUfMk1Q9086tQK9VUAU9mj5qZ9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9pbsCD82GYdCY6q054Gpf+0AU1uCbSEGPTu5jfd/90U4bobIXqdR4fwXAwsS05N0ncATPkOTs03LmeYLtMd1KpVAFiusgN1lytUs+nxenDn+Gx+O5veQ87aoIxZ1vIqp6KeKhSc0xqtknNR9DRuHyxxVUEF4DTereOX0n0Hnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLQ2NwDM; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2269611a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617218; x=1782222018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBS3MV/jBlZa3OBaRQogx3+4bUtSlfAihXqUkT3o36c=;
        b=FLQ2NwDML8DX9DqeUqgwV/nWVeiSPpp9bguWN/6Q6l00kBAidbnVrygtvtYDQPv1cW
         VcecxndIaqswPLGFk+rWmjZwIp49PPuYZynCwhqhqXJAMLN63DQYqMP8XhY169v1PObn
         GYOniU+GeKlWVRl5JseGFoV73nX2zBdcVa2XOGudqdL2BPGAiAfbalEpw7Ea4PLVyc1j
         ajVUI6Ltoi3Efr4hqWXX6Ae6/7zS52LMQGvk8l9MKP2y0gEqO4LDFtzljKM4OM2pdKce
         cOf8r2MMvmzSCmrNVXR+KGlYK40bX2usEwEcKxbbt8nP3yljF3DJ2Wxmc1IATLlUBddo
         TuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617218; x=1782222018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBS3MV/jBlZa3OBaRQogx3+4bUtSlfAihXqUkT3o36c=;
        b=ksPrhs9M2MqDWUUTx2Oo5it28dJMDyAfqi3c9IIq9EowP57S5z9FKNAqXuy9irL3ZK
         tXVxqaxho3y8LMe3dShNcApSC0GTiQlwMjy3+aYhbsmhBf3SoexjIejlKR1By9hh9lMz
         /Hqw263eHqKqmNQJaws1q7y+80xtbgw0nKo5s00AAaGFAFdYBo2xLIiEPVQ/HPcKwGxL
         roLFKkXwnFu5vVtLe0lb/4apFOxYLVHUq1b+Y8CWJ3QqPhgCdqW+cMfx0k9K5IrA7a0n
         iwcWLWdQVoPBA55jRkWRAJ0XtMMUrfL/MC1/H0k/o+C6krLR1ySsxElJAqgJWcjk81WY
         G/ow==
X-Gm-Message-State: AOJu0Yx+WN74FCr8V6fW/E9/xShyVkdIIltDAqNDhMR/GgqeOloyqKAj
	ND8X8aVkQqfixf/Pw2pxXeefh0oLzxFv1al0G7EhaI1YzEeAtxO8gXDSPP6xffU0lANxmZKosc3
	8y8Dc9afe6o5m8149nVZMxxK4PXi+Ij+WxBEyQpiXr90yIPo1Ypv5z+/IdM7CIRnR3I8vA8IHri
	GiHt1vMYVTm9XVqlMZoij9W3WQ2SpcHHmYZJk=
X-Received: from pgve17.prod.google.com ([2002:a65:6491:0:b0:c09:15e9:db4e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce46:b0:3b4:8aad:6337
 with SMTP id adf61e73a8af0-3b7e49b8c55mr4314931637.15.1781617217983; Tue, 16
 Jun 2026 06:40:17 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:40:00 +0000
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616134000.2733403-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-8-praan@google.com>
Subject: [PATCH v2 7/7] nfs: Cleanup the nfs_page_create_from_page helper
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Christoph Hellwig <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22638-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BBFF6900A5

Remove the nfs_page_create_from_page() helper and its public export.
Following the migration of the Direct I/O path to folios, this
function no longer has any callers in the NFS client.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/pagelist.c        | 36 ------------------------------------
 include/linux/nfs_page.h |  6 ------
 2 files changed, 42 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 569bac4faff7..56d397645cc0 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -427,42 +427,6 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page, bool p
 	}
 }
 
-/**
- * nfs_page_create_from_page - Create an NFS read/write request.
- * @ctx: open context to use
- * @page: page to write
- * @pinned: true if page is pinned
- * @pgbase: starting offset within the page for the write
- * @offset: file offset for the write
- * @count: number of bytes to read/write
- *
- * The page must be locked by the caller. This makes sure we never
- * create two different requests for the same page.
- * User should ensure it is safe to sleep in this function.
- */
-struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
-					   struct page *page,
-					   bool pinned,
-					   unsigned int pgbase, loff_t offset,
-					   unsigned int count)
-{
-	struct nfs_lock_context *l_ctx = nfs_get_lock_context(ctx);
-	struct nfs_page *ret;
-
-	if (IS_ERR(l_ctx))
-		return ERR_CAST(l_ctx);
-	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
-			      offset_in_page(offset), count);
-	if (!IS_ERR(ret)) {
-		nfs_page_assign_page(ret, page, pinned);
-		if (pinned)
-			ret->wb_nr_pinned = 1;
-		nfs_page_group_init(ret, NULL);
-	}
-	nfs_put_lock_context(l_ctx);
-	return ret;
-}
-
 /**
  * nfs_page_create_from_folio - Create an NFS read/write request.
  * @ctx: open context to use
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index d23208ed3a33..86d0300075d3 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -125,12 +125,6 @@ struct nfs_pageio_descriptor {
 /* arbitrarily selected limit to number of mirrors */
 #define NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX 16
 
-extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
-						  struct page *page,
-						  bool pinned,
-						  unsigned int pgbase,
-						  loff_t offset,
-						  unsigned int count);
 extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   struct folio *folio,
 						   bool pinned,
-- 
2.54.0.1136.gdb2ca164c4-goog


