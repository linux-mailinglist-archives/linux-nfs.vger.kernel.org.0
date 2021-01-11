Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC02F21FE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbhAKVm0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAKVm0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:42:26 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B23C061786
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:46 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w17so740220ilj.8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fyvIgROEJN2x9toQVhSf0VSCGowsjE1AE+luuzjB0Ss=;
        b=GMR7+illJ69oMkh1zcov8uF7iQLackwVXzEfkP4BATjDUHCeZ9N/X5mP0Pc3Bwof52
         zPOWMjCsautL4UFZ69eIIIyJxbqOmPrcVC+4pn/paPjGMU2SZtaVbaTL2ioME6NS9euY
         aCkczVzb7gApjU3jZUgoiYKNG5hZrGZaWDdqfj8XLVHH7ng21NI9o46vzAyBuIgK4apz
         ZTKYQjj2s1OXaN4N5C3GcsNv4wIT5tYYGtJU6H/1yPMX1fjalYECy5GEoU5ZPBTbL3ij
         FMottXZymL712Bd6s0D61NSXDLb5szDTgWBp3H58yA39SCjKJSenV20uvlY/g43q7ILa
         73WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fyvIgROEJN2x9toQVhSf0VSCGowsjE1AE+luuzjB0Ss=;
        b=r1POREdHVnd2dw19upeNYxNCkSWLL7EL+9MVrV6ZqOTmLiYfNxRbnUNqPfb0mU8kA7
         Y2e/LT5ml+r9eR7lsvKGRZjoaM8hAFZgtfzdSWIUCVMJKLByIQ88fhsuu1cnJZojI2lz
         Wp0jPLbR6dOka8IdGE2WocZCuaPowx22Qj/YvGDUDj0f/fL0PpOS3P6BtxLij+en8ty7
         fYp7+Ef01eRqSVtjGWwmqMvgxFY7ZnpNbQYY0cmAWUhm26kZqCWCXhCx/D0YWe7Oeq4R
         OlCeHteaH3OuiczcKdKDOB5lh48OUsFfVqjC/vB5CAzSHpnjyLFvEKiC/1BEFSI9sj9Z
         phTQ==
X-Gm-Message-State: AOAM5339jzxEiPchHMSQNN2uxLsK0JKYZq6vld2RJHQd/MxtniHSgtTr
        z5fCoOABpIZ/yPD+pyJK0gTgVIVdEEQPcA==
X-Google-Smtp-Source: ABdhPJxu1vzdHq9rdkRS9pk9r2xVPSdbmNLACE+JEFOzGeaGWV1sFBEzMUv3MVflo2ApTzM8MNwqpA==
X-Received: by 2002:a92:cd03:: with SMTP id z3mr1093050iln.181.1610401305165;
        Mon, 11 Jan 2021 13:41:45 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:44 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 0/7] SUNRPC: Create sysfs files for changing IP
Date:   Mon, 11 Jan 2021 16:41:36 -0500
Message-Id: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
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

This is a first draft of the code, so any thoughts or suggestions would
be greatly appreciated!

Anna


Anna Schumaker (7):
  net: Add a /sys/net directory to sysfs
  sunrpc: Create a sunrpc directory under /sys/net/
  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: Create a per-rpc_clnt file for managing the IP address
  sunrpc: Prepare xs_connect() for taking NULL tasks
  sunrpc: Connect to a new IP address provided by the user

 include/linux/sunrpc/clnt.h |   1 +
 include/net/sock.h          |   4 +
 net/socket.c                |   8 ++
 net/sunrpc/Makefile         |   2 +-
 net/sunrpc/clnt.c           |   5 ++
 net/sunrpc/sunrpc_syms.c    |   8 ++
 net/sunrpc/sysfs.c          | 160 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.h          |  22 +++++
 net/sunrpc/xprtsock.c       |   3 +-
 9 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.29.2

