Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D002E30E4EA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhBCVZZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 16:25:25 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:54535
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhBCVZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 16:25:25 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id 7PddloU6S4A0U7PddlwssS; Wed, 03 Feb 2021 14:24:38 -0700
X-CMAE-Analysis: v=2.4 cv=OKDiYQWB c=1 sm=1 tr=0 ts=601b1496
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=3UT470RhSK1ViTJfi10A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v3 0/6] RPC/RDMA client fixes
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <84c2694b-9c73-0125-4327-098d8e5e9f96@talpey.com>
Date:   Wed, 3 Feb 2021 16:24:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKGkQpoctO183CwbznssAhlYZ3RJky6HcxAOIu+rgGZmDyqE5nBEHGjEDCxeEqPxuGWRk/9tjA8NGBdDWd2CWMnkKC6r/wPuUr8Iwq3TN3/kG5EN4z5Q
 GEFWVLzC9na+N7F/+aAztA6iazNj7pVtK7HqtduiCLISe+s7ENN2/QTeTDK6Ykqiho5DcU2m0Eu5c1LGFFmBRlV0iDu44PeqRMVWZOAxNdT4xRsH6hodKzdo
 /ZJfhZCCV72/4pKJdLXshfuaG+xk0KiWIfU+lrzi79s=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/3/2021 3:06 PM, Chuck Lever wrote:
> Changes since v2:
> - Another minor optimization in rpcrdma_convert_kvec()
> - Some patch description clarifications
> - Add Reviewed-by (thanks Tom!)
> 
> Changes since v1:
> - Respond to review comments
> - Split "Remove FMR support" into three patches for clarity
> - Fix implicit chunk roundup
> - Improve Receive completion tracepoints
> 
> ---
> 
> Chuck Lever (6):
>        xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
>        xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
>        xprtrdma: Refactor invocations of offset_in_page()
>        rpcrdma: Fix comments about reverse-direction operation
>        xprtrdma: Pad optimization, revisited
>        rpcrdma: Capture bytes received in Receive completion tracepoints
> 
> 
>   include/trace/events/rpcrdma.h             | 50 +++++++++++++++++++++-
>   net/sunrpc/xprtrdma/backchannel.c          |  4 +-
>   net/sunrpc/xprtrdma/frwr_ops.c             | 12 ++----
>   net/sunrpc/xprtrdma/rpc_rdma.c             | 17 +++-----

While reviewing the changes in rpc_rdma.c, I noticed a related minor
nit, which might be worth cleaning up for clarity.

Toward the end of rpcrdma_convert_iovs, there is no longer any
need to capture the returned value of rpcrdma_convert_kvec:

	if (xdrbuf->tail[0].iov_len)
		seg = rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);

                 ^^^^^^ --> (void)?
out:
	if (unlikely(n > RPCRDMA_MAX_SEGS))
		return -EIO;
	return n;

The two "goto out" statements just above it are getting kinda ugly
too, but...

Tom.


>   net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
>   net/sunrpc/xprtrdma/xprt_rdma.h            | 15 ++++---
>   6 files changed, 68 insertions(+), 34 deletions(-)
> 
> --
> Chuck Lever
> 
> 
