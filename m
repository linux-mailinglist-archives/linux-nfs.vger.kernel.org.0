Return-Path: <linux-nfs+bounces-21753-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF8XFLTxDmohDgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21753-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 13:51:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBC5A441D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01656301A4CF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD423BB694;
	Thu, 21 May 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3yrh3F/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E98185B48;
	Thu, 21 May 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364234; cv=none; b=DwPR6oleHuar8Xb1atU7CysV3RqOHofzar1pFoQryKFIR9FxbQ9UeDDlwsuOB637vZrO8A9XEvg9jbf2AJ/cNMjJmpyAeGaN8jRl7x6HVxJ9SIf3miEI09xcy/cdwQw+/+VPfP+Hv807/W3brEUoXLdPAFA9pocb5tb4Mb0Y9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364234; c=relaxed/simple;
	bh=facGVCTUMDEg00YKi2YmJUcYpjK0EKDA4eYv/HuPK4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UbMoV+SK/WOzo7lhv/0MnBtLR+BFIz50jzd3OUC5/fq0eyy0sbCf/m1DgwGOvKOzjbYM7Y5uSRh18Orxqpjo4IwPyzYw+vSqqpytDX6oO/BLVGs9O55vXB0nI3QxADUoPQRvjly5iQOly68yTcQ9nP78wUKuHlJVj5V1+ikH7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3yrh3F/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2BA1F000E9;
	Thu, 21 May 2026 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364232;
	bh=rpJg9z8XYC9Rv1o9F7++APvg4k8Ih6Ibox5ZV3MF+ZY=;
	h=From:Date:Subject:To:Cc;
	b=T3yrh3F/eRoGB+gw1Bg3woc0AGnbL3CvDvWykJoNyqSjPN/SzMZxwzzwHEHXadLOa
	 v71dXHwx6dSlGmQqTewA7yAJVTPPeo8/NKVgPA6rQCILn7k4OORlwyncSwX85Hn+sS
	 2hvYTfTkgxuwHGSdwhjVuAxzg6SkStCDdtqA34ZsEwxb9exwCCQxsyEbZQe1LTzu9K
	 KCpep41dTW3bYImvpgi+Dpyj+lipS8HVTCydc+w5wXkpxpdIF7ZF4HmFVfTL17g55T
	 SaatLtE/H8FWp6ps2tyUradZNQwrkrfdSa6YuBdktL05F32i2tFMr1uLGzRet5nlB8
	 iNq9KekkPjDCA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 May 2026 07:50:21 -0400
Subject: [PATCH] nfsd: fix dead ACL conflict guard in nfsd4_create
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nfsd4_create_acl_posix_acl_overwrite_leak-v1-1-850fc0a7157e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N3QqDMAxGX0VyvUJW1P28ypCStXELk1aS4QTx3
 Ve8O+dcfN8GxipscG82UF7EpOQq51MD8U35xU5SdfDoe+w8ujxaakNUpi8HilOYi8l6UFlYfyq
 1T0wfR9g/0627XLGNUPdm5VHW4+sx7PsfOGtf53sAAAA=
X-Change-ID: 20260520-nfsd4_create_acl_posix_acl_overwrite_leak-a06bd957804c
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=facGVCTUMDEg00YKi2YmJUcYpjK0EKDA4eYv/HuPK4Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqDvGCnTMByhmsXasIU3f+k7o6iSOxD+9W02RIh
 X++hjnjvLSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCag7xggAKCRAADmhBGVaC
 FQWPD/9tKVZqBgy7pMTx0zH/LfVmseBoieCFwRcj3oBljFChuON3GxE82NHM70CR4RWCmAafz+k
 Wp1tC3WXc3tWQ+Pq8C0oemh2iRPV7za02dlwN5oqBZNATe4kwtv/6CqmCYS45q5rzESF1ce3M5I
 hmY1rw9r+RXr83dmDttOIVM8srgHDpQfvqzV609FsqJSKITnrtwSrwHALEUR7+b2o3KAajFADYS
 HkhTpEVKw+4ywK6uPTXDS6k87YgugcGsAMygnAWKCWvR7Y8pFenssdhVQBN3XLLgN0nDwSgy1FI
 Silb3n3rgFsvaa+HmgTAr8yhsLW+lhKyO3VO/3AyO96GP+tySW43jMNoKVRB2AXsVVILpTpxZEQ
 HjRSU+kI8Gdsn/FdlSc9pWqgEY2Yt3NxnJhExtSrREr+aBkvT95wReBR051t6AtkRLCB51mWBiv
 gDBnQOVUTY1VIiLjHwmXZM4Ung9pEJKhsXBA4Fo3xmppwL1OeFoXWOolsVWmjCoM/oATWZQuAoQ
 qu+r3Q9NdzsXxCxXXFjtV5CJffyasIp8WAMajYGyQNrvNUFxsDs/dFa4MElUdlk058k79WaxZRL
 YWiiPaTyBDZ8cthZg9wkg3v+M+NuSCNPl0snyJx7jFpMm19PDhwjHb7oXJCXp1DUHdkCa/ttUuH
 e11Bu2lzPyudrPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21753-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 70BBC5A441D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_create() steals create->cr_dpacl/cr_pacl into the local
nfsd_attrs via the designated initializer, then immediately sets the
source pointers to NULL. The subsequent conflict guard tests the
already-nilled source fields, making it permanently dead code:

    if (create->cr_acl) {
        if (create->cr_dpacl || create->cr_pacl)  /* always false */

When a client encodes both FATTR4_WORD0_ACL and
FATTR4_WORD2_POSIX_{DEFAULT,ACCESS}_ACL in the same CREATE fattr
bitmap, nfsd4_acl_to_attr() overwrites attrs.na_pacl/na_dpacl without
releasing the originals, leaking two posix_acl slab objects per
request. Repeated requests cause unbounded slab exhaustion.

Fix by checking attrs.na_dpacl/na_pacl (the stolen values) instead of
the nilled create->cr_dpacl/cr_pacl, matching the correct pattern
already used in nfsd4_setattr().

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-6
Fixes: d2ca50606f5f ("NFSD: Add support for POSIX draft ACLs for file creation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 85e94c30285a..fa995cb34b16 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -837,7 +837,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out_aftermask;
 
 	if (create->cr_acl) {
-		if (create->cr_dpacl || create->cr_pacl) {
+		if (attrs.na_dpacl || attrs.na_pacl) {
 			status = nfserr_inval;
 			goto out_aftermask;
 		}

---
base-commit: de5bbd421a35ab18ed71f442aee49c956d6dafb1
change-id: 20260520-nfsd4_create_acl_posix_acl_overwrite_leak-a06bd957804c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


