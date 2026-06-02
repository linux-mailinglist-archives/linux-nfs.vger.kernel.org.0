Return-Path: <linux-nfs+bounces-22214-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HSdJN6YEH2p8dQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22214-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:28:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A5630316
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G0bzexoV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22214-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22214-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC07B30BFECE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8B372684;
	Tue,  2 Jun 2026 16:23:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB4371CF5;
	Tue,  2 Jun 2026 16:23:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417422; cv=none; b=LK0JpESQS5MzK+K4EbCjmngaaoxPpK9GlJtNUdWzjF2IjHZlbTa5+URY8EXFedqM++DNkaHEnUnAj7lDyE5IIUMSgalv/jl6N7HG6i9gx+Ek9DlGVfpbPNaTZSzbIRITwK5w7YrEiuNCvZ4V7BWwQMsiegQhsaCFmrevt0Ahrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417422; c=relaxed/simple;
	bh=2jtYqYJliW0HX+tQbmsi0nWIHbXBjKvAtlZaq9fORZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPKtushgI1/txE1f/USljubWH+o7W0M9JarPOeP4hNpYtxQY+PzND4FBHex0Q1A+NHo0d5elZNm68bjn3gMFauptFDJnYqkFFGJ7Ft4I7gQ1AFMQMSQMP/s31CSrrN/SiCncfp/nTx4gxAMBDr9ATVufObJr5nBFa/yCEXi3zHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0bzexoV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A001F00899;
	Tue,  2 Jun 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417420;
	bh=doETAbbXlih2TgtqnyiZ2/x7ee9FFTG5PiGNE64Nszw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G0bzexoViK1Qs3oxLWv+sxBY+Hg3elL965qKaPhJMvlT0qxgVrPV10jyIPTqGBTZg
	 tUTLv4xQYEOQBgVgOninD98YROqcJynk85UutzTR7GX+KOvyl3Aymk/JAI2Tgph3Hn
	 d9pVQ6ieGxXZB+tS3GQBrZbA8khJmXZQLA6dNsKJwEbhy0pjuolavOLLUQ+ia2/XfV
	 XsAxA+dfCiZTwOmoMHBlFFI4Ga8NvIjBG7fEvAxe2Ypo/CGZAbjFn3ezj3svdO3nyf
	 rZ08/oMjTAsKHInY8bhgqF8iRg69aQy2+sPb4b1SYiMNYmopRgu/9nDwTaYJ4WDEC2
	 Eg69AoyofaGXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:20 -0400
Subject: [PATCH v2 8/9] nfsd: hold net namespace reference for
 delayed-dispose nfsd_files
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-8-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6658; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2jtYqYJliW0HX+tQbmsi0nWIHbXBjKvAtlZaq9fORZw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN9/l7mYJsrhcmgP199d6d35qwkABOIEg4K3
 HEL0EW2HvyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfQAKCRAADmhBGVaC
 FfuAEADAW8yzUikfxcgRlZfi30/bjzcoJOo87KSD5Yscic+xWi6XVoA6WGJyyzTKULE3f5m8cq6
 wEN9al4OU5w9pmDRxVCq5V1I+DBEwedwo/KqCtXAjeK096ZWvuduTD6XFheh/qFzv7ddrLEVrqi
 /XTRACs/otAgHzSo7Kgbu8sFr3RpcbxJw2ZpFqv2P4cUY9qCMsXaJSmIJPe6R1JWLZAgVsbXQ1b
 SkLLbzVNgBRcKrfFTbnxg8Tt33u1mV6tsArZzzPdRt0w6XYgAaDC3R0Vm4/o3mADp5hmXoXRIk9
 Jrtim3axqOrUAeXxD7hf1eNB2+DJfd9IUs3wjMDn7W4/JGbhUWLOcagBNebWeaoBjRLMBOjs2d+
 vOURrYOdhAjGZACX4vVfEeWsnuvjQLdarzD4AAV2a6nlEkdCgah007MLTktYrg73/cRyaJqF2g9
 Vzj/qM09U9y3ZNWZylXelQMqbhZrm4BHrEH9kZDP/z84MalXltm8/pyorryXsUAQ4s5awuT9Gxc
 MHszBgeVvQJrD5aYU2EjXEdpPANOcO7GtvFqWu9HbXFGPamku93Va3131FGlpLPtky7Vis4C9ej
 svYpBTAjyl3Db7W6NB9SfqxALLDjzWCbAN9JOaUJ6tLNo+MzDwWVH+QMq6NBUyo9EUnT7uYuF/s
 +yGqkcOUzt+zeEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22214-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 567A5630316

Take a net-namespace reference in nfsd_file_dispose_list_delayed()
(get_net) and release it in nfsd_file_free() (put_net), so that
nf_net is always valid for files that the GC or shrinker has isolated
from the hash table and LRU -- which __nfsd_file_cache_purge() cannot
see.

Without this, nf_net can dangle for in-flight files whose net namespace
is torn down concurrently, causing a use-after-free when
nfsd_file_dispose_list_delayed() calls net_generic(nf->nf_net, ...).

Only files entering the delayed-dispose path need the net reference;
files freed synchronously (non-GC stateful opens, purge, direct put)
are always freed while the net namespace is still alive, so they skip
get_net()/put_net() entirely.  A new NFSD_FILE_NET_HELD flag tracks
whether a given nfsd_file holds a net reference.

Because nfsd_file_free() may now call put_net(nf->nf_net), the old
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
 fs/nfsd/filecache.c        | 34 ++++++++++++++++++++++++++--------
 fs/nfsd/filecache.h        |  3 ++-
 fs/nfsd/localio.c          |  4 ++--
 include/linux/nfslocalio.h |  9 ++-------
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 03f01a0beced..957fe57be063 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -295,6 +295,9 @@ nfsd_file_free(struct nfsd_file *nf)
 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
 		return;
 
+	if (test_bit(NFSD_FILE_NET_HELD, &nf->nf_flags))
+		put_net(nf->nf_net);
+
 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
 }
 
@@ -375,24 +378,28 @@ nfsd_file_put(struct nfsd_file *nf)
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
@@ -433,9 +440,20 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
-		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+		struct nfsd_net *nn;
 		struct svc_serv *serv;
 
+		/*
+		 * Pin the net namespace so nf_net stays valid while the
+		 * file sits on the per-net dispose list.  Callers (the GC
+		 * worker, shrinker, and fsnotify callbacks) always run
+		 * before nfsd_net_exit(), so nf_net is still live here.
+		 * The matching put_net() is in nfsd_file_free().
+		 */
+		get_net(nf->nf_net);
+		set_bit(NFSD_FILE_NET_HELD, &nf->nf_flags);
+
+		nn = net_generic(nf->nf_net, nfsd_net_id);
 		spin_lock(&nn->fcache_dispose_lock);
 		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
 		spin_unlock(&nn->fcache_dispose_lock);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 683b6437cacc..7ae3c0ea0a2a 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -45,6 +45,7 @@ struct nfsd_file {
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
 #define NFSD_FILE_RECENT	(4)
+#define NFSD_FILE_NET_HELD	(5)
 	unsigned long		nf_flags;
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
@@ -66,7 +67,7 @@ void nfsd_file_cache_shutdown(void);
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


