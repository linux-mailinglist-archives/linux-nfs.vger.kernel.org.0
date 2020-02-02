Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1414FFDC
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgBBW4H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:56:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42688 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBBW4H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:56:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id b81so11944751ywe.9
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYVffNbAr9TiXb+ZLUWsvsYgA2b+QHWTgILXwNulVkI=;
        b=TUUBlQiFS4Z3K4GoLc5f6jj0AmZ4swIBbL3/WHpMLfXdhWIm7e2gFRAL5HVIYBFCvn
         DFbaF5f1GHnQm/MIMcsew2hACYOTYPT9z0My36KCVU1h2qI4pGBytGD6Kuh+j+yhbpW+
         4qOtSFOrdzVij35ch77wLZ8p9D0q7zn3khnonu6LYPMPyTXaa+Y2kRft6Oe68oFj25Xb
         3mZdgHNczIH+QyPSCbCr+d3HyrZetPpfuILBdcZXgZqHESxY9VjUgbavk/fI0R+FYM1P
         0Rn2nD8baSWTotyAyeSVUFhLeoUt9j66ZvfLQBJQAnFuQW5EYm+kg4eQCxiGQZjVYZ7J
         /kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYVffNbAr9TiXb+ZLUWsvsYgA2b+QHWTgILXwNulVkI=;
        b=cWGPJQ023/ahTigNJhYnDej0m9LiWTTB3eKY7e6eUysn1T9qL13l76TfmcTICWIPZd
         iTunm3cun2WoTz230mCew7+qEo1h7MvA2L3eLRaGXfc41yzj13EadO8Gy1jVjzN5bkeb
         uuvOGVhKqd7OAd0NVYhkKTsRMUpytkPkWhfvb0xihY7CtcwM8Q2a/bGPDEk8L2OaFX9q
         16yF3VLUj/D91fAxiqXRxucnmE1pTYD2K0pV2+R1+nIqk6i15KjU/nWSuywzxVcddy27
         +sl37Apw/Iy78OIUeJq6/g0o2f8aK2+AloQb8mHXsqRFq/0Kfz94ko2lElM3YL7XwzSP
         WdJg==
X-Gm-Message-State: APjAAAUvvMqW18bNte3rWtyVQaLEaRzoLujJ/oIXfzdbDMckUTIq7x4M
        uBgjs7Lez9tcDlf3D/na5w==
X-Google-Smtp-Source: APXvYqzE1HssRNyx3JIjt8MyGO2fQDT4OsotHOOdZu5/yI8iHceosujZ94cvTL6VpytP/aL+kuHuuQ==
X-Received: by 2002:a25:6e04:: with SMTP id j4mr18375118ybc.36.1580684166619;
        Sun, 02 Feb 2020 14:56:06 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm7185529ywf.101.2020.02.02.14.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:56:05 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Readdir fixes
Date:   Sun,  2 Feb 2020 17:53:52 -0500
Message-Id: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Two stable patches that fix memory corruption and a memory leak in the
readdir code. Fixing those issues together with the patch by Dai Ngo
then allows us to switch NFS over to the iterate_shared() interface
to enable parallel access to readdir() for the same directory.

Trond Myklebust (4):
  NFS: Fix memory leaks and corruption in readdir
  NFS: Directory page cache pages need to be locked when read
  NFS: Use kmemdup_nul() in nfs_readdir_make_qstr()
  NFS: Switch readdir to using iterate_shared()

 fs/nfs/dir.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

-- 
2.24.1

