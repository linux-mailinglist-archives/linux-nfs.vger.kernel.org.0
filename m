Return-Path: <linux-nfs+bounces-23014-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Es2N6wES2rgKwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23014-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:28:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973D70BE9D
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:28:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SeoaWfRz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23014-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23014-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBB3302880D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617332B9A1;
	Mon,  6 Jul 2026 01:26:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8503321C2
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 01:26:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301163; cv=none; b=jQtGQANM96P5NEpZsMIrrVSmngh/dKhgi3FGsOtb2dED6cYee7COuhNdBuJgA/v/Mwk+HpQ0emeChMH8IVucDYqBx51ippv5OYNXM2sUDHs5AYAa07sjshJTb7wPYQeNePEpNYfFAZtXkZ6Pv+AgqrFVmONIG7Iy5tM95PzcpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301163; c=relaxed/simple;
	bh=dez2iymdS3qHhEznMR8RNLxRW8bZcGfKJKFQiwqAmkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzGNo2TjiqhCFlolcHVSNBMHt+r6AfELNqAaF/IMS2tGibqtuRIFeCBKYrC9bSBzRSC1zBm6h5ep9KxhH3aZ9R78kxxM5Uwnsy/TTNhUbx3wcDCNWd07t5cdq1eQl+6IsknvTviU/UgKRQXH9H+2tVbnZ9N8/uxOEDC5M8ge71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeoaWfRz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913421F00AC4;
	Mon,  6 Jul 2026 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301162;
	bh=OhBTTNooxEPrhjAOqhkbKvi/ucl/ZcxW0tNKh+0EM0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SeoaWfRzlv9rwCybTuTeNkkcSGkdhI/gfIOtR1LHZSVHJZT+5GzIxEBohhcrWlXsI
	 mglY3xBaJwLr1f2qjiBgmHU1t8qi1WG4lBHCKdtKKxmigSIXAEyLaIkLvgYhxR82J6
	 wPE1DhmVuC3xqHoEFYjyiZpwPKMRSc8hxTGrA8/WXdgGfcAtZx56U4lrUR0DnzoPSE
	 h8fFrj9AusyeA8bGRcox9mXF5CAy9eHD2+THNd/xlxQuOeC89UZqNH3i7e5MLVvwdv
	 7IXTHg2rgJHt33QtpoST6qvXLR+gqxiRWqA8owmP2Y0khhpwdgQu8t7JSZOfFFoASJ
	 hGdIEjPFx2E0Q==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 05 Jul 2026 21:25:40 -0400
Subject: [PATCH v2 4/6] NFSD: Prevent client use-after-free during export
 state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-cel-v2-4-d88c3b68e8bc@kernel.org>
References: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
In-Reply-To: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=cel@kernel.org;
 h=from:subject:message-id; bh=dez2iymdS3qHhEznMR8RNLxRW8bZcGfKJKFQiwqAmkA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqSwQmJSjsokFg2JtX8j8xbyscdgrptMOmPTaQW
 7RQ1/UTYGKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaksEJgAKCRAzarMzb2Z/
 l5b1D/9y2CvvXuRYxSO+WFFCWh30d51HWDotKJETFGisxhvTtMegTLdN4Z5JStGBGbzpO5IwppC
 2SUi2ORpMsom5J1yFaSHJfhRVfku/jLcBhyq8cq9ZvDCr/80ybR7AydQo4kmgsC00r/Qdqd5Rng
 6j0hkfDg79yp6dL9XQv9LVKgW1OuqMWyqG+vJi7sk5q7185TOR3VEp/6C8uAfSDs8NB0ufWBbe1
 pDraYBwov8wB8O6zmofugMI1fKxL8mtKOPIkQ2ZPWorlZXiBJkaHzlAqPk48F1YxJCterPSFW88
 DghzyMTwWhTC/7E8cvRVIkYIprD5mIv9NccxYpG6nKu/yCEARpeuoZuFJxC9bFKPlCJ8j+WeLD9
 hnCIe24apUYzCm2PDAM+cy5RMQ6H/urE6iZ7xCsOXCBVKIsIVAyKTld/toumRUkNpePLm8n+tH3
 m/rG7/FX/CmY3z8VUGiiI1Fdf1lo7rPPgpCBtljEkSvRw0wGzBVnqXXSFDxqJONmivGiwlNHww4
 Xjz6FffRw0i5a/Wd/jhReRUTVQEqjw3lcm4tjmxUfZBjvC6aYp+eihTyRwaZbn96huwKcBw6sYm
 Pk/ULbsCAysKtyhhqF6bjDpMo0JCmz6WwJvndP88IK3lp3skDDeA4g3Q5mVj5JIGkpZ97njXLgQ
 +VNJNeLNf3EBRTw==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23014-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3973D70BE9D

nfsd4_revoke_export_states() has the same use-after-free as
nfsd4_revoke_states(): it drops nn->client_lock across
revoke_one_stid() and the following read of clp->cl_minorversion, but
the stateid reference it holds does not pin the client.  A teardown
racing the dropped lock can free the client while revoke_one_stid()
still dereferences it.

exportfs -u drives this path through NFSD_CMD_UNLOCK_EXPORT, so an
administrator removing an export can race a client expiry.

Skip a client that is already expiring and otherwise pin it with
cl_rpc_users under client_lock before dropping the lock, matching
nfsd4_revoke_states().

Fixes: 2eac189bb059 ("NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cdb62b3bf718..c7db2c249441 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2055,10 +2055,14 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_export_stid(
-							clp, path,
-							sc_types);
+			struct nfs4_stid *stid;
+
+			/* Skip or pin clp as in nfsd4_revoke_states(). */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_export_stid(clp, path, sc_types);
 			if (stid) {
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
@@ -2066,6 +2070,9 @@ void nfsd4_revoke_export_states(struct nfsd_net *nn, const struct path *path)
 				if (clp->cl_minorversion == 0)
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}

-- 
2.54.0


