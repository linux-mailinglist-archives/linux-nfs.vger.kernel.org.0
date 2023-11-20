Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2247F1CF5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjKTSxs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjKTSxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:53:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56FED
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:53:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F907C433C8;
        Mon, 20 Nov 2023 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506420;
        bh=2vp4Zufz1kBPECgcRpwM9djHLwFN7C4H49D2rU0hcoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nU+5DoZgcQudghMy5eu5H9SIcdivi9SAyLal0+wGqAo3f+1nYbOCO8BIPXZVsa8T8
         zj2lWAJRkBamgPUP46ofDuidltsVraT2HfjUHNGOkPhZZvNdhLjUnI/afK4F2OPCZO
         mgeMVXS3cS2Wg3Py+wARrvZa8oskoeEQmxD6eEHCpSvmme2S0y2blAZPysS8px1NxG
         nmfpbX3cVP6mSeHXFiMILWwgRHjrz5/D889RGfuNlOOVORxiMqXtOZpsflWVVRIFuV
         FBQ8WenH8G1CfDnaP9HB1J0fY68x9zBCycT/mtbGfJ9G0srGp/IyhHD20Pv4D7C+Ne
         nDxs4eSM4z5TQ==
Subject: [PATCH RFC 1/5] junction: Replace xmlParseMemory
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 20 Nov 2023 13:53:39 -0500
Message-ID: <170050641955.123525.14000282753998469753.stgit@manet.1015granger.net>
In-Reply-To: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

According to:

https://gnome.pages.gitlab.gnome.org/libxml2/devhelp/libxml2-parser.html#xmlParseMemory

xmlParseMemory() is deprecated. Replace the one call site with a
call to xmlReadMemory().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/junction/xml.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/junction/xml.c b/support/junction/xml.c
index 813110b4f308..ec9586528cc9 100644
--- a/support/junction/xml.c
+++ b/support/junction/xml.c
@@ -290,7 +290,7 @@ junction_parse_xml_buf(const char *pathname, const char *name,
 {
 	xmlDocPtr tmp;
 
-	tmp = xmlParseMemory(buf, (int)len);
+	tmp = xmlReadMemory(buf, (int)len, NULL, NULL, 0);
 	if (tmp == NULL) {
 		xlog(D_GENERAL, "Failed to parse XML in %s(%s)\n",
 			pathname, name);


