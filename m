Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E93F689D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Aug 2021 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhHXSCr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Aug 2021 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbhHXSCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Aug 2021 14:02:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0ABC053406
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f22so14421068qkm.5
        for <linux-nfs@vger.kernel.org>; Tue, 24 Aug 2021 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgI+NCEk+cNEP4JtR9haBBuHu5BH950392qugvvN3Ec=;
        b=DI53zw9XrlfaHHW1BFCsW/5KkTJ0xXseXjASeu9cxqoRr+A70TyZj2hQYeJyv1Q+Wg
         1C5Mlw7VPqXTKUxee7iU/6ZFjBR5IiUGc0gRYzcDhdDO764QQBKIxb+H684aiu/yHA5F
         pXUXhA2eHt1nhVp6Di6paSBUXfcF6bKG3ZKENNpOT1+hCqlJQ/z33zHPLvla3CAJHj5F
         Fqwx+Uj9ZiC2t2vtWL/awMCDCinGVjMoAE642xHEakX5bZMeIUARlNvbk4lBeJg6aJlp
         9A4yHddXFdNysTF5RFbURXtiAg97nTkpmHUoHCvExrQossBP0p/JTvPS+mNtKWycjE08
         FNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgI+NCEk+cNEP4JtR9haBBuHu5BH950392qugvvN3Ec=;
        b=GRKRpX5VWTnkIB/eIHjwXqu0A+fMXtWM2kn5Fn37LW1B+Cihz9GZykZEDZP4qun90T
         hgIDivjMeHnsjJ/zFmQlY0ETIJlzFbQ8aMoI1E8v+TQEjCTIbzQ2ZG6tEWmb3WbfeRRe
         sKJBaS1MzbARUz4qrjWWeetEkxx7nARVTzlwyYOQaX5v3cNcPPSiAsHu5MK1JN3GR2Ra
         VrKEkNRMflsF4MZdhBix76RZhucpP/JPHLq3Q5+XxUM1aecMhEat0xedgvhFAj567tqB
         PfVeLlfa/IcAfDz0FLLVhSl7hxt/tae8KaK8O4g7PWnly3WNUpAwZc9QL0ofIiyNJdy4
         PkWw==
X-Gm-Message-State: AOAM530sYuRcDhwlkfw0NNEiuIsx6/wGfrI9SW8A2f96CK514fawyJzT
        Rjlus0ZQxZGLISNhuMsl7Dg=
X-Google-Smtp-Source: ABdhPJxL2k6kDlgny3qbeK/cQpVBp3ifQz98yW8JyBv40gAPe8GEdfJvzqLQyGaoeTfmSMMrCrqaSQ==
X-Received: by 2002:a05:620a:20c5:: with SMTP id f5mr27288249qka.204.1629827476698;
        Tue, 24 Aug 2021 10:51:16 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:549b:da99:adb5:676c])
        by smtp.gmail.com with ESMTPSA id n18sm11519658qkn.63.2021.08.24.10.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:51:16 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/5] do not collapse trunkable transports
Date:   Tue, 24 Aug 2021 13:51:02 -0400
Message-Id: <20210824175108.19746-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch series attempts to allow for new mounts that are to the
same server (ie nfsv4.1+ session trunkable servers) but different
network addresses to use connections associated with those mounts
but still use the same client structure.

A new mount options, "max_connect", controls how many extra transports
can be added to an existing client, with maximum of 16 such transports.

v4: 
no change to 5 patches were made. 
patch 6 dropped. 
man page patch added

Olga Kornievskaia (5):
  SUNRPC keep track of number of transports to unique addresses
  SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
  NFSv4 introduce max_connect mount options
  SUNRPC enforce creation of no more than max_connect xprts
  NFSv4.1 add network transport when session trunking is detected

 fs/nfs/client.c                      |  2 ++
 fs/nfs/fs_context.c                  |  7 +++++
 fs/nfs/internal.h                    |  2 ++
 fs/nfs/nfs4client.c                  | 41 ++++++++++++++++++++++++++--
 fs/nfs/super.c                       |  2 ++
 include/linux/nfs_fs.h               |  5 ++++
 include/linux/nfs_fs_sb.h            |  1 +
 include/linux/sunrpc/clnt.h          |  2 ++
 include/linux/sunrpc/xprtmultipath.h |  1 +
 net/sunrpc/clnt.c                    | 11 +++++++-
 net/sunrpc/sysfs.c                   |  4 ++-
 net/sunrpc/xprtmultipath.c           |  1 +
 12 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.27.0

