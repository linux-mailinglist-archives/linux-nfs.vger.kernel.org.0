Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50D27B2BE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1RJX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1RJX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FEC0613CE
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d1so1323734qtr.6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GUHrlTvW4AtHCcCjsuvF0sWKJa/HocWoEYq/WwxdNMw=;
        b=dr/JUnVK0VktGzRCYu+9VA3AB7hxAuqqF5XmRY6W6USIt6EkO7vaFV7Y5Gx4q97pCf
         V5DNndF9nOWXjIf6C9enlfQzDb3jUsONpAALh6eyJt7RcUwGwrOlk5mFvLfhXME9DIKd
         K0C65l5Z49algYbdEHOw/V8kSvugBmsy7FPlr3SOkFqaiDw18Y0YAfEfQpuxR3Njoxvc
         LhZRE/ku3bgWCvHUvT9uk38gUWOyrcZ+tkExVcSJb0BPC+nVQ0kbjy6/RldZLSekXfvI
         53tDZpSP7TX7/PrrUVAlVgRDZA/55EIgxTlZrKgj2YChvgAnHXuxNJrYe5akALsY19RW
         pUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GUHrlTvW4AtHCcCjsuvF0sWKJa/HocWoEYq/WwxdNMw=;
        b=aOIZrEs3GVF7vB2s2mHQOVDebgDezSbvlDm+r0kdExhTO/V/savTOcOZ6cXDykQdEo
         W7aoZrKzb8GFKjvS+VN4ZUzxQ6XFLxFoNCh6RoT2QmFApBkI/JcWmgbR2n9Mr47RwOqa
         cnWBmb+IMzYpMgAqd8tcsZpTNOKT9XpT2L7tEcuNTH54za6hbqGbLaU0PLzP1cdQPh/x
         EhRQSyOvdLutYtOto677j4TvjdmBc2O/BPskKS9wfHZqS1ihWaTcqizuYXmH7hOP6MFr
         nxdJ5ji+NDtr7DgAsMQbtDkGs12DTTcb8q3ge8f0P9gcCO5RCqYf0159QSPJK6E+UdP5
         lqvg==
X-Gm-Message-State: AOAM531D4pkTCMCggXxnc27U5aEneRvUdTQtOTWCSgz/Z5KbI0MDROgP
        374YexzGyjRp+Y1YgmcCTEyfONSEaHQ=
X-Google-Smtp-Source: ABdhPJxeA0OpHcqAPm1aaMd3n7Hn78kFwGj8o9HZPDUCeO1gJQDHI3iT8avSjncLJbPolnNZ59KK6w==
X-Received: by 2002:ac8:48d5:: with SMTP id l21mr2586750qtr.267.1601312960755;
        Mon, 28 Sep 2020 10:09:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:20 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 00/10] NFS: Add support for the v4.2 READ_PLUS operation
Date:   Mon, 28 Sep 2020 13:09:09 -0400
Message-Id: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches add client support for the READ_PLUS operation, which
breaks read requests into several "data" and "hole" segments when
replying to the client.

- Changes since v5:
  - Make sure we disable READ_PLUS over RDMA, by Chuck's request
  - Update to v5.9-rc7

Here are the results of some performance tests I ran on some lab
machines. I tested by reading various 2G files from a few different underlying
filesystems and across several NFS versions. I used the `vmtouch` utility
to make sure files were only cached when we wanted them to be. In addition
to 100% data and 100% hole cases, I also tested with files that alternate
between data and hole segments. These files have either 4K, 8K, 16K, or 32K
segment sizes and start with either data or hole segments. So the file
mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
has 32K segments beginning with a hole. The units are in seconds, with the
first number for each NFS version being the uncached read time and the second
number is for when the file is cached on the server.

I added some extra data collection (client cpu percentage and sys time),
but the extra data means I couldn't figure out a way to break this down
into a concise table. I cut out v3 and v4.0 performance numbers to get
the size down, but I kept v4.1 for comparison because it uses the same
code that v4.2 without read plus uses.


Read Plus Results (ext4):
  data
   :... v4.1 ... Uncached ... 20.540 s, 105 MB/s, 0.65 s kern, 3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 20.605 s, 104 MB/s, 0.65 s kern, 3% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.72 s kern,  3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern,  3% cpu
   :... v4.2 ... Uncached ...  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
        :....... Cached .....  0.845 s, 2.5 GB/s, 0.72 s kern, 85% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 54.691 s,  39 MB/s, 0.75 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 51.587 s,  42 MB/s, 0.75 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 37.072 s,  58 MB/s, 0.67 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 33.259 s,  65 MB/s, 0.68 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 27.138 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.042 s,  93 MB/s, 0.73 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.66 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 25.326 s,  85 MB/s, 0.68 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 21.125 s, 102 MB/s, 0.69 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-4h
   :... v4.1 ... Uncached ... 58.317 s,  37 MB/s, 0.75 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 51.878 s,  41 MB/s, 0.74 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 36.855 s,  58 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 29.457 s,  73 MB/s, 0.68 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 26.460 s,  81 MB/s, 0.74 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.587 s, 110 MB/s, 0.74 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 25.495 s,  84 MB/s, 0.69 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
   :... v4.2 ... Uncached ... 17.634 s, 122 MB/s, 0.69 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.68 s kern, 7% cpu



Read Plus Results (xfs):
  data
   :... v4.1 ... Uncached ... 20.230 s, 106 MB/s, 0.65 s kern, 3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 20.724 s, 104 MB/s, 0.65 s kern, 3% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.68 s kern,  3% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern,  3% cpu
   :... v4.2 ... Uncached ...  0.904 s, 2.4 GB/s, 0.72 s kern, 79% cpu
        :....... Cached .....  0.908 s, 2.4 GB/s, 0.73 s kern, 80% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 57.553 s,  37 MB/s, 0.77 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 37.162 s,  58 MB/s, 0.73 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 36.754 s,  58 MB/s, 0.69 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 24.454 s,  88 MB/s, 0.69 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 27.156 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 22.934 s,  94 MB/s, 0.72 s kern, 3% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.68 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 27.849 s,  77 MB/s, 0.68 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.670 s,  91 MB/s, 0.67 s kern, 2% cpu
        :....... Cached .....  9.139 s, 235 MB/s, 0.64 s kern, 7% cpu
  mixed-4h
   :... v4.1 ... Uncached ... 57.639 s,  37 MB/s, 0.72 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern, 3% cpu
   :... v4.2 ... Uncached ... 35.503 s,  61 MB/s, 0.72 s kern, 2% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.66 s kern, 7% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 37.044 s,  58 MB/s, 0.71 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 23.779 s,  90 MB/s, 0.69 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 27.167 s,  79 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.088 s, 113 MB/s, 0.75 s kern, 3% cpu
        :....... Cached .....  9.159 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 27.592 s,  78 MB/s, 0.71 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
   :... v4.2 ... Uncached ... 19.682 s, 109 MB/s, 0.67 s kern, 3% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu



Read Plus Results (btrfs):
  data
   :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
   :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
        :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
  hole
   :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
   :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
   :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
        :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
  mixed-4d
   :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
   :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
  mixed-8d
   :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
  mixed-16d
   :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
  mixed-32d
   :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
   :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
  mixed-4h
   :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
   :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
   :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
        :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
  mixed-8h
   :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
   :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
  mixed-16h
   :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
   :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
  mixed-32h
   :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
   :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
        :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu



Thoughts?
Anna


Anna Schumaker (10):
  SUNRPC: Split out a function for setting current page
  SUNRPC: Implement a xdr_page_pos() function
  NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
  NFS: Add READ_PLUS data segment support
  SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
  SUNRPC: Split out _shift_data_right_tail()
  SUNRPC: Add the ability to expand holes in data pages
  NFS: Add READ_PLUS hole segment decoding
  SUNRPC: Add an xdr_align_data() function
  NFS: Decode a full READ_PLUS reply

 fs/nfs/nfs42xdr.c          | 167 ++++++++++++++++++++
 fs/nfs/nfs4client.c        |   2 +
 fs/nfs/nfs4proc.c          |  43 +++++-
 fs/nfs/nfs4xdr.c           |   7 +-
 include/linux/nfs4.h       |   2 +-
 include/linux/nfs_fs_sb.h  |   1 +
 include/linux/nfs_xdr.h    |   2 +-
 include/linux/sunrpc/xdr.h |   3 +
 net/sunrpc/xdr.c           | 309 ++++++++++++++++++++++++++++++++-----
 9 files changed, 488 insertions(+), 48 deletions(-)

-- 
2.28.0

