Return-Path: <linux-nfs+bounces-13570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BEB21AF6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 04:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E8417A71F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69520F07C;
	Tue, 12 Aug 2025 02:51:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4199238C29;
	Tue, 12 Aug 2025 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967066; cv=none; b=qRM+lJ9g6tKcE0XQr8lIikDSfecntN/AZIBsLtrqKXR87QdKcfatWN48J0TkM8mKqc9cs5DPjQF0BmTqnLZ9aGQMUH/1hJAYffW6wlLPLDa3l4N4jc6HN1WpaqCBR/bvw5ph9Z7WdlSJAETTf9q8rGC1el2HV+cbVB8R1zQsxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967066; c=relaxed/simple;
	bh=KzYgw6DTcWrodFe56aqk0/vl+6VTXoC11buJ9/aerzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XaCukKRPs3oMfsdUMj4iord1J6VYjI9SHVhTyly0fkM3YhQchsvg0Y3HcJWhAE7q8UaQkBEZxM+sk0TvruUuAp00RMS9GOyIFvZ6RraGvX8KORote3+jeOe+odKjjvDzt43osV22svVJtpgjCSEmPTeo4Ldo+rEfG6rOzDRjkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1G8p5KtJz14Ls1;
	Tue, 12 Aug 2025 10:46:02 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B3E2180B66;
	Tue, 12 Aug 2025 10:51:01 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 10:51:00 +0800
Message-ID: <c4ca147e-59cd-4b41-a1db-93637a632534@huawei.com>
Date: Tue, 12 Aug 2025 10:51:00 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]nfs: never returned delegation
To: Trond Myklebust <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemp200004.china.huawei.com (7.202.195.99)

On 2025/8/11 21:03, Trond Myklebust wrote:
> On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
>> Recently, we meet a NFS problem in 5.10. There are so many
>> test_state_id request after a non-privilaged request in tcpdump
>> result. There are 40w+ delegations in client (I read the delegation
>> list from /proc/kcore).
>> Firstly, I think state manager cost a lot in
>> nfs_server_reap_expired_delegations. But I see they are all in
>> NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I
>> read this from /proc/kcore too). 
>> I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure
>> meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and
>> never return it again. NFS server will keep the revoked delegation in
>> clp->cl_revoked forever. This will result in following sequence
>> response with RECALLABLE_STATE_REVOKED flag. Client will send
>> test_state_id request for all non-revoked delegation.
>> This can only be solved by restarting NFS server.
>> I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not
>> the only case that cause lots of non-terminable test_state_id
>> requests after any non-privilaged request. 
>> Wish NFS experts give some advices on this problem.
>>
> 
> You have the following options:
> 
>    1. Don't ever use "soft" or "softerr" on the NFS client.
>    2. Reboot your server every now and again.
>    3. Change the server code to not bother caching revoked state. Doing
>       so is rather pointless, since there is nothing a client can do
>       differently when presented with NFS4ERR_DELEG_REVOKED vs.
>       NFS4ERR_BAD_STATEID.
>    4. Change the server code to garbage collect revoked stateids after
>       a while.
> 
>

Thanks a lot for reply.

NFS client meet TIMEOUT in return-delegation procedure may not be the
only case that server keep delegation in clp->cl_revoked list forever.
I think garbaging collecting revoked stateid after a while (4) is more
reasonable way to avoid this problem。


