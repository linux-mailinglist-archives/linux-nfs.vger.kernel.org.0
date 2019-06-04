Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF19349D0
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfFDOKn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 10:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDOKn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 10:10:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E0BDC1EB1EA;
        Tue,  4 Jun 2019 14:10:43 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C23A352C4;
        Tue,  4 Jun 2019 14:10:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: client skips revalidation if holding a delegation
Date:   Tue, 04 Jun 2019 10:10:40 -0400
Message-ID: <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
In-Reply-To: <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
 <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 04 Jun 2019 14:10:43 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Jun 2019, at 8:56, Trond Myklebust wrote:

> On Tue, 2019-06-04 at 08:41 -0400, Benjamin Coddington wrote:
>> Hey linux-nfs, and especially maintainers,
>>
>> I'm still interested in working on a problem raised a couple weeks
>> ago, but
>> confusion muddled that discussion and it died:
>>
>> If the client holds a read delegation, it will skip revalidation of a
>> dentry
>> in lookup.  If the file was moved on the server, the client can end
>> up with
>> two positive dentries in cache for the same inode, and the dentry
>> that
>> doesn't exist on the server will never time out of the cache.
>>
>> The client can detect this happening because the directory of the
>> dentry
>> that should be revalidated updates it's change attribute.  Skipping
>> revalidation is an optimization in the case we hold a delegation, but
>> this
>> optimization should only be used when the delegation was obtained via
>> a
>> lookup of the dentry we are currently revalidating.
>>
>> Keeping the optimization might be done by tying the delegation to the
>> dentry.  Lacking some (easy?) way to do that currently, it seems
>> simpler to
>> remove the optimization altogether, and I will send a patch to remove
>> it.
>
> A delegation normally applies to the entire inode. It covers _all_
> dentries that point to that inode too because create, rename and unlink
> are always atomically accompanied by an inode change attribute.

It should cover all dentries that point to that inode at the time the
delegation was handed out.  Shouldn't dentries cached _before_ the
delegation be invalidated?  The client doesn't currently care about the
order of dentries cached with respect to delegations.

> IOW: The proposed restriction is both unnecessary and incorrect.

But then I think: need to store that change attribute on the dentry instead
of what we currently use - a client-only monotonic counter.  Then, we could
compare the delegation's change attr to the dentry's.

But that assumes they are both globally related -- that a directory's
change_attr on lookup relates to an inode's change attribute.  I don't see
that anywhere (I'm looking in 7530)..

>> Any thoughts on this?  Any response, even asserting that this is not
>> something
>> we will fix are welcome.

I think, what I am lacking (and I admit to have a tendency to become
fixated) is proper guidance on whether or not work on this front is
acceptable.

I am happy to work on this, but not if my time is wasted.  Help!

Ben
