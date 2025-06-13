Return-Path: <linux-nfs+bounces-12434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7456AD885A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573DB7A5185
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE02E175E;
	Fri, 13 Jun 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qbh3Zxmt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lNMnjAG+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B92E174F
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807939; cv=none; b=NkdLLZa+iRXcbA791jnyBjLaQ+5ReyWasPa3PVzuhEA5Vg2Q7o/UI8jwye7LBEoSzxS4Hfskf4xPcV0jH0/AicFwRJeugPEaApYMvIjx6yiTILmDaYIinfeGnstGT0rdgsRXwuCCl9soWbdiOMtBCUB2YRJAxFmmh7hcaYkEdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807939; c=relaxed/simple;
	bh=mDjMrcn2K0VCMZNL5P/VXX08pCzSzgHUbgzrg+UVUGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCyRkrHBgrbiRrVAVXjJQBYtlPl2sYwMxTGPLsKwBzpsBGOHXh3kgYQeeS1/5kNOIG88KD2rYjFrYRbD0vZpXlYo6eOYBDtutlXDgCOPZSmzeu0PYqVFyKfMbxc+/A0QcOaN1b2yqc//ruSP0gTGxaVh4lPZua6nJ+RW1vA1hy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qbh3Zxmt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lNMnjAG+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4C31921941;
	Fri, 13 Jun 2025 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f21kAadH4aFWoIi8fwdLDuBtbgfLrQgqhrLsstTmL1Y=;
	b=qbh3ZxmtFl+rh5+ZUrWhlexaz1ocgwOwmEntHUbViG21+HCRPFf2ebCEPZDLq+QkeLVzt5
	xR0H6DgXlbJMgXTYo4ExA1FN0FmJz/14Z+kXBOl8s2dm17eA5JqgR2+NX8HogZAaXiM5sg
	ej5hrtRW2wqHPqSJasnWymZc/dHE9IE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f21kAadH4aFWoIi8fwdLDuBtbgfLrQgqhrLsstTmL1Y=;
	b=lNMnjAG+Q/kIWqRNHbnhFZcj9GEOQKMzPYGQEonEAwzMV7rZkTz9d0PFbN8O0Qn85JTI0S
	i97v1GtqQOo1e/Hb+5hWLInDMiGqDY3/Dopt0yC3sXJP3gaLKreQj3iJ8qGHKxvMHFCcU+
	kcnYRepJYor+yxo273CjrEvtmrDyTkw=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: remove unused pnfs_ld_data field from struct nfs_server
Date: Fri, 13 Jun 2025 11:44:39 +0200
Message-ID: <20250613094439.82338-4-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613094439.82338-1-ailiop@suse.com>
References: <20250613094439.82338-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The last code that was using this was removed via commit 20d655d6197d
("pnfs/blocklayout: use the device id cache") which was merged in
v3.18-rc1, so it can be removed completely.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 include/linux/nfs_fs_sb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 05c1aa5fc4e4..128456820b6e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -246,7 +246,6 @@ struct nfs_server {
 						   filesystem */
 	struct pnfs_layoutdriver_type  *pnfs_curr_ld; /* Active layout driver */
 	struct rpc_wait_queue	roc_rpcwaitq;
-	void			*pnfs_ld_data;	/* per mount point data */
 
 	/* the following fields are protected by nfs_client->cl_lock */
 	struct rb_root		state_owners;
-- 
2.49.0


