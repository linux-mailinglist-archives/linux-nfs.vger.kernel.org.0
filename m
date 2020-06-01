Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442C51EA602
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAOij (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFAOij (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jun 2020 10:38:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE57C05BD43;
        Mon,  1 Jun 2020 07:38:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2CFC23158; Mon,  1 Jun 2020 10:38:38 -0400 (EDT)
Date:   Mon, 1 Jun 2020 10:38:38 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v4 00/33] Possible NFSD patches for v5.8
Message-ID: <20200601143838.GA11647@fieldses.org>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 30, 2020 at 09:28:03AM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> To address merge conflicts with Anna's tree, I've rebased this
> series on v5.7-rc6 plus ("SUNRPC: Split the xdr_buf event class").
> Only two commits were changed by this rebase:
> 
>       SUNRPC: Move xpt_mutex into socket xpo_sendto methods
>       SUNRPC: Add more svcsock tracepoints
> 
> Feel free to make use of this version, or ignore it. :-)

Linus generally seems to prefer handling minor conflict resolutions
himself over maintainers rebasing.

--b.

> 
> 
> Available to view:
>  https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.8
> 
> Pull from this topic branch:
>  git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8
> 
> Highlights of this series:
> * Remove serialization of sending RPC/RDMA Replies
> * Convert the TCP socket send path to use xdr_buf::bvecs (pre-requisite for RPC-on-TLS)
> * Fix svcrdma backchannel sendto return code
> * Convert a number of dprintk call sites to use tracepoints
> * Fix the "suggest braces around empty body in an 'else' statement" warning
> 
> 
> Changes since v3:
> * Rebased on v5.7-rc6 + ("SUNRPC: Split the xdr_buf event class")
> 
> Changes since v2:
> * Rebased on v5.7-rc6
> * Fixed a logic error that left XPT_DATA unset on return from svc_tcp_recvfrom()
> * Broke down "SUNRPC: Refactor svc_recvfrom()" to separate clean ups from logic changes
> * Some superfluous clean-ups have been redacted
> * Add separate tracepoints for error cases (eg, tcp_recv and tcp_recv_err)
> 
> Changes since v1:
> * Rebased on v5.7-rc5+
> * Re-organized the series so changes interesting to linux-rdma appear together
> * Addressed sparse warnings found by the kbuild test robot
> * Included an additional minor clean-up: removal of the unused SVCRDMA_DEBUG macro
> * Clarified several patch descriptions
> 
> ---
> 
> Chuck Lever (33):
>       SUNRPC: Split the xdr_buf event class
>       SUNRPC: Move xpt_mutex into socket xpo_sendto methods
>       svcrdma: Clean up the tracing for rw_ctx_init errors
>       svcrdma: Clean up handling of get_rw_ctx errors
>       svcrdma: Trace page overruns when constructing RDMA Reads
>       svcrdma: trace undersized Write chunks
>       svcrdma: Fix backchannel return code
>       svcrdma: Remove backchannel dprintk call sites
>       svcrdma: Rename tracepoints that record header decoding errors
>       svcrdma: Remove the SVCRDMA_DEBUG macro
>       svcrdma: Displayed remote IP address should match stored address
>       svcrdma: Add tracepoints to report ->xpo_accept failures
>       SUNRPC: Remove kernel memory address from svc_xprt tracepoints
>       SUNRPC: Tracepoint to record errors in svc_xpo_create()
>       SUNRPC: Trace a few more generic svc_xprt events
>       SUNRPC: Remove "#include <trace/events/skb.h>"
>       SUNRPC: Add more svcsock tracepoints
>       SUNRPC: Replace dprintk call sites in TCP state change callouts
>       SUNRPC: Trace server-side rpcbind registration events
>       SUNRPC: Rename svc_sock::sk_reclen
>       SUNRPC: Restructure svc_tcp_recv_record()
>       SUNRPC: Replace dprintk() call sites in TCP receive path
>       SUNRPC: Refactor recvfrom path dealing with incomplete TCP receives
>       SUNRPC: Clean up svc_release_skb() functions
>       SUNRPC: Refactor svc_recvfrom()
>       SUNRPC: Restructure svc_udp_recvfrom()
>       SUNRPC: svc_show_status() macro should have enum definitions
>       NFSD: Add tracepoints to NFSD's duplicate reply cache
>       NFSD: Add tracepoints to the NFSD state management code
>       NFSD: Add tracepoints for monitoring NFSD callbacks
>       SUNRPC: Clean up request deferral tracepoints
>       NFSD: Squash an annoying compiler warning
>       NFSD: Fix improperly-formatted Doxygen comments
> 
> 
>  fs/nfsd/nfs4callback.c                     |  37 +-
>  fs/nfsd/nfs4proc.c                         |   7 +-
>  fs/nfsd/nfs4state.c                        |  63 ++--
>  fs/nfsd/nfscache.c                         |  57 +--
>  fs/nfsd/nfsctl.c                           |  26 +-
>  fs/nfsd/state.h                            |   7 -
>  fs/nfsd/trace.h                            | 345 +++++++++++++++++
>  include/linux/sunrpc/svc.h                 |   1 +
>  include/linux/sunrpc/svc_rdma.h            |   6 +-
>  include/linux/sunrpc/svc_xprt.h            |   6 +
>  include/linux/sunrpc/svcsock.h             |   6 +-
>  include/trace/events/rpcrdma.h             | 142 +++++--
>  include/trace/events/sunrpc.h              | 419 +++++++++++++++++++--
>  net/sunrpc/svc.c                           |  19 +-
>  net/sunrpc/svc_xprt.c                      |  52 +--
>  net/sunrpc/svcsock.c                       | 407 ++++++++++----------
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 121 ++----
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  10 +-
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
>  net/sunrpc/xprtsock.c                      |  12 +-
>  22 files changed, 1321 insertions(+), 590 deletions(-)
> 
> --
> Chuck Lever
