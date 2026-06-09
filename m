Return-Path: <linux-nfs+bounces-22422-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DWIiJ8lTKGr9CAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22422-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD16631C0
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ed5qqzTk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22422-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22422-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A95531655B0
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AD331EAA;
	Tue,  9 Jun 2026 17:48:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6ED4F7998;
	Tue,  9 Jun 2026 17:48:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027297; cv=none; b=AX6t7LcXczmStqtRN7DTAZ0P97p0dUPpz2WVWH4HgYYdwCo5u6QxD8mRd/nm4hUgozGl2IwwGtJYkgIU7cgL2zvRRLAwHaYT2ORcF7Ku+AvWT4VmhnQavF2qe5UdBOiIhGPjHwosjWMoePk8Jt2GbKLVKB/sKO7kAcjgTv8zEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027297; c=relaxed/simple;
	bh=837ntEQAfNm8vgCsD7lCToH/PeBWJVyRMgHmiH3X4lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skd6ZlzTCCpEELr1jbeOT87Dn0CYuJik9jz+bLdj5GFANNA89a7BNj9K4xtHIyFkkiktKfYOqswsfNgSst5m3dz4wcJfnNJ43MyKRHuvHyEYqx+Oo3ce8GtF+m7j1ggjWvUBjaH8mU7Fzbgn6e/23cGF4TaCY/DkipR2U6HlQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed5qqzTk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C4F1F00893;
	Tue,  9 Jun 2026 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027296;
	bh=z2MG07CGdbK8RrBt2Dmld4oo4PTUdCYx+6jkKRUpyus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ed5qqzTkxufcJ1ADfIyxzxrXXDJQny9qKUfHOqayoQk3uGtAOo7I+rBKkvP21Vq/o
	 LL5gnmlqKUjY6UYBrbrvXAyJumWvo8JTlYZt9lwWnRZvKT3C+NHw8ubvmSrpjl92Q9
	 oJ2O5a2NURt052m5c8heHCSDErgGBncmSF5O0LleFO7oILmnYfRGl/PAk9b8SZt4MK
	 wQEDK/0kHoLmuK996kIhQb/mXS4QmIE9KmJilm/C+jHoPY1e2kdARKhkv3XmvY08D6
	 RJkL6FgqflMokcggnkeBnpKWuSD6OgevDpr34R0NEx8bLow671T5zgMLVAZnK4XzsR
	 e3fXfylxj5J9Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:36 -0400
Subject: [PATCH 15/19] nfsd: reject reclaim LOCK after RECLAIM_COMPLETE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-15-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=837ntEQAfNm8vgCsD7lCToH/PeBWJVyRMgHmiH3X4lM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG8DWvynzKWOTPC9eUtMYP3ufwu6C+uTicXD
 WYJwut/DXaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvAAKCRAADmhBGVaC
 FaMYD/4wUfRmlnO0ClfBqvSXJH/giZDYnMhJ6I4OQtz3vu84GWIHYDi+p+x0vI3x7sbkPkpU3ql
 a0MR75h8lLbm3LiDgNu92w1cIdCxlalOsc2mI4/oy9oc3BGa9iS5zfvJjF28fzQNe2tVVGJHHb0
 x8oWUuGPfsz98MSMB8IT4RWhM5WSJ4l8+0W9py3saOSRoL2ORa62t2OvFWtVNnSP8LtvSPHm0iU
 E83Qiyy4M0D6kqN5v3NXCLuDJ00MSOKLqKUanmyavHweToA+7F+1LI8claqk4mqgAfzzymMdeyt
 HTOKoSMa1yu/cI6RwbOJnkXD5QIJxrmBfi0c/mv2IIAgO5Z5sMsvEKplZ5T/wOqUCy/zFHQBBZQ
 XG1O04Gi5Oa3Uwis7B/kGhgVHB/fQM9FRf6QDDLnfVLk49A5rCBNS2hSDt6opVPBDXbK8l/e4Ii
 ButzWb51UnRu5hhAshSJSHkkpstr3+CrMECTBBtAge2wRiDzY2DlNa+qyBvR3PUJNUsIpsI23/Z
 N1IHCNsAT8tA0DBYIp2qZ2OJIAHWfK0C4TtXm26/lz/YLTm88oV5HaTFD07o+Uvjn3+kWuzfJ9E
 PXbLqUl9WuqaUpNQ04T5M07J2CAotM9rw/CRFZ9G05xHH9dGqpGchFyhBu89siekHpbvRZdaZU7
 cCGajoJi1dvTt3A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22422-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ADD16631C0

nfsd4_lock() only checks the namespace-wide grace flag when deciding
whether to accept a reclaim LOCK. It does not check the per-client
NFSD4_CLIENT_RECLAIM_COMPLETE bit. A NFSv4.1+ client that has
already sent RECLAIM_COMPLETE can submit lk_reclaim=1 while grace is
still active (e.g. lockd holds the grace list open), and the server
accepts it instead of returning NFS4ERR_NO_GRACE as required by
RFC 8881 section 8.4.2.1.

The OPEN path already has the correct two-tier guard via
nfs4_check_open_reclaim(). Add the equivalent check to the LOCK path.

Fixes: 3b3e7b72239a ("nfsd: reject reclaim request when client has already sent RECLAIM_COMPLETE")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fddef6f8db7c..7d96bffd2fd5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8552,6 +8552,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfserr_no_grace;
 	if (!locks_in_grace(net) && lock->lk_reclaim)
 		goto out;
+	if (lock->lk_reclaim &&
+	    test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags))
+		goto out;
 
 	if (lock->lk_reclaim)
 		flags |= FL_RECLAIM;

-- 
2.54.0


