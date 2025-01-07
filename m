Return-Path: <linux-nfs+bounces-8962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD9A04BA4
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688553A5ABF
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56425156968;
	Tue,  7 Jan 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="Afcef8n2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C21F4E47
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285364; cv=none; b=YgpO3dqfOXSrbGZb9hgqlHDn63Cinpvv3AGL2VRPoVepbH+DNI0c/Gd/7Qv96R8JzlmHcctKFWwzjbP14/8JLutn+AyugXeCFnx0+2qQWnZvxCyWFABwM9Hqh/x79M+w8phet0n6/DwvE+xf1vrk1LCtQIePTqJec/3fKfTKaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285364; c=relaxed/simple;
	bh=cKqr2qLqTBeJyRC3UkANgQaHt0pOfkB/IVJnMW/kLDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unTMK55YKCQHZ3I8hPzKldeA5dWjRjuAO3F+4br41GjXxwdaaifqrDlJmnnCl84y7nJNaQ3rgUj8Jps24D3CgEnFXnFi/+wxKrosKkEiBkWy23+A1qMDOzzAHoDTVXQ4ejKg3QFTVCL/IcM+pi8Y3fCVtwoLHVTrS9u4EOS4SzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=Afcef8n2; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736280518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/QoTFDXkORLGmNxOfM+FIEVkGmy1L39JMzER7A2KvY=;
	b=Afcef8n2bRf93Ea/26/m3Q4cf3AnVT9M2gtoHcnOwXzmmCOBS/5drShfpJzWXUgVoC8ZLo
	k0Xv0tskEQNMFBXZAMGOKjlYbeZR1c6mfTbZD8MHQtdiBBIvkbuAV1p6O4KT9hUsuNbrAz
	p8jFAoImrQZ8W4yJluu+vH0e7KK3L+ywJGctzntEB4e40fQB2AgFBdz3VAk8u1WmJYlBuG
	sMs/6KXHfFvAdZwIWn1ZEpU5GhVkAtM0USXcA8++oXjt3s2StiXtJ8Kwvkh2MmS3Y06VmT
	I09EFRYfBc68959zV1wSLS0NQijsrdbYr9Le0NV7gbR4rhZchL0GIgrybEd+0Q==
Message-ID: <324e2e1a-a621-4ea9-ac86-da951708c5ca@hyub.org>
Date: Tue, 7 Jan 2025 21:29:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: NeilBrown <neilb@suse.de>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
References: <> <f6aa9f24-777d-4e22-a876-07e1a72b47f8@hyub.org>
 <173628471159.22054.14955963398487620158@noble.neil.brown.name>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <173628471159.22054.14955963398487620158@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It all depends what the desired behavior is. When a rootdir is set, do
we want any exports to possibly fall outside the rootdir path? If no, it
is beneficial to use this approach since resolving paths within chrooted
env will fail if the path does not exist within the chroot. Allowing for
a "sandboxing" mechanism of sort. But with this approach you have
proposed, the issue might arise where someone with access to an nfs
export can create a symlink to say "/". In that scenario the kernel will
end up exporting the system root. Which can be bad. You could of course
do as you have stated and check if it is within the boundaries of the
rootdir, but it would result to the same thing. I think the chrooted
thread that can be repurposed is the best approach here.

The majority of the patch is simplifying what I believed to have been an
unmaintainable approach of spawning tasks within the worker thread is
created to run chrooted.

NeilBrown wrote:
> 
> (adding back steved and linux-nfs)
> 
> On Wed, 08 Jan 2025, Christopher Bii wrote:
>> I have a $rootdir set.
>> I export $rootdir/$export_entry
>> If /$export_entry exists. It will take whatever path that is and prepend
>> it to rootdir as the export passed to the kernel.
>>
>> $ rootdir="/export"
>> $ exportentry_1="/my_export"
>>
>> # exportutils takes the path at exportentry_1, runs it through
>> # real_path() and concatenates the result to $rootdir. If it fails and
>> # the path doesn't exist. It will still concatenate whatever the entry
>> # was. So in the event realpath($exportentry_1) == NULL.
>> # $rootdir/$exportentry_1 will be sent to the kernel as the path to
>> # export. But take this situation
>>
>> $ file $exportentry_1
>>   > /my_export: symbolic link to "../../../"
>>
>> # realpath($exportentry_1) == "/". So the entry passed to the kernel is
>> # $rootdir/
>>
>> Is it clearer?
> 
> Maybe - thanks.
> You say
>    "exportutils takes the path at exportentry_1, runs it through
>    # real_path() and concatenates the result to $rootdir."
> 
> assuming that is correct (I haven't checked the code but have no reason
> to doubt you), then it seems that the fix is to prepend $rootdir
> *before* running it through real_path() - then checking it still starts
> with $rootdir.
> Would that fix the problem?
> 
> Your patch set seems much more complex than that.
> 
> thanks,
> NeilBrown
> 
> 
>>
>> NeilBrown wrote:
>>> On Wed, 08 Jan 2025, Christopher Bii wrote:
>>>> Hello,
>>>>
>>>> You are correct, it would be a configuration error. But the issue is
>>>> that when a rootdir is set, export entries are assumed to be relative to
>>>> the rootdir path, but this isn't the case.
>>>
>>> The above statement directly contradicts the documentation which says
>>> that all exports *are* relative to rootdir (more accurately: the path is
>>> prefixed with the rootdir).  So if true it is clearly a bug that needs
>>> to be fixed, and would have nothing to do with symlinks.
>>>
>>> But I don't think it is true.
>>>
>>> What you have been saying is that if the export point - which is at
>>> $rootdir/$exportpath - is a symlink, then that symlink is resolved
>>> without reference to the rootdir.  This is true but I don't see why it
>>> is a problem.
>>>
>>> When you create /etc/exports (or run exportfs) you should only identify
>>> directories, never symlinks.  And all ancestors of these directories
>>> should only be modifiable by privileged processes.
>>>
>>> What is your use case for exporting a symlink, or exporting anything in
>>> a directory that is not restricted to privileged users?
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>>
>>>>                                              So my rootdir can have a
>>>> restrictive set of permissions, but the export entry path relative to
>>>> the system* rootdir may have an entirely different set of permissions.
>>>> Or even with restrictive permissions it could be accidentally or
>>>> maliciously symlinked.
>>>>
>>>> Christopher Bii
>>>>
>>>> NeilBrown wrote:
>>>>> On Sat, 07 Dec 2024, Christopher Bii wrote:
>>>>>> Hello,
>>>>>>
>>>>>> It is hinted in the configuration files that an attacker could gain access
>>>>>> to arbitrary folders by guessing symlink paths that match exported dirs,
>>>>>> but this is not the case. They can get access to the root export with
>>>>>> certainty by simply symlinking to "../../../../../../../", which will
>>>>>> always return "/".
>>>>>>
>>>>>> This is due to realpath() being called in the main thread which isn't
>>>>>> chrooted, concatenating the result with the export root to create the
>>>>>> export entry's final absolute path which the kernel then exports.
>>>>>>
>>>>>> PS: I already sent this patch to the mailing list about the same subject
>>>>>> but it was poorly formatted. Changes were merged into a single commit. I
>>>>>> have broken it up into smaller commits and made the patch into a single
>>>>>> thread. Pardon the mistake, first contribution.
>>>>>
>>>>> I'm still not convinced there is a vulnerability here, but I might have
>>>>> missed part of the conversation...
>>>>>
>>>>> Could you please spell out in detail the threat scenario that we are
>>>>> trying to defend against?
>>>>>
>>>>>    From my perspective: if you export a path that a non-privileged user can
>>>>> modify, then that is a configuration error.  We should not try to make
>>>>> it "safe".  We could possibly try to detect that situation and fail the
>>>>> export when it happens.
>>>>>
>>>>> Why is that perspective not correct?  If this has already been
>>>>> discussed, please point me to the relevant email.
>>>>>
>>>>> Thanks,
>>>>> NeilBrown
>>>>
>>>>
>>>
>>
>>
> 


