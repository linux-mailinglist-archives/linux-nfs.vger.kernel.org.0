Return-Path: <linux-nfs+bounces-17288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D758CDA6D6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B712305D9B0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA72F9984;
	Tue, 23 Dec 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPXJpxG1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA82EB5A9
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519294; cv=none; b=L3ndPrJgri1FBjXnSv6s8WuCxWxmf/+kOgBQ1VeOOrRMk4E106RTIVdy9/IA6NH0WoCxVmh3PB752yVxYTa0yvCt3wG7CR/ZEaL/4Ye+Jmoj+CnMcgzGC/nLrxbhz1fqPfyxH1fs99np9MorOPm9yoUrlB5AnQ6imjyjvTcvGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519294; c=relaxed/simple;
	bh=I53gyTaePCf6S1jOkGTOCr2K3hj8YGxS/GVWcvVyg7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NMHjzW30xwHV0EFRkt7970gSCPaSs5iyFJHqUhnzcKRAIvd6MNDjitT6HFUz7QHdI3bhpX9CfHeLN0a8/Gm7N10dfwZrs+FwCX39lsiCuxotUSEqj0kRqQm+xdKKCgCjQ2gJLKEMkpajJ6frxPzPtTtdx6qwQlKvj+UDhKb8JXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPXJpxG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7B9C116B1
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766519294;
	bh=I53gyTaePCf6S1jOkGTOCr2K3hj8YGxS/GVWcvVyg7M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sPXJpxG1ytCNnrQQdctRC3AovEILU7YZ8bKLa7C+UEkDxRbbGrjNU2EHgOHxPA+co
	 SidYFEBPBT/gW5Tkmecvyk38/TwYB6CCn1whpOcAzLISgQ0XqAR1MCYUj8gNYfehCm
	 1uEdGzHJMYiB6pfqqhCcdv3BdU9KCei0JTDrc9NpKFGouohVYPiAWUoJpWYtg5Sf/L
	 cZ0J4JC5rTmWjXwsC3DId/YY1NqMVkWY4mdfsgScMYu7WVPMxcAqigOdDrpHERnQk8
	 p2FW70OrGbfVQHl6eTIlZ4q7PeqVTgrbkogU1WMzzBT/VDCg9PKnFFb6091Kjy//ux
	 /NR+TeloacQxA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 179B2F40068;
	Tue, 23 Dec 2025 14:48:13 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 23 Dec 2025 14:48:13 -0500
X-ME-Sender: <xms:_fFKaZBZSZG2ACyR5plaSSmRXwDt-3qRkvNSNcKjIUaQ5mTbIQjEvA>
    <xme:_fFKaSVWAQ_OcyzOA-wdga2cw3SdCrxQrfmiBFQMSSZjDdFhhfMbc_hVwRlyWjb4X
    s1dP2D9I32zOc-Ml-rCpz4wcxVN9Uwivtd_qsn2C51s_azd0dan4eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlsh
    htrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehnvg
    hilhgssehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_fFKabWgoytfv0hl2Ueb-HBFwfZ4axr5Y0pbGVqnFMYF9ORI-3TMgw>
    <xmx:_fFKadko0yi6FhtYwqAe5-jVVHqWVM5UGSMRijlzXW-IGqWn8yDwEQ>
    <xmx:_fFKaeDo5RZOG5b_Z2LCQulzit406i8NpS-k1iNiwhsdeVn8rqPS8A>
    <xmx:_fFKaUhlVR5FaYuDQWB0A2ZnnBenDVHRjJovCUbIhq0tw_NND8Nruw>
    <xmx:_fFKaTwgfvQtgIPq2V3nW48rB0oo7uS1xVrzfUyz40YdBTwKEzqrlLpa>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6645780054; Tue, 23 Dec 2025 14:48:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqDldx0SSSOk
Date: Tue, 23 Dec 2025 14:47:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
In-Reply-To: <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
 <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 23, 2025, at 1:54 PM, Dai Ngo wrote:
> On 12/23/25 8:31 AM, Chuck Lever wrote:
>>
>> On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:

>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index b052c1effdc5..8dd6f82e57de 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>>
>>>   	struct nfsd4_cb_recall_any	*cl_ra;
>>>   	time64_t		cl_ra_time;
>>> +
>>> +	struct xarray		cl_fenced_devs;
>>>   };
>>>
>>>   /* struct nfs4_client_reset
>>> -- 
>>> 2.47.3
>> Another question is: Can cl_fenced_devs grow without bounds?
>
> I think it has the same limitation for any xarray. The hard limit
> is the availability of memory in the system.

My question isn't about how much can any xarray hold, it's how
much will NFSD ask /cl_fenced_devs/ to hold. IIUC, the upper
bound for each nfs4_client's cl_fenced_devs will be the number
of exported block devices, and no more than that.

I want to avoid a potential denial of service vector -- NFSD
should not be able to create an unlimited number of items
in cl_fenced_devs... but sounds like there is a natural limit.


-- 
Chuck Lever

