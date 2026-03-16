Return-Path: <linux-nfs+bounces-20201-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IqHOA0huGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20201-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0B29C476
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 226A230347AB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8C3A168C;
	Mon, 16 Mar 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX5DIuN0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D73A0E93
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674215; cv=none; b=bWU+SsFmWqtbiNYtFnm3Xh+/PgcWDA5k+YhcM4mMjfNiUrsvk4AmzBNyaU2vte7pQPiA8MmLLgQIx51sld59iipMVvDsnWen2Kx0TY5vn6oIo6ZhacywV625MZYCqA+wELdwpt2jhb8o+8SUfnElkTijgOOoulOd4h4NP2c9FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674215; c=relaxed/simple;
	bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXuopf9CBOxJeWlSvzrEwHEmafLbv+Dl4Ju5m+YDlEAAH0dbhfPbOAuxwF2gftTS3kXzWASI/AtqAT9fYm9ZeArMO8v9n0pR/Vr7f07vOkSvu3l3SWwdEZinBUXPdaV5Hx71xBcCAgUdCuglb8mYoEk29laa764kVs4BGLp7Wms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX5DIuN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6382BC2BC87;
	Mon, 16 Mar 2026 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674215;
	bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eX5DIuN0l3aNYqOazFerfHWCcNHLTcoTPHZ8SjxF0l/zKkehyqGuMTdFEJd3voEJL
	 v1sSSAglranVQf+G2wXA8w5Qn5i1NCx595Q3JEF2sBVkO3lyJX+OvxkCXoE1P4lc7o
	 P8IgLifaLidBQSm0S4q9SHBeGDNrDKD6jXDclXAfUcy0UH8upFYkWk0UV0ga4hFotF
	 l96IEG+D2eD753hi7fnTWi3HbGwsWid7wtEThMzOO5laJvqvXNPJ7SAnfKLBe5UDNE
	 wMnY0wIugQab6qr6jnRiH9vzlRMOiaQ81jnLnmDT4q2nfuhOhJGErcnPykxrDaJDU7
	 SZYxXRKjEX32g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:40 -0400
Subject: [PATCH nfs-utils 02/17] support/export: remove unnecessary static
 variables in nfsd_fh expkey lookup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-2-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7gOtoktN+Q2yjwmmKufbrKg9+kkjc2PTB2c
 Na0XKvmSRaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4AAKCRAADmhBGVaC
 FR5BEADDNgkWG5hpUVejKZSCsD5fTs/HPZ10h6iONgL7/LdQit5tXDdFs6RvRwsEy7M/P/t4BsH
 0J4Ev1XDekxQLm/eoEfrkQVlstaqEXW+HPtt8SLzzmv6/ohhhgqc8IsoY2zEmLGMhhUVR2985Yl
 DiUfReja8htEAU2FYjW/OfuPFCFaxk36l8ut0iPdy3glYKMBI/dRslKbpf4REdR8Msxq1bB5x06
 GYDENm9db2gNa6ex3fjRS2GbDWToe0g4wX47arx1NMmb0ViZjjoJ+KK6ckC7Ez04X7l45ws9KSs
 ASYX0bMYo707CDtYo6G1gIPtwDZOnQsXeWkSDYBDEfYgN7ukRVTt/ydPsGXoD8EYqYIsNGloS1H
 EsFidceLQpv9fgXgcIZHmaa9rACKqc36TQzeHcKo28l+dhCWG4Gp26x7Rvp3uC3OTLJhvN6YJr1
 jQbrxpwZwWG2JTM0ZUDEbFMdL1sE1VcoiGtYNxcOQwuFrGBmRtiewNWU68/bP+QVRG+lFb4hbgN
 zWdJ3bI1DfZiLjMyMxvWEDk2eBzzjNj802zY4qSxnB+cwJEwHHiZK83AtHd2kbxlp4wjHuPjQA/
 auMEBP5cbFPKmRMQypzvSx9/vkjDacDbRA1cc8AJxu75G+EKK05hqoGhNkBeZsF78g3awLpvBoi
 COnvwEV106eDtsg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20201-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7E0B29C476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The prev and mnt variables in the CROSSMOUNT submount iteration loop
only need to persist across iterations of the inner for loop, not
across calls to the function. Convert them from static to local
variables scoped to the outer for loop.
---
 support/export/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6859a55b7ae5c132255b756052c6ddd1734173f0..c052455889481f04631e4ef0e16cd48bc6c11964 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -810,7 +810,10 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
 
 	/* Now determine export point for this fsid/domain */
 	for (i=0 ; i < MCL_MAXTYPES; i++) {
+		nfs_export *prev = NULL;
 		nfs_export *next_exp;
+		void *mnt = NULL;
+
 		for (exp = exportlist[i].p_head; exp; exp = next_exp) {
 			char *path;
 
@@ -820,9 +823,6 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
 			}
 
 			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT) {
-				static nfs_export *prev = NULL;
-				static void *mnt = NULL;
-				
 				if (prev == exp) {
 					/* try a submount */
 					path = next_mnt(&mnt, exp->m_export.e_path);

-- 
2.53.0


