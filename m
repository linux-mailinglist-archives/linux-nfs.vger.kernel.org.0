Return-Path: <linux-nfs+bounces-8366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CB9E63F7
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B837F163EEB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C63513C8FF;
	Fri,  6 Dec 2024 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNdsXBJs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GEkxdDVp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cbt0eyan";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S4vSJ6pZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F12AE9A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451563; cv=none; b=Ic20U6ecxcziuTiKlmZjmkXPMeS7NlHIk32YGolYzYy5IyOQh4aCV18Jghz2xVEIwrOWKd7pq7qfVXSSe0vJA900ALSa4l3WY1L+yOG+D71btkg8/fUT6ZsRWJ3TAcMaARKXdUT5A05dDNjnoriLxdh6wzuQ0To7qWp3pmE5MLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451563; c=relaxed/simple;
	bh=fMs7Ryxx2ms7KtKf8sor1Xy8Wi2EcOBDcQZwLrUbWOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUaOtIKRrWrQaYKnf/Mn2qSuzuUsJW7frarqN829zByIn8jHISj/OzEbjyxqqRv2p4gXeh0pp1S8edk7ZZlxXeXybEr6d7L0lPxYltPYrNTG4qUBhxKBX3MErbR2rfJ5bUsQnPleifSwe1rBz6BVhMJaKNlJzw8OxP/1ei90yIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNdsXBJs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GEkxdDVp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cbt0eyan; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S4vSJ6pZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D82EC1F38E;
	Fri,  6 Dec 2024 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEz40ZY3HZX48Xkp2vdYkh+pYbW6M2CZCdj/9CszJ18=;
	b=WNdsXBJs7yuk37FiFFzplp4LOa4hES83q5/TB+QScdilIPW9f4vF+J1q6HMrMSExUs8C1T
	S0diQrEpivBiRLMqFkfMOy7DZ/f06p1fjehwtA0prKU+vYfBj2WMY+l26sLA1bGvSdzkJx
	24/vFWq9LsmNmfH2w6MgdwVyyNOavJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEz40ZY3HZX48Xkp2vdYkh+pYbW6M2CZCdj/9CszJ18=;
	b=GEkxdDVpw0w5pVA4UtpHwVB8TjPqQCoEd+HkO8xUv8YLsq3GcBQQXg+oOer+1lC6MVMGcV
	0pkw05e53i7R1PCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cbt0eyan;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S4vSJ6pZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEz40ZY3HZX48Xkp2vdYkh+pYbW6M2CZCdj/9CszJ18=;
	b=Cbt0eyaneTMJM4ZJAilZ6rK/GJG2N2L5HXYA8RHFewR6eMv7ji3ublCP4cjbja4347u7g9
	m+D4UmQmO29z34VxaXiU6ysZ0G0WZha/FqjDgO7Lhbq5sKfvMLvyBtaZGGHUDh+Tv6lgd+
	bIZJ+n6p/uyFWE9sn9LnzEuOdrGgmqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEz40ZY3HZX48Xkp2vdYkh+pYbW6M2CZCdj/9CszJ18=;
	b=S4vSJ6pZLYqbL84RBsYrBycjrO95nrR/05sF3CuRTykJQITV335DaB/c1XLC2sIfwar979
	oseBUtqxor5M85DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A009013A15;
	Fri,  6 Dec 2024 02:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j684FSVfUmcuJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:17 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 03/11] nfs: use clear_and_wake_up_bit().
Date: Fri,  6 Dec 2024 13:15:29 +1100
Message-ID: <20241206021830.3526922-4-neilb@suse.de>
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
X-Rspamd-Queue-Id: D82EC1F38E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

In three places nfs clears a bit and then sends a wake_up_bit().
Using clear_and_wake_up_bit() makes this code cleaner and avoids the
need for explicit barriers.

In 2 cases the wake_up is conditional on a "congested" flag.  For these
we use the flag to select between clear_bit and clear_and_wake_up_bit.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/inode.c    |  4 +---
 fs/nfs/pagelist.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 596f35170137..4c4c3ab57fcd 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1451,9 +1451,7 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	ret = nfs_invalidate_mapping(inode, mapping);
 	trace_nfs_invalidate_mapping_exit(inode, ret);
 
-	clear_bit_unlock(NFS_INO_INVALIDATING, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_INO_INVALIDATING);
+	clear_and_wake_up_bit(NFS_INO_INVALIDATING, bitlock);
 out:
 	return ret;
 }
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e27c07bd8929..7f3914064cee 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -214,11 +214,10 @@ nfs_page_set_headlock(struct nfs_page *req)
 void
 nfs_page_clear_headlock(struct nfs_page *req)
 {
-	clear_bit_unlock(PG_HEADLOCK, &req->wb_flags);
-	smp_mb__after_atomic();
 	if (!test_bit(PG_CONTENDED1, &req->wb_flags))
-		return;
-	wake_up_bit(&req->wb_flags, PG_HEADLOCK);
+		clear_bit_unlock(PG_HEADLOCK, &req->wb_flags);
+	else
+		clear_and_wake_up_bit(PG_HEADLOCK, &req->wb_flags);
 }
 
 /*
@@ -519,11 +518,10 @@ nfs_create_subreq(struct nfs_page *req,
  */
 void nfs_unlock_request(struct nfs_page *req)
 {
-	clear_bit_unlock(PG_BUSY, &req->wb_flags);
-	smp_mb__after_atomic();
 	if (!test_bit(PG_CONTENDED2, &req->wb_flags))
-		return;
-	wake_up_bit(&req->wb_flags, PG_BUSY);
+		clear_bit_unlock(PG_BUSY, &req->wb_flags);
+	else
+		clear_and_wake_up_bit(PG_BUSY, &req->wb_flags);
 }
 
 /**
-- 
2.47.0


