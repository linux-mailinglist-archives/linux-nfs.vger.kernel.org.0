Return-Path: <linux-nfs+bounces-12559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2DADEDA1
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D351898AF5
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2962E889D;
	Wed, 18 Jun 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnX1nuFO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596B2E54C5;
	Wed, 18 Jun 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252774; cv=none; b=nPj/jIXa1Y8RzJQbT4Z5WLlRf3+Z1FkyVl97o/6GX6yNR+xqsrsdppqPF526T35rP6ho5jFWvg+/qeLFdXjSTtwT/LJ4w1ixZyVF55yFG+TBAP0V7MogDb/TglHtv7nzaeFsh3spU0dopY7MbF23NlK+v1vX0wdIEK1YZTvyonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252774; c=relaxed/simple;
	bh=cEVNTymQyEoLW8LNl0dbE+EwAXQIKxWKTXC0FaiYbaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRlOaqEIfAAV3NqnzSSCQUs099AoeIqzwtmvPUim6gFbJCmDvs98OUlQs0c8PvIl2pxRKjZwuKcUajVolnHN9fubkgfgEORGAeEpfXXiZ5d/bggfYZmF2iFfriEOjqwjWmFuW1P0BOqqtA0xidKwgM+do8qjirC7b5e/YixQnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnX1nuFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78473C4CEF0;
	Wed, 18 Jun 2025 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252774;
	bh=cEVNTymQyEoLW8LNl0dbE+EwAXQIKxWKTXC0FaiYbaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnX1nuFO3g/mGM54QpOM682oD66yFo+oegyo5UQ6u8aiJzOj77ZiAapTznVn0hKpq
	 /uE6hNX6HHZDzfhGHhQG5lDtiHzGYTFA+8zFLhZbi4lAYbNkg7jQSR0cZr4WMH9Vev
	 ijYnWBw86G3DhDG/iGmcNFBlLZfeZVb0F7YnA/iJPRqgzOhW98WZ6A67HQTh94Tvqx
	 h7idIKMsZ7EF0Xn8vWnzjVADq5hU6+VMOZq0rLJ4n1TG9Pmzqzv/NeLamtpIqbjGo3
	 pgpbGtOyqyqsOLCpIHLbB1dfGOnCra2KfQzgHEHQcfylfRZDttFLs3pmYyxjFqptOd
	 qI+UYFFG32h1A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 09:19:12 -0400
Subject: [PATCH v2 1/4] nfs: add cache_validity to the nfs_inode_event
 tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-nfs-tracepoints-v2-1-540c9fb48da2@kernel.org>
References: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
In-Reply-To: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Coddington <bcodding@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cEVNTymQyEoLW8LNl0dbE+EwAXQIKxWKTXC0FaiYbaU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUrzjZURfKUsFTAqdCGO/ckimfh3RAZyMvrfud
 AhynZsPljSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFK84wAKCRAADmhBGVaC
 FRo4EACUs2E4eTW/GtfEj4fE6TFzFDdIkWzrQE46ahoT4c4vHXrTADNVxgiXdNnY4K+j7PW9B4a
 aX04jLGEDic+1ULS1iNZ+IA+iLwCs6hVz0i8FJT3irUlr+rh0Nxc710niZSzGxsfgiBUvq47Quv
 VCcVcwTRJRIFhTiSfv1NMyNUssAnypXU8o85HejDFi39tw/P5ZggN3H9TQJ/KNEqY0E5DvRop/v
 RaTLROqIDTnykS6ttYJq6nd57a3HqjHMLOXf10mTRTTYP9tE6ueBpIxm2g+ch9gG/dSFajBBm/L
 vHvvyA46pBgZyaQGIL2WxIsr1Okw7sf9Syy16l7t+eC8qKFMxYgDHaHG9ojzhSNO93/ttv4zdmV
 Nxa/X5GQTCO7O+1zbY5g34Ah2okJqteGd/GUz+v7f+dIiKPMR/zgLs3+if2k0gLvRZj3f2en0YM
 JCi2fsowu19RLi7C1T19Y9/c8JseyB1xIsJsALxq7uLuoXQY1Lt7RWIJi1vnaajKAkZUndg7Gk6
 ZSWlqdQAsavXlvSfLLGMRBatMT6wfrRu1MG7VIVf7pR5M90o8iejBp0l7aZATXvYTcv87z8WoZU
 sFqdUyxC7fclkS8bgLbisa5iP9U+BxvMWzfkrO4mph3r+OWdVd1EYp+hI5w3l+T9UYSlBHSJpTQ
 oRg2K5w1EIE2Weg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Managing the cache_validity flags is the deep voodoo of NFS cache
coherency. Let's have a little extra visibility into that value via the
nfs_inode_event tracepoints.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7a058bd8c566e2976e24136e2901fbaa7070daac..55170cbf2ff115c85f56cbafb4fc0e06313918cf 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -56,6 +56,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(u64, version)
+			__field(unsigned long, cache_validity)
 		),
 
 		TP_fast_assign(
@@ -64,14 +65,17 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->cache_validity = nfsi->cache_validity;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu ",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu cache_validity=0x%lx (%s)",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			(unsigned long long)__entry->version
+			(unsigned long long)__entry->version,
+			__entry->cache_validity,
+			nfs_show_cache_validity(__entry->cache_validity)
 		)
 );
 

-- 
2.49.0


