Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEC13DE5C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 16:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPPNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 10:13:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgAPPNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 10:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579187633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUcwveTOiooHWqdbWNDViWn/M8o8oi8gjp+XFqmlu3Q=;
        b=AqgOXEOdych4imjNeYZUy0eafGWoiiG2s/SLoBLYyB1o4Smdn7e4cvDUhUX7/+NlCJ+9KN
        PcMPYN2btGLGb6LFWqZW4PlLROPd/SHu75QyRZc0TxMXHgyWDqMmLHH4FV543TAC53cUpw
        YocVrYNLB8tSYxrOvQQZOEQKCpK/3o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-e19STbyzPZyRYBeN4LCcNw-1; Thu, 16 Jan 2020 10:13:49 -0500
X-MC-Unique: e19STbyzPZyRYBeN4LCcNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D72EB1005502;
        Thu, 16 Jan 2020 15:13:48 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86489811FF;
        Thu, 16 Jan 2020 15:13:48 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Lookup revalidation for OPEN_CLAIM_FH
Date:   Thu, 16 Jan 2020 10:13:47 -0500
Message-ID: <C69931E7-7465-4662-91AC-C74609A4CDB2@redhat.com>
In-Reply-To: <7eae4162d7c8a85bbb7fddab3a818472ec2ebc54.camel@hammerspace.com>
References: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
 <7eae4162d7c8a85bbb7fddab3a818472ec2ebc54.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Jan 2020, at 9:35, Trond Myklebust wrote:

> On Thu, 2020-01-16 at 08:51 -0500, Benjamin Coddington wrote:
>> Hi Trond,
>>
>> I'd like to fix up lookup revalidation for v4.1+ when the client is
>> using
>> OPEN_CLAIM_FH.  The fixes a while back for Stan Hu's case do not seem
>> to
>> improve things for v4.1, and actually make the behavior a bit worse
>> since we
>> no longer pass through nfs_lookup_verify_inode(), which would catch
>> the
>> cases where nlink == 0.
>>
>> Would you accept work to _always_ revalidate the dentry's parent for
>> CLAIM_FH?  Alternatively, it seems that CLAIM_NULL would be
>> preferable for
>> this case, though I don't know how the client would know when to
>> decide
>> between them.
>>
>> Here's a simple reproducer for convenience, I think we've already all
>> agreed
>> that the behavior we want is for the second open by `cat` to reflect
>> the
>> results of the move on the server, or at least eventually later opens
>> would
>> revalidate the dentry:
>>
>> #!/bin/bash
>>
>> set -o xtrace
>> vers=4.1
>>
>> exportfs -ua
>> exportfs -o rw,sec=sys,no_root_squash *:/exports
>>
>> mkdir /mnt/localhost || true
>>
>> rm -f /exports/file{1,2}
>>
>> echo this is file 1 > /exports/file1
>> echo this is file 2 > /exports/file2
>>
>> mount -t nfs -ov$vers,sec=sys localhost:/exports /mnt/localhost
>>
>> tail -f /mnt/localhost/file1 &
>> sleep 1
>>
>> # this is file 1
>> cat /mnt/localhost/file1
>>
>> # overwrite the file on the server:
>> mv -f /exports/file2 /exports/file1
>>
>> # this is file 2
>> cat /mnt/localhost/file1
>>
>> killall tail
>> # this is file 2
>> cat /mnt/localhost/file1
>> umount /mnt/localhost
>>
>>
>> Switching the $vers variable between v4.0 and v4.1 in this script
>> shows the
>> difference in behavior.
>>
>
> If somebody needs stronger lookup cache revalidation, then that's what
> they have the 'lookupcache=none' mount option for. We have these
> 'lookupcache' mount options in order to allow users to tailor the
> caching behaviour (on a per-mount basis) should the default behaviour
> be insufficiently strict.
>
> Since your testcase doesn't use that mount option, I don't see what it
> is proving other than what we already know about the default lookup
> caching: namely that it sacrifices some accuracy in the interest of
> file open performance.

Thanks for the look.  The testcase only provides a comparison of different
behavior between v4.0 and v4.1, which is due to our use of CLAIM_NULL vs
CLAIM_FH.

Indeed, setting lookupcache=none give real-time updates.  With default
lookupcache, after the directory attributes time out, the client will
likewise get the namespace right.  So, this isn't a major problem, but we do
have some  QE folks that are unhappy about it.

Can we improve things a bit for v4.1 without sacrificing performance?  I
can't think of a reason to not go back to CLAIM_NULL in nfs4_file_open().
Maybe it is a bit more work on the server to have to do one extra lookup per
open, but we'll end up with the right file each time.

It makes sense to keep CLAIM_FH for recovery, but why keep it for regular
opens?

Ben

