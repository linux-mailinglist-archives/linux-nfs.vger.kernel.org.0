Return-Path: <linux-nfs+bounces-21876-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHqvF+3pEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21876-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:54:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D32CA5C01E8
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F0153012CDE
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AEF30CD81;
	Sat, 23 May 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="entiYHeQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EB2BB1D;
	Sat, 23 May 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558888; cv=none; b=mIKbWpTgzXl4tp08HLppYIZVtN1Q3x54uY62MWBJXfk0iEkseFonWsqO6v8FT1GWieysvUe3+S6FyPkPwFU6vqfDbX1vOyhD/hqgDqWiMRxK3Fkc1qn20kBE0Cr+zSr9LIxcEgHO0OpZZnB7FKPfb2XktCT+YLktDRNo0l5onPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558888; c=relaxed/simple;
	bh=r0cd8m/9lPWo3zUY7DznvxrgWtjRfjZqyn47CNuIbBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ch3OuzPUGE9j1flY1QkNYodUsLVd51skmmb99kAQ2ZaCPbJEQK9pM7Hp99SRzMLyZ/3UQnJ8PRwjqAwVOOgc6kjGs6np7SfXqtg6/VIVLKuR/x/TJ7Ir6aPX0drzR1bY59Q/5M7Zpr8xfVOjra8q8GIv49pkJzGGvICyITE4FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=entiYHeQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644EE1F00A3A;
	Sat, 23 May 2026 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558887;
	bh=xNqONibNib/HURDSoCRdl8F/ugaDRVHwkYT5A3d+6K0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=entiYHeQKdJpCq2RAkO9V3DfpsOkdAweTN9otxUQ+O8vgrrn4uoBnmky9dnsr9Fbx
	 m4wuzqZzR5kX+E9pPoVCmlFVpTAW11ZEZACAYWQV4RjU+r1ZFA22q8b2P5ph0C7YXK
	 1DXqT1uS77S65UKLbwRFPf6L/4TWqrNbTww9gtbYR5ZfBcfDx1tVRapQXmJMHH+5Qk
	 n8XIwq073N7B/vc1ZNlgL3xUnvihMimNGqIBpzEqFqEavTPULAoZuVZjF7WDOvBjeD
	 PUHEN8u42mw/tjliBBXnMPRf2hgPurks8kLmsMdUGiyYXv57Cm7/XiWGt/T2OaWkqZ
	 RFoyBRXH51pfw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:13 +0300
Subject: [PATCH 01/17] quota: allocate dquot_hash with kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-1-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
To: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Kees Cook <kees@kernel.org>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21876-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D32CA5C01E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dquot_init() allocates a single page for dquot_hash with
__get_free_pages().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_pages() with kmalloc() and get rid of the order
variable that remained 0 for more than 20 years.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/quota/dquot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 64cf42721496..9850de3955d3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3022,7 +3022,7 @@ static const struct ctl_table fs_dqstats_table[] = {
 static int __init dquot_init(void)
 {
 	int i, ret;
-	unsigned long nr_hash, order;
+	unsigned long nr_hash;
 	struct shrinker *dqcache_shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
@@ -3035,8 +3035,7 @@ static int __init dquot_init(void)
 				SLAB_PANIC),
 			NULL);
 
-	order = 0;
-	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_KERNEL, order);
+	dquot_hash = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!dquot_hash)
 		panic("Cannot create dquot hash table");
 
@@ -3046,7 +3045,7 @@ static int __init dquot_init(void)
 		panic("Cannot create dquot stat counters");
 
 	/* Find power-of-two hlist_heads which can fit into allocation */
-	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
+	nr_hash = PAGE_SIZE / sizeof(struct hlist_head);
 	dq_hash_bits = ilog2(nr_hash);
 
 	nr_hash = 1UL << dq_hash_bits;
@@ -3054,8 +3053,8 @@ static int __init dquot_init(void)
 	for (i = 0; i < nr_hash; i++)
 		INIT_HLIST_HEAD(dquot_hash + i);
 
-	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
-		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
+	pr_info("VFS: Dquot-cache hash table entries: %ld (%ld bytes)\n",
+		nr_hash, PAGE_SIZE);
 
 	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
 	if (!dqcache_shrinker)

-- 
2.53.0


