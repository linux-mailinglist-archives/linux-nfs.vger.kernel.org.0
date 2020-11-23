Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75CC2C1510
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgKWUED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWUEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:02 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D55C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:02 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so14301448qte.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NADEDo/1KQ/3Z+4BxtA8R2wX2IJfu0m8WWSLKiBDMck=;
        b=UfJOjnEKFwtz0oDVL4JlN+UDjqBOKV+3ACO7e+SjVUW5sgEEwMdIhsDPsLZEyA10+t
         p8vw9DPizMJHZ9hLOuYRbu2DWrPsdrB/Z9Un4wV7WHqGtAG2XsN7eWA2VVRKPmENeo/f
         ooeak5MV6at4LKqLSsoxOHj49QhM00uyn8lrscdLUcC5De1O6ucVheE2Prxnaempuyz8
         icM2BGmoDSzHrRBdgl95vtSv1sB9coBp8ORZc7qCMWLrtgyb7RxtKSdf7ECsQlPb+3Ot
         xS5Tdpxd8cMM40ACJrCCtALBCDePfRpcrcQQ7SSaUISwDzFv/jE8+UiRvmGMhBRh40Od
         d4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NADEDo/1KQ/3Z+4BxtA8R2wX2IJfu0m8WWSLKiBDMck=;
        b=jWTGTcWymZCgJf8KbAjrGvvvXCeg92WRaa198Sb/eLFC2K6FTSkDhIC2CgZhab38rA
         BvK/h257rliYiTySFZi3LCFAz8SrDCJxmHBDHgKnIetI0OSNcFHsXSQSWNGHkMl36w9p
         dBhijQ445RGi/KRKImflV8ouz7UGVMdDRWRBWkzZRAK7mh4PunkwgV4mOBGZSQ9uN3Jj
         t3pzzBzfM0Cw7PiLrM1/nTZHryiSF/+7/YiqRH8s+HGhT2o1bVPS9tZ7sE20t01Atvt5
         1NS5+Zg9WtO+AexY/fBwXH3wfykx5FbGqyxN5YenpyBPDcu63P9whOuYRwb54+ZVnpKr
         n3CA==
X-Gm-Message-State: AOAM531LkocPFFpDn8IvAWWr9qrcHZ0nN794JA5ucigZ9gzkcpDUei1k
        y9V5j7O0uPJ7aogkCtO3Sps97QrWx6Y=
X-Google-Smtp-Source: ABdhPJx9uBOfrCiM0/R3Zsu22pcZrqPYhP0mTwR4ShLCNMjHG8UMl8OHt6EvsKxyZNDoOZs+QlenJg==
X-Received: by 2002:aed:204c:: with SMTP id 70mr867062qta.92.1606161841405;
        Mon, 23 Nov 2020 12:04:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a13sm6440161qtj.69.2020.11.23.12.04.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK3wfZ010266
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:03:59 GMT
Subject: [PATCH v3 00/85] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:03:58 -0500
Message-ID: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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

The current series focuses on NFSv4 decoder changes only. To
simplify things, I've postponed the NFSv2 and NFSv3 changes until
the NFSv4 work has been merged.

The full set of ready patches lives in a topic branch in my git
repo:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-xdr_stream


Changes since v2:
- Rebase on v5.10-rc5
- Add tracepoints to capture NFSD decoding and encoding errors
- Revert the use of xdr_stream_decode_uint32_array()
- Fix a bug in xdr_stream_subsegment()
- Drop most of the NFSv2 and NFSv3 related patches
- Drop the use of XDR_DECODE_DONE/FAILED

Changes since v1:
- Broke up larger patches (fattr4, LOCK, OPEN, EXCHANGE_ID, and so on)
- Replaced goto spaghetti in new decoders
- Cleaned up function synopses
- Replaced nfsd4_decode_bitmap() with generic XDR helper
- The posted series now contains changes to NFSv2 and NFSv3 decoders

---

Chuck Lever (85):
      SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
      SUNRPC: Prepare for xdr_stream-style decoding on the server-side
      NFSD: Add common helpers to decode void args and encode void results
      NFSD: Add tracepoints in nfsd_dispatch()
      NFSD: Add tracepoints in
      NFSD: Replace the internals of the READ_BUF() macro
      NFSD: Replace READ* macros in nfsd4_decode_access()
      NFSD: Replace READ* macros in nfsd4_decode_close()
      NFSD: Replace READ* macros in nfsd4_decode_commit()
      NFSD: Change the way the expected length of a fattr4 is checked
      NFSD: Replace READ* macros that decode the fattr4 size attribute
      NFSD: Replace READ* macros that decode the fattr4 acl attribute
      NFSD: Replace READ* macros that decode the fattr4 mode attribute
      NFSD: Replace READ* macros that decode the fattr4 owner attribute
      NFSD: Replace READ* macros that decode the fattr4 owner_group attribute
      NFSD: Replace READ* macros that decode the fattr4 time_set attributes
      NFSD: Replace READ* macros that decode the fattr4 security label attribute
      NFSD: Replace READ* macros that decode the fattr4 umask attribute
      NFSD: Replace READ* macros in nfsd4_decode_fattr()
      NFSD: Replace READ* macros in nfsd4_decode_create()
      NFSD: Replace READ* macros in nfsd4_decode_delegreturn()
      NFSD: Replace READ* macros in nfsd4_decode_getattr()
      NFSD: Replace READ* macros in nfsd4_decode_link()
      NFSD: Relocate nfsd4_decode_opaque()
      NFSD: Add helpers to decode a clientid4 and an NFSv4 state owner
      NFSD: Add helper for decoding locker4
      NFSD: Replace READ* macros in nfsd4_decode_lock()
      NFSD: Replace READ* macros in nfsd4_decode_lockt()
      NFSD: Replace READ* macros in nfsd4_decode_locku()
      NFSD: Replace READ* macros in nfsd4_decode_lookup()
      NFSD: Add helper to decode NFSv4 verifiers
      NFSD: Add helper to decode OPEN's createhow4 argument
      NFSD: Add helper to decode OPEN's openflag4 argument
      NFSD: Replace READ* macros in nfsd4_decode_share_access()
      NFSD: Replace READ* macros in nfsd4_decode_share_deny()
      NFSD: Add helper to decode OPEN's open_claim4 argument
      NFSD: Replace READ* macros in nfsd4_decode_open()
      NFSD: Replace READ* macros in nfsd4_decode_open_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_open_downgrade()
      NFSD: Replace READ* macros in nfsd4_decode_putfh()
      NFSD: Replace READ* macros in nfsd4_decode_read()
      NFSD: Replace READ* macros in nfsd4_decode_readdir()
      NFSD: Replace READ* macros in nfsd4_decode_remove()
      NFSD: Replace READ* macros in nfsd4_decode_rename()
      NFSD: Replace READ* macros in nfsd4_decode_renew()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo()
      NFSD: Replace READ* macros in nfsd4_decode_setattr()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_verify()
      NFSD: Replace READ* macros in nfsd4_decode_write()
      NFSD: Replace READ* macros in nfsd4_decode_release_lockowner()
      NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
      NFSD: Replace READ* macros in nfsd4_decode_backchannel_ctl()
      NFSD: Replace READ* macros in nfsd4_decode_bind_conn_to_session()
      NFSD: Add a separate decoder to handle state_protect_ops
      NFSD: Add a separate decoder for ssv_sp_parms
      NFSD: Add a helper to decode state_protect4_a
      NFSD: Add a helper to decode nfs_impl_id4
      NFSD: Add a helper to decode channel_attrs4
      NFSD: Replace READ* macros in nfsd4_decode_create_session()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_session()
      NFSD: Replace READ* macros in nfsd4_decode_free_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_getdeviceinfo()
      NFSD: Replace READ* macros in nfsd4_decode_layoutcommit()
      NFSD: Replace READ* macros in nfsd4_decode_layoutget()
      NFSD: Replace READ* macros in nfsd4_decode_layoutreturn()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo_no_name()
      NFSD: Replace READ* macros in nfsd4_decode_sequence()
      NFSD: Replace READ* macros in nfsd4_decode_test_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_clientid()
      NFSD: Replace READ* macros in nfsd4_decode_reclaim_complete()
      NFSD: Replace READ* macros in nfsd4_decode_fallocate()
      NFSD: Replace READ* macros in nfsd4_decode_nl4_server()
      NFSD: Replace READ* macros in nfsd4_decode_copy()
      NFSD: Replace READ* macros in nfsd4_decode_copy_notify()
      NFSD: Replace READ* macros in nfsd4_decode_offload_status()
      NFSD: Replace READ* macros in nfsd4_decode_seek()
      NFSD: Replace READ* macros in nfsd4_decode_clone()
      NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
      NFSD: Replace READ* macros in nfsd4_decode_setxattr()
      NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
      NFSD: Make nfsd4_ops::opnum a u32
      NFSD: Replace READ* macros in nfsd4_decode_compound()
      NFSD: Remove macros that are no longer used


 fs/nfsd/nfs2acl.c          |   21 +-
 fs/nfsd/nfs3acl.c          |    8 +-
 fs/nfsd/nfs3proc.c         |   10 +-
 fs/nfsd/nfs3xdr.c          |   11 -
 fs/nfsd/nfs4proc.c         |   25 +-
 fs/nfsd/nfs4state.c        |    2 +-
 fs/nfsd/nfs4xdr.c          | 2531 +++++++++++++++++++-----------------
 fs/nfsd/nfsd.h             |    8 +
 fs/nfsd/nfsproc.c          |   25 +-
 fs/nfsd/nfssvc.c           |   47 +-
 fs/nfsd/nfsxdr.c           |   10 -
 fs/nfsd/trace.h            |  128 ++
 fs/nfsd/xdr.h              |    2 -
 fs/nfsd/xdr3.h             |    2 -
 fs/nfsd/xdr4.h             |   30 +-
 include/linux/sunrpc/svc.h |   16 +
 include/linux/sunrpc/xdr.h |   44 +
 net/sunrpc/svc.c           |    5 +
 net/sunrpc/xdr.c           |   45 +
 19 files changed, 1643 insertions(+), 1327 deletions(-)

--
Chuck Lever

