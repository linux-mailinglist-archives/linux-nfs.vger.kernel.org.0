Return-Path: <linux-nfs+bounces-19465-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHE7NV6fo2k3IQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19465-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 03:07:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA91CD044
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 03:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F6DB30A9041
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 02:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881C32F3C19;
	Sun,  1 Mar 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIaM0mg7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD42DF153;
	Sun,  1 Mar 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330531; cv=none; b=HLLiIallQa/0dHq+Yr57hs/mA0QuwhuQC/fAwCVwPQ357edg/rsUr/Sw9Xv0DKU3pKQthTpUdJGP3x0A3o6DW1HxLHWgn5S3iiId0sMYmAlwowKVCicyFx6Nx693HBAxzL/TOgCvc44lN5RvIXXTrljoJYzGVVSioVvHaSiAGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330531; c=relaxed/simple;
	bh=NamtEnGI/HkmjmarOx7aAI07EIBhuFENGu/CrzT+W1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsaTfU/KqiBr123Yy8RlnnjbrceiJcrGu5w070i7vl+L3JzzjStl8ctygJAtmPVRMeOI0YvyQErQKvtYMJXF+plLw24uDL0j2+k/mJIjbtC+cz+wJGc73tY5m+KCxvDdPQmowOjHzlfycbvlZgUP4JD6nWB5eAMRwvy3eu6Svl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIaM0mg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2012C19421;
	Sun,  1 Mar 2026 02:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330531;
	bh=NamtEnGI/HkmjmarOx7aAI07EIBhuFENGu/CrzT+W1o=;
	h=From:To:Cc:Subject:Date:From;
	b=vIaM0mg7Uej9gkJJPNGfxUT+Mskka2aUlbz7E0qu8Lp7Vnt0LZPYv9WY15Ukn+H/+
	 On65o/OHlik63PHDvhYgNPBPDdI17xYPZf8V8GHgT7IJ4/p7ttFLwZq1OGnNy8PqrK
	 Z+Vh8W+vw/NS4r+jF49aRpxvDrYaLpmOop1zhCZ8azZqdWzFqtoO+bODQXo/NCrASf
	 uO5stBhS2i2rlMPdDsbefi8i5n40w2sWDzFLWGw2vqFjROXW859n9JQAelYRT3qJ5r
	 i+zURuKzbsCgLEGk7XLYP0K9d9/Eqy9Z/suHrlvN+VDjCPPDzguBb7GGj6Wg87a1Bt
	 EFOHy+WMjvRKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ailiop@suse.com
Cc: NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: FAILED: Patch "nfsd: fix return error code for nfsd_map_name_to_[ug]id" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:09 -0500
Message-ID: <20260301020209.1729645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19465-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,brown.name:email,suse.com:email]
X-Rspamd-Queue-Id: 7DFA91CD044
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 404d779466646bf1461f2090ff137e99acaecf42 Mon Sep 17 00:00:00 2001
From: Anthony Iliopoulos <ailiop@suse.com>
Date: Mon, 22 Dec 2025 14:30:05 -0500
Subject: [PATCH] nfsd: fix return error code for nfsd_map_name_to_[ug]id

idmap lookups can time out while the cache is waiting for a userspace
upcall reply. In that case cache_check() returns -ETIMEDOUT to callers.

The nfsd_map_name_to_[ug]id functions currently proceed with attempting
to map the id to a kuid despite a potentially temporary failure to
perform the idmap lookup. This results in the code returning the error
NFSERR_BADOWNER which can cause client operations to return to userspace
with failure.

Fix this by returning the failure status before attempting kuid mapping.

This will return NFSERR_JUKEBOX on idmap lookup timeout so that clients
can retry the operation instead of aborting it.

Fixes: 65e10f6d0ab0 ("nfsd: Convert idmap to use kuids and kgids")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4idmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index b5b3d45979c9b..c319c31b0f647 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -672,6 +672,8 @@ __be32 nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_USER, name, namelen, &id);
+	if (status)
+		return status;
 	*uid = make_kuid(nfsd_user_namespace(rqstp), id);
 	if (!uid_valid(*uid))
 		status = nfserr_badowner;
@@ -707,6 +709,8 @@ __be32 nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char *name,
 		return nfserr_inval;
 
 	status = do_name_to_id(rqstp, IDMAP_TYPE_GROUP, name, namelen, &id);
+	if (status)
+		return status;
 	*gid = make_kgid(nfsd_user_namespace(rqstp), id);
 	if (!gid_valid(*gid))
 		status = nfserr_badowner;
-- 
2.51.0





