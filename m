Return-Path: <linux-nfs+bounces-22487-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5IQrDSj4Kmrd0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22487-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C94674447
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M2HJXm5I;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22487-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22487-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506283516B1F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A94D2EFF;
	Thu, 11 Jun 2026 17:51:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05C4CA278;
	Thu, 11 Jun 2026 17:50:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200262; cv=none; b=JL3eaNJy30NHUkp2KVm24kHlKa+vAbkv3mZ4q6YURqoxWjLTUJkwjIEFfHLiznKmrnhswv2Ho0EqTjMGZNCtjIF2+8uY5mmTZ+pB5qzhwCJbQzycpjh4uA1U320sXS9741uJ8o35jDi9/L91NhwJ+Y0FKrwE1qYZoGVGI6AYRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200262; c=relaxed/simple;
	bh=zENUhpmGv6filpPQyCMmrVOTjgbRQ6h8VQJDPTFsxds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGA5JXMg8CPQimJlEjJA9RNhULIm5Uq7ks8AWg2qvJsmxXTQFGv6VnIkJ+gQfOmkQ0b/pq9a3SaAkmwGQRMXaNsWZ+e8szjxa1cczKR41EuAsO4UtAQHEA1Ru1dLzKi4z22f6LIlh0qvOc08iSNvXh/Tq6dOeJbu2iwN4cDhUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2HJXm5I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FC81F00893;
	Thu, 11 Jun 2026 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200258;
	bh=EuZLlasoB6D5tya16pZbWZnz9fzJc6QTjGJBD4ZHycE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M2HJXm5Immue4QBiKuDAcZDCcycMrySN62KNeZUg1xxPrNbJcjZ2swfdRHQlBtB8Z
	 klKrnZK+h35Oi3qBM4hROUh/gWgKVCM0xjI/S+Ji0xFRpjxW17ZyPtoS4E3YQtDB8v
	 zCRgDOGv91LQCVoPtnJjFa4LCfRW5NGShWHRC3enxOZJbp05z4wCKdzhCCQPw8DsLu
	 iPVX286sSod5+OkkOakp2AnuiMLZg2lyhQhgeJZYjacEZWjlmCs08lxzLAWUTs3Sr3
	 pnXtrlb+Lxe49nANwTk7pxeh1Qsj9XzZoR75bt21FYKAYBxMz484VViCayTlybyfff
	 +syIffe7LT62w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:20 -0400
Subject: [PATCH v6 14/20] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-14-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zENUhpmGv6filpPQyCMmrVOTjgbRQ6h8VQJDPTFsxds=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVjp2Ofx8TBaAmcZfa2RvIBKUKv9yUPBxD0m
 ztuiJnGNTSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1YwAKCRAADmhBGVaC
 FWUgD/9RXPQMR2Ki/viK5ZPJNQrNK7C3S/6VHwcWw1W4u9n1IHZOcd/pmTKyKcp9qfb7pX7EHAN
 CIB41pzJ1TWvimgzrhVUHkcPesOWOLYNUUZhaz/Zj7wOuNkbzfmhysxD6s65vdIsQ8ESvNLAeZl
 B8t5UOHBghApny4I1Em6etlYnliswBxhJBuNtcFAUe9Q3Ii57grq3ZxuM+6/Rx/aKJPnbIs+YAH
 jUuBWNOhQWZ7Jon9jr6tAVhLoW8xXsl8CM4mG+7oCClsSHUu8JSWT4843Zep1+YZfJYqOnF13ny
 lyBPjTNnKQ0+onJX8DRkQzAaBsH9JPRDmmJpMMVW4vtGD0JhTXWU5c2CeSibWrx3LLs0PUfbBEB
 RlokBftP49t4lixT8cJeXo1OLP2LFuZ1AAcELHdPcdVmD3S6r4vLPcYjX6i2wUvVzb/i182hfTW
 ptg4iD1tammoQI4YaFOm1geV5P9O8IjFFxna+e3cm8NQbX0CmP6sZqj5IjR4HMuOOc4IYvwpUzx
 NETdgBZyDTe08pZHTmHj+WrK/8s7D/AlYg8G+J+cgjsAJhiyQCfT383TNFjy6iE8AbnOKov1Loy
 4evEbmD9GfFsEhCBr3snStRpRvM2ax7/O6ZzkUE4nJH5JEvoYzEsoNX0eMSMsOSpy0/oTY2/kML
 zeHUkUuFflK9PuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22487-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0C94674447

In addition to the filename, send attributes about the inode in a
CB_NOTIFY event. This patch just adds a the basic inode information that
can be acquired via GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 18adab1d7ca2..4fb61d05a4a7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4191,12 +4191,21 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -4207,6 +4216,41 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
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


