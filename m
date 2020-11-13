Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB962B1DEE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMPC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:02:28 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CFC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:28 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so3243110qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bMdKyhwST47iycnDiTZv9uHNBtqhHYdAfMQUTHDjup4=;
        b=ltiK+8VEGzeXdR4NI+nBviXnBEyWqSNsqP7l5z3mz3WrNnPaj8sKMy9Z2aCsrI39bT
         8xHu3/r+1HCXsOx4+KU5mq+9qcBk0gQY4ZGixBRWWfRjVD8UncS7+JTjkprRpVMfmH+k
         +0oxjuLbLHDSCVdKIe8iACzfncfGDNy67KEeJfYJNKKFzldEFh/zYuTTUrxW2XMVpPBx
         fW40qGoCHkyv6RZ7IHsImAz9clcy79aRnur4H8hYFPig3hj54n0kCQW0F2ClVkGmKAv+
         Dp0fKdHnG3AmMDLCBGiEjwRIOx1bBCQgGixJwJds5nEaDr5NFUuXMHq57HNbaiZPeeLW
         0Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bMdKyhwST47iycnDiTZv9uHNBtqhHYdAfMQUTHDjup4=;
        b=loeNS4NQvcLWR27CPz4sGggXg2YfEt78D3Pj4hfXBYEJTK6uoOkRMok6nkkpWW9uUh
         DkVqWlgoGuHforuOEkcdY7EYCijqRuO9Ty4ffCPlvfw+Apg7iEIi0gygIrZ3by8tYyhR
         4KGwXayB2R8pARE8cRiDnjWwCYalpSUFYgjQPebsA9Z+RCzjSbz5UiuvCmRO1Mnqt45c
         /L/DNp54oSax02iqGD7Xk2J1f0bw5HqRdAAnWJlQYfttsq0w9Cp88ybatsIVKKUUNNBi
         q61G5bFxieo0v18oLwTD8vh/zi89SO2hcVlq4h5gXpAOzxlHybsC0JApypLehLpzGFBP
         wsaw==
X-Gm-Message-State: AOAM532spm/u7knJvx1wS0ffkTc83ULXrzH/B4khJVTaew+A22KHYPjS
        YzxWSzZ1BBToFx99imA3dFvriA0OG8Y=
X-Google-Smtp-Source: ABdhPJzOKCiv9AJsD/yeAhguV0zIGeuT6FJR2UnssryFslZgsnS897N+Hw5cBAT+1sh50fZhw1fd6g==
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr2332011qti.34.1605279746486;
        Fri, 13 Nov 2020 07:02:26 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z16sm7343999qka.18.2020.11.13.07.02.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:25 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2N6H032637
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:23 GMT
Subject: [PATCH v1 00/61] Update NFSD XDR functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:23 -0500
Message-ID: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The purpose of this series is to convert the NFSD XDR encoder and
decoder functions to use the struct xdr_stream API. This is largely
a refactor/clean-up, but there are some long-term benefits:

- More robust input sanitization in the NFSD decoders
- Ability to use common kernel library functions with XDR stream
  APIs: for example GSS-API
- Align the code itself with the RFCs so it is easier to learn,
  understand, and verify our XDR implementation
- Removal of as much explicit manipulation of pages as possible to
  help make the transition to xdr->bvecs smoother

With this initial posting, I'm starting with just the NFSv4 decoder 
face lift to make it easier to review. However, these posted patches
and more are available in a topic branch in my git repo:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-xdr_stream

---

Chuck Lever (61):
      NFSD: Fix returned READDIR offset cookie
      SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
      SUNRPC: Prepare for xdr_stream-style decoding on the server-side
      NFSD: Add common helpers to decode void args and encode void results
      NFSD: Replace the internals of the READ_BUF() macro
      NFSD: Replace READ* macros in nfsd4_decode_access()
      NFSD: Replace READ* macros in nfsd4_decode_close()
      NFSD: Replace READ* macros in nfsd4_decode_commit()
      NFSD: Replace READ* macros in nfsd4_decode_create()
      NFSD: Replace READ* macros in nfsd4_decode_bitmap()
      NFSD: Replace READ* macros in nfsd4_decode_link()
      NFSD: Relocate nfsd4_decode_opaque()
      NFSD: Replace READ* macros in nfsd4_decode_lock()
      NFSD: Replace READ* macros in nfsd4_decode_lockt()
      NFSD: Replace READ* macros in nfsd4_decode_locku()
      NFSD: Replace READ* macros in nfsd4_decode_lookup()
      NFSD: Replace READ* macros in nfsd4_decode_time()
      NFSD: Replace READ* macros in nfsd4_decode_fattr()
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
      NFSD: Replace READ* macros in nfsd4_decode_exchange_id()
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
      NFSD: Replace READ* macros in nfsd4_decode_copy()
      NFSD: Replace READ* macros in nfsd4_decode_seek()
      NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
      NFSD: Replace READ* macros in nfsd4_decode_setxattr()
      NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
      NFSD: Replace READ* macros in nfsd4_decode_compound()
      NFSD: Remove macros that are no longer used


 fs/nfs/blocklayout/blocklayout.c          |    2 +-
 fs/nfs/blocklayout/dev.c                  |    2 +-
 fs/nfs/dir.c                              |    2 +-
 fs/nfs/filelayout/filelayout.c            |    2 +-
 fs/nfs/filelayout/filelayoutdev.c         |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |    2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +-
 fs/nfs/nfs42xdr.c                         |    2 +-
 fs/nfs/nfs4xdr.c                          |    6 +-
 fs/nfsd/nfs2acl.c                         |   21 +-
 fs/nfsd/nfs3acl.c                         |    8 +-
 fs/nfsd/nfs3proc.c                        |   10 +-
 fs/nfsd/nfs3xdr.c                         |   11 -
 fs/nfsd/nfs4proc.c                        |   24 +-
 fs/nfsd/nfs4state.c                       |    2 +-
 fs/nfsd/nfs4xdr.c                         | 2253 +++++++++++----------
 fs/nfsd/nfsd.h                            |    8 +
 fs/nfsd/nfsproc.c                         |   25 +-
 fs/nfsd/nfssvc.c                          |   27 +-
 fs/nfsd/nfsxdr.c                          |   10 -
 fs/nfsd/xdr.h                             |    2 -
 fs/nfsd/xdr3.h                            |    2 -
 fs/nfsd/xdr4.h                            |   28 +-
 include/linux/sunrpc/svc.h                |   16 +
 include/linux/sunrpc/xdr.h                |   71 +-
 include/uapi/linux/nfs4.h                 |    1 +
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |    2 +-
 net/sunrpc/svc.c                          |    5 +
 net/sunrpc/xdr.c                          |   72 +-
 29 files changed, 1451 insertions(+), 1169 deletions(-)

--
Chuck Lever

