Return-Path: <linux-nfs+bounces-21982-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKxUBHHNFWoTcAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21982-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:42:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B145D9E4C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 818C73040975
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE83CAE73;
	Tue, 26 May 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR+wPEWt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13A2571B8;
	Tue, 26 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813546; cv=none; b=JYwkGrjxVzh5QCpKcZGwSa6G5sKPpxhihPClSzQWhAxwjE1p/ewi/7ct1S7GsUxKYdqV50MoQOLjEu3bcISCwRic15lDuqBucg8oFYI3VKoqPNNlwaYNOHlsOMguEVfbjhQScRiOzhSvPu5wS8Qd9xUC5zM53R1GGEV+/HgPc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813546; c=relaxed/simple;
	bh=EuhaeTvZUer9TPm4hog0MOssp4P5pZU6P3ibMtaXW2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lW0nmf+4s8j5YkTcSk8/TSxwC/c8wvbn29/ttFMW5AWnQ+cUC10PcUlyoq1uzAiIDRjDEmfatU0Avuij13ouQtkVaU6jXldlGHHPGcWke14xrj6NOi1z0jq/LdXLWn7L+J2RiVkqYHDz8OI8mRBzNiz1PvQaV1DhoAM9sAfVNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR+wPEWt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E1F1F00A3C;
	Tue, 26 May 2026 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813545;
	bh=BzHDn0s1mv/4IfZh/7mfkYvYs848g+6l7oL8JYM3GB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZR+wPEWtsVxUgmW2/0MFgzMXDtmVMD0l3lLiAUMIST5uvbMXoSm9L+blTW/5SiiE6
	 a6qHJK1ThRibMWamqbKn4sTr6r7ptoeJfCl1xr/ZTCyEHiMuAQPoUtD82o3EJEHJV5
	 36PlYiFI5+llSTo93nP2HaPsBJhHqKZvj8bQGt/qjiYj/wphd/HjliKe4iNy0Q7f8M
	 KsDfuePZVG5CCe+bWL+e8GSRhmp8WHcW9vyVdpjqSNH3bDaoWIoDAVwL/ZZytVGt6x
	 Y4RhxwXGWjHA5kl/T5F1A+cASs86utl4N0eAq6hh9wpqHNUMgMZm/d7YFF0OX0PsJC
	 1YeQ34J/Zjq5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 12:38:45 -0400
Subject: [PATCH 1/2] nfsd: defer setting NFSD4_CALLBACK_RUNNING in
 deleg_reaper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-cb_recall_any_callback_running_stuck-v1-1-310011a028f3@kernel.org>
References: <20260526-cb_recall_any_callback_running_stuck-v1-0-310011a028f3@kernel.org>
In-Reply-To: <20260526-cb_recall_any_callback_running_stuck-v1-0-310011a028f3@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EuhaeTvZUer9TPm4hog0MOssp4P5pZU6P3ibMtaXW2o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFcyneTPqlf6nE46AihFmbKARJVO9iyGdiVCk5
 pSQ9klotlqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahXMpwAKCRAADmhBGVaC
 FSh+D/9Gmcr1/QJAqHBZBZO6W6H1U4lYIk548bP1D91TbT4K5VbDzBCcPpbzzidC/Lsz/8MLqJI
 u73jiv3wT4DIPPXgcoccw8DqWyqVRs9NYffna6dC9BMv3AcNjHnBOasLoor27e4cdvwiyuM/xhm
 mWdScIlfle//DTr3ynhD43Bl2YstKmx6V6QShMF+5zCioG8QD5emD5RzafUu7teeWOU4AlVt33m
 w349+cE8fZkd//MDr4Y15E94BM/I17YEY0cRo+rQ2sWA8EGXzntkmHAW3+igaCmtgS7PZPXDeBF
 FuDQ0/PaI8IqjtOcLQmB6Vvp3B/MrOPyZsUnA6NfiOr8kxoGzqcygcX5HzlAru0/0GKqKhuS8U1
 X1kZDXQ2QgmRyMlaQ6hSzB5E6Y484xwSVFNCMp0KhMW5EXx3B3CIDjCq4sVnN8vzi0JiDLNk/Ku
 9eliLEOBPiaWlb3DSh57ImCP6ygJo942QbSiWIv5+kYtgUxfAJySEXObJ2fNLVAGeK8LKJrMCqN
 0Z+U853fxTB1oABXoBs+/H4NzvKx/C1QcwuzCY2B/fVZbGFcOYEzV/tmBLJy35kMqppDYgLBmsx
 Z0Zsmz8LK6FrZ3NFIpFFFxRzo27pgEroXG8KBtV8mh78IRCT238RWDvVLqKk6NE0/Om1ds+aY3W
 Hs0zHa8KrYHJh9w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21982-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80B145D9E4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

deleg_reaper() sets NFSD4_CALLBACK_RUNNING before checking the
5-second rate limit and cl_cb_state gates.  When either gate fires
the loop continues without queuing callback work, so the bit's only
clear site in nfsd41_destroy_cb() is never reached and RECALL_ANY
dispatch is permanently disabled for the affected client.

Move the test_and_set_bit() below both non-queueing gates so the
bit is taken only when nfsd4_run_cb() will be called.

Fixes: 424dd3df1f99 ("nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5cbf626ab9b..57b99d1e74a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7478,12 +7478,12 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
-		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
-			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
+		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
+			continue;
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);

-- 
2.54.0


