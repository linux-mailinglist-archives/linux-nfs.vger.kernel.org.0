Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCD14CC31
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgA2OSM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 09:18:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50557 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726177AbgA2OSM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 09:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580307490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlA83ItV5mkHxBXQuqs1ki3+ldYj1oAVurswM7tXlmA=;
        b=Lwsche+B/3AKbsUZkFm5z/eq4Obwy2WyBC8W4erjnmGR4SedMZSOWpIn5XXkKDY0QB0z2i
        1ziVcoYngI6M7KZaohxMVbjCyGoTyBLELRtY13YPSQT1N1hgEYEynt/65BtBHuigbyLNHi
        giZ5Q+F8/Yf6haEF8RJWJJ3mZMODcCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-hcpWumPrP0qhuFBTG6dgSQ-1; Wed, 29 Jan 2020 09:18:05 -0500
X-MC-Unique: hcpWumPrP0qhuFBTG6dgSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 375A113E3;
        Wed, 29 Jan 2020 14:18:04 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85527395;
        Wed, 29 Jan 2020 14:18:03 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     Anna.Schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFS: Revalidate once when holding a delegation
Date:   Wed, 29 Jan 2020 09:18:02 -0500
Message-ID: <A95E0924-D2E8-4D02-951C-36D33070D0CD@redhat.com>
In-Reply-To: <3deb5458d142529c0f23669a1b9edaaf4ad032a5.camel@hammerspace.com>
References: <bcb5ffd399c4434730e6d100a5b7cae5e207244e.1580225161.git.bcodding@redhat.com>
 <9e28aaaff4eae411e0a9d6b94b3d69f7514454cb.camel@hammerspace.com>
 <be1a465a0cf52ddae6d2ba26069dff0500b0ea4b.camel@hammerspace.com>
 <d1600385a53358aa69f6f839987a1b11fa2dd5e8.camel@hammerspace.com>
 <5e157e8a6298ecb640414591988c1e76e8a6fd40.camel@hammerspace.com>
 <3deb5458d142529c0f23669a1b9edaaf4ad032a5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 28 Jan 2020, at 16:46, Trond Myklebust wrote:

> On Tue, 2020-01-28 at 21:30 +0000, Trond Myklebust wrote:
>> On Tue, 2020-01-28 at 16:20 -0500, Trond Myklebust wrote:
>>> On Tue, 2020-01-28 at 15:21 -0500, Trond Myklebust wrote:
>>>> On Tue, 2020-01-28 at 10:56 -0500, Trond Myklebust wrote:
>>>>> On Tue, 2020-01-28 at 10:26 -0500, Benjamin Coddington wrote:
...
>>>>>> +	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
>>>>>> +		verifier = NFS_DELEGATION_VERF;
>>>>>> +	else
>>>>>> +		verifier = nfs_save_change_attribute(dir);
>>>>>> +
>>>>>>  	nfs_setsecurity(inode, fattr, label);
>>>>>>  	nfs_set_verifier(dentry,
>>>>>> nfs_save_change_attribute(dir));
>>>>
>>>> Oops! When reviewing, I missed this. Shouldn't the above be
>>>> changed
>>>> to
>>>> nfs_set_verifier(dentry, verifier) ?

Ugh, yep.

>>> ...and on a similar vein: nfs_lookup_revalidate_delegated() needs
>>> to
>>> change so as to not reset the verifier...
>>>
>>> Sorry for not catching that one either.
>>
>> Not my day...
>>
>> nfs_prime_dcache() will clobber the verifier too in the
>> nfs_same_file()
>> case. That one also needs to set NFS_DELEGATION_VERF if there is a
>> delegation.
>>
>> Perhaps add a helper function for that +
>> nfs_lookup_revalidate_dentry()?
>
> ....and finally, we should remove the call to nfs_set_verifier() from
> nfs4_file_open(). Aside from being incorrect in the case where we used
> an open-by-filehandle, that case is taken care of in the preceding
> dentry revalidation.

Ok, I'll get these done.  This doesn't make the revalidation code
any simpler. I am impressed that you can spot these problems just doing
review.  I do wish we could use d_fsdata, seems like exactly the kind
of thing we need it for, but is it worth it to do another allocation every
time we need a dentry.  I wonder if we're going to end up having more
cases like this, or want to have more private information per-dentry.

Right now d_fsdata holds the devicename for IS_ROOT, and caches the
appropriate info for a delayed removal of silly-renamed files.

Problem is that we don't drop the delegation until after caching the
silly-rename data, and then we're still doing the same sorts of things
trying to figure out what data is in which dentry.

Maybe Al would be willing to reserve some of the top of d_flags for
filesystems to use privately?

Al, can we have such?  NFS already has DCACHE_NFSFS_RENAMED, that could move
up above the core d_flags?

Ben

