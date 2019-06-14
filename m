Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75F45A66
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfFNK2z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 06:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfFNK2z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 Jun 2019 06:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35C863091782;
        Fri, 14 Jun 2019 10:28:55 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A85860495;
        Fri, 14 Jun 2019 10:28:53 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        trond.myklebust@hammerspace.com,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Don't skip lookup when holding a delegation
Date:   Fri, 14 Jun 2019 06:28:55 -0400
Message-ID: <7A5AA6C0-CA02-49DD-8D80-066B0D83B2F2@redhat.com>
In-Reply-To: <CAN-5tyFzGGFhuFriN=a-U8X1r-A9+q1V6V4XQM_tmbUdFPyFxg@mail.gmail.com>
References: <bcb2d38fe9c9bb15aeb9baa811aeb9a8697ea141.1560348835.git.bcodding@redhat.com>
 <20190613145149.GD2145@fieldses.org>
 <CAN-5tyFzGGFhuFriN=a-U8X1r-A9+q1V6V4XQM_tmbUdFPyFxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 10:28:55 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jun 2019, at 12:02, Olga Kornievskaia wrote:

> On Thu, Jun 13, 2019 at 11:00 AM J. Bruce Fields 
> <bfields@fieldses.org> wrote:
>>
>> On Wed, Jun 12, 2019 at 10:45:13AM -0400, Benjamin Coddington wrote:
>>> If we skip lookup revalidation while holding a delegation, we might 
>>> miss
>>> that the file has changed directories on the server.
>>
>> The delegation should prevent the file disappearing from this 
>> directory,
>> so if I've been following the discussion, the bug was due to 
>> overlooking
>> the case where the change happened before we got the delegation.  
>> Given
>> that history it seems worth calling out that case specifically?
>>
>> Maybe a comment along the lines of:
>>
>>                 /*
>>                  * Note that the file can't move while we hold a
>>                  * delegation.  But this dentry could have been 
>> cached
>>                  * before we got a delegation.  So it's only safe to
>>                  * skip revalidation when the parent directory is
>>                  * unchanged:
>>                  */
>>
>> But maybe there's a pithier way to say that.

I wish I had pith.  I cannot improve on this comment.. I'm OK with or
without it.

> What is preventing the file from disappearing from the directory while
> holding the delegation: is it the server's responsibility to recall
> the delegation when it gets a move or is it client's responsibility
> not to rely on the cached attributes?

The server should recall the delegation if the file moves, since moving 
it
means that additional calls to OPEN that file at that location should 
fail.
The client shouldn't continue to independently handle those OPENs 
(unless by
filehandle.. but how can the server know how the client intends to 
handle
further delegated OPENs?)

> According to this patch it's client's responsibility, in the case, I
> find the working " file can't move" confusing as they imply to me that
> client can assume file isn't moved (ie, server will prevent it from
> happening).

I think that it looks like its the client's responsibility only because 
the
client lacks an easy way to determine what order delegations were 
acquired
with respect to directory modifications.  We could try to track all of 
that,
but the structures and memory used would be hideous.

Ben
