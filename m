Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70793D6505
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhGZQTA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 12:19:00 -0400
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:47346
        "EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbhGZQQz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 12:16:55 -0400
Received: from [192.168.0.100] ([68.239.50.225])
        by :SMTPAUTH: with ESMTPSA
        id 83nmmkvCl0LVM83nnmq73U; Mon, 26 Jul 2021 09:50:04 -0700
X-CMAE-Analysis: v=2.4 cv=JJ/+D+Gb c=1 sm=1 tr=0 ts=60fee7bc
 a=Rhw2r8FBodfaBxRKvGSZLA==:117 a=Rhw2r8FBodfaBxRKvGSZLA==:17
 a=IkcTkHD0fZMA:10 a=Mwu5d-69jdYTgDQK8hcA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 1/3] svcrdma: Fewer calls to wake_up() in Send
 completion handler
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
 <162731081843.13580.15415936872318036839.stgit@klimt.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <e25bd7be-6bcc-cf7d-efcf-1ac39d411431@talpey.com>
Date:   Mon, 26 Jul 2021 12:50:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162731081843.13580.15415936872318036839.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB7yfYMkh/ggSnMeOMx0z35ZSJuEgiRhbDdrzgq2PjRBfbNTmb5boByG4mec2PxM4GvFmvSWwXOb/GE+9jWssLiR2E/wTKFZVAs1xOBaGp3rvN+1aqaf
 Z8/MOgaCKP27nD0cbmt3/NJLXaRoOb3ciV9N0zQe+C36e/ZGulE4GsHPZlL6tZ29lhv1Y17CSJZfm8JEkMQvc8r3XdXDon25Y4shWF65wGOBbOWKjvSTHD6v
 0dBRaeiBus7t8KH550rTHXm6gX6kJ4HBbwU5bembVMY=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/26/2021 10:46 AM, Chuck Lever wrote:
>   /**
>    * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
>    * @cq: Completion Queue context
> @@ -275,11 +289,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
>   
>   	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
>   
> +	svc_rdma_wake_send_waiters(rdma, 1);
>   	complete(&ctxt->sc_done);
>   
> -	atomic_inc(&rdma->sc_sq_avail);
> -	wake_up(&rdma->sc_send_wait);

This appears to change the order of wake_up() vs complete().
Is that intentional? Is there any possibility of a false
scheduler activation, later leading to a second wakeup or poll?

Tom.
