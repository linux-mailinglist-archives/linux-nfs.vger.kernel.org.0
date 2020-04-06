Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53019FEC9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDFUK5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 16:10:57 -0400
Received: from fieldses.org ([173.255.197.46]:52470 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFUK5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 16:10:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C35C863E; Mon,  6 Apr 2020 16:10:55 -0400 (EDT)
Date:   Mon, 6 Apr 2020 16:10:55 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] SUNRPC: Backchannel RPCs don't fail when the
 transport disconnects
Message-ID: <20200406201055.GA8729@fieldses.org>
References: <20200403193802.2887.41182.stgit@klimt.1015granger.net>
 <1fe55c49410ee8d97c5247644a4678b665fd41e7.camel@hammerspace.com>
 <E472C4D7-313C-48F2-8D4E-8D1F81357979@oracle.com>
 <B385D770-D511-4E72-B0D7-90ED66892C2D@oracle.com>
 <063db847f7f2129504463919978dede3d328d0b6.camel@hammerspace.com>
 <15F1952A-07B1-40E0-BB24-0A7354BD6CB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F1952A-07B1-40E0-BB24-0A7354BD6CB7@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 03, 2020 at 07:11:12PM -0400, Chuck Lever wrote:
> 
> 
> > On Apr 3, 2020, at 6:43 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > On Fri, 2020-04-03 at 17:46 -0400, Chuck Lever wrote:
> >>> On Apr 3, 2020, at 4:05 PM, Chuck Lever <chuck.lever@oracle.com>
> >>> wrote:
> >>> 
> >>> Hi Trond, thanks for the look!
> >>> 
> >>>> On Apr 3, 2020, at 4:00 PM, Trond Myklebust <
> >>>> trondmy@hammerspace.com> wrote:
> >>>> 
> >>>> On Fri, 2020-04-03 at 15:42 -0400, Chuck Lever wrote:
> >>>>> Commit 3832591e6fa5 ("SUNRPC: Handle connection issues
> >>>>> correctly on
> >>>>> the back channel") intended to make backchannel RPCs fail
> >>>>> immediately when there is no forward channel connection. What's
> >>>>> currently happening is, when the forward channel conneciton
> >>>>> goes
> >>>>> away, backchannel operations are causing hard loops because
> >>>>> call_transmit_status's SOFTCONN logic ignores ENOTCONN.
> >>>> 
> >>>> Won't RPC_TASK_NOCONNECT do the right thing? It should cause the
> >>>> request to exit with an ENOTCONN error when it hits
> >>>> call_connect().
> >>> 
> >>> OK, so does that mean SOFTCONN is entirely the wrong semantic here?
> >>> 
> >>> Was RPC_TASK_NOCONNECT available when 3832591e6fa5 was merged?
> >> 
> >> It turns out 3832591e6fa5 is not related. It's 58255a4e3ce5 that
> >> added
> >> RPC_TASK_SOFTCONN on NFSv4 callback Calls.
> >> 
> >> However, the server uses nfsd4_run_cb_work() for both NFSv4.0 and
> >> NFSv4.1 callbacks. IMO a fix for this will have to take care that
> >> RPC_TASK_NOCONNECT is not set on NFSv4.0 callback tasks.
> > 
> > Possibly, but don't we really want to let such a NFSv4.0 request fail
> > and send another CB_NULL? There is already version-specific code in
> > nfsd4_process_cb_update() to set up the callback client.
> 
> A not unreasonable conclusion. But it's hard to test the NFSv4.0 case,
> since it's instability on the forward channel that is tickling this
> problem. The NFSv4.0 callback connection is not affected by that.
> 
> Maybe Bruce has a thought? Otherwise we can try an unconditional
> NOCONNECT for now. RPC_TASK_NOCONNECT was added three years after
> 58255a4e3ce5, fwiw...

I'm not really following the details here, but it makes sense to me that
we'd want nfsd to find about lost connections as soon as possible, so it
can try to use another connection or inform the client (with session
flags or NFS4ERR_CB_PATH_DOWN) promptly.  So NOCONNECT makes sense to
me.

--b.

> 
> 
> >> Unfortunately the looping behavior appears also related to the
> >> RPC_IS_SIGNALLED bug I reported earlier this week. The CB request is
> >> signalled as it is firing up, and then drops into a hard loop.
> >> 
> > 
> > Hmm... Is there any reason why xprt_rdma_alloc_slot() should not be
> > checking if the transport is being shut down? After all, if the
> > transport is being destroyed here, then there is no point in allocating
> > a slot for that specific RDMA transport (it's not as if it can be
> > reused elsewhere).
> 
> The trace for the NULL rqst I posted a couple days ago shows the
> signal occurring after xprt_enq_xmit, which is well past the
> call_reserve step.
> 
> I don't see any special SOFTCONN related logic in call_reserveresult,
> I suspect call_reserve is not currently set up to handle this case.
> 
> 
> >>            nfsd-1986  [001]   123.028240:
> >> svc_drop:             addr=192.168.2.51:52077 xid=0x489a88f6
> >> flags=RQ_SECURE|RQ_USEDEFERRAL|RQ_SPLICE_OK|RQ_BUSY
> >>   kworker/u8:12-442   [003]   123.028242:
> >> rpc_task_signalled:   task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE status=0 action=rpc_prepare_task
> >>   kworker/u8:10-440   [000]   123.028289:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=rpc_prepare_task
> >>   kworker/u8:10-440   [000]   123.028289:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_start
> >>   kworker/u8:10-440   [000]   123.028291:
> >> rpc_request:          task:47@3 nfs4_cbv1 CB_RECALL (async)
> >>   kworker/u8:10-440   [000]   123.028291:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_reserve
> >>   kworker/u8:10-440   [000]   123.028298:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_reserveresult
> >>   kworker/u8:10-440   [000]   123.028299:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_refresh
> >>   kworker/u8:10-440   [000]   123.028324:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_refreshresult
> >>   kworker/u8:10-440   [000]   123.028324:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_allocate
> >>   kworker/u8:10-440   [000]   123.028340:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|SIGNALLED status=0 action=call_encode
> >>   kworker/u8:10-440   [000]   123.028356:
> >> xprt_enq_xmit:        task:47@3 xid=0x8b95e935 seqno=0 stage=4
> >>   kworker/u8:10-440   [000]   123.028357:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=0
> >> action=call_transmit
> >>   kworker/u8:10-440   [000]   123.028363:
> >> xprt_reserve_cong:    task:47@3 snd_task:47 cong=0 cwnd=256
> >>   kworker/u8:10-440   [000]   123.028365:
> >> xprt_transmit:        task:47@3 xid=0x8b95e935 seqno=0 status=-512
> >>   kworker/u8:10-440   [000]   123.028368:
> >> xprt_release_cong:    task:47@3 snd_task:4294967295 cong=0 cwnd=256
> >>   kworker/u8:10-440   [000]   123.028368:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=0
> >> action=call_transmit_status
> >>   kworker/u8:10-440   [000]   123.028371:
> >> rpc_task_sleep:       task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=0 timeout=0
> >> queue=xprt_pending
> >>   kworker/u8:10-440   [000]   123.028376:
> >> rpc_task_wakeup:      task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|QUEUED|ACTIVE|NEED_RECV|SIGNALLED status=-107
> >> timeout=9000 queue=xprt_pending
> >>   kworker/u8:10-440   [000]   123.028377:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=-107
> >> action=xprt_timer
> >>   kworker/u8:10-440   [000]   123.028377:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=-107
> >> action=call_status
> >>   kworker/u8:10-440   [000]   123.028378:
> >> rpc_call_status:      task:47@3 status=-107
> >>   kworker/u8:10-440   [000]   123.028378:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=0
> >> action=call_encode
> >>   kworker/u8:10-440   [000]   123.028380:
> >> xprt_enq_xmit:        task:47@3 xid=0x8b95e935 seqno=0 stage=4
> >>   kworker/u8:10-440   [000]   123.028380:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=0
> >> action=call_transmit
> >>   kworker/u8:10-440   [000]   123.028381:
> >> xprt_reserve_cong:    task:47@3 snd_task:47 cong=0 cwnd=256
> >>   kworker/u8:10-440   [000]   123.028381:
> >> xprt_transmit:        task:47@3 xid=0x8b95e935 seqno=0 status=-512
> >>   kworker/u8:10-440   [000]   123.028382:
> >> xprt_release_cong:    task:47@3 snd_task:4294967295 cong=0 cwnd=256
> >>   kworker/u8:10-440   [000]   123.028382:
> >> rpc_task_run_action:  task:47@3 flags=ASYNC|DYNAMIC|SOFT|NOCONNECT
> >> runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=0
> >> action=call_transmit_status
> >> 
> >> If we want to avoid the early RPC_IS_SIGNALLED check in the
> >> scheduler,
> >> I guess an alternative would be to have call_transmit_status() check
> >> for
> >> RPC_TASK_SIGNALLED. That's not as broad a fix, but it would address
> >> both the NULL and the CB looping cases, IIUC.
> >> 
> >> 
> >>>>> To avoid changing the behavior of call_transmit_status in the
> >>>>> forward direction, make backchannel RPCs return with a
> >>>>> different
> >>>>> error than ENOTCONN when they fail.
> >>>>> 
> >>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>> ---
> >>>>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   15 ++++++++++---
> >>>>> --
> >>>>> net/sunrpc/xprtsock.c                      |    6 ++++--
> >>>>> 2 files changed, 14 insertions(+), 7 deletions(-)
> >>>>> 
> >>>>> I'm playing with this fix. It seems to be required in order to
> >>>>> get
> >>>>> Kerberos mounts to work under load with NFSv4.1 and later on
> >>>>> RDMA.
> >>>>> 
> >>>>> If there are no objections, I can carry this for v5.7-rc ...
> >>>>> 
> >>>>> 
> >>>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>>>> b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>>>> index d510a3a15d4b..b8a72d7fbcc2 100644
> >>>>> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> >>>>> @@ -207,11 +207,16 @@ rpcrdma_bc_send_request(struct
> >>>>> svcxprt_rdma
> >>>>> *rdma, struct rpc_rqst *rqst)
> >>>>> 
> >>>>> drop_connection:
> >>>>> 	dprintk("svcrdma: failed to send bc call\n");
> >>>>> -	return -ENOTCONN;
> >>>>> +	return -EHOSTUNREACH;
> >>>>> }
> >>>>> 
> >>>>> -/* Send an RPC call on the passive end of a transport
> >>>>> - * connection.
> >>>>> +/**
> >>>>> + * xprt_rdma_bc_send_request - send an RPC backchannel Call
> >>>>> + * @rqst: RPC Call in rq_snd_buf
> >>>>> + *
> >>>>> + * Returns:
> >>>>> + *	%0 if the RPC message has been sent
> >>>>> + *	%-EHOSTUNREACH if the Call could not be sent
> >>>>> */
> >>>>> static int
> >>>>> xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
> >>>>> @@ -225,11 +230,11 @@ xprt_rdma_bc_send_request(struct rpc_rqst
> >>>>> *rqst)
> >>>>> 
> >>>>> 	mutex_lock(&sxprt->xpt_mutex);
> >>>>> 
> >>>>> -	ret = -ENOTCONN;
> >>>>> +	ret = -EHOSTUNREACH;
> >>>>> 	rdma = container_of(sxprt, struct svcxprt_rdma,
> >>>>> sc_xprt);
> >>>>> 	if (!test_bit(XPT_DEAD, &sxprt->xpt_flags)) {
> >>>>> 		ret = rpcrdma_bc_send_request(rdma, rqst);
> >>>>> -		if (ret == -ENOTCONN)
> >>>>> +		if (ret < 0)
> >>>>> 			svc_close_xprt(sxprt);
> >>>>> 	}
> >>>>> 
> >>>>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> >>>>> index 17cb902e5153..92a358fd2ff0 100644
> >>>>> --- a/net/sunrpc/xprtsock.c
> >>>>> +++ b/net/sunrpc/xprtsock.c
> >>>>> @@ -2543,7 +2543,9 @@ static int bc_sendto(struct rpc_rqst
> >>>>> *req)
> >>>>> 	req->rq_xtime = ktime_get();
> >>>>> 	err = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0,
> >>>>> marker,
> >>>>> &sent);
> >>>>> 	xdr_free_bvec(xdr);
> >>>>> -	if (err < 0 || sent != (xdr->len + sizeof(marker)))
> >>>>> +	if (err < 0)
> >>>>> +		return -EHOSTUNREACH;
> >>>>> +	if (sent != (xdr->len + sizeof(marker)))
> >>>>> 		return -EAGAIN;
> >>>>> 	return sent;
> >>>>> }
> >>>>> @@ -2567,7 +2569,7 @@ static int bc_send_request(struct
> >>>>> rpc_rqst
> >>>>> *req)
> >>>>> 	 */
> >>>>> 	mutex_lock(&xprt->xpt_mutex);
> >>>>> 	if (test_bit(XPT_DEAD, &xprt->xpt_flags))
> >>>>> -		len = -ENOTCONN;
> >>>>> +		len = -EHOSTUNREACH;
> >>>>> 	else
> >>>>> 		len = bc_sendto(req);
> >>>>> 	mutex_unlock(&xprt->xpt_mutex);
> >>>>> 
> >>>> -- 
> >>>> Trond Myklebust
> >>>> Linux NFS client maintainer, Hammerspace
> >>>> trond.myklebust@hammerspace.com
> >>> 
> >>> --
> >>> Chuck Lever
> >> 
> >> --
> >> Chuck Lever
> >> 
> >> 
> >> 
> > -- 
> > Trond Myklebust
> > CTO, Hammerspace Inc
> > 4300 El Camino Real, Suite 105
> > Los Altos, CA 94022
> > www.hammer.space
> 
> --
> Chuck Lever
> 
> 
