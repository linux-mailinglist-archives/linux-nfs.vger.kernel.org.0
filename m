Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98E1115888
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLFVVA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 16:21:00 -0500
Received: from fieldses.org ([173.255.197.46]:54250 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfLFVVA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 16:21:00 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 787E81C83; Fri,  6 Dec 2019 16:20:59 -0500 (EST)
Date:   Fri, 6 Dec 2019 16:20:59 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: unsafe req->rq_xprt using inside bc_svc_process() ?
Message-ID: <20191206212059.GD17524@fieldses.org>
References: <79494560-1876-494a-0838-cc646eabf68c@virtuozzo.com>
 <3b4bd000-13f6-bd4e-a0ea-3e4da3882135@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4bd000-13f6-bd4e-a0ea-3e4da3882135@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 05, 2019 at 11:40:04AM +0300, Vasily Averin wrote:
> I've found that Trond fixed it recently in commit 875f0706acc
> "SUNRPC: The TCP back channel mustn't disappear while requests are outstanding"

Thanks for following up!--b.

> 
> On 11/29/19 5:10 PM, Vasily Averin wrote:
> >OpenVz team got complain on crash in bc_svc_process().
> >Crashed node had 15 running containers with active nfsv4.1 mounts,
> >single nfsv4.1-svc thread was processed its back-channel requests.
> >In our case nfs41_callback_svc() took rpc_rqst *req from serv->sv_cb_list
> >started its processing but found that req->rq_xprt points to already freed
> >struct rpc_xprt aka part of struct sock_xprt transport.
> >
> >Back-channel request was submitted via xprt_complete_bc_request(),
> >its processing uses req->rq_xprt reference in many times,
> >however I did not found who keeps this reference.
> >It seems sock_xprt or even whole its net namespace can be freed before bc_svc_process() will start processing of submitted back-channel request, and req->rq_xprt using is unsafe in bc_svc_process()
> >
> >Am I missed something probably?
