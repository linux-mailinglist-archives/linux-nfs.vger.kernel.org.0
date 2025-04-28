Return-Path: <linux-nfs+bounces-11314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D72A9F8AD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925873AA57C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6215427A92F;
	Mon, 28 Apr 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv17Njz8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F00288B1;
	Mon, 28 Apr 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865381; cv=none; b=BwouWO+Yxhpd8mVBBWAUX23OnRD0p7B39+QMjys0qLWrIkhot+Vw2OEkG43zGM3xqkVUWR7AlRlul4rwndPmj5/Ongrd58dh7Bae8cBy6roZsY9YETTiGcC9gF4fw3/BETRa6Wumm15XtLnvwv50xvE8ZGRDG8xoAGtZGcyXJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865381; c=relaxed/simple;
	bh=PAnPWNAX8XbCDa80rpnYS7ta/qUgh5STcklx7oFzhy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Daq54mNX4qdEVlDg6r/HXQHbRNtQ5/wn4lbA7YT37s15saiqqXxfG+WRvS7H6kh078Y1Uc8bxXgXeuIRypPSpyKVTaqb1zDtFNKNN4IU++fIsHRVwYJQHnxSHn1U5GG/9X8fHwGrHwDDzySLFpPYD8VfvP/gswkzm1dYZ3Q2fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv17Njz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88D1C4CEE4;
	Mon, 28 Apr 2025 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865377;
	bh=PAnPWNAX8XbCDa80rpnYS7ta/qUgh5STcklx7oFzhy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sv17Njz86olQF0A4TDVAIOJZ5Jlh2hucanS9BNpZPQtBr+jSfKYJGYvLrmgcswKAn
	 NLLH9EwXLbSykIk6iNN9p1/HXhXJMH+J26un4oHn+fJx5W751MKTVyJfYrWezs2HV0
	 dwJwkEgLsmQnxyAl8sihK/ZG66yYhjizeFpNmnvXLg1gAG4MvTpL6rHABolfC88Byy
	 QGY7acTujJ/sKfMaBnySaa2j0N27NZRU1n0d5d+q/7xjW/PFnZoRO+kotngluVXgyx
	 mXy3SZxm2+1h6YLD2VauXE5ODpnAq6i5DsxhhzUO5MFHnnhVVJ4MHVaIfv1NtqW7X/
	 zlv8nU6sgwcZg==
Message-ID: <abb0f9c9-796b-4d4e-9df4-37908fd9a00b@kernel.org>
Date: Mon, 28 Apr 2025 14:36:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] svcrdma: Unregister the device if svc_rdma_accept() fails
To: Zhu Yanjun <yanjun.zhu@linux.dev>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250427163959.5126-1-cel@kernel.org>
 <6d21d80b-db20-4f00-bff0-147716693baf@linux.dev>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <6d21d80b-db20-4f00-bff0-147716693baf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/28/25 2:10 AM, Zhu Yanjun wrote:
> 在 2025/4/27 18:39, cel@kernel.org 写道:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> To handle device removal, svc_rdma_accept() registers an interest in
>                                                            ^^^^^^^^
> interface?

I did indeed mean "interest" (as in, "I'm interested in notification")
but I agree, it's awkward phrasing. I rewrote it.


> Except that, looks good to me.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks!


> Zhu Yanjun
> 
>> the underlying device when accepting a connection. However
>> svc_rdma_free() is not invoked if svc_rdma_accept() fails. There
>> needs to be a matching "unregister" in that case; otherwise the
>> device cannot be removed.
>>
>> Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM
>> event handler")
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/
>> xprtrdma/svc_rdma_transport.c
>> index aca8bdf65d72..5940a56023d1 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -575,6 +575,7 @@ static struct svc_xprt *svc_rdma_accept(struct
>> svc_xprt *xprt)
>>       if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
>>           ib_destroy_qp(newxprt->sc_qp);
>>       rdma_destroy_id(newxprt->sc_cm_id);
>> +    rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
>>       /* This call to put will destroy the transport */
>>       svc_xprt_put(&newxprt->sc_xprt);
>>       return NULL;
> 


-- 
Chuck Lever

