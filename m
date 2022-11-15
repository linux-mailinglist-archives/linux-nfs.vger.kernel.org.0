Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FC6294DD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbiKOJxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 04:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiKOJxi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 04:53:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E429273E
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 01:53:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y14so34715569ejd.9
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myU/5arNNk7NvvHfrDishNpqGempS8a7AqzbQlwYl3c=;
        b=hOVnphEP94dWWBDUUXZ3qxaAeA0pvpDQFgPB4DlG1C7V262I/DIUgjvdnvSlQwZZqa
         R1Cxk+LYZ+9J25DVjqMo2Xq3qP5CVR5akuLUC+Sm9bm2gtocow2Iod1KgjDJtfZGhET6
         GPFZF+kLKh9xLbHbPNtUqbcTszUW/UD3i3bQU46JkWcrJP6Wapo5joe60FwOuhdGf3Zz
         7iOfAIOaS/I6QmY/U7PLDlzhKlOgnR9BZzMmcId5ZKkiDOWseJ/fBYM5gKxfOrBQKik0
         ZK6gJee6k3VLeVgqIN5IZ7jT4A6Uv2PIK8DsBoGYzqR7E/isWFUGgFYU+uOKVxdRVxSg
         mTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myU/5arNNk7NvvHfrDishNpqGempS8a7AqzbQlwYl3c=;
        b=VGXFvsbtdkyW1Fif94FFk3j2+DfSObJOSd6cg/BP32l/RDj+//3ryxEuDOO7ORe9sa
         LWyAOTJk9Swnme50GsVxJ26VrcRhywwPMhRPW3GW7VO5f/eTNaNdrLthcJ1o8semFXE/
         2xMDMDuWlrrCnYAEq28U81qYPp3Y7SqXOakM4RqUYwT+ZV1x5YM4D9EN2vssVOScespd
         N3EWFfhyC8GnnkaYam1IXKkWkSEXyA0id+QUGk+vlA8//gMORUWGhndbggFFNpiHbKoy
         s2zMPh1qRFDCPA01uezdJ2+Ynhw5VUH3GNRfBEbET1j5CVt65U/jftSYo79f0bSEf0qP
         yKKw==
X-Gm-Message-State: ANoB5pn0/UUiK5FS1F4ibNIB2I7HAT+5L82Cr4tzdZgx2fa46IwiZBPt
        0B5prhlrUDvBE90HU2M/MbmI/6rmW70=
X-Google-Smtp-Source: AA0mqf6eq99LBsAXJXmOG/Gag1QktS68zvPKcWxaYIYN5lQO69+kGwxODazEWQh83Ayj8WFud1yriQ==
X-Received: by 2002:a17:906:1f0c:b0:78d:cd72:8e3e with SMTP id w12-20020a1709061f0c00b0078dcd728e3emr12719346ejj.212.1668506008790;
        Tue, 15 Nov 2022 01:53:28 -0800 (PST)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id n28-20020a056402515c00b00458dc7e8ecasm5943106edd.72.2022.11.15.01.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:53:28 -0800 (PST)
From:   yegorslists@googlemail.com
To:     linux-nfs@vger.kernel.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] README: fix mount command
Date:   Tue, 15 Nov 2022 10:53:20 +0100
Message-Id: <20221115095320.10261-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Without device specification, mount tries to mount an entry
from the /etc/fstab file. Hence, specify target "nfsd" to
make this command executable from the command line.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 7034c009..1c19ecd0 100644
--- a/README
+++ b/README
@@ -70,7 +70,7 @@ scripts can be written to work correctly.
 3.1.  SERVER STARTUP
 
 
-   A/  mount -t nfsd /proc/fs/nfsd
+   A/  mount -t nfsd nfsd /proc/fs/nfsd
       This filesystem needs to be mount before most daemons,
       particularly exportfs, mountd, svcgssd, idmapd.
       It could be mounted once, or the script that starts each daemon
-- 
2.17.0

