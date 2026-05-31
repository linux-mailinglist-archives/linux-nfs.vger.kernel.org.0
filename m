Return-Path: <linux-nfs+bounces-22132-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAJVBH8lHGr9KAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22132-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:11:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE18615FE1
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2942C304C627
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68569388876;
	Sun, 31 May 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgeAfHH0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414C3876CE;
	Sun, 31 May 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229235; cv=none; b=JrFnOqG7DcB0f/yzbAs/NhwVT350IaSFuc8wFg8pqna1pN3D0sPFdbctUATxQ9S0ObPDxNt1CRGPqCLD+5BRD83bi/qNjnkFNgUh+jImpHxvkMsCFcmbllU2DMmpQB2jzOfYp1+XdE+KVsNNKbEfJ+dlw7xPmkfnIoKRWGPNeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229235; c=relaxed/simple;
	bh=/6uYWy7xN9U+vxj0A962PY5S2/SNMk5yLo4tDWUdyS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJWU+KYe/CCkMQZk/5A9bVKmOfPG7TCu2slVzKQcp46ygCQgKM80p+cnfIIEXQ3ss0dDFQMrv4R+piRDj+d0mgkv+deqwkoUOQ1dNrsjR0K1Ri3XQyTzORtvHPYDIDRKpuJYuVdMVFfMIAixpN6WqoXBbG1uP1fNBfPWRWuknnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgeAfHH0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368B61F00899;
	Sun, 31 May 2026 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780229234;
	bh=5NwygWEjoNbqbCU3Xq23XELrYKTK5E005O/Uv3eJaoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CgeAfHH09ixGpOlGEg8npN4zZO37tRzTsSYR16ygobE66DKi57bfIpXP2kvo1t8C2
	 KEhBw69dCvbCd/JPCHIytfESNs3/6kpd1yL0VotZb411hENocPwFkExjajjSivgfWD
	 gQ9282zyjfhTXdsYfw0ds6M/sUdvRn+GfrIb/NmksTfmfuq+4zrYN3eCgYgjV6cm+C
	 DKHEfxI1ihPf5m2c966C4YsyvGn6BnOyxrIYiTz+YLmhFNU2Vqiu9/85TlQrQKIJWC
	 GhOYCr6N0aNsT/yEXAWG/zAdnjttPaCAhX/Bgt48ruwRvxvv6enouJeEI4GdRlC62o
	 /eP4nlI5VkwFg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 31 May 2026 08:07:01 -0400
Subject: [PATCH 4/6] nfsd: fix dentry ref leak on V4ROOT export filehandle
 lookup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-nfsd-testing-v1-4-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, David Howells <dhowells@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Rick Macklem <rmacklem@uoguelph.ca>, 
 Chris Mason <clm@meta.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/6uYWy7xN9U+vxj0A962PY5S2/SNMk5yLo4tDWUdyS4=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGocJGuiw6HQ/YZcvBLXcDE6WUVYJlwc1GUeaaS5Ftdg8wzDG
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJqHCRrAAoJEAAOaEEZVoIVlpYQAMk/
 +VYz3AoK2wYKMBn6acBXEeEnSNFArBtvbkREIHgj3ucmEHaMIVYdBlVqWKY7sFToZ7Szs3ZCGjh
 zspi1Su/H7Yq6hp2L+kSA9MyHoVhBASKgZ6WONZQg2QhpcUurYd9qkoonRNv4XATVTuR3sRVZZ6
 EyJYX4J9eblSrVEW9D04um37fjNZRmcTPJrjtAbkmgYSnvmzkmmbOneVXvOgua/PJ5q4KNXBHt0
 9Zw3MAG4fFN4pzu3rmmW727R9+WuwpqSYAwIH+WW4YsNmsUGh4clv8p3TU1gCU06vKuP9Ws2oh4
 MTBE99BwgRhhePO/KYPVlXPeYBRLARktLVEUxlVdzn7ouGEYlTOaLCRcG8cwaUjpJ5KGQiuWWop
 ChVLqazOmUl2b46mA6DawnCcGTq2q9HS3nW/SEwV1bnLP3Q8771AXMmw3YQiVt8QIZaLk2kTD41
 KNeS85QQem+Z1Kvvd5hE3QT4JI3fcH/BZyRI1M/3Y5vZRlA6n5uKNLbl9EspBHloHbFUQ5oAlsZ
 ezwRD3TVVfVw0C0oJXOKwtrdqGckw+fqL6O/lkNtRDTTWlTcyIKVrdnK8jIsVPdNtn2/ur9bMVO
 AIYFGN+Qq6cOL4bjX8ePtkDvJK6UR22lWJVTjj/FT7it+bQ6lYZo4j2/TBbPtD6eknul8Nyc3qA
 yd+6i
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22132-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DE18615FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd_set_fh_dentry() leaks the dentry reference from
exportfs_decode_fh_raw() when the NFS3_FHSIZE or NFS_FHSIZE
switch cases detect NFSEXP_V4ROOT and goto out. The out: label
calls exp_put() but never dput(dentry), and fhp->fh_dentry was
never assigned so fh_put() cannot compensate.

A crafted NFSv3 filehandle targeting a V4ROOT export's fsid
triggers the leak on every request.

Fixes: 6e171106dce7 ("nfsd: move V4ROOT version check to nfsd_set_fh_dentry()")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 429ca5c6ec08..b36915401758 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -344,15 +344,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
-		if (exp->ex_flags & NFSEXP_V4ROOT)
+		if (exp->ex_flags & NFSEXP_V4ROOT) {
+			dput(dentry);
 			goto out;
+		}
 		break;
 	case NFS_FHSIZE:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
-		if (exp->ex_flags & NFSEXP_V4ROOT)
+		if (exp->ex_flags & NFSEXP_V4ROOT) {
+			dput(dentry);
 			goto out;
+		}
 	}
 
 	fhp->fh_dentry = dentry;

-- 
2.54.0


