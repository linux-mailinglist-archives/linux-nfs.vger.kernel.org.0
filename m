Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEC74CFF2
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGJIbk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjGJIbh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 04:31:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DAFEA
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 01:31:32 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE9383F1EE
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688977890;
        bh=bTPODeNJn5OQjO2kyHnWOYmaKj5zTcdGD0OMjQ+njLE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=G/cY/evWBLp8MYXKN1qkNSyT6m/ZEaiF+y5fSgznNfEnjToHputTGIZ3fRfU01/px
         UKf3lV2/FHGHcQ930GDhCBAE84fxpw4BPUAZgqWdTA+DX8YeN2LcmCq1LY+NG34CQN
         td7ADyEhOn5Eh4eG2sft3RVyMCITCGUl0ueazMGmiIc4/wnpxmHEeU8gRlgawr1wRv
         MBAeELsANfA1bGmeOzJShQtKv1oNE9Q2lw1kpDVbie5rC4wo0JLNBb3l5DzrJ/Ymj+
         h/olvyoNeIKDTPV1/mcU868zi59I3NbfkgaNa/4My01o4SJ0K4rHK8TOLNMyQNWclx
         +uTR0eF+TfRwg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b8a44ee130so52933035ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 01:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977889; x=1691569889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTPODeNJn5OQjO2kyHnWOYmaKj5zTcdGD0OMjQ+njLE=;
        b=TeZbIi7S5hA2mc2TgVSTpLF4ZJbE/RVF5XdC94wYyQeg1yVS8/K6NJpWDj7xNj1bbv
         9BbTv3yzuox1ibgBDcYKhKIqSyHLmzMqEwL3RpLp4be/Rj2JnDLijgHRq2X7iDItArEw
         TAEERer/ppCmH7hDxqVnLYDNBVJU3eTy9Wy0Q0ylFiZjXe/GmGz5spTbSzSP56gF08km
         3ViN3i8ogD7oqKuxKEZZoUhJVmNCReQ3an9kQuBR2fOfDSj7znnIjS3C+oCWV2L48nS+
         WjY7A0UMc8q3squho2+YQpx5uzN8A8txIfBNUSmc72zfqVlutitrF7JB93RwECYd2KKx
         ZPJw==
X-Gm-Message-State: ABy/qLZZyGzMcpk6xQ0EqBVNdUDYGkPS2H4Jcnj5RpNN3Zrez8uwhTMB
        JsHIPmfOlBr1snHbEgRJZ3VCO8LrePm0maa14Uj7UjoMCfKuruGjqesUgGAuFFfPuHsaE/JSOaN
        FcensE9K7GMZ3zaTpeBwauX53noJ8EPrdU4SktJtVBHt1cA==
X-Received: by 2002:a17:903:2594:b0:1b5:fb8:a821 with SMTP id jb20-20020a170903259400b001b50fb8a821mr8697202plb.13.1688977889246;
        Mon, 10 Jul 2023 01:31:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7vGbE1VkFf5LJLIneXwjDsAIriuGTGcscE3UqWNuuGZCB7PLaVCwQf5O2bI/Pvqi6Jfq9xQ==
X-Received: by 2002:a17:903:2594:b0:1b5:fb8:a821 with SMTP id jb20-20020a170903259400b001b50fb8a821mr8697197plb.13.1688977888913;
        Mon, 10 Jul 2023 01:31:28 -0700 (PDT)
Received: from chengendu.. (111-248-146-212.dynamic-ip.hinet.net. [111.248.146.212])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902694c00b001b672af624esm7651133plt.164.2023.07.10.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:31:28 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v2] nfs(5): adding new mount option 'fasc'
Date:   Mon, 10 Jul 2023 16:31:24 +0800
Message-Id: <20230710083124.73083-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 0b976731..c9848838 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -568,6 +568,7 @@ The
 .B sloppy
 option is an alternative to specifying
 .BR mount.nfs " -s " option.
+
 .TP 1.5i
 .BI xprtsec= policy
 Specifies the use of transport layer security to protect NFS network
@@ -623,6 +624,19 @@ unstable WRITE to the NFS server.  If
 .B wait
 is specified, then the NFS client sends off the write immediately as an
 unstable WRITE to the NFS server and then waits for the reply.
+.TP 1.5i
+.BI fasc
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

