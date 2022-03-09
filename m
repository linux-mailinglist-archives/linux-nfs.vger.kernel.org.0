Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375984D38C9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiCIS20 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiCIS2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:24 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608A31206
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:22 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso3858711oop.13
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/v+PLiebDEn6OBfshopUcx5Mv717C5YgxE/2WltueU=;
        b=BThtd47pdmBEDM6CBb+WLmZ5qDGqPgI8XqXdZb2cqt+mAhTCwXeTJsjeRFdRgo1DMX
         QL49rkrXD0v/bqPPfJydsM+7rjuF6qLvBiaAcw9JOttdOdBlE9kXLvmV4piEaqte6P4g
         HJv65FQL9pgc8jLKEMz7m7c6VjI+LAQFCCWwQEYEmEnqiKhAGtbqaelwHdYaswc5bjoM
         tW6T2BhfPRh8GODG3RjdTXtoiiyta/fpr/xwK7cAhpBpmlddswNoHoeu/DpGU0sjCPoX
         V+ZW0akTsC9YOazkyCjL6ORkKkhtv0FDpLKj+9IO0VRNqWY4gntBb2XqBzR2U6UhFhpr
         npSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/v+PLiebDEn6OBfshopUcx5Mv717C5YgxE/2WltueU=;
        b=MahMPDFK/GYFxHFRz9DGx1FMoaNqxlCahsU94c8nbe1n3TFlBrZ45yfYgog9tzhKcm
         kX2Vb0cXxHDBPqMZIEV0+96OkSchem5AwqcR6p5mo/rZoy3SLGx6UvCbpa3Bk0JQNqml
         Sf22Usk68W16mS0Xxqq9Kz+vc9sUodd0u1Gl/dhFY3TD9EwKqJ1A3M0yjcPQMtwGBASl
         c5LvLUT9b3aGc3qUx4KwuiTZnPqTA18YZtbspu4A3SP/v44/2MA8Y8Or+eJlbIMxKk1T
         WaixCC1xObivJ9Apt2Tdgp/K/osvetC0OdIy4PuBteUdNMjsz5erL6opZ70ch2FTuHBj
         eL7g==
X-Gm-Message-State: AOAM533dDAojO2EX9cIJYN895lNzZhT+JRBXsgFbOYJVTnjLv6Ep/Evh
        0beio9qs63YZxKkbk1iokz1QnFLOMp4=
X-Google-Smtp-Source: ABdhPJzTdwI1ArDBV/E+0SntLSWBvr1XRCcwyjaU6qanhz+IKOLKYQPepXwRRqUu/kt/eQM0x8peDg==
X-Received: by 2002:a05:6870:32ce:b0:d9:a0ee:44b3 with SMTP id r14-20020a05687032ce00b000d9a0ee44b3mr499613oac.142.1646850441614;
        Wed, 09 Mar 2022 10:27:21 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:21 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 0/7] Introduce nfs-readahead-udev
Date:   Wed,  9 Mar 2022 15:26:46 -0300
Message-Id: <20220309182653.1885252-1-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This patch series introduces nfs-readahead-udev, a utility to
automatically set NFS readahead when a mountpoint is mounted.

The tool currently supports setting read ahead per mountpoint, nfs major
version, or by a global default value.

Thiago Rafael Becker (7):
  Create nfs-readahead-udev
  readahead: configure udev
  readahead: create logging facility
  readahead: only set readahead for nfs devices.
  readahead: create the configuration file
  readahead: add mountpoint and fstype options
  readahead: documentation

 .gitignore                                    |   6 +
 configure.ac                                  |   4 +
 tools/Makefile.am                             |   2 +-
 tools/nfs-readahead-udev/99-nfs_bdi.rules.in  |   1 +
 tools/nfs-readahead-udev/Makefile.am          |  26 +++
 tools/nfs-readahead-udev/config_parser.c      |  25 +++
 tools/nfs-readahead-udev/config_parser.h      |  14 ++
 tools/nfs-readahead-udev/list.h               |  48 ++++
 tools/nfs-readahead-udev/log.h                |  16 ++
 tools/nfs-readahead-udev/main.c               | 211 ++++++++++++++++++
 .../nfs-readahead-udev/nfs-readahead-udev.man |  47 ++++
 tools/nfs-readahead-udev/parser.y             |  85 +++++++
 tools/nfs-readahead-udev/readahead.conf       |  15 ++
 tools/nfs-readahead-udev/scanner.l            |  19 ++
 tools/nfs-readahead-udev/syslog.c             |  47 ++++
 15 files changed, 565 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in
 create mode 100644 tools/nfs-readahead-udev/Makefile.am
 create mode 100644 tools/nfs-readahead-udev/config_parser.c
 create mode 100644 tools/nfs-readahead-udev/config_parser.h
 create mode 100644 tools/nfs-readahead-udev/list.h
 create mode 100644 tools/nfs-readahead-udev/log.h
 create mode 100644 tools/nfs-readahead-udev/main.c
 create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man
 create mode 100644 tools/nfs-readahead-udev/parser.y
 create mode 100644 tools/nfs-readahead-udev/readahead.conf
 create mode 100644 tools/nfs-readahead-udev/scanner.l
 create mode 100644 tools/nfs-readahead-udev/syslog.c

-- 
2.35.1

