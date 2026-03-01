Return-Path: <linux-nfs+bounces-19462-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KenB2Kdo2l2IQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19462-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 02:58:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46331CC7B1
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 02:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0660530891EF
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A42D6407;
	Sun,  1 Mar 2026 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdtdvU81"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158562ECE9B;
	Sun,  1 Mar 2026 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329938; cv=none; b=O6s2mfZazhr8zVdVOzYuyH0+AAgIJkCufl12MdgfmPufvh5HtQrSXmpQMrl0Lsq3tEFEq6fOIf4uLSN4pRr4J03W62YBMJ7bEp9oG5m8DO3qoZIX42FmB9LGgy4uvVAK3+eqIrAoz4fKVguD0ZuHqNNNBzI1h5z6tSvDycH5PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329938; c=relaxed/simple;
	bh=rTELKinGm7Mc5tDtME5CJpDMsIjVjzcBhOLS/ns89AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2g58AQ6SmeHlACLYkEAl+oTB7ks5JhbC/nNR9JOdQdBKb2ft0Zjwmks5F+bDNw775588tHNxS8tpQ9EkHD90KdjMMxerWcOj+nItHDVz9UmHTvuF7UTtZk6qwexQtVPevB90CW0mIDmQ7yvy+rQM4ur2wurF3dUhLS13bKcWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdtdvU81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F1C19421;
	Sun,  1 Mar 2026 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329937;
	bh=rTELKinGm7Mc5tDtME5CJpDMsIjVjzcBhOLS/ns89AM=;
	h=From:To:Cc:Subject:Date:From;
	b=DdtdvU81sysVN/eYgmlEBe7RrVapQUYqPQrxToz7VEyuVZCdF0982BH5WBp25/cfO
	 XTwpMiVUZKMJFU4qm8Mew5E21LTWY9x46UlZeu//uocGNspuuRrdSThxOsPv/cq/BR
	 Ftov8YCpKqgmq6RVVR/nMJANxWzmVKOGQ09un8zuErhbhj2mZPAOiYWGHcYpUZvaGh
	 pBuSwTDr6TzQP/ZpDHNWx/GzDnY1TeU/S3Ad0obasYEtKOLbpIrkUgnnhVuKRRdmoA
	 mUaku0tK2PXoji37/mMyegIg49vNH6cepCv+5AmMCO9eqf65FPYL/3Oa8XXa3u9V0g
	 ZPtk+6NDBDyMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chuck.lever@oracle.com
Cc: Xingjing Deng <micro6947@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "SUNRPC: auth_gss: fix memory leaks in XDR decoding error paths" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:15 -0500
Message-ID: <20260301015215.1718711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19462-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: C46331CC7B1
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3e6397b056335cc56ef0e9da36c95946a19f5118 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Fri, 26 Dec 2025 10:15:32 -0500
Subject: [PATCH] SUNRPC: auth_gss: fix memory leaks in XDR decoding error
 paths

The gssx_dec_ctx(), gssx_dec_status(), and gssx_dec_name()
functions allocate memory via gssx_dec_buffer(), which calls
kmemdup(). When a subsequent decode operation fails, these
functions return immediately without freeing previously
allocated buffers, causing memory leaks.

The leak in gssx_dec_ctx() is particularly relevant because
the caller (gssp_accept_sec_context_upcall) initializes several
buffer length fields to non-zero values, resulting in memory
allocation:

    struct gssx_ctx rctxh = {
        .exported_context_token.len = GSSX_max_output_handle_sz,
        .mech.len = GSS_OID_MAX_LEN,
        .src_name.display_name.len = GSSX_max_princ_sz,
        .targ_name.display_name.len = GSSX_max_princ_sz
    };

If, for example, gssx_dec_name() succeeds for src_name but
fails for targ_name, the memory allocated for
exported_context_token, mech, and src_name.display_name
remains unreferenced and cannot be reclaimed.

Add error handling with goto-based cleanup to free any
previously allocated buffers before returning an error.

Reported-by: Xingjing Deng <micro6947@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/CAK+ZN9qttsFDu6h1FoqGadXjMx1QXqPMoYQ=6O9RY4SxVTvKng@mail.gmail.com/
Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 82 ++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index 7d2cdc2bd374e..f320c0a8e6049 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -320,29 +320,47 @@ static int gssx_dec_status(struct xdr_stream *xdr,
 
 	/* status->minor_status */
 	p = xdr_inline_decode(xdr, 8);
-	if (unlikely(p == NULL))
-		return -ENOSPC;
+	if (unlikely(p == NULL)) {
+		err = -ENOSPC;
+		goto out_free_mech;
+	}
 	p = xdr_decode_hyper(p, &status->minor_status);
 
 	/* status->major_status_string */
 	err = gssx_dec_buffer(xdr, &status->major_status_string);
 	if (err)
-		return err;
+		goto out_free_mech;
 
 	/* status->minor_status_string */
 	err = gssx_dec_buffer(xdr, &status->minor_status_string);
 	if (err)
-		return err;
+		goto out_free_major_status_string;
 
 	/* status->server_ctx */
 	err = gssx_dec_buffer(xdr, &status->server_ctx);
 	if (err)
-		return err;
+		goto out_free_minor_status_string;
 
 	/* we assume we have no options for now, so simply consume them */
 	/* status->options */
 	err = dummy_dec_opt_array(xdr, &status->options);
+	if (err)
+		goto out_free_server_ctx;
 
+	return 0;
+
+out_free_server_ctx:
+	kfree(status->server_ctx.data);
+	status->server_ctx.data = NULL;
+out_free_minor_status_string:
+	kfree(status->minor_status_string.data);
+	status->minor_status_string.data = NULL;
+out_free_major_status_string:
+	kfree(status->major_status_string.data);
+	status->major_status_string.data = NULL;
+out_free_mech:
+	kfree(status->mech.data);
+	status->mech.data = NULL;
 	return err;
 }
 
@@ -505,28 +523,35 @@ static int gssx_dec_name(struct xdr_stream *xdr,
 	/* name->name_type */
 	err = gssx_dec_buffer(xdr, &dummy_netobj);
 	if (err)
-		return err;
+		goto out_free_display_name;
 
 	/* name->exported_name */
 	err = gssx_dec_buffer(xdr, &dummy_netobj);
 	if (err)
-		return err;
+		goto out_free_display_name;
 
 	/* name->exported_composite_name */
 	err = gssx_dec_buffer(xdr, &dummy_netobj);
 	if (err)
-		return err;
+		goto out_free_display_name;
 
 	/* we assume we have no attributes for now, so simply consume them */
 	/* name->name_attributes */
 	err = dummy_dec_nameattr_array(xdr, &dummy_name_attr_array);
 	if (err)
-		return err;
+		goto out_free_display_name;
 
 	/* we assume we have no options for now, so simply consume them */
 	/* name->extensions */
 	err = dummy_dec_opt_array(xdr, &dummy_option_array);
+	if (err)
+		goto out_free_display_name;
 
+	return 0;
+
+out_free_display_name:
+	kfree(name->display_name.data);
+	name->display_name.data = NULL;
 	return err;
 }
 
@@ -649,32 +674,34 @@ static int gssx_dec_ctx(struct xdr_stream *xdr,
 	/* ctx->state */
 	err = gssx_dec_buffer(xdr, &ctx->state);
 	if (err)
-		return err;
+		goto out_free_exported_context_token;
 
 	/* ctx->need_release */
 	err = gssx_dec_bool(xdr, &ctx->need_release);
 	if (err)
-		return err;
+		goto out_free_state;
 
 	/* ctx->mech */
 	err = gssx_dec_buffer(xdr, &ctx->mech);
 	if (err)
-		return err;
+		goto out_free_state;
 
 	/* ctx->src_name */
 	err = gssx_dec_name(xdr, &ctx->src_name);
 	if (err)
-		return err;
+		goto out_free_mech;
 
 	/* ctx->targ_name */
 	err = gssx_dec_name(xdr, &ctx->targ_name);
 	if (err)
-		return err;
+		goto out_free_src_name;
 
 	/* ctx->lifetime */
 	p = xdr_inline_decode(xdr, 8+8);
-	if (unlikely(p == NULL))
-		return -ENOSPC;
+	if (unlikely(p == NULL)) {
+		err = -ENOSPC;
+		goto out_free_targ_name;
+	}
 	p = xdr_decode_hyper(p, &ctx->lifetime);
 
 	/* ctx->ctx_flags */
@@ -683,17 +710,36 @@ static int gssx_dec_ctx(struct xdr_stream *xdr,
 	/* ctx->locally_initiated */
 	err = gssx_dec_bool(xdr, &ctx->locally_initiated);
 	if (err)
-		return err;
+		goto out_free_targ_name;
 
 	/* ctx->open */
 	err = gssx_dec_bool(xdr, &ctx->open);
 	if (err)
-		return err;
+		goto out_free_targ_name;
 
 	/* we assume we have no options for now, so simply consume them */
 	/* ctx->options */
 	err = dummy_dec_opt_array(xdr, &ctx->options);
+	if (err)
+		goto out_free_targ_name;
+
+	return 0;
 
+out_free_targ_name:
+	kfree(ctx->targ_name.display_name.data);
+	ctx->targ_name.display_name.data = NULL;
+out_free_src_name:
+	kfree(ctx->src_name.display_name.data);
+	ctx->src_name.display_name.data = NULL;
+out_free_mech:
+	kfree(ctx->mech.data);
+	ctx->mech.data = NULL;
+out_free_state:
+	kfree(ctx->state.data);
+	ctx->state.data = NULL;
+out_free_exported_context_token:
+	kfree(ctx->exported_context_token.data);
+	ctx->exported_context_token.data = NULL;
 	return err;
 }
 
-- 
2.51.0





