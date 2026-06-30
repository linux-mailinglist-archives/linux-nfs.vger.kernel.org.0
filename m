Return-Path: <linux-nfs+bounces-22901-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uka4OaFURGoJtAoAu9opvQ
	(envelope-from <linux-nfs+bounces-22901-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED916E8B20
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ljQpz9ji;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22901-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22901-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5423077ACC
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21E31715B;
	Tue, 30 Jun 2026 23:43:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2B33A9F8
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 23:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862987; cv=none; b=r0v5SUfBd2jNHQOjvwSJ06piLUkOWOVMS3wOnBW3JC8VtTgejwIlJsbJE2bUGkHITQr7x8uvB/4UINc9nyG7jGlr4rZKfNtsti4XXsMrrz/KJA/bDBkMnB/jbxpi6yD+JHTUJaBIH6+Dr7B/BHORNelRmMyPtT+XMTM9c773ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862987; c=relaxed/simple;
	bh=uccZM0DqUcxeAOuynLRN+rnVfmOHrmSRN3cQ06r2iCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X70YBxrQg5e4fF74YkpEjT0LsQOjq7HXUD7xQk1uIBWh22Bi+p/DBOHXsWPnoVlCFAxbHjD+eAxo2VcgwwVr4Et2lrBNtS0Z2lrrW0UarVlrRtEPh78zC2jc8oM6+KMC7OrpaaMBmWiuXymyV6Koqxdm95roJrJktnJ7IwYPW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljQpz9ji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A831F000E9;
	Tue, 30 Jun 2026 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862986;
	bh=7neU2TGnFxRbVkHA27B0jB+58uCpyjby58Cg0fFGijk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljQpz9ji0G4zSb64f+Che75DYbPVxsu/ZLJYFnHQGRmdB/J5xyB45rQhUoZ/4MqBM
	 r/GLVqVATwFGnT5nyoKNb64486eZpMhhMd1k9Omg21TtPVRp51AHeqYywALxKjGjbs
	 TSyXzWJud3yxn4BWJ8W1tuwq20m5k0PNbx76KZqPB4Z+0xCxhi55oE8Qt1NwvikpVL
	 Nrf+b1JwEeLI9hIoieZ0yU6kZ++M516gxm2ioW7i63lE36dwqxNg7OVgytd0yJYT2u
	 wBhJOnzdniqdnuzo1KEcQhxMuPT+LZvCSULJWYmWHBmnX9LqSozdPYBY5S+g0Ii6PK
	 wfCsS6CI5T0NA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/6] nfs4.2: honor UNCACHEABLE_DIRENT_METADATA by refetching readdir
Date: Tue, 30 Jun 2026 19:42:57 -0400
Message-ID: <20260630234257.5615-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630234257.5615-1-snitzer@kernel.org>
References: <20260630234257.5615-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22901-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,ietf.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ietf.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ED916E8B20

Honor the per-directory UNCACHEABLE_DIRENT_METADATA attribute: when a
directory is marked uncacheable, nfs_readdir() bypasses the readdir page
cache and refetches directory-entry metadata from the server on every
readdir, satisfying the always-refetch semantics the attribute requires
(draft-ietf-nfsv4-uncacheable-directories Section 5.1).

Rather than searching the cached readdir folios, nfs_readdir() forces the
-EBADCOOKIE path so the request is served by uncached_readdir(); the
dir_cookie == 0 (start-of-directory) case is included so the very first
readdir of an uncacheable directory also goes to the server.  A
tracepoint records when an uncacheable directory bypasses the cache.

The metadata the attribute governs is the per-entry size and timestamps,
which are carried only by READDIRPLUS (a plain READDIR refreshes names
but leaves the entries' attributes to the inode attribute caches).  So
also force READDIRPLUS for an uncacheable directory (when the server is
capable): nfs_use_readdirplus() otherwise enables it only at the start of
the directory or once cache usage crosses a threshold, and the cache-
bypassing path above never accrues that usage -- which would leave
continuation READDIRs of a large directory refreshing names but serving
stale per-entry attributes.  Forcing READDIRPLUS makes each READDIR
refresh the entries' attribute caches (via nfs_prime_dcache() ->
nfs_refresh_inode()), so a subsequent stat() observes current values.

The attribute does not change NFSv4.2 change-attribute semantics: the
client continues to use the directory change attribute for validation;
this only suppresses serving READDIR responses from the local cache.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-directories/

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/dir.c      | 18 ++++++++++++++++--
 fs/nfs/nfstrace.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6b07abf272b1..2162e93992c2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -667,6 +667,14 @@ static bool nfs_use_readdirplus(struct inode *dir, struct dir_context *ctx,
 		return false;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_FORCE_RDIRPLUS)
 		return true;
+	/*
+	 * An uncacheable directory must refetch directory-entry metadata
+	 * (including per-entry size and timestamps) from the server on each
+	 * READDIR; force READDIRPLUS so those attributes are refreshed on
+	 * every call rather than left stale in the inode attribute caches.
+	 */
+	if (NFS_I(dir)->uncacheable_dirent_metadata)
+		return true;
 	if (ctx->pos == 0 ||
 	    cache_hits + cache_misses > NFS_READDIR_CACHE_USAGE_THRESHOLD)
 		return true;
@@ -1274,12 +1282,18 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->clear_cache = force_clear;
 
 	do {
-		res = readdir_search_pagecache(desc);
+		if (nfsi->uncacheable_dirent_metadata) {
+			res = -EBADCOOKIE;
+			trace_nfs_readdir_uncacheable_directory(inode);
+		} else {
+			res = readdir_search_pagecache(desc);
+		}
 
 		if (res == -EBADCOOKIE) {
 			res = 0;
 			/* This means either end of directory */
-			if (desc->dir_cookie && !desc->eof) {
+			if ((desc->dir_cookie || nfsi->uncacheable_dirent_metadata) &&
+			    !desc->eof) {
 				/* Or that the server has 'lost' a cookie */
 				res = uncached_readdir(desc);
 				if (res == 0)
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b15c1732c869..a9930d59c610 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -181,6 +181,7 @@ DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
 DEFINE_NFS_INODE_EVENT(nfs_readdir_force_readdirplus);
+DEFINE_NFS_INODE_EVENT(nfs_readdir_uncacheable_directory);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
 
-- 
2.47.3


