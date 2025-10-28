Return-Path: <linux-nfs+bounces-15728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FBC16891
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 19:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F921B27871
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4834C820;
	Tue, 28 Oct 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtjyT0rx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB334AAE3
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677316; cv=none; b=Y2t4rdxziaCjVmcmouorCdYXoWR1bN77B7LclwWseLmx0XyAkAguyBkmc8/FzWX3FB7VavB7+x0iTL6BruZZIHpL1EuN0u+ahu/R07s3fSISAh4pBTxMamtEEyKxdSbMak+tXBTjMqy6nRkRqGrOtrQ/4nq5CaSNwdYEfNk2JFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677316; c=relaxed/simple;
	bh=pLWFat07mq0rKP8pGzztqdGYCBXi5+cXhsV/MWeJPrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDxZLglTv38Vwo0BN92HNAF81LFFkaCHzj6AM4RH0Fy28atAOAG0TjYmKIPHZXmKOFYTxtODdgHSnOkShOI7XgSG+BcR2otJnjyqByJsC20l+7PScd1Nf3wR0aMj08XoQ7aM2YHAtE/cJ7ZO/g0fgrwvk3AMcxLEr7Rgh23vYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtjyT0rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B41C4CEE7;
	Tue, 28 Oct 2025 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761677315;
	bh=pLWFat07mq0rKP8pGzztqdGYCBXi5+cXhsV/MWeJPrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mtjyT0rxzivd1hxgs0urbKMCEUR6tB2U6jQGU7KEX7SGQS3BqOuAJvn6gsmGxkXlH
	 BOTexrpPsExuzlBkUluylSSsykdroHsjF7uIgJrv/AbfTI86QtKPWo4/yhWVzdFzh2
	 oe8mv4TNJJc+H+zhVXVtlNYvfNcNQBOP6ErTsTonlF3yk829GaWHoKTbkbNn9x13k2
	 xS1m2fktkq98nSmtohIBRqPwvZTdFHPQ3hYZ37QV2R1tpcxlb+w91FBCLSi0fPj7/k
	 3JMqBVg8toCXkos+pimW2waHs2Zi4TJa38Qqu6JX3bUJycGBsrh9DztjBBrfn0YWDl
	 H+zEljk3CB0oA==
Message-ID: <b63ed4d4-8bbb-4794-ae07-64a4000e0ea9@kernel.org>
Date: Tue, 28 Oct 2025 14:48:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org> <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
 <aQDpjNnj47ISRItg@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQDpjNnj47ISRItg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:04 PM, Mike Snitzer wrote:
> I'm also concerned about initiating
> any page cache invalidation off the back of the DIO WRITE in the
> middle (and its potential to fallback to buffered if that invalidation
> fails... any associated buffered IO fallback or ends best have O_DSYNC
> set it ensure everything ondisk).

My questions:

A. Which filesystem code can return -ENOTBLK?

- iomap-based DIO (fs/iomap/direct-io.c:715): XFS, ext4, f2fs, gfs2,
  zonefs, erofs
- Legacy DIO path (fs/direct-io.c:984): ext2, some ext4 code paths
- btrfs (has its own DIO implementation that uses -ENOTBLK)

Code auditing shows that vfs_iocb_iter_write() never returns -ENOTBLK
because all filesystems that could generate this error internally
convert it to 0 or another error code before returning from their
write_iter implementation.

Therefore NFSD itself does not need to know about or handle page cache
invalidation failure.

B. Even if NFSD had to recover from a failed page cache invalidation,
   does a fallback write need to set IOCB_DSYNC (not considering the NFS
   protocol requirements) ?

When invalidation fails, some pages remain in the cache (dirty or with
private data). The buffered fallback writes to those same pages,
updating them with the correct data. There's no torn state or corruption
hazard.

The fallback restarts the entire write from scratch, as buffered. Any
partial progress (like a buffered first segment) gets rewritten with
the same data. No orphaned blocks or inconsistent state.

If another process does a DIO read of this region, it will call
kiocb_write_and_wait() first (see mm/filemap.c:2912), which flushes any
dirty pages before reading. So they'll see correct data even if it's
still dirty in cache (Jeff's concern).

C. When setting up a three-segment write, is IOCB_DSYNC needed on the
   unaligned ends (not considering the NFS protocol requirements) ?

Before writing the DIO middle segment, the VFS must first invalidate the
page cache, so the first (buffered) segment is flushed to durability
anyway. The use of IOCB_DSYNC for the first segment is superfluous.

After writing the DIO middle segment, the unaligned end remains only in
the page cache if IOCB_DSYNC is not used. But a subsequent DIO read will
flush that to durability (via kiocb_write_and_wait) before satisfying
the read. So, IOCB_DSYNC is not needed there to meet putative file data
visibility mandates.


>> As I understand it, IOCB_DSYNC has nothing to do with whether the three
>> segments are directed to the correct file offsets. Serially initiating
>> the writes with the same iocb should be sufficient to ensure
>> correctness.
> 
> IOCB_DSYNC just ensures when they complete they are on-disk.  And any
> failure of, or short WRITE, is trapped and immediate cause for early
> return.  Whereby ensuring file offset integrity.

AFAICT, generic_perform_write() updates ki_pos synchronously whenever
it returns successfully, regardless of the IOCB_DSYNC or IOCB_DIRECT
flag settings. If the vfs_iocb_iter_write() call fails or returns fewer
bytes than expected, the loop terminates immediately and writes to
subsequent segments are not initiated. I don't see a data integrity
issue here.



Thus I'm still unconvinced that IOCB_DSYNC is required if the client has
requested an UNSTABLE write. I'm open to reviewing actual evidence of a
failure mode where IOCB_DSYNC might prevent data corruption, but so far
I don't see how it can happen.


-- 
Chuck Lever

