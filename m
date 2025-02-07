Return-Path: <linux-nfs+bounces-9921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53837A2BA91
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714013A7764
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ACF17B421;
	Fri,  7 Feb 2025 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VOD3aDka";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UzWZGOSp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BRWS4iG3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AcVl84BB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566214F9C4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905458; cv=none; b=ApkPuXhAI/KbkXkNKmNByC7JsrEU+uMm+OfhXky6Ni43ra+2gEMa48bl9lq4lUuILjOXOk7tCnTnWSXrYwFnY6xjGGajHCpCZDszvpGbDfEtHD5wG1B4Mv51fp+1H+76VWld+0J/5qPYVv/iE+6VYSJzcV3k4nXMdS0Uzd/qgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905458; c=relaxed/simple;
	bh=KC6nTzpRfm0bzN7DfpVBGHyIPHAIcuS5GJXYc37UfM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex/jis/D4KOcPJWH7y+B4CkJmWVClIW/Q+vjZl90AFsj88P/ayQMkDLeqI/ahpOGjekHD0Tamy4m0jMf7LL1ytV+eGcvpd6o05nBin6SXvIaVDmAVKDNBHZor8qdA/Tv3EHcMmCEojiL7SwKyvlKn0+NBh4zcmEkqMFcyL4/tf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VOD3aDka; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UzWZGOSp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BRWS4iG3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AcVl84BB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2A681F38D;
	Fri,  7 Feb 2025 05:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGQmne6MLxrqXqQde476+/Bu4qVQH5In4NR8Qgo5FDA=;
	b=VOD3aDka0C5Xod1Dvq3czjpiRHLoVd5VWX2m4D/hrb0gD5kFghqTdLL2PIo4YRAWALo03c
	/ljhaxpBshhijTE5sXS9Ds67GCnsqo0GW4FRUBrXxPm755LON7DN8WFMfpPKx0QXkqxeWE
	emQhl4oA6P+dsEtfWDj333btW8KunqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGQmne6MLxrqXqQde476+/Bu4qVQH5In4NR8Qgo5FDA=;
	b=UzWZGOSpl9TlhUMP2dLhH2O0/WK6xKzIfCfomKHuuD/Fsth/7Q3Vd2nfdhoq0Lta1jXwEa
	pTWTz1c+fVgsKsBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGQmne6MLxrqXqQde476+/Bu4qVQH5In4NR8Qgo5FDA=;
	b=BRWS4iG3HY7kyszK+yY+5Oe7eYYP0Y18+JQC9qZh34El+H0TP2sUaQW/KMEz9dJPZX7ttO
	0n4DrlRs0d6xtmTMWaX+CnvCOWhJf8DCi47x2oi5l/1jnN8nOKjuwSfR/q5vhMs0dCMTMZ
	DvGOW7W8pWsMvVf/JcvAKMpmJ/OZsuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGQmne6MLxrqXqQde476+/Bu4qVQH5In4NR8Qgo5FDA=;
	b=AcVl84BBcPWt+o6jmzZenF7JR5Ffr1uJ9QezPUMvH+r0FCZqMC+28p/gsuR8r/xVeVUrQR
	9R2uNcZuV0NTv6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADCE13694;
	Fri,  7 Feb 2025 05:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zS3xC2uXpWcBFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:31 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/6] nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
Date: Fri,  7 Feb 2025 16:15:13 +1100
Message-ID: <20250207051701.3467505-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207051701.3467505-1-neilb@suse.de>
References: <20250207051701.3467505-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

list_lru_walk() is only useful when the aim is to remove all elements
from the list_lru.  It will repeated visit rotated element of the first
per-node sublist before proceeding to subsrequent sublists.

This patch changes to use list_lru_walk_node() and list_lru_count_node()
on each individual node.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 7dc20143c854..04588c03bdfe 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -532,10 +532,14 @@ static void
 nfsd_file_gc(void)
 {
 	LIST_HEAD(dispose);
-	unsigned long ret;
+	unsigned long ret = 0;
+	int nid;
 
-	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
-			    &dispose, list_lru_count(&nfsd_file_lru));
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
+		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
+					  &dispose, &nr);
+	}
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 }
-- 
2.47.1


