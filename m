Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA871F329
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFATrD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFATrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 15:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A1189
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685648779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqkHy8ZAPKlr+SHQRkpklX7yxS0TC5cn4LTH+deSobE=;
        b=KbeJHp6jgWXYQkEIsSRHBufPvfSfAiYHtkaVU/bINBITUssxklTR5SRjzJPEoJ/qNzJ4RJ
        aj/Qpay2u81GTU7lHcKneY2u3Xm26KX+nFpAElFaNU4ApEdilyagPHyVeeLW9fcmd8Oq9Y
        B6LXoG/b7pKGSoCKfjDWRmzdgdFrgWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-CpWQFkeIOp2-SXEIRkgfTg-1; Thu, 01 Jun 2023 15:46:17 -0400
X-MC-Unique: CpWQFkeIOp2-SXEIRkgfTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FD12101A52C
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.32.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DBC9E60;
        Thu,  1 Jun 2023 19:46:17 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 1E86E1A27F7; Thu,  1 Jun 2023 15:46:17 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 2/3] nfs(5): Document the write=lazy|eager|wait mount option.
Date:   Thu,  1 Jun 2023 15:46:16 -0400
Message-Id: <20230601194617.2174639-3-smayhew@redhat.com>
In-Reply-To: <20230601194617.2174639-1-smayhew@redhat.com>
References: <20230601194617.2174639-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
 utils/mount/nfs.man | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 3cef2e23..2ed898f8 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -614,6 +614,28 @@ option is not specified,
 the default behavior depends on the kernel,
 but is usually equivalent to
 .BR "xprtsec=none" .
+.TP 1.5i
+.BI write= behavior
+Controls how the NFS client handles the
+.BR write (2)
+system call.
+.I behavior
+can be one of
+.BR lazy ,
+.BR eager ,
+or
+.BR wait .
+If
+.B lazy
+(the default) is specified, then the NFS client delays sending application
+writes to the NFS server as described in the DATA AND METADATA COHERENCE
+section.  If
+.B eager
+is specified, then the NFS client sends off the write immediately as an
+unstable WRITE to the NFS server.  If
+.B wait
+is specified, then the NFS client sends off the write immediately as an
+unstable WRITE to the NFS server and then waits for the reply.
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.
-- 
2.39.2

