Return-Path: <linux-nfs+bounces-8922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D15A01CC2
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 00:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3728818830E1
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 23:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5101487DD;
	Sun,  5 Jan 2025 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MAXorwJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4PCYTcA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MAXorwJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4PCYTcA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8861465BA
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736120458; cv=none; b=Zjw9w/AEuCU3fzf+8zTwFjM/VA2aW3E8Qh4TnxzwYP6If3yXWsmMLJSB43oXJGRWbTXE6B85U41AvXE7n+R6SPXlp/inGdUcNzci7wRhCcqZ1rDvRXBZBOOsqwG3uFAkZv755gGYx+k6SD+c45VG6owNg/hxKaqy7hq9Q4SKIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736120458; c=relaxed/simple;
	bh=ZlnDCx8OJ/EzvbBHJ6CHCfwElIjgvnvanfWxJ3uUov0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPJks1ivlxLF2jiextKTGP408OL2vXQZ+R1cMepkxy0gFWOL2TJls9Ru5o9odxmN//d9SyWXCxZGzzG1wJimWJPq4rsQ78aXgW3dutXbSeB+KUbEsvMGq/XkXQkXL8ARJnxL4trPUonO2/Q8gE+84DentsKM48BW2ualkI5C+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MAXorwJQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4PCYTcA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MAXorwJQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4PCYTcA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42AFB21161;
	Sun,  5 Jan 2025 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736120455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6/8P4lBG/rGF0e5Te+eN1nbzET+yc+8PrBvEx16Yc=;
	b=MAXorwJQDrsxQGwXh3vQaNCByhmrvjk8dnXB/PRUwAEY4z+L0vc2x1SpTLAVKfJYJEWeU9
	LdiUjNU2/MLUUYDApfkIq2PvG9C1tyqLSYJmsXtP7BfYdSL8TbEOQstuLiyQgSU0Jx9XJe
	uaDVi0Lt/wUrdOLAM5S72yENMrJu6qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736120455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6/8P4lBG/rGF0e5Te+eN1nbzET+yc+8PrBvEx16Yc=;
	b=N4PCYTcAem+aMEl0ypcgxJsKyx7b/m2jZKH7UGzl5Gq0B3YEDV8c60WFRPBKZWs1Raj2OD
	i7yboUohZ2V2FOAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MAXorwJQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N4PCYTcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736120455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6/8P4lBG/rGF0e5Te+eN1nbzET+yc+8PrBvEx16Yc=;
	b=MAXorwJQDrsxQGwXh3vQaNCByhmrvjk8dnXB/PRUwAEY4z+L0vc2x1SpTLAVKfJYJEWeU9
	LdiUjNU2/MLUUYDApfkIq2PvG9C1tyqLSYJmsXtP7BfYdSL8TbEOQstuLiyQgSU0Jx9XJe
	uaDVi0Lt/wUrdOLAM5S72yENMrJu6qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736120455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ms6/8P4lBG/rGF0e5Te+eN1nbzET+yc+8PrBvEx16Yc=;
	b=N4PCYTcAem+aMEl0ypcgxJsKyx7b/m2jZKH7UGzl5Gq0B3YEDV8c60WFRPBKZWs1Raj2OD
	i7yboUohZ2V2FOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20E63137CF;
	Sun,  5 Jan 2025 23:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjO8MYQYe2eQaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 05 Jan 2025 23:40:52 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
Date: Mon,  6 Jan 2025 10:11:59 +1100
Message-ID: <20250105234022.2361576-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105234022.2361576-1-neilb@suse.de>
References: <20250105234022.2361576-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42AFB21161
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Under a high NFSv3 load with lots of different file being accessed The
list_lru of garbage-collectable files can become quite long.

Asking lisT_lru_scan() to scan the whole list can result in a long
period during which a spinlock is held and no scheduling is possible.
This is impolite.

So only ask list_lru_scan() to scan 1024 entries at a time, and repeat
if necessary - calling cond_resched() each time.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..e99a86798e86 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -543,11 +543,18 @@ nfsd_file_gc(void)
 {
 	LIST_HEAD(dispose);
 	unsigned long ret;
-
-	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
-			    &dispose, list_lru_count(&nfsd_file_lru));
-	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
+	unsigned long cnt = list_lru_count(&nfsd_file_lru);
+
+	while (cnt > 0) {
+		unsigned long num_to_scan = min(cnt, 1024UL);
+		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
+				    &dispose, num_to_scan);
+		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
+		nfsd_file_dispose_list_delayed(&dispose);
+		cnt -= num_to_scan;
+		if (cnt)
+			cond_resched();
+	}
 }
 
 static void
-- 
2.47.1


