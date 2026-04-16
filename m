Return-Path: <linux-nfs+bounces-20899-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO4LIWQg4WmapQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20899-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:46:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C80413389
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74E5316846A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6C3EE1E2;
	Thu, 16 Apr 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFKhD1xM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6E3EE1D1;
	Thu, 16 Apr 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360958; cv=none; b=CsaQhcXg61KT9n8sV6c+haK4PcdjC620OoYe6x2R5oLO6yBYGRBx6DPZejlPBedB3H264lZ88TwnBV10kni9VIiZplql6Nx+XCnzNWGIKHjm+y8xMivzdLatwhkN3VS+cM3u9A8ua6qq06wtCA6PUBhr5wJk/UJondXFM/5wsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360958; c=relaxed/simple;
	bh=ZicZK29vRjXVJniDOXihUcGQ+pKGYbnMNExhHc/VLz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3tsk7d+HFo3pMSyhTXX7MNoYAOvQTPMb5c0vgvc95Qe7uQQ2g/PmvQcWiP/Or6fLlH/8VhhUOuYeNSQBoslmdfa/Nr17aLnqc4JdX9nU/o2UJThxUW2Vj/9P6vE7rnUFAGoq1unHMs4xPHGm127umKoH/RtpcQ7Qs8q3AJ/2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFKhD1xM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C11C2BCB4;
	Thu, 16 Apr 2026 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360958;
	bh=ZicZK29vRjXVJniDOXihUcGQ+pKGYbnMNExhHc/VLz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GFKhD1xMass3Nz4lwvO0JSV5qtTti2LnflecGQZoGfR3qYhLn3iQUYrbNGl7DdFm+
	 l6rwgihLSMj7hIpXnvu9i56DmIrEjrYvrpRxo1eOQ1CeojtLH7ZMbZ7q/fgKy1kr82
	 m+/WY7vmvNeiyOsVOizUH2zuVCEclX2z4zWsgrQ+vGvq8v25Zwi0RJGJmJBraA2N3D
	 rO7wywRDgQf3RbSojn/PztOxVXNLr4BEwIYqscfT3QCQaPWnBH5/8UUOyux6neHFhU
	 bxqZC5aN+y7hb/Rh65EnWQj1YoVde4nxiSwNcrk30ou8Qsvv8hAq6uscZuOHNn5kZP
	 uCGBBNSTzF+Cg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:27 -0700
Subject: [PATCH v2 26/28] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-26-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZicZK29vRjXVJniDOXihUcGQ+pKGYbnMNExhHc/VLz0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3omiuxOL+Nl+Tp4LGmmMe7LYWqbf5XuLHfW
 LB9NPaM+AKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd6AAKCRAADmhBGVaC
 FTWPEACC6gobv1pGZf8CKd/MPlTSU8fPUfqq5kQ2eo4yscp3peVXzXKNOq7aQrJAJzaDkqy46Ec
 OQtOe89pxbdhsqCWRodo/GXkarCkDLwWopEOCA/MgOqb16vFeo8Qk8CzBc7mlHA2vQuYRiI6Smu
 c8hdptVMSI5FxPB/z93VlIhrT6SvFFXUXvnBO4ZiPHTnJxQWUXzkbM51fpdEsXR/rLMUW8Z3Av8
 whtslb9vbUohlselj6Mikx2gIncW+R8VPe8IAE5+Uv5l5c8NKTyVZjmZljk5eAX60+JJJ8FpsIm
 2BRUenU7VTYzXiBWosvJvtFqPnVBU2BEzr6O4ThKih2uVDhgu7r4rzYcxqcQ4KPEFFDVqwDuttj
 DxE1mJNlKZov8U6RPSRoy/TLSjFCA+hvDDFLqiUp8GIxlEuYz3/ZRmhfLDeaPSx/Xs9kA1xhw8T
 8u4LoYAuiTVvnrcU7HTpxBrorjjYTW1GLFptOpQ1tUHCQvGLB/UY3Cex3RMp7jmvcE+a+1ijT23
 dGQmVZTB7/BwV1xMAgNc+AmCH5ynh/7Bt8cDHvVU41xMzP4M15+FfSAIH/GekIEbS5ZabvHOE1A
 VrxCAX192kR/vBsxDYkxO+cD3RqHCEqSxby0ENKCZvWdzKlqYRhL/gmfUEu8d4UdRCk3dFSH6OF
 f2cAKQS77SrwM6Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20899-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28C80413389
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
index 01e3bf9e1839..a807a55dddf9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2553,6 +2553,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5f848c9910b8..28e34f6c95e7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9807,6 +9807,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9876,6 +9891,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5d7d8545c904..bd1142590d2b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4183,18 +4183,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
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
index caa3f5f78dc1..cb1ac3248fe8 100644
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
2.53.0


