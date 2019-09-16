Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D492DB423E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfIPUq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:29 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:37197 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfIPUq2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:28 -0400
Received: by mail-io1-f49.google.com with SMTP id b19so2341706iob.4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyrPO6lqSlIeoqJU2FkCClb2Q7flkyCFG2CDiMoCRpA=;
        b=jD1ctqM9QahPcOIpGf368v1k3Z0XddjukLpkxoBM/NC9MZJwkDc6NeExunh/ScepPT
         vLUWgJ9N/0GRk96JFUbm/GGQDqTMjAm1+wzUl3dBb0cUYu3G8R8xIU2j0dNvJPPLW19y
         JhMg4pjHEAeA2VOG/fjQ4a1x2oeQaEz4HyMEymTG5naxh778B7AYWsAtWWZ+CalMqmRz
         perjY5Hsm4raFhMi0WU5M021GCGyMwDBsj74N0S3YEIElhNzrP7rvQJJxK//5ey/5eJU
         vA9w7C9Rj1Mj7Wx8lSGM1eb2rdjqMrVlMAeZqzxN1cRAFy+GKEqm/fB+tBnjvaINpXaC
         fNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyrPO6lqSlIeoqJU2FkCClb2Q7flkyCFG2CDiMoCRpA=;
        b=JgV2A36xg8m0H9UMVrogivItlUGtaLP3GEwZ7ZB0z+CWLZIWnA6yBP12P5rT7T8rtE
         HghaZLEGG51ToXWO32f6S7zkrV2EKz3Qp4cMMtDC9zsvZudQIQEs5sC8I+0wYMrm4JSJ
         dHfcDWUg1/DzFubkHVho/bxNmQHJ3CFtXrMpZ4/ImcVRz0whqEW7ejmI0W8kw0Qa0HaG
         k5kpgvdRhUov5jJhM1Qd4s6tT73M7VSewPdKOrws3DbuQXPR/1sb2OLYMzsv18WiD9kI
         yNInUQSMVMKlQ44okMbjIzExz8WSObQ3VlEesC12oG9myjq0Z4ZAwpiTvfQJ5Zb5qwH7
         rI7w==
X-Gm-Message-State: APjAAAUWhnzU6Mnbij6TyAgwyeSX91KYbwC+U4DAm8rqheg5iNp2jU3m
        biui9QuGEgl+4oRu0P06fvvIvGB8Dw==
X-Google-Smtp-Source: APXvYqwaE1Y28MZQz86rJLHKJ43rqsW5JfTVAof8R+weNzZlA7zmWoA81Kex487QlOZXla4mqAqHEg==
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr289501ioe.28.1568666787315;
        Mon, 16 Sep 2019 13:46:27 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:26 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Date:   Mon, 16 Sep 2019 16:44:10 -0400
Message-Id: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Various NFSv4 fixes to ensure we handle state errors correctly. In
particular, we need to ensure that for COMPOUNDs like CLOSE and
DELEGRETURN, that may have an embedded LAYOUTRETURN, we handle the
layout state errors so that a retry of either the LAYOUTRETURN, or
the later CLOSE/DELEGRETURN does not corrupt the LAYOUTRETURN
reply.

Also ensure that if we get a NFS4ERR_OLD_STATEID, then we do our
best to still try to destroy the state on the server, in order to
avoid causing state leakage.

v2: Fix bug reports from Olga
 - Try to avoid sending old stateids on CLOSE/OPEN_DOWNGRADE when
   doing fully serialised NFSv4.0.
 - Ensure LOCKU initialises the stateid correctly.

Trond Myklebust (9):
  pNFS: Ensure we do clear the return-on-close layout stateid on fatal
    errors
  NFSv4: Clean up pNFS return-on-close error handling
  NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
  NFSv4: Handle RPC level errors in LAYOUTRETURN
  NFSv4: Add a helper to increment stateid seqids
  pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state
    seqid
  NFSv4: Fix OPEN_DOWNGRADE error handling
  NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
  NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU

 fs/nfs/nfs4_fs.h   |  11 ++-
 fs/nfs/nfs4proc.c  | 204 ++++++++++++++++++++++++++++++---------------
 fs/nfs/nfs4state.c |  16 ----
 fs/nfs/pnfs.c      |  71 ++++++++++++++--
 fs/nfs/pnfs.h      |  17 +++-
 5 files changed, 229 insertions(+), 90 deletions(-)

-- 
2.21.0

