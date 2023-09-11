Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134A79BEED
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353962AbjIKV7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbjIKS5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:57:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8621B6
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-655d1cf74faso19493716d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458617; x=1695063417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0/qIh7VMschCkXSU1Pfg8gu15pfpuF60zgwAz0sY5k=;
        b=s5amDxYqmuJBdg0XEEQtIitzWfIaA3+ZiuDb1aEXl4C6T9mexTCWoYoM8xag29IlaU
         gEYLMxdx4PHg/sA3zuOMjNHT/vy9tH8cNdTlRD4pqa/vTmFxOvZbw6rGM0HlRkUmk4BO
         lVNy/pSWlA9E7uIQVfnU/UCpusd1kvgq+F5bzgJ7Z5vjgKZOGlEyZe7gImp1EQRRst+8
         byGNzilPCO+yWBZbyqLIA3stXL2/PKUB1nLxIIlWLyhyNNQ1c+FLS3ApjbLHQ8kabeW1
         Bg6NzKrWgxcqIYU4tl7F8W2dbUKzo7BdO5iUZMU/lI4OYAhum6iUpTMBI09qmKoCYuIN
         XzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458617; x=1695063417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0/qIh7VMschCkXSU1Pfg8gu15pfpuF60zgwAz0sY5k=;
        b=qlqtCONGiUTk8dFKI5lKu+0zrKAjK9o3hMgD+XgO5EjPJ88S8Z/0J3ePTCbbUqu0G8
         68LmTQQt8n/Yw0Gp6NPKi7haq8H3hSwRvwGkk5gDxVuW8/VJiyNnuzZI3MX4pn3p9hMw
         bMVXSE29CCcxIDYPUWhwLNb/kqFP+ssR/tnC9jl/dujhruGZoNZZn5jAOeHCboYh/xWI
         bSfKaI1v1rcZUh0pEsJcacJP8dcirq/jc/1oxqw8gditNdyiIljV5mPZyjudQX/bXJz+
         4cbyHhqxswhjADboz6czlC6H5PfL3iHecKSphqgZBKfssl6AE+hCYDMS2XHfqtCBW7dR
         t5aA==
X-Gm-Message-State: AOJu0YxM7Z1oLh0SFIZU7FLgLGbAUdA8RqVUwHpgJqLBpXpFg1Fhd/xu
        06ZwbO2GCR6OIIvLsMuXUQMClw4DkA==
X-Google-Smtp-Source: AGHT+IHJFJ/I3VA9qMzdgKjfzrrxbbCMTfHP75l1sPYhUuVn9BAODLMLtTSCGfhxa8sdxaudf141Kw==
X-Received: by 2002:a0c:e310:0:b0:655:dc9d:efdc with SMTP id s16-20020a0ce310000000b00655dc9defdcmr6531752qvl.3.1694458616765;
        Mon, 11 Sep 2023 11:56:56 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id e15-20020a0caa4f000000b006263a9e7c63sm3106068qvb.104.2023.09.11.11.56.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:56:56 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] NFSv4.x client improvements for knfsd re-exporting
Date:   Mon, 11 Sep 2023 14:50:29 -0400
Message-ID: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When re-exporting a NFSv4.x filesystem through knfsd, we want to ensure
that the individual knfsd threads don't get stuck waiting for the server
in a NFS4ERR_DELAY loop. While it may make sense to have the re-exported
client retry a few times, particularly when the clients are using NFSv3,
ultimately we want to just punt a EAGAIN back to knfsd, so that it can
return NFS4ERR_DELAY/NFS3ERR_JUKEBOX, and free up the thread.

With that in mind, add a client module parameter, 'delay_retrans', that
specifies how many times a 'softerr' mounted NFSv4 filesystem should
retry before returning EAGAIN.
In order to avoid disrupting existing setups, the feature is disabled by
default, however it can be enabled by specifying a positive value for
the new parameter.

Trond Myklebust (2):
  NFSv4: Add a parameter to limit the number of retries after
    NFS4ERR_DELAY
  NFSv4/pnfs: Allow layoutget to return EAGAIN for softerr mounts

 .../admin-guide/kernel-parameters.txt         |  7 +++
 fs/nfs/nfs4_fs.h                              |  2 +
 fs/nfs/nfs4proc.c                             | 43 +++++++++++++++----
 fs/nfs/pnfs.c                                 |  8 +++-
 fs/nfs/pnfs.h                                 |  5 ++-
 fs/nfs/super.c                                |  8 +++-
 fs/nfs/write.c                                |  2 +
 7 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.41.0

