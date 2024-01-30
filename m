Return-Path: <linux-nfs+bounces-1590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9C84182B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A14D284B4F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66896D266;
	Tue, 30 Jan 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KwrG5Lbr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uMr7cKrA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hCcxgjp1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hl1VeEMy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A23611F
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577126; cv=none; b=Wv/h57Nak4fIXe2bxS62Tt+X3rveSXOtWp4RtGenXlZPxgntFgkmHrdp0yckrBb6W0GfvbRiNOB1Og8r1iZGcquKAGpAgokifqNWzS4UEz725bhLqjSsHuvBliXVAeEmAE1Ol5RFJFAzU2EHCHhBtvWUIm30DEsEC5PhQURuvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577126; c=relaxed/simple;
	bh=s4cX5CoOI/7hxj+4jz6eVtjachFwbwgANomzUErz/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ1lFRHh4wcamcdK828DGKLPegEgpBYykjCtW/BTmIhLOYmNm4rzOSku6BzriOe7CL4Lh8K7KSw49MMB4NPnRm2Md6VNnGC5KOuIgWDz/YBuXcPQSwiGcE0CFfQeAnclEWgmBGWyNK6gNBxVaz569pTFp6yj8gcU3pFOgnZbJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KwrG5Lbr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uMr7cKrA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hCcxgjp1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hl1VeEMy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFE201F80F;
	Tue, 30 Jan 2024 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ca4K9pp4GadeIldlCzUYUJuJuQxb1oG4wzOAT4BVQw=;
	b=KwrG5LbrKft57j1c46CBh98GEK2avCNgHaBXyngW4Rj0axY8PtkboPnlSRQfCocoCJNK0g
	7otUHHNGOhVKS+11Dg/NSGJtOkwjeOBi1mQDbSu16zjFsqMAmuxttFwEelaimkhTf1QDb+
	lbCk+o71NeElEhr0p+65yqCqG4ZR4TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ca4K9pp4GadeIldlCzUYUJuJuQxb1oG4wzOAT4BVQw=;
	b=uMr7cKrAGJm4hvHSfxLIt2Ew8DgHAYcMtI7d809EQ33x/RyI7XwNNoQZJtwpn7BTDX/Lk5
	joqZQjCuiGNi5cDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ca4K9pp4GadeIldlCzUYUJuJuQxb1oG4wzOAT4BVQw=;
	b=hCcxgjp1opix9w9vRVvB7yFSDoKppk7AAW75jMKnoN1x2CHKqbT91fVUVYhX4RD6w6wLgu
	FB9ju0axBIo6msC2QadcHLYcUZXHuLmJBs0FfE1/vU/nFRxmJtgjVvyVXL3U2ZSPXZv17w
	jGl47mNLxyLyYiTt8SgAthQarOFDD0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ca4K9pp4GadeIldlCzUYUJuJuQxb1oG4wzOAT4BVQw=;
	b=Hl1VeEMyNVJNQsJ96S2eXKCDwAktSZ4B5NxaUX2lboORD3LHbA+qQlTgbQESMkvtUaYXkr
	Bf6V6pzT+MW9eZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A6CE12FF7;
	Tue, 30 Jan 2024 01:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id frkEBeBMuGXUQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:12:00 +0000
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
Date: Tue, 30 Jan 2024 12:08:28 +1100
Message-ID: <20240130011102.8623-9-neilb@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hCcxgjp1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Hl1VeEMy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
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
	 BAYES_HAM(-0.00)[26.76%];
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
X-Spam-Score: 2.49
X-Rspamd-Queue-Id: EFE201F80F
X-Spam-Flag: NO

Add "admin-revoked" to the status information for any states that have
been admin-revoked.  This can be useful for confirming correct
behaviour.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a05b6ab81ecf..823239f68153 100644
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


