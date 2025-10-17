Return-Path: <linux-nfs+bounces-15344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21DBEBDB8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 23:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7743BAEEB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82524C68B;
	Fri, 17 Oct 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNo62n6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44B274B23
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738042; cv=none; b=c1kctc+XdUOqvly/e4XSTZF/K+3AN40UKnaaV2/wu/R3SrgpPl9HDQh10n+VJjzkAViLGfeBE2/7AmgNA3OGUagnZCPj3W2ivSIiEU8mwhUbb/8nMjI6am7uMhd/v3vk0PPYk2nlaUe9ZPqAU0rL5iBq35K8mG9130WLXOVmXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738042; c=relaxed/simple;
	bh=bfhGTqFJiFNWjCS4CVQnhkQQ8vh0mSSl7wG+cRXK1Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlyhfP+wi9ZKdLUnsTXl5scg5bIiN1j/hr/FaiYtnuzQNcSqk+sX/uPW6+bLQgTwfdKTL9/XyLPP2/4pugEmMQ+DuhFfRgtdXqGukIKWOlG1l/iMD/GV+C6qEsznoQgYm4GVCYVGHSHWhl2UujcRH6aiyn9VHvnR9PSLt6uQkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNo62n6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D13C4CEE7;
	Fri, 17 Oct 2025 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760738041;
	bh=bfhGTqFJiFNWjCS4CVQnhkQQ8vh0mSSl7wG+cRXK1Do=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNo62n6jF95lqpwxH8KcQ5PWAYIFBC43M9ksp/AOukNBgNbgUZP/KmbX/CWtgJ3H9
	 BitKXHLDYLImGQiO4Lqn7TnwF3mogRHb0BD7hKfimaG+3t42M8PZ+F68iDrr4S4DNj
	 mF20WHn8xPB+BA1MBX+m1Amv5J8MPI+pNbWuW6JlyRx6n4c0p0auJyC/qGiY8S1KHf
	 xlj1KnddPpQyMDFKIloR0FmICofT6D7OsxwERxMICNd0dRrYrbe/kCT+tks3g9t39f
	 RjNeTdTKE/JYgR6ijlCEYX83SE0NlG6iREkg1Xdp1oNheyP+ejXRQvlg1MP4za2IHe
	 xdzBk1Sbasjaw==
Message-ID: <5bf67a27-8a1c-4771-aeba-625bb20ec45f@kernel.org>
Date: Fri, 17 Oct 2025 17:54:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251013190113.252097-1-cel@kernel.org>
 <aPAci7O_XK1ljaum@kernel.org>
 <2e353615-bb40-437b-83ea-e541493f026c@kernel.org>
 <aPKvGynfz0n84Ldm@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPKvGynfz0n84Ldm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 5:03 PM, Mike Snitzer wrote:
> On Fri, Oct 17, 2025 at 10:13:14AM -0400, Chuck Lever wrote:
>> On 10/15/25 6:13 PM, Mike Snitzer wrote:

>>> +	*cnt = 0;
>>> +	for (int i = 0; i < n_iters; i++) {
>>> +		if (iter_is_dio_aligned[i])
>>> +			kiocb->ki_flags |= IOCB_DIRECT;
>>> +		else
>>> +			kiocb->ki_flags &= ~IOCB_DIRECT;
>>> +
>>> +		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
>>> +		if (host_err < 0) {
>>> +			/*
>>> +			 * VFS will return -ENOTBLK if DIO WRITE fails to
>>> +			 * invalidate the page cache. Retry using buffered IO.
>>> +			 */
>>
>> I'm debating with myself whether, now that NFSD is using DIO, nfserrno
>> should get a mapping from ENOTBLK to nfserr_serverfault or nfserr_io,
>> simply as a defensive measure.
>>
>> I kind of like the idea that we get a warning in nfserrno: "hey, I
>> didn't expect ENOTBLK here" so I'm leaning towards leaving it as is
>> for now.
> 
> While ENOTBLK isn't expected, it is a real possibility from the MM
> subsystem's inability invalidate the page cache ("for reasons").
> 
> So it isn't that NFSD would've done anything wrong.. it just needs to
> deal with the possibility (as should any other DIO write in kernel).
Well my point is that if the MM/VFS can return this on a buffered write,
should NFSD be prepared to deal with it in other places besides this
path? I think it's handling ENOTBLK correctly here. Just wondering about
elsewhere.

This is something we can set aside and worry about after merge. It
actually has more to do with the existing parts of NFSD, not the new
direct write code path.

I'll repost the "stable_how" patch and this one together in a new
series, for Christoph, and pull that series into nfsd-testing.


-- 
Chuck Lever

