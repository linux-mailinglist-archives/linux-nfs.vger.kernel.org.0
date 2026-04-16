Return-Path: <linux-nfs+bounces-20880-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FsZBWwf4Wl0pQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20880-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:42:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068F413159
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEED3040197
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8953A5E64;
	Thu, 16 Apr 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuwELF/w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A13A16A6;
	Thu, 16 Apr 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360945; cv=none; b=ldm0BrSr/l9IEMgBP1jrOrlmpm3b7K2QDPdEi+3dcuf8OR5ZKOSNs+1yFG8Glu6mEcffjqDKstFAJcCzosRECVSYcUQpQQSPQPFLTQmQL4ww9M12PqLsDsnyp06cc/PzBhvqQe5KsKPDBsvgvzdw9tF2EAPbhSYweWwk0fQJeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360945; c=relaxed/simple;
	bh=8AWV9g9nNbAzIUfizkPyGOFE9nEceUpI/1oajrzco/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RljdcXix6EMNBHRUVpcL3Jn5eJFIBrOwQRvxStzY0HZSBRhp7kFWhWerrdjASQSgcN/xfBmv8MkXM2aDi2LILpmxpUZFth6wIpzQCtDkpEezB6matJFo89ynnbi1Gtib+77xkVycsB5q5kjqyeimspYfi5j77cwYtoYgAGqun+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuwELF/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3BC2BCC4;
	Thu, 16 Apr 2026 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360944;
	bh=8AWV9g9nNbAzIUfizkPyGOFE9nEceUpI/1oajrzco/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WuwELF/w4jzj0M1YVd5+EU40QttqzVgF5u2PdpluMLi/zTioBAw9Q7OqzDZ/pNlxA
	 anoKcndIwgv1HVT+fzwOOL/BrcoVupjEuxdos7x9/8n3zURW0g+ozddbrHUGst51bZ
	 U12Kx9/G1fv9Tf2Meun8dp83GtzT8WJEcyprzjjjVA2iKRqfZviD1uyHmrqK2Gz9zU
	 /f3kJAXoDjRgcZHH+9WRrxELgXEbcZSJlHQ8u4KD9DgVvQc44eOuF8960u5B9i3pW9
	 rVPAfqlJ/VQOKVUW8o1fzdHly6WRyLJmq6W2zf702Y7lfp2C68UjVqZ0+vq+Cyyv30
	 cBS+vBRu2U0Mg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:09 -0700
Subject: [PATCH v2 08/28] nfsd: check fl_lmops in nfsd_breaker_owns_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-8-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8AWV9g9nNbAzIUfizkPyGOFE9nEceUpI/1oajrzco/8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3jEcvH35WurmxVY0AQR+jHLEXucAm4yURcQ
 arvpQtoGvCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4wAKCRAADmhBGVaC
 FWGhD/sG1pZ/4q2wwdvup665wVoNk9P8EfUUgBhNw6kbxPkeRlkDfiVor8r8Pn6Xn70hTGfvFEq
 gVTyFF+fUa3AZLB+o3OMsq68+rfHlKc/8A9rsa4D/C4NijoNFNNg9lFB8KeR5JbC+JAmBZ8H9KM
 YUeL6CCki24ZmQa/DfqmFP4zJXcEPr2c8Nzrm+4OsZMJunZSEOYsVCV6TU8WOPsCGVk+JMAQ2Vz
 FzIl92Ol8u/POcuREAQ5H6mc7PC388CB+SZp6Ah1U+edGrLhiroO7NtVDMfMpKOPU883NkdKBqg
 1RTpeD0u0C5cEmSlrnwcjEP9jQfdsRTMtWChbbdh64EDKe/XHCyltxrlWqPyg+wkr6FHSvrQYn+
 NmB5B3YczoETui2MCD7FGQB4cPLJqwcHcQTF9/3yqy8xnIGXjs7U0exW+pScENRzeBGLZsGJ+n0
 tnfupU1l7iiQugWsAbKql2EwiMc6RO0wcVi0alSkRAuPRV3yeDhjD8e7HNXSEXuo8LAFLTnYYTz
 ww0bnbceXovnaBBQeJIjxU1PMu/bC1QL8MqbEG+bIrsOp8YFQprP5FqoSZW8LCJb8rVge0756lU
 DgpEqSQfbsyL3G8jlZj3EBxg2ZBMh+wqkqw+Q/eFbBHyJ6EfZb722g9vD7epGeIkYUyRpCVO8Ha
 DPr5CKzt6RVzaHw==
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
	TAGGED_FROM(0.00)[bounces-20880-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 5068F413159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Any lease created by nfsd will have its fl_lmops set to
nfsd_lease_mng_ops. Do a quick check for that first when testing whether
the lease breaker owns the lease.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c75d3940188c..35f5c098717e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -91,6 +91,8 @@ static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_stat
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
 
+static const struct lease_manager_operations nfsd_lease_mng_ops;
+
 /* Locking: */
 
 enum nfsd4_st_mutex_lock_subclass {
@@ -5655,6 +5657,10 @@ static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	/* Only nfsd leases */
+	if (fl->fl_lmops != &nfsd_lease_mng_ops)
+		return false;
+
 	rqst = nfsd_current_rqst();
 	if (!nfsd_v4client(rqst))
 		return false;

-- 
2.53.0


