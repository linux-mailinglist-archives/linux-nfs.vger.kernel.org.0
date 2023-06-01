Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44471F32A
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFATrH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjFATrH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 15:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114E184
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685648778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8OTCkfhnXCqr3MSd46tEPZird3E+hLWGbqbVPI2Tf8=;
        b=C/GtXd/77+rCCpo36eB6Oh3Y1cX20XOCHmkLpl1d1NlX57xKhPA1tkL1LYJulE/p5VDl0a
        eze/IjDsdzUaLI+Hx8AmRXXhCfi3e8A95iI2iE4LwfBbfyRRQi7s57rbwBY2TUHQiUedkK
        wXJOKrimL+OkC0agOy5JZOddRTlYQto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-XCOjvm7iPmK2PwcYSNZSDQ-1; Thu, 01 Jun 2023 15:46:17 -0400
X-MC-Unique: XCOjvm7iPmK2PwcYSNZSDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81220800888
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.32.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75E1CC154D7;
        Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 22F5C1A27F8; Thu,  1 Jun 2023 15:46:17 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 3/3] nfs(5): Document the trunkdiscovery/notrunkdiscovery mount option.
Date:   Thu,  1 Jun 2023 15:46:17 -0400
Message-Id: <20230601194617.2174639-4-smayhew@redhat.com>
In-Reply-To: <20230601194617.2174639-1-smayhew@redhat.com>
References: <20230601194617.2174639-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also, move the documentation for max_connect to the section for
NFSv4-specific options.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/mount/nfs.man | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 2ed898f8..0b976731 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -423,19 +423,6 @@ Note that the
 option may also be used by some pNFS drivers to decide how many
 connections to set up to the data servers.
 .TP 1.5i
-.BR max_connect= n
-While
-.BR nconnect
-option sets a limit on the number of connections that can be established
-to a given server IP,
-.BR max_connect
-option allows the user to specify maximum number of connections to different
-server IPs that belong to the same NFSv4.1+ server (session trunkable
-connections) up to a limit of 16. When client discovers that it established
-a client ID to an already existing server, instead of dropping the newly
-created network transport, the client will add this new connection to the
-list of available transports for that RPC client.
-.TP 1.5i
 .BR rdirplus " / " nordirplus
 Selects whether to use NFS v3 or v4 READDIRPLUS requests.
 If this option is not specified, the NFS client uses READDIRPLUS requests
@@ -1000,6 +987,32 @@ when it identifies itself via a traditional identification string.
 .IP
 This mount option has no effect with NFSv4 minor versions newer than zero,
 which always use TSM-compatible client identification strings.
+.TP 1.5i
+.BR max_connect= n
+While
+.BR nconnect
+option sets a limit on the number of connections that can be established
+to a given server IP,
+.BR max_connect
+option allows the user to specify maximum number of connections to different
+server IPs that belong to the same NFSv4.1+ server (session trunkable
+connections) up to a limit of 16. When client discovers that it established
+a client ID to an already existing server, instead of dropping the newly
+created network transport, the client will add this new connection to the
+list of available transports for that RPC client.
+.TP 1.5i
+.BR trunkdiscovery " / " notrunkdiscovery
+When the client discovers a new filesystem on a NFSv4.1+ server, the
+.BR trunkdiscovery
+mount option will cause it to send a GETATTR for the fs_locations attribute.
+If is receives a non-zero length reply, it will iterate through the response,
+and for each server location it will establish a connection, send an
+EXCHANGE_ID, and test for session trunking.  If the trunking test succeeds,
+the connection will be added to the existing set of transports for the server,
+subject to the limit specified by the
+.BR max_connect
+option.  The default is
+.BR notrunkdiscovery .
 .SH nfs4 FILE SYSTEM TYPE
 The
 .BR nfs4
-- 
2.39.2

