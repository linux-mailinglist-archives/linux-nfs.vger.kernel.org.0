Return-Path: <linux-nfs+bounces-20896-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGEcL3sh4WnMpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20896-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:50:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369E41350D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE47E31AE28F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE303ED5AD;
	Thu, 16 Apr 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekjJldo7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58B3ED132;
	Thu, 16 Apr 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360957; cv=none; b=HHsm4QtITCduwvXxEho3z/Q8lxwhGhpEOIFfsP18ltKnZ3uFxNxf4dcQRUREQedoQIkhB1Tok1yGv+HKbu/bYun75mZWJ0UCYzQqzkHEo05ptfmYL+OnCF4JRUJ9rqlgbPGW4GIMdbXbAH47dLdKoWDMxF35q3LRXC99WOafI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360957; c=relaxed/simple;
	bh=EIx5+PmQa2niFbtXwVrSxp2CGvAuqlFZetkw9RuwCWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUP9uS15FIFWFg8/a4HathBDDFLgxnbOD6OIYm+ChHvrruwJZnyViA0mgX+Vm9l4zAEyY2guteB1asOcd0LF52wqq87XVQvBQdaYvpu+WHCWqBcMu8WZupgahpwwrjmjtPWogCMnIy0jRqgdYjyZ47JLqJu9jSx0yU6Vmza5UkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekjJldo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5F5C2BCB5;
	Thu, 16 Apr 2026 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360957;
	bh=EIx5+PmQa2niFbtXwVrSxp2CGvAuqlFZetkw9RuwCWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ekjJldo7kvgM+y2NSiD/Q0r3eoz9Z827a0NuNLaqVi3oDJYFt48TvwYZPb9UzTJLL
	 hHPHxmedUPUF23kM44k9/mYZZlFkADOSpMxkcgu4H4zZbqBT/74m6nmcpWJ4Q6FKkc
	 oigioKU0PBJsjWXAgvI7vJ7kOYSqlDta2vhpFe8jzaOjTLYgNeVMG60UjU96iqHOUS
	 6h/qUlg1M9QpQOhKHLiCj/U6kQAPnpbafDbGCkxnsEfuZVfpAz8hrzCKT7viHlsQaK
	 U+GoKsTZFgexmQSz8LSvSBP2oD6U6v29u9cJuEBzhr7llVAvkoLdHQeeZSk8yamuW/
	 p6ZyMmFXQgsVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:25 -0700
Subject: [PATCH v2 24/28] nfsd: add a fi_connectable flag to struct
 nfs4_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-24-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EIx5+PmQa2niFbtXwVrSxp2CGvAuqlFZetkw9RuwCWs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3nfCp9rp6PaWVEKuLr6VaWBYljbpKRoWHpg
 2BqbxzGAlqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5wAKCRAADmhBGVaC
 FQtqD/9LSZse6DkbIZowTu2888+9PKTpj+TgsMSWg+qru2KnQpROYdkkWkvsXiFjE8FlewSTTEY
 vnfGkKJ8TUrY83HWZwThYZmVTFHhKf71fQSZ3bqkqfiD354GPGc1Yomwd5IRJuwbFlQ1plwSMcX
 s4uxdy+eyYG3aEAqhiRvCElRlNYW4tMmq3QzWzVAg6g1jEvDeG/aSyOyQYbpThWPBbZnJD89uvb
 MopCN8uii0Jtz0ZiUJlFNQ4itYN3kuJDKpheoyJHNIm0PNkTadi+jeWzDwuxf2bDapjj3jMGkyE
 qTcLTKHaVGKsQSrggoJ+8ToqrWT+/MIuIEbHn9RLtqtk6/xUPhSAb/BvPxF8BBdJ9+9Z60ZmNAX
 hKrD6endgrSt5YkERPz7Xifs5UHfgvVPBVXiaAs8LyWjcEEJOSykqJ4SjAWc2eILqlKzd6LMuTE
 0EHQrwQfPNuX3ZlIh6/q5B5gfakO5o/38k/JvHWWJgfU9ne2Cux1e2k9jCiLEjwyMhzOyUYAjXf
 z4iCtkgiCoqa70aoalkxhxIx16p8Lh+dun6U/a9apnqWV3/q6HzgJDo24Yrms3l2+43WO/s1Fyp
 Nr/NWO/6OATAFc3nSNbCk8anflIqVrhbWAEGsV9px+j7qp5B+y7PAVXKJBiTsTkximDk3S8e4mW
 WWR108oBuFGrFHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-20896-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 4369E41350D
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
index eba6da1072c0..5f848c9910b8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5166,6 +5166,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	memset(fp->fi_access, 0, sizeof(fp->fi_access));
 	fp->fi_aliased = false;
 	fp->fi_inode = d_inode(fh->fh_dentry);
+	fp->fi_connectable = !(fh->fh_export->ex_flags & NFSEXP_NOSUBTREECHECK);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 570d66fc8297..caa3f5f78dc1 100644
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
2.53.0


