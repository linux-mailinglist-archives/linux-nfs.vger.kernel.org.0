Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40778A565
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjH1Fxo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 01:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjH1Fxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 01:53:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A2115
        for <linux-nfs@vger.kernel.org>; Sun, 27 Aug 2023 22:53:32 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B22B23F12F
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693202011;
        bh=1EdiZtk+rCvL0vfX6cuCtDrMpn2tMOvoJRqg47DcDsQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cmthtCz9uOTQoPfuRs4ymj1olSjD3P8TosHJGzbdaJmMrlSlBLJzaeo9/cH33+If/
         vaoiyXjjyCaQRXSZzLMHYZ010R5Yi2I6tt0AYkc4j6MoP6wFuevQ3kem6slKF9xgro
         4ZWSXeY/RLxvtBjw1mAC4vyFwsevR7r0O5THiro+baTk0fDJV4x9iN8338DBN8S9+b
         FAKhtwlbs8hoNKBN7Ex9zUoyP0K0lWuBPqRKpOl4ZE0k0JtkLBpIKPz7NUeoGx3lyF
         W+++hhtZ3nkKTcxf8Xx5vEGGaYjXrSRRVMi/LWHa4S04rv6w1q+3dd9MaNAAYl10Lw
         IO4pnv5AQlASw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c09c1fd0abso26248005ad.2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Aug 2023 22:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693202010; x=1693806810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EdiZtk+rCvL0vfX6cuCtDrMpn2tMOvoJRqg47DcDsQ=;
        b=f9QgnSpawErxxn5pDq+3ttaYPCu5mdrTbsFlW858lfyI6TZjscCzYXzYffirJLdRid
         VJ0kJ3fy1hS5M19MSyAf86ltgMLwexQz2IRITvavpLNhmPeFO2Ay4egaBbE50tGJoQvF
         H4kqNUy0PVgnFNyv2b5Rk6kbx9n0lpEl896yRPj1cf3myW/sdcSAGaxdWv9hDdrI+flH
         vrURKS2KQcf0ZdTkzNo5gzpWQyNt2dvcDD9m2LZBjQbDBVSmuWG5d4d0RlGLhMXVcF5j
         MfLkHeu/ZPoEj8J5WTIBCHQcqJ3z5YNZicU7VeECUUOQVp+VsyhRT91sG7aP89adfpiX
         3qrg==
X-Gm-Message-State: AOJu0YwWb6NUzJsTtO16gmujIBPQm0GgJHYlHQcO6EOmBwf34RyBzPZ1
        LaeEk4423JZNgeYCyAnSICYHn/X4iFzcAPu0+oPT7b+mKpqDR+9hYBwNdUcbF0w8hmmdEHbnVtQ
        l559YxtDuKsBoE7k+VExYo29wdXp7RN2wca4lSg==
X-Received: by 2002:a17:903:2304:b0:1c0:d17a:bff2 with SMTP id d4-20020a170903230400b001c0d17abff2mr7367432plh.20.1693202010430;
        Sun, 27 Aug 2023 22:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgPmx1Mxb+XEs1rREv5yU5L/zaLOQbtFNDMF+9yA+FLdTg66hoAGMLmbs2F5RwkQjBO0FG6A==
X-Received: by 2002:a17:903:2304:b0:1c0:d17a:bff2 with SMTP id d4-20020a170903230400b001c0d17abff2mr7367418plh.20.1693202010063;
        Sun, 27 Aug 2023 22:53:30 -0700 (PDT)
Received: from chengendu.. (111-248-129-25.dynamic-ip.hinet.net. [111.248.129.25])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001bdf046ed71sm6319346plb.120.2023.08.27.22.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 22:53:29 -0700 (PDT)
From:   Chengen Du <chengen.du@canonical.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v3] nfs(5): adding new mount option 'fasc'
Date:   Mon, 28 Aug 2023 13:53:24 +0800
Message-Id: <20230828055324.21408-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 utils/mount/nfs.man | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 9b4bc9c9..2ac7b4ad 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -608,6 +608,19 @@ option is not specified,
 the default behavior depends on the kernel version,
 but is usually equivalent to
 .BR "xprtsec=none" .
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

