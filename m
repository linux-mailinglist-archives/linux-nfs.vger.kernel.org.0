Return-Path: <linux-nfs+bounces-17304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC2CDEC9E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3E43005EBD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C571946BC;
	Fri, 26 Dec 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao8mhHhF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47215853B;
	Fri, 26 Dec 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766762136; cv=none; b=M/ERJ3qzk6mmRKhJ6uKxmsfop9D0DmTNoFQ3GvgQNwdBTEuCqZTCZ7ofTZrL7c/gg6y6ahuAnIymyHyT6loFI2deYLeEuaAfUd97rXek45DEH25jntnF1L2YA2TSS60aYW7H8RZdkVJ8ozZZFM/v1vK8DUkFLYmeHw3FBTF1FHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766762136; c=relaxed/simple;
	bh=AiJR4/Gv5Iou63LOX3tJ3AG4YPAHUGlU/cQNJc3NJP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWsMEFj3UYvM5/v7z+lOh65v9+eujcw/c+XDIPQC2QzLh6U8TWgnAvFwRDwHzrtwq2oCbVA7agGO66cAKM0zY3avZ9gj5RbqyTLLhUPvFE8iZC17eWFVVP/fmVrcgVcOOVMs6L2o3V5VXgZiFNG7HOjYQ1J/knrCiFqwPKo3sBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao8mhHhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF730C4CEF7;
	Fri, 26 Dec 2025 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766762135;
	bh=AiJR4/Gv5Iou63LOX3tJ3AG4YPAHUGlU/cQNJc3NJP0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ao8mhHhFPVzFGO+Y7VwTs/2NDw/lXXwxBKYK4zTgeaeethHUSJLclLhCtS6nHU8oP
	 0EhXNR3IhMh2zowWII7IvynVx4Pdn3SDXGodcvfgLcpp5Hhf3LU+BEyxhp8Ib/57FG
	 S6yiSFvGag9MPUe4cBrktBBlXve5Bi6Dpp/sLfyWUD9kG2ewacakweSAsykZVezGlZ
	 h7JjsnpIj/fsXOBKkeQmEZi0HpyGt7r/iS30R5fewAcJzd0oFfgyKY5jz103vbcCp2
	 Hr6n293PY3v4PyRO2YTdd6c19ONDdkz2+kwZvgTNHIClmfJpW8u/oIKratpZL4+BYk
	 e3jPEouCO5FKQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Xingjing Deng <micro6947@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] SUNRPC: auth_gss: fix memory leaks in XDR decoding error paths
Date: Fri, 26 Dec 2025 10:15:32 -0500
Message-ID: <20251226151532.440886-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 82 ++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index 7d2cdc2bd374..f320c0a8e604 100644
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
 
+	return 0;
+
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
2.52.0


