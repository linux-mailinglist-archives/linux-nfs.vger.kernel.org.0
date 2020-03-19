Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1438E18BAD8
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCSPU3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:29 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41333 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPU2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:28 -0400
Received: by mail-qv1-f68.google.com with SMTP id a10so1182254qvq.8;
        Thu, 19 Mar 2020 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZtMj/CBgCD3yGjXP1YkOgaQmTlsjIgpm/I74/jq1ac4=;
        b=E4JRJX4luJOgYONYsHvQhSr12DWtuR5xbWoovSf6PvhbhhpGNj38hF7rznswQcU1I3
         kXbeXvCea3H3ueHXMzH/nbXUEL2dFHXgdUhDghJ1n5mrxZXbp2MetqyRwODoAfe20tio
         P31XRvSOYR4Dq4sp5Zxxfjd30Ry557T+LiHTDjsgp0KJ55I4CVTXA4INuPa9Mp0rTDi8
         b/4lct20e40sh4WSHRMVJr46rUpeztRZgAi6BECb40MtrNVV/O4F860GZOqVG9k8YSYd
         lYrT09V8L9nz/h5RtxuyWVNIWGKBa3VLNFFZkpamjvoMJQ9N+44lfNHnQuW6pzUruFVH
         bunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZtMj/CBgCD3yGjXP1YkOgaQmTlsjIgpm/I74/jq1ac4=;
        b=mHviqZ2ZrkCkDctR5FX6bQJaOpn+eckbixG3Agd7Esm/vrYmGq+vdI6eg2Saw2RUH4
         uyeP1JRqFcPidJubfHzJ4gyIktPJoLkNZlGaLcqWzSJxXw5DfDy9rG9KKt5A+WKZ5B3X
         nfRU7gX7Vou7uTpGQ/Qoa3lslnR9AjS7aRqJQxgMNBoXC4uOUCIkFUciPtkvVWZ79DxW
         J4Gj0nQ1TUwSHSzuYHe6T8BJ0s+5COPlDiFDqc+GYZiWV862YNW3UvAUtaIDgV+ab69c
         1Cf5L80ZTuzFpjif2BA6BhJC20xCqK7ivG7FN0YKvR0YHCYNn2Em3vRi0EVW7xjKsbzA
         GWyQ==
X-Gm-Message-State: ANhLgQ3wrlPFJn/7aWAHPANYNXJ1beJxnjptOIZKY77M4mr+tk5UgmZn
        3TT84iRHa0itOtY82m9lNTSOGNFzzos=
X-Google-Smtp-Source: ADFU+vsTt5F2ty1kdCBE2hG4/bJmmvyxcpTUpMaVIC/e6eJDAtfVAoGXAPjYSUe1CHGoSzN0UrduFQ==
X-Received: by 2002:ad4:4a89:: with SMTP id h9mr3494361qvx.168.1584631225592;
        Thu, 19 Mar 2020 08:20:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h25sm1652734qkg.87.2020.03.19.08.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:24 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKNfo011145;
        Thu, 19 Mar 2020 15:20:23 GMT
Subject: [PATCH RFC 00/11] Linux NFS server support for multiple Write chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:23 -0400
Message-ID: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The RPC/RDMA version 1 protocol allows clients to provision more
than one Write chunk in each RPC/RDMA message. The Linux NFS client
never has need to construct a message with multiple Write chunks, so
the Linux NFS server has never implemented support for them.

At testing events, we discovered that the Solaris NFS client can
emit such requests on occasion, but only when an application invokes
readv(2) on a "forcedirectio" mount -- rare, indeed.

Even so, it's been on my "to-do" list for quite some time to get the
Linux NFS server to handle multiple Write chunks. While addressing
the recent NFSD/RDMA bug with Linux filesystems that do not have a 
.read_splice method [1], I realized that it was time to get this one
off my plate.

So here is an attempt to support NFS/RDMA clients that send multiple
Write chunks. To do this generically requires more xdr_buf slicing
and dicing than the simple "zero or one" implementation.

At the same time, the ability to send RDMA Write requests _outside_
the .xpo_sendto path is introduced. Extensive testing has not
revealed any functional or performance regression with this change.

Thoughts and comments are welcome.


[1] - https://bugzilla.kernel.org/show_bug.cgi?id=198053

---

Chuck Lever (11):

      SUNRPC: Adjust synopsis of xdr_buf_subsegment()
      svcrdma: Clean up RDMA Write path
      NFSD: Invoke svc_encode_read_payload in "read" NFSD encoders
      svcrdma: Post RDMA Writes while XDR encoding replies
      svcrdma: Clean up svc_rdma_encode_reply_chunk()
      svcrdma: Cache number of Write chunks
      svcrdma: Add a data structure to track READ payloads
      svcrdma: Add svc_rdma_skip_payloads()
      svcrdma: Support multiple READ payloads when pulling up
      svcrdma: Support multiple READ payloads in svc_rdma_map_reply_msg()
      svcrdma: Support multiple Write chunks in svc_rdma_send_reply_chunk


 fs/nfsd/nfs3xdr.c                       |   4 +
 fs/nfsd/nfs4xdr.c                       |   3 +
 fs/nfsd/nfsxdr.c                        |   4 +
 include/linux/sunrpc/svc_rdma.h         |  24 +-
 include/trace/events/rpcrdma.h          |  16 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  32 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 134 +++++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   | 556 ++++++++++++++++++++------------
 8 files changed, 486 insertions(+), 287 deletions(-)

--
Chuck Lever
