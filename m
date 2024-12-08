Return-Path: <linux-nfs+bounces-8435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E69E8848
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 23:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BF7281017
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97584D29;
	Sun,  8 Dec 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WTtbgL73";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TNclkVg5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WTtbgL73";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TNclkVg5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60374040
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698023; cv=none; b=mblqMo5gcshN2duGjs88qExPonQM8Fwe3ffODsZbPp2MsFZVA9xddwGs3qqSf9/s5W+TMr+yrhcU7UA/BZtGChf7lOI2zqUbC82xT02l9NEkGQI0jvhTC0jvoRC8r6FRgqiytIb+FfUaCA9B1ZnCT/UfDvQDNQMlJZcV5H2E69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698023; c=relaxed/simple;
	bh=yU15DXWQh6k4/q5tw6s4+wj26LmBcj5OCUQY12ODzuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6JS9eNBfdGITlAXsM90OYKcqlPlQrOueHPoWS9dJMptRPNUjIYoFYRP/nGI1lhM2HSXL6NgK2zMaKNyx6wigm5d4+gp2AHP7lK4uOE2GBwc8qtOaiQbwWhVTKcQKqzU+fruyFIkwrEx0cqzUf4rfdcdutZ6j66aK9HClqYPRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WTtbgL73; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TNclkVg5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WTtbgL73; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TNclkVg5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48AAE1F385;
	Sun,  8 Dec 2024 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=WTtbgL73Ee7LnggOWOM7sPEAKyPjaJed18LzeRn3wvAAp5qEj1RC1nv24esu5XFPr+ckGv
	BhKZD6w5gXpeJv4LuSsA63Qj0Fvvjnp5gM7O+KVxWJEMkoZu4OrrDVDGX2Kjg2D4ZSIa8R
	ctV0gtEefqmseAM4gvb+CGXRI8Nze9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=TNclkVg5Zm2TttkzfMDxH1n+E/D/wfmYYQ6XvllRfhwKIBWHpWNf34lvIzX6sWmc4A4F4b
	zXdi7R829DrvpeBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WTtbgL73;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TNclkVg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733698020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=WTtbgL73Ee7LnggOWOM7sPEAKyPjaJed18LzeRn3wvAAp5qEj1RC1nv24esu5XFPr+ckGv
	BhKZD6w5gXpeJv4LuSsA63Qj0Fvvjnp5gM7O+KVxWJEMkoZu4OrrDVDGX2Kjg2D4ZSIa8R
	ctV0gtEefqmseAM4gvb+CGXRI8Nze9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733698020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oyQkAYDoZBPLVVxR2nVtef18GPWeXdOR4MsShyQpB0=;
	b=TNclkVg5Zm2TttkzfMDxH1n+E/D/wfmYYQ6XvllRfhwKIBWHpWNf34lvIzX6sWmc4A4F4b
	zXdi7R829DrvpeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BBFF13998;
	Sun,  8 Dec 2024 22:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XNByNOEhVmfbAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 22:46:57 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
Date: Mon,  9 Dec 2024 09:43:14 +1100
Message-ID: <20241208224629.697448-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241208224629.697448-1-neilb@suse.de>
References: <20241208224629.697448-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48AAE1F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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


