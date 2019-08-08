Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7A86B41
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbfHHUSw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35843 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404324AbfHHUSw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so123774238oti.3
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ZrKst6Z22aNLoclBaGsKJhDbkaWt/+Vox6zypZbPPY=;
        b=vX4Ej/WJ8jXqqs49AE2PxqYZwpukoBObG2eKwk9fvdJlUI/dhzm3MiZwQCfhqAeIf8
         VJHawdGuESNDfCYSFgsU954VsSVi/e4Cv8TigLUEr3L1Mbo8k3I/pQY0DXsmNdZ5APWH
         exkKEK3/cGTLVx2kizYqXTJsiToEIuLdfDwQySHd0vey0Az3mEQAqOY18Yf0Z200ZM+g
         H7owzqrGsEyDkDx6Vk7QW4bvI9YrMhkMH+jrrTdQygtldS1I93IpIZvd98H+iq/CPmoZ
         HjMhw61sdkh8RLyQH7Qt5F39phrzihARGBAqWmu05No2mz4zZeOEk89fteLqXe/odKhF
         H7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ZrKst6Z22aNLoclBaGsKJhDbkaWt/+Vox6zypZbPPY=;
        b=Kr8K6GfHGUiNwxc8vRgFr2XTmGqsG01ePXe0bkKm56lHY/mCesWyMESBUtQkhJcsbT
         C0NgBOKTKTQAFtjOyIZT+ktlvljytWzhtYIvPun4V3G6TWQAo7DFTsQecOUgSOMRWdOo
         2h+5bg1qUZW/ZEtSaQP5zAkuJQy62xhSwiSmzKBIflWJYb6sDvGvyc23BE3lDqFY78tl
         emwj2vxNkDbqRCiwONelcYtDLh8Jlo/2ygZ5t0b5rBmxtOJExzfmUVsic9Z2d7kBecPE
         +7xdKSQnRm1PE0nLqq9p2OgqvGEo4XoeIdZH6colu9NVBoULni+L7QAVyFK6LCDjtRy5
         dvRQ==
X-Gm-Message-State: APjAAAWgH443K6m7u15rChaA7KCMEkdFvKlW74FhxOIrLiiIuE5MED3G
        oCKfBJMrRvrCmeLBnVxKlSE=
X-Google-Smtp-Source: APXvYqwGj0IFLI+GtJKBCHEaP0ordpfWmFYTST5Iojl+6WPicckgfrSu1R+w2183pOjnBFeu1NTOyA==
X-Received: by 2002:a5e:c914:: with SMTP id z20mr11969024iol.272.1565295531252;
        Thu, 08 Aug 2019 13:18:51 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:50 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/9] server-side support for "inter" SSC copy
Date:   Thu,  8 Aug 2019 16:18:39 -0400
Message-Id: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

v5 fixes:
-- Remove unused nl4_ulr/nl4_name types
-- default to warn_on_once
-- move 2 chucks of use of stid into previous patch
-- in the idr store stateid ptr instead of copy or copy_notify
-- add sc_type to distinguish copy and copy_notify stateid (for that need to re-work data structures to encapsulate stateid_t with sc_type)
-- rework how initialization of copy and copy_notify stateid is done w respect to adding it to the global list
-- during compound check to allow for stale_fh make sure that saved fh was set – done
-- separated the copy_notify xdr code into its own patch
-- need to insure the parent stateid is valid for copy_notify accesses. in
preprocess_op take a reference on the parent stateid and hold it. on the 
put_stid, check if there are any copy_notifies associated and account for them
during decrementing a reference count. add to the laundromat, traversing copy
notify list of the client pointer, if entry is passed a lease period, then
remove it.

Olga Kornievskaia (9):
  NFSD fill-in netloc4 structure
  NFSD add ca_source_server<> to COPY
  NFSD return nfs4_stid in nfs4_preprocess_stateid_op
  NFSD COPY_NOTIFY xdr
  NFSD add COPY_NOTIFY operation
  NFSD check stateids against copy stateids
  NFSD generalize nfsd4_compound_state flag names
  NFSD: allow inter server COPY to have a STALE source server fh
  NFSD add nfs4 inter ssc to nfsd4_copy

 fs/nfsd/Kconfig     |  10 ++
 fs/nfsd/nfs4proc.c  | 453 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c | 179 ++++++++++++++++++---
 fs/nfsd/nfs4xdr.c   | 154 +++++++++++++++++-
 fs/nfsd/nfsd.h      |  32 ++++
 fs/nfsd/nfsfh.h     |   5 +-
 fs/nfsd/nfssvc.c    |   6 +
 fs/nfsd/state.h     |  36 ++++-
 fs/nfsd/xdr4.h      |  39 +++--
 9 files changed, 840 insertions(+), 74 deletions(-)

-- 
1.8.3.1

