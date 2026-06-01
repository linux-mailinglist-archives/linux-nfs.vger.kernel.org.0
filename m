Return-Path: <linux-nfs+bounces-22180-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAgpCZHCHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22180-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:34:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA06234CF
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14E653025641
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1993E276D;
	Mon,  1 Jun 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j51RBHbT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BA3E2759;
	Mon,  1 Jun 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335102; cv=none; b=Akmzrg6JeqX45z3/yOjsKSEfDPLqiHTKpoyirb+jW5LwYKkiXeucBvxDelB76MdwlHvX/h/C3duBExD7WJ+RTMkIZO2KbYpKbsOVe3I3VYavjfdqsQqHba5AeU/O0AaWTnfyfSANOVCz89R1+wRdn3ozLTblGMB1alJPGjfse/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335102; c=relaxed/simple;
	bh=QyeWtrI9A+N6rR9y0AS2o40h2YkNvdZeQ3dRpIReu1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uApwScskgU3p37Q3AvI4ARv1CZc1X+0sasZrGdmNniv/UtwG3n6Ux1JqqYHjlsC3AQugU8G4Ih3ci4nfZY6s7EFfKPj+VARUSO1havzH+yEZWJxlvKC0uz9+daSuaBix5dDVnnm0mn9pdv0T2CdmQC+paZu6nJcScxxXf8X8nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j51RBHbT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551821F00898;
	Mon,  1 Jun 2026 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335100;
	bh=XNSuSbNi8UDp/7y3bhjNC73fcr/uNxJx2hhHh8HNntY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j51RBHbTM6kcTigQUJ6mBVN7Xy6q+m6jNseFI8N1ZqaPE0PsCg5NzXwzoFFdNqJVk
	 qvtlB0YjlIc0KkEzN9JybKZfltpNHEZa6KISdxY8+Mi70ODS4Bi+sMJKNRuwIQtO53
	 bUks1JoyRmazfh7ieHWu93pxnytKclxWwscm9wBbbTswmy0dek0NQJ45rYs7NCrTm+
	 tBze8w0CYe3F/ignvnB1vkOKMO/eGGD9kF7DuLc307+NI+AhRQ4K2GfaPVS3WRFUTv
	 ngymbSVNtB4McN4OjJV72Mj0KrctWKcnUKX3fQLkL03fprPdbdx0lsTWDEO6KoW0hO
	 m28f9eGYyRKxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:11 -0400
Subject: [PATCH 8/8] nfsd: hold net namespace reference in nfsd_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nfsd-testing-v1-8-d0f61e536df8@kernel.org>
References: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
In-Reply-To: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5494; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QyeWtrI9A+N6rR9y0AS2o40h2YkNvdZeQ3dRpIReu1k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHuJOrDgY3fPYgMsvWgT/AMvQGdeZLKUNYWX
 32HKMaCeRaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7gAKCRAADmhBGVaC
 FeFZEACjOAsAp1c+2d46AbgnCTrR+CXooIc0Fl5DufK+NI7y+Pjta06E+MwWvWfNqHj1AMw/v/o
 RY39ae6hefBhOnZtajOsIF3jE4MFCyeBvilcS90HxEEW2ooxGZFh9S38+w9ns0klxtWRl34qlMn
 yNEKb2QmrSN6BvUMJcg/UuoYxfLNwzhh0SvecVyDIQUMVhdgKZCQ2c3V13obsPDc4rA8lJ5kVXc
 1GgFUxhYeYwTEuhAg6wIzkJoiPTECIC9LN8w47M4xaHIJL/SpeE6w9jXREv5TYLiUq7dy6daYVU
 wxlqSFj/iqr8759Yawc4ZW5wPNSzMQhQlg7vTd7fuNp/Fdl4LWXztj/pEFIA92MGEKSNeXC82CO
 GF2HM0I53anZAXYifTfOZLhVg46wwd8HxckSq9CdA+zMT6TDpsX9JU1svX9QU3JTFgqRTwmXZQM
 t+ddUEPgLxZxbeip4BPv4cKo8XWUdCSpdsstWsuHroPtvqHFIQH8UAM9GeAGu8gqGT5tgpjbbkM
 MEW+r3Xh5WkRm/xFHuAS6cviK8CZJ7Mng+S0/PPoMU7Y+yR30GuBqm6UYq2IzYbAvQxO7+/BTLn
 w14ajliE1kuDtvpIQOpBGU2iK82DUZr3VuRJYwPLJdiFKnIldnBeRL5xAOxppsbJduvZkIq5gxg
 Bnr07ApVxuACWmg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22180-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29CA06234CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Take a net-namespace reference in nfsd_file_alloc() (get_net) and
release it in nfsd_file_free() (put_net), so that nf_net is always
valid for files that the GC or shrinker has isolated from the hash
table and LRU -- which __nfsd_file_cache_purge() cannot see.

Without this, nf_net can dangle for in-flight files whose net namespace
is torn down concurrently, causing a use-after-free when
nfsd_file_dispose_list_delayed() calls net_generic(nf->nf_net, ...).

Because nfsd_file_free() now calls put_net(nf->nf_net), the old
nfsd_file_put_local() pattern of returning nf->nf_net after
nfsd_file_put() is unsafe -- put_net() could theoretically drop the
last net namespace reference, leaving the returned pointer stale.
Fix this by moving the nfsd_net_put() call into nfsd_file_put_local()
itself, before the nfsd_file_put() that may trigger nfsd_file_free().
The function now returns void and the caller no longer needs to handle
the net reference.

Fixes: 43fd953fa7e2 ("nfsd: simplify the delayed disposal list code")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c        | 22 ++++++++++++++--------
 fs/nfsd/filecache.h        |  2 +-
 fs/nfsd/localio.c          |  4 ++--
 include/linux/nfslocalio.h |  9 ++-------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 03f01a0beced..6f75df344091 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -221,7 +221,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	nf->nf_birthtime = ktime_get();
 	nf->nf_file = NULL;
 	nf->nf_cred = get_current_cred();
-	nf->nf_net = net;
+	nf->nf_net = get_net(net);
 	nf->nf_flags = want_gc ?
 		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC) :
 		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
@@ -295,6 +295,8 @@ nfsd_file_free(struct nfsd_file *nf)
 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
 		return;
 
+	put_net(nf->nf_net);
+
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
 }
 
@@ -375,24 +377,28 @@ nfsd_file_put(struct nfsd_file *nf)
 }
 
 /**
- * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
+ * nfsd_file_put_local - put nfsd_file reference and release nfsd_net ref
  * @pnf: nfsd_file of which to put the reference
  *
- * First save the associated net to return to caller, then put
- * the reference of the nfsd_file.
+ * Drops both the nfsd_file reference and the associated nfsd_net
+ * reference.  The nfsd_net ref is released before the file ref so
+ * that put_net() inside nfsd_file_free() cannot drop the last net
+ * namespace reference while the caller still needs it.
  */
-struct net *
+void
 nfsd_file_put_local(struct nfsd_file __rcu **pnf)
 {
 	struct nfsd_file *nf;
-	struct net *net = NULL;
 
 	nf = unrcu_pointer(xchg(pnf, NULL));
 	if (nf) {
-		net = nf->nf_net;
+		struct net *net = nf->nf_net;
+
+		rcu_read_lock();
+		nfsd_net_put(net);
+		rcu_read_unlock();
 		nfsd_file_put(nf);
 	}
-	return net;
 }
 
 /**
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 683b6437cacc..88e397176c48 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -66,7 +66,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
+void nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index c3eb0557b3e1..e3295bae75a4 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -40,8 +40,8 @@
  * avoid all the NFS overhead with reads, writes and commits.
  *
  * On successful return, returned nfsd_file will have its nf_net member
- * set. Caller (NFS client) is responsible for calling nfsd_net_put and
- * nfsd_file_put (via nfs_to_nfsd_file_put_local).
+ * set. Caller (NFS client) is responsible for calling nfsd_file_put
+ * (via nfs_to_nfsd_file_put_local), which also releases the nfsd_net ref.
  */
 static struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 3d91043254e6..7267a69092d1 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -62,7 +62,7 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						struct nfsd_file __rcu **pnf,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
+	void (*nfsd_file_put_local)(struct nfsd_file __rcu **);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
 					u32 *, u32 *, u32 *);
@@ -96,12 +96,7 @@ static inline void nfs_to_nfsd_file_put_local(struct nfsd_file __rcu **localio)
 	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
 	 * does by blocking the nfs_uuid from being finally put.
 	 */
-	struct net *net;
-
-	net = nfs_to->nfsd_file_put_local(localio);
-
-	if (net)
-		nfs_to_nfsd_net_put(net);
+	nfs_to->nfsd_file_put_local(localio);
 }
 
 #else   /* CONFIG_NFS_LOCALIO */

-- 
2.54.0


