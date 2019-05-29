Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D12E262
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2QjQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 12:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfE2QjQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 12:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBBEC7F7B9;
        Wed, 29 May 2019 16:39:15 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66147600C4;
        Wed, 29 May 2019 16:39:14 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: client lookup_revalidate bug
Date:   Wed, 29 May 2019 12:39:13 -0400
Message-ID: <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
In-Reply-To: <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
 <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 May 2019 16:39:16 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 May 2019, at 12:21, Trond Myklebust wrote:

> On Wed, 2019-05-29 at 11:08 -0400, Benjamin Coddington wrote:
>> Hey, here's an interesting one, this seems wrong:
>>
>> [root@fedora27_c2_v5 ~]# mkdir /mnt/one
>> [root@fedora27_c2_v5 ~]# mkdir /mnt/two
>> [root@fedora27_c2_v5 ~]# mount -t nfs -ov4,noac,sec=sys,nosharecache
>> 192.168.122.50:/exports /mnt/one
>> [root@fedora27_c2_v5 ~]# mount -t nfs -ov4,noac,sec=sys,nosharecache
>> 192.168.122.50:/exports /mnt/two
>> [root@fedora27_c2_v5 ~]# mkdir /mnt/one/A
>> [root@fedora27_c2_v5 ~]# mkdir /mnt/one/B
>> [root@fedora27_c2_v5 ~]# touch /mnt/one/A/foo
>> [root@fedora27_c2_v5 ~]# cat /mnt/two/A/foo
>> [root@fedora27_c2_v5 ~]# mv /mnt/two/A/foo /mnt/two/B/foo
>> [root@fedora27_c2_v5 ~]# mv /mnt/one/B/foo /mnt/one/A/foo
>> [root@fedora27_c2_v5 ~]# cat /mnt/two/A/foo
>> [root@fedora27_c2_v5 ~]# stat /mnt/two/B/foo
>>    File: /mnt/two/B/foo
>>    Size: 0         	Blocks: 0          IO Block: 262144 regular
>> empty
>> file
>> Device: 2fh/47d	Inode: 439603      Links: 1
>> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid:
>> (    0/    root)
>> Context: system_u:object_r:nfs_t:s0
>> Access: 2019-05-28 14:00:18.929663705 -0400
>> Modify: 2019-05-28 14:00:18.929663705 -0400
>> Change: 2019-05-28 14:00:58.990124573 -0400
>>   Birth: -
>>
>>
>> ^^ that lstat should return -ENOENT.
>>
>> I think we detect a stale directory by comparing the directory's
>> change_attr with the dentry's d_time.  But, here's a case where they
>> are
>> the same!
>>
>> Am I wrong about this, or any clever ideas to catch this case?
>>
>
> When you are mounting using 'nosharecache' then you are making /mnt/one
> and /mnt/two act as if they are different filesystems. The fact that
> they are the same on the server, means you are setting up a testcase
> where the files+directories are acting like the "changing on the
> server" case as far as the client is concerned.
>
> If you want the above to work in a sane fashion, then just don't use
> 'nosharecache'.

That was deliberate to avoid having to show two clients in the example..
sorry, I should have been more explicit.

I think the client should be able to detect this case, since it can see an
updated change_attr for that particular directory -- that is
"/mnt/two/B/foo", but maybe it needs to compare the change_attr to its
previous value instead of comparing it to the child's d_time?

The person who reported it has some workload that flips files between
directories on separate clients, and doesn't like it when `mv` reports
"source and destination are the same file".

Ben
