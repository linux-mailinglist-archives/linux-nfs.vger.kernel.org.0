Return-Path: <linux-nfs+bounces-14961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4621BB72C0
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 16:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A7A3B6D6E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4E23BF91;
	Fri,  3 Oct 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5X9D0rd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3223B618
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501399; cv=none; b=AG+H1lSZxqgBJUX+Y1r/ePva7jmykRECnn4m3bYZzNhghKLualb860oRu8a8Km2kDepajDp3Ygk5sOskdRaOtq8LcwhAh44Fb48zOTGzUD0IY+Y6XJ9+q7RpSpek7AEmJVrlpreBfeKVy4JLwD3UD0XgtatKwPBI8bi4GdHjSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501399; c=relaxed/simple;
	bh=tIg9LHbw8McRD9wFZZuh+YfGl9vb61ZHla2VkicxlQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASIRs/JoD/6NGlEpU/cbNkOzjoejevaqaga8FUWSItiQIBP1OBhlzAtYR+JjTpeGhez6bWjMuztx6QPioDK0QCkiZDv1vcmHZ/ksKMhjNrVJ1em2iVdMgw4Ev9LUHxzn12a/ZDjwfYLX95HFnNLqQcNBpngkewhDxBQgyiPNejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5X9D0rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A4C4CEF5;
	Fri,  3 Oct 2025 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759501399;
	bh=tIg9LHbw8McRD9wFZZuh+YfGl9vb61ZHla2VkicxlQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5X9D0rdyz7ZxytXPZXwtsHbKH/AuQrsQMv83vtnP9thOA0VqMQ4uwn6JJX8fB0ZM
	 /ksvc7bN+tXKajZqyp4mpcjqf6Pybuj2BCcPnnF8j17PQzSko5Z+leEr0OEZyuZjH3
	 00OREj4l++f3PRjO7ct0ruEXfZA7wMN3pUhVPg7raBLoOnaXVhg03IM/JfFXDKtdyF
	 EwCnneez5mtgYQZFttsNnAUDPLOzdQryvUI1mf7uamw8fBUoFNtloZWrROuvlCcOsN
	 BjQwJVF7QqrDUE6N8DC07IxSJZy/7voihs9w3qivwaVUGpZLkBhOqzj4aZW/O2g4Q0
	 Q638O1EjScBaQ==
Message-ID: <56c040fc-d303-4368-9850-de9b52851466@kernel.org>
Date: Fri, 3 Oct 2025 10:23:17 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] NFSD: Ignore vfs_getattr() failure in
 nfsd_file_get_dio_attrs()
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-7-cel@kernel.org> <aN93he8osC9r6oKR@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aN93he8osC9r6oKR@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 3:13 AM, Christoph Hellwig wrote:
> On Mon, Sep 29, 2025 at 11:56:46AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> A vfs_getattr() failure is rare but not totally impossible.
>>
>> There's no recovery logic in that case; nfsd_do_file_acquire()'s
>> caller will fail but the wonky nfsd_file is left in the file cache.
>>
>> It doesn't seem necessary for nfsd_file_do_acquire() to fail
>> outright if it successfully opened the file but some problem
>> prevented the collection of the dio alignment parameters.
> 
> The only remotely likely case for this is a file system shutdown.
> There's no real way it could fail but I/O later on will work.
> 
> I think just failing serves everyone here much better than try to
> keep going.

Got it.

IMO then more recovery logic is needed in do_file_acquire. We can't then
just leave the moribund nfsd_file in the filecache unless there is some
guarantee that it will not be leaked.


>> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
> 
> Same comment about fixes being first/separate as for the previous
> patch.
> 


-- 
Chuck Lever

