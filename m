Return-Path: <linux-nfs+bounces-22620-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCW/N/g8MWpBewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22620-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:09:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4568F211
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:09:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PO2rbaLN;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22620-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22620-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC608316D034
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33925472784;
	Tue, 16 Jun 2026 11:59:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01490472782;
	Tue, 16 Jun 2026 11:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611182; cv=none; b=Q3N0QM6M5ZAqn46rgztZhNz+2VSM6dIfU9+zUYbUrppuVw3YQs2CkpukSkMcMjzUw4XNg+FLqqJF76RJ/Ow6HIuz4ySQom+TchkAGw/i962O31Hyez5Nwc6oepcmgrdoQ/ATMmJFOkB/Jges6I1rGNpktSA+N4jARWFDYkXb5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611182; c=relaxed/simple;
	bh=KpNjvBy5kZA9voPUFSOMLKosIC22N4Ab3HW0MjMrHWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLDJGtSO9HjwO9xaf/xtvE4sefKO/3EuIm1/jGLhpNZ/LAedWan0nr9Sos/fZZ5wWXQ536g38plWC12bkO/aZbjRjQ5mCPOCdwpEslV2+eEG0gFwBBqAi/RMPY0TzeNFTIixlxZ5GYTFSpqWKrh7RVFL/Uz6r7UWMzxDmbz8Wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO2rbaLN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6351F00A3D;
	Tue, 16 Jun 2026 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611180;
	bh=2lOGPHbS0VDKJIcU7jvqgNeR3kLuLELHVi4EfOtpfBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PO2rbaLN9e7sACx3fLzBXOUiKEi9DWnoKthv44dolceXEHDYoAjDVxAA/QqwC7Mgn
	 /tHXSjCletk0H4f1CBcClv31Q0tNdom1p07f+80j5Q5vPv1tbRAFb2vUmrNllCEaXQ
	 1+umZLqwNH+gTQnyz3sJqD+JO7ORIXUBomVDX88iM5RTg90qddDxSSsJYDtBvwSHk6
	 wbHzDB4MmzBI4E3VaOTiYPH55dfsnMLQr8wKvjGmgkq7/8kB/TuDEF5pNAaAloq3oH
	 39hS2p/eMQjSaosM/sXBhNkR0Kx/EYN0uZXL9NQG/8Xlli7dNuUueObkJQ1oleeyBa
	 JyvmadKzi7k0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:59:01 -0400
Subject: [PATCH v7 18/20] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-18-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4452; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KpNjvBy5kZA9voPUFSOMLKosIC22N4Ab3HW0MjMrHWU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqIgXvg7svVcjsn1dDfNv1L4sA3sPozbQNi7
 zO4B/5m+JqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6iAAKCRAADmhBGVaC
 FSl0EACFphdykWOJe9Swc/kh8wVvJJZLTiGsDfMMItBV6DQjChE93odvBZRr8vGcFRfxFV7UWAn
 ax7ume9AUEJc+Xt0xuxRjfOryo3Fn5eNvZrO0EselsmUVUPh09Mv+EI3Qej7JgxmcyAB/6SVKj8
 EgIsW7crYDjKyNmB+AdUg0kfX14FupsB06ZhgW6Kvi1dhOmjbNRjMRluYiF49m1JApVcJ13uaNJ
 YqvZR2+8H25p86kGoJCYxVBG6vvlHCKqMMpQavdCrzFafqvMnIM905LWoW96btcmcHx22AXs50y
 O87wVUMqcpzq1uVbcDsIEOTBZugQmkbpWJ179TQbX50ee1wPsC6QTCGcPXNYBeFwXlfXwjhiW/2
 xKLnbCzGVjCVyCcLwKELLZV03fq/wF8BVx0g7Kvmt2Nfe2Lf4hc8o8VEsEVMUwX5JDAAJnbIy7l
 eQcNUe2gSocPTyYYi0jY/73Dpq/W8eWAhPgtdaX1alC4sADiuV9rSudfAxqMy00BDbTpFFei/of
 ZjuWzRlNZi/9wLz/AQQ3cXEpIfdQ+2ryLaoQ2l69/BVjUXwj1safQEOa6hhcBaCBGrZ9m5CkWm9
 HyXPqt6ldIJ8ZMGrtlC509qOUAEapRcImie7xNmE/JYXC16ADseLg0GZ6PBCy2z+vTb9V+mlPGw
 V6Slybyowvy9cpg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22620-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57F4568F211

Track the union of requested and supported child attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Since the requested child attributes can now include word1 attributes,
gddr_child_attributes[1] may be non-zero and nfsd4_encode_bitmap4() can
emit a two-word bitmap. Bump the child-attribute bitmap budget in
nfsd4_get_dir_delegation_rsize() from one word to two accordingly, so the
reply-size check before this non-idempotent op accounts for the larger
encoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  4 +++-
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 15 ++++++---------
 fs/nfsd/state.h     |  1 +
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index be79b6063afe..576346578ee0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2608,6 +2608,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
@@ -3574,7 +3576,7 @@ static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
 		op_encode_verifier_maxsz +
 		op_encode_stateid_maxsz +
 		2 /* gddr_notification */ +
-		2 /* gddr_child_attributes */ +
+		3 /* gddr_child_attributes */ +
 		2 /* gddr_dir_attributes */) * sizeof(__be32);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 682c00fbd2fb..c4dc0428f0a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9959,6 +9959,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	return status;
 }
 
+#define GDD_WORD0_CHILD_ATTRS	(FATTR4_WORD0_TYPE |		\
+				 FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE |		\
+				 FATTR4_WORD0_FILEID |		\
+				 FATTR4_WORD0_FILEHANDLE)
+
+#define GDD_WORD1_CHILD_ATTRS	(FATTR4_WORD1_MODE |		\
+				 FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_RAWDEV |		\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY |	\
+				 FATTR4_WORD1_TIME_CREATE)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -10027,6 +10042,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	/*
 	 * NB: gddr_notification[0] represents the notifications that
 	 * will be granted to the client
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b3a4b134d309..0649bb4cf2e7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4284,18 +4284,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
-		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
-	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
-		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
-		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[0] = dp->dl_child_attrs[0];
+	attrmask[1] = dp->dl_child_attrs[1];
 	attrmask[2] = 0;
 
-	if (setup_notify_fhandle(dentry, dp, nf, &args))
-		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+	if (!setup_notify_fhandle(dentry, dp, nf, &args))
+		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (args.stat.result_mask & STATX_BTIME)
-		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (!(args.stat.result_mask & STATX_BTIME))
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 7a66048a130c..2bc54546deb3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -300,6 +300,7 @@ struct nfs4_delegation {
 
 	/* For dir delegations */
 	u32			dl_notify_mask;
+	u32			dl_child_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


