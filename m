Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A133D540
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406904AbfFKSMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:12:01 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44850 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSMB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:12:01 -0400
Received: by mail-io1-f48.google.com with SMTP id s7so10685012iob.11
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLSQKKxSf9LCBfQPFTPXCbtKqtaBmi66Ds1v9Do2Syg=;
        b=C/eBFnfz0f0OrsIiJrmZR0yMedeGm3cuoUCXVfVafE0xMvRdvr3V+lQqhT1Tv67IR7
         jkzQHmyDwQ/vVK+U9o7I/n1F8fvJm8zvAQOjgU9gtktEyiMssHoq/wI+yBNQu3zJpKen
         Amx5U41vGYaTQbK2A3uODpwWZI6f/4xocgYM6bDqtbZDNmcQfS6L4oFLWHL42cx/POnz
         XQlsG0+gxeY8qW8OSJ3xXiWDLPxyPabyemYXrypSemo88VsjNPF5xacDWlYSmxntMKLg
         9HEw2ImYO/Pv7h5a29kMEzRhGJxIMV02LzMB5DZ1b+0MzzqjXKxa+3+gSMMJ/R7MgD9s
         LmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLSQKKxSf9LCBfQPFTPXCbtKqtaBmi66Ds1v9Do2Syg=;
        b=teZZ4v+H9P/5RLkh7vKmejzFj9MN/ChP2syHK1C+yj0tZEg6A0RFc/pHVXSiJBNpcP
         SX0B0Qf1gBzhzKpywP/Zr0fY3NKkN9uLMsWYYMVY7XlbI5LWZDCEP9Ighpzt3wizaty/
         DXW0XPKBwm/ssj5Uh/rV1uXCmNi4HMRLjwMuoLGkt7ENQSX3FaB612Fj9mYEl/GgytF6
         E6goLj37STK88lp1+W64BxE02bPc1Aft1OnyQCp1t3RwoPoAN/+ChZegTVqALYc4r1Q+
         XYgfDhprj4SQB+XrBp2muzYhq22cMYpK+thUt1QCebBwYmaVGZpgF1Bxynp8fm2Le2Ac
         /wGw==
X-Gm-Message-State: APjAAAXZVaJq8bal+9Z5GDi1o22tl18sAQARc1U4Wi828okMMr5kdGYH
        /L/nbEwfirnDXhBbpH2jNqAtLr0=
X-Google-Smtp-Source: APXvYqxjYujT1juBfEeIs5qL/10SN6bAp3K2c4tY6ibog2kTfSXplNBEwy+tCF6wuVGMtaqkxkr4vg==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr29815300iop.293.1560276719492;
        Tue, 11 Jun 2019 11:11:59 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f4sm4900212iok.56.2019.06.11.11.11.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:11:58 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Ensure NFSv4 client ids are unique and persistent
Date:   Tue, 11 Jun 2019 14:08:29 -0400
Message-Id: <20190611180832.119488-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patche use sysfs in conjunction with the udev daemon
to allow the client to run a configuration script to automatically
set the NFSv4 client identifier on first use.

Trond Myklebust (3):
  NFS: Create a root NFS directory in /sys/fs/nfs
  NFS: Cleanup - add nfs_clients_exit to mirror nfs_clients_init
  NFS: Add sysfs support for per-container identifier

 fs/nfs/Makefile   |   3 +-
 fs/nfs/client.c   |  17 ++++-
 fs/nfs/inode.c    |  14 ++--
 fs/nfs/internal.h |   2 +-
 fs/nfs/netns.h    |   3 +
 fs/nfs/sysfs.c    | 187 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h    |  25 +++++++
 7 files changed, 242 insertions(+), 9 deletions(-)
 create mode 100644 fs/nfs/sysfs.c
 create mode 100644 fs/nfs/sysfs.h

-- 
2.21.0

