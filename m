Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BDB42BB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfIPVN4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:13:56 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39457 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfIPVN4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:13:56 -0400
Received: by mail-io1-f45.google.com with SMTP id a1so2466615ioc.6
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BfnBLb6bhE7eoYQ/+vsrvUWGHJTUslyp1tTj67gSM7Q=;
        b=alsjw11DAhM/UU11JGqy6vXeQhIE8OsmuMw/1KGEWHZ4MHADeQ2tYfamRJMladTjYW
         Y26XQqWyjRCdOsgpc1hfO8AiiNT9jmF9bUlaiLL2Theb62tDF72GlduMgOrZbtNxpcPO
         3TvFmP3iMPI18/CzptPLK8vMWzQ/MnIZTe11meuPTNVcxYK1qs+5ccfE2Ccf979aY60y
         iKajWT5U9AcKl7bEV5OUTrG03ir1Yd8kM9YsQuoGtw8JK1J4AH2JLD4FoJUjhZDzPxN6
         u+DyqZf50ZntIpFxb1+3WZYLQOkPSIkx9P2JDih226U5TiLdStiXbMfZouGk40/oPAIF
         QkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BfnBLb6bhE7eoYQ/+vsrvUWGHJTUslyp1tTj67gSM7Q=;
        b=ldaL6sQqVOtQ3L7KSPWujqSeuNBHZ4iH2KjbfSqP4NkpN27DPnJ37hYT1Jkw9DubTu
         LnJu/E02Zjx/EC+y4djdbx+yZcdOu4P4V6D3kjB895q1Ax954M6FOdWtUTNAreuuYlI5
         Lg88sTs+s95IC5p00Hk7g3UwyXZgab9Z3z7d7nbX6xXMxJCdajT9fX4TBBieh9YQr2sW
         7JNV8AjdJKKyKgoCKJy/Hf7CFr+Ly3O3XyBn/18ovdw9q1JNn6d7EAOf4o3RYMQ2Eljk
         Yv22KufBdTmd6LOqr1COmG1t+UalY/mnyvgENYj1W3ezSc0Q0gjTo1WZTs7YIZkzLLxr
         T6ew==
X-Gm-Message-State: APjAAAVL5q6hdEiY77k6GYUfS9RkYYJoIiEQHJlQYFZ2LF42m+veLH5m
        ycNaQDKmjeg3zlbq7NWho/4=
X-Google-Smtp-Source: APXvYqw+nBlFkhBcRsdnf3ofolQmAzsNKB9pFJ831BX5ObI5as33E68j8Q0Ed8rddHHjUZjhTJXOnQ==
X-Received: by 2002:a5d:9410:: with SMTP id v16mr402229ion.10.1568668435672;
        Mon, 16 Sep 2019 14:13:55 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.13.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:13:54 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 00/19] client and server support for "inter" SSC copy
Date:   Mon, 16 Sep 2019 17:13:34 -0400
Message-Id: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v7:
--- rebased patches ontop of Bruce's nfsd-next

Olga Kornievskaia (19):
  NFS NFSD: defining nl4_servers structure needed by both
  NFS: add COPY_NOTIFY operation
  NFS: add ca_source_server<> to COPY
  NFS: also send OFFLOAD_CANCEL to source server
  NFS: inter ssc open
  NFS: skip recovery of copy open on dest server
  NFS: for "inter" copy treat ESTALE as ENOTSUPP
  NFS: COPY handle ERR_OFFLOAD_DENIED
  NFS: handle source server reboot
  NFS: replace cross device check in copy_file_range
  NFSD fill-in netloc4 structure
  NFSD add ca_source_server<> to COPY
  NFSD return nfs4_stid in nfs4_preprocess_stateid_op
  NFSD COPY_NOTIFY xdr
  NFSD add COPY_NOTIFY operation
  NFSD check stateids against copy stateids
  NFSD generalize nfsd4_compound_state flag names
  NFSD: allow inter server COPY to have a STALE source server fh
  NFSD add nfs4 inter ssc to nfsd4_copy

 fs/nfs/nfs42.h            |  15 +-
 fs/nfs/nfs42proc.c        | 193 ++++++++++++++++----
 fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++-
 fs/nfs/nfs4_fs.h          |  11 ++
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         | 125 ++++++++++++-
 fs/nfs/nfs4proc.c         |   6 +-
 fs/nfs/nfs4state.c        |  29 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 fs/nfsd/Kconfig           |  10 ++
 fs/nfsd/nfs4proc.c        | 436 +++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c       | 215 ++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c         | 155 +++++++++++++++-
 fs/nfsd/nfsd.h            |  32 ++++
 fs/nfsd/nfsfh.h           |   5 +-
 fs/nfsd/nfssvc.c          |   6 +
 fs/nfsd/state.h           |  34 +++-
 fs/nfsd/xdr4.h            |  39 ++++-
 include/linux/nfs4.h      |  25 +++
 include/linux/nfs_fs.h    |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++
 22 files changed, 1429 insertions(+), 121 deletions(-)

-- 
1.8.3.1

