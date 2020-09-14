Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030C226965A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINUYY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgINUYC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Sep 2020 16:24:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B95C06178A
        for <linux-nfs@vger.kernel.org>; Mon, 14 Sep 2020 13:23:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so1558824iof.6
        for <linux-nfs@vger.kernel.org>; Mon, 14 Sep 2020 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lOR/ThRtk5C644UA1GPBIz/BN2hllVCnxxkps9AMCDY=;
        b=FRhcNWl0hDPd15ajU39sPgjyW+FBvMtoq5AbvguDEdLdokejI9yu7DJIOOxYcbsV60
         0SBuyEkQz3PlBVD3u8cNsh5L39lRq1FNJ+6TMdtrMzTO91xRzvUWNQn0qWyiyI2bl5Lr
         4ss5Q7cEgZQ9u9edWvNFnbWEBHId3Nercz2HUyfUb8JZzanLRKOd8bzcqoxutImFuHMJ
         bS68Bc6Ixcf/TidoFXTlfabDXbcA1iT2eM9vuseCyEMFTI6lEpAvAcB6aP8H4Y+ZtBzy
         3fph3EGO0F3XvzuVVBazvSs+KccxE6tCBBWQtwfwswHn1ieDqXzmcT9n1uo8gvYRDAxi
         tPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lOR/ThRtk5C644UA1GPBIz/BN2hllVCnxxkps9AMCDY=;
        b=auHQVYBgRJeTTvNnYQZgS0UujtNtutpZmbxZUTtmAPqRwhNyvIZgKyEIYZX08QcODi
         lqqcKDHQtm11h6L8HmUCzQKj87SA5qDmGAPbFH0puD6sdHQXnfkjfyBr5pHpxxG9NDbL
         197AOZq50IFvTNlUtBZesuqrfSg0uJJ9+C1L/83EG/3jwX7TUxLcTtdt0GGRdYUlJeFS
         ABumspdkcyaKLAjJ/bcdvYnoDC++izncpC+2bBSthtv2FwA13BxCIkps6KLIpbxQxSWC
         +ckLB784q1eYpVzG+tnIqLIyGS1zrtfqSGHeYIOohxRlmr4mFYffq22DqpvFXgysOsvc
         NmpQ==
X-Gm-Message-State: AOAM532lgWFJl7M5NfbZrtioM9kYAd9eIXHA0RLXm+TaZxCZ5KvKFj9Y
        vsATnRcQZbFR+Tqu1ZA7ois=
X-Google-Smtp-Source: ABdhPJyJnavJTVS8AhlhukEgnUncp6I9PIWfYBx4QmdbCyqSHUm5ja/iCl0n4JgY/QVH8qYWp9kmPA==
X-Received: by 2002:a6b:d214:: with SMTP id q20mr12785756iob.23.1600115013510;
        Mon, 14 Sep 2020 13:23:33 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s23sm6508352iol.23.2020.09.14.13.23.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Sep 2020 13:23:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, jencce.kernel@gmail.com
Subject: [PATCH 1/1] NFSv4.2: fix client's attribute cache management for copy_file_range
Date:   Mon, 14 Sep 2020 16:23:34 -0400
Message-Id: <20200914202334.7536-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After client is done with the COPY operation, it needs to invalidate
its pagecache (as it did no reading or writing of the data locally)
and it needs to invalidate it's attributes just like it would have
for a read on the source file and write on the destination file.

Once the linux server started giving out read delegations to
read+write opens, the destination file of the copy_file range
started having delegations and not doing syncup on close of the
file leading to xfstest failures for generic/430,431,432,433,565.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 142225f0af59..a9074f3366fa 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -356,7 +356,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	truncate_pagecache_range(dst_inode, pos_dst,
 				 pos_dst + res->write_res.count);
-
+	NFS_I(dst_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
+			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_SIZE |
+			NFS_INO_INVALID_ATTR | NFS_INO_INVALID_DATA);
+	NFS_I(src_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
+			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_ATIME);
 	status = res->write_res.count;
 out:
 	if (args->sync)
-- 
2.18.1

