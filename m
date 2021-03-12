Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB333398FF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhCLVSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhCLVS3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E5C061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a9so25816528qkn.13
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pexP4mVl44dmpNSvH5jw+yzpSOkSXifs2rh/5/wpp0o=;
        b=cL/h8OokxXU19zEWNDuwdf5PFQ5tveaxKxzeI9joARFFNmd5ewL3EJAUbSOMvOK5Gr
         iXbz8GwQS3FdnkZ+EUN16bVdCpzCXrY8O46rz6kIIZfXqW2loP1cjsS3WQJBiA0PhBPJ
         0KbdD11xtInpxzGo2Fkv3JWC8DaEIM6gVRyclIYwsJVISQSTpE3ijEWtDFpMBQGh46gl
         s4BSJYDRVaP3kA/KNFygPoKTJoZYIq4xIl5tbU6GBK6VhUkndeiNTapvgobibrdX3mm1
         p0df5/ypK3A62h4ETPlxFXJOWi584DwJMnsPmJuiTtljXC1/aKO5SjpgEj/uj56280hN
         oPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pexP4mVl44dmpNSvH5jw+yzpSOkSXifs2rh/5/wpp0o=;
        b=lAHmEgdS0UrViCpDLTXJWLWWN6m16Go87BOnCvppsHBAslXHdjUxUdnMooIJHgsxjK
         9hKHvxkBJAgcd7xUobfs4Dj7n2KEcts3MSB9+PnC5S2WdLsrvTXN5exI7xilywd7+GPV
         jetoXmGNQpYYhlt/Xpz9CoJOQiUsM5esVLb8dRJcSd7bmXqa/sL0wzebZQ93kWgb8lf8
         dve1fSOFbJ0jElG/ePFIjztjdgw0DGPZY9p+zAKfcwhsgTbpaiIE76lHFLasqGH1GD25
         5JkiFa4oIFtl7L619Z2TTS2GUmZSG7n99oM0qte7mWIm3hBCrFfDmIZnfdjffltqkjHj
         2qow==
X-Gm-Message-State: AOAM533SKGcC0k2eOElOwavMMTwnyQMB4rHQ0lw2A86sjkeHnB5PkLRe
        xCMZ6dNdS2uNVEXq///Fu85/muQb2BLAfA==
X-Google-Smtp-Source: ABdhPJyPqMQ4fX5LJTeCGdRRmHf+I0MclB+nG/9RycuMSxiXhXmRZIoP01jF4su/H1F5Ahi+wIsG6A==
X-Received: by 2002:a37:584:: with SMTP id 126mr14036592qkf.274.1615583908469;
        Fri, 12 Mar 2021 13:18:28 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:28 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
Date:   Fri, 12 Mar 2021 16:18:21 -0500
Message-Id: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
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

Changes in v3:
- Rename functions and objects to make future expansion easier
- Put files under /sys/kernel/sunrpc/client/ instead of
  /sys/kernel/sunrpc/net/, again for future expansions
- Clean up use of WARN_ON_ONCE() in xs_connect()
- Fix up locking, reference counting, and RCU usage
- Unconditionally create files so userspace tools don't need to guess
  what is supported (We return an error message now instead)

Changes in v2:
- Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
- Rename file from "address" to "dstaddr"

Thoughts?
Anna


Anna Schumaker (5):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: Prepare xs_connect() for taking NULL tasks
  sunrpc: Create a per-rpc_clnt file for managing the destination IP
    address

 include/linux/sunrpc/clnt.h |   1 +
 net/sunrpc/Makefile         |   2 +-
 net/sunrpc/clnt.c           |   5 +
 net/sunrpc/sunrpc_syms.c    |   8 ++
 net/sunrpc/sysfs.c          | 191 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  20 ++++
 net/sunrpc/xprtsock.c       |   2 +-
 7 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.29.2

