Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A014F343
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 21:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgAaUln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 15:41:43 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44245 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAaUln (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 15:41:43 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so6048914ywc.11;
        Fri, 31 Jan 2020 12:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rg+onKFknsLvLX9JqukVFDouz4qGqvSfOybfNJoTEnA=;
        b=oIaeoBRndoeufPqxZtJHTOvh4EvynFLT2xliExksn3XcGLJ2cmcawaVn5c5Udv0nW3
         laGAgujY0BoGA2Pzfe6A5JrxhnoebOpds39NlLqzVRpo5dh4sfhHUIIblgrMggKTL8kC
         tb5JXbgzvB7dCzPjW/QzVvDs6GkK4oNoH6qQLV3ZgSIKro+hr/4GOcqHPopdKsSSr48s
         SztoJDH9iYEnNVUkdy0nwGTzfTOrB0g6SZ8gLCus7kAuhnx4uTpkD97FhROZOJ/6kMMV
         JkTrk7UUXHjbUX1JhcVQGjt0uXU0dICe6A3/xsufC7IcW8PHjL5fly1z8zo6pWwqBq28
         +00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rg+onKFknsLvLX9JqukVFDouz4qGqvSfOybfNJoTEnA=;
        b=dUOTWwiTIldrfYdlUVsqfAuMfya64NmsdtL+YhXzcPRgBD8lU9dJmtO7moT8Qi0h8g
         EnZ/qvHCi/5oCxZJXsZSn4k2l7EKGNibCmUzh/bUeZHW61MffVz7rrlx0UcKrmeZxr+O
         72allJ9ceBiZPl8ZMuof0uH4T0lEZFWQAlgz2cFpBMVaY0guIjSpb0JM12QX0QYNC6KK
         yzmwctBqgEU4ngZw40CJN6be7ZZIRKydibK5qPdOiq9R+ma5FwVGIj8hDMm1LSo68FRS
         c7+OWJV9pYO+26Fn/+3XgxHPVkIu+VwGrrsq/AE4hKkgqvenp7XeHYdqXs179fbFUYQO
         qxaw==
X-Gm-Message-State: APjAAAUmoolqigLXvOBcwDBnV4BL7GwZu4deEp4Io3SuQ0qfsiBPvupc
        mlltycndvrTC+Kaz3WjgQngXToSO
X-Google-Smtp-Source: APXvYqxKokVJRLL6F/Cu1xgwGRc6KzKdl+YHnHe2aN7AS54DPXW+/Cgq98GddK8u6Wr15MAIJViFEg==
X-Received: by 2002:a25:8484:: with SMTP id v4mr586086ybk.13.1580503301030;
        Fri, 31 Jan 2020 12:41:41 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x131sm4938278ywd.54.2020.01.31.12.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:41:40 -0800 (PST)
Subject: [PATCH RFC2 0/3] Follow-up discussion of bug 198053
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:41:39 -0500
Message-ID: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
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

This approach does not cause any regression of support for NFSv4
COMPOUNDs with multiple READ operations over TCP. It is also far
less invasive than my first try.

Thoughts, opinions?


---

Chuck Lever (3):
      nfsd: Fix NFSv4 READ on RDMA when using readv
      SUNRPC: Track current encode position in struct xdr_stream
      NFSD: Enable nfsd4_encode_readv() for NFS/RDMA


 fs/nfsd/nfs4proc.c                       |    1 +
 fs/nfsd/nfs4xdr.c                        |   16 +++++++---------
 include/linux/sunrpc/svc.h               |    3 +++
 include/linux/sunrpc/svc_rdma.h          |    6 +++++-
 include/linux/sunrpc/svc_xprt.h          |    2 ++
 include/linux/sunrpc/xdr.h               |    1 +
 net/sunrpc/svc.c                         |   14 ++++++++++++++
 net/sunrpc/svcsock.c                     |    7 +++++++
 net/sunrpc/xdr.c                         |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |   29 +++++++++++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   26 +++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 13 files changed, 88 insertions(+), 21 deletions(-)

--
Chuck Lever
