Return-Path: <linux-nfs+bounces-19463-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLE3Bf6ho2k3IQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19463-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 03:18:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713151CD6B9
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 03:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF92D3447D36
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2D309F18;
	Sun,  1 Mar 2026 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJO8RZIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1F309EE9;
	Sun,  1 Mar 2026 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329942; cv=none; b=k4PR+HniJpP0JWn/DP07mO4Hqzulh3Z90Z6AWQ3nDuSBWEEldJ53BXaikRzXF4BNOcvJiYbt2fu0VMqW1u926+dWIUnpFd6wwnBoCRdI/y4EF/yFNDjUjiPceYcFKRfKoFjwqZo8I6N+ptn5R2EJp3C+a1SOite8SPaYywmfTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329942; c=relaxed/simple;
	bh=tL9qk+qOPUMoiwsaixGs97ph6zMCLzRS4UD8NgDGiFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sV3809HNFUvuNlGPVjwklokA9Wu7/juRr4VLS/rbfblihCik8Scrq/oHyoFtPbORnJgfi8/2Hg6jiQQA9evp3ptQBVrTIOWbo5tv7SVKhRy9oDliF7f3q2K+wZpe8MSGiLRMjjE2mAnK4JfS/a7OhjZhmdRO9ETl8JsAc5rXxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJO8RZIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7135C19421;
	Sun,  1 Mar 2026 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329942;
	bh=tL9qk+qOPUMoiwsaixGs97ph6zMCLzRS4UD8NgDGiFY=;
	h=From:To:Cc:Subject:Date:From;
	b=rJO8RZIwaWxbjv4dr65idPt66V1LuYgWU82pMYuAgsOdCzQUOnSfLzygDt8DDb6WW
	 LoN7jsBJaKcrEqtzmP9uVhJYeqYHDMulQhIakPyZEO59v6hc3+8cTd56kF7Y4TJXSn
	 a5UvDhY2diVZ2S+bWgEIpJA/3Qxmto8jnCpJ9ftU0tiZGYeyYln0OCXOLCn1oiGm6z
	 nLQHs3DBHqzJY6gJVN8cQiqwGuVJOehCWbfEO7u52P8utps7FthZ/tpKD84W/D6m2S
	 xNgC1NcPrGnwenp+XhN5R2Iv/bI5neE1JmcBbW6seKGI84aTqKY2Pk3YMtiY5CKpZg
	 ffZIHE03BGyWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ailiop@suse.com
Cc: NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: FAILED: Patch "nfsd: fix return error code for nfsd_map_name_to_[ug]id" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:20 -0500
Message-ID: <20260301015220.1718813-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19463-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 713151CD6B9
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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





