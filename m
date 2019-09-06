Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3CAC0BE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392216AbfIFTqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:35 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:40218 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFTqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:34 -0400
Received: by mail-io1-f45.google.com with SMTP id h144so15380474iof.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ipo2D6z0gnLBacph9tAWGHP/GtINH38xaCHihdYZN1Q=;
        b=W5kuSzdslNz+BXpqRUFfP27E2H8BMq9+JzzEC7y4eMXO0Ry1Le1in6eZIWBpr+g3DH
         NUCtsOH1QAWiY2r19q7LMcsqZeEfj2QZ+5Sl8/Wk345rsleQMQKdHsvaOxZroo7qRRcq
         024Rf4URHF/XWqLKDOzt/i/fU7gUIHt99VUjKCm0I1o2ps3KamWqdo7vLXitRkCSzUsG
         xkMAReKLYiHdZ+1ss//TZxtnkAgUXSHfzoU9ZktRZNN03V0lEp+Ew2Xz8++KFt4U3Ai7
         /1iC+//5DW/o8EhtCjiMaqiwe/TXi5XB/4tPpWkypZXb7QIUgzVQrwLX5r30fYIY49Ex
         mspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ipo2D6z0gnLBacph9tAWGHP/GtINH38xaCHihdYZN1Q=;
        b=s7CmpR0den8sk1o3pm9pdL5fXCbupzUWePCtE2j1Cjydp4XlpriR9vYdUur6Rv6dMx
         IEhGnQjXXCwtOrYozuKJD+5ZT0uv0IqcWsg76RyTMxbNqlruvZCk2h/OnoUVpDIcAppk
         t6vYM6pbJdAxBPo7tO0KxjBqFpxh+Ytp1h1qhmfeGQk0mX2p+RwBawwWbSy7wMwXLTPw
         zM8YPDrGCUr8vP4zzp1yWEOkOu98Z5Ejgq5ixFiDnIs+5/S5hcsrIHJP3MrdUC7hnxLw
         1KLcg34KQkZ8XJC0JHXdlu1LujD9e/vqWaLKqhUJJVPtfbbRGnUECHnxxt35u6nWJTgS
         LO2A==
X-Gm-Message-State: APjAAAVGxnaZYrJCVFJiepfE6kFWPNT8YYHuQiVqYyIH3S/05wA5LpAe
        K4a4aUtizKfq3Eti12Lst8E=
X-Google-Smtp-Source: APXvYqxCkYSmYmxJDQGeH67T8tlvjKZHYPFStvR+Kv0i+fDo2wMI4r933ff/70WzynBwFl9VddCm5A==
X-Received: by 2002:a5e:8c01:: with SMTP id n1mr4539636ioj.152.1567799194004;
        Fri, 06 Sep 2019 12:46:34 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 00/19] client and server support for "inter" SSC copy
Date:   Fri,  6 Sep 2019 15:46:12 -0400
Message-Id: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As per Bruce's request submitting the client and server series together
as there is a common patch that's needed by both.

No client side changes were made since the previous submission

v6 server-side changes
--- removed global copy notify list and instead relying only on the idr
list of stateids. Laundromat now traverses that list and if copy notify
state wasn't referenced in a lease period, state is deleted.
--- removed storing parent's stid pointer in the copy notify state.
instead storing the parent's stateid and client id then using it to
lookup the stid structure and client structure during validation of
the stateid of the READ.
--- added a refcount to the copy notify state to make sure only 1 will
delete it (as it can be delete either by the nfs4_put_stid(),
laundromat, or offload_cancel op. basically all access to the copy state
is using just one global lock now (netd->s2s_cp_lock).
--- added a type to the copy_stateid_t to distinguish copy notify state
kept by the source server and copy state used by the destination server.
--- previously with a global copy notify list, the check if client has
state before unmounting checked if the list was empty, now the code
traverses the idr list and looks for anything with a matching clientid
(again under the global s2s_cp_lock).

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
 fs/nfsd/nfs4proc.c        | 440 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c       | 215 +++++++++++++++++++---
 fs/nfsd/nfs4xdr.c         | 154 +++++++++++++++-
 fs/nfsd/nfsd.h            |  32 ++++
 fs/nfsd/nfsfh.h           |   5 +-
 fs/nfsd/nfssvc.c          |   6 +
 fs/nfsd/state.h           |  34 +++-
 fs/nfsd/xdr4.h            |  39 +++-
 include/linux/nfs4.h      |  25 +++
 include/linux/nfs_fs.h    |   3 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++
 22 files changed, 1431 insertions(+), 122 deletions(-)

-- 
1.8.3.1

