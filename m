Return-Path: <linux-nfs+bounces-8368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D634D9E63FD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5AB18826EC
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0263149E1A;
	Fri,  6 Dec 2024 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RdhcPUhl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qmxop8XL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RdhcPUhl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qmxop8XL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABF144D0A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451571; cv=none; b=lcz5HQDEICG66NfMwk/fQvKpb8lPGlzl1TUynsgcqYHFu107pO1Vca0qm1ErM5NSAugX03+AotxDAc1PQDTeUuaibyJImOIPnV+YAsRef+PmYfzx7ATXC2g92+soZ/9BFmVz/CMrc214yoXII84rL4qLZ4qEo81q8Fs+RIdhPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451571; c=relaxed/simple;
	bh=2s6W/0IxliIVmvW0NIPJbEldixOohfQLzcGZlv2Nn9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK3j7TfW3Tx50i0rFscPiyDRMF1Ts6ngK176QL4YJmNi8JPmCz9WCs8P6nIjB3hXrRKaAQfPIgcUrBzwy6PhNoqkTg1tvG7/gXDoLq3y948xdX/K05KnV6/JjG2X/nrQJG9Mk0HfHFU9rvZCtKqhPrv5kY8wcJIul6dkO3HZPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RdhcPUhl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qmxop8XL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RdhcPUhl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qmxop8XL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D2701F394;
	Fri,  6 Dec 2024 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jl39J4Nyot8HiS3DTwx4WMT1lrl5PmwM+SJxwteyKww=;
	b=RdhcPUhlctd83xt6MRxYZ4Y5L3Ebeg6UaU+DgzaoRpAU7hENkaQykflVT0iiXUgHABkQDp
	F4GoTsIttRZLwP9AsU3d4gw0LVVQiGXDLA37ugjGVtrjcLuEJohwfWY4cb01vXCF6jIl9g
	KeFvwwMLYEeKkmQaJdRVQr3Cq1iZg+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jl39J4Nyot8HiS3DTwx4WMT1lrl5PmwM+SJxwteyKww=;
	b=Qmxop8XLXoAekuzzT4vg4rQxZIG8Wox0BDs/c7mBlHU/UN5hpAzGjRZxBthM8CvO9s93F2
	Vu30lnAVsEmUhKCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RdhcPUhl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qmxop8XL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jl39J4Nyot8HiS3DTwx4WMT1lrl5PmwM+SJxwteyKww=;
	b=RdhcPUhlctd83xt6MRxYZ4Y5L3Ebeg6UaU+DgzaoRpAU7hENkaQykflVT0iiXUgHABkQDp
	F4GoTsIttRZLwP9AsU3d4gw0LVVQiGXDLA37ugjGVtrjcLuEJohwfWY4cb01vXCF6jIl9g
	KeFvwwMLYEeKkmQaJdRVQr3Cq1iZg+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jl39J4Nyot8HiS3DTwx4WMT1lrl5PmwM+SJxwteyKww=;
	b=Qmxop8XLXoAekuzzT4vg4rQxZIG8Wox0BDs/c7mBlHU/UN5hpAzGjRZxBthM8CvO9s93F2
	Vu30lnAVsEmUhKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9E0313A15;
	Fri,  6 Dec 2024 02:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tGFNJy5fUmc+JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:26 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 05/11] nfs: use clear_and_wake_up_bit() in pnfs code
Date: Fri,  6 Dec 2024 13:15:31 +1100
Message-ID: <20241206021830.3526922-6-neilb@suse.de>
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
X-Rspamd-Queue-Id: 2D2701F394
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The wake_up_bit() interface is fragile as it sometimes needs an explicit
barrier before it is called.  It is generally better to use the combined
interfaces which have all necessary barriers.

The usage of wake_up_bit() in NFS/pnfs IS safe as the required barriers
are included.  But it is ugly to need that explicit barrier.

This patch changes to use clear_and_wake_up_bit() which transparently
includes the required barrier.  Also use test_and_clear_wake_up_bit() in
one case.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/pnfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5963c0440e23..445ba09ba324 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2034,9 +2034,8 @@ static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
 
 static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
-	if (atomic_dec_and_test(&lo->plh_outstanding) &&
-	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
-		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
+	if (atomic_dec_and_test(&lo->plh_outstanding))
+		test_and_clear_wake_up_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
 }
 
 static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
@@ -2048,9 +2047,7 @@ static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
 {
 	unsigned long *bitlock = &lo->plh_flags;
 
-	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
+	clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
 }
 
 static void _add_to_server_list(struct pnfs_layout_hdr *lo,
@@ -3221,9 +3218,7 @@ static void pnfs_clear_layoutcommitting(struct inode *inode)
 {
 	unsigned long *bitlock = &NFS_I(inode)->flags;
 
-	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
+	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, bitlock);
 }
 
 /*
-- 
2.47.0


