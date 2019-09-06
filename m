Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1EAC32B
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393104AbfIFXgO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:14 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:45905 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFXgO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:14 -0400
Received: by mail-io1-f46.google.com with SMTP id f12so16550146iog.12
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fR3fsVAD1gPU7Xx4DJ3MZu5LaPpOW7ufrAJLp5zCznk=;
        b=ckcUp0eKoAyxkM++ItrCTT4fjSjfxtbZjnSCygTDTkz13qUHKV/fU9Zkgoo9bsFB5N
         7JEdjh2RQ4zlhPB7cUb4BJLjZ50zvpvI9FAhcSoKvEOhR8xMXxwdnVODw+11K+ymkaWs
         uM1j20UjElgf1qvI2S9md4KqlxwVcnQORD3iUFja0GZcSxocKm1I1JpUHlv1eUDOe9oK
         O5aoZT6tfWzs/1wCzEf3+IbINxIFQt5bD1+Iai8d+pj7SZUbk1Ywi/5LbfTnzh9pFnG1
         696dzuIvGaeMM/RUEFJIMzPrJEVhxyBMIdujBgYSu4xXH2MoRKqZl64Zavf5pAPcvU/5
         c3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fR3fsVAD1gPU7Xx4DJ3MZu5LaPpOW7ufrAJLp5zCznk=;
        b=m5SpzaP1tofqRH9WNV+gtXT5HIbqYbP+J19s4ZckRz/k6UAog7lgpZ7wwmQK80/U+e
         qd3a6bOrsogr/so+rtl9VKAva3lOm/d7zODF5TibKnwTGhiFwQ7DtVy5pXDlFv+clf8u
         NOczWj0zzgNvdYKDJPoPhkH9l6kdwXd0ezhmQe03LXNUySG6orM5HoIQXgz8UNjfSPQZ
         GPvTf0iU8eNzvW5GpPihcCNEZ1a0gZ0GP6MgzSKgp8LzBCw06+wcgpVVs7r8wdZ9lJct
         wKS7PVSxalbmbuut/moMOo0OSJVLxw3V+Nztw4h1mczsNxeL4LhTR/oSk2FzegLxXVDx
         foxQ==
X-Gm-Message-State: APjAAAWrPiOU67i2TzN6uX7Updb4/fLUomlRYsxw+ICvuhN1D8MLN6cP
        MwvqHyv7BYdvmMIdzlPJbEPjq8xamnk=
X-Google-Smtp-Source: APXvYqzAR3OA25Ty/rkpT3E1Ro0D/G5gJ6VVDbuSwVEmuuaQ4c176iAtj9o8nlT3RFS4ubyDDwm0EA==
X-Received: by 2002:a6b:6603:: with SMTP id a3mr13641271ioc.50.1567812973160;
        Fri, 06 Sep 2019 16:36:13 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 00/21] client and server support for "inter" SSC copy
Date:   Fri,  6 Sep 2019 19:35:50 -0400
Message-Id: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

As per Bruce's request submitting the client and server series together
as there is a common patch that's needed by both.

v7
--- added new patch (11/21) that checks the size of the file and
decides to either do a sync intra, or not do inter at all and fallback
on traditional copy.

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

Olga Kornievskaia (21):
  NFS NFSD: defining nl4_servers structure needed by both
  NFS: add COPY_NOTIFY operation
  NFS: add ca_source_server<> to COPY
  NFS: inter ssc open
  NFS: skip recovery of copy open on dest server
  NFS: for "inter" copy treat ESTALE as ENOTSUPP
  NFS: COPY handle ERR_OFFLOAD_DENIED
  NFS: also send OFFLOAD_CANCEL to source server
  NFS handle NFS4ERR_PARTNER_NO_AUTH error
  NFS: handle source server reboot
  NFS based on file size issue sync copy or fallback to generic copy
    offload
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
 fs/nfs/nfs42proc.c        | 199 ++++++++++++++---
 fs/nfs/nfs42xdr.c         | 190 +++++++++++++++-
 fs/nfs/nfs4_fs.h          |  11 +
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         | 139 +++++++++++-
 fs/nfs/nfs4proc.c         |   7 +-
 fs/nfs/nfs4state.c        |  40 +++-
 fs/nfs/nfs4xdr.c          |   1 +
 fs/nfsd/Kconfig           |  10 +
 fs/nfsd/nfs4proc.c        | 440 ++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c       | 215 +++++++++++++++++--
 fs/nfsd/nfs4xdr.c         | 154 ++++++++++++-
 fs/nfsd/nfsd.h            |  32 +++
 fs/nfsd/nfsfh.h           |   5 +-
 fs/nfsd/nfssvc.c          |   6 +
 fs/nfsd/state.h           |  34 ++-
 fs/nfsd/xdr4.h            |  39 +++-
 include/linux/nfs4.h      |  25 +++
 include/linux/nfs_fs.h    |   4 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++
 22 files changed, 1461 insertions(+), 125 deletions(-)

-- 
2.18.1

