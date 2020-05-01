Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038F91C1BB9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgEARdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729260AbgEARdY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:33:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDAFC061A0C;
        Fri,  1 May 2020 10:33:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f83so2557772qke.13;
        Fri, 01 May 2020 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sA3GZFbu5RP3AmAyeldIt+9yZ/WrLDNOZ31SEUtOAa8=;
        b=L1y8yt0Q3Je8oCr5Nq7oGR3o3S8I72ZsCoVAwBsJEPpJIAUuJd9YGF9Rpo0QJcn0Ht
         qEu2bDMjG9s4QX1I0iLSK27tuAxSZs+NktYv5xTO3csktnbGj4bLYfkkhoBFGJrSV69V
         8qoQsfsO3MuMsoMgNW6QuLKW/PQfLfMzBUOFM9rc+HCp6ZkaUrgd1UE1tVLjF0QDoCy/
         hvLp+6htksZGJidnEOl3VEYqYybOKx0E2FVmoFTBkeeIzJ1OLONwOYu8dcTofJ0lCHJM
         NbbRPFdfn4LVhq3gk2SuWKQukjJk63S4TOvJ6zfdtFTvnsVzYP9u/ZqdqvqsA8aOJPoj
         /MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sA3GZFbu5RP3AmAyeldIt+9yZ/WrLDNOZ31SEUtOAa8=;
        b=JZmj4T1n0LS6Z+vAznfmexjEyq7Z9JgD3Czf4e/aVwKtldsyS0HtwwTjjD9ItFyg+p
         90L5V4YR5UX9/hQJahWAxaL/MMBr7wVThD+2fMFqUqIbwZS1v1sH81dc8gM7awmkg3Fz
         Ei5cV5rkSwRGpJeJ2Smsr/nlle7BjoDhQEfXcXuH6bxYtsLUunIS0CuE73P4mi8bmIMi
         plQ3cWxhUSIDLltUvDUes21WSbOu+b7WQRzt+pzfLT7y2u5ZSndGSXii7X51yea57sEr
         Qxe8+1IcLyG7UuNbnlAj4gA1k2ot2ezc2f10kZ6sidFqUqcK7umYQBvHqMIQTQDy6EXH
         1o2A==
X-Gm-Message-State: AGi0PuYj2V6lwiQjrpEgAuUOcRbiuJfBR7c7n9RBP6nAxglfOn7js1N8
        hwYZgACCTz6zkuhSpMeOXwy9glru
X-Google-Smtp-Source: APiQypI5tbyS8fbKTfYKT3w87bFY6r5JZcl9nVOlmjrjRE0bWyeuRnTANnmXkWQenZlDngukWKIxSA==
X-Received: by 2002:a37:96c4:: with SMTP id y187mr2771597qkd.126.1588354403543;
        Fri, 01 May 2020 10:33:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g25sm2973301qkl.50.2020.05.01.10.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:23 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXLPc026700;
        Fri, 1 May 2020 17:33:21 GMT
Subject: [PATCH v1 0/7] RPC server tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:21 -0400
Message-ID: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

(cc: linux-nfs and linux-rdma)

A mix of RPC-over-sockets and RPC-over-RDMA observability
enhancements, along with one very interesting change:

"SUNRPC: Move xpt_mutex into socket xpo_sendto methods"

I've changed svc_send() so that it no longer holds the transport
mutex during the call to ->xpo_sendto. Instead, the socket
sendto methods take that mutex, since they need to serialize
sends on the socket. The RDMA sendto method does not need that
serialization, so the mutex is not taken in svc_rdma_sendto.

Performance results for that change are reported in the patch
description.

---

Chuck Lever (7):
      SUNRPC: svc_show_status() macro needs enum definitions
      SUNRPC: Move xpt_mutex into socket xpo_sendto methods
      svcrdma: Displayed remote IP address should match stored address
      SUNRPC: Remove kernel memory address from svc_xprt tracepoints
      SUNRPC: Tracepoint to record errors in svc_xpo_create()
      SUNRPC: Trace a few more generic svc_xprt events
      svcrdma: Add tracepoints to report ->xpo_accept failures


 include/linux/sunrpc/svc_xprt.h            |  6 ++
 include/trace/events/rpcrdma.h             | 36 ++++----
 include/trace/events/sunrpc.h              | 95 ++++++++++++++++------
 net/sunrpc/svc_xprt.c                      | 41 ++++------
 net/sunrpc/svcsock.c                       | 37 ++++++---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 35 ++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  9 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   | 55 +++++--------
 net/sunrpc/xprtsock.c                      | 12 ++-
 9 files changed, 187 insertions(+), 139 deletions(-)

--
Chuck Lever
