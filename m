Return-Path: <linux-nfs+bounces-3532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C88D848F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7521C22584
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A112BF30;
	Mon,  3 Jun 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D9jhueSF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528F22075
	for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423401; cv=none; b=thACJlGug0WGBFByuDRcKnusfy4KLf7BltZjo195dfF1jOnATS/NVwE23Q7fNW/TWaF0SjJ2mU8B9ILu3ZeK+Ez79LcxQ8pc7lkcdYZOZnzqPQuMBhuHOQ6mUDDLoWYJea0R9X+ygBc2gFhLqiRG3XP0GwuwCxw46aCtvzqc/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423401; c=relaxed/simple;
	bh=Ff2WzmhmYEItPNf1qQFYOKhLPGHJOjnu1zuuR7VObKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIFcYy4OF20kZ6oQxMt7A5o1+zQUkQSNcFHf259goqwO6Z+JqmM6mM1BVDIZ5LLatlnNw3/aq6ufgy1/IJVJxT3HHAVdmjqR3658pG/Ho1oJpTyJFRimESsjaRFP5EdAODWqB2vbBIdICJGayqXpMTwUKVafNms/lSCwnU5nP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D9jhueSF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: chuck.lever@oracle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717423394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7s1AYR70khVIfVDYU7GD/y9Hirp7COpsMuoMksv4eUw=;
	b=D9jhueSFt8g+EbsbojazbUDojysJWfbQ53H5O2wiv19TNfciQbBNPEAtmPnulL6rI4FXfX
	5Mnhwc5HcJ7RFBZf4m4/cLQ+fsA0SaB+znsbxcKcfG9kfEliCcFu+QYTU8xaNh7F4ADobn
	DiWtiSWVgqEev/gGW25SS7E5dJcift4=
X-Envelope-To: cel@kernel.org
X-Envelope-To: linux-nfs@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <1e54456d-a50d-c1ce-ca3e-e58e7e2bdbc3@linux.dev>
Date: Mon, 3 Jun 2024 22:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] svcrdma: Refactor the creation of listener CMA ID
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20240531131550.64044-4-cel@kernel.org>
 <20240531131550.64044-5-cel@kernel.org>
 <9ae0657b-b430-9318-4e19-eae9f40307fb@linux.dev>
 <Zl3DvlqRGasKmhz8@tissot.1015granger.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <Zl3DvlqRGasKmhz8@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/3/24 21:23, Chuck Lever wrote:
> On Mon, Jun 03, 2024 at 06:59:13PM +0800, Guoqing Jiang wrote:
>>
>> On 5/31/24 21:15, cel@kernel.org wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> In a moment, I will add a second consumer of CMA ID creation in
>>> svcrdma. Refactor so this code can be reused.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    net/sunrpc/xprtrdma/svc_rdma_transport.c | 67 ++++++++++++++----------
>>>    1 file changed, 40 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> index 2b1c16b9547d..fa50b7494a0a 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>>> @@ -65,6 +65,8 @@
>>>    static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
>>>    						 struct net *net, int node);
>>> +static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
>>> +				   struct rdma_cm_event *event);
>>>    static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>>>    					struct net *net,
>>>    					struct sockaddr *sa, int salen,
>>> @@ -122,6 +124,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
>>>    	}
>>>    }
>>> +static struct rdma_cm_id *
>>> +svc_rdma_create_listen_id(struct net *net, struct sockaddr *sap,
>>> +			  void *context)
>>> +{
>>> +	struct rdma_cm_id *listen_id;
>>> +	int ret;
>>> +
>>> +	listen_id = rdma_create_id(net, svc_rdma_listen_handler, context,
>>> +				   RDMA_PS_TCP, IB_QPT_RC);
>>> +	if (IS_ERR(listen_id))
>>> +		return listen_id;
>> I am wondering if above need to return PTR_ERR(listen_id),
> PTR_ERR would convert the listen_id error to an integer, but
> svc_rdma_create_listen_id() returns a pointer or an ERR_PTR. Thus
> using PTR_ERR() would be wrong in this case.
>
>
>> and I find some
>> callers (in net/rds/, nvme etc)
>> return PTR_ERR(id) while others (rtrs-srv, ib_isert.c) return ERR_PTR(ret)
>> with ret is set to PTR_ERR(id).
> These functions use PTR_ERR only when the calling function returns
> an int.

Thanks for the explanation!

Guoqing

