Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79FC669C52
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAMPbg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAMPbR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:31:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A192354
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 048A56216C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EA3C433EF;
        Fri, 13 Jan 2023 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623472;
        bh=fCH2Sn4QSEsq6g/JOJk0bTB1nfM+mb/p1UFXdrmBYk4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hj+KhsaK0arQJCQPioLu+V1/9qak8zT0IZmGBXI/eiIXNCG0aoOR+3NoNvSZjoRv9
         wmqgwz7gj6NNKzUleAGqSidILfhK/3BJBwXMsu1lriqGRog1ut/KeDkkbnCKEcuKBF
         fij6SjOHKj+RUfe6KChJOmyHqdfhUNWams/yBpo//yJNG5bucjk+RL/DrveZPh5MU3
         zsnMuPpQ47Wws8N7T5qxkh4mxzKJvbEIdg1kZ9DLq2jXPJ3WrD1tGqsWc6IBe0nhgR
         LvkfkW1zBXJ6RvB6zFiA4MIJQvRp1hwk5zO4/euXf/QxX7iJq2Lp0/jYMbjIlfH7Gh
         IBk/ilnPHhLKQ==
Subject: [PATCH v1 29/41] SUNRPC: Advertise support for the Camellia
 encryption types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:24:31 -0500
Message-ID: <167362347130.8960.16694201789326175105.stgit@bazille.1015granger.net>
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

Add the RFC 6803 encryption types to the string of integers that is
reported to gssd during upcalls. This enables gssd to utilize keys
with these encryption types when support for them is built into the
kernel.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 157d90a5aef6..6e728a8a3a37 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -275,6 +275,10 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 		ENCTYPE_AES256_CTS_HMAC_SHA384_192,
 		ENCTYPE_AES128_CTS_HMAC_SHA256_128,
 #endif
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA)
+		ENCTYPE_CAMELLIA256_CTS_CMAC,
+		ENCTYPE_CAMELLIA128_CTS_CMAC,
+#endif
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,


