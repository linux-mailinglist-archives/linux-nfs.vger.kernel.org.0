Return-Path: <linux-nfs+bounces-17299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105ACDD05B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA41A3009A9B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C352C030E;
	Wed, 24 Dec 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYMpBQcZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A225F7A5
	for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766603408; cv=none; b=dyDBhUOq9FQW1wboVogoyikTZ7HRhcCrhPRwGN95iihWUbkExzwQbQl7YEscZ5+iKYi+aWx4N9LduX40lneCOZPt0QtprfWRwrWV+k2isgdc9l5nyNpbARezdP0J0hkvmSRgizOOHtjw1jOh1B62jOUX7fQuFJ1rkpXipjZY6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766603408; c=relaxed/simple;
	bh=OZj4wyhPB3tvmTrXQ3BvFiyCvxQgJ3qLgNoA8UIle8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsvw0KZz77nOjtq5C1FyumuUZxgUyXAZLDBVnic0Z6L1YGuXpjXu+wS7BtJ8TTz0QjovuKoA1c1bIQx3qhGoJ1pRfqaDEfMf8jSykpxs0mrRK7CPLeSA+dbH3GVDrzqbwtx+t2yl83Pq8YBJvSKodN5o4Q82JWo5+toWR7md5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYMpBQcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB86C4CEF7;
	Wed, 24 Dec 2025 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766603408;
	bh=OZj4wyhPB3tvmTrXQ3BvFiyCvxQgJ3qLgNoA8UIle8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rYMpBQcZ34iDmC/CDu07eKOHvOIXBIFSn6XaPZbKNojhk7T7g0IZOoqdlAFIMuJch
	 NUT2+h5hWmxWWWqMXHvlUdwILuzTqfP0v0Da1Mu/fUgc6aPnlQCExDv4AXWyllJOmp
	 FcTkqpZG8XoBihDvvZ0h2lJlFSkNoVSjpLZR3aXquHm9DnB/9ue4oa3zhKMHeWS4lB
	 Nxmjiu9ADxTF2WrFBbF/AQ6V+nMEsbDryp5q9SRQC4BDnzBgLbFHzLU7u7wajqxNLw
	 J5paSBBBXHWcAyEtBB+OLzaq/USSnZSKGM2o6ARh3BiyoTWhV15Kt8L8mrE/xeRpq5
	 1vCisLLlfk6tg==
Message-ID: <2b5a99aa-6bd6-478c-b734-82ea9d440ecd@kernel.org>
Date: Wed, 24 Dec 2025 14:10:06 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
 Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
 <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
 <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
 <3bf448ee-7e1e-4ed8-93a7-2754084885c5@oracle.com>
 <492c5f62-e11e-4601-83f6-31aff5f5802f@app.fastmail.com>
 <0bc92d15-09cd-481f-8874-8dcc5a7b9d39@oracle.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <0bc92d15-09cd-481f-8874-8dcc5a7b9d39@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/24/25 12:52 PM, Dai Ngo wrote:
> 
> On 12/24/25 6:57 AM, Chuck Lever wrote:
>>
>> On Tue, Dec 23, 2025, at 5:34 PM, Dai Ngo wrote:
>>> On 12/23/25 11:47 AM, Chuck Lever wrote:
>>>> On Tue, Dec 23, 2025, at 1:54 PM, Dai Ngo wrote:

>>>>>> Another question is: Can cl_fenced_devs grow without bounds?
>>>>> I think it has the same limitation for any xarray. The hard limit
>>>>> is the availability of memory in the system.
>>>> My question isn't about how much can any xarray hold, it's how
>>>> much will NFSD ask /cl_fenced_devs/ to hold. IIUC, the upper
>>>> bound for each nfs4_client's cl_fenced_devs will be the number
>>>> of exported block devices, and no more than that.
>>>>
>>>> I want to avoid a potential denial of service vector -- NFSD
>>>> should not be able to create an unlimited number of items
>>>> in cl_fenced_devs... but sounds like there is a natural limit.
>>> Oh I see. I did not even think about this DOS since I think this
>>> is under the control of the admin on NFSD and a sane admin would
>>> not configure a massive amount of exported block devices.
>> Ultimately, the upper bound on the number entries in cl_fenced_devs
>> is indeed under the control of the NFS server administrator,
>> indirectly. But looking only at the code in the patch:
>>
>>   - New entries are created in cl_fenced_devs via GETDEVICEINFO,
>>     a client (remote host) action
>>   - There's nothing that removes these entries over time
> 
> I don't understand why these entries need to be removed over time.

They don't need to be removed over time. I'm saying you should document
the assumptions better -- that NFSD indirectly enforces a limit on the
number of items in this xarray. That isn't clear if a reviewer is
looking only at the code in nfsd4_block_get_device_info_scsi.


> These entries are created only when the clients accessing NFS exports
> that use pNFS SCSI layout. So long as the clients still mount these
> exports, don't we need to keep these entries around?
> 
>>
>> The duplicate checking logic needs to ensure that client actions
>> cannot create more entries than that upper bound.
> 
> How can this happens? repeated GETDEVICEINFO ops of the same device
> still use the same entry so how do the clients can indirectly create
> more entries than the number of pNFS exports?

It can happen if a race occurs, for example. A broken or malicious
client could send two concurrent GETDEVICEINFO operations for the same
device. If the new code isn't careful, it could unintentionally add two
copies of the device to that array due to that race.

What I'm saying is that this needs to be documented: why does the
addition of the device to cl_fenced_devs need to be atomic? Because
if it isn't, a race could allow an errant client to add extra devices
to cl_fenced_devs over time. That could cause cl_fenced_devs to grow
without bound.


-- 
Chuck Lever

