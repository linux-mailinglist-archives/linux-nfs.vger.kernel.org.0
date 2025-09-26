Return-Path: <linux-nfs+bounces-14737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262BBA4383
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2471562DBF
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B21C32FF;
	Fri, 26 Sep 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLVCAGRo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483114B953
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897103; cv=none; b=LI5kZEIe60+TR6bg8vAlaszHgmcrQvVMu5uoWvzczPPypwDvXclzXLVun6+Zn4Jq1nluA7+yZl28FD93QJzyE8DfZhCO7YCQ25qQhmNcRqrpAxeSEQKi+HsQFTI1e6EyYqLNxcERaY7McOfPTuNRHnziBH8lETnHuJzpTFYMtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897103; c=relaxed/simple;
	bh=M/OKHEo9nyDbCu2zayCEyyDkt+4ZgvAkFrIr/d92wDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK8uwiv05e1iHBRUuJwqJbyJ1HrOck4WNCxSVUURKsbEA7xLXg2YkzhIh8NpadnapStucM00McNxAYrY4ZAZ1b1hN0RTWfphIWmWYY/YvAB5Zb8dCSJhRtgSFtgatOXUDP3sqsXwyoBJgC/4ds921NV0ShsT2Yngq2YlRRRCOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLVCAGRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EF9C4CEF4;
	Fri, 26 Sep 2025 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897102;
	bh=M/OKHEo9nyDbCu2zayCEyyDkt+4ZgvAkFrIr/d92wDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JLVCAGRoFoyVdiaLmBOPlDRueV06Mnoft0CRCXypyuwwmSf87YuZRDMtpa5FZB7J5
	 caq2ArEZucVZlKRH+3oux34qeu8NMrlI6FWw/40uJJ9JemA4zVVflsB8q5PJo4AnYO
	 Wp1NfvIaa10LbLzCjnAGgTCLHpihP705kEHyC5tJgyDm6mANRKOU8uFS6hGARbobPL
	 ZVCOhZy09wyux4ugZyV0SNCrKRWDUKb7B/9nWBOT3zYdhJ4Q/SKcY0b2eCkkB4pvPZ
	 jjLNoMGvhVrhTwBplQmilL4+nl1eVEhazF4+yv27weqNlTDbrPobAO746qvVL6/5fP
	 lQDEszcvwH4uQ==
Message-ID: <b77e3e52-0259-4c45-84d8-5f5ad017b8c1@kernel.org>
Date: Fri, 26 Sep 2025 10:31:40 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Relocate the xdr_reserve_space_vec() call site
To: NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250924195128.2002-1-cel@kernel.org>
 <175884921980.1696783.4211256086968875624@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175884921980.1696783.4211256086968875624@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 6:13 PM, NeilBrown wrote:
> On Thu, 25 Sep 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In order to detect when a direct READ is possible, we need the send
>> buffer's .page_len to be zero when there is nothing in the buffer's
>> .pages array yet.
>>
>> However, when xdr_reserve_space_vec() extends the size of the
>> xdr_stream to accommodate a READ payload, it adds to the send
>> buffer's .page_len.
>>
>> It should be safe to reserve the stream space /after/ the VFS read
>> operation completes. This is, for example, how an NFSv3 READ works:
>> the VFS read goes into the rq_bvec, and is then added to the send
>> xdr_stream later by svcxdr_encode_opaque_pages().
> "This is .. how an NFSv3 READ works" is the part of this that stands out
> for me.  Increasing the consistence between v3 and v4 must be good.
> 
> v2 and v3 readlink, readdir, read; and v4 splice_read
> all use svcxdr_encode_opaque_pages().
> 
> These are precisely the operations where there is precisely one
> page-like component of the reply.  For other v4 operations there are a
> mix of page-like and non-pagelike elements.  They use the more
> traditional xdr_reserve_space() and xdr_truncate_encode.
> 
> direct_read is more like splice_read than it is like iter_read.

But only in the NFSv4 case, and only in the sense of /when/ it may be
used, and the similarities are not exact (see below).

The logic of a direct read is identical to vectored and dontcache
reads in all cases -- build a bvec and call vfs_iocb_iter_read(). The
only reason it is split out today is because I want to get the direct
I/O implementation nailed down before de-duplicating the code.

And, we have the nice fallback behavior, currently, where NFSD tries
direct I/O; if that isn't possible, dontcache; and if that isn't
possible, vectored read, which is always possible. I believe there is
still situations where per-I/O fallback is reasonable.


> This is because there can be only one page-like element.
> So it isn't clear to me that it should be integrated with
> nfsd_iter_read().  It is quite different from splice_read too.
> 
> However I think for the v4 case, direct read fits better in
> nsfd4_encode_splice_read() than it does in nfsd4_encode_readv().
> In both cases the READ is the only OP that can used the page vec - all
> other replies have to fit in the header page.

There is the sticky part of this where GSS forbids the use of splice
read. In that case, all NFSv4 READ operations use nfsd4_encode_readv().
The first READ operation in a COMPOUND may still use direct I/O even
though NFSv4 READs do not use nfsd4_encode_splice_read() when krb5i or
krb5p is in use.

IMHO the direct read path still fits best (though I agree, not yet
perfectly) in nfsd_iter_read().

I'll post another revision of the series to continue the discussion.


-- 
Chuck Lever

