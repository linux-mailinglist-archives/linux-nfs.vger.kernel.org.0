Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854532BB712
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgKTUdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbgKTUdt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:33:49 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72998C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:49 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id a15so5314831qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uR5iAIfJ5gGi4i92SdYH3oXVk/Z2QnlVTsf3i8Lblnc=;
        b=H4f9f9T4xhZNGV+vYeRdOnzhqPmJBcsgJ0Vpou2RIMZe1V1nD3FF1EL5q5JYPpV1df
         Qt9FaUWhi6sZGnz2ySka4fRwLMhtcr16vGBORTcsvP3iWCz6fjvwv0lZcXxSJlCPH9Lj
         ALa6Y4FRUkgGt/bey0lRq7aIkBpN6xFbNKw/KabjO3gsrtAe0cwRqxUzZze6peFdD0fR
         BJkfBZ6sGgq9HZ58YO67jbn8HELx4sQwRCLKnfHEbPMJBWkdXd2UMg+kd+35X81DFMII
         PTJ9iEO7MNdY5+0WU/g95Q+EyzmmsUhj/L+F3Gi9NU66hNOs7ZQBuKx1InIVXPMtd3bJ
         5Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uR5iAIfJ5gGi4i92SdYH3oXVk/Z2QnlVTsf3i8Lblnc=;
        b=JgQnuKxyNfwgMTgfZish7iR1OIUteCCTI/SgXT+DIIzfxjI7JCzzAIaIL/G3ru0SmV
         T7SfEbr5YuD6kf5YbvcOupVjRDeF9RMDS8Vq9onwli/ZJP5GtY9vThyhzytSWbd1ZxCE
         +NYL2E8qjb1cL6DGM4HkmjsYxh/AGlpJ5Avb0Ek9tsotnj4wMz4MenAucyHYSX452Z1X
         zNYQc9k+rTWcNTd7getmQePN8lBQpcq4XWqThIcIzSSt7l0nJDIOuhMrTuaKQMZxnXj2
         oFSi9myTIGkJv+Zau1XljZ4ZWHyKWf4gu91Z6hZ9ZZE0LY7VIrP/t0qLum3nJmGinHU3
         1Trw==
X-Gm-Message-State: AOAM533qp0+jcyOqA3xO68C63/6BEV4fRK2KZuyPNoAKUBPb5McjTF0x
        Le2Nfd/rEH2Mj+18KPTUdMh08aoF1Xs=
X-Google-Smtp-Source: ABdhPJxh9KtgZcOUA872zLKp4Zb5uC8HWpJTqmLq4a0cy1J1hzHhr/qvcy50HObNq5vaGAfDawbVrw==
X-Received: by 2002:a0c:fe66:: with SMTP id b6mr8191086qvv.42.1605904428137;
        Fri, 20 Nov 2020 12:33:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j17sm2648887qtn.2.2020.11.20.12.33.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:33:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKXjMQ029202
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:33:46 GMT
Subject: [PATCH v2 000/118] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:33:45 -0500
Message-ID: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My apologies for piling on.

The purpose of this series is to convert the NFSD XDR encoder and
decoder functions to use the struct xdr_stream API. This is largely
a refactor/clean-up, but there are some long-term benefits:

- More robust input sanitization in the NFSD decoders
- Help make it possible to use common kernel library functions with
  XDR stream APIs (for example, GSS-API)
- Align the code itself with the RFCs so it is easier to learn,
  understand, and verify our XDR implementation
- Removal of more than a hundred hidden dprintk() call sites
- Removal of as much explicit manipulation of pages as possible to
  help make the transition to xdr->bvecs smoother

The series contains only decoder changes for the moment. I have
encoder changes for NFSv2 and NFSv3 in development. It makes sense
to put those off for a separate review/merge window cycle.

These patches are available in a topic branch in my git repo:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-xdr_stream


Changes since v1:
- Broke up larger patches (fattr4, LOCK, OPEN, EXCHANGE_ID, and so on)
- Replaced goto spaghetti in NFSv4 decoders
- Cleaned up function synopses
- Replaced nfsd4_decode_bitmap() with generic XDR helper
- The posted series now contains changes to NFSv2 and NFSv3 decoders

---

Chuck Lever (118):
      NFSD: Fix returned READDIR offset cookie
      SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
      SUNRPC: Prepare for xdr_stream-style decoding on the server-side
      NFSD: Add common helpers to decode void args and encode void results
      NFSD: Replace the internals of the READ_BUF() macro
      NFSD: Replace READ* macros in nfsd4_decode_access()
      NFSD: Replace READ* macros in nfsd4_decode_stateid()
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
      NFSD: Replace READ* macros in nfsd4_decode_clone()
      NFSD: Replace READ* macros in nfsd4_decode_nl4_server()
      NFSD: Replace READ* macros in nfsd4_decode_copy()
      NFSD: Replace READ* macros in nfsd4_decode_seek()
      NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
      NFSD: Replace READ* macros in nfsd4_decode_setxattr()
      NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
      NFSD: Replace READ* macros in nfsd4_decode_compound()
      NFSD: Remove macros that are no longer used
      NFSD: Update GETATTR3args decoder to use struct xdr_stream
      NFSD: Update ACCESS3arg decoder to use struct xdr_stream
      NFSD: Update READ3arg decoder to use struct xdr_stream
      NFSD: Update WRITE3arg decoder to use struct xdr_stream
      NFSD: Update READLINK3arg decoder to use struct xdr_stream
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


 fs/nfs/blocklayout/blocklayout.c          |    2 +-
 fs/nfs/blocklayout/dev.c                  |    2 +-
 fs/nfs/dir.c                              |    2 +-
 fs/nfs/filelayout/filelayout.c            |    2 +-
 fs/nfs/filelayout/filelayoutdev.c         |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |    2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +-
 fs/nfs/nfs42xdr.c                         |    2 +-
 fs/nfs/nfs4xdr.c                          |    6 +-
 fs/nfs_common/nfsacl.c                    |   53 +
 fs/nfsd/nfs2acl.c                         |   96 +-
 fs/nfsd/nfs3acl.c                         |   60 +-
 fs/nfsd/nfs3proc.c                        |   74 +-
 fs/nfsd/nfs3xdr.c                         |  588 ++---
 fs/nfsd/nfs4proc.c                        |   24 +-
 fs/nfsd/nfs4state.c                       |    2 +-
 fs/nfsd/nfs4xdr.c                         | 2419 +++++++++++----------
 fs/nfsd/nfsd.h                            |    8 +
 fs/nfsd/nfsproc.c                         |   99 +-
 fs/nfsd/nfssvc.c                          |   66 +-
 fs/nfsd/nfsxdr.c                          |  370 ++--
 fs/nfsd/xdr.h                             |   15 +-
 fs/nfsd/xdr3.h                            |   22 +-
 fs/nfsd/xdr4.h                            |   30 +-
 include/linux/nfsacl.h                    |    3 +
 include/linux/sunrpc/svc.h                |   16 +
 include/linux/sunrpc/xdr.h                |   93 +-
 include/uapi/linux/nfs3.h                 |    6 +
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |    2 +-
 net/sunrpc/svc.c                          |    5 +
 net/sunrpc/xdr.c                          |   72 +-
 31 files changed, 2184 insertions(+), 1961 deletions(-)

--
Chuck Lever

