Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CCD1F834F
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2020 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgFMMym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Jun 2020 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMMyh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Jun 2020 08:54:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C972C03E96F
        for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2020 05:54:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so12567871wru.0
        for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2020 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8vLLkPBuuAUskqZkG2yEnBrDzgqhFKk/ni1YNMBvZzM=;
        b=NdVvHcQKxIZJHshXMiY5LYbuUHPgpfDrMwYJIUUCyZvzIOepwF4RY9Opy6utsp3M2r
         evzVJovHuuR56qdggWmzLR/zZjqCnARRWDZHlm1iPilzIQ54cUNA5nbZgzNHprud39hn
         v5E0aRPao3KFelQXQ2OFDnr8llFFHx0eKa7gbL1jtzvDVZoZltHeA/vTSVH4zLoB9y0S
         lxdPJfuGCWKFsDDkHKNsKsVzHLSMC3U6HDnT6Ku+/y/5Iwm3gqgcmrYVtGLuZnTaWz+5
         WJGleeVhN+Rzm8Ys1VuZG40H6eSRkNRQgrxaYBbqDfwEykF0MQAjHoC7MZLeoJLsV7RH
         Sqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8vLLkPBuuAUskqZkG2yEnBrDzgqhFKk/ni1YNMBvZzM=;
        b=iD7fgq7kmvkG239E8Z0szxkVmBIY7buPqPJ7+3ogWFjm2lzhZDRahoKUsYLhgQzhvH
         El6JKyUyBTP8d0fC+54QtJMu0jQVtnSGEGD8YLyMEjl4sZi7Be3A6FwrPx51pCrCuaSH
         3EU9TLLBvaOurm2C/GfG+ALM6PU89iKOj21qjmckIbUQ6VqAn0Vm1J+TquRBlKK22pV8
         9vnDlxikkUCbcuQrfhuvZTDgFI25aGqd9p0S4lR2Uc+2+phdI2arZCrsSwib8H6S+lFT
         Y6WDwg2WCVk6T7vtASX+E3OlSM+jAXEuzBlDHLZfPKfWLGPucHWz/4Pbi3d2Ok1cjTli
         wbLQ==
X-Gm-Message-State: AOAM533Kwrrrkn54TWMdHpO7LlyCdfRC9zeAlwso8DPjVaGLd//cmx3O
        XKzNdzUIQKjUXCPidoZ9wsI=
X-Google-Smtp-Source: ABdhPJwJzYU6kOc9vmC4HYwA480O6C8dOug+BelPQqgG3q5SDOSUGqzSrlizzennumdiuGYt7GvJEQ==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr20861829wrs.115.1592052873435;
        Sat, 13 Jun 2020 05:54:33 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id l17sm14904306wrq.17.2020.06.13.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 05:54:32 -0700 (PDT)
Date:   Sat, 13 Jun 2020 14:54:31 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Elliott Mitchell <ehem+debian@m5p.com>
Cc:     962254@bugs.debian.org, linux-nfs@vger.kernel.org,
        bfields@redhat.com, agruenba@redhat.com
Subject: Umask ignored when mounting NFSv4.2 share of an exported ZFS (with
 acltype=off) (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200613125431.GA349352@eldamar.local>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611223711.GA37917@mattapan.m5p.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Elliott,

[I'm adding linux-nfs upstream hopefully J. Bruce Fields or others can
help clarifying]

On Thu, Jun 11, 2020 at 03:37:11PM -0700, Elliott Mitchell wrote:
> Bit more experimentation on this issue.
> 
> I tried a very small C program meant to create files with fewer
> permissions bits set.  This succeeded which strengthens the theory of
> the umask getting ignored.
> 
> I haven't seen anything hinting whether this is more a client or server
> issue.
> 
> I can speculate perhaps somewhere between 4.9 and 4.15 the NFS client
> code stepped closer to proper the "proper" 4.2 protocol.  If a
> corresponding NFS server was slow at getting merged, what we're seeing
> could happen.
> 
> Alternatively someone was trying to get a Linux NFS v4.2 client to work
> better with a different NFS v4.2 server, so they fixed Linux's NFS v4.2
> client.  Yet they failed to test with Linux's v4.2 server.
> 
> 
> This though is speculation.  All I can say is sometime between kernels
> 4.9 and 4.15, NFS v4.2 got broken.  There are hints this is related to
> handling of umask.
 
I was initially confused because of the mentioning of only appearing
with the update to 4.19.118-2 but this is now cleared up, so it shows
up when changing from 4.9.x from stretch to 4.19.x.

Now I'm quite unsure if this should and is to be considered a Linux
kernel issue. What follows is just what I found with respect of the
mentioned behaviour. There is a specific aspect of the NFSv4.2
implementation:

In upstream, with [nfsv4.2-umask-support], [47057abde515] NFSv4.2
support was added. The repsective RFC describing it is [RFC8275].

[nfsv4.2-umask-support]: <https://lore.kernel.org/linux-nfs/1477686228-12158-1-git-send-email-bfields@redhat.com/>
[47057abde515]: <https://git.kernel.org/linus/47057abde515155a4fee53038e7772d6b387e0aa>
[RFC8275]: <https://tools.ietf.org/html/rfc8275>

Since, they allow the umask to be ignored in the presence of
inheritable NFSv4 ACLs.

Now what is or will be confusing is that the behaviour is reproducible
with ZFS default of acltype=off (aclinherit=restricted, sharenfs=off).

Reproducing the issue is easy as follows (all done on Debian unstable
to verify the behaviours can be triggered there as well with more
current 5.6.14-2, zfs-linux on 0.8.4-1):

# zpool create zfs_test /dev/vdb

and exporting /zfs_test in /etc/exports as

/zfs_test 192.168.122.1/24(rw,sync,no_subtree_check,no_root_squash)

The properties of zfs_test would be:

# zfs get acltype,aclinherit,sharenfs zfs_test
NAME      PROPERTY    VALUE          SOURCE
zfs_test  acltype     off            local
zfs_test  aclinherit  restricted     local
zfs_test  sharenfs    off            default

And reproducing then with

# mount -t nfs 192.168.122.150:/zfs_test /mnt
# mkdir /mnt/foo && ls -ld /mnt/foo && rmdir /mnt/foo
drwxrwxrwx 2 root root 2 Jun 13 14:25 /mnt/fo
# umount /mnt

The comment from J. Bruce Fields, in
https://bugzilla.redhat.com/show_bug.cgi?id=1667761#c1 can help debug
it further:

> To start debugging this, I'd recommend looking running wireshark to
> sniff traffic while running your reproducer (mount, mkdir) and
> compare to what's expected from the umask RFC.  Somewhere there
> should be a getattr from the client for the supported_attrs
> attribute, and the reply from the server will probably indicate
> support for the new mode_umask attribute.  If you find the CREATE
> operation that creates the new directory, you should see the client
> set the mode_umask attribute, with the mode part set to the open
> mode and the umask to the process umask.  If those values look
> right, then the problem is likely on the server side.

In fact in sniffing the traffic, there, the gettattr from the client and the
server does indicate support for the new mode_umask. Then later in the CREATE
operation, the client sets the mode_umask attribute, with mode part set to
'0777' and umask to '022'. The mode replied is then as well '0777'.

If further needed to debug we should try to distill a sniff with
wireshark providing the repsective pcap.

https://bugzilla.redhat.com/show_bug.cgi?id=1667761

did not further contain specific information on followups.

https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1779736

indicated this was specifically observed on ZFS on Linux only. Seth
Arnold's answer seem to be inline with that that the issue is more on
the ZFS on Linux side and the issue keeps biting people a bit
unexpectedly. Why does this break with ACL off settings?

But there was at least one other (but again without further
detail/followups) that it was observed on an export from OpenWRT, but
no specific details here:

https://bugs.openwrt.org/index.php?do=details&task_id=2581

Both Debian bugs itself were as well with underlying ZFS filesystem exported:
https://bugs.debian.org/934160
https://bugs.debian.org/962254

Any hint on were to pin-point the issue? Both on Linux anf ZFS on
Linux side or only on one of the components?

Regards,
Salvatore
