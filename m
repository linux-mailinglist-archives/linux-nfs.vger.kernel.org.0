Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3214BCC1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgA1PYg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 10:24:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgA1PYf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 10:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580225075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d5tk6b137UAwT0yRmcmEKGR46Gba29Zlqn4r8gOJ6Qw=;
        b=NTSJG3mttM++bcGf98HUB22v5uY2r2fnLXR1nQlRKcZatkUYza5gyafqc96ly3bqg+EVTr
        04mKfkYmpQDVCerIhjeOLTUhUMNJhlx2gGkQc3UNa4xZmYCZ4wHWjV2YM8UfMSA4Wu88oo
        BYyDa+tRffAwp0GJpB471uTqQLCvkHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Ivp8V0ujP4Sefvyz5VlFKw-1; Tue, 28 Jan 2020 10:24:31 -0500
X-MC-Unique: Ivp8V0ujP4Sefvyz5VlFKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10CC107ACC4;
        Tue, 28 Jan 2020 15:24:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DBEC80894;
        Tue, 28 Jan 2020 15:24:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, Anna.Schumaker@netapp.com
Subject: Re: [PATCH] NFS: Revalidate once when holding a delegation
Date:   Tue, 28 Jan 2020 10:24:28 -0500
Message-ID: <26A91225-96C2-4693-8AD2-20693FB071F7@redhat.com>
In-Reply-To: <859c878cb9c645de0950fae54e59f8c528b54b9e.camel@hammerspace.com>
References: <c65905b1e2fdaddc6271cbf510d7e30c8790de63.1579874894.git.bcodding@redhat.com>
 <ab9d72c908d5c3cecc53ec049572a7675ad12072.camel@hammerspace.com>
 <43817735-6694-406C-A66A-485A716C7FC5@redhat.com>
 <859c878cb9c645de0950fae54e59f8c528b54b9e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Jan 2020, at 14:36, Trond Myklebust wrote:

> On Fri, 2020-01-24 at 20:33 -0500, Benjamin Coddington wrote:
>> On 24 Jan 2020, at 14:24, Trond Myklebust wrote:
>>
>>> On Fri, 2020-01-24 at 09:09 -0500, Benjamin Coddington wrote:
>>>
>>> This patch needs to fix nfs_force_lookup_revalidate() to avoid the
>>> value NFS_DELEGATION_VERF.
>>
>> I don't understand why.  Doesn't nfs_force_lookup_revalidate() just
>> bump the
>> directory's cache_change_attribute, which is value we don't care
>> about at
>> all here.  This patch just sets a magic value on the dentry's d_time
>> after a
>> revalidation occurs for that dentry while holding a delegation.  It
>> doesn't
>> care at all about the directory's change_attr.
>>
>> What am I missing?
>
> Those calls to nfs_set_verifier(dentry, nfs_save_change_attribute(dir))
> are storing the parent directory cache_change_attribute() in the d_time
> field of the child dentry. That's the normal value for the child dentry
> verifiers of that directory when there is no delegation.
>
> So to avoid collisions, you need to ensure that dir-
> cache_change_attribute never takes the value NFS_DELEGATION_VERF.

Ah - of course.  A _complete_ fix.  Thanks for helping me with the obvious.

Ok, after not feeling good about adding a comparison and jump into that path
- maybe its not as big a deal as I'm thinking, but ugh it seems gross for
  just this single case - I wondered about doing this other ways.

As alternatives, I tried to get d_fsdata freed up for this case (there's
already two users of that, it was ugly), and then playing with only some of
the bits in d_time for flags (every approach I tried is slower than just
checking and skipping NFS_DELEGATION_VERF).  I thought maybe we could grow
another d_flag for this sort of thing, but I doubt that will fly.

Oh well, I'll just send a V2 that skips the magic value.

Thanks again,
Ben

