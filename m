Return-Path: <linux-nfs+bounces-22998-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3BjaDNDYSmpRIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22998-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C170B9A8
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:21:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=Fy5qUIwG;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Sc0icLr1;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22998-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22998-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4528D30028E0
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763F34DCC8;
	Sun,  5 Jul 2026 22:20:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AF35F193
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:20:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290059; cv=none; b=j599UOk7K0gsXIIanXY9J6b2xtnlJjf9n7KyVpZ0QNm5ypS5KqtW06wF+84G5ENXN5Ye9I8E+t0nd8OChxHe2geCuPgEY9jsikFywJEwAaUxYQjQJCFCPZ+s7MwdHn2V9GgyHpsSaXGKhA61nyjsixSDnj+NFs/Hg3/alB+hk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290059; c=relaxed/simple;
	bh=mOc2P2wPYvM+mBoM1EmNiyx7ujKLkY09DcdABC2ZsCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4huoA2TTuLauhIlfIgP85pDUhFDlT1Xjn91TvJ6gCWU8y7z+x96jW7uqcwaxfgiWSlzljuShFyS3DyKWpSrwdxohhPnQjIvylX3oF49aPKdaKsQ+7f1FEATwBZ/GAq3OdKbAEkSE0v9kFOxctgt6AwP0gKBLgeeAA7d6AtDyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Fy5qUIwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sc0icLr1; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F03E5140009C;
	Sun,  5 Jul 2026 18:20:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783290056;
	 x=1783376456; bh=hapQ0gHTFWhlRBXYGEq7mFGxP0xkUPD721FN/C2q+2o=; b=
	Fy5qUIwGaDGr0JxIHs3V21rKFjlNxQvPAflNZE7lonQQI8OqhfhGPTy1Ug+woFCG
	Y4s2qXENVN/AgLWUTs0rlU5LxuxqB8mwkPuisH2mXjtPPrpVXjaTbEiagF47SpR2
	i7n426NG52PEump3stsB+1kMDNB00tXqWEydJ5ik5/4yzaqOLFYwaabyk9M0HKXg
	p15hmqr1KbNQMts5Owbw/nuHO/76KOBxIX9CWk0a5q/7xoYollxfJ5mRrxSidZRv
	snfArSNrXq/wqnDgqEqIj8dd4xWVu18IUYA9zaufqUUzOrN5nxt1tTTmvPVuXyaL
	LvhJGogXHJI+KZXCV9dZ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783290056; x=1783376456; bh=h
	apQ0gHTFWhlRBXYGEq7mFGxP0xkUPD721FN/C2q+2o=; b=Sc0icLr150d0fwk9e
	ScD+dX0zYLkidM+aFnbStqpT2L4wyxXQaQDhsBsEA5U35aoF/Ze/lqprUCBGAbuo
	AohKwnj9rsZCWH3u/l4X3bltEHci4jibJC1Ji0I3pVli+9pJqXkY1r4+NMl2qtUk
	1/hdbGq+MtmfArWXp1T38129D5ThpqnbQamoUkFbzt1uGNHEV+vnu9azHs4NLIxe
	blQx8fhGiyLcDdEXjNsgKzERx0T6ydeMIDspbpZC6KOn5gXmBpRx6xsNAmOthFr1
	+bqlMtEqhjk/rZ34Gnxq19jYfeP00S2fvn1MLs0ADJSE4fU2c4+WrOGef7YvdBJl
	R4VFg==
X-ME-Sender: <xms:yNhKamVNvJk0YkZiBQZg2qqNj7m44z_qKbJwaNLxDAsihte_fUw-nA>
    <xme:yNhKamTzQoncWK4lcoh3cNBl3_3a0REJ3UCf0ypPi3B5bmUyyMwCs7bGRU3xZ6dvk
    dJpeGoAtgHbGSK5J051Q-7on0tpxbv85roYB9B-BpB2_qv1qLg>
X-ME-Received: <xmr:yNhKakPUIPltupuO8nLLTyQJJxd9IKEYDAqnDBhjvdF9v2n9bkHXnYFWL-Wo3wvsi_FI-FHB0YvFSUZ1N3oYmLBd7CpQVy8>
X-ME-Proxy-Cause: dmFkZTEXWwk7I8gAcx7OrRtNSjcnGB47cRbiBDqgtw1WTOs3DuMG9iZhop51+DSdP1tiLD
    yCq7K4DQDhjO6nsk+F2F8II7LJ0utdmOACw+niG7CI11B2zvXCzreuesbdS4vY+aI4fICN
    33J75SdFOj7RZ5AcX4glpqvke7JrcFSl1l3lfiIjodRRR8tYqnxTYR2+eex171+X610ql0
    pwh3Y1hUkrOJ4HxX8l3S4zPrVLt+h0hyXkObswBuRXuRPVy5Gyp8EitKO+FpH8owD6y9Gz
    bsEbqyRQx5HBNkNt4zxvk4tnVA6tsZN5oK6SzyiSWNKjbVqVV+gXdrbGyBDtcahD+RvmUa
    Q/PNGaPuC98Tm6OZnoRGG9mADhgQlHb+OcS6HcTM2lLj2ox7HJecEpzReuDx6hfjsI+Pi+
    V9ZIpGvc8NxAO9wjtVtYoh/y1TTrXkyBLPi2J8k/Cxwv+ta+8nT/fnaHSsLqULEN9XIrCP
    4PWXnBsT8hIRPUcx2VbcFIVnpDqp5n8A1bbTqaXu8w+6oEtm3NZ1gN2jdC8kcahhMnwmJP
    HdV8CGPXDjVJaHPKh3zZqgDiE6BPG+fWgnM3gK4coHX16ySQl/Ak8KZQVAfRkz58KvUH3C
    O+ItKa90PszkAwlBU0GkcJSfHVVhB0PD/A8RlcIbJRFlwzxIQC8qchC34KKQ
X-ME-Proxy: <xmx:yNhKakQCYD3V2B4BbGGyyGRk5bnkEHd-ouTJ4kQt6mGdLGWRylpw_g>
    <xmx:yNhKaijeD9m0UgVfP_zxVHS5B9M43nqMGsY_8jcnfgiAy0Q43TmtNg>
    <xmx:yNhKat-labn2NofJg_9pLiq317qtY4dCAaWKAw8zK_GSPK4zdvIoEg>
    <xmx:yNhKapFwnjb8bnY2_CBDA8VG9jIoGiaSp9PyiVYGypWfpxWxX2SeEQ>
    <xmx:yNhKar3u_6sOk9BOWWGqE7zhzwncnmHvCeBCwoZmUuTHrTYsT4xcednW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:20:54 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/14] nfsd: move fh_want_write() after preamble in nfsd4_create_file()
Date: Mon,  6 Jul 2026 08:19:35 +1000
Message-ID: <20260705222032.1240057-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705222032.1240057-1-neilb@ownmail.net>
References: <20260705222032.1240057-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22998-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B5C170B9A8

From: NeilBrown <neil@brown.name>

As part of separating the nfsd-specific code from the VFS interaction
code in nfsd4_create_file(), move fh_want_write() to just before we need
it.

Consequently errors in the "if" statement that this code is moved over
can now be returned immediately rather than needing to "goto out".

Also restructure that "if" statement to only test is_create_with_attrs()
once.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a93132323b66..17be4f7420fc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -270,22 +270,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	parent = fhp->fh_dentry;
 	inode = d_inode(parent);
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
-
-	if (open->op_acl) {
+	if (!is_create_with_attrs(open)) {
+		/* No attrs to check */
+	} else if (open->op_acl) {
 		if (open->op_dpacl || open->op_pacl) {
-			status = nfserr_inval;
-			goto out;
+			/* Cannot specify both NFSv4 and Posix ACLs */
+			return nfserr_inval;
 		}
-		if (is_create_with_attrs(open)) {
-			status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
+		status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
 						   &attrs);
-			if (status)
-				goto out;
-		}
-	} else if (is_create_with_attrs(open)) {
+		if (status)
+			return status;
+	} else {
 		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
 		attrs.na_dpacl = open->op_dpacl;
 		attrs.na_pacl = open->op_pacl;
@@ -293,6 +289,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_pacl = NULL;
 	}
 
+	host_err = fh_want_write(fhp);
+	if (host_err) {
+		status = nfserrno(host_err);
+		goto out_free;
+	}
+
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
@@ -409,8 +411,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
-	nfsd_attrs_free(&attrs);
 	fh_drop_write(fhp);
+out_free:
+	nfsd_attrs_free(&attrs);
 	return status;
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


