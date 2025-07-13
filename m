Return-Path: <linux-nfs+bounces-13009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8EEB03289
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B0189C4F8
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4419D07A;
	Sun, 13 Jul 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT7Z/Xx7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59339367
	for <linux-nfs@vger.kernel.org>; Sun, 13 Jul 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752429011; cv=none; b=C0JMdLZkrxQYVMvpeQ8VNzu6ERZdkpYEIF41/zJAYfEyPhs5Zq00/uY2GHEdrSj6g5xJoyo1PdZVAx9Rkn0/o6XNOznbT9iHc2chkfKeUhda/dhR7BIkDZ6pXiIQGcE0CvL3N1WxzE5AfNi1u4htgk1V+jpr5zGuWmsHev2b8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752429011; c=relaxed/simple;
	bh=0DGRPOSqsWlUkUCZlK9JlqHFgs14hd77qou2JOjTFnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upiwMgCi4qKofDmfjMiNv0/cB0rGVZkaN10qpI1BjcnrduYNBPWACnTnAOJ0Ci67j1UCx63nPHfZs/9CGVbURkmBfzTs6kPWmW7vJm8G4ABKbvMijStEog0ZBRmXrh9Cqtu9KQApePjdnmoWwwZU0Y91gzkbAX2WnhZiAmP1L3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT7Z/Xx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425E6C4CEE3;
	Sun, 13 Jul 2025 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752429010;
	bh=0DGRPOSqsWlUkUCZlK9JlqHFgs14hd77qou2JOjTFnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WT7Z/Xx7bWvmM8q4OVtLwUr+QsrJxyvQpXKIy+Z67OeKSaKdMP8Y/Vr9MDWrSQbij
	 dG58dJvNRGC0Yr+iUJqk5n5fIRASzTdzjsVHSt8CihLEGC4yWliDDnZ2QEd3ax6tXQ
	 vlq/wbnxBNki4x4xbBqMY7Ql4o/ocRdEU/BW3Wb+gFn33pCXI+Mav3C8DWPE8flQVJ
	 j4lb9rIM++OGuWKVd35JrUBbjM2mRHQIbL0fLk53kV+nBi+Md/J/2M9MZiuk3e6IgT
	 G58UyTr5hZxPVJCq9MtqjvHa6rfgOg0WXF4nSa0jP4Y+vAhpWD8WaiScVW8SSVhKsD
	 UyuYV1ODwKL7A==
Message-ID: <f6f3c22f-8c49-4f9a-937f-2103cd780f6e@kernel.org>
Date: Sun, 13 Jul 2025 13:50:09 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be
 synchronous"
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250618125803.1131150-1-cel@kernel.org>
 <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
 <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/12/25 9:06 AM, Aurélien Couderc wrote:
> ?
> 
> On Wed, Jun 18, 2025 at 9:22 PM Aurélien Couderc
> <aurelien.couderc2002@gmail.com> wrote:
>>
>> On Wed, Jun 18, 2025 at 2:58 PM Chuck Lever <cel@kernel.org> wrote:
>>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> In the past several kernel releases, we've made NFSv4.2 async copy
>>> reliable:
>>>  - The Linux NFS client and server now both implement and use the
>>>    NFSv4.2 OFFLOAD_STATUS operation
>>>  - The Linux NFS server keeps copy stateids around longer
>>>  - The Linux NFS client and server now both implement referring call
>>>    lists
>>>
>>> And resilient against DoS:
>>>  - The Linux NFS server limits the number of concurrent async copy
>>>    operations
>>
>> And how does an amin change that limit? There is zero documentation
>> for admins, and zero training or reference material for COPY, CLONE,
>> ALLOCATE, ...
>>
>> Aurélien
>> --
>> Aurélien Couderc <aurelien.couderc2002@gmail.com>
>> Big Data/Data mining expert, chess enthusiast
> 
> 
> 

The tone of your original email suggested to me that it was a whine
rather than a genuine request for more information.

Also the request for "training material" for individual NFSv4.2
operations does not make sense. We do not have training material for
the NFSv3 READDIRPLUS procedure, for example.

Therefore I ignored the email.

If you want reference material, the obvious place to look is the
Internet standard that specifies these new operations (RFC 7862). It is
publicly accessible on the web. If you need something more basic, I
highly recommend Callaghan's "NFS Illustrated" (ISBN: 9780321618924).

NFSv4.2 COPY, CLONE, and ALLOCATE are exposed to applications via the
POSIX file system API available in Linux, as documented in man pages.

There is no specific administrative setting that controls the number
of concurrent asynchronous COPY operations. The limit increases with
the number of NFSD threads. If someone demonstrates a specific use
case where manually adjusting that limit is necessary, a setting can
be implemented.

The specific guidance you might be looking for is typically provided
by the documentation staff at Linux distributions. You could file an
issue with your favorite Linux vendor to let them know what you are
looking for.

-- 
Chuck Lever

