Return-Path: <linux-nfs+bounces-15709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11115C0FD09
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FA763504A2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0830B528;
	Mon, 27 Oct 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvAXZlnE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1D307AE5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587848; cv=none; b=t2unQi5L05SjT06gMOq3gCUGJPH2dlsMvMRVZjnVy57Rt2bkddYyJbEKD8spC5vqO+gLogGDqqXhfWmJxJqg0tdx0dviCYbq7zQK7doQ8yd0ETZn5Bvj33s3SDIeiaAAu4JnltX0FT3uV1wQt/B/Xo7NaBR1uq6u96628SP9S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587848; c=relaxed/simple;
	bh=IW2ninOc3/dUuBIHfJNs6IlUUw4VSbPkGNZLPVtNlBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e92u54xByxqOTQCQkULIV6UHRIdoj8lkHb3GcHZinBETDSY1NhjPo5BjWyo9lO7mobE3ZDLisjY0/RBHP8dQSbqwIAKIWZiD/c9S+vQIe+YMJ7A0CDtU+1BIEmghaHyWw1UqB7xgjjF6KEqHqeWcXKDVGnHNvi389Si50oy/uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvAXZlnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210BC4CEF1;
	Mon, 27 Oct 2025 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587847;
	bh=IW2ninOc3/dUuBIHfJNs6IlUUw4VSbPkGNZLPVtNlBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pvAXZlnEMCpKqV/QsHRAClYoQlwEpW24S4QlHsDqkOHmgLEG+th6qANYRg6yxGnKW
	 pQRMJJGzFYxREYbChqlr9qcXaye3E2tITpv/salvdSCm0zjaDAgwlNwstc8NNuASbW
	 nxZPe+ZFAPJ+INQ/Wjwvy/dDX8QJyZa/z+RcVfqhMRHMR9NOdGkdSut3jc8vpzAO0E
	 uHr0YPFICv2wJBaHXVzx/Xgsa5UcurGMZUvLXr0PJUXq/jSDw1e2P3LF8sKrRAFrBc
	 Fa4IyOJc4/lQc+3B5TXbATQh3wnEcW9TBSnd+Jt3OEhrGzVhFXpdyDoMJuc6FjniH/
	 H+afYGbfeneJg==
Message-ID: <a221755a-0868-477d-b978-d2c045011977@kernel.org>
Date: Mon, 27 Oct 2025 13:57:25 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org> <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP-YV2i8Y9jsrPF9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/25 12:05 PM, Mike Snitzer wrote:
>>> You also need IOCB_DSYNC for direct I/O to hit the media if you want
>>> to return NFS_FILE_SYNC.  But I still don't understand why we want or
>>> need to return NFS_FILE_SYNC to start with.
>> NFS_FILE_SYNC is not required here, but it's better if we can return
>> that. If the server returns NFS_FILE_SYNC there is no need for the
>> client to follow up with a COMMIT.
> Yes, which is why I'm confused by Chuck wanting to do away with
> NFSD_IO_DIRECT setting NFS_FILE_SYNC "for now".  Not heard compelling
> reason, but "it is what it is". 😉

The compelling reason is that it's generally faster (or less work for
the NFS server and its storage) to sync the metadata after the client
has sent all of the data it wants to write. This amortizes the cost of
the metadata operations, and allows the server to get the written data
persisted (if it makes sense to do that) while waiting for the COMMIT.

Since your patch asserts IOCB_DSYNC for all direct write segments,
NFSD_IO_DIRECT (as it is implemented in your patch) does not need a
subsequent COMMIT operation. Forcing the client to COMMIT is totally
unnecessary. That's why I suggested promoting all NFSD_IO_DIRECT WRITEs
to FILE_SYNC.

So perhaps the issue here is that the rationale for using IOCB_DSYNC
for all NFSD_IO_DIRECT writes is hazy and needs to be clarified.


> Were we not all concerned about safety first (especially of mixing
> buffered and DIO) and performance a secondary concern?  Using
> IOCB_DSYNC|IOCB_SYNC for all WRITEs and returning NFS_FILE_SYNC is
> really safe right?

The client ensures that UNSTABLE + COMMIT is just as "safe" as
FILE_SYNC, generally, by preserving the dirty data in its own page cache
until the server indicates the written data is durable and is safe to
evict if needed.

If you want to make an argument about data integrity, let's
be as precise as we can about what we believe might be unsafe. The
data integrity doubt was with the unaligned ends, IIRC? If we need
that extra bit of integrity, then WRITEs with an unaligned portion
will need to be IOCB_DSYNC, and then promoted.

An NFS WRITE, even an UNSTABLE one, I believe makes the written data
visible to other readers. That might be an argument for using IOCB_DSYNC
with IOCB_DIRECT, so that subsequent NFS READs (and local applications)
see the written data as soon as NFSD generates a response to an NFS
WRITE backed by IOCB_DIRECT.

I think we also discussed that an NFS WRITE should make updates visible
in byte order, which is why the segments are handled low offset to high
offset.

Or, we might decide that, no, NFS WRITE has no data visibility mandate;
applications achieve data visibility explicitly using COMMIT and file
locking, so none of this matters.


> And we already showed that doing so really isn't slow.

Well we don't have a comparison with "IOCB_DIRECT without IOCB_DSYNC".
That might be faster than what you tested? Plus I think your test was
on esoteric enterprise NVMe devices, not on the significantly more
commonly deployed SSD devices.

-- 
Chuck Lever

