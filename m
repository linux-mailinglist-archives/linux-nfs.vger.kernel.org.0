Return-Path: <linux-nfs+bounces-1583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1572841822
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6910E1F23696
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FF2C868;
	Tue, 30 Jan 2024 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AJx1WMiQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xiMx2jsO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AJx1WMiQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xiMx2jsO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9333CFB
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577080; cv=none; b=C3oLkc2+Dtx2x053B3ndTxIHNEvERvxZ4boV16XhAmqGAz0Q4cr+zOg7eeCBH24sVMjM45s56YN8nXU8KQMN+OUcNfVDEjHS1m2unpA+UIvohldpmA3bzuE6vCauZyYcXpUDZFOxN1xAh10mKBvl996WE/tw/y4/kmQxMrG+rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577080; c=relaxed/simple;
	bh=euWqh/E1ZR4UZWrudj9I6/AoWjDzE3GuqdYMoLHj/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ako8DqRwxxsZcE/gyKRiiuH9wmnm2jCbMiu+Ckk2CnTkYmy/XHxT9h3xqlYsv3cSSMlP9Qe9cTH0nDEqw3A30/taQ/VwGwqHoXTamsCQhJcUA4JMJxOFcVzuOnULqh1HkcmA0mpdb+7Ecwt6Wcvg5ZeVvDV8VxwlW+Br44SpzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AJx1WMiQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xiMx2jsO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AJx1WMiQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xiMx2jsO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3939A1F7ED;
	Tue, 30 Jan 2024 01:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/D/F6WZ2eEk2G617T5LAt3UsHaQ8KwYa7FA1TDmQQg=;
	b=AJx1WMiQsUUgYNomeRuMn4qUzNgX9W4nPu7w0Xi+ltGKuhqu0+s+3VznBLE7D1WN+fU0Um
	fcl3G/Syx9p1MnwPHQ129rDrP4hVArW9YyRH/gA4Q+CT67amwmOH5OHLJbCWh9E3LIrUyp
	ku65U0Vr3Xcmn8K1OiW/Yc5mZAdiJwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/D/F6WZ2eEk2G617T5LAt3UsHaQ8KwYa7FA1TDmQQg=;
	b=xiMx2jsOsu5cdW7LbK4O2HacfAWKehtYxGGMjJ7znwto1yZ56MAbAPpN7y3c0b3BFdUWOk
	+yHxb5onAJbRIsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/D/F6WZ2eEk2G617T5LAt3UsHaQ8KwYa7FA1TDmQQg=;
	b=AJx1WMiQsUUgYNomeRuMn4qUzNgX9W4nPu7w0Xi+ltGKuhqu0+s+3VznBLE7D1WN+fU0Um
	fcl3G/Syx9p1MnwPHQ129rDrP4hVArW9YyRH/gA4Q+CT67amwmOH5OHLJbCWh9E3LIrUyp
	ku65U0Vr3Xcmn8K1OiW/Yc5mZAdiJwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/D/F6WZ2eEk2G617T5LAt3UsHaQ8KwYa7FA1TDmQQg=;
	b=xiMx2jsOsu5cdW7LbK4O2HacfAWKehtYxGGMjJ7znwto1yZ56MAbAPpN7y3c0b3BFdUWOk
	+yHxb5onAJbRIsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5AC12FF7;
	Tue, 30 Jan 2024 01:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SvXxEbJMuGWTQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:11:14 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 01/13] nfsd: remove stale comment in nfs4_show_deleg()
Date: Tue, 30 Jan 2024 12:08:21 +1100
Message-ID: <20240130011102.8623-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130011102.8623-1-neilb@suse.de>
References: <20240130011102.8623-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AJx1WMiQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xiMx2jsO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.36 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.13)[67.43%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 2.36
X-Rspamd-Queue-Id: 3939A1F7ED
X-Spam-Flag: NO

As we do now support write delegations, this comment is unhelpful and
misleading.

Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ae9b5a3a585f..5e640e9945cd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2711,7 +2711,6 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_printf(s, ": { type: deleg, ");
 
-	/* Kinda dead code as long as we only support read delegs: */
 	seq_printf(s, "access: %s, ",
 		ds->dl_type == NFS4_OPEN_DELEGATE_READ ? "r" : "w");
 
-- 
2.43.0


