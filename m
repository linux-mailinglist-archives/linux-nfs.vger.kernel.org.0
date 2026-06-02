Return-Path: <linux-nfs+bounces-22209-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kiynES0GH2oudgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22209-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE86303BF
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ovR+DRSc;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22209-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22209-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A84193025934
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A936827E;
	Tue,  2 Jun 2026 16:23:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847536828D;
	Tue,  2 Jun 2026 16:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417416; cv=none; b=Rh/5PFDA/ywedLaFRku9ik0/te/7sEyTtVhhNFMWNgMrte/9SQPhE4otP3WSSrT6L1WkLmmeq+rPFHozO71WgCnmYCKGxr0QIfoOyybrIAVPAdRkv7fnv1UnH4T5HwYhcdnpfU/t4Vi84Ib9feXJustsJ+5fYDh1mdLL31y9lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417416; c=relaxed/simple;
	bh=RNvYl4X9h5aArUfk9p/ctbid7hq3/VtVP+wffu34sME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfItsq1qLyEFW9Zi742FxxVw4aYXM0R9eZ0zGTzgqMtwsPOaH0n5X12dWVriVlpuw+YpvgKAdP5ndCnFJmhNQ97+x/EkQdGvtq6S4/rXrxLBc/WH/YNTnUITTfvFEF2Tv0XV6D2ML56MuZdoFsr/joOpLlE5gLKX7rvEG7ecj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovR+DRSc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA131F00898;
	Tue,  2 Jun 2026 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417412;
	bh=jO/o2PhsFYiMTNYvyXUl1epDYlP6z+nKUYpcM7iOoL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ovR+DRScbD9G9x/gHC1An4K83HnEXmo2WG6wNTfldbVu0WfFSDGXBRHsqUSX40Lng
	 W78kxVq3ef7UQvErI9q7q70OsSnyW3XrH362qOU9jcb/DhagNu2e848prTexXDVEr2
	 UcQXBDHdBU77Xqe8azXpNw3eAsJX3b4/TNWXr0tA8RhzjE5GiX0oND1Wx4Vz6Q1QLH
	 xP2aPhltiB88EcEppH8n6Pp07nbOMlepmnggimg4q7xAJF1APBztli8gFvEWODJ80I
	 ouWjlWPFD4vcVY+nbzY2BsYqRNVVZbI5fKNs+xrxWl6MICOukOMs0+NyAUvuCr0l6C
	 YNeJFjC9GXc5Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:15 -0400
Subject: [PATCH v2 3/9] nfs/localio: fix ref leak on nfs_uuid_add_file
 failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-3-e4ea62e3cd5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SymQrXheMIcvvEyabGknNPPPReS8lNip1GXZKx5s68g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN8/ppH6UYhAfQxpRuM39wzZRACc6ota6s3p
 ZrhR0LFJ++JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfAAKCRAADmhBGVaC
 FZdoD/9swTNdkPgL1db5t9qt+HZNU/4YFPe5FdTcK9Iqlpb6Pbc2WEqYPv0sUU/45KWKi4Uciaj
 LS9BAoJN8csJaTE41hmjnYxI3wlcyKseBO7g7v3WQTTmegn5uTXwckVXdcwy1ZbSkDgIW7mKZow
 UzqEsbfwZ6cCqJp9d9nbdtt+SMifktVjJ9CeLJAHELf1NGXQyOAmuwcMI/mRsZLIOkLpP6H9Mb1
 q1zNzNc7qWlDnBdiVTOgFGuHCwz5RcyrTYXnjB4uN5TwaBKmhVYCB1N8kqT6OSGodccMqaErHEn
 PNupLFJ5MXlbyn9WfNm3oZmLoTNJHDNJ+MtiGIcbFju6a2OEaTR1V8/9MJxMxh5rxTKnaOY5NVZ
 87TTNTTBpXXPk6BdRcEUrQwtk1AUsAFRwBo3TlyM5G/ANpNuVpPvimHbi4NNHy0jggB0K/eTTDA
 rjV0WWzN6aQTR03UGJ/xjfYUtJcnxF8TllPUiqFBR6XNP1r+rKQ7x89Rhg5B0H7X/RMQBZ8lHz2
 Z706a5Y7UwHZLBbfc5H5Aym1kqIbq2ZfihURUS/T1s5s6sY5kd4jqUY0W4LPGiKXBC2gQCZzHAu
 E18vhOsGLNH6ppdGO4V0oFNoSdihz6dUXbI3reCGTofGERmE6L3F2qe9u9HYTyrIuDzSpIwE98l
 v2iTEWCuL9ljAXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22209-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54CE86303BF

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


