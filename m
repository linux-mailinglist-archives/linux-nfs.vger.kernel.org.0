Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5527913E9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjIDIvU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245349AbjIDIvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 04:51:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73E12E
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 01:51:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so11915885e9.3
        for <linux-nfs@vger.kernel.org>; Mon, 04 Sep 2023 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=youngman-org.20230601.gappssmtp.com; s=20230601; t=1693817468; x=1694422268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvOMre4a3YieSW5zcIG1DVNTDoBfGjIpfZWWI1tSO5I=;
        b=Yr9fy9kbN+TCC1eEKTs1INfAqPVyY4xg8kH+viotQqx44dc0qnVkse+3KCNh/0snKZ
         oYcZl1HxugDxhIE1xk0tlo+JTXPoNSnKOkm74dx0x9ZMMI8e35tyK2LMyZtvkg5WsgQV
         hjqixpgSGJgm+ohrx9uV1zcd0LGPDyjWwfmgMCk0zWnxKmrCkf0aebeKyJDuuM4A6OIo
         zILVvmkbagBc14lmQUVqNX/cub2CkJMYHmLv4JJvyfg/JeOPHcbV+cMxbe5x/eyryDha
         dwm0WGmupiAnc7jbdZey1dE92pTbOZ/QCrcFI84cBmhGHg0wEnstyKYml2GwefAoHB6z
         DKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693817468; x=1694422268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvOMre4a3YieSW5zcIG1DVNTDoBfGjIpfZWWI1tSO5I=;
        b=blxi4gEsntXEJQdyaEba9w+bn9Kumg6hK4yMUUJ+gdSEwNjBBIrIKu6QIbOwp9hhW0
         CudEQ/ozN9u7ZvZaPlRvXARaukTbZza6VMyxNnp6nPMu+11XxOZk8ttW+nkK1ySA9pXE
         zfXEbBG8Kg0yDixaXdQHWAZXeip46SNUO9e5T7nnZ59GG9TEHXuxRUmzryxpXZrQbEJa
         VrdiMuhQbXvet9qY4QbftGsJtpr3QqymfdGHw3avsY5PE3FqIrgZutikxuF+jyAUWuwU
         KdSs+ppz23ilIkqs034t4nBdi54gO8VcRFDcjRxuzzWe2h+GXJBRWKv5sgdgHx3y4WHp
         A8FQ==
X-Gm-Message-State: AOJu0Yx8hqKAZOedGx4WQeoge8n9mU4ufp1RbmbvKSLj79+gvE7f+ALQ
        29xlCCwatm7fG9EAMn8YO5yTWttSFjaPnhiWGzAFOQ==
X-Google-Smtp-Source: AGHT+IFVChF7NAav5jdvxaVOGgbtuaMoc7nuFTUOauDK+xvwp1yoWctpHZrEci872pkD8JbWLndBqw==
X-Received: by 2002:a7b:c7d9:0:b0:401:bedd:7d42 with SMTP id z25-20020a7bc7d9000000b00401bedd7d42mr7323624wmk.13.1693817467626;
        Mon, 04 Sep 2023 01:51:07 -0700 (PDT)
Received: from horizon.spiral-arm.org ([86.40.46.168])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bca52000000b003fe601a7d46sm16572390wml.45.2023.09.04.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:51:07 -0700 (PDT)
From:   James Youngman <james@youngman.org>
To:     linux-nfs@vger.kernel.org
Cc:     1051088@bugs.debian.org, James Youngman <james@youngman.org>
Subject: [PATCH] Remove extraneous words left behind by commit 522837f.
Date:   Mon,  4 Sep 2023 09:50:47 +0100
Message-Id: <20230904085047.1053192-1-james@youngman.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

---
 utils/mount/nfs.man | 1 -
 1 file changed, 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 7a410422..c9850f29 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -986,7 +986,6 @@ file. See
 .BR nfsmount.conf(5)
 for details.
 .SH EXAMPLES
-mount option.
 To mount using NFS version 3,
 use the
 .B nfs
-- 
2.39.2

