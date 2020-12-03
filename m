Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0340A2CDF9A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgLCUTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgLCUTZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:19:25 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8084C061A52
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 12:18:44 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so3400758qkq.6
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAWPWqAxgiZPZRQ77eP5fnkEptbtn50ZT00r/dkUoUM=;
        b=SQQaIVm6qD+uwSxnakFCAtXPzMrbmJQOiFuaqWC/piJ995NTMhRKMq2a+ciqaUXpsE
         eMrzBQCvjgc6wKiY/hFPMDOzbPX4UlCEGjxKFm9hTvoDp/Ujb0KgUaxXfdVHAEOJhnT8
         T9Ii7VBw9Zd3KkrWU6OyrYQ0ERU0Nu2ZZOL5BHTzyO3UD1RYnpbFcx3oNqktacHbrQ3I
         1D3/ZIOdsM97lfMxCbNQ30Yyoq00789CQF+HuIi2fisAxxTN0Nfq3cJkNRS86TKtPFNF
         8rAB4y7o8AuxhFD3iyPwAYezFWDfHuG/bEkKN/yZDIScK8lGzxOmX966L51OjOWOx5Z8
         ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GAWPWqAxgiZPZRQ77eP5fnkEptbtn50ZT00r/dkUoUM=;
        b=YhzrghV1ssKIWjpZV4Q5ZKeQVayX+mwH7IA0uuRCf2bc4jD9MNrQZvvUqxqP4qQymK
         3qFjLSRH127EXLcMv/CbXrtScxpikXIQKNZlEOgskSM0dXYyNf0vCb6P4qxxPy2vvuv6
         sdsPeaEC+sxAZAncI9lgEfvn5hNGkTYI2qurBvqad4NKVbDRehtYu/SJNN/eoiBCWal+
         Hpt9vOFkTvbGjoz8XCeiYMKRMKhbLXVE3RDwSRXRXTCcjNKaQ2AX64lc+s+kvTCOJ7Be
         4DiaULQNc04/ja9BzrjAv3hhxTaltTchTjE4au6FPY2vQ9JYILwylSB105QV9Jh5+WsJ
         ir0Q==
X-Gm-Message-State: AOAM531UKdiqNx1f04PXREJWtFZwtworJ0E5WLrjybPjT3yCPymxKpfK
        VXvYL14/Dhyj55AV1EnvXYET9HOnDWA=
X-Google-Smtp-Source: ABdhPJyAyd4vqd+LwsA2+Nd3n0RTmUp5dZMKuVV2u71bD8VF2/OyVqCd8ojC7kYgU+OPRcOcaL6ixg==
X-Received: by 2002:a05:620a:57b:: with SMTP id p27mr4775528qkp.417.1607026723610;
        Thu, 03 Dec 2020 12:18:43 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q20sm2194530qtn.80.2020.12.03.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:18:42 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/3] NFS: Disable READ_PLUS by default
Date:   Thu,  3 Dec 2020 15:18:38 -0500
Message-Id: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I've been scratching my head about what's going on with xfstests generic/091
and generic/263, but I'm not sure what else to look at at this point.
This patchset disables READ_PLUS by default by marking it as a
developer-only kconfig option.

I also included a couple of patches fixing some other issues that were
noticed while inspecting the code. These patches don't help the tests
pass, but they do fail later on after applying so it does feel like
progress.

I'm hopeful the remaning issues can be worked out in the future.

Thanks,
Anna


Anna Schumaker (3):
  NFS: Disable READ_PLUS by default
  NFS: Allocate a scratch page for READ_PLUS
  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes

 fs/nfs/Kconfig          |  9 +++++++++
 fs/nfs/nfs42xdr.c       |  2 ++
 fs/nfs/nfs4proc.c       |  2 +-
 fs/nfs/read.c           | 13 +++++++++++--
 include/linux/nfs_xdr.h |  1 +
 net/sunrpc/xdr.c        |  3 ++-
 6 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.29.2

