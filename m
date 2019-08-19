Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2994E16
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfHST3D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44075 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfHST3C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:02 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so6802308iop.11
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARgeRH0qJSHZt9N0Ens++USvK3Kh/gI5lM7N7JB37Dg=;
        b=gokaQI+p2Khink+aK/wCdCru+Ksf/GgOxPDVW4ZCXLuD5dr5RW1M+k25GBGaTtitEc
         CUv+G8QFMZF6G0O98zCeLzCAkQ/G+6zBXGUsp1VrbEckXFF+RuH6ldE2N1fMSM6fCpM0
         SHO3I7dmoNJRJkxZT7JkmWXAvG1KuSNDjhAdQigQ82I7BAINsJNw0YPchV3dG7u1UWf9
         6VaozAhiLYlXgNaN74NqHqyhfwvTqanR97tAZoZTCXMuJY5QwSMi1QcOOv5d/bKCIdgb
         2RkazVQ/xGrH75ggHm1+EejhskBXdXuM3jbzbeU5D6ohlJ3FPAU25xwE17ixlCUMwyiz
         QNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ARgeRH0qJSHZt9N0Ens++USvK3Kh/gI5lM7N7JB37Dg=;
        b=C9UPNYdAx4XW0MjlBBQYCmomtODfy9upt5PsGso+yQq0VAM4VVudPG0zvBBJK06OW6
         2p1v9LV4yygJtZlokEC8G4wg8VH/9+YkXu8i1MJBFDWIcqB/aNiruwouN6zNDA+VlyDl
         EdN8rM3lzogYqcB5duzhQaktSXBEIfM7NYDi9lH0PUabhA7NP3HiOe+1c5qnYicde+fW
         L5wIRxgVNBmj+G2WYYeEXVt/2Tp4xuUNcrIzi7GRdb9My1Ck94orG/X03gIQslmEI6Bf
         5NBdLGwsjxBLWGSwAM9PEEM2RoWx53SJf2iifP713a1IH2bR1wxsCyfg6SaX8Hou0O9H
         f3hA==
X-Gm-Message-State: APjAAAVbC8uOmHiey/JYtjPBC8Gt0ZwLesGllwLiy/wzFsfln89hlde/
        FMXwBvUPMZO8oqad0qBmA9I=
X-Google-Smtp-Source: APXvYqzpBKUPxTZC8adDVxW7GCvwLElOQ8BTN2uGCBsUu7GYJ+4VM9uMjnF0zxnoIIYIWsH3k991+A==
X-Received: by 2002:a6b:b556:: with SMTP id e83mr13642304iof.128.1566242941930;
        Mon, 19 Aug 2019 12:29:01 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:01 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/6] NFS: Add an nfs4_call_sync_custom()  function
Date:   Mon, 19 Aug 2019 15:28:54 -0400
Message-Id: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The nfs4_call_sync() function creates a default rpc_task_setup structure
that works for most, but not all, cases. We have some code duplication
in functions that can't use nfs4_call_sync(), so these patches aim to
help with that and make it easier to customize synchronous RPC calls in
the future

Anna.


Anna Schumaker (6):
  NFS: Add an nfs4_call_sync_custom() function
  NFS: Have nfs4_proc_setclientid() call nfs4_call_sync_custom()
  NFS: Have _nfs4_proc_secinfo() call nfs4_call_sync_custom()
  NFS: Have nfs41_proc_reclaim_complete() call nfs4_call_sync_custom()
  NFS: Have nfs41_proc_secinfo_no_name() call nfs4_call_sync_custom()
  NFS: Have nfs4_proc_get_lease_time() call nfs4_call_sync_custom()

 fs/nfs/nfs4proc.c | 106 +++++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

-- 
2.22.1

