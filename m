Return-Path: <linux-nfs+bounces-21832-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAB6I6WyEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21832-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:46:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2157D5B9984
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3839304DAD4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097437DAD5;
	Fri, 22 May 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSJ2viWm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146C38737A;
	Fri, 22 May 2026 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478990; cv=none; b=lFO0/ihtEfPI8RgVbpjB4iyNjcPE9X8p4rzKUHKh0lbk9fgNen2DuZCku/Q4HE9jSYGh898FbVtBTF2d/L0JEK1pNc7ikpAEqhQlsvay+VpJufvfQYfUl6ipKHgGmx6BDyjoQ/tq9pmPIF7+Pe5QHMZKQqT+h9ZVNZtfKnR96RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478990; c=relaxed/simple;
	bh=KtpHxWDfDdHjB8yg9KaoXFiwQCWhWzizamvNaqnAIjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqxzzFPLU8DS0w4eW3rzDnxRHQNGwstRw2RwcaSqb2xdF+ykoG8w1FEp9c/oOFb8K+s5yT76skGEWAPXAZWOXOXNK34FymFdPeptbBI98ldwiN154S1l6QyVUccYFt5rma/LMVwG1CemWbP6UwypMWLqvIRDZYXjnkUNGiZNzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSJ2viWm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ABA1F00ADF;
	Fri, 22 May 2026 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478983;
	bh=GXO6t0Kw2P03u5JqorR0nwll/zm6VVQnFtRlVoi4ApY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MSJ2viWmkCY8qiuDTC6zJ3WUMQl00zxO6AmXyck7f5/h3+ktXEmo10Hw+p4PPoMKF
	 KcpgU8D1GmzXfBOieKuHgzeceHVus0hCy7KwLoSvHtLy1jOF0WVbQUUueQMKlyRYG+
	 6u/zfsJdGSrJ/t7LC2/TuhejcBBWwzgUn+oV6woXG2UUFjdqpThuerJAIn/oHzsLeg
	 4JGKpup6/RxvSbU3N0B5rtMgrgJCFSe2rjj4kU6R4Z6ZkgSyDfhhKfACC3nxaJoWmT
	 rGdsqnVi2hiPH2+JMSg8ujCQWf8gNNS50BJvttIfaUTFmBWrNY/A2bmDZ0RXl4cMM+
	 p22N3lGMm+MYw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:22 -0400
Subject: [PATCH v5 17/21] nfsd: add a fi_connectable flag to struct
 nfs4_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-17-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KtpHxWDfDdHjB8yg9KaoXFiwQCWhWzizamvNaqnAIjw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGiTX7+aehkfOlex+4fvb/Og5XfaEs2qRN6E
 eamJk3CKrSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxogAKCRAADmhBGVaC
 FTZJD/0VhXEe6Hv5QHGaTWD6YUWs5UqMdlErsC7zVbRR+tUwc1VstYei0ZMuhujiCNIpPNqAJH4
 jz0ZKDwAwgQPL7pcwsh3KxPpmkZxDO2M7Ovp8DJp9o5XRu0Ugr1r5nsXY2hb5QwOKTv2PcIUQfa
 3+v8Eg7ZVznmQ40COcdBlEREgJlBAEKir2WwIqSANGwYOD4W2FFkQE9E3Av7r/iBfzK908efgw3
 owf7KTpu9bswIx0VrU/y/sHLEVBFe+0QI/MjL1lIhA3c6zLnQAvXdNAM7+LfD69vFpQQvO3dY4e
 gMS4a8rnDHwTcjXYQHldCOLObSRVCQyYT6dIV6RsuYjKuxfHdZgjoyGuTX0cl/HZ61XMb0oU3fI
 UgZ5xtqFtKbYubas6Czy8izu986wKCaoNCxopsklyp3/26TtW5S5IuOjMFYD5UPrvZ775Kim16F
 t69zIWDc+Ra7CrAO4JIPSaHtq01MiC8e01EZmc4miuCKb0/688Xx3689257HyGavwHWfjxHJPQs
 3nHeQ0y7wI/v3ZplYonMB6r7OWALm4/MCKnCe3Mc1qXY3v9nWq/lU6En66kflhd1QTkwnHfUWAg
 IuBIaUqbSmfq+oNH4VOcFPdRPtheMMAdrzgELa8pYqnmYF/CoZ1pf79RyLr2r7TE7ZosauqN2Ov
 WmJfM0g2OmNLmCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21832-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2157D5B9984
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
index e00b4463c89d..eed997d1c88f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5179,6 +5179,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
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


