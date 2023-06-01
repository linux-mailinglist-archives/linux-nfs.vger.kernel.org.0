Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3371F328
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjFATrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFATrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 15:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0118D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685648779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcCjm6j5Lkzo515T96+Acs/cfc5OaO3WQZ2b+eBZkG0=;
        b=EkbCaEeQYNA5+1DevoePIdfuYKwhyHO84urlJztOhW0FgKYcS95s3q3oqLnQWklobaSije
        SJVKItklfF1j2/H0A8CGeDMc8ISbqBCO1CtfTBB2XCpQ9QkNOXrP3bsDmS0aPvP+62wNO9
        2mb9dkKa4OXQW6VpgjyGtrbiX+CKE7M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-vUwb8O6uOraqFtdq2cstsw-1; Thu, 01 Jun 2023 15:46:17 -0400
X-MC-Unique: vUwb8O6uOraqFtdq2cstsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F2FD3C025AD
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.32.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 700B220296C6;
        Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 167A51A27F3; Thu,  1 Jun 2023 15:46:17 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 1/3] nfs(5): Document the softerr mount option.
Date:   Thu,  1 Jun 2023 15:46:15 -0400
Message-Id: <20230601194617.2174639-2-smayhew@redhat.com>
In-Reply-To: <20230601194617.2174639-1-smayhew@redhat.com>
References: <20230601194617.2174639-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/mount/nfs.man | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 7a410422..3cef2e23 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -94,31 +94,38 @@ This option is an alternative to the
 option.
 It is included for compatibility with other operating systems
 .TP 1.5i
-.BR soft " / " hard
+.BR soft " / " softerr " / " hard
 Determines the recovery behavior of the NFS client
 after an NFS request times out.
-If neither option is specified (or if the
+If no option is specified (or if the
 .B hard
 option is specified), NFS requests are retried indefinitely.
-If the
-.B soft
+If either the
+.BR soft " or " softerr
 option is specified, then the NFS client fails an NFS request
 after
 .B retrans
 retransmissions have been sent,
-causing the NFS client to return an error
-to the calling application.
+causing the NFS client to return either the error
+.B EIO
+(for the
+.B soft
+option) or
+.B ETIMEDOUT
+(for the
+.B softerr
+option) to the calling application.
 .IP
 .I NB:
 A so-called "soft" timeout can cause
 silent data corruption in certain cases. As such, use the
-.B soft
+.BR soft " or " softerr
 option only when client responsiveness
 is more important than data integrity.
 Using NFS over TCP or increasing the value of the
 .B retrans
 option may mitigate some of the risks of using the
-.B soft
+.BR soft " or " softerr
 option.
 .TP 1.5i
 .BR softreval " / " nosoftreval
-- 
2.39.2

