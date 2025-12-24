Return-Path: <linux-nfs+bounces-17295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB1CDC9DB
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 16:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B48A3055B92
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C933B974;
	Wed, 24 Dec 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXidrZ5L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351F3358AA
	for <linux-nfs@vger.kernel.org>; Wed, 24 Dec 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766588287; cv=none; b=KGisQe/qzI90OoIRzFL7ixBMF+kusTCVrWYjWtqpoXKEcn3/3ubafCrE7DC6GZXTZORe7JogAomOggW+PYma/RYaylOzgKD8O/nK+1bswI8INM+7XHBOs5ikLN7gs/fkIyGNwGOa98ny8g2S9CBIKKLeOepBt98OLM7u8tcvdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766588287; c=relaxed/simple;
	bh=qncIo3RkalqF7BvPvpSWz6IlF3VLGbCpIm+aIdvB7gk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tp8+SisFSHCnPRTfdOpVvtJRWsmPxBe4ryJ7LzKV7L63WtLcB+sWUoSDtY7WF3QsXLV9fi+jczAdoUB7cjjjHHlGa6d8oH2aTUqvcpfehRIBE2k4S+uaFgq3LZTADMpQhgWRzo+U8kifm/L54ufsGsG+sDB197Hsubei6oEzOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXidrZ5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C38C4AF0B;
	Wed, 24 Dec 2025 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766588287;
	bh=qncIo3RkalqF7BvPvpSWz6IlF3VLGbCpIm+aIdvB7gk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XXidrZ5LOiLSYpz/4LToWXMsccrOeXSx6Ew4cbHTCXtQBNhFAD0/g7jUdy4m4NcpL
	 8oKWOEuLGrX2JBK2/T1xJodH3W25+P2SAh0RLbnBZn6Fq8VrLgqXHIyAfmzcE6gEc4
	 0v9YAsG1BnGu6quXBAmbbM2bNLePx9G4uwKmJ2bat6+ndLCOInn8nruY5A8TyuZlyy
	 rZPOQgMRmTN2mD0hJsy1M+GfUZyGB4ukhGXa9U33tm04Gt3JgznUk7B9b9YU1YQuDO
	 YCGTWYPR6IYc6fnQ6QOELKArLwwIl8ScHyeJR5xAObRJVrlRlzQ2K29ib5oqkQ/9k9
	 /F7SAMJ+ix29g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8220BF40069;
	Wed, 24 Dec 2025 09:58:05 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 24 Dec 2025 09:58:05 -0500
X-ME-Sender: <xms:ff9LaeRYoa1FAXf7oo9QRARijxz0DVXZPx5DngH1k5eGh4qlPdwQGQ>
    <xme:ff9LaemETmk7jvu-mXyNvNBKOhUg-VFqqOYKKd4jNS3zTK-W_xdACbyEtzKYzxy24
    BvPskRM-s1A18nHt05N0ey6dtfRGRl7hmP1SHEmbcAqiVItARrxbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeifedttdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ff9LaUloT4D4kYh9HU9dSArxXIWJKmdWdr681be76t8jUASEcUPeVw>
    <xmx:ff9Lad0att_t-49-SBPglN379JWeEh3LTl1IuOYqYZWgk8RuaGxaxA>
    <xmx:ff9LaZSMpm4SpRqq1-oSGY0g2ITDyYQsG6E7bcsOnNlEaGUtcmk07A>
    <xmx:ff9LaezQXpCf5cpJ_B1ulMqhJ6FoSJKaRPQ8FOGRODy47NibduSiUw>
    <xmx:ff9LaRBNZmxtWtLomf9-1jvrIFMLOAb2qs-k4nVVpszEl6ElWOYfHVnQ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 612BD78006C; Wed, 24 Dec 2025 09:58:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqDldx0SSSOk
Date: Wed, 24 Dec 2025 09:57:37 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <492c5f62-e11e-4601-83f6-31aff5f5802f@app.fastmail.com>
In-Reply-To: <3bf448ee-7e1e-4ed8-93a7-2754084885c5@oracle.com>
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
 <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
 <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
 <3bf448ee-7e1e-4ed8-93a7-2754084885c5@oracle.com>
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 23, 2025, at 5:34 PM, Dai Ngo wrote:
> On 12/23/25 11:47 AM, Chuck Lever wrote:
>>
>> On Tue, Dec 23, 2025, at 1:54 PM, Dai Ngo wrote:
>>> On 12/23/25 8:31 AM, Chuck Lever wrote:
>>>> On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:
>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>> index b052c1effdc5..8dd6f82e57de 100644
>>>>> --- a/fs/nfsd/state.h
>>>>> +++ b/fs/nfsd/state.h
>>>>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>>>>
>>>>>    	struct nfsd4_cb_recall_any	*cl_ra;
>>>>>    	time64_t		cl_ra_time;
>>>>> +
>>>>> +	struct xarray		cl_fenced_devs;
>>>>>    };
>>>>>
>>>>>    /* struct nfs4_client_reset
>>>>> -- 
>>>>> 2.47.3
>>>> Another question is: Can cl_fenced_devs grow without bounds?
>>> I think it has the same limitation for any xarray. The hard limit
>>> is the availability of memory in the system.
>> My question isn't about how much can any xarray hold, it's how
>> much will NFSD ask /cl_fenced_devs/ to hold. IIUC, the upper
>> bound for each nfs4_client's cl_fenced_devs will be the number
>> of exported block devices, and no more than that.
>>
>> I want to avoid a potential denial of service vector -- NFSD
>> should not be able to create an unlimited number of items
>> in cl_fenced_devs... but sounds like there is a natural limit.
>
> Oh I see. I did not even think about this DOS since I think this
> is under the control of the admin on NFSD and a sane admin would
> not configure a massive amount of exported block devices.

Ultimately, the upper bound on the number entries in cl_fenced_devs
is indeed under the control of the NFS server administrator,
indirectly. But looking only at the code in the patch:

 - New entries are created in cl_fenced_devs via GETDEVICEINFO,
   a client (remote host) action
 - There's nothing that removes these entries over time

The duplicate checking logic needs to ensure that client actions
cannot create more entries than that upper bound.

I think the structure of the new code is good, but maybe the
kdoc comment for nfsd4_block_get_device_info_scsi() should
underscore that it does not allow more cl_fenced_dev entries to
be created for an nfs4_client than there are exported pNFS SCSI
devices.


-- 
Chuck Lever

