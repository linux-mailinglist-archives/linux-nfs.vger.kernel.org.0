Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96B33103C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEaOcD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 10:32:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:36118 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaOcC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 May 2019 10:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:32:01 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.228.129.69]) ([10.228.129.69])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2019 07:32:01 -0700
Subject: Re: [PATCH RFC 00/12] for-5.3 NFS/RDMA patches for review
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <ef371698-5b2f-40c2-8fcc-b3a3c57cd158@intel.com>
Date:   Fri, 31 May 2019 10:32:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/28/2019 2:20 PM, Chuck Lever wrote:
> This is a series of fixes and architectural changes that should
> improve robustness and result in better scalability of NFS/RDMA.
> I'm sure one or two of these could be broken down a little more,
> comments welcome.
> 
> The fundamental observation is that the RPC work queues are BOUND,
> thus rescheduling work in the Receive completion handler to one of
> these work queues just forces it to run later on the same CPU. So
> try to do more work right in the Receive completion handler to
> reduce context switch overhead.
> 
> A secondary concern is that the average amount of wall-clock time
> it takes to handle a single Receive completion caps the IOPS rate
> (both per-xprt and per-NIC). In this patch series I've taken a few
> steps to reduce that latency, and I'm looking into a few others.
> 
> This series can be fetched from:
> 
>    git://git.linux-nfs.org/projects/cel/cel-2.6.git
> 
> in topic branch "nfs-for-5.3".
> 
> ---
> 
> Chuck Lever (12):
>        xprtrdma: Fix use-after-free in rpcrdma_post_recvs
>        xprtrdma: Replace use of xdr_stream_pos in rpcrdma_marshal_req
>        xprtrdma: Fix occasional transport deadlock
>        xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
>        xprtrdma: Remove fr_state
>        xprtrdma: Add mechanism to place MRs back on the free list
>        xprtrdma: Reduce context switching due to Local Invalidation
>        xprtrdma: Wake RPCs directly in rpcrdma_wc_send path
>        xprtrdma: Simplify rpcrdma_rep_create
>        xprtrdma: Streamline rpcrdma_post_recvs
>        xprtrdma: Refactor chunk encoding
>        xprtrdma: Remove rpcrdma_req::rl_buffer
> 
> 
>   include/trace/events/rpcrdma.h  |   47 ++++--
>   net/sunrpc/xprtrdma/frwr_ops.c  |  330 ++++++++++++++++++++++++++-------------
>   net/sunrpc/xprtrdma/rpc_rdma.c  |  146 +++++++----------
>   net/sunrpc/xprtrdma/transport.c |   16 +-
>   net/sunrpc/xprtrdma/verbs.c     |  115 ++++++--------
>   net/sunrpc/xprtrdma/xprt_rdma.h |   43 +----
>   6 files changed, 384 insertions(+), 313 deletions(-)
> 

For hfi1:
Tested-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
