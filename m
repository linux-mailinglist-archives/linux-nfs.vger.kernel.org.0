Return-Path: <linux-nfs+bounces-18799-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJpICS1ShmnQLwQAu9opvQ
	(envelope-from <linux-nfs+bounces-18799-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 21:42:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729461032FF
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5856E303AAA7
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3930F55F;
	Fri,  6 Feb 2026 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="F6TjauNH";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="LXfdjBI5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4B2EC0A7;
	Fri,  6 Feb 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410515; cv=none; b=AU3CPNYJnae74U2ypgE5YUhH+8ZsSxAJOy7tIFm9QVFhSA7wDAPUs9G7hIvyTmM8X+SBFIIi2phoZ9vWyTrfRy8mCI+K0Yc6ViLhck1WKR11f52z1e35L7jHD1Ukl0TjLU/9E+sP6uWcgtRdLtpYajpCxfh1rNBF2QPf+zPjP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410515; c=relaxed/simple;
	bh=mtIS6L7p5weFzGrtJCr2iaB11dBNt2cH07r6/GTGfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6pIq4him+oG1V6zaHBI+MyGMLRfSiveyrBQCNnuLeUs6BTX74K/ehiGKMcU0kbJecgQIqxxS/1xmrxLfFff7tkuxVGJl2Vktsmepy4/ciJnuEuW9Bc53DY9gyzDRsU6HqQsDhDewUtOEwOjV/9Ahx+eJWO7Yv5gMf9cs4AuvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=F6TjauNH; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=LXfdjBI5; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770410506; bh=WwAnzenkq1Xn7RsL/ac0kPI
	OggL6T09Nc3LDc7PsTmM=; b=F6TjauNHBoJdFIzFzdVSDaqM4p64bZIiEik3ZdtjYUx4tPndRZ
	5SQYcOxGYO4n2sffH0AMdjkMyR5P5qK22cNsGKpzI1MeVZxlkaycZRijPRrQMFsUP1yMV8cEBVV
	dM9RH05MlUBEnG1Cic8H/Enkq14aCpIfgsW57S0tvHkd4n0QbfG2dL4FcWjyObwE5chGfutqcHU
	0jdZ/C2zg3ujoN9+6MBBG5YRWPti3nV9FkHpOdACJM0hTC07kblwCBcP4zaiXysMMLRdZl1D/AD
	VBAT9BiMRtQTrmVZpdQP+oUet5oitvLWA7YzQHEOKUO1yyoFW339Y5V1F7880xg8r9A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770410506; bh=WwAnzenkq1Xn7RsL/ac0kPI
	OggL6T09Nc3LDc7PsTmM=; b=LXfdjBI5DUaW0Nn5AQNI0OEYjQY6oV0HvFlPDv55L9QLtKcGk7
	RT9W6RBZ6MWwJFhFveNONZAe36rH/D1/cDDQ==;
From: Daniel Hodges <git@danielhodges.dev>
To: chuck.lever@oracle.com,
	anna@kernel.org,
	trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Daniel Hodges <git@danielhodges.dev>,
	stable@vger.kernel.org
Subject: [PATCH] SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path
Date: Fri,  6 Feb 2026 15:41:46 -0500
Message-ID: <20260206204146.21093-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18799-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,danielhodges.dev:email,danielhodges.dev:dkim,danielhodges.dev:mid]
X-Rspamd-Queue-Id: 729461032FF
X-Rspamd-Action: no action

Commit 5940d1cf9f42 ("SUNRPC: Rebalance a kref in auth_gss.c") added
a kref_get(&gss_auth->kref) call to balance the gss_put_auth() done
in gss_release_msg(), but forgot to add a corresponding kref_put()
on the error path when kstrdup_const() fails.

If service_name is non-NULL and kstrdup_const() fails, the function
jumps to err_put_pipe_version which calls put_pipe_version() and
kfree(gss_msg), but never releases the gss_auth reference. This leads
to a kref leak where the gss_auth structure is never freed.

Add a forward declaration for gss_free_callback() and call kref_put()
in the err_put_pipe_version error path to properly release the
reference taken earlier.

Fixes: 5940d1cf9f42 ("SUNRPC: Rebalance a kref in auth_gss.c")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 net/sunrpc/auth_gss/auth_gss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5c095cb8cb20..bb3c3db2713b 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -39,6 +39,8 @@ static const struct rpc_authops authgss_ops;
 static const struct rpc_credops gss_credops;
 static const struct rpc_credops gss_nullops;
 
+static void gss_free_callback(struct kref *kref);
+
 #define GSS_RETRY_EXPIRED 5
 static unsigned int gss_expired_cred_retry_delay = GSS_RETRY_EXPIRED;
 
@@ -551,6 +553,7 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 	}
 	return gss_msg;
 err_put_pipe_version:
+	kref_put(&gss_auth->kref, gss_free_callback);
 	put_pipe_version(gss_auth->net);
 err_free_msg:
 	kfree(gss_msg);
-- 
2.52.0


