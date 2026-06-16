Return-Path: <linux-nfs+bounces-22633-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vymGNzlTMWpQgwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22633-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:44:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEB6900D0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KVs6wcke;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22633-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22633-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CF931FC48E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725030C345;
	Tue, 16 Jun 2026 13:40:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49340327BEC
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617209; cv=none; b=pkiHxkzumXvWY0Ckw/WPw0HpuLwR5EKGBPROVx6nEnQ+g2r2fBMrahm6XqfqKBUJQ0mMXtkFxCNsUz50+3CBJSGz9oamXzVQYI4cYaUWEb9DHmTW2EID83dimhjdIFMYX+qOpYNFkx1lYVNp0te7JG11IZvDWLlKIVbz/mVx93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617209; c=relaxed/simple;
	bh=y4SrqlcQUH1NTWAOkVX8IcfVRt/JvGwglpqKLAgS46c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BGY2B2Q8/mzw6fV9rqbtI8n5XZoegNSIuF/MILhHqgwHHJdPZODqwiiSy84jaLxZ9IgXk5f5tjFEWUuOTewKT9/xH6pu5Jjf0NkcPxA0YjIftPPlC/uLKbDiHm45akTv+w6dkqXfDv/ifx3UfevyJTNJpsWrNiNydRGWTLJoIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVs6wcke; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f19558so2525422a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617208; x=1782222008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SVlvry5FcOzYHP8fF1VVoNZ4UfIPPvWckgyb5sjBA8=;
        b=KVs6wckemJoFrj42FYunCmgzwAjBtmFZxCaXkhDmrPpj5Q549siglNP/SbPTONwfvj
         6cAh7AbLrqdszaT7ODDQCd//R8IyM8Hpk+Cp3YimVEmzo/hg0LoRm8T7ZE8BEcZhMSJT
         kTFuPiGTrbU8dXlIwjXfV5bFbd4l8ohbYbYXphrNmjWbpHCq4hicIVcQTPJAutInvomi
         6TmpnKGS7AwQkM+tPWGhs0o+GcZBMVPQ3F5zeWvXbbtY+udcXs9JBnPSJFjvtdu9fQBl
         cZXMEYV4ViyMRLxK1n7eLvpOHTRgimkpYS8LyLkDo9V20CzAe1H1rDmUiL2elXA03RDN
         Hjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617208; x=1782222008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SVlvry5FcOzYHP8fF1VVoNZ4UfIPPvWckgyb5sjBA8=;
        b=B0X/P9gKjrfZ6VVVbHNX6mXcHpmJVr4bJLYbk+a30j1nQrAHziE8MYLCuqHOeaFAC/
         Xd6E8yIfVFogd6vT5V5xZrfK0S8exX+p+mcpwBclJ8NewElfC9eHXh0u1L7+OkDBEfdV
         vt7JVPH1/eq/L2hkOmPtlJXmtc7glbaznOGxRM1HsixAhxwysn74kPkys47YLZvc6822
         kMK701iB1uL8Pfjit3yFVHbMtT4PzfdVgcp2Wjjh6kwdmQDSw+bM3aIX7sL8Il+UKVQU
         xFkbUBA/pJmexOh0b35LhkxO3ylCpfarMM7ML5IBwdVHgdQ5sk0KqQxQfRj6gnWZOlcq
         oS+Q==
X-Gm-Message-State: AOJu0YzovbLvkrf2KTow0gJKCjEjFAA9mxrSqv2mLzj46DlkfrtgsymR
	IvvvJhnncrk1Ekvc0FsZIq+x28DNWyQ8Cd+zp/y3Flkg41gUq/32ff/vxgYIAXw+WjqVGZm+OVx
	aMOuC/W726AQUiWnZ98U9YFjawlUNu6tPHb9rDlXiSK+ewOS1PvASrNM9vTBMQTPm+c8kLilu7f
	VypaGH0/AGv6DYZ+QkLqICGm2OIKJcfPYjQ/s=
X-Received: from pgjh21.prod.google.com ([2002:a63:df55:0:b0:c85:6b39:d407])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:492:b0:3b4:6a31:6d0f
 with SMTP id adf61e73a8af0-3b7e4deb96bmr4370444637.41.1781617207383; Tue, 16
 Jun 2026 06:40:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:39:55 +0000
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616134000.2733403-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-3-praan@google.com>
Subject: [PATCH v2 2/7] nfs: Track number of pinned pages in nfs_page
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22633-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41FEB6900D0

Track the number of pinned pages in nfs_page to handle unpinning
correctly, ensuring that only primary requests perform the final
unpinning operation, preventing subrequests from incorrectly
performing unpinning on behalf of their parent requests.

Add wb_nr_pinned to struct nfs_page to store the count of pinned pages
owned by the request. Update request creation and cleanup helpers to
initialize and use wb_nr_pinned for primary requests. Use the
nfs_page_array_len() helper to calculate the number of pages spanned
by a request's offset and length.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/pagelist.c        | 9 +++++++--
 include/linux/nfs_page.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index faa8bc1c6526..7d51e10fe97a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -455,6 +455,8 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_page(ret, page, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = 1;
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -487,6 +489,9 @@ struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_folio(ret, folio, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = nfs_page_array_len(offset_in_page(offset),
+							      count);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -565,14 +570,14 @@ static void nfs_clear_request(struct nfs_page *req)
 
 	if (folio != NULL) {
 		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
-			unpin_user_folio(folio, 1);
+			unpin_user_folio(folio, req->wb_nr_pinned);
 		else
 			folio_put(folio);
 		req->wb_folio = NULL;
 		clear_bit(PG_FOLIO, &req->wb_flags);
 	} else if (page != NULL) {
 		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
-			unpin_user_page(page);
+			unpin_user_pages(&page, req->wb_nr_pinned);
 		else
 			put_page(page);
 		req->wb_page = NULL;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index fd7aafe7cb54..080fa3e23580 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -59,6 +59,7 @@ struct nfs_page {
 	struct nfs_page		*wb_this_page;  /* list of reqs for this page */
 	struct nfs_page		*wb_head;       /* head pointer for req list */
 	unsigned short		wb_nio;		/* Number of I/O attempts */
+	unsigned int		wb_nr_pinned;	/* Number of pinned pages */
 };
 
 struct nfs_pgio_mirror;
-- 
2.54.0.1136.gdb2ca164c4-goog


