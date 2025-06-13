Return-Path: <linux-nfs+bounces-12432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED4AD8850
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB12189D58B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C32D1925;
	Fri, 13 Jun 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nju5Fl7I";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nju5Fl7I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4642D5C96
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807927; cv=none; b=F4f+JPW9TI+6v8h+046DwGRfKX7z0w4l2Ru95Ja08BJgrffORjDjGL0TPUdHbRVfvjhVt4gGz6mI6LtuQr5XKEnGvXesmXphL+1FOAv9zQ5+HmnR/ZZlMgZ3PDvDeFnpxfRekNs1jfOFoo+4z/Op1ck8prq/Nb3xsLZHhpfobgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807927; c=relaxed/simple;
	bh=SCMhdPYhdnMrAc2QEb/wdVT3osg1xRzfXnY5IOpoH4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6yjyUOUpSPkHEeUymKzfIBrEA4wE9F8axYtR1T7ygtDBqHSJlrcmw+nfpfnswynIbjv0qUg0E9etd8ayvrXw+NbUVviF1ciDiAF6N4wyQ2xfrzSrhGYsqr7+VF/1wOmHCsU3nel+0NwgZDxf9Df4GRijsSwcWZTHKqOCOKgihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nju5Fl7I; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nju5Fl7I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id AAD1E2193C;
	Fri, 13 Jun 2025 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HL1G9zZy2l/ZUaCQdsPVX9F2Rbtyk7VjUXAOxmRWl0U=;
	b=Nju5Fl7IIs4HObNjDaSsEbQqtHleSj4E6ovkImOxZDCQDB9ngXTPCbG40lkeW9ItcTv33g
	r8AqXfMSwK6li19A8iqMBLnTGwsQCTWcC2QKMYghJj/4+O4Dasxate3R3aRXnqtd2O7kYo
	nocU3n3M7KwG4p7jg8jAnXUo9ek8GT8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HL1G9zZy2l/ZUaCQdsPVX9F2Rbtyk7VjUXAOxmRWl0U=;
	b=Nju5Fl7IIs4HObNjDaSsEbQqtHleSj4E6ovkImOxZDCQDB9ngXTPCbG40lkeW9ItcTv33g
	r8AqXfMSwK6li19A8iqMBLnTGwsQCTWcC2QKMYghJj/4+O4Dasxate3R3aRXnqtd2O7kYo
	nocU3n3M7KwG4p7jg8jAnXUo9ek8GT8=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: remove unused wpages field from struct nfs_server
Date: Fri, 13 Jun 2025 11:44:37 +0200
Message-ID: <20250613094439.82338-2-ailiop@suse.com>
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

The wpages field is not serving any purpose since commit c63c7b051395
("NFS: Fix a race when doing NFS write coalescing") which was merged in
v2.6.22-rc1. Remove it completely.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfs/client.c           | 1 -
 include/linux/nfs_fs_sb.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index cf35ad3f818a..23dafc590476 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -814,7 +814,6 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 		server->wsize = max_rpc_payload;
 	if (server->wsize > NFS_MAX_FILE_IO_SIZE)
 		server->wsize = NFS_MAX_FILE_IO_SIZE;
-	server->wpages = (server->wsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	server->wtmult = nfs_block_bits(fsinfo->wtmult, NULL);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 63141320c2a8..1aa89b41afd8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -177,7 +177,6 @@ struct nfs_server {
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
-	unsigned int		wpages;		/* write size (in pages) */
 	unsigned int		wtmult;		/* server disk block size */
 	unsigned int		dtsize;		/* readdir size */
 	unsigned short		port;		/* "port=" setting */
-- 
2.49.0


