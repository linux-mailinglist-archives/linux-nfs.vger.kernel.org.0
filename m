Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC415F47E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbgBNSV1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 13:21:27 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33257 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgBNPtq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:49:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id b6so4973054ybr.0;
        Fri, 14 Feb 2020 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B4Yces3GA3NT+lBTZdVIgNxGvj/dhKg96+I5y5scsvg=;
        b=gNM5lKg4vqIVz/o8q+PAO9NAWIc47FwnqjDp8dx2ZnbpQNZB/Aw4uddWrR5bBA7Duo
         zFIWz1fTR3bLrwy9nOKkRi71pKjuKhEsxcZQoBjP8MWVmZtbPiESyAlBC6FcLmOloeAN
         sZBUpacJqvXzUCIUvkxe+a8XFuX0cJm0dcPmvQv481ce8YolmgUlp0PSjnr/Up00ezFF
         HyxHPzUllJUZW71Px0gArL+i8hyGuiysSALcWKUvbmqxgEfR89kqB/Ni7wYZEYBT7nWh
         rvv7FCwSvZFQzejwT26HFGRwnItSEpSykJITzpyZY678quSn27BmaYH+jF90FrB565x+
         kqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B4Yces3GA3NT+lBTZdVIgNxGvj/dhKg96+I5y5scsvg=;
        b=hSeL8iflMR42EnluJx/dM4Dj7Rxp565y5vfqyZwvsSKs/EoSr/6HsMyQ1NL0eHojbm
         ue8cAtGdhkXCIRdAkoHhBCq4dPKvC6kaeE5IbwKM2tjLrq90lvuxcOACN6XVQu1J5DGK
         GDDe8ha/jqTwa2XIWf5O7Xd5BjenpHqYc61Hb9RFa4ekZfTgflKWiswexAV2ZP19wUf3
         LhkLkpFxLIw02YD24IrgNSuEsVYSgRh7hnG+pz/CLMIPYCJQnCTC1ly51pAf4oo0uniz
         XhrdmiV94i6Nj7mp1+tQ+mQCSenu/82zyAFtTRbEMwYdKSkj3Ne8TSfcx7z+rFxkkEDF
         NbZA==
X-Gm-Message-State: APjAAAWgOisfgXJedFUoHdZRrmxLn8RsvCwmKjg+w0DcW/hVh36da8rB
        dPmSBhD0ugXb5vEYzYwO+jL4i085
X-Google-Smtp-Source: APXvYqzKbkj09pM79pXgkQDMAlSRFxHqG0ms5dFZBDHSILLBgE1Api88TzotZgVMmu8BiEkgpQXcag==
X-Received: by 2002:a25:c945:: with SMTP id z66mr3463977ybf.206.1581695385184;
        Fri, 14 Feb 2020 07:49:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v7sm2630937ywh.62.2020.02.14.07.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:49:44 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFneeg029147;
        Fri, 14 Feb 2020 15:49:41 GMT
Subject: [PATCH RFC 0/9] Address bugzilla 198053 and more ...
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:49:40 -0500
Message-ID: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

As promised, I'm resending the fix for 198053, now that the v5.6
merge window has closed. This fix gets splice-incapable file systems
working with NFS/RDMA. That's the first patch in this series.

We can discuss splitting the fix up again, if you so desire, but my
sense is that will make the fix more challenging to backport into
stable kernels.

The next logical step is to add support for multiple READ payloads
to the server's RPC-over-RDMA transport implementation. Subsequent
patches in this series start down that path. There is more work to
do to finish that task. Today I'm sending only what is code-complete
and working.

The primary issue is that today svcrdma assumes that rq_res's page
vector is exactly what needs to be pushed in a single Write chunk.
In other words, only one read payload is supported, and it has to
fit exactly into that page vector. And critically, the XDR pad for
that payload must not be included in the page vector.

I've already implemented changes to handle Writing more than one
chunk back to a client. See patches 4 and 7.

Patch 9 introduces a data structure to keep track of multiple Write
chunks and multiple read payloads. Next, the svc_rdma_sendto path
needs to be changed to use the information in this data structure to
exclude arbitrary segments of rq_res (ie, read payloads already sent
via explicit RDMA) when constructing each RPC/RDMA Reply.

Comments and input are welcome as always.


---

Chuck Lever (9):
      nfsd: Fix NFSv4 READ on RDMA when using readv
      NFSD: Clean up nfsd4_encode_readv
      svcrdma: Avoid DMA mapping small RPC Replies
      NFSD: Invoke svc_encode_read_payload in "read" NFSD encoders
      svcrdma: Add trace point to examine client-provided write segment
      svcrdma: De-duplicate code that locates Write and Reply chunks
      svcrdma: Post RDMA Writes while XDR encoding replies
      svcrdma: Refactor svc_rdma_sendto()
      svcrdma: Add data structure to track READ payloads


 fs/nfsd/nfs3xdr.c                          |    4 
 fs/nfsd/nfs4xdr.c                          |   32 ++--
 fs/nfsd/nfsxdr.c                           |    4 
 include/linux/sunrpc/svc.h                 |    3 
 include/linux/sunrpc/svc_rdma.h            |   21 ++
 include/linux/sunrpc/svc_xprt.h            |    2 
 include/trace/events/rpcrdma.h             |   47 +++++
 net/sunrpc/svc.c                           |   16 ++
 net/sunrpc/svcsock.c                       |    8 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |   58 +++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |   42 +++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  248 +++++++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |    1 
 14 files changed, 308 insertions(+), 180 deletions(-)

--
Chuck Lever
