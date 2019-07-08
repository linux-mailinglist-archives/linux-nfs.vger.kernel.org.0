Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4574F6293D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfGHTXv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:23:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40105 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfGHTXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:23:51 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so29634721iom.7
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WXnT0b21DvtGqbCodr/1Rsr0iEvWNoZOkIYmfzCKYWE=;
        b=GKtU7yrqL47NHw9Nb/JlGoO+PTjYRmuootHr8p7598v1C4RHIrIpR4Wnw1l2Nkjehb
         cEeJBqhO0J3vPNZR41CA3Gk90Z8LDQDCk3SyeDrd6tH64JKgufXNrqfz5XNZmzZu7MHz
         coCTtshRmamOC6zli4zVUW9G2HZ4MuqxF2twtNpcDFrmz/fTtYQbbsGS4SddPtKlK4E6
         ltnaT9JsVAB5P7zI0Z32I9aJWnb+FWGtvAk2a9DMswiLsxROxPdEMqrfU8Zs0q6ywIhK
         4LCkKCLf43MLM1yk8nCxQdnjHSzvehSa5mL7BkPCD2v2TKO15JpdqsIvMREmtjxKOoGY
         XPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WXnT0b21DvtGqbCodr/1Rsr0iEvWNoZOkIYmfzCKYWE=;
        b=hiGIyn6chehaQV/RBytAn3Fse+SNarymwmltu6oyO16bcz23TUOuDEmmVDBApqV/hH
         CGnz9CVtAXeT0seJENqRoBmW3xv7ytirPQOUj+NjRbcDxOReexFFiFl3NqZ/oVajJuvR
         x4h3LEERusdjS6AH2dCNF1+SyFijDRO10+K4FwtijCIQpfbH+KKyaqbxfI6m92nCJS87
         L804/++5mDbuBQAAd2GO8+IP57/2yG1MvgSytUwq4ELiAO8tj4EjP7Pd4X01BOqjBFbG
         oDWfylL2q1xsZ636u4vCq4r589V+lvrlXJHrtouJuoQtB7pPqi4/5HZIXmsj/cB73jVU
         /zhg==
X-Gm-Message-State: APjAAAXPoK4om59N5IJlwhey7gmcwl05cPD36PM2Bsi/tERv0dx1z+tR
        XWiuUOzv0QDf1WWCcXJJR8ktE35asL0=
X-Google-Smtp-Source: APXvYqyq+mScHL4rJxb5ebvPHUpclIaxnAsQrgyC+j/JCMrCMNoBa09WXttQVvgG0h+ichdZduhbYw==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr12837591iof.6.1562613830827;
        Mon, 08 Jul 2019 12:23:50 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v3sm9212841iom.53.2019.07.08.12.23.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:23:50 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/8] server-side support for "inter" SSC copy
Date:   Mon,  8 Jul 2019 15:23:44 -0400
Message-Id: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series adds support for NFSv4.2 copy offload feature
allowing copy between two different NFS servers.

This functionality depends on the VFS ability to support generic
copy_file_range() where a copy is done between an NFS file and
a local file system. This is on top of Amir's VFS generic copy
offload series.

This feature is enabled by the kernel module parameter --
inter_copy_offload_enable -- and by default is disabled. There is
also a kernel compile configuration of NFSD_V4_2_INTER_SSC that
adds dependency on the NFS client side functions called from the
server.

These patches work on top of existing async intra copy offload
patches. For the "inter" SSC, the implementation only supports
asynchronous inter copy.

On the source server, upon receiving a COPY_NOTIFY, it generate a
unique stateid that's kept in the global list. Upon receiving a READ
with a stateid, the code checks the normal list of open stateid and
now additionally, it'll check the copy state list as well before
deciding to either fail with BAD_STATEID or find one that matches.
The stored stateid is only valid to be used for the first time
with a choosen lease period (90s currently). When the source server
received an OFFLOAD_CANCEL, it will remove the stateid from the
global list. Otherwise, the copy stateid is removed upon the removal
of its "parent" stateid (open/lock/delegation stateid).

On the destination server, upon receiving a COPY request, the server
establishes the necessary clientid/session with the source server.
It calls into the NFS client code to establish the necessary
open stateid, filehandle, file description (without doing an NFS open).
Then the server calls into the copy_file_range() to preform the copy
where the source file will issue NFS READs and then do local file
system writes (this depends on the VFS ability to do cross device
copy_file_range().

v4:
--- allowing for synchronous inter server-to-server copy
--- added missing offload_cancel on the source server

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

Olga Kornievskaia (8):
  NFSD fill-in netloc4 structure
  NFSD add ca_source_server<> to COPY
  NFSD return nfs4_stid in nfs4_preprocess_stateid_op
  NFSD add COPY_NOTIFY operation
  NFSD check stateids against copy stateids
  NFSD generalize nfsd4_compound_state flag names
  NFSD: allow inter server COPY to have a STALE source server fh
  NFSD add nfs4 inter ssc to nfsd4_copy

 fs/nfsd/Kconfig     |  10 ++
 fs/nfsd/nfs4proc.c  | 434 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c | 135 ++++++++++++++--
 fs/nfsd/nfs4xdr.c   | 172 ++++++++++++++++++++-
 fs/nfsd/nfsd.h      |  32 ++++
 fs/nfsd/nfsfh.h     |   5 +-
 fs/nfsd/nfssvc.c    |   6 +
 fs/nfsd/state.h     |  25 ++-
 fs/nfsd/xdr4.h      |  37 ++++-
 9 files changed, 790 insertions(+), 66 deletions(-)

-- 
1.8.3.1

