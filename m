Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2295835015
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFDTAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 15:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFDTAD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 15:00:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23664307D86F;
        Tue,  4 Jun 2019 19:00:03 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 778675DD6D;
        Tue,  4 Jun 2019 19:00:02 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: client skips revalidation if holding a delegation
Date:   Tue, 04 Jun 2019 15:00:01 -0400
Message-ID: <7289561F-686E-4425-B0CE-F3E5800C033D@redhat.com>
In-Reply-To: <a595b6962b2e083fef8ad2d3534e1d0964995560.camel@hammerspace.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
 <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
 <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
 <a595b6962b2e083fef8ad2d3534e1d0964995560.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 04 Jun 2019 19:00:03 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Jun 2019, at 10:53, Trond Myklebust wrote:

> On Tue, 2019-06-04 at 10:10 -0400, Benjamin Coddington wrote:
>> On 4 Jun 2019, at 8:56, Trond Myklebust wrote:
>>
>>> On Tue, 2019-06-04 at 08:41 -0400, Benjamin Coddington wrote:
>>>> Hey linux-nfs, and especially maintainers,
>>>>
>>>> I'm still interested in working on a problem raised a couple
>>>> weeks
>>>> ago, but
>>>> confusion muddled that discussion and it died:
>>>>
>>>> If the client holds a read delegation, it will skip revalidation
>>>> of a
>>>> dentry
>>>> in lookup.  If the file was moved on the server, the client can
>>>> end
>>>> up with
>>>> two positive dentries in cache for the same inode, and the dentry
>>>> that
>>>> doesn't exist on the server will never time out of the cache.
>>>>
>>>> The client can detect this happening because the directory of the
>>>> dentry
>>>> that should be revalidated updates it's change
>>>> attribute.  Skipping
>>>> revalidation is an optimization in the case we hold a delegation,
>>>> but
>>>> this
>>>> optimization should only be used when the delegation was obtained
>>>> via
>>>> a
>>>> lookup of the dentry we are currently revalidating.
>>>>
>>>> Keeping the optimization might be done by tying the delegation to
>>>> the
>>>> dentry.  Lacking some (easy?) way to do that currently, it seems
>>>> simpler to
>>>> remove the optimization altogether, and I will send a patch to
>>>> remove
>>>> it.
>>>
>>> A delegation normally applies to the entire inode. It covers _all_
>>> dentries that point to that inode too because create, rename and
>>> unlink
>>> are always atomically accompanied by an inode change attribute.
>>
>> It should cover all dentries that point to that inode at the time the
>> delegation was handed out.  Shouldn't dentries cached _before_ the
>> delegation be invalidated?  The client doesn't currently care about
>> the
>> order of dentries cached with respect to delegations.
>>
>>> IOW: The proposed restriction is both unnecessary and incorrect.
>>
>> But then I think: need to store that change attribute on the dentry
>> instead
>> of what we currently use - a client-only monotonic counter.  Then, we
>> could
>> compare the delegation's change attr to the dentry's.
>>
>> But that assumes they are both globally related -- that a directory's
>> change_attr on lookup relates to an inode's change attribute.  I
>> don't see
>> that anywhere (I'm looking in 7530)..
>>
>
> OK. Now I think I see what you are saying. This would the case that is
> of interest:
>
> * A directory contains a file "foo", which has a hardlink "bar". Our
> client has both link names cached due to a previous set of lookups.
> * Some other client changes the name of "bar" to "barbar" on the
> server.
> * Our client then opens "foo" and gets a delegation.
> * Our client is then asked to open "bar", and succeeds, failing to
> recognise that it has been renamed to "barbar".
>
> Is that what you mean? That looks like it might happen with the current
> code, and would indeed be a bug.

Yes, that's the problem.  The practical case that was reported to be hitting
it is when `mv` stats source and destination and finds they are the same
file.

> Actually, in the NFSv4.1 open-by-filehandle case, we might even see a
> bug when "foo" is renamed on the server too.

Ok, some relief that you agree this is a bug.

Some ideas for fixing it:

- change d_time to hold the directory's change_attr
from the server, stash that in the (unused?) struct delegation.change_attr

- git rid of the optimization.

- investigate (maybe heuristically discover) whether a directory's
  change_attr is a global counter related to the inode's change_attr.

</hand waving>

At least now I can spend some time on it and not feel aimless, thanks for
the closer look.

Ben
