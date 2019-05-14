Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032A41D0CC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfENUpX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34888 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUpW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:22 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so1051385ith.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ufsLM6u7rIENRihY2pJS2ohWHx5EjKSvPGEo5obMww=;
        b=nOxf6WhNbLoccNi1gNRHPfIW1ihPfOAMy0cTLoGEebO6eipQzISZfZBxL99eaT/qaq
         4xjvAbuE/NlfCXjlFtl0TfZi3Yn8FXJ+mM+d2oK5JGW9mjQaZtkjVCpAqbgn5F9MlaMC
         Gbcxr1x85AX3EMy8shDTGcSrdJoXQQBCBnvibgOw+BXeBDzIaTFmyTqYsaPvl8aR4jBB
         yqtA/fw0E5ErhnuTPUpE4Nc2yORq+FwXYMaxbzwUjUFa1DFY1B5lzdIQbs7K6TxwboVk
         uZSNMTDsS+M9uMjzIsLZVzm8Gw/lZuheG7+clWw64icCfV4nE5CNMiuJ9xSjKLtHZeND
         qVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ufsLM6u7rIENRihY2pJS2ohWHx5EjKSvPGEo5obMww=;
        b=Ze/2EdLdhi77E0BQqz9WoFqCF3qCIRzorpOWLuzE7IaDB/NzUdQwspgShyoe08Me9J
         5K5I7O0cUt9/qMytdKTlqXwVoBsZaPvQceM6wEZdeROt2mAOSNGkdhN3h8h79Y4o6k1w
         mIBCoCVMJMudaL5VHh3M31Q+nU6TP1QbKOl7seOYtQXGcxoCgsNAWo9EEnHD2mfcykxE
         CqNaniDan7Tvpw+0hUcV2on7191j9vPUklI34xTD86eRnQxFtvSmL/kiiVhVrFiciOzu
         tO97SluXCxZj7vOImO9+ilK1eVpUxlIAjrTnOiOGC/dNuHvdwQy0rNtvZhghJAd+DDum
         78zg==
X-Gm-Message-State: APjAAAWr6LwCn/srBEG7SQOPWRa7SNgMIEvOU688v+uT5lZcJIN/iJES
        UiSoy6nxdWtzfUcAx/yHosgJ06s=
X-Google-Smtp-Source: APXvYqyA7dzRRTyoB39WbNg6fPnlr4vfcDLB3BY97qvZ7BxUKEba8qn8NKEk49shsJygXeqoK3ccXw==
X-Received: by 2002:a05:660c:444:: with SMTP id d4mr5668154itl.158.1557866721682;
        Tue, 14 May 2019 13:45:21 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/5] Add a chroot option to nfs.conf
Date:   Tue, 14 May 2019 16:41:48 -0400
Message-Id: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patchset aims to allow the configuration of a 'chroot
jail' to rpc.nfsd, and allowing us to export a filesystem /foo (and
possibly subtrees) as '/'.

Trond Myklebust (5):
  mountd: Ensure we don't share cache file descriptors among processes.
  Add a simple workqueue mechanism
  Add a helper to write to a file through the chrooted thread
  Add support for chrooted exports
  Add support for chroot in exportfs

 aclocal/libpthread.m4      |  13 +-
 configure.ac               |   6 +-
 nfs.conf                   |   1 +
 support/include/misc.h     |  11 ++
 support/misc/Makefile.am   |   2 +-
 support/misc/workqueue.c   | 267 +++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man       |   3 +-
 utils/exportfs/Makefile.am |   2 +-
 utils/exportfs/exportfs.c  |  31 ++++-
 utils/mountd/Makefile.am   |   3 +-
 utils/mountd/cache.c       |  39 +++++-
 utils/mountd/mountd.c      |   5 +-
 utils/nfsd/nfsd.man        |   4 +
 13 files changed, 369 insertions(+), 18 deletions(-)
 create mode 100644 support/misc/workqueue.c

-- 
2.21.0

