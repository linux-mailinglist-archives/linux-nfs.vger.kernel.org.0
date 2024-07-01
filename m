Return-Path: <linux-nfs+bounces-4482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0D91DD13
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91436B24C58
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23813B59E;
	Mon,  1 Jul 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="umTBw2hI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrntKHCh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="umTBw2hI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrntKHCh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761E12C491
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831068; cv=none; b=GntpSYCS2F+bhtTctFfrwnzsYX4nfLhUvDJd6t8l0r1c13SOZmWSt5CUS58kE3t/0e39TIC1KX7gmAi895IaFRS9ZAx5qxygz58jGBOuCTDhbvl5OTUmISDVLEHMq6WyBOTPeqCcN691NIoAPVj+brmhl+sTZRXj37+n/Irr6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831068; c=relaxed/simple;
	bh=Yu5E67eCRJyBriuDiXxjFJAxZ1jtzEDh611a6togicY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umaPqOgC5o2AGZtEXU+lF9AuBBtxs7Fi8c625fzyXfCo7XyRoawK6iAe614XKlpv/MRG0KEaFJrRqmVD1DCY9A5/SgGA5KSjkfYpDUXGF3yhqCEV4+FZGra5/dtg+RiKxfLb8m/KE4eqpXImop/uF3Pv80pTq0Bs1IMS/pQR9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=umTBw2hI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrntKHCh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=umTBw2hI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrntKHCh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AC391FB3D;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8rOhWv36GLnu3ALR5iB/Y6ldaN6h4X/wKLPlWdLhTc=;
	b=umTBw2hIkmqms0lfcI3viV1AjTkCH4OZzCAlawV8wY+zQSgU81MHhbuMuZaY7li7sOmCJv
	81r4q4ywvwMBUzWALv5v6THwSwhMjkG0pKQ9cG2WWUoaVLMH7T1hwX7LyqQU4NtFvUrjzg
	G8bgILfOw8ZGSuJoms95L/R/qd1p54w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8rOhWv36GLnu3ALR5iB/Y6ldaN6h4X/wKLPlWdLhTc=;
	b=XrntKHCh1jxTRXUFIjNzThjmfidrP+RNBbcEY4UFRqY8zCVAJh0h7kOvEExp3kg7lx1IAP
	NWwFKz1Fq8HXrxBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8rOhWv36GLnu3ALR5iB/Y6ldaN6h4X/wKLPlWdLhTc=;
	b=umTBw2hIkmqms0lfcI3viV1AjTkCH4OZzCAlawV8wY+zQSgU81MHhbuMuZaY7li7sOmCJv
	81r4q4ywvwMBUzWALv5v6THwSwhMjkG0pKQ9cG2WWUoaVLMH7T1hwX7LyqQU4NtFvUrjzg
	G8bgILfOw8ZGSuJoms95L/R/qd1p54w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8rOhWv36GLnu3ALR5iB/Y6ldaN6h4X/wKLPlWdLhTc=;
	b=XrntKHCh1jxTRXUFIjNzThjmfidrP+RNBbcEY4UFRqY8zCVAJh0h7kOvEExp3kg7lx1IAP
	NWwFKz1Fq8HXrxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D4D113AA4;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWBOHhiKgmY0LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 10:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28486A08A9; Mon,  1 Jul 2024 12:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/3] nfs: Properly initialize server->writeback
Date: Mon,  1 Jul 2024 12:50:47 +0200
Message-Id: <20240701105056.25535-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617073525.10666-1-jack@suse.cz>
References: <20240617073525.10666-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=711; i=jack@suse.cz; h=from:subject; bh=Yu5E67eCRJyBriuDiXxjFJAxZ1jtzEDh611a6togicY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmgooG1CDZahFESXIF/SMwxrQbvoLCxy49f7rPp1Z9 YnWq2BqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZoKKBgAKCRCcnaoHP2RA2fUVB/ 9oYOauzj1a0rBJfVOaClBkA6G+suzvrpZYyUczxwu0e2+sJhJ8SE5OVjYsyp0JfdHQSpXykuEpIveR pkAUp4jlF6GUMssEn7JScw0dxkxwxuSnJ++upQ88eUSBUWCf97sPM/3qDE6s5aIU+39xERYUCXAtm8 w67YyQPrWsJ2LSJLiVrVAq9KEHumNwLS1SuNZHYCk1rY5vuwA4MuJi3lmw4OIohBEpGwe+51x2B/xW qrPngSMm4qOdMb/KLgH51yvPRFlGsE7D4f/M5No3fbzdWo9FuJDyHCRjeATVS4WjsbQRM+uD5FQ9e3 J4iWiYoYLbXPfCICOSSfg6f0AtJpy2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Atomic types should better be initialized with atomic_long_set() instead
of relying on zeroing done by kzalloc(). Clean this up.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


