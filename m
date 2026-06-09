Return-Path: <linux-nfs+bounces-22417-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iUIaKvlUKGpGCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22417-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:01:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB4663252
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:01:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QZcFyb5h;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22417-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22417-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5682630917BD
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDC4E3772;
	Tue,  9 Jun 2026 17:48:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954394D9907;
	Tue,  9 Jun 2026 17:48:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027286; cv=none; b=tuCsMv8UzX7vmi0896PdH+GQDBhvVfIVCrzxN1+HxUztYAekify1jH8K674tNp8WGa24BvrCi7wADGD7lV1GSCjpIQxSb0m5W+KN2YG8w9H01d2tKz6MqJskOiutzRojU+naNhfa4jKtc7Ur+BcYIombSoz7/L2a5+mxcJjwNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027286; c=relaxed/simple;
	bh=RC8Q4o+sDN8hiJL73YQ7jLVzuohRzOZJ8N9lyw2U7ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTL//7yXX+oTtcD8yJqze/AHSyWBZ6Viea/AqudhX4+LWWysCKMRqwOVGgKL0dAOBrhZmqjBWhnJOJApK19MO+Lh93GFRrnDVR+DfgcX2Gx+QKLGOC5WeUNntAnZhjwmbfn4SrLu4PbAPYcjmS7TXH/xOzyAihpxML1+oAC6Rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZcFyb5h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FA31F0089B;
	Tue,  9 Jun 2026 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027285;
	bh=HSirJ20UxaqRcpZdu1nDFRKAQBeJk3ozVY/Zdp8wQ5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QZcFyb5hVF+JBrWhQ08y7DnolBC3RL2Le4mwljdEk4TVP2ssk1ajyJ2jUCWXcgLpv
	 z6dJ+zIqccxLKADJNUM99k9JNHwecqDHD6xptizZyyFwKZPY/XIf3R76CJRLZHi6Vu
	 CHslL+ovMkIhaMoLJnJKyC9lx6n6Bm0YhPIaQh58EvaCFYTiBN1yoQ5HlGjrVEangV
	 Rofsbeehp06AqEJo5Arg41+bY16tZpk1NlikmWAqQe+zUPvrgrJVErg8ci67yeoeuq
	 JmOiYIucij0+AojV+f/QXKD1Q6cFw451kMsxcwndy9WNwEluk4gh4p7c2cRr6XmUqm
	 R8161xDNYggYg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:31 -0400
Subject: [PATCH 10/19] nfsd: fix version mismatch loops in
 nfsd_acl_init_request()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-10-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RC8Q4o+sDN8hiJL73YQ7jLVzuohRzOZJ8N9lyw2U7ps=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG7Ypt7h3bBjgUXMmI25+K+18OAyePwvm24M
 geLStpTye+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRuwAKCRAADmhBGVaC
 FUgzD/oCLrs+nvJfbPzIZM12pL7DStKlv9rXwFsKSWpMX7fOpTZtqvmAzIIffcIHZ+GyJbWFhvu
 CLmI86K15mgqqyHa4uq9NbSfghIbVn9PeTMYP15v+O3mUm4qY7J9FCWc06UihLoDu2jM+JGUqRc
 ZG1OZ+I5lFwp8DY1lZDpPSReGHUjdrtTKhx+fpaHv1MiweKs0M6XGraZaVoW1m6c1Mgi9Lg0wvM
 yXgjeEWG9yFbypXbi7yiW1eymfbh2GS/OXUfRb5/q2O8uqSzeWv0xHfuuiTZAcGHJfwEjN5KzCs
 VeatppLQXhGbDITCKMUKs8te2Cj3gSIbynWNQpVnSwAvMrBXR9gKJQqKpoacnAHoTfwnHYgjH1q
 ExYrOzSDnI8LP8B4+kXa44QiZJczbfNifv+LOp1xBKHvWIUFVouktF68O5myiGsb02eUpeLH45D
 Q3DWLcNtwkjCJLrzUZ5s1qmrVui8TIkGXKQN9uZqMNv3XTpEmFBumY2/s4gOFOuhtnFCloPRy+9
 c4b4TOH7lFnI2d/V4DNx8m3gL1HUJc2Yjz9nFirDZOahvNoX6FaSEyCAiLcPMb4DLlEJO+j5+07
 66E0znCI56zXRBhPuvxcv36jinvgt+kK/BNnDFqQhozmWbgl/AAAQimUzwqDv0NJsBaMtaNLXjy
 +WoY8ud0PvH4gUg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22417-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03BB4663252

The loops that compute the supported version range for PROG_MISMATCH
test nfsd_support_acl_version(rqstp->rq_vers) instead of
nfsd_support_acl_version(i), so every iteration fails and the
function returns rpc_prog_unavail instead of rpc_prog_mismatch.

Replace rqstp->rq_vers with the loop variable i, matching the
pattern used by the sibling nfsd_init_request() function.

Fixes: e333f3bbefe3 ("nfsd: Allow containers to set supported nfs versions")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e45d46089959..d47451125761 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -815,7 +815,7 @@ nfsd_acl_init_request(struct svc_rqst *rqstp,
 
 	ret->mismatch.lovers = NFSD_ACL_NRVERS;
 	for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++) {
-		if (nfsd_support_acl_version(rqstp->rq_vers) &&
+		if (nfsd_support_acl_version(i) &&
 		    nfsd_vers(nn, i, NFSD_TEST)) {
 			ret->mismatch.lovers = i;
 			break;
@@ -825,7 +825,7 @@ nfsd_acl_init_request(struct svc_rqst *rqstp,
 		return rpc_prog_unavail;
 	ret->mismatch.hivers = NFSD_ACL_MINVERS;
 	for (i = NFSD_ACL_NRVERS - 1; i >= NFSD_ACL_MINVERS; i--) {
-		if (nfsd_support_acl_version(rqstp->rq_vers) &&
+		if (nfsd_support_acl_version(i) &&
 		    nfsd_vers(nn, i, NFSD_TEST)) {
 			ret->mismatch.hivers = i;
 			break;

-- 
2.54.0


