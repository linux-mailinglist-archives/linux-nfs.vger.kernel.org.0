Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9016BC1F
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfGQMI3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 08:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfGQMI3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 08:08:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB98B30842A1;
        Wed, 17 Jul 2019 12:08:28 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7685360BE2;
        Wed, 17 Jul 2019 12:08:28 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Noam Lewis" <noam.lewis@elastifile.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: large directory iteration (getdents) over NFS mount resets due to
 stat
Date:   Wed, 17 Jul 2019 08:08:27 -0400
Message-ID: <6A3988F2-45CB-4C2D-84D6-0D5826E77493@redhat.com>
In-Reply-To: <CALDUuiDG8mKRtH+Zhoc7kQjoKN-SpTn-xaKm=oh+sXHDQ47sug@mail.gmail.com>
References: <CALDUuiDyf5mfNVLeTKHNkU+bTbsKLOoHw_rZm1khcaiep-cEDQ@mail.gmail.com>
 <CALDUuiDG8mKRtH+Zhoc7kQjoKN-SpTn-xaKm=oh+sXHDQ47sug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Jul 2019 12:08:28 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Maybe because we always drop the directory's page cache whenever we 
decide
to switch to READDIRPLUS, even if we're already doing it..  I've not 
tested
or checked very thoroughly if this is ok, but I think maybe want 
something
like this:

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 57b6a45576ad..acfe47668238 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -438,8 +438,8 @@ void nfs_force_use_readdirplus(struct inode *dir)
         struct nfs_inode *nfsi = NFS_I(dir);

         if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
-           !list_empty(&nfsi->open_files)) {
-               set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
+           !list_empty(&nfsi->open_files) &&
+               !test_and_set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags)) 
{
                 invalidate_mapping_pages(dir->i_mapping, 0, -1);
         }
  }

Want to give that a spin?

Ben

On 17 Jul 2019, at 2:44, Noam Lewis wrote:

> I'm starting to think this is a bug. I can't see a good reason why
> accessing (stat) a directory entry should cause the READDIRPLUS cookie
> to be reset.
>
> It seems that the trigger for iteration reset is accessing a directory
> entry that doesn't have a valid entry in the cache. If it does has a
> valid cache entry it doesn't trigger the cookie reset. Note, it
> doesn't matter if the entry (or traversed dir) has actually changed:
> the reset occurs even if both did not change on the server side.
>
> Setting actimeo to a large enough value allows the dir iteration to
> complete without any resets, but this is just a workaround that isn't
> acceptable if the file system is being modified or if there isn't
> enough memory. It's also heuristic and can lead to unexpected hiccups
> if something in the environment changes.
>
> So my questions still stand: is this expected behavior? What's the 
> reason?
>
> P.S. I'm using NFSv3
>
> On Mon, Jul 15, 2019, 08:56 Noam Lewis <noam.lewis@elastifile.com> 
> wrote:
>>
>> I've encountered a problem while iterating large directories via an 
>> NFS mount.
>>
>> Scenario:
>>
>> 1. Linux NFS client iterates a directory with many (millions) of
>> files, e.g. via getdents() until all entries are done. In my case,
>> READDIRPLUS is being used under the hood. Trivial reproduction is to
>> run: ls -la
>> 2. At the same time, run the stat tool on a file inside that 
>> directory.
>>
>> The directory on the server is not being modified anywhere (on this
>> client or any other client).
>>
>> Result: the next or ongoing getdents will get stuck for a long time
>> (tens of seconds to minutes). It appears to be re-iterating some of
>> the work it already did, by going back to a previous NFS READDIRPLUS
>> cookie.
>>
>>
>> Things I've tried as workarounds:
>> - Mounting with nordirplus - the iteration doesn't seem to reset or 
>> at
>> least getdents doesn't get stuck, but now I have tons of LOOKUPs, as
>> expected.
>> - Setting actimeo=(large number) doesn't affect the behavior
>>
>> Questions:
>> 1. Why does the stat command cause this?
>> 2. How can I avoid the reset, i.e. ensure forward progress of the dir 
>> iteration?
