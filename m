Return-Path: <linux-nfs+bounces-18395-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mItYOPrDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18395-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D57479DA4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F5E93037F28
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980F23314B;
	Fri, 23 Jan 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZYWMSyE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857962BDC3E
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194410; cv=none; b=d0kN4FVqF0k3Q5NDXAGC2GzgAaXe73kYbmeT8CU2piQYWqDsP/OLHQuOkwpm4LgZyuiW78uyIP4pGlZO/C1mRkkevkh5RXKlx95017gcSmoq84ON8C57jeTMv+eKA/USaqFivzhBHXnne1GJ4a23FWTVXedt20muNFevRdrlEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194410; c=relaxed/simple;
	bh=czpIBSOPZB0aGrSqwCZh9S7IE+OuJe1leMil9hTbgxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESvF1hmSSfR+B24TwxpBxjnAZhfJQo2ZEWurIquhwqBu9AiRyTtKqdILh4rnkb1UqBLHe5owj9nO2cSmhYlS8JZnZ0RxVdb1rwQVnfVeDnSEYcngp9wovwlvlNcPCTg3XNAztb0fw/SKtF7eXPjhHgrjtic88re/KsNJmrptcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZYWMSyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80129C116D0;
	Fri, 23 Jan 2026 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194410;
	bh=czpIBSOPZB0aGrSqwCZh9S7IE+OuJe1leMil9hTbgxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZYWMSyEEsvrYjzvj7QayT6xkUUyFx+WgkkesB8GDLrt7O2yknM95++ByOR3FUvXS
	 wweHIvhZRqwcjNiJeERaHMlQ9ITuQTTOvHVQMHKk+xswZXw9HGDxw4iGQzC1Q/Nx4+
	 yh9RbAnEi9o6cd+vXyW+jZBJwq0gIdeG2rpXKjr3qxMD0MKA2pbIP0S+pI+bSulFK+
	 IVbavZapPicnNhYdzWXC0v/SIuLXcQAtakPQfJ1xFrSIPg+yPVvnNV1B98FsgMQOE4
	 YnlRTUXde0SyMgCQ3dLbY/7WRnUQwAn+Fdac17ggdtbbExtNBbjoFN4y7TegRLSiRK
	 cAznnokM/KDKg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 34/42] lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
Date: Fri, 23 Jan 2026 13:52:51 -0500
Message-ID: <20260123185259.1215767-35-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18395-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D57479DA4
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The xdrgen-generated XDR decoders cannot initialize the
file_lock structure because it is an internal kernel type,
not part of the wire protocol. To prepare for converting
SHARE and UNSHARE procedures to use xdrgen, the file_lock
initialization must be moved from nlm4svc_decode_shareargs()
into the procedure handlers themselves.

This change removes one more dependency on the "struct
nlm_lock::fl" field in fs/lockd/xdr4.c, allowing the XDR
decoder to focus solely on unmarshalling wire data.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 16 ++++++++++++----
 fs/lockd/xdr4.c     |  3 ---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index d8a5f662ab39..4667e4a1278f 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1040,6 +1040,7 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm_lock	*lock = &argp->lock;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -1054,14 +1055,17 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 	}
 
 	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
+	locks_init_lock(&lock->fl);
+	lock->svid = ~(u32)0;
+	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
+	if (resp->status)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
 	resp->status = nlmsvc_share_file(host, file, argp);
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_release_lockowner(lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
@@ -1075,6 +1079,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm_lock	*lock = &argp->lock;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -1089,14 +1094,17 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	}
 
 	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
+	locks_init_lock(&lock->fl);
+	lock->svid = ~(u32)0;
+	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
+	if (resp->status)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_unshare_file(host, file, argp);
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_release_lockowner(lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rpc_success;
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index dbbb2dfcb81b..308aac92a94e 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -257,9 +257,6 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
-	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32)0;
-
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-- 
2.52.0


