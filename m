Return-Path: <linux-nfs+bounces-12211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD3AD207A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6569C3A808B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318055E69;
	Mon,  9 Jun 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="to6FveuA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="to6FveuA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB874059
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477698; cv=none; b=hHiQpRQJjlSZv2kBNES/jLGHJX/RMeeGWSO74U/izGE6sVeO6EOgH83AXNs80qP8/hzwy7Ld9tmlCR0gbId9bBPfNGfOC3WV9cZL7F280sLJX9d/xNXbemv3ZN9EqDSWoF/We/zotdl5JB+NydXKXbl7InIPj9mTOztEP1fAC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477698; c=relaxed/simple;
	bh=H4yWfDvPCU72DdZj/OmzLpPzouaKk7tRaQVMOjy1fnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8OAh6k4PQ29fYWzT6D+tommSOGk9yrqHDM0hi+QP6p31lxJfpWhEMqwbR5oOk54jOuY2Id85R4qWf4tUH+13TdczTz0/+Vg8RrDvDplVemGSN8EGgrBodvjPZwBkHh60G0rmO7SVQNgswliN2VOL7KwlIFzowkE3q3StcltGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=to6FveuA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=to6FveuA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0CAB1F38F;
	Mon,  9 Jun 2025 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749477693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cD1VoC7ub0iYuo4lZgkGp9ZXTZ9QnFyFvBLJgvVxCzw=;
	b=to6FveuAcy/1QMJlAnmqsTIoKPm+QUL2vQnmM4+ryR7BrLLE87UYUtaBzwcGJhybLcPBCM
	phCQmSdBl+JZ5VhhiZ6K/+bF8wLPWSfvJ0x/myf36UXCwr4j61X8mszP73/7BJtoSE+7Dp
	iZFnRYtuSyRQE5VLwxCC2WbHW1Ns+EM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749477693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cD1VoC7ub0iYuo4lZgkGp9ZXTZ9QnFyFvBLJgvVxCzw=;
	b=to6FveuAcy/1QMJlAnmqsTIoKPm+QUL2vQnmM4+ryR7BrLLE87UYUtaBzwcGJhybLcPBCM
	phCQmSdBl+JZ5VhhiZ6K/+bF8wLPWSfvJ0x/myf36UXCwr4j61X8mszP73/7BJtoSE+7Dp
	iZFnRYtuSyRQE5VLwxCC2WbHW1Ns+EM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82AC813A1D;
	Mon,  9 Jun 2025 14:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8PRyHD3pRmigZwAAD6G6ig
	(envelope-from <antonio.feijoo@suse.com>); Mon, 09 Jun 2025 14:01:33 +0000
From: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To: linux-nfs@vger.kernel.org
Cc: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH] nfsroot-generator: do not fail if nfsroot is not configured
Date: Mon,  9 Jun 2025 15:59:11 +0200
Message-ID: <20250609135911.48232-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Level: 

If the user configures an alternative way to boot the system, the
nfsroot-generator should not fail.  In other words, the presence of
the nfsroot-generator in the initrd does not imply that nfsroot must
be mandatory.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 systemd/nfsroot-generator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/nfsroot-generator.c b/systemd/nfsroot-generator.c
index 52bd0752..f3cb60c3 100644
--- a/systemd/nfsroot-generator.c
+++ b/systemd/nfsroot-generator.c
@@ -78,10 +78,10 @@ static int get_nfsroot_info_from_cmdline(struct nfsroot_info *info)
 		/* Mount type: "nfs" or "nfs4" */
 		colon = strchr(root, ':');
 		if (colon == NULL)
-			return EINVAL;
+			return 0;
 		if (strncmp(root, "nfs:", strlen("nfs:")) &&
 			strncmp(root, "nfs4:", strlen("nfs4:")))
-			return EINVAL;
+			return 0;
 
 		nfsroot = colon + 1;
 	}
-- 
2.43.0


