Return-Path: <linux-nfs+bounces-8526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FA9ED900
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 22:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45285285361
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D81DBB13;
	Wed, 11 Dec 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YrjQnypO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDwhlo+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YrjQnypO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDwhlo+A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFE1D31B5
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953762; cv=none; b=YnhtlZ2YGoJ0iS5NtEoYHJV5ecsvIx/XsdFbt/4BQQmqGuVr8UYu+pKsz9xXaeE3yD5gAzwXRrqtLArQGItllrU0rtL8ZUzgrrmfOlqZYNXsICPiCXUVWyH0N3slOWQec88oPIcXPhL8DC9HaVQt6Es12f9s/lnl41Me7UEuw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953762; c=relaxed/simple;
	bh=7UjEPc0JqjcV66qTkdot0v3c/mTaAvaaNb50GM4EOSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoLeuHhlqTzj3SF1fYHGQe55x5DZsl3Xqla54a06WJvodLcQSvFXP9T5oWfoBPKij7IQglnbA6HRrgbt0Wqiatd557UWdmcQI2EEuy2V0VYaUDUxlRwbCpVekvb6zyPpzd6G5Xd4I5OwoYd+kyNuHrLd5UO6Efe2aQdJ23PJ7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YrjQnypO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDwhlo+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YrjQnypO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDwhlo+A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82DC81F46E;
	Wed, 11 Dec 2024 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihut6lLHPNKFZwg4lk5GZAMvGvNY5kJaFl0ewrPmTww=;
	b=YrjQnypOsjMQp5tZrkh6WX6sP3hslrKauRWPUrjABiAC86vziAYcY9VynGINZAYJLFdbNc
	TVByzGdSHA020pVMBF63nV3H/8oWc6e/QKUZUhVHFBU9j7QUNZfN8rvU1IeD1iZn2z32QU
	5P7aehtGay7xcxMGZfiJdKWHa3XglqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihut6lLHPNKFZwg4lk5GZAMvGvNY5kJaFl0ewrPmTww=;
	b=lDwhlo+A2k84No2v3uxeEEz08t9T7DvY2GYfdD7/H0PUeOeSVj6xxJYeWPwB+bkXJ1rc2f
	IXMFT/X7ggxbWtBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YrjQnypO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lDwhlo+A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733953758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihut6lLHPNKFZwg4lk5GZAMvGvNY5kJaFl0ewrPmTww=;
	b=YrjQnypOsjMQp5tZrkh6WX6sP3hslrKauRWPUrjABiAC86vziAYcY9VynGINZAYJLFdbNc
	TVByzGdSHA020pVMBF63nV3H/8oWc6e/QKUZUhVHFBU9j7QUNZfN8rvU1IeD1iZn2z32QU
	5P7aehtGay7xcxMGZfiJdKWHa3XglqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733953758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihut6lLHPNKFZwg4lk5GZAMvGvNY5kJaFl0ewrPmTww=;
	b=lDwhlo+A2k84No2v3uxeEEz08t9T7DvY2GYfdD7/H0PUeOeSVj6xxJYeWPwB+bkXJ1rc2f
	IXMFT/X7ggxbWtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5101344A;
	Wed, 11 Dec 2024 21:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hToxCNwIWmfRMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 21:49:16 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
Date: Thu, 12 Dec 2024 08:47:06 +1100
Message-ID: <20241211214842.2022679-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211214842.2022679-1-neilb@suse.de>
References: <20241211214842.2022679-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82DC81F46E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


