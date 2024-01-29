Return-Path: <linux-nfs+bounces-1523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03183FCD9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7875C1F2318C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986410940;
	Mon, 29 Jan 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hFirjY9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zni5L/gE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hFirjY9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zni5L/gE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EF10949
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499461; cv=none; b=c4Txbs2CO0uTwmTHPA0jOaSnSNpb7uAO11Qe/qd8kvWej7vg6mmr1crubhXdc8fYzPiIiwdp6FY2AdQMo37RTpmA2U0Z7Zj5EO758N86tzUxxNcDNybdqfjIhhROYyY4O86UTHWmjFG6zOzzR6FUKOkPG8QFDBsTry6hgzW6mU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499461; c=relaxed/simple;
	bh=50LXGVY0qVGDRUGgImLXbwALGAlBYnZ5HnrP4m6RB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3fcUpcRY+pmr1MzPd67nEHQ5dQq8vUTR+igyahfDhuLSBk8qXYKIOtTtCwqohumWlGb8+omiWhDqktS6wGSuoeBWOFUDpQNShfztV3I5SNCJF31UyKOqMimoM+2W+GR7y8HQfXNCzu7RErVNcOf7PHaDkWadDAqBMvji29Osj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hFirjY9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zni5L/gE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hFirjY9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zni5L/gE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45AEA2229E;
	Mon, 29 Jan 2024 03:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suthgnAFTQLKhYxg98kqMJDmjKohKI6HWLCjhLFlK9o=;
	b=hFirjY9vdbulXqjYpvDJyO7nvzJS401GblTVM14X3CTUJz3y11tm8w5yMrrMejywFAOw4W
	ldvIIwHKgRq72TykS7xq9feTnDGq0gXwW4cKy9hQ3DYQ3Cxzk0/l36ZExXJJZ+ueB3a7nv
	1zi32UtUUKUzDPBX46WVgxqOoo19s1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suthgnAFTQLKhYxg98kqMJDmjKohKI6HWLCjhLFlK9o=;
	b=zni5L/gE68IvUmghmnxcjVRdNQgVFBrRGjStIgdx34KazpIgjuu8u04pWWG0u5jYIDFTHA
	HmNzRA7ynPqBamAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suthgnAFTQLKhYxg98kqMJDmjKohKI6HWLCjhLFlK9o=;
	b=hFirjY9vdbulXqjYpvDJyO7nvzJS401GblTVM14X3CTUJz3y11tm8w5yMrrMejywFAOw4W
	ldvIIwHKgRq72TykS7xq9feTnDGq0gXwW4cKy9hQ3DYQ3Cxzk0/l36ZExXJJZ+ueB3a7nv
	1zi32UtUUKUzDPBX46WVgxqOoo19s1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suthgnAFTQLKhYxg98kqMJDmjKohKI6HWLCjhLFlK9o=;
	b=zni5L/gE68IvUmghmnxcjVRdNQgVFBrRGjStIgdx34KazpIgjuu8u04pWWG0u5jYIDFTHA
	HmNzRA7ynPqBamAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4CBD13867;
	Mon, 29 Jan 2024 03:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LqolF38dt2U5KgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:35 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 08/13] nfsd: report in /proc/fs/nfsd/clients/*/states when state is admin-revoke
Date: Mon, 29 Jan 2024 14:29:30 +1100
Message-ID: <20240129033637.2133-9-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129033637.2133-1-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hFirjY9v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zni5L/gE"
X-Spamd-Result: default: False [4.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[22.84%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 45AEA2229E
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Add "admin-revoked" to the status information for any states that have
been admin-revoked.  This can be useful for confirming correct
behaviour.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ef4ec23f7c0d..e1492ca7c75c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2717,6 +2717,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	}
 	spin_unlock(&nf->fi_lock);
 	nfs4_show_owner(s, oo);
+	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_puts(s, " }\n");
 	return 0;
 }
@@ -2753,6 +2755,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 		seq_puts(s, ", ");
 	}
 	nfs4_show_owner(s, oo);
+	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_puts(s, " }\n");
 	spin_unlock(&nf->fi_lock);
 	return 0;
@@ -2784,8 +2788,10 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 		seq_puts(s, ", ");
 		nfs4_show_fname(s, file);
 	}
-	seq_puts(s, " }\n");
 	spin_unlock(&nf->fi_lock);
+	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
+	seq_puts(s, " }\n");
 	return 0;
 }
 
@@ -2809,6 +2815,8 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 		seq_puts(s, ", ");
 		nfs4_show_fname(s, file);
 	}
+	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_puts(s, " }\n");
 
 	return 0;
-- 
2.43.0


