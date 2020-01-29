Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD114CD78
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 16:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgA2PgJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 10:36:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726271AbgA2PgI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 10:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580312167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icmjNkgEoaHzR7OittvWxW/OTm6kJHCcj417jFnLLds=;
        b=egD98aZGAy1+EldydUNKpAgG8gavh4lhbMBpLDF7Y+Ny2Fi3LhaTXlzwCfF4bTXIL1EgbH
        RdMncfHGxGMJi4ntvjidUrvLBPx+dykrJ3r/zQCI8Ea12UOH6343hwJEmhJ0BBMtMPya2I
        DnnYCFVzLF0ecLRXqotU/rtfU+WkaXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-AmFcfRJQMuGzV1w1OE8jvg-1; Wed, 29 Jan 2020 10:36:05 -0500
X-MC-Unique: AmFcfRJQMuGzV1w1OE8jvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA1D8108E89A;
        Wed, 29 Jan 2020 15:36:03 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10DAB90062;
        Wed, 29 Jan 2020 15:36:02 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH v2] NFS: Revalidate once when holding a delegation
Date:   Wed, 29 Jan 2020 10:36:01 -0500
Message-ID: <BCC4E2F5-605A-4C26-B87D-1AD3A6512646@redhat.com>
In-Reply-To: <7d83d09f968394646424c61e9fa28b7b2a6d9b1a.camel@hammerspace.com>
References: <bcb5ffd399c4434730e6d100a5b7cae5e207244e.1580225161.git.bcodding@redhat.com>
 <9e28aaaff4eae411e0a9d6b94b3d69f7514454cb.camel@hammerspace.com>
 <be1a465a0cf52ddae6d2ba26069dff0500b0ea4b.camel@hammerspace.com>
 <d1600385a53358aa69f6f839987a1b11fa2dd5e8.camel@hammerspace.com>
 <5e157e8a6298ecb640414591988c1e76e8a6fd40.camel@hammerspace.com>
 <3deb5458d142529c0f23669a1b9edaaf4ad032a5.camel@hammerspace.com>
 <A95E0924-D2E8-4D02-951C-36D33070D0CD@redhat.com>
 <7d83d09f968394646424c61e9fa28b7b2a6d9b1a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 Jan 2020, at 10:04, Trond Myklebust wrote:

> On Wed, 2020-01-29 at 09:18 -0500, Benjamin Coddington wrote:
>> On 28 Jan 2020, at 16:46, Trond Myklebust wrote:
>>
>>> On Tue, 2020-01-28 at 21:30 +0000, Trond Myklebust wrote:
>>>> On Tue, 2020-01-28 at 16:20 -0500, Trond Myklebust wrote:
>>>>> On Tue, 2020-01-28 at 15:21 -0500, Trond Myklebust wrote:
>>>>>> On Tue, 2020-01-28 at 10:56 -0500, Trond Myklebust wrote:
>>>>>>> On Tue, 2020-01-28 at 10:26 -0500, Benjamin Coddington
>>>>>>> wrote:
>> ...
>>>>>>>> +	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
>>>>>>>> +		verifier = NFS_DELEGATION_VERF;
>>>>>>>> +	else
>>>>>>>> +		verifier = nfs_save_change_attribute(dir);
>>>>>>>> +
>>>>>>>>  	nfs_setsecurity(inode, fattr, label);
>>>>>>>>  	nfs_set_verifier(dentry,
>>>>>>>> nfs_save_change_attribute(dir));
>>>>>>
>>>>>> Oops! When reviewing, I missed this. Shouldn't the above be
>>>>>> changed
>>>>>> to
>>>>>> nfs_set_verifier(dentry, verifier) ?
>>
>> Ugh, yep.
>>
>>>>> ...and on a similar vein: nfs_lookup_revalidate_delegated()
>>>>> needs
>>>>> to
>>>>> change so as to not reset the verifier...
>>>>>
>>>>> Sorry for not catching that one either.
>>>>
>>>> Not my day...
>>>>
>>>> nfs_prime_dcache() will clobber the verifier too in the
>>>> nfs_same_file()
>>>> case. That one also needs to set NFS_DELEGATION_VERF if there is
>>>> a
>>>> delegation.
>>>>
>>>> Perhaps add a helper function for that +
>>>> nfs_lookup_revalidate_dentry()?
>>>
>>> ....and finally, we should remove the call to nfs_set_verifier()
>>> from
>>> nfs4_file_open(). Aside from being incorrect in the case where we
>>> used
>>> an open-by-filehandle, that case is taken care of in the preceding
>>> dentry revalidation.
>>
>> Ok, I'll get these done.  This doesn't make the revalidation code
>> any simpler. I am impressed that you can spot these problems just
>> doing
>> review.  I do wish we could use d_fsdata, seems like exactly the kind
>> of thing we need it for, but is it worth it to do another allocation
>> every
>> time we need a dentry.  I wonder if we're going to end up having more
>> cases like this, or want to have more private information per-dentry.
>>
>> Right now d_fsdata holds the devicename for IS_ROOT, and caches the
>> appropriate info for a delayed removal of silly-renamed files.
>>
>> Problem is that we don't drop the delegation until after caching the
>> silly-rename data, and then we're still doing the same sorts of
>> things
>> trying to figure out what data is in which dentry.
>>
>> Maybe Al would be willing to reserve some of the top of d_flags for
>> filesystems to use privately?
>>
>> Al, can we have such?  NFS already has DCACHE_NFSFS_RENAMED, that
>> could move
>> up above the core d_flags?
>
> I did look into this a few weeks ago, and it seemed to me that we're
> already low on free bits in d_flags.
>
> An alternative might just be to reserve a whole bit in d_time as being
> the 'delegated dentry revalidated' bit. e.g. reserve bit 'BITS_PER_LONG
> - 1' (or just bit '0') for that purpose.

I did look at doing this already for the purposes of making
nfs_force_dir_revalidate() faster than having an if statement in it, and the
neat thing is that the if statement is always faster than any bit shifting
work I came up with - however I was playing with most-significant bits.

Maybe using the least-significant would be faster, then we just do:

nfs_force_lookup_revalidate() {
	nfsi->cache_change_attribute += 2;
}

But, again - what happens when we need another bit?  Is it OK to keep
chopping d_time in half?

What about coming up with a struct for d_fsdata that unionizes the
devicename and the unlink data, and holds our private flags?  The case I am
trying to fix is so rare that we could just do the allocation when it
occurs, and that way we don't have to modify too much of the revalidation
code just to handle it.  It also would give us more flags and private dentry
data if we need it later.

Another option - allow filesystems to do d_alloc, then we could just account
for the space we might need privately.  NFS would have larger dentries, but
VFS could probably drop d_time.  Maybe too big a burden to grow another api
for VFS.

I think I like the "allocate it if you need it" option for d_fsdata best so
far.

Ben

> We would then want to change nfs_set_verifier() to set the verifier in
> the remaining bits, and have it set the delegated dentry revalidated
> bit depending on whether there is a delegation for the inode at the
> time of revalidation.
> We may also want to do the same setting of the delegation bit in
> nfs_verify_change_attribute() when there is a successful match of the
> remaining verifier.
>
> Finally, we should have nfs_mark_delegation_revoked() and
> nfs_start_delegation_return_locked() clear that delegated dentry
> revalidated bit, perhaps by iterating over the inode->i_dentry list?
>
> Note that this has the advantage that since the actual verifier part of
> dentry->d_time can be kept up to date while we hold the delegation, we
> don't have to worry about the dentry getting revalidated for no reason
> after the delegation is returned.
>
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

