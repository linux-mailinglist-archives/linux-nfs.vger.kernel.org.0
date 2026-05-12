Return-Path: <linux-nfs+bounces-21576-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INXkNEJuA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21576-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA1527274
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E736306D5D9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1C3815F7;
	Tue, 12 May 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSbqnUT4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E10370D71
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609671; cv=none; b=um1TxKrhUlea9WeeBF6GqvE3cs9izaQTv0Sgpc72Bkd96qKSzpksfMIfJdqA+BUuT6UeaEXnxRG5pxyobrzB3HqZrsk6rJw8haAtxU64nLyq8c1PJqszoVn/RBAq1TsFPlVvtsKToVS9vJIXP3q0NdDxpvz8BLTnpvlJ+qeHf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609671; c=relaxed/simple;
	bh=u0l2grwgfRkSmOVhlHjaHuuwDqAYfH9q2JtoDc0QxUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvRTMunPVherrW2WqB8F2elpAj56ba2KhRSeh3PG58jBj62jJP5kgytQ+P3YyiLE8FxaMetuF5uNFVcHxPq2nY+Ohd+MMH3dIY0gq+hU8sofAQhTgGJ4m1lhjJjCGQrbazxtpGGWX870sXaFSPRV5P/eFWjcLJ/q6nBbWXV6emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSbqnUT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C0CC2BCB0;
	Tue, 12 May 2026 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609671;
	bh=u0l2grwgfRkSmOVhlHjaHuuwDqAYfH9q2JtoDc0QxUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VSbqnUT4QiC3YX83JgU0HAlna4s6YaLm9SwEoZcnaq3NVjBe+mcww8xC6aiZKx+ZJ
	 j3ALiM0baBreQmuS1nPQHHGke6JJMt0b9rmC0A21DP/UmdChBM0uLGDkQ/O7u5PfPV
	 JomBVNqGwhcfwJ04sFpvwpU/b13gvpj55cbgm6Pn3PIKMbB2z8HVhy0GOfBtvn4wGY
	 xruAlnF88RZpR+JUHvkIhu7DpaHdfrXY/E91tN3affwbMRQYwTbOzBpKkCz4ZfgqWF
	 vdUWRxF+W9ztX4KiS/dO3bzAyQlgkpUIEmez9i5Tb2iuhI4wjRCySoeylupgT7QQ2h
	 U3RTmz0lSUEXQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:11 -0400
Subject: [PATCH 36/38] lockd: Remove C macros that are no longer used
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-36-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=1DAPpnnGt5hjRNrHj6YqY9Bhf3uhOqqMnvWvILvqvSY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23nFkMSECcBwo/QaAsQl2XI3i5U55E3Rvb6s
 2FchshhD5mJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5wAKCRAzarMzb2Z/
 l2fcEAC1OWrrUrb3mUdYBpSxuKKdrRXOuzlqRfAf3yjOVLqZjB5Ryha+592i11oBeilZOy2Apcb
 sVIoR9kBRHT/+wvmz1H08IXtnTF40VBpbsUq6+XI8Jnk/oD7IvCQD18pyjAxCrigmBEx/tM18nh
 5yKW52x3ZxKGM3LyAQx2TOhboTB17Fa2ja1cL17n0A0tMF+lmky4bjYKA3bdRpMaidH6MEN7BxV
 7avWChvDICjTIU09gIpryU0Pbpkw3n33bBetu2Qo8hmKrou3TYLnsnndDWCaWvjHsIKeXJW7204
 GpCdRh2eTe4mJhhwoSulObNGmQZa+A9GalIKYogKJ4etA1H30c6wbBvOoDqG16kmdBihS6YVGlS
 1uSeiiIe8dv4vgFOgG5FGlLTETaFGnByusKq+UOS7xH0qKujbbPCVA+8tGqqWnQVQ3fgo3TCbUq
 aos+TW4lOeYYxbwpVfF4Odt3fVMFu+7P6acnopNJ1iM/1X/zTsAHMqjeW4CR4RhloWCTOREkjOV
 8jvAwp9v64Sx3xEY6zL1wh+JMGLi58aBMdpJ86wetsAsyXWWWHOT5zd9WveZpYu/vdAsJOWwjza
 I2DqGLD/xW2/IRTtTwdd4M4YmeRDMOYDrrFkFlvQ299+r9Bb7dwHngxvBZgwQPrQQfIVjwBwCud
 YQaTWLnd+Aw/n0w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: AACA1527274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21576-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The conversion of all NLMv3 procedures to xdrgen-generated
XDR functions is complete. The hand-rolled XDR size
calculation macros (Ck, No, St, Rg) and the nlm_void
structure definition served only the older implementations
and are now unused.

Also removes NLMDBG_FACILITY, which was set to the client
debug flag in server-side code but never referenced, and
corrects a comment to specify "NLMv3 Server procedures".

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index ef1ae701b43b..f62b0b39c5e9 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -24,8 +24,6 @@
 #include "share.h"
 #include "nlm3xdr_gen.h"
 
-#define NLMDBG_FACILITY		NLMDBG_CLIENT
-
 /*
  * Size of an NFSv2 file handle, in bytes, which is 32.
  * Defined locally to avoid including uapi/linux/nfs2.h.
@@ -1188,16 +1186,9 @@ static __be32 nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 }
 
 /*
- * NLM Server procedures.
+ * NLMv3 Server procedures.
  */
 
-struct nlm_void			{ int dummy; };
-
-#define	Ck	(1+XDR_QUADLEN(NLM_MAXCOOKIELEN))	/* cookie */
-#define	St	1				/* status */
-#define	No	(1+1024/4)			/* Net Obj */
-#define	Rg	2				/* range - offset + size */
-
 static const struct svc_procedure nlmsvc_procedures[24] = {
 	[NLM_NULL] = {
 		.pc_func	= nlmsvc_proc_null,

-- 
2.54.0


