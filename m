Return-Path: <linux-nfs+bounces-15675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1334C0E2F6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE6F34FBB6E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73515302158;
	Mon, 27 Oct 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bROrLAAM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44646307481
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572906; cv=none; b=BcItqwJVSvX/3Cy9vNgzQQwF92lBCpEqSoeo85TEkOJtHSG7C7KkUYuvb/k0iZ9JHcnGHWf2iTQy7yBNrgQkanmcj4/cyjArH1IBIKQ+WeDH0nC1xlTw7/x7AkI5+tpGtBK+cFTP3L2/nsK6AZeF0BZfhYd6etNdfE2P5+twFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572906; c=relaxed/simple;
	bh=ARHSaU9alDuSgDsIKF95b8A1QKdPqZnN4VEzcwwl+nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHNRjYRWCClBCOu6WPT/ksvyDJuGXa8odRm4KnmZwP9eq1pJkE3cfqBIu3sx5U97ISZZV5JSGC6noUg8ui+BuZc4QQ9/93UqaKni7N1kGj5DeqTC+zMTcGjT3a7yTBG7EFnvBlQBs9dJqNNSJuUrCQ9gM8HBUNDN9FP1/38ueyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bROrLAAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AD9C4CEF1;
	Mon, 27 Oct 2025 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572905;
	bh=ARHSaU9alDuSgDsIKF95b8A1QKdPqZnN4VEzcwwl+nQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bROrLAAMQR8e6dq6587JC/uwk8l061IcF0OWj2T3HtCOCZ5s5EzsaYrfwquc6g7ze
	 G7lLlS7jm8NYI5Umxx24vAUHMzvqEnhbARmYfUckKbgWvk+oDco/n1oJxzZjV/lLcE
	 neGdvg/11411Sd9na3nG9miVFM9EpAMne6juZsDfpqbmwdy4x1fnm/lIiZ0Z5GuDNU
	 OrtAD+L1Bham3e2nNhvmdBf21yJAytLe/hcD31KcvPxCex5VEiyhA8wwAi1MV69uAP
	 XJBFJ+4KSsWOEBq46EtkZCw6WR6L/4x9W0aGGYo04vrlgOpnGf0bvjPnbafwH89JP6
	 ol08b6R54D0iA==
Message-ID: <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
Date: Mon, 27 Oct 2025 09:48:23 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org> <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 6:50 AM, Jeff Layton wrote:
> On Mon, 2025-10-27 at 01:15 -0700, Christoph Hellwig wrote:
>> On Fri, Oct 24, 2025 at 07:56:59PM -0400, Mike Snitzer wrote:
>>> Really, even ignoring all the quirkiness of this: that O_DIRECT can
>>> fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
>>> buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
>>> stable storage -- that's enough justification.  Bit circular but
>>> compelling to prove the need.. albeit wordy and a lot to unpack.
>> You always need IOCB_DSYNC for data to hit stable storage, both for
>> buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
>> out the timestamps, which I think we now agree we need.  I still don't
>> understand why using direct I/O implies that we want NFS stable writes
>> and not two-stage writes, though.
> That's certainly a possibility too. Consider the case where we have a
> WRITE with unaligned parts at both ends. This set so far just does the
> ends as synchronous I/Os.
> 
> We could do the end bits as non-synchronous writes, and follow up with
> a vfs_fsync_range() call before returning NFS_FILE_SYNC.

What concerns me a bit is that the code that handles unaligned ends
is careful to issue the vfs_iocb_iter_writes in file offset order. Are
we OK to use IOCB_DSYNC for the unaligned parts but IOCB_DIRECT +
subsequent COMMIT for the direct I/O middle segment?


-- 
Chuck Lever

