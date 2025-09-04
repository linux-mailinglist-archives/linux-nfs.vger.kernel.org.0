Return-Path: <linux-nfs+bounces-14037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91607B440F5
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDED7A8BC6
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAFA21ADCB;
	Thu,  4 Sep 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0k9kCVu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680B212574
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000931; cv=none; b=C3vuCKNNTtz5SmG8Z2K4Gjloi+pBs7NTyXOTO+FRJcapnf4xv1xo63lZvFqJjyPkIYMnCZ6FqqhKJTM6QQbi0kKquNgAiIL8WSewJejXsG3ylexfiUolfRf4R1DAH/i2H1mVYZh5B/MnObQ6+BMaT9RJ8bHbwjs0qHVAFzD027Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000931; c=relaxed/simple;
	bh=ENooL2OkVILF35RWwSSyWg+hNg39tYRWzgazZe2shsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKNZVRZ3v3v3iOQtOo44U1Y1blthjJUXqvhRfo98dM5VyL1OKJCJ54nYi5r3cVh3/WnKYKQgFGEVoSj4tcyvM1RVq7wdX7tS+6S68cFjMPVkTmRJifi1czzjzt0xAcypmhG8jpl/rdgFAslxvmP9Pj47/Shz+PdXaWusg7+fFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0k9kCVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC84C4CEF0;
	Thu,  4 Sep 2025 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757000931;
	bh=ENooL2OkVILF35RWwSSyWg+hNg39tYRWzgazZe2shsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d0k9kCVus8Y31wttXynaJ0Zjkvlr/EyuAybYRzOGs4bGZWNWHiGzaNMiAx2xKrX9/
	 S++q4O2NVBzndYhkcqNyVvZzykAYgJtu7i4Lse4eW+Pu26Bqyy/yT+1Za1Y1Lyz8cS
	 /A1g8sbVUmHbB1gOl7JFE/PJLav+Bsi56VHBmdg2+DHU9qNG6BHoO0l0r+cHtC/NAy
	 n5oHKTiAJCSsrQ9W7JAyoMUIonl34OLp1s6pZ18G8Pq6XTCsI7yEPlua4vlEAtTaoo
	 6LAmo+JTEifYAasEwvfY7AQ0qetwukW6SF8ZRHqjyH0JMKNswv+0GH2u3A61ICX/Gd
	 mkTvqAN9I3jdA==
Message-ID: <5a1f9a16-2373-4e30-b356-42e3af047126@kernel.org>
Date: Thu, 4 Sep 2025 11:48:49 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] svcrdma: Release transport resources synchronously
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250903155335.1558-1-cel@kernel.org>
 <CACSpFtB7CSkakYL5FZj_6L4dgj2ybBMVzgqX8kWhZrGBW0GT7Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CACSpFtB7CSkakYL5FZj_6L4dgj2ybBMVzgqX8kWhZrGBW0GT7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 11:43 AM, Olga Kornievskaia wrote:
> On Wed, Sep 3, 2025 at 11:53 AM Chuck Lever <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> NFSD has always supported added network listeners. The new netlink
>> protocol now enables the removal of listeners.
>>
>> Olga noticed that if an RDMA listener is removed and immediately
>> re-added, the deferred __svc_rdma_free() function might not have
>> run yet, so some or all of the old listener's RDMA resources
>> linger, which prevents a new listener on the same address from
>> being created.
> 
> Does this mean that you prefer to go the way of rdma synchronous
> release vs the patch I posted?

We could do both. IMO we need to make "remove listener" work while
there are still nfsd threads running, and this RFC patch does
nothing about that.

But as noted below, it looks like the svc_xprt_free() code path assumes
that ->xpo_free releases all transport resources synchronously, and
there can be consequences if that does not happen. That needs to be
addressed somehow.


> I'm not against the approach as I have previously noted it as an
> alternative which I tested and it also solves the problem. But I still
> dont grasp the consequence of making svc_rdma_free() synchronous,
> especially for active transports (not listening sockets).

I've tested the synchronous approach a little, there didn't seem to
be a problem with it. But I agree, the certainty level is not as
high as it ought to be.


>> Also, svc_xprt_free() does a module_put() just after calling
>> ->xpo_free(). That means if there is deferred work going on, the
>> module could be unloaded before that work is even started,
>> resulting in a UAF.
>>
>> Neil asks:
>>> What particular part of __svc_rdma_free() needs to run in order for a
>>> subsequent registration to succeed?
>>> Can that bit be run directory from svc_rdma_free() rather than be
>>> delayed?
>>> (I know almost nothing about rdma so forgive me if the answers to these
>>> questions seems obvious)
>>
>> The reasons I can recall are:
>>
>>  - Some of the transport tear-down work can sleep
>>  - Releasing a cm_id is tricky and can deadlock
>>
>> We might be able to mitigate the second issue with judicious
>> application of transport reference counting.
>>
>> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
>> Suggested-by: NeilBrown <neil@brown.name>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/svc_xprt.c                    |  1 +
>>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 19 ++++++++-----------
>>  2 files changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 8b1837228799..8526bfc3ab20 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -168,6 +168,7 @@ static void svc_xprt_free(struct kref *kref)
>>         struct svc_xprt *xprt =
>>                 container_of(kref, struct svc_xprt, xpt_ref);
>>         struct module *owner = xprt->xpt_class->xcl_owner;
>> +
>>         if (test_bit(XPT_CACHE_AUTH, &xprt->xpt_flags))
>>                 svcauth_unix_info_release(xprt);
>>         put_cred(xprt->xpt_cred);
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 3d7f1413df02..b7b318ad25c4 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -591,12 +591,18 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
>>         rdma_disconnect(rdma->sc_cm_id);
>>  }
>>
>> -static void __svc_rdma_free(struct work_struct *work)
>> +/**
>> + * svc_rdma_free - Release class-specific transport resources
>> + * @xprt: Generic svc transport object
>> + */
>> +static void svc_rdma_free(struct svc_xprt *xprt)
>>  {
>>         struct svcxprt_rdma *rdma =
>> -               container_of(work, struct svcxprt_rdma, sc_work);
>> +               container_of(xprt, struct svcxprt_rdma, sc_xprt);
>>         struct ib_device *device = rdma->sc_cm_id->device;
>>
>> +       might_sleep();
>> +
>>         /* This blocks until the Completion Queues are empty */
>>         if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
>>                 ib_drain_qp(rdma->sc_qp);
>> @@ -629,15 +635,6 @@ static void __svc_rdma_free(struct work_struct *work)
>>         kfree(rdma);
>>  }
>>
>> -static void svc_rdma_free(struct svc_xprt *xprt)
>> -{
>> -       struct svcxprt_rdma *rdma =
>> -               container_of(xprt, struct svcxprt_rdma, sc_xprt);
>> -
>> -       INIT_WORK(&rdma->sc_work, __svc_rdma_free);
>> -       schedule_work(&rdma->sc_work);
>> -}
>> -
>>  static int svc_rdma_has_wspace(struct svc_xprt *xprt)
>>  {
>>         struct svcxprt_rdma *rdma =
>> --
>> 2.50.0
>>
> 


-- 
Chuck Lever

