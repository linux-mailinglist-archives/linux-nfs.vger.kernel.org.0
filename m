Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262B51E9176
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgE3N2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N2H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16815C03E969;
        Sat, 30 May 2020 06:28:07 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id q18so5209021ilm.5;
        Sat, 30 May 2020 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VGgc6IKSdQFcnyPkkpvjEIw7SfVA9Of3FWwPy71Kljs=;
        b=bK3h9R3+1KOKfmehyVRXvYV4l4/aJ3oUPIsOIkhS59SIg6Xf7spf5djUr1zxSbJ9Bu
         GUtIzozut50PnWVefuu6xGvt9ElpufVP7Ro3vIixm5v/fnty6ZnZcF4B/MI6Snw1sd5w
         cTpJqC6LaWiwmzCsqr9a2N6Wg6se8X9Y11I7k95QxEO51CYBQoL2vxkeZB5T5qhTKByt
         PqC3Ya825SS0yOaWn9EBPUPQtdRZ2SsJ9EehBxUOnllFELBtChXhDnHMjUl1qBBCeCJF
         Qi92hueAVEqAjy7WAk6JYxXgrM/3em8R/5W6us8r61NeDV5msR8hENF8ZWxaMd6fnVL5
         lyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VGgc6IKSdQFcnyPkkpvjEIw7SfVA9Of3FWwPy71Kljs=;
        b=nI91XdOHHU5uSmQzmqGybfwByOjqcUVj8jLgAI5Pv+X/hcfyv//iakOVbTTgdZJBEV
         a6NgoqLxJxiGMNoOrjBzCJ+X4mlzdX7zDL7f3inKEmkjixZ7fo9rsWg1xKw5vZqi1iBu
         2bf1Z2dTM55uFDE90sUjfU06FbrMzQ/zF0Efuz+Za+cxtUkdOgkcq8uzDJ8srOhoz4aW
         +F4VKrqLTKXxbGs5gs6iQzibxzA+9HNd5Dydz7PjN15ahJBNKc87sBlf2WVOwsczziXW
         jI9dmsoBuo17fNodqm+xeDQ0kRC7pNMesP6M9Uf0YRNPiX8mKd8t9eZ/RMJL6qBO5d9m
         u7wg==
X-Gm-Message-State: AOAM53378IkTXRtF5Qiko0/vvwvCCrSqZJEfDJx5N0zolDj8aCXx6VCA
        SWSVTrrzu8fSMVvYocShjWKTx6mJ
X-Google-Smtp-Source: ABdhPJzwwykOSYVlaI7or/UuYVc7jnCzXYyvFSNFXCka2mtTEmehgcwx2zp1M25aBiaDiHtRe5GTjw==
X-Received: by 2002:a92:d112:: with SMTP id a18mr4767557ilb.3.1590845285814;
        Sat, 30 May 2020 06:28:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e12sm5081679ioc.37.2020.05.30.06.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:05 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDS3Bo001384;
        Sat, 30 May 2020 13:28:04 GMT
Subject: [PATCH v4 00/33] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:03 -0400
Message-ID: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

To address merge conflicts with Anna's tree, I've rebased this
series on v5.7-rc6 plus ("SUNRPC: Split the xdr_buf event class").
Only two commits were changed by this rebase:

      SUNRPC: Move xpt_mutex into socket xpo_sendto methods
      SUNRPC: Add more svcsock tracepoints

Feel free to make use of this version, or ignore it. :-)


Available to view:
 https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.8

Pull from this topic branch:
 git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8

Highlights of this series:
* Remove serialization of sending RPC/RDMA Replies
* Convert the TCP socket send path to use xdr_buf::bvecs (pre-requisite for RPC-on-TLS)
* Fix svcrdma backchannel sendto return code
* Convert a number of dprintk call sites to use tracepoints
* Fix the "suggest braces around empty body in an 'else' statement" warning


Changes since v3:
* Rebased on v5.7-rc6 + ("SUNRPC: Split the xdr_buf event class")

Changes since v2:
* Rebased on v5.7-rc6
* Fixed a logic error that left XPT_DATA unset on return from svc_tcp_recvfrom()
* Broke down "SUNRPC: Refactor svc_recvfrom()" to separate clean ups from logic changes
* Some superfluous clean-ups have been redacted
* Add separate tracepoints for error cases (eg, tcp_recv and tcp_recv_err)

Changes since v1:
* Rebased on v5.7-rc5+
* Re-organized the series so changes interesting to linux-rdma appear together
* Addressed sparse warnings found by the kbuild test robot
* Included an additional minor clean-up: removal of the unused SVCRDMA_DEBUG macro
* Clarified several patch descriptions

---

Chuck Lever (33):
      SUNRPC: Split the xdr_buf event class
      SUNRPC: Move xpt_mutex into socket xpo_sendto methods
      svcrdma: Clean up the tracing for rw_ctx_init errors
      svcrdma: Clean up handling of get_rw_ctx errors
      svcrdma: Trace page overruns when constructing RDMA Reads
      svcrdma: trace undersized Write chunks
      svcrdma: Fix backchannel return code
      svcrdma: Remove backchannel dprintk call sites
      svcrdma: Rename tracepoints that record header decoding errors
      svcrdma: Remove the SVCRDMA_DEBUG macro
      svcrdma: Displayed remote IP address should match stored address
      svcrdma: Add tracepoints to report ->xpo_accept failures
      SUNRPC: Remove kernel memory address from svc_xprt tracepoints
      SUNRPC: Tracepoint to record errors in svc_xpo_create()
      SUNRPC: Trace a few more generic svc_xprt events
      SUNRPC: Remove "#include <trace/events/skb.h>"
      SUNRPC: Add more svcsock tracepoints
      SUNRPC: Replace dprintk call sites in TCP state change callouts
      SUNRPC: Trace server-side rpcbind registration events
      SUNRPC: Rename svc_sock::sk_reclen
      SUNRPC: Restructure svc_tcp_recv_record()
      SUNRPC: Replace dprintk() call sites in TCP receive path
      SUNRPC: Refactor recvfrom path dealing with incomplete TCP receives
      SUNRPC: Clean up svc_release_skb() functions
      SUNRPC: Refactor svc_recvfrom()
      SUNRPC: Restructure svc_udp_recvfrom()
      SUNRPC: svc_show_status() macro should have enum definitions
      NFSD: Add tracepoints to NFSD's duplicate reply cache
      NFSD: Add tracepoints to the NFSD state management code
      NFSD: Add tracepoints for monitoring NFSD callbacks
      SUNRPC: Clean up request deferral tracepoints
      NFSD: Squash an annoying compiler warning
      NFSD: Fix improperly-formatted Doxygen comments


 fs/nfsd/nfs4callback.c                     |  37 +-
 fs/nfsd/nfs4proc.c                         |   7 +-
 fs/nfsd/nfs4state.c                        |  63 ++--
 fs/nfsd/nfscache.c                         |  57 +--
 fs/nfsd/nfsctl.c                           |  26 +-
 fs/nfsd/state.h                            |   7 -
 fs/nfsd/trace.h                            | 345 +++++++++++++++++
 include/linux/sunrpc/svc.h                 |   1 +
 include/linux/sunrpc/svc_rdma.h            |   6 +-
 include/linux/sunrpc/svc_xprt.h            |   6 +
 include/linux/sunrpc/svcsock.h             |   6 +-
 include/trace/events/rpcrdma.h             | 142 +++++--
 include/trace/events/sunrpc.h              | 419 +++++++++++++++++++--
 net/sunrpc/svc.c                           |  19 +-
 net/sunrpc/svc_xprt.c                      |  52 +--
 net/sunrpc/svcsock.c                       | 407 ++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 121 ++----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  10 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
 net/sunrpc/xprtsock.c                      |  12 +-
 22 files changed, 1321 insertions(+), 590 deletions(-)

--
Chuck Lever
