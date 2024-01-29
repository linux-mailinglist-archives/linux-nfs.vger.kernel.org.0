Return-Path: <linux-nfs+bounces-1516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC71483FCD1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82945283D5E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC210A0C;
	Mon, 29 Jan 2024 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZJ73qwL2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y4seQPfJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZJ73qwL2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y4seQPfJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B310962
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499419; cv=none; b=XGpgo1oB+VUyLfAXR/vDOuz6TCYc2eO8eTYNy4uKp/sr+5OcWB877mzktbfsnGxKfozLqyaeku8GQrp5HErjnWLo0VA377yJwF7avSUxHdYrF1+td4STpoysxX3rK6xq0ajS22EEmDfmUXoDXaBtamda5rAqqQE686c6QSPIJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499419; c=relaxed/simple;
	bh=SthJrmPo+r4MYoVpMnRxtJN2eT3W31RAYbFIhuXPYmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8+LhZULVpDzeNKzSgUhaTSb/TfFTqa3Q7TgyfF94WSRUZCp44SNUy958PzJVWW6j78swUiX1Q8AcwAHEMQLMrFlf07L7KAmlmVEYtycKzkzfja+7d/0/+aXna/c1TVhIabieQYJQ6yMG9DYH16/i1/qawd5mSZki96Inld2MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZJ73qwL2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y4seQPfJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZJ73qwL2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y4seQPfJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2678E1F7C4;
	Mon, 29 Jan 2024 03:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDfhzzERneTcNbkZGh6wnJU6FYJ9q0ehheplbADO+14=;
	b=ZJ73qwL2YXZmXPUm07IerFP+ZtcTjdg+4CL1R/pm8A6oftvu3yYDlpZ1ppuZqU3cEXRfeq
	eiEuRRdluaHI0U2VQTy2J7fsCgw5EwYshNwJG36pOOkFaPd11PItg3dVlKhq7ZqXFrrtVz
	JEPoIKePr7CWYKptqy7KpHZ+EqH04DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDfhzzERneTcNbkZGh6wnJU6FYJ9q0ehheplbADO+14=;
	b=Y4seQPfJEdg0rG6z+4KwgVihAgNujS/bzW7+VyHxCiR7qvSbylMFBOrq5GUAohC8fuMJZR
	15gyx0ubC4X9h4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDfhzzERneTcNbkZGh6wnJU6FYJ9q0ehheplbADO+14=;
	b=ZJ73qwL2YXZmXPUm07IerFP+ZtcTjdg+4CL1R/pm8A6oftvu3yYDlpZ1ppuZqU3cEXRfeq
	eiEuRRdluaHI0U2VQTy2J7fsCgw5EwYshNwJG36pOOkFaPd11PItg3dVlKhq7ZqXFrrtVz
	JEPoIKePr7CWYKptqy7KpHZ+EqH04DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDfhzzERneTcNbkZGh6wnJU6FYJ9q0ehheplbADO+14=;
	b=Y4seQPfJEdg0rG6z+4KwgVihAgNujS/bzW7+VyHxCiR7qvSbylMFBOrq5GUAohC8fuMJZR
	15gyx0ubC4X9h4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8548E13867;
	Mon, 29 Jan 2024 03:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6N1D1Udt2UQKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:36:53 +0000
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
Date: Mon, 29 Jan 2024 14:29:23 +1100
Message-ID: <20240129033637.2133-2-neilb@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZJ73qwL2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y4seQPfJ
X-Spamd-Result: default: False [4.64 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[59.63%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.64
X-Rspamd-Queue-Id: 2678E1F7C4
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

As we do now support write delegations, this comment is unhelpful and
misleading.

Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6dc6340e2852..d377a0a56e45 100644
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


