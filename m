Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697DE1D9C1A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2020 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgESQLJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 12:11:09 -0400
Received: from fieldses.org ([173.255.197.46]:45050 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgESQLJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 May 2020 12:11:09 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AD29E621B; Tue, 19 May 2020 12:11:08 -0400 (EDT)
Date:   Tue, 19 May 2020 12:11:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
Message-ID: <20200519161108.GD25858@fieldses.org>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm getting a repeatable timeout failure on python 4.0 test WRT15.  In
pynfs, run: 

	./nfs4.0/testserver.py server:/export/path --rundeps --maketree WRT15

Looks like it sends WRITE+GETATTR(FATTR4_SIZE) compounds with write
offset 0 and write length taking on every value from 0 to 8192.

Probably an xdr decoding bug of some kind?

I don't see anything in the server logs.

--b.

On Tue, May 12, 2020 at 05:22:04PM -0400, Chuck Lever wrote:
> Available to view:
>   https://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/nfsd-5.8
> 
> Pull from:
>   git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8
> 
> Highlights of this series:
> * Remove serialization of sending RPC/RDMA Replies
> * Convert the TCP socket send path to use xdr_buf::bvecs (pre-requisite for RPC-on-TLS)
> * Fix svcrdma backchannel sendto return code
> * Convert a number of dprintk call sites to use tracepoints
> * Fix the "suggest braces around empty body in an ‘else’ statement" warning
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
> Chuck Lever (29):
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
>  fs/nfsd/trace.h                            | 345 ++++++++++++++++++
>  include/linux/sunrpc/svc.h                 |   1 +
>  include/linux/sunrpc/svc_rdma.h            |   6 +-
>  include/linux/sunrpc/svcsock.h             |   6 +-
>  include/trace/events/rpcrdma.h             | 142 ++++++--
>  include/trace/events/sunrpc.h              | 387 ++++++++++++++++++--
>  net/sunrpc/svc.c                           |  19 +-
>  net/sunrpc/svc_xprt.c                      |  41 +--
>  net/sunrpc/svcsock.c                       | 393 ++++++++++-----------
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  86 +----
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
>  19 files changed, 1221 insertions(+), 570 deletions(-)
> 
> --
> Chuck Lever
