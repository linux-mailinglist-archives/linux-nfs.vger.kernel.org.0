Return-Path: <linux-nfs+bounces-10751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57754A6BEB9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93B83B7E78
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1D1E571B;
	Fri, 21 Mar 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl1J9xKP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0942A94
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572289; cv=none; b=Wy46tpVAbwb1F/ZoeYR4c5dJvqXtaQcNhw/rRV9sGiq7H8BuNC8rIoAvlPvTvNOj7y6PbL6pN503+SahmHiNKehJHhthng3HlHjeVw+RZw2w+8JIA74JMift7Je+fRgwNar19/LnjOBHIm3JY8I5NUyuIojauR+8z+OeiyxRjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572289; c=relaxed/simple;
	bh=XJymiIPgIWEseQ8pCZG1MNzbr+ImFeCoUujUOke/DMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XThzJ9fiu31lYvj5+t3P7GM0s6hhcVtO2UMLwalHeHlxbhVeIfwyMYXZSFOadMnckBt3yLBie7AtnnfJj9i7vBTVglIK8fQliQ2YrQ9H8ljxtNf/3A8f9qn7pc/6FX9AQJfnQL06K+6weK0JmxIahtRSo4r3HdGcRbYIbDqgbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yl1J9xKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742572286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pdXHjZpXXTVs0aC8q3tluyfOkhAd9tgHVUBjzyHZCY=;
	b=Yl1J9xKP6J/ppGkACu2TC69eXB9YPErvr/aQzKx3bpcU9VQeI9d+0YJoQ0wDvUVEiajEQm
	ZFMvhtsBveAv2Wp+KLoffkLke1SupkFRE07mqId0K2uVqbDRGFut77H9hZPeuUR/7AOjrA
	J/1y420hzr/XgPp+ZSTERo6UQP2BMqY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-OH11YAWROpu5_drsNJk5ow-1; Fri,
 21 Mar 2025 11:51:22 -0400
X-MC-Unique: OH11YAWROpu5_drsNJk5ow-1
X-Mimecast-MFC-AGG-ID: OH11YAWROpu5_drsNJk5ow_1742572281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CA4E1801A1A;
	Fri, 21 Mar 2025 15:51:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 984121800944;
	Fri, 21 Mar 2025 15:51:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
Date: Fri, 21 Mar 2025 11:51:17 -0400
Message-ID: <08AF64B5-8224-4349-AB8E-C4945C0AEADF@redhat.com>
In-Reply-To: <508ab008-866b-49b1-83cb-31d25de96f8c@oracle.com>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
 <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
 <0895A981-76C0-41A0-B474-62659480B31F@redhat.com>
 <4afafdfd5f7148cf8c9e0c9a65946726f29719e5.camel@kernel.org>
 <5ACD599A-44FA-41B0-AFDB-B8D352044387@redhat.com>
 <508ab008-866b-49b1-83cb-31d25de96f8c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 21 Mar 2025, at 11:18, Chuck Lever wrote:

> On 3/21/25 11:07 AM, Benjamin Coddington wrote:
>> On 21 Mar 2025, at 10:43, Jeff Layton wrote:
>>
>>> On Fri, 2025-03-21 at 10:36 -0400, Benjamin Coddington wrote:
>>>> On 20 Mar 2025, at 13:53, Chuck Lever wrote:
>>>>
>>>>> On 3/19/25 5:46 PM, NeilBrown wrote:
>>>>>> On Thu, 20 Mar 2025, Dai Ngo wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Currently when the local file system needs to be unmounted for maintenance
>>>>>>> the admin needs to make sure all the NFS clients have stopped using any files
>>>>>>> on the NFS shares before the umount(8) can succeed.
>>>>>>
>>>>>> This is easily achieved with
>>>>>>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
>>>>>>
>>>>>> Do this after unexporting and before unmounting.
>>>>>
>>>>> Seems like administrators would expect that a filesystem can be
>>>>> unmounted immediately after unexporting it. Should "exportfs" be changed
>>>>> to handle this extra step under the covers? Doesn't seem like it would
>>>>> be hard to do, and I can't think of a use case where it would be
>>>>> harmful.
>>>>
>>>> No. I think that admins don't expect to lose all their NFS client's state if
>>>> they're managing the exports.  That would be a really big and invisible change
>>>> to existing behavior.
>>>>
>>>
>>> If we're unexporting the filesystem though, then ISTM like we ought to
>>> cancel any state that was held on it. Are you concerned the admin
>>> inadvertently unexporting something or is there another use-case you're
>>> worried about?
>>
>> I'm worried about changing existing behavior and the fallout, today I can
>> un-export and re-export all day long, and as long as I re-export the
>> filesystem the applications on those clients are unaffected.
>>
>> I'm an old sysadmin that knows that I can un-export and re-export stuff and
>> not have to worry about state loss.
>
> Is it documented that you can rely on that? If not, then I'd say old
> sysadmins should expect that behavior can be changed. 2-cents.

No, I don't know any place it's documented.  It's the consequences of this
change I'm worried about, not our ability to say "you should have expected
this!"

> Also, as a sysadmin, I would never unexport and expect there to be no
> consequences. Running apps that try to open a file on a recently
> unexported share /will/ get ESTALE -- NFSv3 holds no open state at
> all, so the next NFS READ on that share will fail with EIO.
>
> So unexport is already not without some consequences. IMO it's not
> sensible to expect an unexport / re-export cycle will be safe under all
> circumstances.

This is true.

>> There have to be existing systems and
>> people that also have that knowledge built in by now.  If we change this, we
>> break things.
>
> No lies detected. ;-)
>
> Another reality test is to audit other server implementations. I can ask
> around.

Thanks for taking my worries seriously.  Since I'm working on a distro, I'm
sensitive to how many folks might get upset when an upgrade breaks things.

Ben


