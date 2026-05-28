Return-Path: <linux-nfs+bounces-22045-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNQQIWqYGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22045-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E25F7251
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A860E3036CC5
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6094343896;
	Thu, 28 May 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEWwZ/5f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A632B128;
	Thu, 28 May 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996748; cv=none; b=qmj/GNpDqDTlJbrewof0PPrjp2FqP8litiXgp47eMx+k1F5jUswBdbx9zDYQ4+H87g+fWQtmr8GkK2eogDadtmM432ZtfmT9aVDabDIAP3prQ1HiQoyWki1pt7YbTQYMcr7hu1cjbryvMITKy6HmDh6/Qv7DnF7CVurkcqNtizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996748; c=relaxed/simple;
	bh=km0nl347wA6RTnqCzcQ6046kqA8W5j8in8OtroZbV/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjLlHSPqvYx5UOwD3qakNqrvJaoScFea6QVgLDGBKuHKhz7X7oljy9ZDJCO4Jpu/K75lEtdJ68Iwm29nrV9sFDtjRJ3klXm/Tu9tzqsqhEyQT6W3iuGzolqR8Y5sD/TQfQ6pxsBF1qVhv4EDesGyDbG7jUcz4kokIPHyNXI29+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEWwZ/5f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7151C1F00A3F;
	Thu, 28 May 2026 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996747;
	bh=rkb83lLwCPFi5cqD1i0rQIeXMtJ0Mg6oPSiHeHIERBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mEWwZ/5fjPgA7JqAqLMt1IGPFjFsbq5yJMVXGMmRlyZUPIVL4MGSKQcIXn3IyCDTk
	 VP5aTktusRS9KzzaZuZBC8jukjmkK2ESvGsNcCW2XdGmQG2FpHAGmqDS7exsQcBI6I
	 KZp1jYrewZVNXsL09Qr5fG3z7afezOkBL3IyBfzj3/KJRXayRtI1aKAE06LBSDN46A
	 WfCvNxCvFEROq+OGM5cxGxVcwIOU4sZ8EAs1/SQTEHE1rRbVhxmkYw2Qu3FGkW4jCg
	 shBxzendzb/spXFtQvqCHnSknRCRmXIclKflgyI2R9dfoaAidv8aoOx2GdWW+r08Tr
	 0dAK6tOciPG3g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:09 -0400
Subject: [PATCH 2/6] SUNRPC: fix gssx_dec_option_array error path bugs
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-2-d026a1415e0b@oracle.com>
References: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
In-Reply-To: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Simo Sorce <simo@redhat.com>, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3999;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=r8ggNWU9165vxjye7pMprQOJ1Ii7JKG075SqDY684YQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhHXNY4Ak++F5wrbUIxvjPwWtK6BK8mccYL5
 YuLtHDld5SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYRwAKCRAzarMzb2Z/
 l8onEACmRcLekMoNhCFClMmtNAGFnrHcZymMYvOWeyR4JaQhi1rEExGkAVhp7muJZohI0WiQGie
 4NG62xOKh5tr4rltzx74F0nHDs2/1NiAmHH3qHiPFb3x4ObN7ijjXa59zXglGXfuWV9CCz8tnKU
 qxiM9e9gE6TOWwEvzdnkm9r9VtgL1fsF7wo1xjDE8VBEwTyEJ4/pMi9gNa45E24cnDsXg6cJ90Y
 eZ3GBWfJeItWTzyLkm9LANwLx/G8l+E0wehcrFuJgnCKoo+2rSloAHM7XOIJYZiMtAYyACy+b+S
 TvJgCus6vPAf2DPv1ANYSfNmR1ZKLG9TTwtX0J8Of8O8sKGYTxVsHojU4M2qbUoXjBw4DL2/11z
 MacfwILJdazo5sGX9hZWAWHz8rhiCgpJXYNyR03uiyk7nuA8x1mooS1orGpkdN8x+JH1QEUZSX+
 ateZBRxDoLf6SEQxugknqATRZzdrch8hmA40LZVmi2id39t8lcps/6N0x3a0vdkn51BMjWZ71rg
 cnnnnVfZ/76rReGMvkpqc7dEADrvgJTMzrO9W3oPS99nSPS4E+2d0pYM2XJH84OoCpg/pAB6X2R
 HF8AEKo9X7O8BoMRe7QD4G18oDDK9dY70dH1BNUCMBC94EFBCf/ft6kUDmY9K97kuEX9+Lk42wU
 WuOIvm0K32WtTQg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22045-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 1C2E25F7251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

Four coupled defects in the gssx XDR option-array decoder make the
error paths unsafe: a NULL deref in the caller, a refcount leak on
the decoded group_info, and a latent use-after-free that the leak
fix would otherwise expose.

gssx_dec_option_array() sets oa->count = 1 before allocating
oa->data.  If that allocation fails, -ENOMEM is returned with
oa->count == 1 and oa->data == NULL.  All other error paths jump
to free_oa: which frees oa->data and NULLs it but also leaves
oa->count == 1.  The caller trusts the count:

    gssp_accept_sec_context_upcall()
      gssx_dec_accept_sec_context()
        gssx_dec_option_array()        /* fails, count=1 data=NULL */
      data = res.options.data[0].value /* NULL deref */

Independently, free_creds: releases the partially decoded svc_cred
with a bare kfree(creds).  gssx_dec_linux_creds() installs a
groups_alloc() result into creds->cr_group_info; that object is
kvmalloc-backed and refcounted, and only put_group_info() reaches
kvfree().  A plain kfree(creds) drops the wrapper and leaks the
group_info allocation.

The natural fix for the leak is to call free_svc_cred(creds) before
kfree(creds), but free_svc_cred() invokes put_group_info() on
creds->cr_group_info unconditionally when non-NULL.  The existing
out_free_groups: path in gssx_dec_linux_creds() already called
groups_free() on that pointer without clearing it, so once
free_svc_cred() is wired in, the subsequent put_group_info() would
touch freed memory.

Fix all four together:

  - Move the oa->count = 1 assignment below the oa->data allocation
    so it is never set when oa->data is NULL.
  - Reset oa->count to 0 at free_oa: so count and data stay
    coherent and the caller sees an empty option array.
  - Call free_svc_cred(creds) before kfree(creds) at free_creds:
    so the refcounted cr_group_info is released.  free_svc_cred()
    either NULL-guards each field explicitly (cr_group_info has
    an if() check) or delegates to a helper that is NULL-safe
    itself (kfree for the string fields, gss_mech_put() which
    guards with if(gm) at gss_mech_switch.c:342), so it is safe
    to call on a partially decoded svc_cred where only
    cr_uid/cr_gid/cr_group_info have been written and everything
    else is zero from kzalloc.
  - In gssx_dec_linux_creds()'s out_free_groups: path, release
    cr_group_info with put_group_info() rather than groups_free()
    so the teardown matches free_svc_cred()'s refcount-aware path,
    and clear the pointer so a later free_svc_cred() on the same
    creds does not release it a second time.

Fixes: 3cfcfc102a5e ("SUNRPC: fix some memleaks in gssx_dec_option_array")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index fceee648d545..f2b8f919adea 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -222,7 +222,8 @@ static int gssx_dec_linux_creds(struct xdr_stream *xdr,
 
 	return 0;
 out_free_groups:
-	groups_free(creds->cr_group_info);
+	put_group_info(creds->cr_group_info);
+	creds->cr_group_info = NULL;
 	return err;
 }
 
@@ -242,12 +243,12 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 		return 0;
 
 	/* we recognize only 1 currently: CREDS_VALUE */
-	oa->count = 1;
-
 	oa->data = kmalloc_obj(struct gssx_option);
 	if (!oa->data)
 		return -ENOMEM;
 
+	oa->count = 1;
+
 	creds = kzalloc_obj(struct svc_cred);
 	if (!creds) {
 		err = -ENOMEM;
@@ -294,8 +295,10 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 	return 0;
 
 free_creds:
+	free_svc_cred(creds);
 	kfree(creds);
 free_oa:
+	oa->count = 0;
 	kfree(oa->data);
 	oa->data = NULL;
 	return err;

-- 
2.54.0


