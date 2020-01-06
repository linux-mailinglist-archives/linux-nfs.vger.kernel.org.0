Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E196131761
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFSUY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:20:24 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45490 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSUX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:20:23 -0500
Received: by mail-yb1-f196.google.com with SMTP id y67so12770510yba.12
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b+xTjyKzwQACWyT3C/3CNIHOhiIHoL2LFf21qMaJHHE=;
        b=M89g1lDAT6T9mGzbVb2KVjuPvVOBeuldwPnZxO3eAoyGviupz5JzQt4cxAoMG2WJF3
         MxOAI2jmgth+johJ0yBKZS8R79+OYHBytOx49ue+1KicbTTaV1LO2aygM3nXAlENhvhq
         zQfFJgsEk7gGr6go/glNNtzgWdDALheWyV7DeyM5ZUnJMzvDc3BgV0vPIvWYRUPYzqfz
         6cZ8JW6eOvAOLA5z1ApahGB/clpoOySwdd4MZpDW1GzzpZW3LYMgCV3IaPvmplasCIwk
         LxEqScMLnoZHBQ+k6JakALP8gGw/SPklJscjlCqyZN0GZmuzLCbgvuwFZmRMtNAd2JvK
         7AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b+xTjyKzwQACWyT3C/3CNIHOhiIHoL2LFf21qMaJHHE=;
        b=cQOoVLaZ5oky9miJnn25tnqftERAdzNztR59NeethbJtdRpuI+ywvAHqdVGPtXGiKV
         eDHL721lxXx++eNewfA6CyjhjU6bk2XopPq71hhcqewc0n2wKvEoB/Qq0BHHaOEipHZt
         7iKfHrlMZsgoUqryEkhUZo5ygtzdFo8VKqG7sdRhvDlqr0oPQlY5KPAEwITEp6vhWuda
         Olq6+HTj3Adt9joOl0fkSI8MfofeUTtjcH8hyE3a49jdibr3t4Pxt06BNd4tIQ1z97Il
         uu/hqT+cnmbhUDW1MC+veldQjui9gbm3+yiOCD1K0UJl238ebgyklAJmKxduBClzdDoW
         jeSw==
X-Gm-Message-State: APjAAAUzOwPC2ggnFbxd9uEnBJVs5YeL4Fkk6HbFK/WaHCcSsUyv9WVW
        3kRFnOXsFx+9yJlfhuzzlK9cYfHJIA==
X-Google-Smtp-Source: APXvYqyB7P9gxDMh6g1LMmKynEHyvlOPEd38XriHtGmkg3zykAa6DstumS42Odn1N2bLOYE51Q2V6g==
X-Received: by 2002:a25:dcc3:: with SMTP id y186mr66303426ybe.351.1578334822593;
        Mon, 06 Jan 2020 10:20:22 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id r31sm24800524ywa.82.2020.01.06.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:20:22 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RESEND 0/6] Improve performance of containerised knfsd
Date:   Mon,  6 Jan 2020 13:18:02 -0500
Message-Id: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patches fix up the garbage collection for the knfsd file
cache, to make the behaviour under load be more predictable.
It also separates out the garbage collectors for knfsd instances running
under different containers to ensure that a close() or fput() of a file
in one container that hangs or is slow won't gum up the system for
all the other containers.

Trond Myklebust (6):
  nfsd: fix filecache lookup
  nfsd: cleanup nfsd_file_lru_dispose()
  nfsd: Containerise filecache laundrette
  nfsd: Remove unused constant NFSD_FILE_LRU_RESCAN
  nfsd: Schedule the laundrette regularly irrespective of file errors
  nfsd: Reduce the number of calls to nfsd_file_gc()

 fs/nfsd/filecache.c | 285 ++++++++++++++++++++++++++++++++++----------
 fs/nfsd/filecache.h |   2 +
 fs/nfsd/nfssvc.c    |   9 +-
 3 files changed, 230 insertions(+), 66 deletions(-)

-- 
2.24.1

