Return-Path: <linux-nfs+bounces-9648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E40A1CF6C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05BB1885567
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889064D;
	Mon, 27 Jan 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NQfKAbeg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QNYO7W7J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NQfKAbeg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QNYO7W7J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219F4C6E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941016; cv=none; b=L92vX6zY73RijoHztgJFhnMcX0OWwRB0Wyl+wqV3RpCwNcqlDqwmN4270lrot/BKYDXC7jV+choHtpmbjyG0WfwIcRmTxMCblMUZkIETfH/vPzCjXhMi8crrSx7VMN7tk8jglI9tCvFghQ3mBGUMDJiOA3nDjiRfPz72NWdS7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941016; c=relaxed/simple;
	bh=LxeM8iYQ7KlloFc0NBpnaQBIQ3sh4XIFyg35f7Psqzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYA3DbXMj5IdEcER4RFi9Dp3Ajzi0qKV3X+RYRAJrCf6eHACVHfAwXqegqSa3kgQSnv1fUKIhuQ2IthVEMtklIZBAA9QrakiQKzPRdRiXr7AXJGvQbdCzOZJH5QGPV0t1GDgArmuXlIa622IIcRWkrkpf5W4nOo+bkyo8TNSmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NQfKAbeg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QNYO7W7J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NQfKAbeg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QNYO7W7J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 509032115F;
	Mon, 27 Jan 2025 01:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwfrUPGCHQYnEmI0HOezSBu6W/N58f0uYCU2IBYhd4=;
	b=NQfKAbegS1t0J4nrPyK2ZOlmaFQ8qKdfbZh+rcAYRkL8If3tDAxJHnQPzyW8afKslb5vdj
	7jNcGhUEp19bG91JH3eu04+8ZFDnzgI4jeo4nWJJ+vuoslrFbpAzjjQ3Qs0XgSs2ONT/jI
	PdNQ7q3cOGCjaXTLT7txwj4rwQy9GXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwfrUPGCHQYnEmI0HOezSBu6W/N58f0uYCU2IBYhd4=;
	b=QNYO7W7Js+82LeBNbEdc91k3VnYlyIwgnPFt0d1ZTXTjVXYzZ4YxdugBT+1/wXkx41AnmU
	KT+GDNAClFm2VGBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwfrUPGCHQYnEmI0HOezSBu6W/N58f0uYCU2IBYhd4=;
	b=NQfKAbegS1t0J4nrPyK2ZOlmaFQ8qKdfbZh+rcAYRkL8If3tDAxJHnQPzyW8afKslb5vdj
	7jNcGhUEp19bG91JH3eu04+8ZFDnzgI4jeo4nWJJ+vuoslrFbpAzjjQ3Qs0XgSs2ONT/jI
	PdNQ7q3cOGCjaXTLT7txwj4rwQy9GXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwfrUPGCHQYnEmI0HOezSBu6W/N58f0uYCU2IBYhd4=;
	b=QNYO7W7Js+82LeBNbEdc91k3VnYlyIwgnPFt0d1ZTXTjVXYzZ4YxdugBT+1/wXkx41AnmU
	KT+GDNAClFm2VGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C8313782;
	Mon, 27 Jan 2025 01:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TBPeIhLglmc6fgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:30 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/7] nfsd: filecache: use nfsd_file_dispose_list() in nfsd_file_close_inode_sync()
Date: Mon, 27 Jan 2025 12:20:33 +1100
Message-ID: <20250127012257.1803314-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127012257.1803314-1-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

nfsd_file_close_inode_sync() contains an exactly copy of
nfsd_file_dispose_list().

This patch removes it and calls nfsd_file_dispose_list() instead.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f5a92ac3f16f..549969d4aa7c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -681,17 +681,12 @@ nfsd_file_close_inode(struct inode *inode)
 void
 nfsd_file_close_inode_sync(struct inode *inode)
 {
-	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
 	trace_nfsd_file_close(inode);
 
 	nfsd_file_queue_for_close(inode, &dispose);
-	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
-		nfsd_file_free(nf);
-	}
+	nfsd_file_dispose_list(&dispose);
 }
 
 static int
-- 
2.47.1


