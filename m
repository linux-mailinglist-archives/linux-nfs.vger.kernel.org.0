Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360072FF962
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 01:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbhAVAXb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 19:23:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbhAVAX0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 19:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611274918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCNdPwe/vGutxXQHi2O+fmXXQEjFGkZNWAh0lnTIM5s=;
        b=QHwE3ae7XgNQehmwZOBjVdHE4IwkFjXCEWc3gjiJkLYgKH/WJsxoPn8UdawNPp82nXnABh
        qejnQCoFqxCVjngMISEbjzpRBXWvYRt3WMmKNp+4c4djl2D/djsUQn/NDHSpu/wSYNNJUw
        NjLuBuhIpzPe6SuWE7CyJs1ypaC9sOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-CBbXC33APiq5ek9yadmqXg-1; Thu, 21 Jan 2021 19:21:54 -0500
X-MC-Unique: CBbXC33APiq5ek9yadmqXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B4A107ACE6;
        Fri, 22 Jan 2021 00:21:53 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-130.rdu2.redhat.com [10.10.64.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD60919C59;
        Fri, 22 Jan 2021 00:21:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 04/10] NFS: Keep the readdir pagecache cursor updated
Date:   Thu, 21 Jan 2021 19:21:51 -0500
Message-ID: <7DD58BAC-33C5-4DBA-B692-3FB24186B7E4@redhat.com>
In-Reply-To: <187eb82fa8acad68141d026811945a56cc14b35d.camel@hammerspace.com>
References: <cover.1611160120.git.bcodding@redhat.com>
 <f803021382040dba38ce8414ed1db8e400c0cc49.1611160121.git.bcodding@redhat.com>
 <76fd114e0f4018cf7e00f565759e10acd1f0ba92.camel@hammerspace.com>
 <187eb82fa8acad68141d026811945a56cc14b35d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Jan 2021, at 15:11, Trond Myklebust wrote:

> On Thu, 2021-01-21 at 20:00 +0000, Trond Myklebust wrote:
>> On Wed, 2021-01-20 at 11:59 -0500, Benjamin Coddington wrote:
>>> Whenever we successfully locate our dir_cookie within the
>>> pagecache,
>>> or
>>> finish emitting entries to userspace, update the pagecache cursor. 
>>> These
>>> updates provide marker points to validate pagecache pages in a
>>> future
>>> patch.
>>
>> How isn't this going to end up subject to the exact same problem that
>> Dave Wysochanski's patchset had?
>
> IOW: how is this not also making invalid assumptions around page cache
> layout stability across READDIR calls?

IIRC, Dave's approach was to store the index along with dir_cookie in
order to skip having to re-fill the cache to resume a listing.  That
approach assumed that the index still referred to page data aligned
with the current reader's dir_cookie.  But in between calls to
nfs_readdir() it would be possible for another reader to fill the cache 
with
a different alignment due to directory changes.  In which case the index 
is not
going to point to the next entry, we'll either skip entries or repeat 
them.

With this approach, we don't assume this is the case.  For every page 
with
data, the alignment of the entries is verified to be in the same 
position
as that reader's last pass through.  If not, the page data is discarded 
and
refreshed with a new READDIR op - just like an uncached_readdir path, 
but we
still fill the pagecache.  Every READDIR also updates the change_attr, 
so
even if there are cached pages beyond our current location that match 
our
alignment, we detect the case where those pages are actually invalid due 
to
changes on the server, and we re-fill them.

Another way to think about this is that instead of trying to cache the 
complete
representation of the directory aligned to the first entry in the 
pagecache,
we're instead just caching the results of any READDIR at convenient 
offsets
in the pagecache for other readers that might follow.  The READDIR 
results
are only usable if they match the current version of the directory and 
their
alignment is correct.

If you were to lseek to nearly the end of a directory, the first call to
nfs_readdir() will end up with results of a READDIR hitting the cache 
and
filling page->index 0.  That's ok because any other reader coming along 
with
a different alignment will discard that data and refresh it. We are 
going to
create a performance penalty for two readers that want to regularly fill
entries at different alignments, but I think that case is probably 
fairly
rare.  I am making a guess, but I think the most common usage of readdir 
is
by readers that want to traverse the entire directory in order.

So for that case all the readers benefit from the work of other 
processes,
the cache can be filled in parallel, and readers at the beginning don't
prevent readers at the end from filling in entries.  We no longer have 
to
worry whether we have enough memory to list a directory, or play games 
with
timeouts.

Ben

