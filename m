Return-Path: <linux-nfs+bounces-20707-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCFMGlYH1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20707-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:32:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF35E3AF2D8
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D1E31082E0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3C3C063A;
	Tue,  7 Apr 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZKMb0ZT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D43B9DA0;
	Tue,  7 Apr 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568189; cv=none; b=mgilj/edZdQjiJJbz8231yaGsFGrtksfdpnWw0F39YR5AX/+72zkm9LS/zZnehX0qdQSS8gqJZ7Sg09G2uKnMdCxNi4gGIag95S5fmI9YBUrpK2hS58c0qA04sEnodOOXspL8u/DgTH7tC8UXUmRW9FeEeF/ig7s+PXXG2mJCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568189; c=relaxed/simple;
	bh=Y0Ef697EebMArSFW6C9jXtnQz6TfSRIm7o8BBtDPbqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ph2eBkBAysZwCWEL8LcZYbgV5x5uRF9E6u5nEwFR7os7Csoyy2Su60UQMXpD8//zySWlmo75FNUA9ZtdJnIMzK0acSuyqRYv9UZN1QQ4L2hnHXjFiCGmdRWIzO1BqigHwavN/3AOZSDmjbl9xKKahFjqCCv/TF33a0VVFV+/RNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZKMb0ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DEFC116C6;
	Tue,  7 Apr 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568188;
	bh=Y0Ef697EebMArSFW6C9jXtnQz6TfSRIm7o8BBtDPbqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JZKMb0ZT1lxUK9RReDgR+zSHSo8T6JrDaWovM767kRny4IR5nedb8RyG4qWqX6cZJ
	 lsfHA9rcjLIorMhOIUaASgcncpJZcMojYdLfYsrzn8VFlAnaMqbTwRTbQ55totJ1s1
	 HnKK4eyvxpmb56L5QqVsXA59uW4MH5o6FildwOBGw8NFBKp2wxQFAlyU888HJYXEws
	 qHs5v5PSH0TePmsbayEAOvvFWF+nX19pmFEM2qn9v9sre1TwlBoyma+jdPyP447NrK
	 KuyYAi2ymz87VTFh5E2h4vTsOHjrl07D6aVNQBfn9mC2ddZIAwD0CUfnoMvDg65qjT
	 hP0aHTeM+zg2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:33 -0400
Subject: [PATCH 20/24] nfsd: add a fi_connectable flag to struct nfs4_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-20-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y0Ef697EebMArSFW6C9jXtnQz6TfSRIm7o8BBtDPbqs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUJlVa6uz/6jZzGHdhCAxoqZn7jrQXeOIZwo
 EbF4XMk1GOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCQAKCRAADmhBGVaC
 FfSpEACZO8IC6XlzaFXCwcCrToIw+1ZatZ2KksLX+NJ5g3kDJEWjOBDnkMwvMDdb1z4pwllRmBj
 6rHn322rvA53o9ggGbRS956G04JE5J8UJvdxXBkXQS6lINlkq7c6Nc4CEzIjpKG77j5Nhrfp95q
 PhH4vSsVBhGZvAhm3lk5668GZSvawfzLxvx9SucPZNEaOcYCHmTOz3InY8rwDAlTvAQd0a6ZVWZ
 YlsBMvhNE8VJzRQi2LAvGlqb8Xk+k8A6iiyTlv0fTHsEDxFZ0erJAbioVx67d+6Vlf3DgtVTs44
 8EgyX8oYcJR2Oz+QqW0U7RuMBcUfQMandQYWLz3LzrBQMFex4TNvfSYBNnxWibtZhpZKbx5GhTM
 UngvYMxv03kG8cGU9IFqTgBtPEJdHi4QvldnbgOs4MbhjDZ1qpwHXeJhLaqdZK7DNX9oET+ATSM
 0IyD3Mgq5hOTUr3AtxtRCrqvUZZvSqoRp4vmLJlLu0rixTrAMvFHqNzzMAa3Ids5T8lis4OxzwY
 GHN8saTOdDkNFzC28Ke0HO/6yiSzio01weIJUFw/sxnJa1t9aWnkgoIgTkVb0W/6SusM21sl1w3
 6I4sM0Bucv1fpcziNZFSepT61FsllqpERbsm7wFT9GTL056Jobgg3UPwxS5VTamE1el+8ecGOdw
 kG9UFATVP856O0w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20707-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF35E3AF2D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When encoding a filehandle for a CB_NOTIFY, there is no svc_export
available, but the server needs to know whether to encode a connectable
filehandle. Add a flag to the nfs4_file that tells whether the
svc_export under which a directory delegation was acquired requires
connectable filehandles.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/state.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f3bf572b0ada..0580c935d804 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5153,6 +5153,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	memset(fp->fi_access, 0, sizeof(fp->fi_access));
 	fp->fi_aliased = false;
 	fp->fi_inode = d_inode(fh->fh_dentry);
+	fp->fi_connectable = fh->fh_export->ex_flags & EXPORT_FH_CONNECTABLE;
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index dbeacbb7a5c8..d060d70c5820 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -745,6 +745,7 @@ struct nfs4_file {
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;
 	bool			fi_had_conflict;
+	bool			fi_connectable;
 #ifdef CONFIG_NFSD_PNFS
 	struct list_head	fi_lo_states;
 	atomic_t		fi_lo_recalls;

-- 
2.53.0


