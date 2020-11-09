Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D422AC709
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgKIVUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgKIVUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:42 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86005C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:42 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so7101475qtb.10
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZJUwOUWSF6UgorjLDq56rw5Z7Wkks/fmbrJ1u284DA=;
        b=RTY3DbpIrPtL5T3h5yb0Oy/fG0Pjen3r5+2gP44tHnnLbaCW37UzQQVQklcdD7XcbF
         52e3MquoX/iEc0Dq2qcZgbwKpYCNktOMYXGXPrwY9JPgoXGyYcVCcA3raphBZZLb1n+P
         /Ka0jFtfD5JasRczy2tFbyWC2iAwFsIw7cOOa4LGZKtag4/dw0Ke+AFqri+O89lz3AMJ
         oct2h0DIyomeH/EiGp4pInUKjyA+dSuBemoNNLa/Ko76nuEnbK57ND1C9hmfeV9FaD4R
         obMmPyGDjua3341NTJvWAegXdKxJP8M6Vw1qcnU+DKwIsod1rkWmfrGa0XreAuB7ykO6
         onaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZJUwOUWSF6UgorjLDq56rw5Z7Wkks/fmbrJ1u284DA=;
        b=EiNtawH9vu6qJCQ4s/BK75SmvO/nGFrnepkx+OwQFZIw5uQrwYWNT5LxQ3jR11FNYZ
         Ac35sCDnj/Cu0uC4YYSktj+BkhH5iNErXO7cxmWjI66YYPHtsV1biVAtTy4/F3gDtX2c
         iMDw3OwGGpOQWXOmoZz0iAbU1J3MYL278eJF/UxkuVeKo8j5WKT11XpNfHsl4ailPaJS
         zs6wNbLJxBsr9nrqV9xr1XrOYfxoyngQ1at7b3+D5+y/yQhFy4RRHsmX6iGbj5ow5Hrl
         mgq5/eO41Ef6N6bkequwIprM5cishahYtYXYQxJkSTVieE7rkBdp7njbZepLKxlLgce4
         b9sA==
X-Gm-Message-State: AOAM532Z2WGvPhoPqiD+WhVCOBZpom2Hsz1VlkMPGzYQ9uhhxiu1fJak
        MZeHaJvgoi6INReehV9aJT0b97u66i8F
X-Google-Smtp-Source: ABdhPJz0c0vZ0c5CTfjqxuneKChZFnScgg0Qm07hQceaV9eqNUOyAU+TrMk0/Zyqg5Y4+zu6dP+w1Q==
X-Received: by 2002:ac8:7296:: with SMTP id v22mr15138241qto.267.1604956841134;
        Mon, 09 Nov 2020 13:20:41 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:39 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/5] Add RDMA support to the pNFS file+flexfiles data channels
Date:   Mon,  9 Nov 2020 16:10:24 -0500
Message-Id: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for connecting to the pNFS files/flexfiles data servers
through RDMA, assuming that the GETDEVICEINFO call advertises that
support.

v2: Fix layoutstats encoding for pNFS/flexfiles.

Trond Myklebust (5):
  SUNRPC: xprt_load_transport() needs to support the netid "rdma6"
  NFSv4/pNFS: Use connections to a DS that are all of the same protocol
    family
  NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr
  pNFS/flexfiles: Fix up layoutstats reporting for non-TCP transports
  pNFS: Clean up open coded kmemdup_nul()

 fs/nfs/flexfilelayout/flexfilelayout.c | 34 +++++++++--
 fs/nfs/pnfs.h                          |  1 +
 fs/nfs/pnfs_nfs.c                      | 80 +++++++++++++++++++-------
 net/sunrpc/xprtrdma/module.c           |  2 +
 4 files changed, 91 insertions(+), 26 deletions(-)

-- 
2.28.0

