Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62F7F1CF6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKTSxv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjKTSxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:53:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C37BC8
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:53:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBE5C433C8;
        Mon, 20 Nov 2023 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506427;
        bh=My3stO6oFd/9rUFAB5HQqsIZaehpceYJCE0n7ue6+Z0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VNk3X4rUaTsIE4vtFNDaYxx5AB+OLre6frEn3k7K5pUBQDP7+4IHBzAPSg9xNXQy2
         f3XREFMuWJc25k85clbwApX1pDwUAUpY6MZTSr/Cc9W3pEfed8on3OMKT6BWGaRxFh
         w94gXMUXbsttLFpDRpL9z7kw6rHRNjkqW0WKQGszztxv9NUEl1od3z2Vz7vG6BlZwW
         NhGHLs2avpcv8B3d7fmxhj/JaPOE1In4DW4FHRo1n6+9ZdQBadOfUI88YDntOuqYto
         10r+2etsTY2SWElN1b0sczFcD4GNRZUUXQCz5aAYlpqqB8S6Re5BdpgCU3Y9eNCJ+d
         +PQjpR8/2n78w==
Subject: [PATCH RFC 2/5] junction: Remove xmlIndentTreeOutput
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 20 Nov 2023 13:53:46 -0500
Message-ID: <170050642602.123525.1034811730816028179.stgit@manet.1015granger.net>
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

Though it doesn't seem to be marked deprecated, xmlIndentTreeOutput
does not appear in recent versions of libxml2. Since

  xmlIndentTreeOutput = 1;

should be the default behavior now, we can remove this statement
without a behavior change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/junction/xml.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/support/junction/xml.c b/support/junction/xml.c
index ec9586528cc9..aef1cbbd74d3 100644
--- a/support/junction/xml.c
+++ b/support/junction/xml.c
@@ -387,7 +387,6 @@ junction_xml_write(const char *pathname, const char *name, xmlDocPtr doc)
 		return retval;
 
 	retval = FEDFS_ERR_SVRFAULT;
-	xmlIndentTreeOutput = 1;
 	xmlDocDumpFormatMemoryEnc(doc, &buf, &len, "UTF-8", 1);
 	if (len < 0)
 		goto out;


