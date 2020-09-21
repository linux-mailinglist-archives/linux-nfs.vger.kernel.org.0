Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE8273189
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUSKy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:10:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6220C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:10:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j2so16433773ioj.7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YeKnEHw5nIXsc+mJ8DJLKDuTXCMcWysUVZB9KgJ7XHs=;
        b=NZ4xaUP2SjFhPz9CJpROlZ7IwgtEakAQVIKuDFmhMloZ2iI0WvpOmJWDomNf6AI2bK
         mV/zUNmSblQI6wSp9sNqaCDsDq7htpILU5pV8ya0xeSAG6bkHDxIwEBOtuH9tHTPtGFI
         2VtIhpz2IVXM5oY5C/B+slPYMVJKh3jyKJtq6qp7eJcVlfdd0Wamw6xURKk0Uo0cYm1T
         3rqL8WnQODBh5C5RKRhOXVPjiO4ZK3p4BtjkHgQhigm78M9FpskwoVwpJJvYEVb8r481
         RfZLDIQ6lUg4uyONtcfBa1bnfsZ41vxkC7YihjM3j8anuLpjglULLnq4WocsRRKHRTFk
         BUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YeKnEHw5nIXsc+mJ8DJLKDuTXCMcWysUVZB9KgJ7XHs=;
        b=tQTiiy4NPLnyE9J9/NcI3WkKPO0O/6cik//mT6XlqpPucSZzAz0fgX31ZZocUIxePk
         hS0MywVEHZMGORozH4jzTyyVITVHkFSPgJNX5QV4Rlgba3FdOYBZLfx2XhSJRXRLCjEZ
         vzIU/GKTBL61y+7fRRj5U2+jg4vYsWfxc5u+T1AHfmPlLQSYcUs6nQ2Zq92PtkKDmXGU
         EexkTCGDZV8LdGB3GuyNL/LP+BbFgw9KFl8RkR/fJuTB1fLWABGyEBapgvB3RGlUYsnX
         WCg5TFT1mn3I5dwQ44rJVHW25GYCVYdMPn+Bz9Rqm9+sbOnFQwnNyAqRuhkjDjwxtl76
         Dz6w==
X-Gm-Message-State: AOAM532B5xLXBKP0NMXJmwOsFJKHDlZA6SUYF+FDuN9PmWmWy3vT6Yb8
        s5FvYbKVASzm/NlKSKT+Y9E=
X-Google-Smtp-Source: ABdhPJywi59Gl58RBLtksj9ORMbSVVtkiff6/GbbuIc+6SgiVJJ9jXGg44FC3TLMNooAlp+8e/ROxA==
X-Received: by 2002:a5d:80c6:: with SMTP id h6mr533078ior.2.1600711853020;
        Mon, 21 Sep 2020 11:10:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c18sm4274534ild.35.2020.09.21.11.10.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:10:52 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIAneM003842;
        Mon, 21 Sep 2020 18:10:49 GMT
Subject: [PATCH v2 00/27] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:10:49 -0400
Message-ID: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

As I've been working on various server bugs, I've been adding
tracepoints that record NFS operation arguments. Here's an updated
snapshot of this work for your review and comment.

The idea here is to provide a degree of NFS traffic observability
without needing network capture. Tracepoints are generally lighter-
weight than full network capture, allowing effective capture-time
data reduction:

- One or a handful of these can be enabled at a time
- Each tracepoint records much less data per operation than capture
- Extra capture-time filtering can reduce data amount even further
- Some of these operations are infrequent enough that their
 tracepoint could be enabled persistently without a significant
 performance impact (for example, for security auditing)

The topic branch has been updated as well:

git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-more-tracepoints


Changes since RFC:
* s/SPDK/SPDX and corrected the spelling of Christoph's surname
* Fixed a build error noticed by <lkp@intel.com>
* Introduced generic headers for VFS and NFS protocol display macros
* nfsd4_compoundstatus now displays NFS4ERR codes symbolically
* The svc_process tracepoint now displays the RPC procedure symbolically
* NFSD dispatcher now displays procedure names and status codes symbolically
* fh_verify tracepoint tentatively included; it adds a lot of noise, but perhaps not much value
* Cleaned up the remaining PROC() macros in the server code
* Removed trace_printk's that were introduced during the RFC series
* Removed redundant nfsd4_close tracepoint

---

Chuck Lever (27):
      NFS: Move generic FS show macros to global header
      NFS: Move NFS protocol display macros to global header
      NFSD: Add SPDX header for fs/nfsd/trace.c
      SUNRPC: Move the svc_xdr_recvfrom() tracepoint
      SUNRPC: Add svc_xdr_authenticate tracepoint
      lockd: Replace PROC() macro with open code
      NFSACL: Replace PROC() macro with open code
      SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
      NFSD: Clean up the show_nf_may macro
      NFSD: Remove extra "0x" in tracepoint format specifier
      NFSD: Constify @fh argument of knfsd_fh_hash()
      NFSD: Add tracepoint in nfsd_setattr()
      NFSD: Add tracepoint for nfsd_access()
      NFSD: nfsd_compound_status tracepoint should record XID
      NFSD: Add client ID lifetime tracepoints
      NFSD: Add tracepoints to report NFSv4 session state
      NFSD: Add a tracepoint to report the current filehandle
      NFSD: Add GETATTR tracepoint
      NFSD: Add tracepoint in nfsd4_stateid_preprocess()
      NFSD: Add tracepoint to report arguments to NFSv4 OPEN
      NFSD: Add a tracepoint for DELEGRETURN
      NFSD: Add a lookup tracepoint
      NFSD: Add lock and locku tracepoints
      NFSD: Add tracepoints to record the result of TEST_STATEID and FREE_STATEID
      NFSD: Rename nfsd_ tracepoints to nfsd4_
      NFSD: Add tracepoints in the NFS dispatcher
      NFSD: Replace dprintk callsites in fs/nfsd/nfsfh.c


 fs/lockd/svc4proc.c           | 263 +++++++++--
 fs/lockd/svcproc.c            | 265 +++++++++--
 fs/nfs/callback_xdr.c         |   2 +
 fs/nfs/nfs4trace.h            | 387 ++--------------
 fs/nfs/nfstrace.h             | 113 +----
 fs/nfs/pnfs.h                 |   4 -
 fs/nfsd/nfs2acl.c             |  79 +++-
 fs/nfsd/nfs3acl.c             |  54 ++-
 fs/nfsd/nfs3proc.c            |  25 +
 fs/nfsd/nfs4callback.c        |  28 +-
 fs/nfsd/nfs4layouts.c         |  16 +-
 fs/nfsd/nfs4proc.c            |  43 +-
 fs/nfsd/nfs4state.c           | 100 ++--
 fs/nfsd/nfsd.h                |   1 +
 fs/nfsd/nfsfh.c               |  36 +-
 fs/nfsd/nfsfh.h               |   7 +-
 fs/nfsd/nfsproc.c             |  21 +
 fs/nfsd/nfssvc.c              | 198 +++++---
 fs/nfsd/trace.c               |   1 +
 fs/nfsd/trace.h               | 844 ++++++++++++++++++++++++++++++----
 fs/nfsd/vfs.c                 |  18 +-
 fs/nfsd/xdr4.h                |   3 +-
 include/linux/nfs4.h          |   4 +
 include/linux/sunrpc/svc.h    |   1 +
 include/trace/events/fs.h     |  30 ++
 include/trace/events/nfs.h    | 511 ++++++++++++++++++++
 include/trace/events/sunrpc.h |  33 +-
 include/uapi/linux/nfsacl.h   |   2 +
 net/sunrpc/svc_xprt.c         |   4 +-
 net/sunrpc/svcauth.c          |   5 +-
 30 files changed, 2187 insertions(+), 911 deletions(-)
 create mode 100644 include/trace/events/nfs.h

--
Chuck Lever

