Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF686294A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfGHTYn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:43 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45953 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfGHTYn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:43 -0400
Received: by mail-io1-f45.google.com with SMTP id g20so16752368ioc.12
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q7LhehhitmgmJxMCsK0gP8VrZxCYtZse9FwORRaOELk=;
        b=ePqZb0XTYJCaMNA4jPmb0eDjqLLdWiWe1oORbn9m9SJtA0g4yH0B1VftkiBDbEKcre
         YB+vcZJcU32dVnRcAxR4wrXGvzXsJ0NUnmQ4+DMtIJnlugAgoibxQtPbJTrP7t/hx22w
         pscGUu0yfOzaHlBNT6ehgiDBGXu1PFi1l9zGus34B82itzMLcgU7iVNA0l1O0EvlZpSY
         kB4ntm+CArfLU0v9F8EbrG+mMqzmr9eBDZejJao6MMk6aJ27qRyzYu/DNKDnjY4QpQfG
         /WFSephALYKIHDKcETBvOnzi/ue8bOVWPmcD7YT5e/RQnxURIAEOwNkz9bqYakItebrp
         QVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q7LhehhitmgmJxMCsK0gP8VrZxCYtZse9FwORRaOELk=;
        b=cnDfpueKuJRTdf1EOKZoqCO5ofmx5ncSCwisb6iMQNdN9CSnN27otNCq/EhJONjMUv
         DiTSTwqvPoPVQWtziSWJmM6K9JQLVp5mrJx7iL2MR/rvxcobCtz5Mmrks4CpDeNDQpLH
         Zd8HeyoIiWtKR+9uo2y27IE34EX8eWj2IbOOfKG0HNCxHqBncBK+sh+wGhzt+VVvqe2v
         X84lpUNg1HlrLmUZdpWEWJ7c7kMcTlf6SMhq0eupnw2IPKvotyFEVDQcl2XgpMYKEPBO
         +4nB2md8esca6TJLrf3WZ/Zkanfi6Wvrn1SnOYWCehKGbdjtvXiOSt9sJfRuh/VPI7sM
         h1QQ==
X-Gm-Message-State: APjAAAUXdz3IPVukvvjYiwBC+AoMNGsb9MuFIBQeEWNFPthU5QakVvPo
        Jo+631CTZ22sqtSWN5CZEFhy5CEGMEA=
X-Google-Smtp-Source: APXvYqzgs9t4k/qjo4fnXxnRwD1VXv88oynOrc7mFZfmJhw4p8zHy0WsGJIRgRsgueHeNARIejBYVg==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr21817940ios.227.1562613882939;
        Mon, 08 Jul 2019 12:24:42 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 00/12] client-side support for "inter" SSC copy
Date:   Mon,  8 Jul 2019 15:24:32 -0400
Message-Id: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch series adds client-side support for doing NFSv4.2 "inter"
copy offload between different NFS servers.

In case of the "inter" SSC copy files reside on different servers and
thus under different superblocks and require that VFS removes the
restriction that src and dst files must be on the same superblock.

NFS's copy_file_range() determines if the copy is "intra" or "inter"
and for "inter" it sends the COPY_NOTIFY to the source server. Then,
it would send of an asynchronous COPY to the destination server. If
an application cancels an in-flight COPY, OFFLOAD_CANCEL is sent to
both of the servers.

This patch series also include necessary client-side additions that
are performed by the destination server. The server needs an NFS
open that represents a source file without doing an actual open.
Two function nfs42_ssc_open/nfs42_ssc_close() are introduced to
accomplish it that make use of the VFS's alloc_file_pseudo().
This patch series depends on removal of the cross-device check which
was done in Amir's VFS generic copy_file_range support.

v10:
--- new patch (#12) is added to toggle sync/async copy and also
fallback to traditional copy for small enough inter server to
server copies
--- moved and modified patch "also send OFFLOAD_CANCEL to source
server" to include sending OFFLOAD_CANCEL when the destination server
returns ENOTSUPP on COPY so we need to clean up state on the source
server

Already presented numbers for performance improvement for large
file transfer but here are times for copying linux kernel tree
(which is mostly small files):
-- regular cp 6m1s (intra)
-- copy offload cp 4m11s (intra)
   -- benefit of using copy offload with small copies using sync copy
-- regular cp 6m9s (inter)
-- copy offload cp 6m3s (inter)
   -- same performance as traditional as for most it fallback to traditional
copy offload


Olga Kornievskaia (12):
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
  NFS based on file size issue sync copy or fallback to  generic copy
    offload
  NFS: replace cross device check in copy_file_range

 fs/nfs/nfs42.h            |  15 ++-
 fs/nfs/nfs42proc.c        | 199 ++++++++++++++++++++++++++++++++------
 fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4_fs.h          |  11 +++
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         | 139 +++++++++++++++++++++++++-
 fs/nfs/nfs4proc.c         |   7 +-
 fs/nfs/nfs4state.c        |  40 +++++++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |  25 +++++
 include/linux/nfs_fs.h    |   4 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++++
 13 files changed, 604 insertions(+), 47 deletions(-)

-- 
2.18.1

