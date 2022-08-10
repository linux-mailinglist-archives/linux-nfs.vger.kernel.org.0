Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AF58EB67
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiHJLk3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Aug 2022 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHJLk1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Aug 2022 07:40:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1237642FE;
        Wed, 10 Aug 2022 04:40:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dc19so27122841ejb.12;
        Wed, 10 Aug 2022 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=DdJp4UZHmlYx0A4VYaHgo2wRMc0wfMVM5lOUKK2ThO4=;
        b=Bz3ob9RtssQY/+VrStqxVSL4x5lN7bbl61PFrrY73Et0lNuTTiOR2vflxTmV/gGAGu
         hk/sGeRPQDy7JQQQ4fHpsGdSze1U6Hgc36NK441s5/sC+QLnyxOTos5GVqXog7HKeLgE
         jpQffK0TfRZJATt65GZTuMXONlSdTU8y0UZpMnExkSCX9kxyit+7b3DnQ1PHeBF1K46A
         EbO5S5s5qHaf4m8r3EVBPh6WjsxrlTWub5u5YE2BcSbS4pUqiyGWqp8L+/DJGlrWs9rj
         88/Ta4hbjAf1paypvJz6kPFuu+mQU8DYFdsoEjGVF5TW6ebz9SQTTVqIUaPjmPPdXySn
         iESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DdJp4UZHmlYx0A4VYaHgo2wRMc0wfMVM5lOUKK2ThO4=;
        b=cTdPNDUAuvd0zZv3zeOAdikI8ovE9DKUERQVzzVzn5Rt3RMAJiXfGI0OjAUDQWGMX5
         AQImxqOV8oUdxG8gxHhZtivIlZFk1R93chi9Yipn4Cqvz55vUZw+HjcqYxPscDbMmdJ6
         1zOXzVzku7PvA/t0IWAMduSOV+k9BZ8nIoWLQQtL9/brUUcWnjfoUlF7F1JsFUzivgsr
         +2ZX9ycP8U7RgEY/i8b2bxxkjCZQnTJChxJzTd2rjUD7PDDPJ0a7dRw3N1YoS3ODA2xO
         PMIhqU2aKICr9fNPZHvMfQfl+BXrHYgqU9J970Xjqhf2kJ1hP2UyQYCFTUV7JWLNF7gt
         hxZg==
X-Gm-Message-State: ACgBeo2C9ufDhDmO4VyI18RfhvXYdoAb4V9l2IDFgGmjEUrtVPZJhypx
        bvu50xrUwnfIQNpvMZWr78X9ZU/ehX0=
X-Google-Smtp-Source: AA6agR4hTX2FKtOUU9qMLkpuVYHtU3N3YoJFjdkyuHvvYrlgWecJoyMlHenkzTFbRxSnaYNXYypt8w==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr21037817ejc.66.1660131620373;
        Wed, 10 Aug 2022 04:40:20 -0700 (PDT)
Received: from felia.fritz.box (200116b826708900bd59055014c64746.dip.versatel-1u1.de. [2001:16b8:2670:8900:bd59:550:14c6:4746])
        by smtp.gmail.com with ESMTPSA id ec22-20020a170906b6d600b00730560156b0sm2213435ejb.50.2022.08.10.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:40:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] NFS: clean up a needless assignment in nfs_file_write()
Date:   Wed, 10 Aug 2022 13:40:01 +0200
Message-Id: <20220810114001.13513-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 064109db53ec ("NFS: remove redundant code in nfs_file_write()")
identifies that filemap_fdatawait_range() will always return 0 and removes
a dead error-handling case in nfs_file_write(). With this change however,
assigning the return of filemap_fdatawait_range() to the result variable is
a dead store.

Remove this needless assignment.

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/nfs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d2bcd4834c0e..f2ad9495ee4a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -658,9 +658,9 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 	}
 	if (mntflags & NFS_MOUNT_WRITE_WAIT) {
-		result = filemap_fdatawait_range(file->f_mapping,
-						 iocb->ki_pos - written,
-						 iocb->ki_pos - 1);
+		filemap_fdatawait_range(file->f_mapping,
+					iocb->ki_pos - written,
+					iocb->ki_pos - 1);
 	}
 	result = generic_write_sync(iocb, written);
 	if (result < 0)
-- 
2.17.1

