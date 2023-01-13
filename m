Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613B669C3B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAMPar (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjAMPaJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C510EA
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BC6B8217A
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A65C433F0;
        Fri, 13 Jan 2023 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623364;
        bh=AAKF2h49CkAzEC5hAJhxvkm51RZupkaiVZQfgHEyap8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mkeHwQAEijJeXFhDpsMyFuEQzNYt1ULvCBepzXJ5fbDUp7qDPIfA5kdEoBFlxCO/L
         Y6YGm9Yfthy5u9D4b/74YsFtG45ujpX0YnspPfM2MpWahu9Po+0E1MRnEiGFlcO0j3
         2XSBH5DUCufP1uD5dnRW7lKo5pi0xTaoRphIg03tczhwxmpwey+sLEhRud0VBfmcse
         mxTnoSWjXim6t2UT2ew0O6PDJZl/VzvuNn8K67lMUSUd5j2/zYvqkqnpa17Ts3tFLf
         HcA5LRKD3n6W5bOB+S2pEK2Eg8X0ntoEflJSXWFeuxEwd2AGBbPSPUJL03xABM+6sy
         7JgW3vbqA7THw==
Subject: [PATCH v1 12/41] SUNRPC: Add /proc/net/rpc/gss_krb5_enctypes file
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:22:43 -0500
Message-ID: <167362336382.8960.2076097967542181718.stgit@bazille.1015granger.net>
In-Reply-To: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
References: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I would like to replace the KRB5_SUPPORTED_ENCTYPES macro so that
there is finer granularity about what enctype support is built in
to the kernel and then advertised by it.

The /proc/fs/nfsd/supported_krb5_enctypes file is a legacy API
that advertises supported enctypes to rpc.svcgssd (I think?). It
simply prints the value of the KRB5_SUPPORTED_ENCTYPES macro, so it
will need to be replaced with something that can instead display
exactly which enctypes are configured and built into the SunRPC
layer.

Completely decommissioning such APIs is hard. Instead, add a file
that is managed by SunRPC's GSS Kerberos mechanism, which is
authoritative about enctype support status. A subsequent patch will
replace /proc/fs/nfsd/supported_krb5_enctypes with a symlink to this
new file.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 28e977c89a5a..19f0190a0b97 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1494,6 +1494,55 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net)
 		clear_gssp_clnt(sn);
 	}
 }
+
+static ssize_t read_gss_krb5_enctypes(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct rpcsec_gss_oid oid = {
+		.len	= 9,
+		.data	= "\x2a\x86\x48\x86\xf7\x12\x01\x02\x02",
+	};
+	struct gss_api_mech *mech;
+	ssize_t ret;
+
+	mech = gss_mech_get_by_OID(&oid);
+	if (!mech)
+		return 0;
+	if (!mech->gm_upcall_enctypes) {
+		gss_mech_put(mech);
+		return 0;
+	}
+
+	ret = simple_read_from_buffer(buf, count, ppos,
+				      mech->gm_upcall_enctypes,
+				      strlen(mech->gm_upcall_enctypes));
+	gss_mech_put(mech);
+	return ret;
+}
+
+static const struct proc_ops gss_krb5_enctypes_proc_ops = {
+	.proc_open	= nonseekable_open,
+	.proc_read	= read_gss_krb5_enctypes,
+};
+
+static int create_krb5_enctypes_proc_entry(struct net *net)
+{
+	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
+
+	if (!proc_create_data("gss_krb5_enctypes", S_IFREG | 0444,
+			      sn->proc_net_rpc,
+			      &gss_krb5_enctypes_proc_ops, net))
+		return -ENOMEM;
+	return 0;
+}
+
+static void destroy_krb5_enctypes_proc_entry(struct net *net)
+{
+	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
+
+	remove_proc_entry("gss_krb5_enctypes", sn->proc_net_rpc);
+}
+
 #else /* CONFIG_PROC_FS */
 
 static int create_use_gss_proxy_proc_entry(struct net *net)
@@ -1503,6 +1552,13 @@ static int create_use_gss_proxy_proc_entry(struct net *net)
 
 static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 
+static int create_krb5_enctypes_proc_entry(struct net *net)
+{
+	return 0;
+}
+
+static void destroy_krb5_enctypes_proc_entry(struct net *net) {}
+
 #endif /* CONFIG_PROC_FS */
 
 /*
@@ -2042,7 +2098,15 @@ gss_svc_init_net(struct net *net)
 	rv = create_use_gss_proxy_proc_entry(net);
 	if (rv)
 		goto out2;
+
+	rv = create_krb5_enctypes_proc_entry(net);
+	if (rv)
+		goto out3;
+
 	return 0;
+
+out3:
+	destroy_use_gss_proxy_proc_entry(net);
 out2:
 	rsi_cache_destroy_net(net);
 out1:
@@ -2053,6 +2117,7 @@ gss_svc_init_net(struct net *net)
 void
 gss_svc_shutdown_net(struct net *net)
 {
+	destroy_krb5_enctypes_proc_entry(net);
 	destroy_use_gss_proxy_proc_entry(net);
 	rsi_cache_destroy_net(net);
 	rsc_cache_destroy_net(net);


