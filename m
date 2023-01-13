Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065BF669C4D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjAMPb2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAMPa5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FC81415
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0416B820D4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335DCC433D2;
        Fri, 13 Jan 2023 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623453;
        bh=/1wdiSxGD1EpIWl77hZrX3dtHUMY3lKRAFpNBcpkmPI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SiuKfW+3H/dbjDU5OoPqrDiIqeTP7tuc5z3lRFPU1KW6UmW/OezmWozpveOdQRuxr
         81iOrdeHPPS7eaemGCtviSvRrfoX8DDcZowGH7SMlxAvMRbpqzBBZVmRfwOMQprJxi
         5bo6pgj8zuZoCMxQuHr7Sy3YALCV236RnBEsAl+QErcq8Y0w5fP5Xc9EukzluaeQaB
         XasjjhtjeYJBrIZPuxRCydKjxc6mCe9rcC42qy7rykHL8ehCyJ9KnHCFJAhM2Rat7s
         Jc8s02FAibyU/XLeWq/7o/nEb+yWYGOfIqvizHEWXUeLzHhxfQCLGwQt/EOUoB3pFy
         mIXghzKqqHuUQ==
Subject: [PATCH v1 26/41] SUNRPC: Advertise support for RFC 8009 encryption
 types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:24:12 -0500
Message-ID: <167362345228.8960.10652140004514370977.stgit@bazille.1015granger.net>
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

Add the RFC 8009 encryption types to the string of integers that is
reported to gssd during upcalls. This enables gssd to utilize keys
with these encryption types when support for them is built into the
kernel.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=400
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index fa0b5197fe32..6ef0c7247692 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -214,6 +214,10 @@ static char gss_krb5_enctype_priority_list[64];
 static void gss_krb5_prepare_enctype_priority_list(void)
 {
 	static const u32 gss_krb5_enctypes[] = {
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
+		ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+#endif
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,


