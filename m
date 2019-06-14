Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA74C46871
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfFNUAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:20 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38766 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNUAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:19 -0400
Received: by mail-io1-f54.google.com with SMTP id d12so419677iod.5
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DV+MaZ1fjcdeutCJFBuiFU7qLT5P1id2QNZvpu2uTDQ=;
        b=HnjiGjRctjZSilKcIjgDN6oHCbde8ptiGYAVJ8dxgF+1E+pFKkH14xjtT4hQPHf9kH
         LYHC6CE7ZDwS70i3VWyK4wXa1dABDNkmxyqCs1eqLc7nlmYoZ7F5RcWv4dIjUiwe0aQJ
         6DpNULkECiCmrq7ivPhPMdJIEOhw4FXsq09a44Em/XE+9NAPWLtIPV3v2Xtd2eFBlakG
         JI9TPEe8gdVPrDt5lxE+j1YIeLnwAgYI6szANXoSjsY20ZqtSZ2A8yUdQoYGXGT8OIJT
         RLZY2pKtlL1jKJ2/Ht4nIAmQkccc+uzsMEon2XAkJqyb5zbgo4PqUaGNtE8VYevZ462Y
         E8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DV+MaZ1fjcdeutCJFBuiFU7qLT5P1id2QNZvpu2uTDQ=;
        b=o+FGS9PML+K1MGWifu+HmvvZYfxsNpXOPv6ZrLR2sw3OmWSly7dxep1IyqIx50zUDX
         CSWhphnhBdKjL0GkAzMPUMN421MgOCxQ6X9lO8SnpYHpI0FoStqAe/IQBz2JgxMyNQv5
         dYKug24CW1t4LjhKhq9SpIn5sYTRYS/43XQ9KAjLYLCiZ+nuSVBJ1XcuARlDlvpOIH+x
         tvKMdEPcBkTRVfjAJ0YY7Q6s23Vf+Lh2Dt7klG/J9ZspbfNToEixPEo/gF+gaBdK4UD4
         OjuI+JWPBdsDyJdsgpH7nZ1G1uhuI9iXaD4LqVsDRLPTgqYKncSF77enM8yJGcowWn3b
         8BSw==
X-Gm-Message-State: APjAAAWfTJ1ogTQCSObYa769Y2c6QydhE457ygO/7l9QMxbX1+RIzrIr
        V5AS2jnwwaNyVem7xjoX1BM=
X-Google-Smtp-Source: APXvYqzdwL/NM/5bKwiUJU0expD48XAF6xLxHPXFbZ9HMNxqf9/xLf2uJEDZz4KrXDDtD5jGeVXgHA==
X-Received: by 2002:a6b:cb07:: with SMTP id b7mr4639580iog.7.1560542418831;
        Fri, 14 Jun 2019 13:00:18 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 00/11] client-side support for "inter" SSC copy
Date:   Fri, 14 Jun 2019 16:00:05 -0400
Message-Id: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
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

v9:
--- reworked reboot recovery for the source server. previously copies
were stored on the destination's server structure list, but when source
server reboots it can't wake up the waiting copies to be redone. Instead
now add the copy to both the source server and the destination server so
that during recovery we can find it on either of the servers' lists.
--- when a source server rebooted and the destination server wasn't able
to read any bytes and in the callback it returns NFS4ERR_PARTNER_NO_AUTH
with 0 bytes, treat that as source server reboot.

Olga Kornievskaia (11):
  NFS NFSD: defining nl4_servers structure needed by both
  NFS: add COPY_NOTIFY operation
  NFS: add ca_source_server<> to COPY
  NFS: also send OFFLOAD_CANCEL to source server
  NFS: inter ssc open
  NFS: skip recovery of copy open on dest server
  NFS: for "inter" copy treat ESTALE as ENOTSUPP
  NFS: COPY handle ERR_OFFLOAD_DENIED
  NFS handle NFS4ERR_PARTNER_NO_AUTH error
  NFS: handle source server reboot
  NFS: replace cross device check in copy_file_range

 fs/nfs/nfs42.h            |  15 +++-
 fs/nfs/nfs42proc.c        | 193 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfs/nfs42xdr.c         | 190 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4_fs.h          |  11 +++
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         | 125 +++++++++++++++++++++++++++++-
 fs/nfs/nfs4proc.c         |   7 +-
 fs/nfs/nfs4state.c        |  40 ++++++++--
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |  25 ++++++
 include/linux/nfs_fs.h    |   4 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++++
 13 files changed, 586 insertions(+), 45 deletions(-)

-- 
1.8.3.1

