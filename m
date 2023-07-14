Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0977542A4
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjGNSgY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjGNSgW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 14:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEA26B6
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 11:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87DBE61DC2
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0933C433C8;
        Fri, 14 Jul 2023 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689359779;
        bh=Dv12fPbn55bYujD9Y8vvYBg+PDh+dMBt+YEUEyQgtrU=;
        h=Subject:From:To:Cc:Date:From;
        b=fuak3dJeVNJOJcnZ6qxBHC+na72LPWu5oQ/wdSm1lno58CGAxPOXm7p5iFf1lTInv
         lbxcWk7lI39yWZEF7i6f1u9l0eb6BOZTQ96ujPUhDTZtTAOekU9WmWw3FASYNQADJf
         gZ9dFde0Qy7Olej4ZVFsTVCCbQ5x2u0ZMUKujkmjvNoc44AyRoTJWbQyxGU7nkvvPs
         Y5a7ijqHlmll+rlWheGly5FiyDdkFBI91YY+/YLOyD0g8OC89ktBIziFRTJ7hrwzYB
         J4ZAQQF2DvlqumplTrlzkTFd/wq7kzr+FOyaXicyR7eAKda68bjnEG3B3OrlMvHflt
         8w1bq3+RkPSjw==
Subject: [PATCH v1] nfs(5): Document the new "xprtsec=" mount option
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Fri, 14 Jul 2023 14:36:18 -0400
Message-ID: <168935977873.1850.8214830433103692090.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 utils/mount/nfs.man |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index d9f34df36b42..dfc31a5dad26 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -574,7 +574,43 @@ The
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
+If either
+.B tls
+or
+.B mtls
+is specified and the server does not support RPC-with-TLS or peer
+authentication fails, the mount attempt fails.
+.IP
+If the
+.B xprtsec=
+option is not specified,
+the default behavior depends on the kernel version,
+but is usually equivalent to
+.BR "xprtsec=none" .
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.


