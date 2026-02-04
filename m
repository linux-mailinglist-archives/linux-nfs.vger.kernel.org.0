Return-Path: <linux-nfs+bounces-18663-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDY7B+2bgmlgWwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18663-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 02:07:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A088E04E2
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 02:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9603021716
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 01:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE21EE7B7;
	Wed,  4 Feb 2026 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA1U954m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC641E5207;
	Wed,  4 Feb 2026 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167055; cv=none; b=LuqJMMpwBlWLPmymbcW/pNT5BR9VTzK2QZrWWckcRUnR9oF5+E2MWsGFMFA1exPCdFEjx0vn3s1riiTSxMi02815QT0GuqBGd9W+S5NC6BYUPHUwOEGhKPhhRuaPch+R7KemCesPkz+y1nmuQyXAzkRQqp6iR3FnuVIx3gPRk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167055; c=relaxed/simple;
	bh=oHfyB86S699I2l7vasQsJbgTXIDWhFxuxsXjPxNEoW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvqwXMlbSsYOWDJszNcbJThBiiNItjjcJ5YZTai1AAgOaJSw99UqXMEUZ8I2FBPovBZNIZXuwfGptvXM6oz7V7By+kbPgPH8SZRz2MkRUIqHe0cf4HdeXgZuzSfbar5omwSDVdfXj9PRRl0Ju9s/8vyzUG7zkgpaKQYMdLMld+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA1U954m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770167053; x=1801703053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oHfyB86S699I2l7vasQsJbgTXIDWhFxuxsXjPxNEoW4=;
  b=LA1U954mFWz++k27voeo2LwJYfBr89x+/ZabtqAbl5W89iKB1RQnJRj3
   YNWz8pMvGfJXKcxWR/MSqQzBm8k20Os9zeTYPcvcwNLhu45PjWj0NT/E7
   q3k8hCVTt1mg+BpL1qSQD5SVHUwoMTRU9bP5uXKTDemkanWSHoc9RgmC4
   nqVedGYvdoCGljPtf0Xa7z31pNX9t52EpHvilpnAfitmwd4VZOkrbbQHD
   ZuqRXQ1bkkYrDnzs+WnBDMaES3mgxf993rCpYD+Kk0yoPaALJ29sE0V/n
   7rZASqVac8CBpxz/b7q/ugzjxGh8lim2/q9U5dlnaqm15ezweYUL7e4t5
   w==;
X-CSE-ConnectionGUID: 4JsEqhFnT6GwlZM9GbukdA==
X-CSE-MsgGUID: 4fT9a1QyQEilM2h9Gv4GKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96804942"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="96804942"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:04:12 -0800
X-CSE-ConnectionGUID: gC3WHVmFTBWT9DglHP+yEw==
X-CSE-MsgGUID: Ifs6i89gQ1e1g5UhBZWCfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214556524"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 03 Feb 2026 17:04:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 98D5895; Wed, 04 Feb 2026 02:04:08 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
Date: Wed,  4 Feb 2026 02:04:02 +0100
Message-ID: <20260204010402.2149563-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18663-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,linux.intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A088E04E2
X-Rspamd-Action: no action

Clang compiler is not happy about set but unused variable
(when dprintk() is no-op):

.../blocklayout/blocklayout.c:384:9: error: variable 'count' set but not used [-Werror,-Wunused-but-set-variable]

Remove a leftover from the previous cleanup.

Fixes: 3a6fd1f004fc ("pnfs/blocklayout: remove read-modify-write handling in bl_write_pagelist")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfs/blocklayout/blocklayout.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 0e4c67373e4f..83e4a32b3018 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -381,14 +381,13 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
 	sector_t isect, extent_length = 0;
 	struct parallel_io *par = NULL;
 	loff_t offset = header->args.offset;
-	size_t count = header->args.count;
 	struct page **pages = header->args.pages;
 	int pg_index = header->args.pgbase >> PAGE_SHIFT;
 	unsigned int pg_len;
 	struct blk_plug plug;
 	int i;
 
-	dprintk("%s enter, %zu@%lld\n", __func__, count, offset);
+	dprintk("%s enter, %u@%lld\n", __func__, header->args.count, offset);
 
 	/* At this point, header->page_aray is a (sequential) list of nfs_pages.
 	 * We want to write each, and if there is an error set pnfs_error
@@ -429,7 +428,6 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
 		}
 
 		offset += pg_len;
-		count -= pg_len;
 		isect += (pg_len >> SECTOR_SHIFT);
 		extent_length -= (pg_len >> SECTOR_SHIFT);
 	}
-- 
2.50.1


