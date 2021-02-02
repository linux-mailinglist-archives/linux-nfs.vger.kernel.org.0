Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5A30CA50
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhBBSoy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbhBBSn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:28 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E85C061786
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:47 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id r77so20800119qka.12
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15OHnxD+2xiRrqxd/g7CU3xZ31zwjreMRfj+4glkFD4=;
        b=TNnN2Ddxlm/WrWL9/hnub+eoGDLAL7sJY5brWOBtTESEGTd+25h271je9/MPMSg8sN
         KjAJJ6GN1B3IPjyuJOMMczKwTf3SGgeerL6J4Ee+vrJdz6LyAyQpQcoB4skG+i7TI3yZ
         r9Ro6Y3MxosZpEcr7ko1mDQIK8jyyPP08EKry0TOSUu2zjqrDqfI9n/a2l2vDhvHW8JR
         UmCWgeiXofhQ9tyuLafFhxwExYme0ueIlwlvcOFjYBfKA02DV/lX7LDzHCXwiCmosyWf
         rE+t4D4g4gezSSP3ayzlZAqZgp6kUTbgyA2uaUv3Q65Y7jqTFXcgHBaBZ6ltNd+Seect
         Zpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=15OHnxD+2xiRrqxd/g7CU3xZ31zwjreMRfj+4glkFD4=;
        b=GiblUQWAPlvvcw4AsARfqNnwgQDGUS0POMM8wkJfVf/sLkkk7d5Soo0tOK38tgWKYg
         bSQU0IKqILA2Tf40DNs+brc1nXy+AkOCXC+RDHbEkIovTWGm+/5cYDjsZ3JskotSEKF1
         1/AK51QQ96ybIZ5i/4T7klfUcP9bncUDO4uvWAZ1VzWeoHVGnya2InF97BvTcde2GRea
         cndGCwDV0/tTC3A/bGuVtwjgqRKoqsCXUgSh6Vii3QLNqKhQDxaFMTWaeTRMlHKOL3ma
         aYpc2KOrx7qDWhK3BF3l83qEVwbF1a/Xz+ip8Sl1AfCUOQ6wcRkTMRiaFMzR8lUpmFOJ
         bf/A==
X-Gm-Message-State: AOAM533+01EZQmKemiK+WBDgtDY+hOo1m8EWgHEfWUG2wpqLI2bhW7n7
        urnzv9ofee9nnXK1awvntemmBZ+2juCwWQ==
X-Google-Smtp-Source: ABdhPJy/sWUChY1Gt/R+QTOzIx65OuJtUEFBelAXvFwXphoIrDJPIKDuy62Cuggkb7N6lc4HuAn0Cw==
X-Received: by 2002:a05:620a:b19:: with SMTP id t25mr21629031qkg.59.1612291366722;
        Tue, 02 Feb 2021 10:42:46 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:46 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Date:   Tue,  2 Feb 2021 13:42:39 -0500
Message-Id: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

It's possible for an NFS server to go down but come back up with a
different IP address. These patches provide a way for administrators to
handle this issue by providing a new IP address for xprt sockets to
connect to.

Chuck has suggested some ideas for future work that could also use this
interface, such as:
- srcaddr: To move between network devices on the client
- type: "tcp", "rdma", "local"
- bound: 0 for autobind, or the result of the most recent rpcbind query
- connected: either true or false
- last: read-only timestamp of the last operation to use the transport
- device: A symlink to the physical network device

Changes in v2:
- Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
- Rename file from "address" to "dstaddr"

Thoughts?
Anna


Anna Schumaker (5):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: Prepare xs_connect() for taking NULL tasks
  sunrpc: Create a per-rpc_clnt file for managing the destination IP
    address

 include/linux/sunrpc/clnt.h |   1 +
 net/sunrpc/Makefile         |   2 +-
 net/sunrpc/clnt.c           |   5 ++
 net/sunrpc/sunrpc_syms.c    |   8 ++
 net/sunrpc/sysfs.c          | 168 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  22 +++++
 net/sunrpc/xprtsock.c       |   3 +-
 7 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.29.2

