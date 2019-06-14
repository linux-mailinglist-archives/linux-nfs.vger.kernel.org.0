Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF084687F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNUA5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40134 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFNUA4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:56 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so8356886ioc.7
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CvhqTb70cz6lbJtSe8j4vvY2P9BTDBl9cZxsj8MT6R0=;
        b=LB0wceN6d4tO0hN3yp4UC3zkL3msaH3Oq6j/ok61kpUdn+NFz/tE+du3tLdtnbKqlN
         cgZdcvIRd3WMkTiwep9u+ApqrMeezfYjLoKDxIBPHapToLCn1f7l80ukmgQq6B3LZlNB
         gNVoa5Fx1CT0tAsUTWAGVcuP2vPx2rqM3cOkEftuc4MdOX5bhZtTT/kXtMEZDQBOgTIz
         D06QMVcI8vwc82y5FwDfkgSIElWnx8DFFVZUYAR1AJlqibu/bDlAbbY3Cg0/2mhhaPhn
         I8Et1N7FLYqH+MuljGkDqjuwYoKzKlHjkp/VuuE6zNZrs6uALvZMEMJofM2ZNp41ptxZ
         F5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CvhqTb70cz6lbJtSe8j4vvY2P9BTDBl9cZxsj8MT6R0=;
        b=NLfNR+EoKw9uUKt1z4oq9GCIEXg900cPQcIuVmWCR+7K5Ek4wn7AKiF+eXA/+7mqwk
         dzW5I+XfExTSzZKC6k/VjdpqoSUfwdG8oACxEvJx9ROcCmZ73nzOwIHjO6WOVvR6EtwE
         QdKWBl5s3hmmwVWUpN2fmN80lQGecy/7CaZt5LoJ8CAqob8IMnpsmtS/5x3MY6WMe/63
         iUqKB0Xm1v5miS/nw6uE4Genxy9DSwHTmfSGvg1xoDKlkAOjCaMicVj20z5w3KoolnCh
         wMQwXCkVEmlJCAsUbi4n/kDb1CmXJ1lfMtdOpcQk/Dorl95stDyY5Sc3kJkSQBWmELEF
         clMQ==
X-Gm-Message-State: APjAAAVbwmO3b/WhV5IDqrcMFKxfZDEGaOJ9fZ6MsaPDYOtPBAR/Aier
        AY51SFTCoKaXRp98vwRhmxQ=
X-Google-Smtp-Source: APXvYqw0m6aWh6y14/QYXpHAwkgAuihJyUyC0eansaXcuyOv3CADhGhP9hkyLt4y5w0b8lBbdIX5ew==
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr483946iog.195.1560542455800;
        Fri, 14 Jun 2019 13:00:55 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p4sm6528115iod.68.2019.06.14.13.00.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/8] server-side support for "inter" SSC copy
Date:   Fri, 14 Jun 2019 16:00:46 -0400
Message-Id: <20190614200054.12394-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

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

v3:
-- when nfsd_copy_file_range() returns EBADF and no bytes were read
return NFS4ERR_PARTNER_NO_AUTH to signal to the client to restart the
copy. EBADF can happen when (1st) READ wasn't successful to the source
server due to server reboot or taking too long to make the 1st read
after COPY_NOTIFY was sent to the source server
--- made changes as per Bruce's comment. (1) changing struct nl4_server
not to be allocated on the stack (2) move checking for copy compound to
allow for foreigh filehandle in the compound in a separate function.
(3) removed might_sleep().

Olga Kornievskaia (8):
  NFSD fill-in netloc4 structure
  NFSD add ca_source_server<> to COPY
  NFSD return nfs4_stid in nfs4_preprocess_stateid_op
  NFSD add COPY_NOTIFY operation
  NFSD check stateids against copy stateids
  NFSD generalize nfsd4_compound_state flag names
  NFSD: allow inter server COPY to have a STALE source server fh
  NFSD add nfs4 inter ssc to nfsd4_copy

 fs/nfsd/Kconfig      |  10 ++
 fs/nfsd/nfs4proc.c   | 420 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c  | 122 +++++++++++++--
 fs/nfsd/nfs4xdr.c    | 172 ++++++++++++++++++++-
 fs/nfsd/nfsd.h       |  32 ++++
 fs/nfsd/nfsfh.h      |   5 +-
 fs/nfsd/nfssvc.c     |   6 +
 fs/nfsd/state.h      |  21 ++-
 fs/nfsd/xdr4.h       |  37 ++++-
 include/linux/nfs4.h |   1 +
 10 files changed, 763 insertions(+), 63 deletions(-)

-- 
1.8.3.1

