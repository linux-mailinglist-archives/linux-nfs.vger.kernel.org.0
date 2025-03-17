Return-Path: <linux-nfs+bounces-10640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61CA6600B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B4519A280F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37232063D2;
	Mon, 17 Mar 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIxwAt6f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEE2063C3;
	Mon, 17 Mar 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245219; cv=none; b=SAuslX/byX853RkP/rX+W73s2z0We2Rbu+FTcIJRVa4f37bNKsv+vUAZ6grendorZQusnFDhEqNI9tYBtsS7tL3Dz7yv6REJziDjbx/AgJu3rRsyV0e2R0LEpUyYaUMZaRt9RDL8OU++e7p++PK/WfmOTLXgfKEwxrlpuKa2vBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245219; c=relaxed/simple;
	bh=FZgJlwD7q/KVkhllrSyqU3sWFbaUznyU5+XlxzH/Gu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpr4O8Q3e9WxkHMTgVH8JFzWajHvnzBbMRuw9cMTcJUiXru0vElpOsgtuFipItkw7kazVcJ4s1xlKAgk1ZOsk5lmUXZaLAnu6XXhlpbQXYrvlUTopuFQ0bKck8TRv3by8Q31knbvpYFcXqJMAK9WgKrGVcXIh244+nJ+b7LZsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIxwAt6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273FEC4CEF1;
	Mon, 17 Mar 2025 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245219;
	bh=FZgJlwD7q/KVkhllrSyqU3sWFbaUznyU5+XlxzH/Gu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rIxwAt6fr2y5XeH81YL7FXRqmGVCx7SoavWD56Dl7bBLvmnreN38RuFeY0718UbNT
	 wrpnBbXyEvQi7VTzwEutZ7+00YDStUy+jaQ7M2mFtUxFmjq5mTRYoKMLba8s6WiDew
	 e7E21YCo9+YxzGdLsWo9Qp1YOZU0SXqBxOON16j1cbJuSmYi/bfSXi/2JZ7ZIXOTKS
	 9xFtjxvzylitoQqALz1v8PZ/ryIJoxgRsu9j9F/avvn8nwqBYMIpeBL4vsk4Ay/969
	 qN0eh5fjkeFQ/NkKrR9rI+lfthUgNnMP3DhQUnZv2nMckLlOYlWWV70dVTnbaYIHDX
	 4OmqGJk1Vb5gQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:59 -0400
Subject: [PATCH RFC 7/9] auth_gss: don't hold a net reference in gss_auth
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-7-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FZgJlwD7q/KVkhllrSyqU3sWFbaUznyU5+XlxzH/Gu8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1VPI8r7zGxukH/RwNzSdWwBI5QXfWDlhMDL
 /EB68xdHmiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVQAKCRAADmhBGVaC
 Fe3+D/9m/uy/A2wuVHMYADSwBcoYLZxk20mBOjp8qMXSH+EdJ/52UKcS/dauuVeOWtwlw+fUPu7
 wvRa9euPx9cbflNj67rGpCFRlynHicfSfukmLNEqYclDc84Dtw0P61ekDynYY3AuHVzTL0sBp0J
 KbixtyOCMB8Z7z1Q7tWXJIK7d2kecz+Ja8W9FR8FadAvtuhaO9HMGwdLkASeneUq0gzw4ZV2y3j
 fhsqsulm68M3T7mPQP28h3DfudyfC+BZIBmNaRRzEIJw7t9WcKXBdxNzzAqXUBeXeaDMF8nLooD
 n/vt4vXeNZua6rR+SHZoGSv8xsgBzoZRUEzJcf+rqAPAEhPgKgaIaUmNHDWn069VSHDIrIovNSK
 VfvYIJ4NKjY86diy+xU5mfTv9DMEVfVJvvbNM3ihuMKu9TtnzSdVZCl/j36CDUg22iz3qQphuQ1
 5tqoi6jWbdmjcgSVutmGu5DgAMEHAHiYpIOUnEkw3pDK4B88vAZcGwJiEcbpmQHzsPVo/202Ua1
 b8KRq0g4OngyqvpwtsEXMyA16rPYLavup75HG9Gu6aiUD742isRTn4iiQWF9nrNzCxjTlxTwuqE
 ndyi5zCBbnqs9O5dsgK3es96LWHDjo3tkXAikBiJE9Euz/jFDHKlYySIl3Ohr0gKNsqb6fNnSBh
 5L0fJf9nQiiQgLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's not clear to me that these net references were ever needed. They
were added in commit e726340ac9cf ("RPCSEC_GSS: Further cleanups"), but
there no is explanation for taking it in the patch description and it's
not clear what race this prevents.

Now that the gssproxy client is shut down in pre_exit, there should be
no need to keep a reference here.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/auth_gss/auth_gss.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 78571776f446e2097bf25642c182d57546502803..9698914d7ed3e5674351f9cc4f43c08d7b746bc3 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -89,7 +89,6 @@ struct gss_auth {
 	enum rpc_gss_svc service;
 	struct rpc_clnt *client;
 	struct net	*net;
-	netns_tracker	ns_tracker;
 	/*
 	 * There are two upcall pipes; dentry[1], named "gssd", is used
 	 * for the new text-based upcall; dentry[0] is named after the
@@ -1045,12 +1044,11 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 			goto err_free;
 	}
 	gss_auth->client = clnt;
-	gss_auth->net = get_net_track(rpc_net_ns(clnt), &gss_auth->ns_tracker,
-				      GFP_KERNEL);
+	gss_auth->net = rpc_net_ns(clnt);
 	err = -EINVAL;
 	gss_auth->mech = gss_mech_get_by_pseudoflavor(flavor);
 	if (!gss_auth->mech)
-		goto err_put_net;
+		goto err_free;
 	gss_auth->service = gss_pseudoflavor_to_service(gss_auth->mech, flavor);
 	if (gss_auth->service == 0)
 		goto err_put_mech;
@@ -1101,8 +1099,6 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 	rpcauth_destroy_credcache(auth);
 err_put_mech:
 	gss_mech_put(gss_auth->mech);
-err_put_net:
-	put_net_track(gss_auth->net, &gss_auth->ns_tracker);
 err_free:
 	kfree(gss_auth->target_name);
 	kfree(gss_auth);
@@ -1118,7 +1114,6 @@ gss_free(struct gss_auth *gss_auth)
 	gss_pipe_free(gss_auth->gss_pipe[0]);
 	gss_pipe_free(gss_auth->gss_pipe[1]);
 	gss_mech_put(gss_auth->mech);
-	put_net_track(gss_auth->net, &gss_auth->ns_tracker);
 	kfree(gss_auth->target_name);
 
 	kfree(gss_auth);

-- 
2.48.1


