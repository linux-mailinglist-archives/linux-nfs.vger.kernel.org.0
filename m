Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7E71F84F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jun 2023 04:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjFBCJy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 22:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjFBCJv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 22:09:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D6138
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 19:09:50 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED8073F234
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jun 2023 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685671788;
        bh=AHYIcvlg5Q9MskWL2MZg375hggjT//gb5ewnFK7RT3Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DXS3O2aUy5NpJgJj0dZwEuXjEcSPxNeHGOhKOtOLn2K5tlAfI5ZQy13gYGblv3l/h
         ecGX90HXtSoVVBdLuDqVof5TKg0RpkpnzR6JozyKjxYpwOboBbG5ejp3zNqxdsRsJv
         cSuNyjCFWixSKPhac33+3bgRtsldf7/4/9XN2qUXqzxZKeDZ/Ibrb6zuv+P75ibYsO
         tGYWA4QRVdsChvc+e4A436wVsGLkwuHEYPopXSjThRoO3ylA5IsDDEdltFmAb7dyyw
         vdPM2mK4oY52+ak7txSVljbps5jsxxVw+jp+Cz0fAqZI0dJmGOilB7EHCTHinNaWkK
         9QmlvU2ijuFOQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b0427acfc3so6801145ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jun 2023 19:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685671787; x=1688263787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHYIcvlg5Q9MskWL2MZg375hggjT//gb5ewnFK7RT3Y=;
        b=AvYK3Bd0eroARhDFntA+A4wzrW3Acn+ajJbJ4HNfsnwiKx6FAvpw9xJkiE9t6LfOYF
         /hF2em+ppoHRdlOJLyoiyo+GN5hpl0q6hzN48lXBd838R4MasU3hHU2V4Itt1/ux3rzL
         UlNo5DUlg9JjkVUQV3YUkvdQm8cc7Zl9ppV611rMQoc8QYFO7xt/Fe+3TQta0/Tx80j6
         PiGkFA+J72zKYCeIdYHy5hHPVkteFawnMPZylQcKzBK9c8wSQzi570hHXmjjsn5blNUZ
         nFOW2hGYO0L9CCILmS5+cBjKGYfLvxv+hHBUmDNMEiJ/SjFTLEZpBkA2NZb7kbzO2JfO
         D0UA==
X-Gm-Message-State: AC+VfDzh+DusCDqWcwml3NZMBZXXsdGTPExutW+2XeYB8CfjunKLGFXO
        5GM7LedAjEiRI1I5S3DCwC+1AHUt/KLWCmY/aeDcWcMmyafMoWVGtVcDYMKAcOE+cJptkgHblt2
        QxLYaE6WufeNJkTSv4VohuFdK8AWlElUN9L2kwfDYxjJuLA==
X-Received: by 2002:a17:902:c20d:b0:1b0:3e2c:53cc with SMTP id 13-20020a170902c20d00b001b03e2c53ccmr775374pll.27.1685671787381;
        Thu, 01 Jun 2023 19:09:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SuiniVBNhFPMD+tSNgyZjekX7tJWuHzb5FmEvdcs6qlg62gIYUMuZLE90vEPJArhvuJyJKw==
X-Received: by 2002:a17:902:c20d:b0:1b0:3e2c:53cc with SMTP id 13-20020a170902c20d00b001b03e2c53ccmr775368pll.27.1685671787091;
        Thu, 01 Jun 2023 19:09:47 -0700 (PDT)
Received: from chengendu.. (111-248-148-133.dynamic-ip.hinet.net. [111.248.148.133])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ab1d23bf5dsm41032plf.258.2023.06.01.19.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:09:46 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH RESEND] nfs(5): adding new mount option 'fasc'
Date:   Fri,  2 Jun 2023 10:09:42 +0800
Message-Id: <20230602020942.43414-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

