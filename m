Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26AC4455C3
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKDO75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKDO7z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 10:59:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C9C06127A
        for <linux-nfs@vger.kernel.org>; Thu,  4 Nov 2021 07:57:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id f10so6462011ilu.5
        for <linux-nfs@vger.kernel.org>; Thu, 04 Nov 2021 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po/rWnP2OWlGs2oX2RP+Nl8Q9FmGoRi/U1lFMQTgu08=;
        b=JwOJ0dn4Q5K45qS4u4YNrviYJcFaK75b7ZfdavZ0JvYibJOvf/GnXn6AzDSGIryW2u
         Z5PXxbohSFP34gqXqgTmk+ZFhTG6bu1c6ekWZiUEddK8PCGGl/4ThXGdOEYiJQqwEKtH
         WfDEYVf95mUovtebv7J2pxPi+0IqykhR/YTkTG8iO2QrtePV/Ud6cif0Jph5Jkqf5Ozl
         WGuxZ7I+jyJWeWWnqnHsdXdM2Ixqfx5D7y+mY8ISK3qN/QuTjQx2Fl+feri+FamJ33PQ
         wBr4WcXwGlDiJ+qsSNTNBpTVwXBHx6F4ZAbuL5jA+OYRNXNogoHsSto15Ed9Ps1QtlKi
         t/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po/rWnP2OWlGs2oX2RP+Nl8Q9FmGoRi/U1lFMQTgu08=;
        b=DzSbV13HhtX/GkQqe3VXh3gc1hHFazT5qWcMZFMcstLsJPWT0N2LRBtBJY+jSNlhda
         /2fOTD3XXfXbO0M/3jWsQfcIKYeI2K/Pn7u7mseMJqYMM1enOP6shsnmRiXqgYtShVt2
         pryrhRsiqEtjMjYguiAiHtARvgbkgmAu3CMUxoDVkDkfj+UJf23nTOJTgDmz4SE2PVyL
         f6tnJpF2BO98O5icIc7e4vCp6kifMY2oJxu+8T+lJsL/Q8ePUwOADZRT9c24ALgbS23Y
         R8mCJDk9CDzUn6WTV5e84+timHEliOkvtUPrjfmXUGum4gQMxXto7vnNuikzijBB3FsG
         D+Ow==
X-Gm-Message-State: AOAM53244L44rRVz+0/u2dWUOW0FlnBuq8pFRbDPVxrgDZKk+XlxTtVR
        Q+f2lQpYa53dFZw2e+Yw2k4=
X-Google-Smtp-Source: ABdhPJzfDIMjUxEgt9G0Qr9MyTKAC4f/pT1FJfhtxepS29QhaPCwgBH7bCL6R4WpXZf0Fc56ljOPiQ==
X-Received: by 2002:a05:6e02:1588:: with SMTP id m8mr35412744ilu.188.1636037837033;
        Thu, 04 Nov 2021 07:57:17 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:886c:a169:fafb:e7cf])
        by smtp.gmail.com with ESMTPSA id c12sm3007157ils.31.2021.11.04.07.57.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:57:15 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        chuck.level@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/7] NFSv4.2 add tracepoints to sparse files and copy
Date:   Thu,  4 Nov 2021 10:57:07 -0400
Message-Id: <20211104145714.57942-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v2 changes:
- addressed compile issues with CONFIG_NFS_V4_2 isn't enabled
- addressed grouping assignment based on the error value
- addressed reusing show_nfs_stable_how instead of defining new

Olga Kornievskaia (7):
  NFSv4.2 add tracepoint to SEEK
  NFSv4.2 add tracepoints to FALLOCATE and DEALLOCATE
  NFSv4.2 add tracepoint to COPY
  NFSv4.2 add tracepoint to CLONE
  NFSv4.2 add tracepoint to CB_OFFLOAD
  NFSv4.2 add tracepoint to COPY_NOTIFY
  NFSv4.2 add tracepoint to OFFLOAD_CANCEL

 fs/nfs/callback_proc.c |   3 +
 fs/nfs/nfs42proc.c     |   9 +
 fs/nfs/nfs4trace.h     | 443 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)

-- 
2.27.0

