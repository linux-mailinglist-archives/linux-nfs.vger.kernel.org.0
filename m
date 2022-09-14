Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB75B8E31
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINRbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiINRbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 13:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28082D24
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663176679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP3Gc16ir0eGZ+1EzBVXgI9LuLQTzv2qXRYSOMhHhjY=;
        b=aWOQSdwuvhFAIly/JPbos9xJUrcdulQkjCAuxsTPS2Yi8erzhD3kiNyOdocEtGw5A11j2U
        Y7KzQfKaLeEcfFfYdsT2DRCknitezh+dworMdC1wowmSc/6uKaIAyHWszzCGioS4BCLMTN
        s4ze+EJTP/tcv5MRMRC9b3TE5hAbnFs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539--mHj1njSMKyndaCWPWvImQ-1; Wed, 14 Sep 2022 13:31:18 -0400
X-MC-Unique: -mHj1njSMKyndaCWPWvImQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD133C10149
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 17:31:18 +0000 (UTC)
Received: from plambri-t490s.homenet.telecomitalia.it (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D6440C6EC2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 17:31:17 +0000 (UTC)
From:   Pierguido Lambri <plambri@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2 2/2] nfs4_setfacl: update man page about new option index
Date:   Wed, 14 Sep 2022 18:31:15 +0100
Message-Id: <20220914173115.296058-2-plambri@redhat.com>
In-Reply-To: <20220914173115.296058-1-plambri@redhat.com>
References: <20220914173115.296058-1-plambri@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The man page now reflects the newly added syntax to handle indexes.

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
---
 man/man1/nfs4_setfacl.1 | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/man/man1/nfs4_setfacl.1 b/man/man1/nfs4_setfacl.1
index 47ab517..61699ae 100644
--- a/man/man1/nfs4_setfacl.1
+++ b/man/man1/nfs4_setfacl.1
@@ -30,27 +30,21 @@ Refer to the
 manpage for information about NFSv4 ACL terminology and syntax.
 .SS COMMANDS
 .TP
-.BR "-a " "\fIacl_spec\fP [\fIindex\fP]"
+.BR "-a " "\fIacl_spec\fP"
 .RI "add the ACEs from " acl_spec " to " file "'s ACL."
-ACEs are inserted starting at the
-.IR index th
-position (DEFAULT: 1) of
+ACEs are inserted starting at the default position 1 of
 .IR file "'s ACL."
 .\".ns
 .TP
-.BR "-A " "\fIacl_file\fP [\fIindex\fP]"
+.BR "-A " "\fIacl_file\fP "
 .RI "add the ACEs from the acl_spec in " acl_file " to " file "'s ACL."
-ACEs are inserted starting at the
-.IR index th
-position (DEFAULT: 1) of
+ACEs are inserted starting at the default position 1 of
 .IR file "'s ACL."
 .TP
-.BI "-x " "acl_spec \fR|\fP index"
+.BI "-x " "acl_spec \fR"
 delete ACEs matched from
 .I acl_spec
-- or delete the 
-.IR index th
-ACE - from 
+from
 .IR file 's
 ACL.  Note that the ordering of the ACEs in
 .I acl_spec
@@ -61,6 +55,10 @@ delete ACEs matched from the acl_spec in
 .IR acl_file " from " file "'s ACL."
 Note that the ordering of the ACEs in the acl_spec does not matter.
 .TP
+.BI "-i " "\fIindex\fP"
+.RI "ACEs are inserted or deleted starting at the " index "th position (DEFAULT: 1) of file's ACL.
+It can be used only with the add or delete action.
+.TP
 .BI "-s " acl_spec
 .RI "set " file "'s ACL to " acl_spec .
 .TP
@@ -189,6 +187,10 @@ add the same ACE as above, but using aliases:
 .br
 	$ nfs4_setfacl -a A::alice@nfsdomain.org:RX foo
 .IP - 2
+add the same ACE as above, at index 2:
+.br
+	$ nfs4_setfacl -i 2 -a A::alice@nfsdomain.org:RX foo
+.IP - 2
 edit existing ACL in a text editor and set modified ACL on clean save/exit:
 .br
 	$ nfs4_setfacl -e foo
-- 
2.37.3

