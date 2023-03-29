Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490C66CDB9B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2OJt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjC2OJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 10:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283349CC
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 07:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72D76B82339
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 14:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D425AC433EF;
        Wed, 29 Mar 2023 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098913;
        bh=mvyaeUidnCu1hCTb0KA/7gZiUVW3H2O1ynjmseAyXB0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NTssCnAY54b04qMvrQV2JzBlbB2YDc09bSPoQGKMOtT4A0STrbhhfP/j/cJ9JdHQI
         X3F4l2NlpdzLnIFrptBdFvWRP8J5UqXyp9rDV8zh+RQh55lAhNeXNvvzqb9KfSwlGT
         2JJ3Afdl+fQOo799ayeclrmWmuZS1d9QQXAe3g6CY29sOVyrN5H70GU9j582jNlJtZ
         Hv94SYE6IIgg3NN9aStLALWQfuTbQnVU0l8GLh+0a6a97imW0/gDtIxKx7Lp9AicYC
         93tsRapL5xyn/r05tbVGG7z38ZocJhgCiodTOQJ+1qrkKOIi4Qsp5rCDYDUEzGDTLe
         qtCVLOakuSDYA==
Subject: [PATCH v2 4/4] nfs(5): Document the new "xprtsec=" mount option
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 29 Mar 2023 10:08:31 -0400
Message-ID: <168009891187.2522.6811718417615257679.stgit@manet.1015granger.net>
In-Reply-To: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

More information about RPC-with-TLS and some brief set-up guidance
are to be provided in a separate man page in Section 7.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/mount/nfs.man |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index d9f34df36b42..7a410422897c 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -574,7 +574,39 @@ The
 .B sloppy
 option is an alternative to specifying
 .BR mount.nfs " -s " option.
-
+.TP 1.5i
+.BI xprtsec= policy
+Specifies the use of transport layer security to protect NFS network
+traffic on behalf of this mount point.
+.I policy
+can be one of
+.BR none ,
+.BR tls ,
+or
+.BR mtls .
+.IP
+If
+.B none
+is specified,
+transport layer security is forced off, even if the NFS server supports
+transport layer security.
+If
+.B tls
+is specified, the client uses RPC-with-TLS to provide in-transit
+confidentiality.
+If
+.B mtls
+is specified, the client uses RPC-with-TLS to authenticate itself and
+to provide in-transit confidentiality.
+If the server does not support RPC-with-TLS or peer authentication
+fails, the mount attempt fails.
+.IP
+If the
+.B xprtsec=
+option is not specified,
+the default behavior depends on the kernel,
+but is usually equivalent to
+.BR "xprtsec=none" .
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.


