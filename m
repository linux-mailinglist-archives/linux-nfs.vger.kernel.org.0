Return-Path: <linux-nfs+bounces-8367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BBC9E63FC
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42BC164025
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90A17B502;
	Fri,  6 Dec 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0GiwMKeP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOu9TGU1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0GiwMKeP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GOu9TGU1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D3156236
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451567; cv=none; b=Sod/BByV6LZ9k7PRx5VSpUS/JBUe8lF63vQL+WSpVRbSmU+ECcXlw9TPe0i/h4bk9NuhJXz8JSHqbdVabyFN7FWs6i6ZVR+zA8dn6ReGfCGJXkshmOjTWsfkBHSRu4+Zh7Dtt7P9f4HmDH+aipZ8AOeNAW7G1ArwabNdCIlQnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451567; c=relaxed/simple;
	bh=FXMX6/uAf/xzoF04GuV6091SWxGKRrjDouNC1So2xiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iijAyMFzQons55m1e+lAgrPV3McrDMjGcBrGK6mnq/NAtFwdQixRKo0iygbrz9qpAqRSwj6XMpMnd7dQSztEFEI2Ez15UyQbHprhhCecZiD6c4SoV07Be4nJMIkhRKeD7dNInTNjFNZrZL+DCsYtHpOzqPBzHp2/SF/cLmTO7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0GiwMKeP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOu9TGU1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0GiwMKeP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GOu9TGU1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 823701F394;
	Fri,  6 Dec 2024 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQF/sT+iiJrJkYrPNV8viCwhns8T6ZZy5JjIW6cf+Dk=;
	b=0GiwMKePGheNN3HReRg/NN6vD7+CWcxyFX6cza5lvH+aRDqppsUhGruXQkZtHcUd5bc7so
	S3Nwk0s7vuDpbAmx9FqAmVfbyslrPl6z58Pj4Zmekim2m65BwUpxO6uC5qJeqcCJo4DhM7
	cK4aYSsnC6Q3VuSJ/DeL5YVWcwF4YxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQF/sT+iiJrJkYrPNV8viCwhns8T6ZZy5JjIW6cf+Dk=;
	b=GOu9TGU1ql/GUd979saV+oK8uEjOSS5VB6mB9yZgDW6iJZ8/uF7PWK86Eag3fNN4TvyG03
	BbIPeVjTYjnoQiDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0GiwMKeP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOu9TGU1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQF/sT+iiJrJkYrPNV8viCwhns8T6ZZy5JjIW6cf+Dk=;
	b=0GiwMKePGheNN3HReRg/NN6vD7+CWcxyFX6cza5lvH+aRDqppsUhGruXQkZtHcUd5bc7so
	S3Nwk0s7vuDpbAmx9FqAmVfbyslrPl6z58Pj4Zmekim2m65BwUpxO6uC5qJeqcCJo4DhM7
	cK4aYSsnC6Q3VuSJ/DeL5YVWcwF4YxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQF/sT+iiJrJkYrPNV8viCwhns8T6ZZy5JjIW6cf+Dk=;
	b=GOu9TGU1ql/GUd979saV+oK8uEjOSS5VB6mB9yZgDW6iJZ8/uF7PWK86Eag3fNN4TvyG03
	BbIPeVjTYjnoQiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ABFA13A15;
	Fri,  6 Dec 2024 02:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fntfACpfUmc6JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:22 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 04/11] nfs: combine NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK
Date: Fri,  6 Dec 2024 13:15:30 +1100
Message-ID: <20241206021830.3526922-5-neilb@suse.de>
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
X-Rspamd-Queue-Id: 823701F394
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The flags NFS_LAYOUT_RETURN and NFS_LAYOUT_RETURN_LOCK are effectively
identical.
The only time either are cleared is in pnfs_clear_layoutreturn_waitbit(),
and there both are cleared.
The only time NFS_LAYOUT_RETURN is set is in pnfs_prepare_layoutreturn()
immediately after NFS_LAYOUT_RETURN_LOCK was set.
The only other time that NFS_LAYOUT_RETURN_LOCK is set is in
pnfs_mark_layout_stateid_invalid() if NFS_LAYOUT_RETURN was set but
NFS_LAYOUT_RETURN_LOCK was not set - but that is an impossible
combination given that else where the flags are set or cleared together.

So we only need one of these flags.  This patch discards
NFS_LAYOUT_RETURN_LOCK and does the test_and_set needed for exclusion with
NFS_LAYOUT_RETURN.

Also the wake_up_bit in pnfs_clear_layoutreturn_waitbit() is changed to
clear_and_wake_up_bit() which includes all needed barriers internally.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/pnfs.c | 15 ++++-----------
 fs/nfs/pnfs.h |  1 -
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0d16b383a452..5963c0440e23 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -386,10 +386,7 @@ pnfs_clear_layoutreturn_info(struct pnfs_layout_hdr *lo)
 
 static void pnfs_clear_layoutreturn_waitbit(struct pnfs_layout_hdr *lo)
 {
-	clear_bit_unlock(NFS_LAYOUT_RETURN, &lo->plh_flags);
-	clear_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags);
-	smp_mb__after_atomic();
-	wake_up_bit(&lo->plh_flags, NFS_LAYOUT_RETURN);
+	clear_and_wake_up_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	rpc_wake_up(&NFS_SERVER(lo->plh_inode)->roc_rpcwaitq);
 }
 
@@ -471,9 +468,6 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 	pnfs_clear_layoutreturn_info(lo);
 	pnfs_free_returned_lsegs(lo, lseg_list, &range, 0);
 	set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
-	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags) &&
-	    !test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
-		pnfs_clear_layoutreturn_waitbit(lo);
 	return !list_empty(&lo->plh_segs);
 }
 
@@ -1310,9 +1304,8 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
 	if (atomic_read(&lo->plh_outstanding) != 0)
 		return false;
-	if (test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
+	if (test_and_set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags))
 		return false;
-	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	pnfs_get_layout_hdr(lo);
 	nfs4_stateid_copy(stateid, &lo->plh_stateid);
 	*cred = get_cred(lo->plh_lc_cred);
@@ -1454,7 +1447,7 @@ _pnfs_return_layout(struct inode *ino)
 	/* Reference matched in nfs4_layoutreturn_release */
 	pnfs_get_layout_hdr(lo);
 	/* Is there an outstanding layoutreturn ? */
-	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
+	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
 		spin_unlock(&ino->i_lock);
 		if (wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
 					TASK_UNINTERRUPTIBLE))
@@ -1564,7 +1557,7 @@ bool pnfs_roc(struct inode *ino,
 		goto out_noroc;
 	}
 	pnfs_get_layout_hdr(lo);
-	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
+	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
 		spin_unlock(&ino->i_lock);
 		rcu_read_unlock();
 		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 30d2613e912b..df914f17b927 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -100,7 +100,6 @@ enum {
 	NFS_LAYOUT_RW_FAILED,		/* get rw layout failed stop trying */
 	NFS_LAYOUT_BULK_RECALL,		/* bulk recall affecting layout */
 	NFS_LAYOUT_RETURN,		/* layoutreturn in progress */
-	NFS_LAYOUT_RETURN_LOCK,		/* Serialise layoutreturn */
 	NFS_LAYOUT_RETURN_REQUESTED,	/* Return this layout ASAP */
 	NFS_LAYOUT_INVALID_STID,	/* layout stateid id is invalid */
 	NFS_LAYOUT_FIRST_LAYOUTGET,	/* Serialize first layoutget */
-- 
2.47.0


