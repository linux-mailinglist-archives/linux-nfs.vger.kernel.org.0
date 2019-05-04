Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865B1137BD
	for <lists+linux-nfs@lfdr.de>; Sat,  4 May 2019 08:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfEDGQT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 May 2019 02:16:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfEDGQT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 4 May 2019 02:16:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53207C76FE5F7E71F8FF;
        Sat,  4 May 2019 14:16:15 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 14:16:14 +0800
Subject: Re: [PATCH] SUNRPC: task should be exit if encode return EKEYEXPIRED
 more times
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <bfields@fieldses.org>, <jlayton@kernel.org>,
        <davem@davemloft.net>, <linux-nfs@vger.kernel.org>
References: <1556530351-81780-1-git-send-email-zhangxiaoxu5@huawei.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <dd163a59-eb34-242a-052d-eb0ac4d4a9e8@huawei.com>
Date:   Sat, 4 May 2019 14:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1556530351-81780-1-git-send-email-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping.

On 4/29/2019 5:32 PM, ZhangXiaoxu wrote:
> If the rpc.gssd always return cred success, but now the cred is
> expired, then the task will loop in call_refresh and call_transmit.
> 
> Exit the rpc task after retry.
> 
> Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
> ---
>   net/sunrpc/clnt.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 8ff11dc..a32d3f1 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1793,7 +1793,14 @@ call_encode(struct rpc_task *task)
>   			rpc_delay(task, HZ >> 4);
>   			break;
>   		case -EKEYEXPIRED:
> -			task->tk_action = call_refresh;
> +			if (!task->tk_cred_retry) {
> +				rpc_exit(task, task->tk_status);
> +			} else {
> +				task->tk_action = call_refresh;
> +				task->tk_cred_retry--;
> +				dprintk("RPC: %5u %s: retry refresh creds\n",
> +					task->tk_pid, __func__);
> +			}
>   			break;
>   		default:
>   			rpc_exit(task, task->tk_status);
> 

