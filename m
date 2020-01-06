Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5425D131982
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFUls (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:41:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46744 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUls (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:41:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id u139so22418925ywf.13
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XD/nFvl0EmT9VHX+ajn/VD0AXctQfh9Nz2WBcta+GJo=;
        b=iHwM0QXI4s1pApXRc1I4vVAjm6rusn3Hir2IqUdhZXC0+4+LNjvMaqUU5zDXPQWTdZ
         892gNQZ2D4yHZsxuylZyp15OP6i3gEwylK22EqwyfQ9GxcMsRLkaJjJ6QvCZ2l6fSa7y
         x/0IfeqDNQjJ8xWqPgtQCWPzqjHaujlv1Prh0lHF/y5aiGuAN8JpT+8/ENqOnoASmkP/
         pyMRG9WjDMPEfJWp/czJMlFzSiQCJGq9a1etuOcrNL8RR6+wtvjFxYnXMCqRrhUqgTMv
         iTE0ymV6heCbwJk8jFpWkA290RV7tnMSxb9garHRN8+jcqwSCNkJJgk9XVB6+m7SXltO
         rckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XD/nFvl0EmT9VHX+ajn/VD0AXctQfh9Nz2WBcta+GJo=;
        b=ei/O5zS9WbQtSVjucf2uYO/OILyElfg8U9tMVofkbwX36By8W+2NWNVx/5kQP8Y0R9
         3ZHMKbppdx2D7GmS7ve7RppBAWtvVS7fM5Scn3N+uUeWwngRkYTf7dEM0ojLHPIkORcm
         sJGQaMzAtxxWnRq3ci/zHATPOU96IRmYWLkDJTWC/Oci4Gs88MhFdXLwRGm4cKbVtpU4
         wM89/lrryw8yDsF5BLEp/DEF3ylY+uZ7ZU08nZcZlEvFv2VZpHloa+cCLaCautZ7IJnx
         iVf6Hw6yhd4jcRc3R+EZPQ/f2BqVpDBF1/MRnYKR8H5Tpc889PaDRuNatZlwzzFgtVVT
         twMQ==
X-Gm-Message-State: APjAAAXhHZPapSBWEsaYFF2j6XvxE8AB8DlutlZsceQFbD5Q9D2VCtoO
        ll2ODq+u/pcW2fwa/NgiQk+ze8mpQA==
X-Google-Smtp-Source: APXvYqz0veEWUXylfzlCJ1Vd103S2uRSS+GrBdWn6NkeWkR5eS/+Mdruu5XKLBhMrYp/030IuN4dwA==
X-Received: by 2002:a0d:dd4a:: with SMTP id g71mr75975006ywe.248.1578343306859;
        Mon, 06 Jan 2020 12:41:46 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id 207sm28082405ywq.100.2020.01.06.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:41:46 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Optionally default to cached info when server is down
Date:   Mon,  6 Jan 2020 15:39:35 -0500
Message-Id: <20200106203937.785805-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a mount option that allows the NFS client to default to using
cached information (attributes, permissions, data, etc) if the NFS
server is down.

Trond Myklebust (2):
  NFS: Trust cached access if we've already revalidated the inode once
  NFS: Add mount option 'softreval'

 fs/nfs/dir.c              |  4 ++--
 fs/nfs/inode.c            |  8 +++++++-
 fs/nfs/nfs3proc.c         |  7 ++++++-
 fs/nfs/nfs4proc.c         | 33 ++++++++++++++++++++++++++-------
 fs/nfs/proc.c             |  7 ++++++-
 fs/nfs/super.c            | 16 ++++++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 7 files changed, 62 insertions(+), 14 deletions(-)

-- 
2.24.1

