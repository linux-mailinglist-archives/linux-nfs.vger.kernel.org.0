Return-Path: <linux-nfs+bounces-21236-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LaAI6tg8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21236-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:24:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87547EC5A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A47930D8062
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE83C061D;
	Tue, 28 Apr 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTkPXJls"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4183B7B68;
	Tue, 28 Apr 2026 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360333; cv=none; b=q2HcZEm4F28gHOqSYqpMT8ZqqlRxY6GQi7vDBLao5maAF+8KW0URIuwADdn7se7UVsiEzd/kJRBoMDOL3iSsEBRoA8r46fQssSxh56ani3pKQYNbv1JB9hA99sOBfR5hT97mHUUhgfWSdlbmxpxQRx1qa9FeyydGFK6xbbCv3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360333; c=relaxed/simple;
	bh=BmwaOojEgulUgvkQB2FtzNLN4OZvTiJYgZ4cG/A/lYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S502tcs+/YrmOqSdgOwpOAs9ffGZRV0ZCruHg/ZKqCXk9gLDEBMhEHLYUF5xrO47s+MEz4zzxk6nz7Ca9wmnTedqomcN+bvt/+LWrT7WfWgKI6uEa3ESlHABAGnVCS/oDIuUV0B1a1dzP8Jzzu4/q0nt1+MojL3CAwDhYRCHO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTkPXJls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73AC2BCB5;
	Tue, 28 Apr 2026 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360333;
	bh=BmwaOojEgulUgvkQB2FtzNLN4OZvTiJYgZ4cG/A/lYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YTkPXJlsEYp0fZJFhZHzkne/NWc5D2JmQ9vqfGgRgYlsaAppsJEoqlzUVbJpLJY17
	 cxdwSxURWoRpKdXAP28jsgFq+6sjJOe2WzYD5JIgz00o440HY7stNRcyZKQoL4SgDg
	 7h36CVAgJK1yaBtjBlLOlkl98TnJN4v2SB14u+harGRIeP/xaIUO8hqOsaefM6mrC6
	 3r2pNEHWL3WUeplFcBzinwb9oL2gcHStNkpo0HgoULFmXerVnFHbZuhy/7Vla2q0Oe
	 Nm6+9uuC+RGIIbt6F6h0MaA9oF/XPCtL3i4++KRnUKG9xzGBjljMqX6uIUF6bmq12a
	 nkD4YiyAolQ/g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:08 +0100
Subject: [PATCH v3 24/28] nfsd: add a fi_connectable flag to struct
 nfs4_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-24-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BmwaOojEgulUgvkQB2FtzNLN4OZvTiJYgZ4cG/A/lYs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1UYzTvpenu/Jo12jsGOoRihwUud8xyef7OB
 ekwcM9smHyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdVAAKCRAADmhBGVaC
 Fe89EACItI37Mrdh+sGu3jHLt3VA1e9nWx/BkoxrXT7Bmcgqky/o1YejxGuMwXoo68cbLc2edtu
 GWUXcN6CcCitCC8+RexodQl38h1jvxnwxnsYx7Crc3EE7CPRnRMrNtLyrXtOGkmCNG2CW3ahxx9
 51oKencnd4Tt+ZoVxgUzkLO0CPvPfuPWXXEgcBYw2KvdzlOJfYnJhuJXsg2G8RWGIuASKUc2dUg
 JsdbI2Z/biGnvs7MmYDvenGjm38GlolbUQjAzXlLC7kVNwjHZIXSB8qdmWXx15wmauz97GB2B2P
 xZklLGjTohegj9UOP4IsC/ev2Bh/AFy4KZTDB1xTuYStPwiFUt8fkvpcuvNX5XRSRZLjgTEoGrg
 gjDHwd5x5WDsPSrFlJ/zB1o7UUyk9eHzXT6Eu+3QXNXWyGLG+4Daa3fE1+KrxpU6vC8MhA664AU
 LMdbU3Qh3lQOnGbnmluxw5a6R1I4RGwOg4PBFyoTBzwvnNzl199HLsuCSEIXXcq+ILGIo4+tRzl
 qlNizR4y6Sj7Y1DMT7mxqIoMd06UskL7+Py+05bdvRq2jcY30ytVFRDTTcWQxWAAcvMtlh6U9BX
 TwfNSxzaL7PWSe/yfhMRDG4HsYRrp9S9YuTOsLmTq/AZ/ymEyC/Zsq8dEE45WXE1RjysVc8Xqx+
 tYjjVbWUiCh6/Hg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8A87547EC5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21236-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
index f00aba95753c..3050980a778c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5167,6 +5167,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
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
2.54.0


