Return-Path: <linux-nfs+bounces-21234-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMlBNlBf8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21234-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:18:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4647EA9A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29393074A11
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FB3B634C;
	Tue, 28 Apr 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXD8wTtK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AED3A9612;
	Tue, 28 Apr 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360323; cv=none; b=bAppd4G3nwVOAN7eYbvGH9GxuvtrXyQmjq7XkUo86tGbdXwkFgcMGZ8/PU6D/Tc76HFOpVgLUGBJUeL5ApPadF8UUnHHoQZM+IdEjkSLQPj0HO4LPmtpc7xYc6Nlzp1lJKZXa+so05gjs6SA3ePr2UU870XpUV12m6RV6V1xaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360323; c=relaxed/simple;
	bh=3FB93IfyOh/XE3d3Bb9HPR6+nkrsaX/3QYQn7eFefzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVJcXKlESBBiKzFtXOhvYx8fKGaD378dkHRpi0o6a9J7zkPIMryq/S40clKnIm7voUz25ji+7JthcLbSP5ptdXFhJv17O2UIEX89FHLWcj7UER+Uo55BvAFgo1xSNsAuvP2Xjo8lKhiVzbENC6r1P1Mc+8A+r13DRO+oSsy03ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXD8wTtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D912EC2BCAF;
	Tue, 28 Apr 2026 07:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360323;
	bh=3FB93IfyOh/XE3d3Bb9HPR6+nkrsaX/3QYQn7eFefzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UXD8wTtKr6IlfOZ88wydQxraUHy4vxK2LsbAWZAOqYruyA0GlOgaysVRNUnNUL+IL
	 IXOpbk2aBf4O4kCo0JW6GFmOvpbD068yz6agUpJEHhaYzBuel3PjWAGP9frhGY/cIE
	 VLogA0AOV7MMaQ8XYZ8uJn/61iszZhP9u0n4o0PjTtncDAJXAnsPPEJElp/BiNTBcC
	 MsXbpu72l+NVVHiYuW3rXAlxMvLbBDSUOzQGihsK/m3kmo124rDU+yeN/lN5v6ZfmJ
	 CNFHO8NC8UA4UAz1uNAIhGzrpq5CDJ1hIl0Q+ahQxA6E188PazptjG/WiOZt3W6AU+
	 /4/T30TMXWzeg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:06 +0100
Subject: [PATCH v3 22/28] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-22-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3FB93IfyOh/XE3d3Bb9HPR6+nkrsaX/3QYQn7eFefzU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1TZbwHyKhDWNk4Gph/m2VKJAVfOhUE5NMuR
 6ggIlQUdsqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUwAKCRAADmhBGVaC
 FTDqD/9LNQ6bKTtQtkhypVOOgNI5y1tUJvodpYtO/3grikpp/CTAOiDOk+/VxI0N5/z67+o9oFq
 cK54/MOlN9OIuJffvRJyIqkDAiFqGuYPm57cffzondhwUbBzMvtjhffeXULO6xE7LnZ23SzavMf
 1ut7wDCl1KMQmpoRRMbK/0GCZ+fTmIwUeQGV9QY1jjTdpXO+eBmUPG+L/1yijQyUFBYqipfGNnR
 4HXWkHJnPQuLkVu2gpEX50wDGMzWuEnhDU+dM4QnsO/eQ60lPa+g/Aznr8gVrsvenYL4IOiov04
 WZp/ji+BSwloSvb0hsUAXL2R2w+5dW1w7O/T8i19zns3vAvJLAapiYvcNy7GDnOI8sEk+M8VM/D
 m6krvLZzjETb0pvCusMB2MsRWz+Dnq023lxT8LUV+BTZVccagMbBIjps5tUS7M9knXt/cbngVdB
 xNmBm7UVTd+38A3lF7PlpoLj3zm/6Vg8H7qWxCkky42VYdEs7Fe/BXIrGB065hOj7e3PLuRksC9
 0uUjHMl3D1lYhLjPbSA+eTZDVL+wR84OjpyO+uNdox9Msvdn9O+22f3A/vzLsLP3Idcgi7U8soa
 r83SzCGjWhlYVqTQZ3f3YHNVf7OhZxWyI9THzRjuGJczfpXzwj8M+NjjlArdpNr8Q9iXf/Ss8L6
 VkEDg6aMyy9yjEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 42E4647EA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21234-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In addition to the filename, send attributes about the inode in a
CB_NOTIFY event. This patch just adds a the basic inode information that
can be acquired via GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91681aea9d7f..f85581ebbd10 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4104,12 +4104,21 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+#define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
+				      STATX_BTIME	  | \
+				      STATX_CHANGE_COOKIE)
+
 static bool
 nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
+	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
+			      .dentry = dentry };
+	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
+	__be32 status;
+	int ret;
 
 	/* Reserve space for attrmask */
 	attrmask = xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
@@ -4120,6 +4129,41 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	/* FIXME: d_find_alias for inode ? */
+	if (!path.dentry || !d_inode(path.dentry))
+		goto noattrs;
+
+	/*
+	 * It is possible that the client was granted a delegation when a file
+	 * was created. Note that we don't issue a CB_GETATTR here since stale
+	 * attributes are presumably ok.
+	 */
+	ret = vfs_getattr(&path, &args.stat, CB_NOTIFY_STATX_REQUEST_MASK, AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		goto noattrs;
+
+	args.change_attr = nfsd4_change_attribute(&args.stat);
+
+	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
+		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
+	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
+		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
+		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[2] = 0;
+
+	if (args.stat.result_mask & STATX_BTIME)
+		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+
+	ne->ne_attrs.attrmask.count = 2;
+	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
+
+	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
+	if (status != nfs_ok)
+		goto noattrs;
+
+	ne->ne_attrs.attr_vals.len = (u8 *)xdr->p - ne->ne_attrs.attr_vals.data;
+	return true;
+noattrs:
 	attrmask[0] = 0;
 	attrmask[1] = 0;
 	attrmask[2] = 0;

-- 
2.54.0


