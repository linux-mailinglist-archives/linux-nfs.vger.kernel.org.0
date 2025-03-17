Return-Path: <linux-nfs+bounces-10639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A2A66007
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C0619A25CA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71F6205AC5;
	Mon, 17 Mar 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmVkQaKf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA49205ABF;
	Mon, 17 Mar 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245218; cv=none; b=t4tLbfBYaOvTmkCwEBezyL3BmwPKIQbcWSDwa/gVfUmVYPJpi/Hvu9ntvESJqop9ptQKnJvlow4HY4+oZLFuMbMM4uQZYA4LU2lj9nD+XH+xD3RKyu7nqovlVNKKs1EdLp9qFLbVl5PiU2YdHIbUbRds3o3V4E4GDl/EMkZRRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245218; c=relaxed/simple;
	bh=IBV+vN6wOOZiC4bOQLfVH5Q5rc2w53Ap+h6wej5B8qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+UMcTIDfxiiuF+YaxO3v1MIXqPNBS6y4i77+xbz+kUYEwGjf66criVzjLcdkz3LwwRXvnEwQhDoAaAf7eaeiOvaCX/LAVnnNzo0+nkJGJExZvMq6cr84FCVubZNESe5b/rtrulKcPrqzcQxsqg0z/A9jbChjOx1pOoxc/Iiafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmVkQaKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0CCC4CEED;
	Mon, 17 Mar 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245217;
	bh=IBV+vN6wOOZiC4bOQLfVH5Q5rc2w53Ap+h6wej5B8qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EmVkQaKfzpRjlixX5u6ptOjwQlYK0bGuuPHyha9OuLfW6ua0AD2ogyTTEm5nL099M
	 n1jssYiqefE9815iK4hN4hI+ScA8GtKI22Gw5YofhHyH4iK0EGwDkukpfVzjvWnTqy
	 NcWIhCLK4mX2QZqGmH214CDHLHmKmiBxcuPeXTC5iicEgqUaJ9GGluoLcNykz1bjKw
	 p9OWKJvBmXFxGYNj1XkIfX9klwjlgARUJw32F8VmYhZV8TPsT7Vo6TTctHFjUgGQPG
	 kZWv0+jm+1SRXLzxIhhCY8ShyN2xbjaTUbCCfWoV9lrrN8NRBQm5DqB6WB/nZINScy
	 vsYPEomqEyEYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:58 -0400
Subject: [PATCH RFC 6/9] auth_gss: shut down gssproxy rpc_clnt in net
 pre_exit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-6-85ba8e20b75d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IBV+vN6wOOZiC4bOQLfVH5Q5rc2w53Ap+h6wej5B8qc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1VqJI3DHTF0owzCuhiL67WUbGvo0HYo6WEq
 17eeapc+YGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVQAKCRAADmhBGVaC
 FeHqD/96hvh2LiqTHfHVE0QZOsFKZoN4m7gbdMKfPj7r0UmhIVRZYZDOWof3BCO60OYP+tPPkrA
 5zY+NbtNYpJlByPeEf2WBAeCGAKzJHaaLa4ItQ6qeJ1sqqoz6oqiMUu0fPQAbLoTqjZxcf2HNDS
 fOwU951CjBHUcLk0y2VHfjI7dfPiuN3IilfVG+xBuHXtqtAkMshyRfKKBQQtqK5MpKK5/TePPhf
 OuAz0Ra/2DsemXiwpq+XaSTNBC5jjIRMiCjrM6d25iz4pBMZ3wB06j/1oxrAJcdYxiWxoA6pa4g
 l/kQ+xK78Ofaqfe2dmY4BkecHvO3G+/rtwbIF22dgdMZIObfp6sCT5b9lyocLllp6wCUVvxYtJr
 Y73hDrHJcPKJBHDtJLxBDcXgkRP2YcBPhWlbjuv2HftHyXIXKpVnfekyw6yxP1pu38IXje0L33J
 TVeMor39kTovZF4wswsDY1WYznO4Mjzo4ybOUIMfP/86eVfArnyBvy5iWO2X+HyczMnzYs494ZP
 rYrchWUn+FPLpdEUezowescnGQP5hAuBHsdEMgTJ0B+WOtDMbIe5pZb1augpwUdE/oFpbAMymcz
 DQd4x8sonGCins1BXuWWpJ/xTdh7IoXBY5e+vbA7Nl7lfU7uK9HYPIhIHxa5Qbsf2mrW4q42Wdj
 spw+/nr2QxfaoVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With a coming change to rpc_xprt's not holding a reference to the netns,
it will be necessary to shut down the gssp_clnt in pre_exit rather than
the netns exit routine.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svcauth_gss.h | 1 +
 net/sunrpc/auth_gss/auth_gss.c     | 6 ++++++
 net/sunrpc/auth_gss/svcauth_gss.c  | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svcauth_gss.h b/include/linux/sunrpc/svcauth_gss.h
index f09c82b0a7aefed0b4ce6ab60258a2d34cea8e27..0dfda2f25f7fdb16a6bc9e537399548e47dfde56 100644
--- a/include/linux/sunrpc/svcauth_gss.h
+++ b/include/linux/sunrpc/svcauth_gss.h
@@ -19,6 +19,7 @@
 int gss_svc_init(void);
 void gss_svc_shutdown(void);
 int gss_svc_init_net(struct net *net);
+void gss_svc_pre_shutdown_net(struct net *net);
 void gss_svc_shutdown_net(struct net *net);
 struct auth_domain *svcauth_gss_register_pseudoflavor(u32 pseudoflavor,
 						      char *name);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 369310909fc98596c8a06db8ac3c976a719ca7b2..78571776f446e2097bf25642c182d57546502803 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2242,9 +2242,15 @@ static __net_exit void rpcsec_gss_exit_net(struct net *net)
 	gss_svc_shutdown_net(net);
 }
 
+static __net_exit void rpcsec_gss_pre_exit_net(struct net *net)
+{
+	gss_svc_pre_shutdown_net(net);
+}
+
 static struct pernet_operations rpcsec_gss_net_ops = {
 	.init = rpcsec_gss_init_net,
 	.exit = rpcsec_gss_exit_net,
+	.pre_exit = rpcsec_gss_pre_exit_net,
 };
 
 /*
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 73a90ad873fb9da659ba76184b2e2a0e5324ce0d..624e88be6eb3163b131902c4800e4842e4c0808e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -2102,11 +2102,16 @@ gss_svc_init_net(struct net *net)
 	return rv;
 }
 
+void
+gss_svc_pre_shutdown_net(struct net *net)
+{
+	destroy_use_gss_proxy_proc_entry(net);
+}
+
 void
 gss_svc_shutdown_net(struct net *net)
 {
 	destroy_krb5_enctypes_proc_entry(net);
-	destroy_use_gss_proxy_proc_entry(net);
 	rsi_cache_destroy_net(net);
 	rsc_cache_destroy_net(net);
 }

-- 
2.48.1


