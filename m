Return-Path: <linux-nfs+bounces-22978-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QAaHCgP0R2o2iAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22978-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 19:40:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91036704AEF
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 19:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HN+IeiMz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22978-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22978-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DCA33035885
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D330BBB6;
	Fri,  3 Jul 2026 17:39:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DF30B53A
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 17:39:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100390; cv=none; b=l/lTC6E6hIFRAzpg5g7sCFdTKIGYP4XYW0rlDUG1P8pcbDQnX5s1PNjQESUt9oZxODj5nBKBHZm6tA+Segw51H9qSdGLQQtLJ4GwnTWYIENEqsz/RI4ddkx6iD2K1rxGI0/dJp6SxkDy4kpPCJFJ2bm/hF9tAhlzg0ACSSGJqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100390; c=relaxed/simple;
	bh=dCKx8NWKEQryiSj/GzPRoj54Tk7Qh9curyNdtVk0eg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDSGUv0sOoiKm6AE9Lqtay8YSpBwRtfc5c7Pt1ReEt44rLsogj+jjd/IYDXdCntewPk6n/uWk5CMI28yntdXhOI7BA2X10S88EGy9M0+66vf+BAyrJYrkNVLX/r7t+LMnEvdygWUDcDC5R/l0Wl26DiqgDCB5oi7bK/NQeocwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN+IeiMz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACE81F000E9;
	Fri,  3 Jul 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783100387;
	bh=vAc6tKqNeF9I7/TT3mcS3yFWVOBZLANtnUmC1I9H+X0=;
	h=From:To:Cc:Subject:Date;
	b=HN+IeiMzDK2XwE3NW5cL12OEQiFhCBZG72St5VahQdBxg98kmzjJbW2/DuidTO2pR
	 NCZ+BqcNxMeZNHS6h5SXbTcSE8H8wHjv7RgXk52vFh4cl7F8IPjakoNm9DJYwR1kde
	 u6TdxTYVgPIT35dNOMUOExv/sYKJEf9Z6BZ20etzSeiNxK9LyWGoLEh2eQNEQBS6Z9
	 RVX+5h6vwaV5VCF5U9kk3jCTSQRrtohlJSARyag2cvWZ13s3yozkzmyVPN3LTn3bbN
	 jw3Aw5Gp2+m5j9Iw4d8cHhJ/679fihfIsfICiSK2r/yQJgunmUNKC1T2lAa7fyjH80
	 MnlHQiSlIaZSA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Wolfgang Walter <linux@stwm.de>
Subject: [RFC PATCH] NFSD: Prevent lock owner use-after-free during client teardown
Date: Fri,  3 Jul 2026 13:39:43 -0400
Message-ID: <20260703173943.3242873-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22978-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neilb@ownmail.net,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,stwm.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91036704AEF

After __destroy_client() releases a client's open owners, a lock owner
whose only remaining reference is a blocked lock (nbl) is left on
cl_ownerstr_hashtbl.  client_has_state() does not account for a bare
lock owner, so DESTROY_CLIENTID can reach __destroy_client() with these
lock owners still present.

__destroy_client() then walks cl_ownerstr_hashtbl and calls
remove_blocked_locks() on each lock owner without holding a reference.
Freeing a blocked lock drops the lock owner reference held through the
file_lock's flc_owner, so the per-net laundromat, which reaps timed-out
blocked locks from nn->blocked_locks_lru independently of client state,
can free the same lock owner concurrently.  The two paths serialize on
blocked_locks_lock for the list splice only, not for the lock owner's
lifetime.  The laundromat can therefore free the lock owner while
__destroy_client() is about to dereference it, and the freed, zeroed
slab object produces a NULL dereference in remove_blocked_locks().

nfsd4_release_lockowner() holds a reference across the same call;
__destroy_client() does not.  Hold cl_lock across the walk, and
take a reference and unhash each lock owner before dropping the
lock, so the laundromat cannot reap a blocked lock and free the
lock owner underneath this loop.  cl_lock is released before
remove_blocked_locks() and nfs4_put_stateowner(), which take
blocked_locks_lock and cl_lock respectively.

Reported-by: Wolfgang Walter <linux@stwm.de>
Closes: https://lore.kernel.org/linux-nfs/6eccafaaaa60651ef091257c3439c46b@stwm.de/
Fixes: 68ef3bc31664 ("nfsd: remove blocked locks on client teardown")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a4398dc861a5..e000ed3e96e9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2758,14 +2758,24 @@ __destroy_client(struct nfs4_client *clp)
 		release_openowner(oo);
 	}
 	for (i = 0; i < OWNER_HASH_SIZE; i++) {
-		struct nfs4_stateowner *so, *tmp;
+		struct nfs4_stateowner *so;
 
-		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
-					 so_strhash) {
+		spin_lock(&clp->cl_lock);
+		while (!list_empty(&clp->cl_ownerstr_hashtbl[i])) {
+			so = list_first_entry(&clp->cl_ownerstr_hashtbl[i],
+					      struct nfs4_stateowner, so_strhash);
 			/* Should be no openowners at this point */
 			WARN_ON_ONCE(so->so_is_open_owner);
+			nfs4_get_stateowner(so);
+			unhash_lockowner_locked(lockowner(so));
+			spin_unlock(&clp->cl_lock);
+
 			remove_blocked_locks(lockowner(so));
+			nfs4_put_stateowner(so);
+
+			spin_lock(&clp->cl_lock);
 		}
+		spin_unlock(&clp->cl_lock);
 	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_copy(clp);
-- 
2.54.0


