Return-Path: <linux-nfs+bounces-6294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCA96E7BF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 04:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D10B23AC7
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 02:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE401ECF;
	Fri,  6 Sep 2024 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FsdfyKnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TLCCi79M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FsdfyKnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TLCCi79M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3062E62C
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589935; cv=none; b=j16pvxgTGb/XhMFbPCIM3TNMIsf2duTKu1xZVPd+uwhOV3C7yjMsUxBtttbWOAM4fNV4ZyUUty4Yy1jxUC8/lWFPvyin4evzqao3Yj+riJ79Pb+xKxdQbl+kLBLM8MkRPHMr1kv3OH4iAqIV8WEwiJn8Xak8oi7DdpjkYsdwuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589935; c=relaxed/simple;
	bh=QwLlEWMmhpx0v0fbgXPJwNzT5CobcqSqUidonulYwm4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=L2jK2Jmk1QV1Ub+Tsv4pUXD87Lrc3I19F/9jyUy2YSYsH0dwUi3mJl9icmM5fcfK/tnAA7aQYgaDrJNaIITqEx3STH7KujLTdyNm0YDprQqcEZB61SZvP14a9/VaB4ZlaX1Grgk/KD+qQDd/rWkKfUX/BkI6D3qEb7jM0jBBrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FsdfyKnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TLCCi79M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FsdfyKnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TLCCi79M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB9AA21B91;
	Fri,  6 Sep 2024 02:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725589931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JFBw2oSCDR1fYmfr7gZbOAIxkj8LcNW0usoND40iPtk=;
	b=FsdfyKnOSqaR+4A4IZXCvhdXc8yKyYM+9giFy52hnususlWqZpq54Wfja7vN0BsadfK67n
	KDZnLFI6iOCxi1I9MhkoFNlHMQw6M5YFKyslDxm/MV92tCUTRiX4yE2qaRHX0yvSruyYfv
	nl4oKz88J2f/KX4eDr+WeDo4MtOy3dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725589931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JFBw2oSCDR1fYmfr7gZbOAIxkj8LcNW0usoND40iPtk=;
	b=TLCCi79MW3bynqJwTeg1kEq18G+H1edsSA/oc4ATG3iiMJ3QPUM+sp3T7Iz8LPCkHob+aS
	zzBnSivQ5mhsLJBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FsdfyKnO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TLCCi79M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725589931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JFBw2oSCDR1fYmfr7gZbOAIxkj8LcNW0usoND40iPtk=;
	b=FsdfyKnOSqaR+4A4IZXCvhdXc8yKyYM+9giFy52hnususlWqZpq54Wfja7vN0BsadfK67n
	KDZnLFI6iOCxi1I9MhkoFNlHMQw6M5YFKyslDxm/MV92tCUTRiX4yE2qaRHX0yvSruyYfv
	nl4oKz88J2f/KX4eDr+WeDo4MtOy3dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725589931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JFBw2oSCDR1fYmfr7gZbOAIxkj8LcNW0usoND40iPtk=;
	b=TLCCi79MW3bynqJwTeg1kEq18G+H1edsSA/oc4ATG3iiMJ3QPUM+sp3T7Iz8LPCkHob+aS
	zzBnSivQ5mhsLJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77FEB13508;
	Fri,  6 Sep 2024 02:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8YGlC6pp2macXwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Sep 2024 02:32:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: simplify and guarantee owner uniqueness.
Date: Fri, 06 Sep 2024 12:32:03 +1000
Message-id: <172558992310.4433.1385243627662249022@noble.neil.brown.name>
X-Rspamd-Queue-Id: AB9AA21B91
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO


I have evidence of an Linux NFS client getting NFS4ERR_BAD_SEQID to a
v4.0 LOCK request to a Linux server (which had fixed the problem with
RELEASE_LOCKOWNER bug fixed).
The LOCK request presented a "new" lock owner so there are two seq ids
in the request: that for the open file, and that for the new lock.
Given the context I am confident that the new lock owner was reported to
have the wrong seqid.  As lock owner identifiers are reused, the server
must still have a lock owner active which the client thinks is no longer
active.

I wasn't able to determine a root-cause but the simplest fix seems to be
to ensure lock owners are always unique much as open owners are (thanks
to a time stamp).  The easiest way to ensure uniqueness is with a 64bit
counter for each server.  That will never cycle (if updated once a
nanosecond the last 584 years.  A single NFS server would not handle
open/lock requests nearly that fast, and a Linux node is unlikely to
have an uptime approaching that).

This patch removes the 2 ida and instead uses a per-server
atomic64_t to provide uniqueness.

Note that the lock owner already encodes the id as 64 bits even though
it is a 32bit value.  So changing to a 64bit value does not change the
encoding of the lock owner.  The open owner encoding is now 4 bytes
larger.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/client.c           |  6 ++----
 fs/nfs/nfs4_fs.h          |  2 +-
 fs/nfs/nfs4state.c        | 15 ++-------------
 fs/nfs/nfs4xdr.c          |  6 +++---
 include/linux/nfs_fs_sb.h |  3 +--
 include/linux/nfs_xdr.h   |  2 +-
 6 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 8286edd6062d..3fea7aa1366f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -997,8 +997,8 @@ struct nfs_server *nfs_alloc_server(void)
 	init_waitqueue_head(&server->write_congestion_wait);
 	atomic_long_set(&server->writeback, 0);
=20
-	ida_init(&server->openowner_id);
-	ida_init(&server->lockowner_id);
+	atomic64_set(&server->owner_ctr, 0);
+
 	pnfs_init_server(server);
 	rpc_init_wait_queue(&server->uoc_rpcwaitq, "NFS UOC");
=20
@@ -1037,8 +1037,6 @@ void nfs_free_server(struct nfs_server *server)
 	}
 	ida_free(&s_sysfs_ids, server->s_sysfs_id);
=20
-	ida_destroy(&server->lockowner_id);
-	ida_destroy(&server->openowner_id);
 	put_cred(server->cred);
 	nfs_release_automount_timer();
 	call_rcu(&server->rcu, delayed_free);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index c2045a2a9d0f..7d383d29a995 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -83,7 +83,7 @@ struct nfs4_minor_version_ops {
 #define NFS_SEQID_CONFIRMED 1
 struct nfs_seqid_counter {
 	ktime_t create_time;
-	int owner_id;
+	u64 owner_id;
 	int flags;
 	u32 counter;
 	spinlock_t lock;		/* Protects the list */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b45f2..08725fd416e4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -501,11 +501,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	sp =3D kzalloc(sizeof(*sp), gfp_flags);
 	if (!sp)
 		return NULL;
-	sp->so_seqid.owner_id =3D ida_alloc(&server->openowner_id, gfp_flags);
-	if (sp->so_seqid.owner_id < 0) {
-		kfree(sp);
-		return NULL;
-	}
+	sp->so_seqid.owner_id =3D atomic64_inc_return(&server->owner_ctr);
 	sp->so_server =3D server;
 	sp->so_cred =3D get_cred(cred);
 	spin_lock_init(&sp->so_lock);
@@ -536,7 +532,6 @@ static void nfs4_free_state_owner(struct nfs4_state_owner=
 *sp)
 {
 	nfs4_destroy_seqid_counter(&sp->so_seqid);
 	put_cred(sp->so_cred);
-	ida_free(&sp->so_server->openowner_id, sp->so_seqid.owner_id);
 	kfree(sp);
 }
=20
@@ -879,19 +874,13 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(st=
ruct nfs4_state *state, f
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state =3D state;
 	lsp->ls_owner =3D owner;
-	lsp->ls_seqid.owner_id =3D ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCO=
UNT);
-	if (lsp->ls_seqid.owner_id < 0)
-		goto out_free;
+	lsp->ls_seqid.owner_id =3D atomic64_inc_return(&server->owner_ctr);
 	INIT_LIST_HEAD(&lsp->ls_locks);
 	return lsp;
-out_free:
-	kfree(lsp);
-	return NULL;
 }
=20
 void nfs4_free_lock_state(struct nfs_server *server, struct nfs4_lock_state =
*lsp)
 {
-	ida_free(&server->lockowner_id, lsp->ls_seqid.owner_id);
 	nfs4_destroy_seqid_counter(&lsp->ls_seqid);
 	kfree(lsp);
 }
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 7704a4509676..1aaf908acc5d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1424,12 +1424,12 @@ static inline void encode_openhdr(struct xdr_stream *=
xdr, const struct nfs_opena
  */
 	encode_nfs4_seqid(xdr, arg->seqid);
 	encode_share_access(xdr, arg->share_access);
-	p =3D reserve_space(xdr, 36);
+	p =3D reserve_space(xdr, 40);
 	p =3D xdr_encode_hyper(p, arg->clientid);
-	*p++ =3D cpu_to_be32(24);
+	*p++ =3D cpu_to_be32(28);
 	p =3D xdr_encode_opaque_fixed(p, "open id:", 8);
 	*p++ =3D cpu_to_be32(arg->server->s_dev);
-	*p++ =3D cpu_to_be32(arg->id.uniquifier);
+	xdr_encode_hyper(p, arg->id.uniquifier);
 	xdr_encode_hyper(p, arg->id.create_time);
 }
=20
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1df86ab98c77..e1e47ebd83ef 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -234,8 +234,7 @@ struct nfs_server {
 	/* the following fields are protected by nfs_client->cl_lock */
 	struct rb_root		state_owners;
 #endif
-	struct ida		openowner_id;
-	struct ida		lockowner_id;
+	atomic64_t		owner_ctr;
 	struct list_head	state_owners_lru;
 	struct list_head	layouts;
 	struct list_head	delegations;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 45623af3e7b8..96ba04ab24f3 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -446,7 +446,7 @@ struct nfs42_clone_res {
=20
 struct stateowner_id {
 	__u64	create_time;
-	__u32	uniquifier;
+	__u64	uniquifier;
 };
=20
 struct nfs4_open_delegation {
--=20
2.44.0


