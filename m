Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42A26CE86
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIPWSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIPWR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:17:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7FC0611BE
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:15 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so10022392iow.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FRUCK8+VSOPO6v3rP+tHADwYHg0GplTMh5VZHAVEQwc=;
        b=W2e3QLc4h7yu/fkSnByvYthNTJpfSNkUVY/ZrqlMVbZDBvXvH8SJbrf02E9MFTORSH
         tpajDnJ5zpWQJJwvfG2TX/eiib7CvxuGdWzqHTTWcNm8UcBqots2pYfTW8Be9LF3NEce
         XFgzKgf4dWFohJM+gR2bnYsmnVo1X67l1PLQYKgkoSKQWxZPId426bPFYm7h5W36YvK5
         efLm1nlcHY0TAVR0/Ol/lvANbRz4NWgU5yXgh73mPtinuD2mHsilJ/VXSKzSkIxtj7ZH
         S516yCI+UEKCNYirRcdOZiK18U/6hD6bREf7sgWR7z7CGdzfUpwxxQuJeSfzkQ3KhZmj
         6WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FRUCK8+VSOPO6v3rP+tHADwYHg0GplTMh5VZHAVEQwc=;
        b=NQaSjYex51VjimNdlB9cqsBOJiG/JAUlvDH9F7OU7fUx+lxpeTFmCSN3+QhU/kJOrI
         aYI8XpCwJshyFfwawFqPD5dYhiO0yiLZNrpdl2Mi7x7hePQEfCi0oEHLSunnGt4u13St
         Pg5lOu8qVpgGXV4jzdzin+H+Dxkwb1EOpxsG3y5fgoxWSM/z2h1/wXyytmaNZx++k3Ho
         HdyHRPhtLoAn3wABylk/iMPyWYgS447NNi9zT88NVXqt0A/d6CRXSKwlnQeLG7d+NcLR
         mk4DTGgh5YE6UCYgvnthsZqIf5EQw4ajOcePOecWKmBJt8XKYa0NRtfnxvVQZddDaPCm
         Q6nA==
X-Gm-Message-State: AOAM5335RaFqrRewwgLDURqcClm1t/S+TKdE9965fAYa8wqjiCGhD+eS
        m9vlmuFANppDtvfdZ3hdrPE=
X-Google-Smtp-Source: ABdhPJxpANtVRSmR85mGm5jVVRgD2STj4Bx0ecXU3p+TEXnfxxw0iQcu3ZBhrq7J4yLmlA5VlBL4pQ==
X-Received: by 2002:a02:7b0d:: with SMTP id q13mr24963412jac.7.1600292534990;
        Wed, 16 Sep 2020 14:42:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k16sm11103720ilc.38.2020.09.16.14.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:14 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgC07022978;
        Wed, 16 Sep 2020 21:42:12 GMT
Subject: [PATCH RFC 00/21] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:12 -0400
Message-ID: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

As I've been working on various server bugs, I've been adding
tracepoints that record NFS operation arguments. Here's a snapshot
of this work for your review and comment.

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

I've also pushed these patches into a topic branch:

git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-more-tracepoints

There is probably more work to be done. For example, one thing I'd
like to do is move client-side helpers (like the macro to display
NFS4ERR status codes symbolically) into an include file that can be
shared with server tracepoints.


---

Chuck Lever (21):
      NFSD: Add SPDK header for fs/nfsd/trace.c
      SUNRPC: Move the svc_xdr_recvfrom() tracepoint
      SUNRPC: Add svc_xdr_authenticate tracepoint
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
      NFSD: Add CLOSE tracepoint
      NFSD: Add a tracepoint for DELEGRETURN
      NFSD: Add a lookup tracepoint
      NFSD: Add lock and locku tracepoints
      NFSD: Add tracepoints to record the result of TEST_STATEID and FREE_STATEID
      NFSD: Rename nfsd_ tracepoints to nfsd4_


 fs/nfsd/nfs3proc.c            |    3 +
 fs/nfsd/nfs4callback.c        |   28 +-
 fs/nfsd/nfs4layouts.c         |   16 +-
 fs/nfsd/nfs4proc.c            |   39 +-
 fs/nfsd/nfs4state.c           |  103 ++--
 fs/nfsd/nfsfh.h               |    7 +-
 fs/nfsd/nfsproc.c             |    3 +
 fs/nfsd/trace.c               |    2 +
 fs/nfsd/trace.h               | 1083 +++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.c                 |   21 +-
 include/trace/events/sunrpc.h |   25 +-
 net/sunrpc/svc_xprt.c         |    4 +-
 net/sunrpc/svcauth.c          |    5 +-
 13 files changed, 1151 insertions(+), 188 deletions(-)

--
Chuck Lever

