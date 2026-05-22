Return-Path: <linux-nfs+bounces-21798-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVuOv5OEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21798-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:41:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 906335B4496
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66CC03075C5C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C723A984F;
	Fri, 22 May 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+KYX0Q1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C1390C9F;
	Fri, 22 May 2026 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452979; cv=none; b=nSNXklahxec2xZZo5zokciAsn3bZNkYXkCo9q+un10G8wR2bZs4aEAdtqJRK5v5dzK1/9aQNycDTp6Gj/mnYj4rgP+D4T0RW3xlIhjtYYaAeYaW1oBAd9ikUk3wVuyarPySsnec3LJbs/jQfinaIue981JZZ1JdxyNscoiVt7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452979; c=relaxed/simple;
	bh=S54+rM2MVj7+wJMZyyeIWuif9qM1/ds9J+LGy3XQ7rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ahr5/jS00pKP5zttmydyDG1luC8bhe++cA4wmdU06/ZtEpswis6znxPbnoSlEeeJ1K617+f+UrukoUCTni6QnMkB+D7WugJCXzD6F96XZYZluf7c14BYRO3uZa8DoUENtzzy19F+Klih0jM91JyEZfNpU/1/ZtHP5pQm12mM5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+KYX0Q1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC7E1F00A3D;
	Fri, 22 May 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452978;
	bh=jr45dfm3eg1LVF54YsyaZn/ElrojpeyWCBSxVhPwhqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O+KYX0Q1qvMSjzPT9QSV4eMMc17djLQ5xgCKI7LJIn9c9jhByIw4gSTfzcekSlSTe
	 ZZcl51mb8EfLL+essRve13ypFCFNEzFfUzR8S1NX41OJcK0pkTZL2dEVntkSGTJbR1
	 +767kJefV25kQNFDlCR0/3+5lY4niyAjS0H3NS49uzRrkly8XAtuE2oX2lprOn/47o
	 s76PnMeg4enjt2MNAnuGaDGLO4Ds/o33dGaVy9d4/ZbmYOFjolWxoEbqt6F87i8BEo
	 pLReZdFK0N59vLjUK556nbUwhmdi3EOC33RxFKU0kJ7DEAWc9pqvfn4svYEzIwZ6b0
	 JSfpkZPirD4Sg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:06 -0400
Subject: [PATCH v4 17/21] nfsd: add a fi_connectable flag to struct
 nfs4_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-17-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=S54+rM2MVj7+wJMZyyeIWuif9qM1/ds9J+LGy3XQ7rA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwS132hE/a2nn3fji0wPuiTkk/b4LusByI7M
 U99c5M+WWWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEgAKCRAADmhBGVaC
 FSHND/wK65W43OA8yudK/QDGEGTrvGiz4AxKLBhRR+1WxzIsLB1iacvvz0zTupEB+1U4s+dIvmp
 g1aavgj+8X0PCPvbgOUjbnr39b582AyHQAH4MshKMxnp8xdIoEQLxbw34kXSGxl67lmYvyFPuit
 KPBTUDY5ccm3IyUaoCYGhphsEa11/ZeJYUWeelTGGZfAWA7Ept5NdcZDTZmVVtr7f3xPIWjcnY9
 jYZ9MARh2W7QvxS/Z7nc3D0h6hT/EuwwljkEY+cq+QMJhaMzEe7QhHxc+LjclIHy0Ge4NhgqWom
 CLRtxUC2r0ex0aSVwanhACEx4K0mxjtzxtPzs7zt6iBO309Fj6r/qfnX0s5aARYCEjwI6JAAlwJ
 RlUI/FnKZEqa1SzZbsMtbM6MoPJRU66fQ7cevon7PrIEUHJlqUMOp9+zvP269zKSeawLjijBWSI
 FyOquqF0UcKq7s+hPsTvhQrr2xakZrdXe/XXOzMUAO3qSFBfKP308cdS3oONd/gZ6+X/DVqM6p4
 v8RnGWKXaMiTjH3MZuCs8vkBsXDj8si5fP6kicvgEIImF/qIfFbbwTqX0XJeEFelpdDxbXfot6E
 i/CG4aiMuAQwtq65sgo0cuaXiqQvmGP4g12YxLUpl2An7wfyXvNPQzWqCuUxrvtRXfP4FEGNcbB
 2EMtAQXywZ7Uw2w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21798-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 906335B4496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When encoding a filehandle for a CB_NOTIFY, there is no svc_export
available, but the server needs to know whether to encode a connectable
filehandle. Add a flag to the nfs4_file that tells whether the
svc_export under which a directory delegation was acquired has subtree
checking enabled, in which case it needs connectable filehandles.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/state.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8d73203297e5..0e7512046c63 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5175,6 +5175,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	memset(fp->fi_access, 0, sizeof(fp->fi_access));
 	fp->fi_aliased = false;
 	fp->fi_inode = d_inode(fh->fh_dentry);
+	fp->fi_connectable = !(fh->fh_export->ex_flags & NFSEXP_NOSUBTREECHECK);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e85cce4f8bc5..56008234b700 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -747,6 +747,7 @@ struct nfs4_file {
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
+	bool			fi_connectable;
 #ifdef CONFIG_NFSD_PNFS
 	struct list_head	fi_lo_states;
 	atomic_t		fi_lo_recalls;

-- 
2.54.0


