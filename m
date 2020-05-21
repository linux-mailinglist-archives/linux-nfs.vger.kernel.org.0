Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388961DCFC7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgEUOdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEUOdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:33:46 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7259C061A0E;
        Thu, 21 May 2020 07:33:46 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a14so7305438ilk.2;
        Thu, 21 May 2020 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F2doUypY+0PF/pJK7CMWb1oSI7oqBqmoWHwdiabFaSw=;
        b=Q/zjh/IJY+dGYFkLm0/rypeoSJF5Hzj/jSKYg5niYVh8sUbJT4TrpkUTWw5Gp/HsOT
         c/brtq2yRYUtUAiSabQvCmlB3M936Atbr3/Dpbt6WFshBLcTICytUPe3yK0T9j4Zv6s6
         aVR0kRmLvYeyl14BUAJCK8XLRDZv2CWRC8XiVFinoJXor+J2VQT23IltDj4/9GuxXxqE
         tHHfAq7MKBOPn/0KhF51tOkUUXwua1MjlOzmG9wnf05EsAFxgqERt2OJljnUq2Fo/mmG
         zaiIleLBXj7bUwEk1JXuBbUES+pADk71HZs6NBemnJ1pM+cdhULpZbH8NutCqzoU26wE
         XvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F2doUypY+0PF/pJK7CMWb1oSI7oqBqmoWHwdiabFaSw=;
        b=DRHE+etl/DyxDSLaPke56RLND4LUVg//7Ti4FeVBuCetaOhTEa+5sTMO81hfkvI1wo
         j261z64sapUdBaxlU7RVfqYVljqYgpAG4tkMm5HvolLuwNEe8Teftyqvsf4P467Z0Rwo
         lVXTom4sAElPPtybuE5hqnuqwIKIjgo8kCKXZXXNLqgL+xZcUUFwUpDQGa6vIDtOKof8
         8lCRvkEzsTnnKZhg36SbOUSSsj48gL9/qzVN9iPVtakLE0OaiwDIaBDMFhKivXqbnC6Y
         db5Gw9I8oV4a47yz1L5xzfPUallHuqy31/jKbEj+eQJihq9mcNSqEGTenhGuUIQ8BTQb
         +afA==
X-Gm-Message-State: AOAM532f+xXLJqrcVZ2VB1vVy5LliPd/WJllti3/y/Kx1CslFMwRInvh
        nhamBWkZxCU2FLJy/ENgPZO2jRnU
X-Google-Smtp-Source: ABdhPJzM1nZz4CHKA64iptBFB1B3epWRbVQIHpdWuF29W7MU4ElvMlmXG9hBITOLWiq6lLApRuFZiw==
X-Received: by 2002:a92:5d86:: with SMTP id e6mr8626193ilg.120.1590071625857;
        Thu, 21 May 2020 07:33:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y11sm2974659ily.22.2020.05.21.07.33.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:33:44 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEXgXg000803;
        Thu, 21 May 2020 14:33:43 GMT
Subject: [PATCH v3 00/32] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:33:42 -0400
Message-ID: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've updated this series to address the WRT15 bug. The bug was due
to an over-aggressive clean-up which unintentionally altered how
XPT_DATA was set in svc_tcp_recvfrom().

To help better expose that kind of change to code inspection, I've
broken out the clean-ups in ("SUNRPC: Refactor svc_recvfrom()") into
patches separate from the change that adds bvecs.

The fixed code has been tested with complete runs of pynfs (both
4.0 and 4.1). No new test failures were observed. I've also run the
cthon locking tests with NFSv3, NFSv4.0, and NFSv4.1 using TCP
without observing any failures.

In addition I've made a small change to the new svcsock tracepoints
to follow the convention of reporting errors via tracepoints whose
name ends in _err, rather than using the same tracepoint to report
both normal progress and an error.

(Normal progress reports are for developers. Such tracepoints would
be enabled only rarely because they fire for every socket receive.
An error tracepoint can be left persistently enabled without causing
a torrent of trace records).


Available to view:
  https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.8

Pull from:
  git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8

Highlights of this series:
* Remove serialization of sending RPC/RDMA Replies
* Convert the TCP socket send path to use xdr_buf::bvecs (pre-requisite for RPC-on-TLS)
* Fix svcrdma backchannel sendto return code
* Convert a number of dprintk call sites to use tracepoints
* Fix the "suggest braces around empty body in an 'else' statement" warning


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

Chuck Lever (32):
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
 include/linux/sunrpc/svcsock.h             |   6 +-
 include/trace/events/rpcrdma.h             | 142 +++++--
 include/trace/events/sunrpc.h              | 419 +++++++++++++++++++--
 net/sunrpc/svc.c                           |  19 +-
 net/sunrpc/svc_xprt.c                      |  41 +-
 net/sunrpc/svcsock.c                       | 382 +++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  86 +----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
 19 files changed, 1257 insertions(+), 555 deletions(-)

--
Chuck Lever
