Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFB2E2C0
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2RCZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 29 May 2019 13:02:25 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:36725 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2RCY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 13:02:24 -0400
Received: by mail-yw1-f44.google.com with SMTP id e68so1378147ywf.3
        for <linux-nfs@vger.kernel.org>; Wed, 29 May 2019 10:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q0Wd52x7MkOltk0GIxKESXlowmDVIwNNXry3+o+W0aM=;
        b=thBAv9etHmmUqd+Gqse4bNEeLXTP7qa/L0Ja02EmE6dC8vuNVqfZ7LoUszvu8Xpfj+
         H3sBMYS+XDw+PSK8yzfmw/04s257U/wIh4egkHcKxnQmvbYQc+SFAF9Ny2zpV/3ynj2I
         vc0UU5vNwvtpBJHK0rjM4uE+j7qXp967zJm2NHoAxDJSUely3+dnzzV/GP2Q6FIuZp7L
         x+YSYUOmPzIBFCGTdX3SbWqeYI5ufpxllPzNt7J1oGLt6ZQXqunsZzyqBDwwrlGzcZTQ
         xAzKVtjpwSgi8Fus7l0cnnRXPgRu03CiNAJud25OQHvlwHLrYCDV2YmhlHe/LrN0KhOV
         dBKA==
X-Gm-Message-State: APjAAAXeXJoXo47qHSNfGYx69FIFwh24MmgnuKJE24zDgYAbq2ettpUe
        Uyd2iWz/tr8+Cu416cQe+mFWmwfDTiqEQYrA4MqlnIjkiVI=
X-Google-Smtp-Source: APXvYqwaIOfoFEoLX+Ns3NoSkp6Ech+WCpuyAXCC1pdm2zHwgphM2bUDJ9y/Xz2nxK1uvKhhucCzCexNCuj9gtADIpE=
X-Received: by 2002:a81:3a52:: with SMTP id h79mr26347630ywa.271.1559149344075;
 Wed, 29 May 2019 10:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <D4DAB8F2-CAA7-4BC3-B0A0-4EAF5E9DE261@redhat.com>
 <458733948202ed0fddf37cbb79730b5ebdabd551.camel@hammerspace.com> <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
In-Reply-To: <66FFF553-5DEE-4B49-A207-7B0D63FBAECB@redhat.com>
From:   Achilles Gaikwad <agaikwad@redhat.com>
Date:   Wed, 29 May 2019 22:32:12 +0530
Message-ID: <CAK0MK2r6aar7fhBLcEWdfaP_0NAzdxSQsCNinuZvFB71u3vNSw@mail.gmail.com>
Subject: Re: client lookup_revalidate bug
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs@vger.kernel.org, Takayuki Nagata <tnagata@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The file doesn't exist, but when specifying the complete pathname,
nfsv4 thinks that the file already exists.

[...]
#    mv /mnt/nfs/B/f /mnt/nfs/A/f
mv: ‘/mnt/nfs/B/f’ and ‘/mnt/nfs/A/f’ are the same file

# ls -l /mnt/nfs/A/f
-rw-r--r--. 1 nfsnobody nfsnobody 0 May 29 01:59 /mnt/nfs/A/f

# ls -l /mnt/nfs/A/
total 0
[...]

Things I've tried:
1. dropping cache
2. using noac

What mv tries to do is mv ‘/mnt/nfs/B/f’  ‘/mnt/nfs/A/f’, it finds
that the file already exists. This is a bug.
Enabling rpcdbug logs for
   # rpcdebug -m nfs -s pagecache  lookupcache  dircache fscache

[47821.556171] NFS: nfs_lookup_revalidate(A/f) is valid

Best,
- Achilles
---
Reproducer by my colleague @Takayuki Nagata

Steps to Reproduce:
1. Mount a NFSv4 volume with noac on node1 and node2.

[root@node1 ~]# mount -o noac server:/srv/export /mnt/nfs
[root@node2 ~]# mount -o noac server:/srv/export /mnt/nfs

2. Create directories and a file.

[root@node1 ~]# mkdir /mnt/nfs/{A,B}; touch /mnt/nfs/A/f

3. Move the file from A to B on the node1.

[root@node1 ~]# mv /mnt/nfs/A/f /mnt/nfs/B/

4. cat the file on the node2, and move it from B to A.

[root@node2 ~]# cat /mnt/nfs/B/f; mv /mnt/nfs/B/f /mnt/nfs/A/

5. Move it again from A to B on the node1.

[root@node1 ~]# mv /mnt/nfs/A/f /mnt/nfs/B/

6. cat the file again on the node2, and move it from B to A again.

[root@node2 ~]# cat /mnt/nfs/B/f; mv /mnt/nfs/B/f /mnt/nfs/A/
mv: `/mnt/nfs/B/f' and `/mnt/nfs/A/f' are the same file

Best,
- Achilles
---


On Wed, May 29, 2019 at 10:09 PM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 29 May 2019, at 12:21, Trond Myklebust wrote:
>
> > On Wed, 2019-05-29 at 11:08 -0400, Benjamin Coddington wrote:
> >> Hey, here's an interesting one, this seems wrong:
> >>
> >> [root@fedora27_c2_v5 ~]# mkdir /mnt/one
> >> [root@fedora27_c2_v5 ~]# mkdir /mnt/two
> >> [root@fedora27_c2_v5 ~]# mount -t nfs -ov4,noac,sec=sys,nosharecache
> >> 192.168.122.50:/exports /mnt/one
> >> [root@fedora27_c2_v5 ~]# mount -t nfs -ov4,noac,sec=sys,nosharecache
> >> 192.168.122.50:/exports /mnt/two
> >> [root@fedora27_c2_v5 ~]# mkdir /mnt/one/A
> >> [root@fedora27_c2_v5 ~]# mkdir /mnt/one/B
> >> [root@fedora27_c2_v5 ~]# touch /mnt/one/A/foo
> >> [root@fedora27_c2_v5 ~]# cat /mnt/two/A/foo
> >> [root@fedora27_c2_v5 ~]# mv /mnt/two/A/foo /mnt/two/B/foo
> >> [root@fedora27_c2_v5 ~]# mv /mnt/one/B/foo /mnt/one/A/foo
> >> [root@fedora27_c2_v5 ~]# cat /mnt/two/A/foo
> >> [root@fedora27_c2_v5 ~]# stat /mnt/two/B/foo
> >>    File: /mnt/two/B/foo
> >>    Size: 0           Blocks: 0          IO Block: 262144 regular
> >> empty
> >> file
> >> Device: 2fh/47d      Inode: 439603      Links: 1
> >> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid:
> >> (    0/    root)
> >> Context: system_u:object_r:nfs_t:s0
> >> Access: 2019-05-28 14:00:18.929663705 -0400
> >> Modify: 2019-05-28 14:00:18.929663705 -0400
> >> Change: 2019-05-28 14:00:58.990124573 -0400
> >>   Birth: -
> >>
> >>
> >> ^^ that lstat should return -ENOENT.
> >>
> >> I think we detect a stale directory by comparing the directory's
> >> change_attr with the dentry's d_time.  But, here's a case where they
> >> are
> >> the same!
> >>
> >> Am I wrong about this, or any clever ideas to catch this case?
> >>
> >
> > When you are mounting using 'nosharecache' then you are making /mnt/one
> > and /mnt/two act as if they are different filesystems. The fact that
> > they are the same on the server, means you are setting up a testcase
> > where the files+directories are acting like the "changing on the
> > server" case as far as the client is concerned.
> >
> > If you want the above to work in a sane fashion, then just don't use
> > 'nosharecache'.
>
> That was deliberate to avoid having to show two clients in the example..
> sorry, I should have been more explicit.
>
> I think the client should be able to detect this case, since it can see an
> updated change_attr for that particular directory -- that is
> "/mnt/two/B/foo", but maybe it needs to compare the change_attr to its
> previous value instead of comparing it to the child's d_time?
>
> The person who reported it has some workload that flips files between
> directories on separate clients, and doesn't like it when `mv` reports
> "source and destination are the same file".
>
> Ben
