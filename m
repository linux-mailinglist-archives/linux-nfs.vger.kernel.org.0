Return-Path: <linux-nfs+bounces-3744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1549066C4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B644B22A60
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262613E046;
	Thu, 13 Jun 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxHBUXZr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r7ePrbuf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTvPyopD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+fkAX6R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABA13D51F
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267322; cv=none; b=Q1ri4YycV2+sKXXBKc3b5MS4UwpRCG8hV2hrV7DQxABaApesbwi/jGLrYJhbmZrZu1s98dxzuWINBYIN6VgamYMSl0JVbGCh5Z7gn0lqLnD4lPaQpA4aYGXrt7Bua22gZWv8NsFYU5tPt2OOZ6tYbGMJSNgrdqO6grlXcQgneGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267322; c=relaxed/simple;
	bh=DY8AglSEqJ2V5wGwE1jSoYjtETgB7p7ptF7rYPzQfeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSpBChus0iQquQqKfFxcXJR9Yl0hcZP/18KO4Q7SnCrEOpzxIlRxxHzVouY0ZXAWd2OXf78/BuhiUG18SQkVqO2vorfhY2GvwhfncX7R7/Bhr6dWrsOXUHAvmjVaOGwkmv20GLj2cQMmjZA3KZt0dMvf3Pd4gMZAlxOr5FP0rgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxHBUXZr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r7ePrbuf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTvPyopD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+fkAX6R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F118F5D008;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/c/ksSl9a6tlSWlpt55jFzAy3CDGUbd8VqyAbiaI0A=;
	b=IxHBUXZrWxfJ4AHnjV0Mkafj/7NCWHsSiXo0ZzwlScox4uCpBLaxcZ4nnQJG0rRfGtnDYF
	4w2OeIP99F0PtC1b+BmmQ7gNeut6WpqKs8YMZdy239ERCt54Rjwp06xh4thOHLS8cq1Jt8
	Ucb/QxD5j29bllSkGqoMJMXk+n/hBQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/c/ksSl9a6tlSWlpt55jFzAy3CDGUbd8VqyAbiaI0A=;
	b=r7ePrbuftRWQd/It9Hoa7ojii/I8vs0PObLRK+uLaueM68Yh7wrSduUhQ0baTmY8DGJrj0
	uUT+XHpkgCbGckDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/c/ksSl9a6tlSWlpt55jFzAy3CDGUbd8VqyAbiaI0A=;
	b=kTvPyopD0iGM0p54uBcy5z0MrqHX2lrmNTnYghsbOdaYigXxWWoZzaI6pWZ8RJVLC1llkP
	1Q7LeIx2XB7MkZ/OX0Mfu4TPb7Zy7qiGgNsR+sxiaixXKXYllrmUQqzYciRkTMjfY8o5J/
	gph6DG2NmjVumAcdiZRCTgGGgGV1Dc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/c/ksSl9a6tlSWlpt55jFzAy3CDGUbd8VqyAbiaI0A=;
	b=7+fkAX6ROU2YF6/91mUOUAxyO7eC4OleCrDGy7dopI35AY9/KZKRgo6C1xPnFyxKyEkVLe
	3M0lqnFXvBAN99Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E504213AB5;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id opVUN7StamZBXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 08:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 819A0A088A; Thu, 13 Jun 2024 10:28:21 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] nfs: Properly initialize server->writeback
Date: Thu, 13 Jun 2024 10:28:18 +0200
Message-Id: <20240613082821.849-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240612153022.25454-1-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=jack@suse.cz; h=from:subject; bh=DY8AglSEqJ2V5wGwE1jSoYjtETgB7p7ptF7rYPzQfeI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmaq2hSW/npDwR3m9WDs54716PPIqNh2L522zTrbmY X9lQCuyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZmqtoQAKCRCcnaoHP2RA2TWnB/ 9x4/wQtiumA4/Veiy02wqM1OXVZdGfLMN3UWnFtf3ChoQctC+ORrYqq30n01ZtJzpP/LvJUElcxkQy f9S6h/WfUeXSqrHuT0d/z4O5lyGryQMCCOGjuvhD+/uU+BXI3W8YeQXhyvpShtYXAcks1TRdnKFAEJ bY3xrwH+8uQ29o90h1udMej3xyqSAAjG4vtXgLXl7NhFCWxWjS2V14SFLS7G9k9FItYxm1YVqTPrG+ Tpq4OgCHu5OItnZGO6SH8oZuDUhST7B/OlEh8IvpmAci+KjvWI8m5Qt0ws8maiyYJPcy2Cu40uU3qZ QTS9yNV9UhmXqGyHRmXDTqk5Plao49
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Atomic types should better be initialized with atomic_long_set() instead
of relying on zeroing done by kzalloc(). Clean this up.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index de77848ae654..3b252dceebf5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -994,6 +994,8 @@ struct nfs_server *nfs_alloc_server(void)
 
 	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 
+	atomic_long_set(&server->writeback, 0);
+
 	ida_init(&server->openowner_id);
 	ida_init(&server->lockowner_id);
 	pnfs_init_server(server);
-- 
2.35.3


