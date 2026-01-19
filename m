Return-Path: <linux-nfs+bounces-18102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE40D3AC5F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6582230ECC02
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7770368261;
	Mon, 19 Jan 2026 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e26y7ZEk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E21236437
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833260; cv=none; b=KwZBDCDQ9tCfJ1RxdX8pcMbyM/o92og1j9LJqv5Lvvza9bGlLEa+WXyBuh2pnFATI0TA2abeSlHDjwMIpSgsk5Lza+3jLDFqbCP/78qIHT4bqoP/9pAvdC3JH1EzA0gcnNnfLStHgiih9UWBbSm4TOa6+ywt9na9VtGwjZ31TRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833260; c=relaxed/simple;
	bh=8+5iUEYeFhSztZbbFhuKqGIp/F2DMLTZ4Vuh+kLqvrg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PAxmVE2jpAqDgkfPPfK/MgvrSFczL6yYC8qH03Bg48xbBncehu8AYRAkIJkKil3fXR87LJFrUcub53cBMlgrnERwgiUxoL2l+K47cXMjjjPqjDsRsovBi+g4P8nhTbiVz26rQ88s7aTYlcrxAY9IcrZNVIa7rYDR5W43MjqHwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e26y7ZEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE0C19423;
	Mon, 19 Jan 2026 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833260;
	bh=8+5iUEYeFhSztZbbFhuKqGIp/F2DMLTZ4Vuh+kLqvrg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=e26y7ZEkIuM5p4CtATMhNi6pPLEx5PlaSV84tpfXkpkSrnbjl5wmbzgGefr2dDR/3
	 cysG9WbTf98HUB4/VguEadDeUKrltK9JQiok0RgH8r1OTT8Q5Vxvcf10BJWvgY/VlD
	 5rlq2XqAr0QPHMHWxrwg5/zMxx+lgsCJ/3TkpFtrFW2Mj4OgZIRrDqsj8bFOil2FLZ
	 TVJpsunm4hbOpEYt/sBh7R17+65SuFx8h6vykKakoQ4H1BRvqRPCR6LsVCpc7tgNOh
	 Tq68AorZNdfdlNaMyqaS+lNH0A6VbAl+QOkea4vM+WE7VK3erkfg491XK9+rOhtBtR
	 xFFYtqmDOR9GA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 420B7F40073;
	Mon, 19 Jan 2026 09:34:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 19 Jan 2026 09:34:19 -0500
X-ME-Sender: <xms:60BuafIDzO9Se4DM6n7uvkQ4XEy9CViuOi1f8CGWb7VpbNial8mbXQ>
    <xme:60Buad_tD8CS5xX-KKcvUfa4f5224jmmYCe8zLGe6yQADb8mSyv9DFMFK_UaacNPM
    xJbDDVG-6nIOAG0FZ5kYDxHu_h1GbcBxhtFCzJFy7jCO5wE154FAgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegurghirdhngh
    hosehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:60BuaTn-ZoIUx8cXb7xzgMLjfI9BttlRdWcrlj32oJ494N4SFn7Teg>
    <xmx:60Buaen3l8G6bN7GypQw-osjGNTC2INs5J9b13E_oOwDnabijh9cmQ>
    <xmx:60BuactfnfkxvVoDHXK2ss99_CjFqxbc63JoACG3wkz75EpJ8eV7Zw>
    <xmx:60BuaZmsxw_0ni38plV86gEjNgBl_qp3VVYn_fXr4qiAEcNgS-wz-g>
    <xmx:60Buafv89FWPnQsIOJ2k_koPFf-rA_iMTXF5p_5RhpayPGEAVzHpHRXl>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 243DC780070; Mon, 19 Jan 2026 09:34:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ari2zWJUXQbN
Date: Mon, 19 Jan 2026 09:33:37 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>, "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <453f0d57-5230-432e-90c3-df0308f7fddd@app.fastmail.com>
In-Reply-To: <aW3jGVAHrEusJyBk@infradead.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
 <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
 <aW3jGVAHrEusJyBk@infradead.org>
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Jan 19, 2026, at 2:54 AM, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 11:04:55PM -0800, Dai Ngo wrote:
>>         ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>>                         XA_ZERO_ENTRY, GFP_KERNEL);
>> -       if (ret < 0 && ret != -EBUSY)
>> +       if (ret == -EBUSY)
>> +               xa_clear_mark(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>> +                               XA_MARK_0);
>> +       else if (ret < 0)
>>                 goto out_free_dev;
>
> This looks reasonable.  But looking at this, I think it would really help
> to add a named constant for XA_MARK_0 to make it more clear what the
> bit stands for,

Sure, that idea has been in and out of my private working copies
of this patch. I'll add it.


> and maybe even add little inline helpers for
> setting/clearing the mark.

In the past you've actively hated "adding little inline helpers"
so I don't suggest that any more. But I actually prefer that.


-- 
Chuck Lever

