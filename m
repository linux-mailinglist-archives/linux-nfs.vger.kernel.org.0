Return-Path: <linux-nfs+bounces-22223-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ooE3NjK8H2rOpAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22223-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:31:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A46344A5
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=r9IaPBOM;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22223-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22223-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D2830C1837
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B337CD2C;
	Wed,  3 Jun 2026 05:30:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09313750CF
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:30:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464643; cv=none; b=Ui8RvaxIuxDznhDTeOVWg13/b3jVpUx66rmx4IYgBXN3DYih6TDfI5YSV59TNS2/JeouiSNXqQTFrXxk1/qZtREA85EFA5Qol/vTreYEaYblzRcHL3XK3b11KchRyU70L5p6LARg1CVbRtGwIYgNZVSidfrhoDgNVRQaSh8lEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464643; c=relaxed/simple;
	bh=n0mH3N7dN+6P/rXhifQricOYElYnonXD4V1GRu+wSQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOLNtYuCRYtwztA+xxzASgSbY/6V74PIHhHUCBiZEcbpkZVoEwb90QwME4bU22yEHQiB7jkDQFBAYTsq1oV5sGmnY+pdTQxZCETCbIfAplwgmHGnnUH0vOx7mn0xE7i/4uB5DPhVWfYrbnQc4pPsMQG62XhiPD00j4DckDh0Slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9IaPBOM; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so2131793a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464641; x=1781069441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUizU4Vsty2onsNNFrCgDH72BT/u0SfXPzmHgHi1tzY=;
        b=r9IaPBOMnm49cjBY8ijsGoglRei5LU2mtt3hUL/hvGKjkHgKLmHLr9rqCQz5gs8dHJ
         //eKIGL/BkxryXO2TJju1BqBgTFViJ7xAZ6wyZ4KyPg42PIWlUrC8M8RVjXZcGZZ/j+H
         EIoJj/zJcM0xvrFgigbbaMOvb+srDKnuq4GRq487sZFdVwCoQJRYL7RJlvZXRZNZOkqX
         BByRdj7iGttWON/B9wo4bu5FOCV5El/Kf+SAmeSG5WbaYp9tdEF7Vh/78d2dokADR9qr
         gIQJfwl4Qc7JfEJ5WSBiVJk4P5RpzuEtK+noPZ2owTEFrgxQHI9CAOCJvTfx0TpZOmA7
         4FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464641; x=1781069441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUizU4Vsty2onsNNFrCgDH72BT/u0SfXPzmHgHi1tzY=;
        b=jAl4yeRPYZ8qUASiLk0hku47q50jPh3Czba7/TSXXidNAk6PB9sRO0x3aOADUnrGL1
         DNFQNWoMxGthBtty1w4OqqeyDYg0/I8rXf2tKyQ9Qo3LeMmDEnLIXeUlkFsOLcy7jdT/
         fZi4CwlIw8r2sFZdxFZybfcK9rYKaQJxwhzu76HnniAmvUa4pgPJiCklQ2QAbvRrktTM
         6C/RsOzXaltsFTr/fGHybVDg+3EdU6m6StdWvXfhFXl0GFzBBHAT656+ptRvq+Ww16gd
         cqn3GMXQv3/pka/MkGvILE0DWBB4CFoYpniyXk+90U4DwL2uTNsUpIhj5Nw2Id+z1qkl
         QQjQ==
X-Gm-Message-State: AOJu0Yzz2pTRkrcujgfqmtV5q7ZhV+u9+UZb9QNQn5bzVaoGkLzOSNPA
	vsrI9B84j66WnG83iuT8F9o0/tFb+CHRKJHplIPGdE6J2Shalux0HSyvbYQWM7AU3tYXCEyqcwk
	Nk6y22kJ4MBcyq/SYRVqaz+vyypq3Nil/3mhe2BmWsRq4UF33eoZDpzVhbBpIhOP8H7G0M0VD9j
	zCAaao9Au4/nSOkLuhUvnCnsdDwG07zz/ybvc=
X-Received: from pgbcp1.prod.google.com ([2002:a05:6a02:4001:b0:c73:8295:1401])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:549b:b0:3b4:7eb0:47a1
 with SMTP id adf61e73a8af0-3b49742220emr2047732637.19.1780464640786; Tue, 02
 Jun 2026 22:30:40 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:30:28 +0000
In-Reply-To: <20260603053033.3300318-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603053033.3300318-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603053033.3300318-3-praan@google.com>
Subject: [PATCH v1 2/7] nfs: Track number of pinned pages in nfs_page
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22223-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583A46344A5

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
index 5c5601a27663..f59449918be7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -454,6 +454,8 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_page(ret, page, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = 1;
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -485,6 +487,9 @@ struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_folio(ret, folio, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = nfs_page_array_len(offset_in_page(offset),
+							      count);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -563,14 +568,14 @@ static void nfs_clear_request(struct nfs_page *req)
 
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
index 9ece78f1b788..295280fe9571 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -58,6 +58,7 @@ struct nfs_page {
 	struct nfs_page		*wb_this_page;  /* list of reqs for this page */
 	struct nfs_page		*wb_head;       /* head pointer for req list */
 	unsigned short		wb_nio;		/* Number of I/O attempts */
+	unsigned int		wb_nr_pinned;	/* Number of pinned pages */
 };
 
 struct nfs_pgio_mirror;
-- 
2.54.0.1013.g208068f2d8-goog


