Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA77C4D3BA5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiCIVEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 16:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiCIVEV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 16:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7937E52E34
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646859800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PYnE6cWFpeFwqCYBkl2d8YqY19hg85+kU5QEInCELQ=;
        b=LNQYZVnuj3JSWsWEet1QHy9uZ/EBwM3qYYmE4PWQXHXo71rhKLmG9xquC8vGZSx5BhpuTE
        vMnXOhHBbp8J5+QtPHK0T7NoOl05LjjgZMfBVI1oi2eg2V8slehzMXYrnVazHUsBvchDzu
        kvkS3m+0mfN2bqvtWlYQvk0yw5ddik4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-NQrgxo1dP4OHeS5FxUHP0w-1; Wed, 09 Mar 2022 16:03:19 -0500
X-MC-Unique: NQrgxo1dP4OHeS5FxUHP0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 389581006AA6;
        Wed,  9 Mar 2022 21:03:18 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D01CB17DBA;
        Wed,  9 Mar 2022 21:03:17 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Date:   Wed, 09 Mar 2022 16:03:16 -0500
Message-ID: <5870CF24-1E28-42E1-95FE-3E708704B559@redhat.com>
In-Reply-To: <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
 <20220227231227.9038-24-trondmy@kernel.org>
 <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Mar 2022, at 15:01, Benjamin Coddington wrote:

> On 27 Feb 2022, at 18:12, trondmy@kernel.org wrote:
>
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Instead of using a linear index to address the pages, use the cookie 
>> of
>> the first entry, since that is what we use to match the page anyway.
>>
>> This allows us to avoid re-reading the entire cache on a seekdir() 
>> type
>> of operation. The latter is very common when re-exporting NFS, and is 
>> a
>> major performance drain.
>>
>> The change does affect our duplicate cookie detection, since we can 
>> no
>> longer rely on the page index as a linear offset for detecting 
>> whether
>> we looped backwards. However since we no longer do a linear search
>> through all the pages on each call to nfs_readdir(), this is less of 
>> a
>> concern than it was previously.
>> The other downside is that invalidate_mapping_pages() no longer can 
>> use
>> the page index to avoid clearing pages that have been read. A 
>> subsequent
>> patch will restore the functionality this provides to the 'ls -l'
>> heuristic.
>
> I didn't realize the approach was to also hash out the linearly-cached
> entries.  I thought we'd do something like flag the context for hashed 
> page
> indexes after a seekdir event, and if there are collisions with the 
> linear
> entries, they'll get fixed up when found.
>
> Doesn't that mean that with this approach seekdir() only hits the same 
> pages
> when the entry offset is page-aligned?  That's 1 in 127 odds.
>
> It also means we're amplifying the pagecache's useage for slightly 
> changing
> directories - rather than re-using the same pages we're scattering our 
> usage
> across the index.  Eh, maybe not a big deal if we just expect the page
> cache's LRU to do the work.

I don't have a better idea, though.. have you tested this performance?

..

maybe.. the hash divided the u64 cookie space into 262144 buckets, each 
being
a page the cookie could fall into.   So cookies 1 - 70368744177663 map 
into
page 1.. bah.  That wont work.

I was worried that I was wrong about this, but this program shows the
problem by requiring a full READDIR for each entry if we walk the 
entries
one-by-one with lseek().  I don't understand how the re-export seekdir()
case is helped by this unless you're hitting the exact same offsets all 
the
time.

I think that a hash of the page index for seekdir is no better than 
picking
an arbitrary offset, or just using the lowest pages in the cache.

Ben

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <string.h>

#define NFSDIR "/mnt/fedora/127_dentries"

int main(int argc, char **argv)
{
     int i, dir_fd, bpos, total = 0;
     size_t nread;
     struct linux_dirent {
             long           d_ino;
             off_t          d_off;
             unsigned short d_reclen;
             char           d_name[];
     };
     struct linux_dirent *d;
     int buf_size = sizeof(struct linux_dirent) + sizeof("file_000");
     char buf[buf_size];

     /* create files: */
     for (i = 0; i < 127; i++) {
         sprintf(buf, NFSDIR "/file_%03d", i);
         close(open(buf, O_CREAT, 666));
     }

     dir_fd = open(NFSDIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
     if (dir_fd < 0) {
             perror("cannot open dir");
             return 1;
     }

     /* no cache pls */
     posix_fadvise(dir_fd, 0, 0, POSIX_FADV_DONTNEED);

     while (1) {
         nread = syscall(SYS_getdents, dir_fd, buf, buf_size);
         if (nread == 0 || nread == -1)
             break;
         for (bpos = 0; bpos < nread;) {
             d = (struct linux_dirent *) (buf + bpos);
             printf("%s offset %lu\n", d->d_name, d->d_off);

             lseek(dir_fd, 0, SEEK_SET);
             lseek(dir_fd, d->d_off, SEEK_SET);
             total++;
             bpos += d->d_reclen;
         }
     }
     printf("Listing 1: %d total dirents\n", total);

     close(dir_fd);
     return 0;
}

