Return-Path: <linux-nfs+bounces-8372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDEA9E6401
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C641882656
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35652155C94;
	Fri,  6 Dec 2024 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gR4qaz/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tayg5DCs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gR4qaz/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tayg5DCs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE149E1A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451594; cv=none; b=Mu4uthEhntdZZi+rCesShUUiFBzOMALgTSUokF4RfXvM0fkUMY5SgylK2NATaf6ePkeamGpXPeSYGjSKWkfShrA9qhx1eVDpuTDmOHut6uXZBrreE/vFF0K5nA4y3aekJHdzVn+XRc12XlYfEWvqQRj3VCibMICniQlVt0AWQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451594; c=relaxed/simple;
	bh=OrTTmtRg6G9tqsvy+Cwuia24zNh303uPtcluolBh2rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlRwGp6YOwoqoqT4ZPRi+MLzvQDAIkxTCN9RInolylwfPCIPGqFgqxBwbli2WNirv3Z9BeIfeLdUxydB/HnXmEzgC2sIovMjdT7S7HPBExkl6NkgGiSoJd5KkOAWUBh0YXXEg8udyr0AFyJMuI9jNQu6Sc1QVma7/pxYoGFglzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gR4qaz/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tayg5DCs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gR4qaz/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tayg5DCs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB96121167;
	Fri,  6 Dec 2024 02:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea7lS4kOxBzi0yj9Ar1Y+7O4UKHILi353AR0tZkBeSE=;
	b=gR4qaz/4tMIh83sMO/cAVLaU/XBifgcfF6J13fE6CtKgLEq4R+5le5iCn9LozZmvid9vwa
	BKHNYBAUXwV2xx3392Du+mIyHeCWDs5ShO+7/RheMGDP1bBwOaqWOkYJGMEOlf3P2RjomG
	7tqq0SXts43nLn9eEDW7lSSI/E0s6Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea7lS4kOxBzi0yj9Ar1Y+7O4UKHILi353AR0tZkBeSE=;
	b=Tayg5DCspjNQYosQ2weMiIqNqng8kMY6c1dJNDYcx5w2RdIbf8W3to29RRwo/DaM6sD/4O
	3q3Jb/1e0RpRrnCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="gR4qaz/4";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tayg5DCs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea7lS4kOxBzi0yj9Ar1Y+7O4UKHILi353AR0tZkBeSE=;
	b=gR4qaz/4tMIh83sMO/cAVLaU/XBifgcfF6J13fE6CtKgLEq4R+5le5iCn9LozZmvid9vwa
	BKHNYBAUXwV2xx3392Du+mIyHeCWDs5ShO+7/RheMGDP1bBwOaqWOkYJGMEOlf3P2RjomG
	7tqq0SXts43nLn9eEDW7lSSI/E0s6Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea7lS4kOxBzi0yj9Ar1Y+7O4UKHILi353AR0tZkBeSE=;
	b=Tayg5DCspjNQYosQ2weMiIqNqng8kMY6c1dJNDYcx5w2RdIbf8W3to29RRwo/DaM6sD/4O
	3q3Jb/1e0RpRrnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9536B13A15;
	Fri,  6 Dec 2024 02:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9cGZEkVfUmdgJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:49 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 09/11] nfs: add memory barrier before calling wake_up_var on cl_state
Date: Fri,  6 Dec 2024 13:15:35 +1100
Message-ID: <20241206021830.3526922-10-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206021830.3526922-1-neilb@suse.de>
References: <20241206021830.3526922-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB96121167
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

After setting NFS4CLNT_RUN_MANAGER we need a full memory barrier before
it is safe to call wake_up_var().  As that setting is "atomic" it is
sufficient to use smp_mb__after_atomic().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/nfs4proc.c  | 1 +
 fs/nfs/nfs4state.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..37c8aa1f3e1b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10847,6 +10847,7 @@ static void nfs4_disable_swap(struct inode *inode)
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	smp_mb__after_atomic();
 	wake_up_var(&clp->cl_state);
 }
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 556b521f17eb..189d7b57cb74 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1207,6 +1207,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
 					   &clp->cl_state);
 		if (!swapon) {
+			smp_mb__after_atomic();
 			wake_up_var(&clp->cl_state);
 			return;
 		}
-- 
2.47.0


