Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CF113D30
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLEIkZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Dec 2019 03:40:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:44134 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfLEIkZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Dec 2019 03:40:25 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1icmg9-0005Cc-BT; Thu, 05 Dec 2019 11:40:05 +0300
Subject: Re: unsafe req->rq_xprt using inside bc_svc_process() ?
From:   Vasily Averin <vvs@virtuozzo.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <79494560-1876-494a-0838-cc646eabf68c@virtuozzo.com>
Message-ID: <3b4bd000-13f6-bd4e-a0ea-3e4da3882135@virtuozzo.com>
Date:   Thu, 5 Dec 2019 11:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <79494560-1876-494a-0838-cc646eabf68c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've found that Trond fixed it recently in commit 875f0706acc
"SUNRPC: The TCP back channel mustn't disappear while requests are outstanding"

On 11/29/19 5:10 PM, Vasily Averin wrote:
> OpenVz team got complain on crash in bc_svc_process().
> Crashed node had 15 running containers with active nfsv4.1 mounts,
> single nfsv4.1-svc thread was processed its back-channel requests.
> In our case nfs41_callback_svc() took rpc_rqst *req from serv->sv_cb_list
> started its processing but found that req->rq_xprt points to already freed
> struct rpc_xprt aka part of struct sock_xprt transport.
> 
> Back-channel request was submitted via xprt_complete_bc_request(),
> its processing uses req->rq_xprt reference in many times,
> however I did not found who keeps this reference.
> It seems sock_xprt or even whole its net namespace can be freed before bc_svc_process() will start processing of submitted back-channel request, and req->rq_xprt using is unsafe in bc_svc_process()
> 
> Am I missed something probably?
