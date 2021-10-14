Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5642E093
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 19:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhJNR5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhJNR5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 13:57:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD4C061570
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id v2so4193826qve.11
        for <linux-nfs@vger.kernel.org>; Thu, 14 Oct 2021 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4REhmtKkXdYKzNB+V7TCzPzrBsG0gXeVBvTQ79le6s=;
        b=iTO59ip+LYtEpmah7coqkaL0EQXFm7BK1AN17/5Y63dr4oWQArYqzgh0Eb1ZR3b+B3
         /KVpDCpReZaADn31DAPxRxUJyGKsDSSxQp1ANF4DGt01QqGuSlxTKR27+m07vQO7pVge
         yc/7invF33sKDL84U+fLUCSC1e4FzFiJ4LSHTNFQD34ajTqaD8eRFxPta8ogQWWatiSh
         1fbo1l8dITU7a8wqxYvaYuKhXMfHSVwzbF02jDQFWKMIVi3oJ01UypAlPMrBKL4pzWVf
         iSGZ548+7b/UEwC79p1p9+xyGX1rfGznOvjkwcbxUOu3oaKwcVjxYzWg7YJs4DJdKS5G
         X4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=i4REhmtKkXdYKzNB+V7TCzPzrBsG0gXeVBvTQ79le6s=;
        b=jvJZ3V5ufSTS6OEG4IgklicSphaYwJqG2Ag5ZiWgKctC0fKQaAcvoFlN0Ih4F0zoSw
         VlDCzJV66jIKZ6oLL+2COlyrCe/jHHfKtj+1MXe8dnTiQ5wZZ7WFu3p9XKoGceopwwp+
         5s7TBwxoUpbQbI2y5ff23SCV2bI8GPRopBp0VLQX4YOcCaqY9OZScxmb9VNzTvcUrhhE
         Cwf72XrBEJg9BAuRKHxFChzlUo/ZDQy+Fe0sb5s+T0lGhDo14wKPRs8DXDG7CzjS0pXP
         mzoebiTu0PZvbTUB/ezxj+H0JVSMgXtmZhbeOf1lkS7MuuWER5PIve8Z33Thhwn6eQ2S
         Ivmg==
X-Gm-Message-State: AOAM533z6vhjMKMw4p2BvKZpycHrCzZCyOeEYLEBl6Yr8Ah+BPhjRyWX
        DyhWYBYVYfj4s9/B5k0YBN0=
X-Google-Smtp-Source: ABdhPJxpm+GRxgva5bizrGc++XxN82+ulPdwEgwlQZerK2acBjS6lxf3RhGhjMkzSMBpmuZUFwr8hQ==
X-Received: by 2002:a05:6214:a10:: with SMTP id dw16mr7027383qvb.57.1634234109896;
        Thu, 14 Oct 2021 10:55:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id m6sm1536131qkh.69.2021.10.14.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:55:09 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 0/5] NFS: Re-probe server capabilities on remount
Date:   Thu, 14 Oct 2021 13:55:03 -0400
Message-Id: <20211014175508.197313-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

These patches hook into the nfs_reconfigure() function to reset and
reprobe a server's capabilities when remounted. This could be useful if
a server is upgraded to support a new NFS v4.2 feature or if it has
other changes that can only be detected at mount-time.

Thoughts?
Anna

Anna Schumaker (5):
  NFS: Create an nfs4_server_set_init_caps() function
  NFS: Move nfs_probe_destination() into the generic client
  NFS: Replace calls to nfs_probe_fsinfo() with nfs_probe_server()
  NFS: Call nfs_probe_server() during a fscontext-reconfigure event
  NFS: Unexport nfs_probe_fsinfo()

 fs/nfs/client.c     | 37 ++++++++++++++++++--------
 fs/nfs/internal.h   |  3 ++-
 fs/nfs/nfs4client.c | 65 ++++++++++++++-------------------------------
 fs/nfs/nfs4proc.c   |  2 ++
 fs/nfs/super.c      |  7 ++++-
 5 files changed, 56 insertions(+), 58 deletions(-)

-- 
2.33.0

