Return-Path: <linux-nfs+bounces-8356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD99E6277
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B441883D8B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293F282FE;
	Fri,  6 Dec 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HFzyXfZ5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9k2TJIBe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HFzyXfZ5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9k2TJIBe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A9BE46
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446164; cv=none; b=BAKFz5NOJWnuDr+ckoTbtgNHUL7nLnn2uYYbETEJbH0KUzmJoUFpr0ou1BSrpo/6ZcwrtfUymAeuf8s6Ax7y2DfREEs5SspD9NdbVwDYg0c8DVkFTH+cxkL/nMWqKY3gFJihIT++DPklx5ZHGN3cto1Vn3I3UTXtqJuPrajTxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446164; c=relaxed/simple;
	bh=yU15DXWQh6k4/q5tw6s4+wj26LmBcj5OCUQY12ODzuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cda7igOHOTgee4kSMnFDSlJZIs2tvJWorsWnAImmmSHJn4gR2ulbVoOY8kb9x+h7pRtvqv4HImiNHYIDGAkNJHYN0exnM6SXu7W4wCz27lNZBfGlXsOaWhr3+ddtEhjUs2guNZQLzyLzBtyfSqcZrHDZy2+5lrxcmlWMLxwlgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HFzyXfZ5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9k2TJIBe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HFzyXfZ5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9k2TJIBe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6C93210FB;
	Fri,  6 Dec 2024 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=HFzyXfZ5teRgQeTlFpdlEYgswyJkytth4C1lG9MyiLEVhVkOGVh9sYlbtHQGyRy+VL2rge
	xFuu9HX4mdpT2rncCV3auSpCnmAuMGv5E0JX3KrNATwxq/8rNRgZVS7Y6B2ZLDD3mtZGc4
	Romrac7K9I/nDFYRKlrAxdjv6Dq1cjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=9k2TJIBeIRzZkdi/IxRiigGmOgCiFX52NouWNay3peFbDqNDGqlga1Y36W7fXHiR5yEKBN
	vEm4ub/AUe7rmOCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HFzyXfZ5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9k2TJIBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=HFzyXfZ5teRgQeTlFpdlEYgswyJkytth4C1lG9MyiLEVhVkOGVh9sYlbtHQGyRy+VL2rge
	xFuu9HX4mdpT2rncCV3auSpCnmAuMGv5E0JX3KrNATwxq/8rNRgZVS7Y6B2ZLDD3mtZGc4
	Romrac7K9I/nDFYRKlrAxdjv6Dq1cjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=9k2TJIBeIRzZkdi/IxRiigGmOgCiFX52NouWNay3peFbDqNDGqlga1Y36W7fXHiR5yEKBN
	vEm4ub/AUe7rmOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B49B132EB;
	Fri,  6 Dec 2024 00:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A38bEA5KUmfpDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:49:18 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
Date: Fri,  6 Dec 2024 11:43:17 +1100
Message-ID: <20241206004829.3497925-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206004829.3497925-1-neilb@suse.de>
References: <20241206004829.3497925-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6C93210FB
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Each client now reports the number of slots allocated in each session.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808cb0d897d5..67dfc699e411 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2643,6 +2643,7 @@ static const char *cb_state2str(int state)
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = file_inode(m->file);
+	struct nfsd4_session *ses;
 	struct nfs4_client *clp;
 	u64 clid;
 
@@ -2679,6 +2680,13 @@ static int client_info_show(struct seq_file *m, void *v)
 	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_addr);
 	seq_printf(m, "admin-revoked states: %d\n",
 		   atomic_read(&clp->cl_admin_revoked));
+	spin_lock(&clp->cl_lock);
+	seq_printf(m, "session slots:");
+	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
+		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
+	spin_unlock(&clp->cl_lock);
+	seq_puts(m, "\n");
+
 	drop_client(clp);
 
 	return 0;
-- 
2.47.0


