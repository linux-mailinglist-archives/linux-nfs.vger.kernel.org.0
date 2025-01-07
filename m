Return-Path: <linux-nfs+bounces-8966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6CA04D88
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 00:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA443A3FED
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916313B58A;
	Tue,  7 Jan 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="tKKaxjF+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517B1DF75C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292659; cv=none; b=eXN5MEqL+PX3S4WHhYJykmqdOm9oI6cAVEEnf2bj46Ohg06ZvnJV5EjfrnxJJYhKN7+NDG/yl/ZAJFnSJvC3RweuriVAtisoa8LA9qqJpHWLofg2yxt8akn5NE4sjRECV8F0pWDgIj3SfK+/d1iCgFHeMhnqL7upDI8aVkkmmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292659; c=relaxed/simple;
	bh=GxjGO4ZKcGCdlzUL59FZpp0Ltuj0yquNumQCUwskguY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpcxa+ylGjFP4HwApXYe6KMGVxwfk15B/vHWbNDmvFKYS/SwlBaQJ8xYPTEJLo6zg3OATSHroeSPX2DKehu1erWqyxQ5TGZGl27hM7i0Xh81lQVfwXnq5wBSPjY9eZuNKW9E1eDpPu5odyG5pAcH6eylCNh+13kOVy9xdyccRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=tKKaxjF+; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736287812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25m6MhnzHCPwFDgXia5zWqnPIAqNQruPaCMmpfDYW40=;
	b=tKKaxjF+z1zXwN4aIZff5Iy3UMHaSH0jwzP96793WKwwXQIEOD5NosrNMuOpYROVvyoVOj
	wVV7YS70eMSGsBTwoduRoTH2KiaVF3etQL4LsiyM6NgGP0XeM4f5icc8KOOs+rGgpdIUFf
	/Kqw1PSLgLtPi9DcAJ8r65UO87/tnNG5HZ8LYxjIKFcd627Gr79uHA/8ThoKteXeIzupb4
	I/mC1QyuEqLhYE35RHPGQM5o6vuVEgscLchqzF8S2BGBpAqwLtUucsKHzrFrM8N3+TcWQd
	AyMIxq6sNZgavjbV+zFTu2wTnC3oNXQa6ksv9H7qvoShCTX7p+DT8Vo7L2kSrg==
Message-ID: <e7a5c4a7-b3aa-46da-b4c1-2a88adc4705c@hyub.org>
Date: Tue, 7 Jan 2025 23:30:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: NeilBrown <neilb@suse.de>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
References: <> <324e2e1a-a621-4ea9-ac86-da951708c5ca@hyub.org>
 <173628960892.22054.13808393456971278871@noble.neil.brown.name>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <173628960892.22054.13808393456971278871@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I would love to agree with everything you've said, but I thoroughly 
explained the issue/problematic behavior. It doesn't take more than a
glance at the patch to see the work done in nfsd_path.c is on wrappers
around various function call signatures. In the patch commit message it
is clearly stated that I am simply implementing these methods using
helper function nfsd_run_task(). How thorough can an explanation for
abstracting away repetitive conditional logic be?

 > And don't just say "there is a security vulnerability".  Explain that it
 > is because the that real_path happens before that root is prepended.

The issue still has nothing to do with realpath being called before
concatenation of the rootdir, as placing it after is arguably worse and
not a fix. My mention of it came due to concluding you assumed an
alternate ordering of steps (concat -> realpath), hence why you did not
understand the issue.

Cheers,
Christopher Bii

NeilBrown wrote:
> On Wed, 08 Jan 2025, Christopher Bii wrote:
>> It all depends what the desired behavior is. When a rootdir is set, do
>> we want any exports to possibly fall outside the rootdir path? If no, it
>> is beneficial to use this approach since resolving paths within chrooted
>> env will fail if the path does not exist within the chroot. Allowing for
>> a "sandboxing" mechanism of sort. But with this approach you have
>> proposed, the issue might arise where someone with access to an nfs
>> export can create a symlink to say "/". In that scenario the kernel will
>> end up exporting the system root. Which can be bad. You could of course
>> do as you have stated and check if it is within the boundaries of the
>> rootdir, but it would result to the same thing. I think the chrooted
>> thread that can be repurposed is the best approach here.
>>
>> The majority of the patch is simplifying what I believed to have been an
>> unmaintainable approach of spawning tasks within the worker thread is
>> created to run chrooted.
> 
> I'm not at all familiar with the "work queue" and nfs_path.c and chroot
> code so I cannot comment on whether the current approach is
> unmaintainable.  Maybe it is.
> 
> But all these details need to appear in the patches that you send.
> Don't just tell us what you are changing, tell us why.  Say that is is
> unmaintainable and give some reason for us to believe you - a reason
> that we can check by looking at the code, and then see that your patch
> makes it unmaintainable.
> 
> And don't just say "there is a security vulnerability".  Explain that it
> is because the that real_path happens before that root is prepended.
> 
> All of that needs to be clear in the patches so that we can review them
> properly now, and so that when we look back at them in 2 years because
> some issue arose, we can remind our self what they were for and
> understand how that all relates to the new issue.
> 
> Maybe the code in the patches is already fine.  But the explanation in
> the patches also needs to be good before we can approve them.
> 
> Thanks!
> NeilBrown


