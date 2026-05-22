Return-Path: <linux-nfs+bounces-21800-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLHVEJdVEGraWQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21800-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:09:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F85B4D4B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD6FE309DD9B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21D3A9017;
	Fri, 22 May 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUGOaOuL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BC3A9631;
	Fri, 22 May 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452983; cv=none; b=u4Bu4/zkzvCzN37LqJIGxFmWt2pJwlONsNXl0H2TuBCZFaLguAilz1/5jQaPSAzCoMRFPFUzN3gp9g+WMEvOpCSDt7HpDY/Ni9W5oAboz2d3NDtrxmOcZcKkoNKqI24YbLMO3GpLtB8136qaYiiP24GQcbemqCaWEmI4jNUYctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452983; c=relaxed/simple;
	bh=Tm88PYbTKOzA1m6/RvOrfrf+njGW/yUDKwdnprgqAUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NM71D0zSB89/FgKAu4W99PKovpw6gIOSXugNO/EGZrzV+lFBrnobhS7EHGJ+sTaUXJcwOmNbZKEXlPW8RQOQ2RXnqld6qoU2kd8qgx2QKZGK45VlU2Gm0vDu0OBKkHI/BIuhCwVtxf9o0z4M+d84keNW5zHtKBjA8TtSLdjjpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUGOaOuL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D67E1F00A3D;
	Fri, 22 May 2026 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452981;
	bh=3Oi/l6/G2+8157KS0fYrmVbRBuFCb2KUekmH3Df2YEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UUGOaOuLmB/iEALzjBJiW7D/1zu4rbPaTGOZWaC07O4xe3BYHcsqDp4TikahJUjIf
	 Rx6k7A/FSq6924usvc7E6SGLlZQ+7rp49o5NiYbDqLa1P35rXcVaCEkeVC6qVslzi0
	 GoSopdcYZeMPamIaIHFAGUINdby+o61P8UPOzU2/dTt9wS4QMxPVuCZjDEnefCBaje
	 TPFJc3GQe6aaZLo4rIx4QOdjJZLZws20tji+422lVN1mep/PJDneLK7MZefxqRHD9G
	 ol8+mBR+6IsUIFjRv1Q8zLlEWlG9HxMtfamjRfcjxeWaU6ROYLPopUZtuvcd282hYG
	 zBJws3ayJ05zQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:08 -0400
Subject: [PATCH v4 19/21] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-19-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Tm88PYbTKOzA1m6/RvOrfrf+njGW/yUDKwdnprgqAUo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwS8CsBjedkws2MRlmwps33Bvv2xUEEiqwb7
 Ge4tOsQktGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEgAKCRAADmhBGVaC
 FUevD/4zeaiqpESoQKvPVUR215ADzzcmCL2Ayf0nP4QQVNjk4I4/DfsLbw2dUWUyNMnIi1DVH7e
 zMzSaq2TZfKykrWxkImtTxZGKGtrQxJwQEoEizPQsh6DPbbYbJlOqqqbX2Ib8oXRhkPnUGC56Tq
 33YMcC+Z5mU+A++Js03rtv0SUJKmbJzuJjzV+o+H4R5q6QvDB37rPgt24rdShZb0Qf7C4kIAyeo
 5raFbhmJQo7J64izCtPWMOKl8ybfJ78JPoYx0ejeasy/WEdddvM1qbsBwt1/U+hgTJqxqABma4h
 XbPknfF6ge7f/mQ4SfsBRQ1ungbu/zFYrKDJywwoDA/QlrGvU3rboaY9FnUQQ2Nc8U9VSUEVrCV
 xFr/QnHOzkFxdATRpPI1zPOT2/KXhL1vdwYfbR6pDYSk6DactfeMyaJtHETLX7364rRHSJBfl0K
 z850qfXYxJSu5jAWMZlBsFn0BRVvtjizwin6LLRguXvVdT9c1q333m4OSlpu2B0uPG4szy/L9jl
 FQ/Inm2aFpOX34a2nhmcrEBdbjNORyP34bpbA8CeKMyjKlvonSTk2hWb7/kxeG9fpnvJF1nEM3g
 xA8hkwAZ6HycWUAzzirUDYT0K7b9+MdLANMIKhwOeN+KnLwXCzgsjmmXpfRpFBZ6SA3FCMME4fn
 mmBKFMkajtttxlA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21800-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D4F85B4D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the union of requested and supported child attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 ++
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 15 ++++++---------
 fs/nfsd/state.h     |  3 +++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 30f338f90acd..1eed8f23551d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2568,6 +2568,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0e7512046c63..90055edc633b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9816,6 +9816,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9885,6 +9900,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f8534288b2fc..4fe697bf34e7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4258,18 +4258,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
-		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
-	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
-		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
-		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[0] = dp->dl_child_attrs[0];
+	attrmask[1] = dp->dl_child_attrs[1];
 	attrmask[2] = 0;
 
-	if (setup_notify_fhandle(dentry, fi, nf, &args))
-		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+	if (!setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (args.stat.result_mask & STATX_BTIME)
-		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (!(args.stat.result_mask & STATX_BTIME))
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 56008234b700..461abcee9e6c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -284,6 +284,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_atime;
 	struct timespec64	dl_mtime;
 	struct timespec64	dl_ctime;
+
+	/* For dir delegations */
+	uint32_t		dl_child_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


