Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECDA6FF231
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjEKNLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjEKNKe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 09:10:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA86E40E5
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:10:27 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4CE53F4DF
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683810625;
        bh=AHYIcvlg5Q9MskWL2MZg375hggjT//gb5ewnFK7RT3Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rCaNFB0nhEza+k9sSuHg9DyXaTn+gN1pv/16z/qzRpcaKxWgj050WjYojybVnqOmG
         gEQhrRxYk92dsUPbeiIA4vK5ViwTrDFa7pZ9iHTUfhapoQYiC/oRE4aU9V4Qvtez6G
         Ru7051Qdww6Utr3/BNBoR7XVIji30pHF1C2gPBroP4fN2CYHM8Ddw+wJRtp1QUPrwb
         +uDzSGPDaX6jGl3srbxqx6Wf+Qf1A21ywrjKdaOzOSTKNiWgJE6QnrEEJK6tXmNkCU
         eYpgj4Uu8womR4zLhcG3eYEveMXPUtYX2RKObypmyvK0lgGBFnvknYySb+2JYHAQ2g
         W5eoaUi25ZTrw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25014b171a4so8301486a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 06:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810624; x=1686402624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHYIcvlg5Q9MskWL2MZg375hggjT//gb5ewnFK7RT3Y=;
        b=UtRec3BGXT1hQA8lImWghDI9tOvTZy+S2RD+ir8YfF4HLv5jOToeCPNUxHTgFP7NqF
         XUOVrHpPAgZkvBREsYNxFUJWz5jbIfiXkvKi5VorGBWz2OutPT+TltcNCUPOw6H040Um
         /Fa590xRZIYpqZ07I9lwE2nfAEDhWDKBzUI471Q1RCAmKOo4dT+4hUZP0RbDg04IKAoQ
         vJFukt+gvlGoJfdgCyf7xAUZ80W2ZL7TsQt/6MgoSTn/y/Ys8auWtiBmytUXVqMG6fFV
         nEZjObpaC198bpRTWub+GFRmOusXDuSLaLlaUrhyNsF5a5LYkXmDhUxJrImntC/j8AE3
         mleg==
X-Gm-Message-State: AC+VfDyVEpb9Yc8CQLQ5nAuloswOH+cHG2wzI/ljBRzufiq+RSL2wwNc
        rYUuF+XKo2+VStuCKYHZ/MjvewLl8mnisqFkaKDW2wwJEDzd5w72Deao9SPirYm2m5hZFVJlFeU
        FsPjVVVsNHyjgyiUGsnv9rjHZgxAwgBiqBTTaeaSCD9RIhQ==
X-Received: by 2002:a17:90b:2250:b0:24d:e123:1eb2 with SMTP id hk16-20020a17090b225000b0024de1231eb2mr21456328pjb.37.1683810624458;
        Thu, 11 May 2023 06:10:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JMhmw+c7UKhhD3GmfDm29FcwiYOuQVJaSEuO+JzoYllgM8Hk5PdULrf0tb55I6HBSwJ8snw==
X-Received: by 2002:a17:90b:2250:b0:24d:e123:1eb2 with SMTP id hk16-20020a17090b225000b0024de1231eb2mr21456307pjb.37.1683810624123;
        Thu, 11 May 2023 06:10:24 -0700 (PDT)
Received: from chengendu.. (111-248-154-232.dynamic-ip.hinet.net. [111.248.154.232])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a9f0b00b0025023726fc4sm11987163pjp.26.2023.05.11.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:10:23 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] nfs(5): adding new mount option 'fasc'
Date:   Thu, 11 May 2023 21:10:18 +0800
Message-Id: <20230511131018.61266-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add an option that triggers the clearing of the file
access cache as soon as the cache timestamp becomes
older than the user's login time.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 utils/mount/nfs.man | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 7a410422..68514fbd 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -574,6 +574,7 @@ The
 .B sloppy
 option is an alternative to specifying
 .BR mount.nfs " -s " option.
+
 .TP 1.5i
 .BI xprtsec= policy
 Specifies the use of transport layer security to protect NFS network
@@ -607,6 +608,19 @@ option is not specified,
 the default behavior depends on the kernel,
 but is usually equivalent to
 .BR "xprtsec=none" .
+.TP 1.5i
+.B fasc
+Triggers the clearing of the file access cache as soon as the cache 
+timestamp becomes older than the user's login time. It is supported 
+in kernels 6.4 and later.
+.IP
+NFS servers often refresh their users' group membership at their 
+own cadence, which means the NFS client's file access cache can 
+become stale if the user's group membership changes on the server 
+after they've logged in on the client. To align with the principles 
+of the POSIX design, which only refreshes the user's supplementary 
+group information upon login, the mechanism uses the user's login 
+time to determine whether the file access cache needs to be refreshed.
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.
-- 
2.39.2

