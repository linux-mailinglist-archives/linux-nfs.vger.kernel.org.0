Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C064174EFD
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCASqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 13:46:00 -0500
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:58043
        "EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgCASqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 13:46:00 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 13:46:00 EST
Received: from [172.20.1.219] ([50.235.29.75])
        by :SMTPAUTH: with ESMTPSA
        id 8TUAjlrXX3mdr8TUAjdMjZ; Sun, 01 Mar 2020 11:38:42 -0700
X-CMAE-Analysis: v=2.3 cv=AZbP4EfG c=1 sm=1 tr=0
 a=VA9wWQeJdn4CMHigaZiKkA==:117 a=VA9wWQeJdn4CMHigaZiKkA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8
 a=yPCof4ZbAAAA:8 a=BLa6zQfhWGza00yZWR8A:9 a=EFZ49vrQq20z-xuo:21
 a=iBP7MK1XyrXoHnT4:21 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 05/11] xprtrdma: Allocate Protection Domain in
 rpcrdma_ep_create()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
 <20200221220033.2072.22880.stgit@manet.1015granger.net>
 <8a1b8d87-48a7-6cc2-66de-121a46d1b6a4@talpey.com>
 <D9382354-0063-43C5-9940-6F376D16E083@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <fd1a2b33-258e-eb8d-8ce8-83ee99504543@talpey.com>
Date:   Sun, 1 Mar 2020 10:38:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <D9382354-0063-43C5-9940-6F376D16E083@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfACK8M28YdLCj7WhOm5L9vbk5BgKBCZdkcutqlNwubOLkWsf9a/PbkrDIx1sDfqQvPLzQfCsLUm4CxBOSVHCBNYgVsoOipFEyNpkTTBCLvRxeIllSPss
 3bHIEdbNX+2KEfsG0qq9syJan7yiGK8V4aGos+ire60YH0178WLM+CzAAH2yfszxP146vrH96b2j8l8/IDucHf5rjD/FJWXQVyPW5R47ecV4OI5sVznKvsWM
 MIHwZ9F2IzoRal8U9Bming==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/1/2020 10:29 AM, Chuck Lever wrote:
> Hi Tom-
> 
> Thanks for your careful reading of the patch series!
> 
> 
>> On Mar 1, 2020, at 1:11 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 2/21/2020 2:00 PM, Chuck Lever wrote:
>>> Make a Protection Domain (PD) a per-connection resource rather than
>>> a per-transport resource. In other words, when the connection
>>> terminates, the PD is destroyed.
>>> Thus there is one less HW resource that remains allocated to a
>>> transport after a connection is closed.
>>
>> That's a good goal, but there are cases where the upper layer may
>> want the PD to be shared. For example, in a multichannel configuration,
>> where RDMA may not be constrained to use a single connection.
> 
> I see two reasons why PD sharing won't be needed for the Linux
> client implementation of RPC/RDMA:
> 
> - The plan for Linux NFS/RDMA is to manage multiple connections
>    in the NFS client layer, not at the RPC transport layer.
> 
> - We don't intend to retransmit an RPC that was registered via
>    one connection on a different connection; a retransmitted RPC
>    is re-marshaled from scratch before each transmit.
> 
> The purpose of destroying the PD at disconnect is to enable a
> clean device removal model: basically, disconnect all connections
> through that device, and we're guaranteed to have no more pinned
> HW resources. AFAICT, that is the model also used in other kernel
> ULPs.

True, and revoking the PD ensures that no further remote access can
occur, that is, it's a fully secure approach.

>> How would this approach support such a requirement?
> 
> As above, the Linux NFS client would create additional transports,
> each with their own single connection (and PD).
> 
> 
>> Can a PD be provided to a new connection?
> 
> The sequence of API events is that an ID and PD are created first,
> then a QP is created with the ID and PD, then the connection is
> established.

Yes, I'm aware, and that was the question - if PD sharing were desired,
can the PD be passed to the QP creation, instead of being allocated
inline?

If this isn't needed now, then it's fine to leave it out. But I think
it's worth considering that it may be desirable in future.

Tom.

>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   net/sunrpc/xprtrdma/verbs.c |   26 ++++++++++----------------
>>>   1 file changed, 10 insertions(+), 16 deletions(-)
>>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>>> index f361213a8157..36fe7baea014 100644
>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>> @@ -363,14 +363,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>>>   		rc = PTR_ERR(ia->ri_id);
>>>   		goto out_err;
>>>   	}
>>> -
>>> -	ia->ri_pd = ib_alloc_pd(ia->ri_id->device, 0);
>>> -	if (IS_ERR(ia->ri_pd)) {
>>> -		rc = PTR_ERR(ia->ri_pd);
>>> -		pr_err("rpcrdma: ib_alloc_pd() returned %d\n", rc);
>>> -		goto out_err;
>>> -	}
>>> -
>>>   	return 0;
>>>     out_err:
>>> @@ -403,9 +395,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>>>     	rpcrdma_ep_destroy(r_xprt);
>>>   -	ib_dealloc_pd(ia->ri_pd);
>>> -	ia->ri_pd = NULL;
>>> -
>>>   	/* Allow waiters to continue */
>>>   	complete(&ia->ri_remove_done);
>>>   @@ -423,11 +412,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>>>   	if (ia->ri_id && !IS_ERR(ia->ri_id))
>>>   		rdma_destroy_id(ia->ri_id);
>>>   	ia->ri_id = NULL;
>>> -
>>> -	/* If the pd is still busy, xprtrdma missed freeing a resource */
>>> -	if (ia->ri_pd && !IS_ERR(ia->ri_pd))
>>> -		ib_dealloc_pd(ia->ri_pd);
>>> -	ia->ri_pd = NULL;
>>>   }
>>>     static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
>>> @@ -514,6 +498,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
>>>   	ep->rep_remote_cma.flow_control = 0;
>>>   	ep->rep_remote_cma.rnr_retry_count = 0;
>>>   +	ia->ri_pd = ib_alloc_pd(id->device, 0);
>>> +	if (IS_ERR(ia->ri_pd)) {
>>> +		rc = PTR_ERR(ia->ri_pd);
>>> +		goto out_destroy;
>>> +	}
>>> +
>>>   	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
>>>   	if (rc)
>>>   		goto out_destroy;
>>> @@ -540,6 +530,10 @@ static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
>>>   	if (ep->rep_attr.send_cq)
>>>   		ib_free_cq(ep->rep_attr.send_cq);
>>>   	ep->rep_attr.send_cq = NULL;
>>> +
>>> +	if (ia->ri_pd)
>>> +		ib_dealloc_pd(ia->ri_pd);
>>> +	ia->ri_pd = NULL;
>>>   }
>>>     /* Re-establish a connection after a device removal event.
> 
> --
> Chuck Lever
> 
> 
> 
> 
> 
