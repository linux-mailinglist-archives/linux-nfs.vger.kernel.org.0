Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17666606C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAKQ2K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjAKQ1u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 11:27:50 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947C3592E
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:25:39 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id fd15so4222397qtb.9
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSmCxbrguX9JK8DdpZDn5eJMz1dapG9KJ1fXWHJ83k=;
        b=YDAtZSObXSHv4ZIVIG7ZjAIdc7UdjBwqyBaJHEn3dtzhcsCPjBGLSCD4er/95DdHjO
         dajni2+TWnFCXJ41e0HwBZsWkxL5cWTWgis67ylD2WaZ3+Wlr4QixWsMHGgilUC7L+7q
         s8qhHY38duArHVTNG0lMiWq5YHIAmQlIijwicitHvAXoiKYAYg10+OMEmNsx7DR0dfpW
         WAzCSqr/hqEgrZ09TeXToY2J6QIgERT2MU87V/sCs8ebMNn1XcSRPakaUYPzWeHe6lT7
         FoVzSUise0hX6Rf+39UerNCNRAk75EMctDZsDFFfF8Tzl9/JZPJnfpLKLrwGIt4Dqdn4
         1nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrSmCxbrguX9JK8DdpZDn5eJMz1dapG9KJ1fXWHJ83k=;
        b=lRHe+VO8xsVDsCKxAbNneN6o1lzMfNmSq+4syQ1/rrBLl5UrfQs+JeamZoqj8U8TsF
         eglBj8xuT3/u2DDkEwB2TM8Jkp7MX0RrLMrDvmQF+EXqzwYPIwYX5aJspvu8qurS24wd
         NX7tbJPpVKRjVdmfJIB/yHuGLJtD2vEHeoSmS4omckVCA0vVd6rlnsouuAOQnWvNudd5
         G8pkFZ0h2TjexqaEF/om+P40Y7RkYXO0nwF4LgSLDyc480X8FwKI+d8QJf+uhPcfX7GL
         InIQ7m0n+GXd4SF0VBkKusv26qsVcc5vK+OQKN4rfnUTjRSpQHW8E6LyBHhqkplcyhnV
         cn4Q==
X-Gm-Message-State: AFqh2kpMBkU6T7Acgb9cV5XBwfQIktdVHN1cHCFDmETFa3H7TyGIyhO5
        bckVcBaOz/ePq+ElaHw0vIY=
X-Google-Smtp-Source: AMrXdXvNbTQzKJEkJOaC3VMda0UALd9sMG0aBU6Bnq1o3u04N6WcSdRzMNeeHGi2CKlEFqb/CVU15A==
X-Received: by 2002:a05:622a:8c8:b0:3ad:fdb5:46c8 with SMTP id i8-20020a05622a08c800b003adfdb546c8mr15188998qte.10.1673454339105;
        Wed, 11 Jan 2023 08:25:39 -0800 (PST)
Received: from localhost (ec2-44-201-124-83.compute-1.amazonaws.com. [44.201.124.83])
        by smtp.gmail.com with ESMTPSA id ay28-20020a05622a229c00b003a50d92f9b4sm7740741qtb.1.2023.01.11.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:25:38 -0800 (PST)
From:   Xingyuan Mo <hdthky0@gmail.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, dai.ngo@oracle.com,
        Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH] NFSD: fix use-after-free in nfsd4_ssc_setup_dul()
Date:   Thu, 12 Jan 2023 00:24:53 +0800
Message-Id: <20230111162453.8295-1-hdthky0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If signal_pending() returns true, schedule_timeout() will not be executed,
causing the waiting task to remain in the wait queue.
Fixed by adding a call to finish_wait(), which ensures that the waiting
task will always be removed from the wait queue.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
 fs/nfsd/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bd880d55f565..3fa819e29b3f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1318,6 +1318,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 			/* allow 20secs for mount/unmount for now - revisit */
 			if (signal_pending(current) ||
 					(schedule_timeout(20*HZ) == 0)) {
+				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
 				return nfserr_eagain;
 			}
-- 
2.34.1

