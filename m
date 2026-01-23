Return-Path: <linux-nfs+bounces-18402-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFNbIAjEc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18402-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEB79DE0
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 789823052AF7
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1D26E6FA;
	Fri, 23 Jan 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx7FbWDS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5A248176
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194415; cv=none; b=L0+qmpjKeylpVXNjCU4F7wWRQupn+KytjqI656aZEsIBIM66yB1i65cFe+CZNJbdnx7A7u2u+/iddICR/ZNYofoEOGr+d0vJyf74LY+leIp7jhC0i7E5XonYWanNL21h1jwLjz/TMMurCey8l7FY93Ni9r2QNzDOceHz7kGjRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194415; c=relaxed/simple;
	bh=Ut9RTEHg5tij+7M8FNv8+F3LACCUf5YqYRey3k22TL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQjb/koSE7AYGuJ2RE2BLT0NhgJz3vJ9eQ4P6gVvvgN0GuW2exbRj9vw8vYh9QrYldzf9HajNbu80iMDjxzO+OmYoB/e8udDDTYeMwm6UTje7AQoDkA1/rbYfm81n2V4eJtCbv9+jDLTgb/yvL0sz2m/L6Fb2pWziGWbosqoD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx7FbWDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6BDC4CEF1;
	Fri, 23 Jan 2026 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194415;
	bh=Ut9RTEHg5tij+7M8FNv8+F3LACCUf5YqYRey3k22TL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx7FbWDS5SANyGaNpwkhjrCkOyWnRfIBxXVnvyMw85/QEAySbMswS92HUPYFBB0d7
	 Hn5LhI52CEcAVV2BgJ5TbWE3Gri48dWFln7iouKI4yxT6/Qep9Q/SeZPANg3vyTnDD
	 E+AzI4t9BEeRJm5CfXRXPdv5SlzMw4FuDr/A1nrnPf05NQI5gkSB7Q/klG9w5CAxg2
	 7l41DmJQeSPbhAzJnL7PfEuhU15xY8DE1Z4xjXnqrz88JI52w3vKte4f0vJGsqWZcn
	 98Tgt6/XYxXFgyyu3YOpgShXQjxUHoo3d+cwYVhrs0Yap6CTUxc5xATonahak0fPj/
	 pPGlVjYC1nWaw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 41/42] lockd: Remove C macros that are no longer used
Date: Fri, 23 Jan 2026 13:52:58 -0500
Message-ID: <20260123185259.1215767-42-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18402-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28AEB79DE0
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 3c50bd18c45a..178473fabc7f 100644
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
@@ -1149,16 +1147,9 @@ static __be32 nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 
 
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
2.52.0


