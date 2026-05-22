Return-Path: <linux-nfs+bounces-21782-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P58HVhNEGoJWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21782-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:34:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B845B4161
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C273007649
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C87E38228F;
	Fri, 22 May 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeXvnBTy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4B381B08;
	Fri, 22 May 2026 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452952; cv=none; b=WbWIAa0ulw6XkX5Y6QOMnTvZIWHpAgdk3h5Xdx7y8ztlzZ+lBnvqUKYsJPym5JoPGJOYLTGL46wxBuVOA97Anw9Q/mN7clplPFezxkoQ5oKpguPOcCDKw21ujipgxW8oZHroFV+3mjTqbql+c0yeZYK7jkO8tIQBDviY51HtovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452952; c=relaxed/simple;
	bh=ZKSdExH//yHPrO+bh/Uj+4YIl81jFCLLy6kU97jewL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSaStG4oN634r2pdYeNowX3N5EM4vfwbcxMQxwCf7iM5L9oAaLDpLfNPelTcnad6MjgvispBDC4q944A1hQW8CivLfz9MCBmyphHxbJjwe470r1FhCCVOq53BdrsUKzUcmH96i4W31D1Wrsj9/lWPCY2H9RFq/Y0APPvrRRdGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeXvnBTy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EA1F00A3D;
	Fri, 22 May 2026 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452951;
	bh=tS3ewl/RblzPq0s0br2Ku7A8Mpy7aLrtToStoyvDFrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TeXvnBTyL7iuOWL1a24Lnor9X4PSVyYyHfyxHwhqqIJ3p2phOwMA1/YNuU9NgA4a2
	 ChjmuL1d7jAhYAc+Lf2IbZNC97HiBONKf8fKHW5ZCxbK+yhvsohbI/OthP3dbP5esU
	 ehLV+CpqnT3zjbKCsQ0r2e8NivyZe0+X9zIOCiJeTp8uZJrkmI5NwxCTM64SNvLkko
	 rdgimQaznKCZg1cEeAfgHYHZylYCsVbzsuoI7QNYNZ8C8JOIcxflWPgQV4kihJ00H3
	 GoRdRWqpj5dnQ2GiBS3sHLZX4h8EvRrqdCJqcRORXs+2//G2zqczswVG7tRVIkTkGu
	 5NVcyPBlasPbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:50 -0400
Subject: [PATCH v4 01/21] nfsd: check fl_lmops in nfsd_breaker_owns_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-1-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZKSdExH//yHPrO+bh/Uj+4YIl81jFCLLy6kU97jewL8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwMipJw1fKeK44+JEQe/XHs1jmU6NTMFXayM
 voy5E3b5hmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDAAKCRAADmhBGVaC
 FRx6D/4qhiAGbJOghjEaf/yFl33GPCMVkPQITfukTq0A+7eGld+61pHMwoISCt0xI4TBb+VJiAp
 +nv4W8CZ62c2Yy2WTkeqxg7u5EfXY1cjXYIJab9vEKwMGYsw3zS9k00Jn8Z7CmJwuyoNyy9Osdd
 sMKKIJFWtXC+tWWRJVK0hMUuLNjpZYDIFSNQa5OSQnR3q/CuTF0RtPJ4r0a9dCAVKsAy45v1WJ4
 tgDv+gvDhnvPkKG0xcP83ooxbwp83x9SRRSUBQ8I8k8JlbktXkBK54AvTodA8UsVA4Br0pBsZcx
 aztG5JUTvwPmi8JWyWMt4KIy1+YNm9kc42DPo/uEVYmmB0zCiYhhrkeSuF+4knVykgSO6t4IP03
 4f3ya1RG4phSvZxDT+DvFA6BrNoYWLDyE98knIXSSaDvG1RY6y3ACwSz1mYa6pbiyWfpTYJ5r2+
 qLqLaoih2LQer/0uQn21CcgjX699dcmHDewLc6tJ6AqtI5vqX18sRfVAflpU1NVlcHtJ3q7xhSz
 NUPeiYyzYO/W+kShhTllUYxbxYr5eAWiAqIXwvC9nN46RLfk5cDDApgRkizDvWiMSEBJwwV2t5z
 DRp/N5MPpIsq0vvZxZZ9Aa2vufYTFMURLBumRXKsvgc8+fW8rGjCyLLoK1jC+7nULR4hRBzxAx/
 QnT874ZhaaJBosQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21782-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21B845B4161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Any lease created by nfsd will have its fl_lmops set to
nfsd_lease_mng_ops. Do a quick check for that first when testing whether
the lease breaker owns the lease.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2cf021b202a6..67e163ee13a2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -91,6 +91,8 @@ static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_stat
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
 
+static const struct lease_manager_operations nfsd_lease_mng_ops;
+
 /* Locking: */
 
 enum nfsd4_st_mutex_lock_subclass {
@@ -5663,6 +5665,10 @@ static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	/* Only nfsd leases */
+	if (fl->fl_lmops != &nfsd_lease_mng_ops)
+		return false;
+
 	rqst = nfsd_current_rqst();
 	if (!nfsd_v4client(rqst))
 		return false;

-- 
2.54.0


