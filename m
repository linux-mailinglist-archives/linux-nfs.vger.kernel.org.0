Return-Path: <linux-nfs+bounces-19011-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMerC1XnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19011-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B311915158C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78FF7307E0B9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AE313E0F;
	Tue, 17 Feb 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYxNPnKT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D657313525
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366069; cv=none; b=R/3gnmCX90fzqa2lKdI85TdPUF7qObMgX2djZKGo2ZswWhvD6jh2/wAUS1MBcVOXARAqSCYPiG6H2FpZn2qeQPRYHVC5NSntNl4bgTeof1j0wsbNSUGDN8I+DCGrFRdqnf7z+c2MhT6unR9uMhX5Tl04QzVTv9pOleEb9sF3CP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366069; c=relaxed/simple;
	bh=lLMmtPwkMLyBLnVC89hvp0mtU2KF0XEECLc51/H67dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWl5WLIz6Ld4+T5cMSf2t3sAWdRwd+CIIOO9gKgV5clCw98yqOKbBkka7zFgjgyDwlxi4aHIsgC45rT0go1Qbi/8XMu0iK30OzEpRV2EtjzNj/b3OFfXO0togFaJRWeNS/wbBRI62GnZwwofon4+AbjOHnCoe9CgPVUm9RlrXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYxNPnKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696D0C4CEF7;
	Tue, 17 Feb 2026 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366069;
	bh=lLMmtPwkMLyBLnVC89hvp0mtU2KF0XEECLc51/H67dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYxNPnKTSnX3AJgzQ1/jwKkEDmMHehABEqvwNrEOPTy/Gwl4DP449pe/PdFnDmrZw
	 BPot0gf/ldcFxMOBIHe9BVCvw4jJMGOfyihIrvbMqd2eiLwDVspt+1eJ7QzQIi5sRo
	 GR98WeWQYZwG0VHIk0wkJDSwnAZOaiMuba/Dh2ozyyEbGQGowgxcvwy4tAu+NwKikP
	 c9oWbM573fxPOeJCLx4CVUoRE7LBOO+GPEvZMKHi/m79XYQQY8vf182JyKuPehNMwq
	 FsFYAerXJNzkdD+2/LeE9ndSf3v37UizxTErnGEoWvCbT0NLdyXlJbqKUMjDCzC5T1
	 5h2Ve+0KJ57TA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 28/29] lockd: Remove C macros that are no longer used
Date: Tue, 17 Feb 2026 17:07:20 -0500
Message-ID: <20260217220721.1928847-29-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19011-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B311915158C
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The conversion of all NLMv4 procedures to xdrgen-generated
XDR functions is complete. The hand-rolled XDR size
calculation macros (Ck, No, St, Rg) and the nlm_void
structure definition served only the older implementations
and are now unused.

Also removes NLMDBG_FACILITY, which was set to the client
debug flag in server-side code but never referenced, and
corrects a comment to specify "NLMv4 Server procedures".

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index ce340ea0d304..4044459b7c49 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -26,8 +26,6 @@
 #include "nlm4xdr_gen.h"
 #include "xdr4.h"
 
-#define NLMDBG_FACILITY		NLMDBG_CLIENT
-
 /*
  * Wrapper structures combine xdrgen types with legacy nlm_lock.
  * The xdrgen field must be first so the structure can be cast
@@ -1152,16 +1150,9 @@ static __be32 nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 
 
 /*
- * NLM Server procedures.
+ * NLMv4 Server procedures.
  */
 
-struct nlm_void			{ int dummy; };
-
-#define	Ck	(1+XDR_QUADLEN(NLM_MAXCOOKIELEN))	/* cookie */
-#define	No	(1+1024/4)				/* netobj */
-#define	St	1					/* status */
-#define	Rg	4					/* range (offset + length) */
-
 static const struct svc_procedure nlm4svc_procedures[24] = {
 	[NLMPROC4_NULL] = {
 		.pc_func	= nlm4svc_proc_null,
-- 
2.53.0


