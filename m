Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09EA664BA8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjAJSxA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239743AbjAJSwL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:52:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977395564D
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:45 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so7507132otp.9
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxCLd5eKTaBauVbpS1dHjWWTZQ+FKdga7/8xoNKcAGU=;
        b=P/vF4FTTr3/WvPABBq7MV2Hqs08U7w+zE6E4jdHMGvkJM2wRq+XsqP5hsvSOB6HZ8n
         6IYREVH/j5dtM0Mn/080bQrT2rfTZj0QPffwFMdDpMdLhspypdg00mA0dJrjOl7a8fNy
         kHLoE5x3QBORsHzzSHPabDyTh1K+KP6M00fkgYpIoPEwQkfgEGK9aZdQbDJF3FHi4vDw
         L1QlM1kv8vYaKZef8wJ2xWflZtRsIvNQ0WZ/cda6V7rQJ6L2+te04hm0Vm4Qx4rQe0LB
         DzTgR35inD7PRwgDlRNWDq6Yz2LgD03+uyRsa+wLkO/6BUUWPFgPC0BmFaPImoPdts+U
         zssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxCLd5eKTaBauVbpS1dHjWWTZQ+FKdga7/8xoNKcAGU=;
        b=nvQWdf03svBhXFU6MTr4vo8+COiwGyAXQju3WfOGGwzFZBImyoCQZfbVRAdVNecq1r
         E15MoV2fPS7FVhqInFkl7KZU/JBBBvgpFyWojwyEItMTHt6iis9Px3yuEJTdmjBfwtaV
         lJlGXgaJhGVlxZoKE87N4ZMvqu5bXgpVFy+FNPN4gl3PHdhpjF2+BUGCx7or8ZviVB7N
         dBSsd2eX+WX/CZiPCftgmSvSvn3DT0bacZl0NoqOBmEZyu3hXGyQ5afz2B1Z0RYHRVuS
         /cFVCIzCTdNkcOUp/orH7456gOOT0yteM/D0vrY+clOkLekI2ZGe+9Ej9YidPLlApfFd
         1qaQ==
X-Gm-Message-State: AFqh2kqRQ/AB02BKLhbGcR1axtafRABN0vNGQEvQ/ARfcvDke8WgNzc/
        L53dnu6koA9QmKRg3YWrA0glxOiEY0E=
X-Google-Smtp-Source: AMrXdXssi0B8lXqOkCVy8sYOQBgDxoDFPwxy8p8AayKgFhrJzWwcNil8NSYmCO1cJLt9UWXAee7fbQ==
X-Received: by 2002:a9d:7341:0:b0:66d:c9f6:5528 with SMTP id l1-20020a9d7341000000b0066dc9f65528mr34238992otk.24.1673376404399;
        Tue, 10 Jan 2023 10:46:44 -0800 (PST)
Received: from localhost.localdomain (cpe-24-28-172-218.elp.res.rr.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm6438775oth.81.2023.01.10.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:46:43 -0800 (PST)
From:   Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To:     linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, Anna.Schumaker@netapp.com
Subject: [PATCH v1 0/2] add support for IO_ADVISE
Date:   Tue, 10 Jan 2023 11:46:39 -0700
Message-Id: <20230110184641.13334-1-mora@netapp.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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

Adds support for using the NFS v4.2 operation IO_ADVISE to
send client I/O access pattern hints to the server.

There is a one-to-one correspondence between the advice
(POSIX_FADV_*) given in fadvise64() and the bitmap mask sent
to the server. Any other advice given, results in just
calling generic_fadvise().

The bitmap mask given by the server reply is just ignored
since the fadvise64() returns 0 on success. If server
replies with more than one bitmap word, only the first word
is stored on the nfs42_io_advise_res struct and all other
words are ignored.

Added trace point (nfs4_io_advise) for this operation:
nfs4_io_advise: error=0 (OK) fileid=00:32:4217220 \
  fhandle=0x4a271991 stateid=0:0x30b83748 offset=0 \
  count=200 arg_hints=SEQUENTIAL res_hints=SEQUENTIAL

Jorge Mora (2):
  NFS: add IO_ADVISE operation
  NFSv4.2 add tracepoint to IO_ADVISE

 fs/nfs/nfs42.h            |  1 +
 fs/nfs/nfs42proc.c        | 68 +++++++++++++++++++++++++++++++
 fs/nfs/nfs42xdr.c         | 84 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4file.c         | 37 +++++++++++++++++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4trace.h        | 75 ++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c          |  1 +
 include/linux/nfs4.h      |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   | 28 +++++++++++++
 10 files changed, 297 insertions(+)

-- 
2.31.1

