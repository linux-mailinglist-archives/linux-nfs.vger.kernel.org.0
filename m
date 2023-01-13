Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489E669C24
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAMP3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAMP2V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:28:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F744C43
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372886216C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65985C433D2;
        Fri, 13 Jan 2023 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623320;
        bh=kpUGvzOW39hlMmxADthx96vNAWACrjND/YOYiOTSHks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sZkK4DpHe6+3z+O4e0qj13/IOvpwcaWzUT7Tc4GxQ4KFiLEpWs+sO0NzQv2xou1ZK
         hBBK9QDX6ENWKyS76KEsGLwoHr81xB1RtVC9r6xmboESqv+qTGz/kn+IPic04javOL
         4VXUhu8fmLS6fY7r1Gf4s8j1Js/jtpigtp9pSo8G+euo0IyjUqbT3ooRZ7MWvlKknT
         Hy1J3RxPxxI7daqlV8dizGVs8fKa2OghivSzJ9znkHKdoNT7xIj51nt5omvYorPM5S
         KvT8CSY1oNV5GacPXLLERxJsxh/JmwsocBuAexQOwyHg8FQseELd/5Iym0vcC3Cjl+
         3uCYcXOI0mGFQ==
Subject: [PATCH v1 05/41] SUNRPC: Obscure Kerberos session key
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:21:59 -0500
Message-ID: <167362331943.8960.1546242627205639130.stgit@bazille.1015granger.net>
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

ctx->Ksess is never used after import has completed. Obscure it
immediately so it cannot be re-used or copied.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 6d59794c9b69..9b489f7f2720 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -550,6 +550,7 @@ gss_import_sec_context_kerberos(const void *p, size_t len,
 		ret = gss_import_v1_context(p, end, ctx);
 	else
 		ret = gss_import_v2_context(p, end, ctx, gfp_mask);
+	memzero_explicit(&ctx->Ksess, sizeof(ctx->Ksess));
 	if (ret) {
 		kfree(ctx);
 		return ret;


