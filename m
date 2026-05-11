Return-Path: <linux-nfs+bounces-21458-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MidAgHFAWqSjgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21458-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:01:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CC50D409
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C82D30459C9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBD37881F;
	Mon, 11 May 2026 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6GMfdxP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C4377555;
	Mon, 11 May 2026 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500725; cv=none; b=Qu4Dc6dtYNcxXcM4F478KbGV1O7sQ5hi4fn9GJ2UfkGloSCO7Oa4EyS8J+d98nbq3CgETgqWu7Qrw/mBoNw+0MoLA14AAvFVG6yo0ETM1YfBqsLVdoiJ4efVx+OO7KgBpyQZ8+t9SMHbJLIUCzQo/cbX3x/EpV7yFWCkF1ElUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500725; c=relaxed/simple;
	bh=6R6WN7QnLwKTUc2bC5H1Z4sYb5q8DLb1p7kKZ09YbHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7d/0YuWdYyzcnU9JkrN+KHDq88WNpUMC7q/5ohVk1ATevowUb0iwyLiaE5bJ6dV6orBfNOFHJD7xA7CkWUV+G6OmUiVwCNMHGWOQ5PmjJtzCOc69Hr9cbj2KTn6Ey9oLrSGSdMZ6gRXvVTPGYIW2njV4GZioqaoQ0mruGNc3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6GMfdxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45600C2BCC9;
	Mon, 11 May 2026 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500725;
	bh=6R6WN7QnLwKTUc2bC5H1Z4sYb5q8DLb1p7kKZ09YbHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6GMfdxPoBnkQmf6f0ysMCxxkecaXuPL1FRe/aiVrCN5gHGBTjTiKh68s35ujlkI8
	 IFTxsjnaWspo9Crp/8/onQdUc29YJ2cC1leVMEWUgg3iQRFbS6BqXBTf1pzQyXb9zu
	 1TJEDr4uHdSm14vLZestczhSe5bI4gk+bYeDiTamxaxcmFD3ufe5Z0FH+mkvP0pqP6
	 +vKQ3Y9nqcJnXu6arPhEV2ZkErOz4AoeUxVv3yWaD0La0dBQLh3jxX6MZzTF7JDKt/
	 2TawDzCykxEPxi7s7cha/9G+B1ZJS03E+KNokDphYSkYciRuJio2XseexZ7yolfQtJ
	 0dsyFjuCFieog==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 May 2026 07:58:27 -0400
Subject: [PATCH v7 1/3] mm: preserve PG_dropbehind flag during folio split
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dontcache-v7-1-2848ddce8090@kernel.org>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
In-Reply-To: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6R6WN7QnLwKTUc2bC5H1Z4sYb5q8DLb1p7kKZ09YbHE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqAcRw/d2G69PENt9dpII3eX7moPHrfcJfJVKpz
 U2jJnpt2f+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagHEcAAKCRAADmhBGVaC
 FSjED/9B+1yQ1WSrNNdIhOxP4U+WPleq5eEldlJUXnR4U9UuQ/YPgnW30Hq1QkSq5ty0m8y/KE4
 AEYuxkB8dn2QqREbvLR8O7Loa4ODbWwRbjyX3f5XwYhpKUvCcnHvOU024VkKdYL8Pvr5gcLv9UC
 b6mg0hgxPVyVLGawrZZ5g8X1zeiuOXcqLt1sGzX7IuUP2R+DnXGx7nw81hYT/HEP8AexYoFNEOr
 sIgKtTqr6iFoMCfFjTuTxHqdDCUXuAWBzV1ie8uvQuQbOrthLwlL6TEUXee/qh+6tduhiOBqw//
 7t7m4rkTuh9jXRhQeJi6vzWJeAr+q7jdkguKYL1yndnzZxiLFeHlZMRog8bqFBG3UFfWSWR/vXP
 a10nr0XN7wpWsqyYIAF61tPIoODLz6N+3TMIt4Tr5X8sEFWLTKXzxyM8DecOhtmfIK5oB3CkVtm
 gDXuKXhYHwWmybz+d5fZEiZ7lUEMZswt/pcFGR1Y30S3UEuSrPsKom3Ddki1Ljf4+qAnv+1m8OY
 Vm80xMmiAGz50Pecc46IEeqOMTJras52eY6RFSRyD9TMsZs2xh4gcWZPTiI+UrSbLEvOZdyXki/
 VGlyMDvbI/Teu3yd5oE/IAJQQ1Z0EFRT1WJbkdlCPRZ9GWDZEZrXF6OaNgaCNhVq/NqXKPh7P3N
 aewMDqixNIZwhpg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 521CC50D409
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21458-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

__split_folio_to_order() copies page flags from the original folio to
newly created sub-folios using an explicit allowlist, but PG_dropbehind
is not included. When a large folio with PG_dropbehind set is split,
only the head sub-folio retains the flag; all tail sub-folios silently
lose it and will not be reclaimed eagerly after writeback completes.

Add PG_dropbehind to the flag copy mask so that the drop-behind hint
is preserved across folio splits.

Fixes: a323281cdfec ("mm: add PG_dropbehind folio flag")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..e01917b14d1a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3642,6 +3642,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 				 (1L << PG_arch_3) |
 #endif
 				 (1L << PG_dirty) |
+				 (1L << PG_dropbehind) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
 
 		if (handle_hwpoison &&

-- 
2.54.0


