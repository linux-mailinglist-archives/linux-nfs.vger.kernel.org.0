Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF88410D6B0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2019 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2OLL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Nov 2019 09:11:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:57648 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfK2OLK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Nov 2019 09:11:10 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iagyu-0006iV-1h; Fri, 29 Nov 2019 17:10:48 +0300
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: unsafe req->rq_xprt using inside bc_svc_process() ?
Message-ID: <79494560-1876-494a-0838-cc646eabf68c@virtuozzo.com>
Date:   Fri, 29 Nov 2019 17:10:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

OpenVz team got complain on crash in bc_svc_process().
Crashed node had 15 running containers with active nfsv4.1 mounts,
single nfsv4.1-svc thread was processed its back-channel requests.
In our case nfs41_callback_svc() took rpc_rqst *req from serv->sv_cb_list
started its processing but found that req->rq_xprt points to already freed
struct rpc_xprt aka part of struct sock_xprt transport.

Back-channel request was submitted via xprt_complete_bc_request(),
its processing uses req->rq_xprt reference in many times,
however I did not found who keeps this reference.
It seems sock_xprt or even whole its net namespace can be freed before bc_svc_process() will start processing of submitted back-channel request, and req->rq_xprt using is unsafe in bc_svc_process()

Am I missed something probably?

Thank you,
	Vasily Averin
