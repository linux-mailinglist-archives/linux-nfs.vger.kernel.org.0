Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF602EAE48
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAEPa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAEPaZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:25 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71625C061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:29:45 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z11so26781569qkj.7
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4vTYenFphaCWHVzAvclsMi2fnddGobkpzyazzxh8vl0=;
        b=TRC6XuoF6dEKzrOpSobVoFXDXRBqfJQSmEmrGVzxGQvKdnCuaV1PaHRiFPiLmoJHlB
         nLAsSsUICGb2/wlqNuqilBKP1AAMB7tGtnP5A87UFMyXJhyV0yc/FDPm1TdcOrBcU1UB
         nKFQIlT0Msm602C+LY9kSKx+EAyoxjlRHZyMz5p96ilyuho5Y9dfqEkP9JOXp70LRYwN
         I6BPIx8RpynNHiYnQe7xZZpKEwWAzQa8ciF77Y9JlAdXfiCTidg94a/tp9MQjDBGmO7t
         FLQwriP/4LiDBkTQ30i1Vtk4GUpPSHWiRWT4RMyAIFwU4d0VEpnuZumcjG5mo8cIgAfv
         8mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4vTYenFphaCWHVzAvclsMi2fnddGobkpzyazzxh8vl0=;
        b=YKm3DUoyZdfLgLQtv74F+Dx5yQp54QlVDvxP+Wcf2n25shEr0eAvwNJAd+6hS5yVeP
         kpV7HSpWHuUfBqGjZudNNCOu5MkI4EOGuJO9xIsb8+vtdaRPDt1Ed0sSMjwzh2/HtYEn
         NrpYc8hKTydckB9PfnCX1kum0pBAW2DrEgwhxzk3xNYk0H/IJk1ZyCuZqneAuYVkfoEw
         5/UgK4oyx7p4At9/izRrmAUWvIDK01IpBQNcRJ5GNGBctIe66UtdAiYNpLEi6iP0jVC+
         1II9zPMO505M81s21BkU+cVRrZIajTmRwHgn/ri9sGsJAkijJ3db3sR0/+KZLhMw0TMC
         rcXQ==
X-Gm-Message-State: AOAM530S7BDyyT4l5CdGOzQcB3EhLZPDcz09uPVrWVFYAlElhW8+0JGw
        yJSC2dRCCHxLJ0cOnjbQR8hApG35kbs=
X-Google-Smtp-Source: ABdhPJwgikLNVwfhmnGz/LroS2B5Q1vSergnV51BEyNIZpFLCl+NdhRs4HuaXhmck45UgK5cZmbEmw==
X-Received: by 2002:a05:620a:147a:: with SMTP id j26mr68491qkl.190.1609860584365;
        Tue, 05 Jan 2021 07:29:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r10sm26130qtw.66.2021.01.05.07.29.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:29:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FTebv020811
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:29:41 GMT
Subject: [PATCH v1 00/42] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:29:40 -0500
Message-ID: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The long-term purpose is to convert the NFSD XDR encoder and decoder
functions to use the struct xdr_stream API. This is a refactor and
clean-up with few or no changes in behavior expected, but there are
some long-term benefits:

- More robust input sanitization in the NFSD decoders.
- Help make it possible to use common kernel library functions with
  XDR stream APIs (for example, GSS-API).
- Align the structure of the source code with the RFCs so it is
  easier to learn, verify, and maintain our XDR implementation.
- Removal of more than a hundred hidden dprintk() call sites.
- Removal of as much explicit manipulation of pages as possible to
  help make the eventual transition to xdr->bvecs smoother.

The current series focuses on NFSv2 and NFSv3 decoder changes. Please
review and comment!

The full set of patches lives in a topic branch in my git repo:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-xdr_stream


---

Chuck Lever (42):
      SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
      SUNRPC: Display RPC procedure names instead of proc numbers
      SUNRPC: Move definition of XDR_UNIT
      NFSD: Update GETATTR3args decoder to use struct xdr_stream
      NFSD: Update ACCESS3arg decoder to use struct xdr_stream
      NFSD: Update READ3arg decoder to use struct xdr_stream
      NFSD: Update WRITE3arg decoder to use struct xdr_stream
      NFSD: Update READLINK3arg decoder to use struct xdr_stream
      NFSD: Fix returned READDIR offset cookie
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update READDIR3args decoders to use struct xdr_stream
      NFSD: Update COMMIT3arg decoder to use struct xdr_stream
      NFSD: Update the NFSv3 DIROPargs decoder to use struct xdr_stream
      NFSD: Update the RENAME3args decoder to use struct xdr_stream
      NFSD: Update the LINK3args decoder to use struct xdr_stream
      NFSD: Update the SETATTR3args decoder to use struct xdr_stream
      NFSD: Update the CREATE3args decoder to use struct xdr_stream
      NFSD: Update the MKDIR3args decoder to use struct xdr_stream
      NFSD: Update the SYMLINK3args decoder to use struct xdr_stream
      NFSD: Update the MKNOD3args decoder to use struct xdr_stream
      NFSD: Update the NFSv2 GETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 READ argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 WRITE argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 READLINK argument decoder to use struct xdr_stream
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update the NFSv2 READDIR argument decoder to use struct xdr_stream
      NFSD: Update NFSv2 diropargs decoding to use struct xdr_stream
      NFSD: Update the NFSv2 RENAME argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 LINK argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 CREATE argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SYMLINK argument decoder to use struct xdr_stream
      NFSD: Remove argument length checking in nfsd_dispatch()
      NFSD: Update the NFSv2 GETACL argument decoder to use struct xdr_stream
      NFSD: Add an xdr_stream-based decoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL GETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL ACCESS argument decoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv2 ACL decoders
      NFSD: Update the NFSv3 GETACL argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv3 ACL decoders


 fs/nfs_common/nfsacl.c          |  52 +++
 fs/nfsd/nfs2acl.c               |  62 ++--
 fs/nfsd/nfs3acl.c               |  42 ++-
 fs/nfsd/nfs3proc.c              |  71 +++--
 fs/nfsd/nfs3xdr.c               | 538 ++++++++++++++++++--------------
 fs/nfsd/nfsproc.c               |  74 +++--
 fs/nfsd/nfssvc.c                |  34 --
 fs/nfsd/nfsxdr.c                | 350 ++++++++++-----------
 fs/nfsd/xdr.h                   |  12 +-
 fs/nfsd/xdr3.h                  |  20 +-
 include/linux/nfsacl.h          |   3 +
 include/linux/sunrpc/msg_prot.h |   3 -
 include/linux/sunrpc/xdr.h      |  13 +-
 include/trace/events/sunrpc.h   |  15 +-
 include/uapi/linux/nfs3.h       |   6 +
 15 files changed, 680 insertions(+), 615 deletions(-)

--
Chuck Lever

