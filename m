Return-Path: <linux-nfs+bounces-20405-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE15GaMTxWnr6QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20405-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:08:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA7C3340E0
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D02D3143EDC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D53BED36;
	Thu, 26 Mar 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHcsoPv4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285DA3E7145
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522039; cv=none; b=ZZFF6CjNd4FBi2sUiYpeYu8VO6AUHkK9eVEaIWE2VIuMMkdTHhWjEzZipEwCUAkxnSIGOjtAKil93tIlGAxYCCQUehxzUj8uOm7vCGswRVUY75rd6ZMwB0jUEAJB+BNtlRpA1CTOPgvnMTI0RB3PgNbMgKRjpW+BlbcvbWkVfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522039; c=relaxed/simple;
	bh=5oiL4h3gwETW05fsIL6ptaxARlHp1gU+1xVFfXCtL9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXDI5jWSu5LaOFfNkt+9weVKS13CeO/uNObJrVMSXyhrf700FQ+gvRnS2EutKakW3UZG+v4Utn+5hr0NyblERnlEozQyYAel/nLtvyXezZV1vmECQN6XYcEAxDcZdv6WeMhJFa61SkkzS5Ey4IMJvIFkJHBDzfB7SwRfWAchtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHcsoPv4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMTqSI3JlWcbbZ5ax9gnuhYVE8KLn3P9vdg2r2cDfs=;
	b=PHcsoPv4VOhZwnBth+8Cm8WMMCG68v1xtdYfsmuuYT/lyFZFExRxF+5O6Do8S1hYwaeBSp
	P+nkp92rAV4ycrzVWJsWL2LCaxC6ZYBe/tzGSCUaqaVSUjDMpoLZU0BX+vHV05mhSjS87Q
	TESDxNh8i+x/3DnvNLHd6vQDpXZbvfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-292P2OpvMDm-lsocWZMW3Q-1; Thu,
 26 Mar 2026 06:47:12 -0400
X-MC-Unique: 292P2OpvMDm-lsocWZMW3Q-1
X-Mimecast-MFC-AGG-ID: 292P2OpvMDm-lsocWZMW3Q_1774522029
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B90819560BB;
	Thu, 26 Mar 2026 10:47:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9D3519560B1;
	Thu, 26 Mar 2026 10:47:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
Date: Thu, 26 Mar 2026 10:45:22 +0000
Message-ID: <20260326104544.509518-8-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20405-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auristor.com:email,manguebit.org:email,brown.name:email]
X-Rspamd-Queue-Id: DEA7C3340E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
former's ref on the victim dentry that it obtained from
cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
of the victim in place, resulting in occasional:

  WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/11831
  cachefiles_cull+0x8c/0xe0 [cachefiles]
  cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
  cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
  vfs_write+0xc3/0x480
  ...

reports.

Actually, it's worse than that: cachefiles_bury_object() eats the ref it was
given - and then may continue to the now-unref'd dentry it if it turns out to
be a directory.  So simply removing the aberrant dput() is not sufficient.

Fix this by making cachefiles_bury_object() retain the ref itself around
end_removing() if it needs to keep it and then drop the ref before returning.

Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: NeilBrown <neil@brown.name>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27..20138309733f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -287,14 +287,14 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	if (!d_is_dir(rep)) {
 		ret = cachefiles_unlink(cache, object, dir, rep, why);
 		end_removing(rep);
-
 		_leave(" = %d", ret);
 		return ret;
 	}
 
 	/* directories have to be moved to the graveyard */
 	_debug("move stale object to graveyard");
-	end_removing(rep);
+	dget(rep);
+	end_removing(rep); /* Drops ref on rep */
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -304,8 +304,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	/* do the multiway lock magic */
 	trap = lock_rename(cache->graveyard, dir);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
+	if (IS_ERR(trap)) {
+		ret = PTR_ERR(trap);
+		goto out;
+	}
 
 	/* do some checks before getting the grave dentry */
 	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
@@ -313,25 +315,27 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		 * lock */
 		unlock_rename(cache->graveyard, dir);
 		_leave(" = 0 [culled?]");
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
+	ret = -EIO;
 	if (!d_can_lookup(cache->graveyard)) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "Graveyard no longer a directory");
-		return -EIO;
+		goto out;
 	}
 
 	if (trap == rep) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
+		goto out;
 	}
 
 	if (d_mountpoint(rep)) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "Mountpoint in cache");
-		return -EIO;
+		goto out;
 	}
 
 	grave = lookup_one(&nop_mnt_idmap, &QSTR(nbuffer), cache->graveyard);
@@ -343,11 +347,12 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 		if (PTR_ERR(grave) == -ENOMEM) {
 			_leave(" = -ENOMEM");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
-		return -EIO;
+		goto out;
 	}
 
 	if (d_is_positive(grave)) {
@@ -362,7 +367,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		unlock_rename(cache->graveyard, dir);
 		dput(grave);
 		cachefiles_io_error(cache, "Mountpoint in graveyard");
-		return -EIO;
+		goto out;
 	}
 
 	/* target should not be an ancestor of source */
@@ -370,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		unlock_rename(cache->graveyard, dir);
 		dput(grave);
 		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
+		goto out;
 	}
 
 	/* attempt the rename */
@@ -404,8 +409,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
 	unlock_rename(cache->graveyard, dir);
 	dput(grave);
-	_leave(" = 0");
-	return 0;
+	_leave(" = %d", ret);
+out:
+	dput(rep);
+	return ret;
 }
 
 /*
@@ -812,7 +819,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
-	dput(victim);
 	if (ret < 0)
 		goto error;
 


