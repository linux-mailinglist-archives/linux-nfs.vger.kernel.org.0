Return-Path: <linux-nfs+bounces-22058-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBGYDj+6GGqsmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22058-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:57:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A265FAA15
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BA27305B619
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB336921C;
	Thu, 28 May 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BapTHcxX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98968368D42;
	Thu, 28 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005340; cv=none; b=eQqNFfJ1FB5u0ign/75Q3LHFH1hIcr+s2ovGc0jVkxQiOrh652lOxo6c8PnQDNyK2JDf8/a9DbSRpZ2c4ubcfqaj93RqNWlYwsdgXiEgS3fNLAQQ+guRfcr5cvLKsW4X1cT2JRIOyffC3nH8n0er4xILEIMLVRGTLr6neNEGeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005340; c=relaxed/simple;
	bh=tpPyldF1ng/UAup0IEjon7uOB3/Il45nXDpJmy2eEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmsQ+Nt9cB2pgIBlWpIOISDEA8a0k0IABU6r0K6yRGnLb7ROv9SzUTZ/b5+fYQm/wnelUtzxCTnjjgTNldTpo+Vy4bkL0ROZha8vAO9Kms7Lc1pyfdmcRb8IpV1FOSYF+rNTc5o19EXo/wqky0/slmZEGOLCFM0FJVktZys9ZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BapTHcxX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1364E1F00ACA;
	Thu, 28 May 2026 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005339;
	bh=JryY+lk+CVXnYXPbEYkvEZd9RAwO1QGurng0FR2GFkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BapTHcxXNN8XYX88rror0PQxwV2RCVfUBc6kkFrIPz7E6cIv+4P41doDr6EsJ74zg
	 kl5Z2+zfkU65CZURYw6W7fHYmM6svU+vVJBKHTGcdPC9OQ48kZtV4KjySNKxOOHnOu
	 IYB2inuz6hcuYDd6e3Fe7UfyVcmWhwi1wkYIPAaogubxUc+LjFmpyaer32fPYJLDbg
	 ZfIX2+en2WwpLMToHmgi1+UxL/TI+BTMPcS72zMek3koaHJLaJ/QWMDDFfFqRY4KY1
	 /K2mBvGt2zqYnbtgLHme33h0dUykgS/aXS5DOKzBGwx4u42STWcnyf3juZwnWNB5jJ
	 etACUxBo7tXZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:20 -0400
Subject: [PATCH 09/10] nfsd: cap decoded POSIX ACL count to bound sort cost
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-9-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DnOXwDcgGRU7CosVARw/tloWNLDBt7bWuhRiCqiYRb0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnLrNmWDEt0F7v/L92MWKqm9U6732ZAwULpH
 5FG4+J634mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ywAKCRAADmhBGVaC
 FRS0EACu97meKx3iF96dDwt3L8AQ4VnejoH4F+UlwXdbHsncN7AQHHR7dYtI/suEP5WLeQFSleN
 M2DXPpoe08RwwVCrBQTS4YQCJDiSIOSvnhNLPCLDbTS8HMNS1gu/B0yWqHR/WYTcNXNH8/CHpmA
 bpihukXw5kSMZxayi1JQSv3lCKjmrtsSamN/x7EAKx3Idi6usk9sfafY9uVBppPujTW0AJSrn6W
 bcaEYMV+GinTegqThDQEDla8cwoqacz6xDEQPWS7GMvEw8pzYrtPl4uD0OUODOljhngO8e2DODR
 HKzsC+JQY1qnckSBczaUSy4DSBNFL35ybTWpHZmdD/6BJPU2dHL7na7TWONhQpMQt9lBgwtHc5v
 /vNcqkgiM0STRBGkGBY1nVZoqzckqipVPGxlSn2pDV+i6lt7ekHoXoNfYcvOAKuw9a1/1oC2i1B
 a93lkgxaOR8P52VMcigEpzkWd7wLPD6M8mxm4zju20FQRxGujO4ZReK3gz9bjecmPTyRxuefSoW
 48iBjCudY0d49cZaNWeJ50zRKsLKIs8drd0Pa7At9jFxCymS+bV+oJiAZZlp1YEHkq6WAGeMnXu
 y9ybkzvjX11R/YTvsvwAT+rTZrEBKE05IscaLxw1vH1y2DP1FJ0CGS+agc4bUxuUqIrTdm/hKZe
 TIBOM2IqfH3eN8g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22058-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: D6A265FAA15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd4_decode_posixacl() reads a u32 entry count off the wire and passes
it straight to posix_acl_alloc() and sort_pacl_range(). The latter is
an O(n^2) bubble sort, so a client-chosen count drives unbounded CPU in
the server's compound processing path.

    nfsd4_decode_posixacl()
      xdr_stream_decode_u32(&count)       /* uncapped u32 */
      posix_acl_alloc(count, GFP_KERNEL)
      sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */

The encoder side in the same file already rejects ACLs whose a_count
exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
omitted the symmetric check.

Fix by rejecting a wire count greater than NFS_ACL_MAX_ENTRIES with
nfserr_resource, before any allocation, so the sort is bounded by
NFS_ACL_MAX_ENTRIES^2 comparisons.

Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c6c50c376b23..5469c6c207ba 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -448,6 +448,8 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
+	if (count > NFS_ACL_MAX_ENTRIES)
+		return nfserr_resource;
 
 	*acl = posix_acl_alloc(count, GFP_KERNEL);
 	if (*acl == NULL)

-- 
2.54.0


