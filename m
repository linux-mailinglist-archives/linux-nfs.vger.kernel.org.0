Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7A280A99
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgJAW6v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW6v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:58:51 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AFCC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:58:50 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b13so331533qvl.2
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B/HwiNgbMASB6G5VRMlzLIKr11gXw6B1Vn9x0Ag1K4w=;
        b=IqEoUHruqXMXYgBMwGllSpQybpmFrSYpJAPpth8my9oNFT3HK4SqkNWBhj1M0TnQDx
         vReIVZhgi+gBE7/slllagJeEoZ/WTHNz/UWz4FZMISU1EhiC4It0/AhUB8lHZDfy/Mx+
         fZPA8W9DayQxwK8Y3rZFfKrjok5sX+vhyqcNy7utOrkttUqfn3A3y5XEbUfaaf4FSvaz
         ZjxII8zEKMtdveTi5rKFuCNGQ0X/bjGa+0fiUtta2j+C7LAYYUBnbg3aW3JYmPAYNrWo
         tDHLZQtcxAWzUIjwiq9butMqpD4soA64uguyJBxHfXjq9J4/3jqhbIggwnFroBWYTUgY
         YNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B/HwiNgbMASB6G5VRMlzLIKr11gXw6B1Vn9x0Ag1K4w=;
        b=RUjyB+cWxM+q9Fw/oRND/ozrXuCQYmdnkpd28Mbtfhu5K+haXox+Tt5taKY0sdR9Nx
         8RXHG4c4zDz5KoTb/SyZY+MtcIelI+vwBIPz8+/tdnGEYSt46tywJw01LPBHc3q1Uq3t
         WZP1fW75/+WPKcmjrvVmiMG2dgvv00sAmMdFWV0+H5vS64cWXPe7H+uZvxfiuYGVuM1o
         KqTZ5PGlKjFhhnOuHjPIueyq8rDorKOA694ZqRPPLEwzTuwqU7HbQyzet46gmdflNf2C
         DGxKMLalY0Nj1daEV7mx6qWRSvJ55SSJA7vsoCgzUohSOR77W5i7wpdCGuJqK3OrALJX
         4wkA==
X-Gm-Message-State: AOAM531iOQi7tkvdwncmS/mYyl1QNVHVtUm2AebFxeVc04Itg8uMg/PF
        iMv7ztAksHvIqlqUK2ZWjUwbqQ0RbiYIFg==
X-Google-Smtp-Source: ABdhPJwvnDnJ0Qs/quCBzzGhaWd2r/A4JL3eXn3yI/xyx+iZDKMq5jfsnoY7cgp98pulFMVkJyPHtA==
X-Received: by 2002:ad4:5745:: with SMTP id q5mr10381456qvx.29.1601593128837;
        Thu, 01 Oct 2020 15:58:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t43sm8698387qtc.54.2020.10.01.15.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:58:47 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091Mwkpr032561;
        Thu, 1 Oct 2020 22:58:46 GMT
Subject: [PATCH v3 00/15] nfsd_dispatch() clean up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:58:46 -0400
Message-ID: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Here's the latest version of the nfsd_dispatch clean up series,
building on the "non-controversial" patches I posted last week.

The purpose of this series is three-fold:

o Prepare to add NFS procedure tracepoints
o Prepare to eventually deprecate NFSv2
o Minor optimizations of the dispatcher hot path


Changes since v2:
- Fixed crasher caused by invoking NFSv2 ROOT or WRITECACHE
- Hoisted encoding of NFS status code into XDR Reply encoders
- Numerous bug fixes, clean ups, and patch re-ordering

Changes since v1:
- Pulled in latest version of rq_lease_breaker cleanup
- Added patches to make NFSv2 error encoding similar to NFSv3
- Clarified nfsd_dispatch's new documenting comment
- Renamed a variable

---

Chuck Lever (14):
      NFSD: Add missing NFSv2 .pc_func methods
      lockd: Replace PROC() macro with open code
      NFSACL: Replace PROC() macro with open code
      NFSD: Encoder and decoder functions are always present
      NFSD: Clean up switch statement in nfsd_dispatch()
      NFSD: Clean up stale comments in nfsd_dispatch()
      NFSD: Clean up nfsd_dispatch() variables
      NFSD: Refactor nfsd_dispatch() error paths
      NFSD: Remove vestigial typedefs
      NFSD: Fix .pc_release method for NFSv2
      NFSD: Call NFSv2 encoders on error returns
      NFSD: Remove the RETURN_STATUS() macro
      NFSD: Map nfserr_wrongsec outside of nfsd_dispatch
      NFSD: Hoist status code encoding into XDR encoder functions

J. Bruce Fields (1):
      nfsd: rq_lease_breaker cleanup


 fs/lockd/svc4proc.c         | 248 ++++++++++++++++++++++++-------
 fs/lockd/svcproc.c          | 250 ++++++++++++++++++++++++-------
 fs/nfsd/export.c            |   2 +-
 fs/nfsd/nfs2acl.c           | 160 +++++++++++++-------
 fs/nfsd/nfs3acl.c           |  88 ++++++-----
 fs/nfsd/nfs3proc.c          | 238 +++++++++++++++---------------
 fs/nfsd/nfs3xdr.c           |  25 +++-
 fs/nfsd/nfs4proc.c          |   6 +-
 fs/nfsd/nfs4xdr.c           |  11 +-
 fs/nfsd/nfsproc.c           | 283 ++++++++++++++++++++----------------
 fs/nfsd/nfssvc.c            | 121 ++++++++-------
 fs/nfsd/nfsxdr.c            |  52 ++++++-
 fs/nfsd/xdr.h               |  16 +-
 fs/nfsd/xdr3.h              |   1 +
 fs/nfsd/xdr4.h              |   1 +
 include/uapi/linux/nfsacl.h |   2 +
 16 files changed, 984 insertions(+), 520 deletions(-)

--
Chuck Lever

