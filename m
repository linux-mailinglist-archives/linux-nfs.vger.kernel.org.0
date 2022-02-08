Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983EA4AE047
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiBHSDy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBHSDx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:03:53 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B5C061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 10:03:52 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id v10so6556735qvk.7
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMHC+JoEUZsaXalxHpRnPY0Zy0TTo8/IZEoiVwFI+u8=;
        b=SoxJIVglkp0QX8k7Zff683V/aMFyaMgyYJH5USwwnLqc5hIMf7LaZQU09PhFOqKpdK
         v4hXoBYTeXxP/fC1wkZZLC7L9hxuyPZrqAbG0KWEgQgAuJbMTph7P6OYr0U+1Xpio70S
         e57Lblls56h+ALzgJHELe3yB1hfaVRrvrP4X1WjrsUJQhHdRAo2w2suysp3hGpR7Bofd
         EiOBohRLczMNZIHgWw7ztsM6hdfDOLCp0xtRIrs2f5OYQIkrlJspoi4tPRBYBfQNLrAn
         Um9BnL13zEfMLEEoG61Rtwcjc3B6EkeREEHX6oZwEdDhlXU7lhc3rExmo2tyJHgC+TTx
         6PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMHC+JoEUZsaXalxHpRnPY0Zy0TTo8/IZEoiVwFI+u8=;
        b=dVz1rfguG2YUeouNgU84WaWi0Ea34nAMSOwCXv/Jp/9V90RPBdr4V1IoWFgzb6+ne3
         n2DEGYXM0e4Xm8oj+eVt8Ce9JSxu6NM39vT7QYHHW9d8fqnr/ksEtHuEzxyRNJdbxUML
         a8DELy2p78LNDtet8MIbsUuGMXNaL1urFD0HhNpGX+7IcT1i2WfULVfQwGatF1yToH/A
         ZtFn3SScqWJX5hVCFmcobrICMshzubBbtLQjkhcbfZ5BhFTqKioei4JKtPPAQYWpu0jP
         X8qq2iE3RjpIvRKMsnx3af1eznqMCLLGeJ976kpmsXtaZu28Tp9LFt545BWkXct8CRSt
         JmUw==
X-Gm-Message-State: AOAM530HKyoOM623nlhUQ3Au7JVwOTBshHrC3hvjr6vKKcMU4n0XyYoD
        5pGqxzdhFCtEXFHCJzeSb1Ys5d8JQw==
X-Google-Smtp-Source: ABdhPJyCkVOaZbq7n3YS/wFcep3Z33eBp5s76K/b4s9uLlnkJ5leoNfrdk+kqO/TcX6M/+b7K7oIUA==
X-Received: by 2002:a05:6214:d06:: with SMTP id 6mr4135200qvh.96.1644343431076;
        Tue, 08 Feb 2022 10:03:51 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id s2sm7000723qks.60.2022.02.08.10.03.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:03:50 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Adaptive readdir readahead
Date:   Tue,  8 Feb 2022 12:57:00 -0500
Message-Id: <20220208175702.1389115-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

--
v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set


Trond Myklebust (2):
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: Simplify nfs_readdir_xdr_to_array()

 fs/nfs/dir.c           | 77 ++++++++++++++++++++++++++++++++----------
 include/linux/nfs_fs.h |  1 +
 2 files changed, 60 insertions(+), 18 deletions(-)

-- 
2.34.1

