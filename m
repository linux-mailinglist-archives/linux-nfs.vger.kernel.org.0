Return-Path: <linux-nfs+bounces-18077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE565D38FDB
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFABD300F723
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299761B87C9;
	Sat, 17 Jan 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwBYfHXt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061699475
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668763; cv=none; b=jG2eJqfYqPKuhrnT9aK7/2LtpT6kUS0QP8OHw10+78y/oINCKOwm1tjkdaEOdZRHmBpNOxLAg1ZKlKXKL+briSCSWbVPuCOZcYfBcNnYCMiHt5iQoVegmaHeCOpsX03dkgdDHOe+PvR16m5njgbZ9OwLMRk9Tmolfrc9lE+8syQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668763; c=relaxed/simple;
	bh=kqoAKtluHny7FyQIw8O3bBXYi24J5mY2o4zwU4vLQ50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=itLVgfMeKqTr1lZwYTAFotx9H460rvAvh8y0kfjFraVDL91hOY1jMMpOBMJ91NSt0SQXYy9DvlKxRUjmYgcXYyw4VIPp+vi47Pzi/fKW9xDhIYqfGH9RXhnKglli/btZPZB2ibbBc7EG4yKaxGZPekPK2m/mkI9/eNcXEKFzx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwBYfHXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73629C19422
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768668762;
	bh=kqoAKtluHny7FyQIw8O3bBXYi24J5mY2o4zwU4vLQ50=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lwBYfHXtiy1jXqn2sUiPbNQ8aWG6Z37aUXr9N10ZgddeqWgwY2fLwvEIWslGINq/7
	 QQn54jQR9//7OmXtMvwKy+dMuiEM8gjkQDLQbhFGpw3RoTlu8e/oeVcg63RxDhCMFl
	 gCb5ZEC8dk7ix7Z7SHZqsZz2/rD4zTlq2XQG235TbGsNRll54gx3b2caVFy8jbrcfJ
	 s80y5xXy7PVZ8hnt6WN9TQIDbGMV/pKVPx+wn5Yq35PlBPDQKVwYVjkNLUi7lqhL1w
	 AYV3EnMZFVWt9HlnNy7477TL5+eSNe6gdfXGhc36icRJY7VIglicpdiq6MYQpoPL81
	 6ksn85ygstryQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5EC3AF40074;
	Sat, 17 Jan 2026 11:52:41 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 17 Jan 2026 11:52:41 -0500
X-ME-Sender: <xms:Wb5raaDqmsZFH07x8USCWoQF0WKxYDFNbuehA6cVuD6SEP5DMHzk_w>
    <xme:Wb5rafV50KXTKdL4PS5o1k4ctjex2goRn1wVezipt_hG0HQUbLCeD4y4I5xI17Dsi
    XlsWA3XhUXsa5AT1WtyvVzlJ0nGQzCwI4N5324UT0DSw3fHhv0Xrfnb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Wb5racs59e4h4gghhuax6Tz5nsQ8jFtr_nUdT4zrWenff-nEzpm4zw>
    <xmx:Wb5raXZGVIkUNOZ1H9YS7jMogHwtlGX0Q7c6Hh69jvFsSwa0q2qbvw>
    <xmx:Wb5rafWBvmKbJQXChLlZCH8pnvM2HRkm6J7SPl6zfmWFyUCp4EGKvw>
    <xmx:Wb5rab5eUxXZPPenCIwkrJzWIrfNwFMqqnMVismv0nYv2rjfn9lXBw>
    <xmx:Wb5raai9WvLm0KNCy5OYWLuw_PxGuZv4x055mR7VH8tedrAl6JmD8MNg>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C231780077; Sat, 17 Jan 2026 11:52:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ari2zWJUXQbN
Date: Sat, 17 Jan 2026 11:52:09 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <a7493441-cc53-4b99-bb62-9092650d61f2@app.fastmail.com>
In-Reply-To: <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
 <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Jan 17, 2026, at 2:04 AM, Dai Ngo wrote:
> On 1/16/26 1:55 PM, Dai Ngo wrote:
>>
>> On 1/16/26 12:00 PM, Chuck Lever wrote:
>>>
>>> On Fri, Jan 16, 2026, at 12:15 PM, Dai Ngo wrote:
>>>> After the entry in the xarray was marked with XA_MARK_0, xa_insert
>>>> will not update the entry when nfsd4_block_get_device_info_scsi is
>>>> called again leaving the entry with XA_MARK_0.
>
> I tested the following fix and it works fine:
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 60304bca1bb6..18de3e858106 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -343,14 +343,18 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>          }
>
>          /*
> -        * Add the device if it does not already exist in the xarray. This
> +        * Add the device if it does not already exist in the xarray. If an
> +        * entry already exists for the device, then clear its XA_MARK_0. This
>           * logic prevents adding more entries to cl_dev_fences than there
>           * are exported devices on the server. XA_MARK_0 tracks whether the
>           * device has been fenced.
>           */
>          ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>                          XA_ZERO_ENTRY, GFP_KERNEL);
> -       if (ret < 0 && ret != -EBUSY)
> +       if (ret == -EBUSY)
> +               xa_clear_mark(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
> +                               XA_MARK_0);
> +       else if (ret < 0)
>                  goto out_free_dev;
>
>          ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
>
> -Dai

I applied this fix, wrapped it in xa_lock to make the update
atomic, and pushed to nfsd-testing.

-- 
Chuck Lever

