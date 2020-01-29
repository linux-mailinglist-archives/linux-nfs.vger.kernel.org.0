Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D849E14CDF5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgA2QJX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:09:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38730 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:09:23 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so73421ywv.5
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QIEHDuYLdKvWAzp2TmHCvVsw2oPejC3jP9HcIjnFGOM=;
        b=rZJ+Rv7RFOUZhJi0tMt48KHhDCcTIAAwrIIudwDtH7mwXrbheAhMkc5cwG4KJffi7/
         43+BnurQEPTKNmJ/K4w/RHPrZO+9oCg3jk11DrXQdWB6tpx7IGhBYZN3C9bjULacUg/+
         OJAQeb3I/UPz7rcQyZXNRz39I9qz+J394ek1zGo/KZaUshRXrWKUM4a18nTZgjJVuk2u
         DNDamOTMud+Y2hAybnKvk7BteI5SFtaqJl1Jll2JJ4ASHrNZu3AhzwjTTWE69tOModuX
         vMcw49mL8cgJJ5wlkilDRHFTic6jfp0MBjkw2IkhenHJlwffLjK8mw8rJ55ls1W7btPK
         MIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QIEHDuYLdKvWAzp2TmHCvVsw2oPejC3jP9HcIjnFGOM=;
        b=kIpjtB6bI/Lt5L00Api5ofwqBQF8V0WQhMsJ5O/f6egGghkPw88I0S1cOnTEvc3LTC
         XgC9owbvXNgVs1OUV5M+pQZaH+IS3/nUXRcSIgADqpQIhe+ZWY/jnN27dD0ZCQCMQTHG
         ubdEuiOBbQPBhpcyet7t6bS0I7pks1z/ESTMd71P/BfPMmNL2PuP69q8efMDJSHnQyyr
         UaJ9iXEuDLk3Y5Ecs03Cjq4VomLhsYg67ls4GNdwRhpPQwuEWSJ9IkhO7wH4k0jgokfH
         wzFO9V2+A7PQDFOaA87vWYXNJ1MyWUbTZj5Mzm4CCskiPyFOHzlndIE1wDMSrxRtLfVc
         8Fug==
X-Gm-Message-State: APjAAAWy/vCyP2R9Rwrm5s7ROyBDtug8f3thKflrE8qjEjVpLh4PAtAj
        /xK9caCA9WATVGY2dkhi8jDLYBwf
X-Google-Smtp-Source: APXvYqx+YKUzAgdQ3NsFYMH6z0eL2j0Jjk0Dh0tuI4hufxNZ02T8zVAcaW7edumRKpeKm/0THZlC8w==
X-Received: by 2002:a81:af56:: with SMTP id x22mr22001913ywj.153.1580314162302;
        Wed, 29 Jan 2020 08:09:22 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o126sm1182152ywb.24.2020.01.29.08.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:09:21 -0800 (PST)
Subject: [PATCH RFC 0/8] For discussion of bug 198053
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:09:20 -0500
Message-ID: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

These are a proof-of-concept, not for merge.

This set of patches addresses the NFS/RDMA bug reported here:

https://bugzilla.kernel.org/show_bug.cgi?id=198053

However, applying them results in a regression of support for NFSv4
COMPOUNDs with multiple READ operations on TCP.

I think a different approach might be needed? I could introduce a
new transport method that would be called for READ/READLINK that
would enable the transport to determine how it wants to convey
the Reply payload. The TCP method would behave exactly as it does
today. The RDMA method would utilize a Write chunk if one is
available, otherwise, it would also behave as it does today.

If I can get that approach to work, it would both address 198053
and enable support for multiple READ operations in a COMPOUND for
both TCP and RDMA. Thoughts?

Sidebar: while working on this patch set, it occurred to me it
would be a good clean up if svc_alloc_arg could always set up a
page for rq_res->tail. Then there wouldn't have to be all the
duplicate logic for checking whether a tail exists, or if it's
large enough, etc. etc. Can you think of an easy way to grab
one of the rpc_rqst's rq_pages for this purpose?


---

Chuck Lever (8):
      nfsd: Fix NFSv4 READ on RDMA when using readv
      SUNRPC: Add XDR infrastructure for automatically padding xdr_buf::pages
      SUNRPC: TCP transport support for automated padding of xdr_buf::pages
      svcrdma: RDMA transport support for automated padding of xdr_buf::pages
      NFSD: NFSv2 support for automated padding of xdr_buf::pages
      NFSD: NFSv3 support for automated padding of xdr_buf::pages
      sunrpc: Add new contractual constraint on xdr_buf API
      SUNRPC: GSS support for automated padding of xdr_buf::pages


 fs/nfsd/nfs3xdr.c                     |   19 +-------
 fs/nfsd/nfs4xdr.c                     |   70 ++++++++-----------------------
 fs/nfsd/nfsxdr.c                      |   20 ++-------
 include/linux/sunrpc/xdr.h            |   74 +++++++++++++++++++++++++--------
 net/sunrpc/auth_gss/gss_krb5_crypto.c |   13 +++---
 net/sunrpc/auth_gss/gss_krb5_wrap.c   |   11 +++--
 net/sunrpc/auth_gss/svcauth_gss.c     |   51 +++++++++++++----------
 net/sunrpc/svc.c                      |    2 -
 net/sunrpc/svc_xprt.c                 |   14 ++++--
 net/sunrpc/svcsock.c                  |   39 +++++++++++------
 net/sunrpc/xdr.c                      |   15 ++++---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   13 ++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   27 ++++++++----
 13 files changed, 200 insertions(+), 168 deletions(-)

--
Chuck Lever
