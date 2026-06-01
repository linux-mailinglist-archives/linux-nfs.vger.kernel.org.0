Return-Path: <linux-nfs+bounces-22175-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PG8OUPDHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22175-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:37:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAA62353A
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8583092856
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410E3E0245;
	Mon,  1 Jun 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k621h1VR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF63E0224;
	Mon,  1 Jun 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335094; cv=none; b=ZwrnNTksl5WOlO3diNQ2gZkJkMQ2NF8rajRgXiDKm4uZEJkJGHH6oLw88FJHu0vLhwwIntWtvhmXVcrdFgj9K12lJuBAUx1Y5Cp9Tlqs7P01hGhkgbwZ9Ur6Cxh7B099o7yL9LjmHLHPdh7Ah5RWS98uTu845/IUjeX2ZNwZPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335094; c=relaxed/simple;
	bh=RNvYl4X9h5aArUfk9p/ctbid7hq3/VtVP+wffu34sME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaLPSNt59lr1snTsIEs86pHgKT4rCh18QRgWV1pjqNKpgmJKizA3p93KgYo6GJDvZd8WP5eagg22d+w8JoopkrLDKBW6RSSEiNlJ55dDjexhZPS91Q4ibZ5Vo2n5ja+zMY6YnekqVa+IpkCdXj8PGF67o0vkpuGenZCKyHBgpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k621h1VR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9421F00898;
	Mon,  1 Jun 2026 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335092;
	bh=jO/o2PhsFYiMTNYvyXUl1epDYlP6z+nKUYpcM7iOoL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k621h1VRbgCSrfJ1J+mt6BPm3ckz1GFqTvJrTNdRBc4rxZJnoBMYxSJWcX1dwTm7v
	 UhVCgODJh02uq9E6Wn+wY/X5Yp9hYiMfYvnCvvXIY2y360Qhu8KQ0eiYLOr/6r2U+N
	 cnPXDMC27o/dd4asSW+D2W71nl7evOMHSHd0h0fKCNdnUiWq35aco/2/Dpk78nVkWH
	 ScMkSe6WY8xHtluVG3t2N5It6VCbecHn54v0z2ozRrgAWTSZNPkKYgwckCowt3XQOE
	 yNpR1ZH+IfWoxkEG3179Lcks+ElXVXQBFXC9eWQe/UQKVAJImdThX+I45wPfJfFV3S
	 6I/cA6PBW/ZAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:06 -0400
Subject: [PATCH 3/8] nfs/localio: fix ref leak on nfs_uuid_add_file failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nfsd-testing-v1-3-d0f61e536df8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SymQrXheMIcvvEyabGknNPPPReS8lNip1GXZKx5s68g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHtOiR3ydI7L7kOyRfXIyMRAhmhHOOZ2HE9K
 U8IEU6gCoCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7QAKCRAADmhBGVaC
 FSC1EACT/AyEWsBIrFwkonb+7Lyjh5NX2m1bfklS9i5ci0DC6TRZzN3CuG0RM3g3qfRAIzG0Amd
 Y6jqPPKzFyBbA5FDBT+Ule0/ShNtXZWVg8YhshusD4OTzjTiyFe70xrC1wycZlb0qg4wYxlmgnb
 u0XDWdnWvcAbzrl59IkR+DmkMd6DnZxlZSky1dvx1WH68zRpi/TL60ya4kZRM0WAo1WzhSRsZIO
 OKWPe/nj5mn/oVtSIoIVi19cmo6hAytfXXQ/n0vtJG5qs1lmZduYFIVHKxvF8vSiY0ebzsnlx3k
 teOZk2guAb+K5cnC6LLqP0V10/7cm17ZkrP8R0d4Q35lAso3kPJCrZ3biZTMk8jQUtBEWR+rNsl
 Di+fP7eq2XbHz7dlW7/5/BuniHOVLIVPZbmvggqPsqjOteXAxQF6lTcxNq+ye5tMo7nJHdcWgXT
 3A3SSlqYyVKxdp1VYiOHGgsI0rSF/t5IAv1thm2kS/9D75nnIAOTCQ/itlGAsTxtNC9K8BqgjaG
 PPHNZBihE1EbouY+g2NH/tnJMXV6mHnXyvKWT1lx7HdD6dA8oYgoH+/7vlUfqyD1mkGdcUDEqmx
 kxvj3rhhnyUAjtUAvkOq1i75CFh7eGFsam7m/XxEFYIhOafVu1+JP9YsZZS6HCyuoIZAXeXpDHo
 ZVkce6mezQDFRkw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22175-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 8CCAA62353A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

When nfs_uuid_add_file() races with nfs_uuid_put() tearing down
uuid->net, it returns -ENXIO without publishing nfl->nfs_uuid via
rcu_assign_pointer().  nfs_open_local_fh() then enters its error
branch and only releases the slot pair plus its own entry-time net
ref, while the close path is a no-op:

    nfs_close_local_fh()
      nfs_uuid = rcu_dereference(nfl->nfs_uuid);
      if (!nfs_uuid) { rcu_read_unlock(); return; }  /* always */

nfsd_open_local_fh() returns localio holding a caller-owned +1
nfsd_file reference (from nfsd_file_get() after
nfsd_file_acquire_local()) and an entry-time nfsd_net reference
(from its first nfsd_net_try_get()) embedded as nf->nf_net.  Both
are leaked on the failure path, pinning one nfsd_file (and the
underlying struct file, dentry, inode) and one nfsd_net_ref per
occurrence, which blocks nfsd_net and netns teardown.

Fix by releasing the caller-owned file ref and its net ref through
the existing helper, using a stack-local RCU pointer so the helper
can xchg it out, then returning -ENXIO so callers do not
dereference a localio whose slot has been cleared:

    struct nfsd_file __rcu *tmp = RCU_INITIALIZER(localio);

    nfs_to_nfsd_file_put_local(pnf);
    nfs_to_nfsd_file_put_local(&tmp);
    localio = ERR_PTR(-ENXIO);

The trailing nfs_to_nfsd_net_put(net) continues to release the
outer net ref, so all three nfsd_net_try_get() increments are
balanced on the error branch.

Fixes: fdd015de7679 ("NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfs_common/nfslocalio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index dd715cdb6c04..a3c1c5c2764a 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -292,8 +292,20 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt, cred,
 					     nfs_fh, pnf, fmode);
 	if (!IS_ERR(localio) && nfs_uuid_add_file(uuid, nfl) < 0) {
-		/* Delete the cached file when racing with nfs_uuid_put() */
+		/*
+		 * Delete the cached file when racing with nfs_uuid_put().
+		 * Since nfl->nfs_uuid was never published via
+		 * rcu_assign_pointer(), nfs_close_local_fh() will early-return
+		 * and cannot clean up after us.  Drop the slot pair, then drop
+		 * the caller-owned nfsd_file ref (+1) and the entry-time
+		 * nfsd_net ref carried via nf->nf_net, and return -ENXIO so
+		 * the caller never dereferences the now-cleared localio.
+		 */
+		struct nfsd_file __rcu *tmp = RCU_INITIALIZER(localio);
+
 		nfs_to_nfsd_file_put_local(pnf);
+		nfs_to_nfsd_file_put_local(&tmp);
+		localio = ERR_PTR(-ENXIO);
 	}
 	nfs_to_nfsd_net_put(net);
 

-- 
2.54.0


