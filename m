Return-Path: <linux-nfs+bounces-22352-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Us9LCKXgJmr+mAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22352-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:32:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9066581ED
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 17:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cnU39MNz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22352-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22352-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CCF03077831
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526AE3EFFC7;
	Mon,  8 Jun 2026 14:55:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA73EF65B
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 14:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930509; cv=none; b=nLH06vyCyiQZTPhnLdoyo6zAeTrs6pgD5CViA4csnXTn6wLcG6wibUD5Q+FW+S1anfwI6evn3A8Y9xYQF1R/9ueSLNoHhCkYxk8I4+D4PW1ajmmpSqr0bzfBQa8bOZ7QrJ+NwpCJfe6jkZIJo4vo5MDIy2/TEZhvUblJDyD2mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930509; c=relaxed/simple;
	bh=zCd/iNdBzMzBN8CIod7ZZV56ICy+rSCXqOJZZvgRkeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcfEIWIp3J6KrczSkJI/GLFNG1kCC2kbIEyzoqjyOjncXwdVvActVFwUthQmVF/okex+u6EsB7eW+de8HMNE5H/IR82oLOIfEKadG6+BwMuehbdMpxnKU4oVbhLv5nqtwAj7WiUNNlK1wQefMDZmnJC7kaBN16DPqOoK71zbuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnU39MNz; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780930507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRFmJ/J1AuXTPRw4YdoDWjljqrX4pDv27mJgEf6FBEw=;
	b=cnU39MNzSaCNca+ZLLarEG/Y3ydgGL4o0hN+1F2IY6CRXRH7mm2E3tQNe+rAngyZZ0pekr
	iWcr+WR+4tIHiEDNoaBf7rP30XAyOSjOzSFIOKqkgyY5LEj3Z7RByf95liOPwDl6DqPCJr
	0ZMhVKpvErBf5F3uf+o5DPUepgcL/Us=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-csTOZHPLPLuOOUmuk6FytQ-1; Mon,
 08 Jun 2026 10:55:01 -0400
X-MC-Unique: csTOZHPLPLuOOUmuk6FytQ-1
X-Mimecast-MFC-AGG-ID: csTOZHPLPLuOOUmuk6FytQ_1780930498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E26981956094;
	Mon,  8 Jun 2026 14:54:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6747F3008B35;
	Mon,  8 Jun 2026 14:54:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/22] netfs: Fix decision whether to disallow write-streaming due to fscache use
Date: Mon,  8 Jun 2026 15:54:09 +0100
Message-ID: <20260608145432.681865-2-dhowells@redhat.com>
In-Reply-To: <20260608145432.681865-1-dhowells@redhat.com>
References: <20260608145432.681865-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22352-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,manguebit.org:email,linux.dev:email,auristor.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB9066581ED

netfs_perform_write() buffers data by writing it into the pagecache for
later writeback.  If the folio it wants to write to isn't present, it uses
"write streaming" in which is will store partial data in a non-uptodate,
but dirty folio.

However, when fscache is in use, this is a potential problem as writes to
the cache have to be aligned to the cache backend's DIO granularity, and so
netfs_perform_write() attempts to suppress write-streaming in such a case,
requiring the folio content to be fetched first unless the entire folio is
going to be overwritten.  This allows the content to be written to the
cache too.

Unfortunately, the test netfs_perform_write() uses isn't correct because it
doesn't take into account the fact that the object lookup is asynchronous
and farmed off to a work queue, so there's a short window in which the
cache is doing a lookup but the test fails because the answer is undefined.

This can be triggered by the generic/464 xfstest, and causes a warning to
be emitted in cachefiles (in code not yet upstream) because it sees a write
that doesn't have its bounds rounded out to DIO alignment.

Fix this by changing the condition to whether FSCACHE_COOKIE_IS_CACHING is
set on a cookie rather than whether the cookie is marked enabled.  Note
that this is really just a hint as to whether we allow write streaming or
not and no other aspects of the cookie or cache object are accessed.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c |  2 +-
 fs/netfs/internal.h       | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 6bde3320bcec..2cdb68e6b16f 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -277,7 +277,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * caching service temporarily because the backing store got
 		 * culled.
 		 */
-		if (netfs_is_cache_enabled(ctx)) {
+		if (netfs_is_cache_maybe_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
 				goto flush_content;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 645996ecfc80..d889caa401dc 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -239,6 +239,18 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 #endif
 }
 
+static inline bool netfs_is_cache_maybe_enabled(struct netfs_inode *ctx)
+{
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct fscache_cookie *cookie = ctx->cache;
+
+	return fscache_cookie_valid(cookie) &&
+		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+#else
+	return false;
+#endif
+}
+
 /*
  * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap).
  */


