Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC51D0099
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgELVWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVWI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3CCC061A0C;
        Tue, 12 May 2020 14:22:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id o19so882857qtr.10;
        Tue, 12 May 2020 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ed7Z1Oa0oNoLeRpJdzVxFnNhOXXncm6v02Y+O5wgw5s=;
        b=Siu5eyWdIVH0lKMDy+D45H0wB+ejxyArUgV/Dgt/zaMfF6Z2PKEY0QMvYAX8Pr4Ydk
         IlpQork/99l8Eg/oDm25zVZ4ifNuDaWLpV6347IJ9qNvjHRklZPgQqwv4usNvWwmzLK8
         NjvFKRUGsTNO1LOLO+I78y3XhYO+D2cd+5gPlsEaTeGFs+Ojpu8BDn7mOlci4mhvVBFi
         0EQpER4cMxtlmlh+eDxhIckYLtEQlgFbL4DwBoY1H/RiD92QccMRD8TpyfCzejBUCWJx
         bO6hX3o54DvE9hW2wqvWZZPZqzqCukVZsdAmBpKU3YAqSOKcnysnH5f28c2vh2ZNG28s
         YUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ed7Z1Oa0oNoLeRpJdzVxFnNhOXXncm6v02Y+O5wgw5s=;
        b=gwAH81ZZpi9wBqSoxKSHeHbLFKxWiUYuc1FY8wgLk/Hp9pQoulpe05vV88THXWtshq
         PChaL7cWKVw2cq17IkVASDdm9CGSBB+gFnm6VHipOwQgeNZVUfnFepmvs+n4OIlhIjdV
         Uqi89UpQZLA2ZzVayw6AsqerlRzSuQHQ/eZ+Tbc2wIMtOD5FY9LgHWKoIIgjffkhosIT
         FW25XEGwZANwbv4nm8sFFZXNf3sanYQOehYQZkxfrM0JwyxGdD5M0azNcPFnozT8W/ay
         zg0Jre3fQR38MO5Vh5i2pUxWC0s4xawviwAO3bTye0VjVZx34Pp2tr6ChZ+LKNns8TFs
         75dg==
X-Gm-Message-State: AGi0PuZ3bGMheSJ+2PiKrgUlqgt/nEODqNQN+lz8IMq47LZ5HdoZ+QGF
        Mecz7wVxnYt/jMSj99j/x2CK3DeJ
X-Google-Smtp-Source: APiQypLUtJ/6MluOvdey+0Ejl+zeI1SvaUD1D9mqXBYu5nJ+alS9aBAJe3xYxQ4m+2YqrIc9buGaGg==
X-Received: by 2002:ac8:2623:: with SMTP id u32mr24137564qtu.388.1589318526762;
        Tue, 12 May 2020 14:22:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c26sm11947526qkm.98.2020.05.12.14.22.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:05 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLM4T9009872;
        Tue, 12 May 2020 21:22:04 GMT
Subject: [PATCH v2 00/29] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:04 -0400
Message-ID: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Available to view:
  https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.8

Pull from:
  git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8

Highlights of this series:
* Remove serialization of sending RPC/RDMA Replies
* Convert the TCP socket send path to use xdr_buf::bvecs (pre-requisite for RPC-on-TLS)
* Fix svcrdma backchannel sendto return code
* Convert a number of dprintk call sites to use tracepoints
* Fix the "suggest braces around empty body in an ‘else’ statement" warning

Changes since v1:
* Rebased on v5.7-rc5+
* Re-organized the series so changes interesting to linux-rdma appear together
* Addressed sparse warnings found by the kbuild test robot
* Included an additional minor clean-up: removal of the unused SVCRDMA_DEBUG macro
* Clarified several patch descriptions

---

Chuck Lever (29):
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
 fs/nfsd/trace.h                            | 345 ++++++++++++++++++
 include/linux/sunrpc/svc.h                 |   1 +
 include/linux/sunrpc/svc_rdma.h            |   6 +-
 include/linux/sunrpc/svcsock.h             |   6 +-
 include/trace/events/rpcrdma.h             | 142 ++++++--
 include/trace/events/sunrpc.h              | 387 ++++++++++++++++++--
 net/sunrpc/svc.c                           |  19 +-
 net/sunrpc/svc_xprt.c                      |  41 +--
 net/sunrpc/svcsock.c                       | 393 ++++++++++-----------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  86 +----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
 19 files changed, 1221 insertions(+), 570 deletions(-)

--
Chuck Lever
