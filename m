Return-Path: <linux-nfs+bounces-17586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14451D00767
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 01:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A174B301C900
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82319A2A3;
	Thu,  8 Jan 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOG83wiP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A9199FB0
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832010; cv=none; b=hDckWkYD0DyAWKBNLQ5XGhhXQ6CroXfjNTLXQYXwc0TwUbtqaHbhHqhC3DFfBme90NpwMk2WAK0LI5HWAb0YTB5YMp7Tp8Fu1sFKNIxi/dqHkawxQCo378DOnPsxBjdtRF56ilAPEKh3/PotR0C9XXtjqpXyzT2dqMufB7mwCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832010; c=relaxed/simple;
	bh=FMm6znQEgmQsGoE7OEJXQvl+VcGJ4oanpicJW4OIflA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B3KUhTXgwt38LsatNLz4XuDdW2Z6+Ogx6gAekvroo/lEshWmmbM3ulwcs7Sn2IzKENgn1hWrfB8e1v06el+OLeu1W3O3R45/vGbmp9IcqZYOAbavbr/iZv5DlSKR4Olnl/uT4CzCpdtrfdYxsNB/nYgBJQweXRP8UlBxLBPqfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOG83wiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF99C19421
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 00:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832008;
	bh=FMm6znQEgmQsGoE7OEJXQvl+VcGJ4oanpicJW4OIflA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AOG83wiPXa9+3Nvmnr0OwtTVd1/yOd1deWw297NGThMYnZ9ZJhmtGkn94JSiWOQ91
	 YpWh+Qyh/O8Gp3oBOgUB1fsY9hT/3JmTAmj6Hs8+6ZQjDEr+v8qochujd3y0P2TuPn
	 L7HMR5COiF0pWTk0wZznMtWukm+mScQC+/XUTpUnQah6C8ZHL/HzQDw/1EfvHC34XI
	 FbRhXUh0YbSDEQTB3vTcCFITC6BJB7DVaCFJVhi+E2M5xhB5WRnP9sztqewH8ag4Cy
	 fQsjs/YCVL1Y9V2wOR0VcqqGBvENnJLqBXlAL1NCfeC3RYntFtjweIn1AP3ioxkz/Z
	 iXOgPCWNqVoXg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C1131F40069;
	Wed,  7 Jan 2026 19:26:47 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 07 Jan 2026 19:26:47 -0500
X-ME-Sender: <xms:x_leaUSUnzI3QVTe2AmU9XaTfS_Fy6K06VOSk_pR8bncrExOveYOPA>
    <xme:x_leackMZm_aIG1R3829WcZPeCKpVVRQoTlnVF1LGxxSnsbehdtlj6uqDY6kHkkUG
    soJKCKy7gZJPQ7559_6Sb_X7uIRIJDcZ4Dn3wwgBoxSNO8YV6YPUCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllhihse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepnhgvihhlsgesohifnhhmrghilhdrnhgvthdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x_leaalB8VgO4UDk3YamtHQJPsIv1KLDTicXzjTihj6etHsa8Xp10Q>
    <xmx:x_leab3oayo0_RMnDJ1VzsLAR0daQhbAHLe6YKLUygqpOIJS1g6ULA>
    <xmx:x_leafR0hp8vrT4V2xzVbFHGiHylPTPaap4-JfXboLIL3zz407MHjw>
    <xmx:x_leacwB-wJUMYKKSLszClR6oUUkuMuW2X3pk24Xpi5DB5BY-Nzv2Q>
    <xmx:x_leaXBcUNs1PHWCW4Pj7fdXkDWfYdkbnm0LvInvMFjRjyZ5xIyvjXKR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A1756780054; Wed,  7 Jan 2026 19:26:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJTYT3n31L2N
Date: Wed, 07 Jan 2026 19:26:26 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-Id: <9e127bfa-e4c9-4e06-b5ad-bb375e7d8e2b@app.fastmail.com>
In-Reply-To: <aV6HHwrkoR4OE5qc@infradead.org>
References: <20251227042437.671409-1-cel@kernel.org>
 <aV6HHwrkoR4OE5qc@infradead.org>
Subject: Re: [PATCH v5] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 7, 2026, at 11:17 AM, Christoph Hellwig wrote:
> On Fri, Dec 26, 2025 at 11:24:37PM -0500, Chuck Lever wrote:
>
>> @@ -342,6 +343,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>>  		goto out_free_dev;
>>  	}
>>  
>> +	/*
>> +	 * xa_store() is idempotent -- the device is added exactly once
>> +	 * to a client's cl_dev_fences no matter how many times
>> +	 * nfsd4_block_get_device_info_scsi() is invoked. This prevents
>> +	 * adding more entries to cl_dev_fences than there are devices on
>> +	 * the server. XA_MARK_0 tracks whether the device has been fenced.
>> +	 */
>
> Only in the most abstract way, xa_store actually stores the new
> entry/value and returns the old one.  In other words, this does
> quite a bit of work for the non-initial GETDEVICEINFO.

The comment is misleading then, and should be clarified.

But should the code use xa_insert instead of xa_store ?


-- 
Chuck Lever

