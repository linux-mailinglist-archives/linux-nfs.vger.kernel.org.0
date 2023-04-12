Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6746DF759
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLNgm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLNgl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 09:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE91991
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 06:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE12763533
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 13:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02ECC433D2;
        Wed, 12 Apr 2023 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681306583;
        bh=swLJhG8A6CnU4YIfgLjkQ2v3GWgVg+6+InVd6ifVoH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T7W9WsxFbc78dmOjrchRrKwVrIDVvEpr6LqYcYFX6EGMRpDT+BvNdAvVN5Z4TT/6V
         5oJP+utVBCiFp8oT/8meYKKGZhqP1QxunWBvOIuJQTlIndEM/ipixD1HZjBLyrRxGv
         3bGvzKL4fXYKZ1ojDr7JMApuAu/DRX6rywAaAlaw2XG3NAOAfEI2Ff7V3Gt+f/8FkS
         p1279nvP0Vz0JzxpSdvvdZXiPuwXl7j+vD4QlHZ2UmIuxkkNP5rSj1gazHBbdKhbix
         xVRvLJVqIoaxc328WCMP0r5o4XSNHfRW06YBIz0mY9FXT5HWjNAKVdTdIz2Ykj1C6k
         7jTkUrtKteS8A==
Message-ID: <449f185616ca56c47c767e16db1be364f6c70fc1.camel@kernel.org>
Subject: Re: RFC: umount() fails on an NFS mount ("/A/B") mounted on an
 underlying ("/A") NFS mount when access is removed to the underlying mount
From:   Jeff Layton <jlayton@kernel.org>
To:     David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Wed, 12 Apr 2023 09:36:21 -0400
In-Reply-To: <CALF+zOnizN1KSE=V095LV6Mug8dJirqk7eN1joX8L1-EroohPA@mail.gmail.com>
References: <CALF+zOnizN1KSE=V095LV6Mug8dJirqk7eN1joX8L1-EroohPA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-04-06 at 09:22 -0400, David Wysochanski wrote:
> Anna, Trond, Jeff, Neil, others,
>=20
> This is a RFC post regarding a problem report from a customer.  I am
> not sure this is worth fixing though (look towards the end for a few
> approaches), and maybe a more experienced NFS developer would have
> seen this before and have guidance if this is something worth
> pursuing?  I think this is likely to have been a long outstanding
> issue - the reproducer below works on upstream 6.3-rc5, our RHEL8
> series kernels (4.18 based), as well as RHEL7 series (3.10 based)
> kernels.
>=20
> We had a customer report a failure to remove an autofs mountpoint that
> was mounted on an underlying NFS mount whose access changed on the NFS
> server.  Unfortunately the customer was unable to provide the exact
> steps of what changed, and was unable to provide a full tcpdump or
> kernel trace.  However, they did provide the specific 'umount' output
> and error, which was unusual (see below), as well as output such as
> exports and paths to the underlying mounts.  Based on the information
> the customer provided, we investigated and were able to replicate the
> unique umount error, with a simplified reproducer that does not
> involve autofs.  The reproducer is attached and output is as follows:
> # ./test-non-autofs.sh
> setting exports available
> exporting 127.0.0.1:/exports/dir1
> exporting 127.0.0.1:/exports
> setting exports unavailable
> exporting 1.2.3.4:/exports/dir1
> exporting 1.2.3.4:/exports
> sleeping 60s to let attribute cache expire
> ls: cannot access '/mnt/exports/dir1': Permission denied
> umount.nfs4: /mnt/exports/dir1: block devices not permitted on fs
> TEST FAIL on 6.3.0-rc5-bz2149406+
> output of 'grep 127.0.0.1 /proc/mounts'
> 127.0.0.1:/ /mnt/exports nfs4
> rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,=
proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,local_=
lock=3Dnone,addr=3D127.0.0.1
> 0 0
> 127.0.0.1:/dir1 /mnt/exports/dir1 nfs4
> rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,=
proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,local_=
lock=3Dnone,addr=3D127.0.0.1
> 0 0
> exporting 127.0.0.1:/exports/dir1
> exporting 127.0.0.1:/exports
> #
>=20
> From ftracing the reproducer (attached), the reason the umount
> systemcall fails is due to link_path_walk() failing, which is due to
> access being removed on the dependent mountpoint and the NFS attribute
> cache expiring.  The link_path_walk() will call nfs_permission(), and
> ultimately nfs_revalidate_inode() because the attributes have expired.
> The nfs_revalidate_inode() will fail due to GETATTR call getting an
> NFS server response of AUTH_ERR, which gets sent back up to
> user_path_at() with -EACCESS.  Since user_path_at() fails, the system
> call never gets to path_umount() and thus umount fails.
>=20
> 1915 static int ksys_umount(char __user *name, int flags)
> 1916 {
> 1917         int lookup_flags =3D LOOKUP_MOUNTPOINT;
> 1918         struct path path;
> 1919         int ret;
> 1920
> 1921         // basic validity checks done first
> 1922         if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE |
> UMOUNT_NOFOLLOW))
> 1923                 return -EINVAL;
> 1924
> 1925         if (!(flags & UMOUNT_NOFOLLOW))
> 1926                 lookup_flags |=3D LOOKUP_FOLLOW;
> 1927         ret =3D user_path_at(AT_FDCWD, name, lookup_flags, &path);
> <--- this fails with -13 (EACCESS)
> 1928         if (ret)
> 1929                 return ret;
> 1930         return path_umount(&path, flags);
> 1931 }
> 1932
> 1933 SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
> 1934 {
> 1935         return ksys_umount(name, flags);
> 1936 }
>=20
> To fix this, I initially tried to add/reuse an existing mount flag
> just as a proof of concept, and fail "user_path_at()" with a special
> error code if the flag was set, and continue to path_umount().
> However, this approach does not work (kernel oops) because
> path_umount() requires a valid path structure, and so user_path_at()
> must be successful.
>=20
> The only other approach I thought about is to somehow pass down the
> umount flag all the way down to the NFS layer to nfs_permission(), and
> then essentially have nfs_permission() skip over the call to
> nfs_revalidate_inode() - the flag would essentially say "there is a
> umount in progress, act as though the attributes have not expired on
> this directory inode and skip over refreshing".  Unfortunately it
> looks like I'll need multiple flags at different layers, one that
> controls lookup in the VFS layer, and one down to the NFS layer.  It's
> possible some flags such as LOOKUP_MOUNTPOINT may be re-used, but I'm
> not very optimistic about the idea of patching the VFS layer for such
> a problem.  So in the end, I'm not sure if this is worthwhile, and
> would like some feedback on the above before investigating further.
>=20
> Note that this is the same "cascading mount" configuration that was
> reported recently in another recent thread [1] and described in the
> patch [2] that fixed a similar problem:
> [1] https://lore.kernel.org/linux-nfs/CACH9xG8-tEtWstUVmD9eZFEEAqx-E8Gs14=
wDL+=3DuNtBK=3D-KJvQ@mail.gmail.com/
> [2] https://github.com/torvalds/linux/commit/cc89684c9a265828ce061037f1f7=
9f4a68ccd3f7

Yeah, that's an ugly problem, alright.

Several years ago, we did some work [1] that made umount() skip
revalidation of the leaf dentry. The fs/namei.c code has changed a lot
since then, but I think that the exception still doesn't apply to non-
leaf dentries. They still get revalidated as usual on umount, and of
course are subject to permission checks during the pathwalk.

At the time, the rationale for skipping revalidation of the leaf was
that umount is really a special case, and that all we care about is the
final path component on the local machine. We're disposing of it anyway,
so we really don't care about revalidating the inode at all.

Maybe we could extend that argument to cover all of the path components
during umount? With an umount, what we're really interested in is the
local directory tree at the time that it's called, and any revalidation
of the path at that time is not adding any value.

It _might_ even be reasonable to avoid permission checks on directories
during umount too? Umount is already a privileged operation, so I'm not
sure we gain anything from doing NFS permission checks on intermediate
directories. Again, we're interested in the local directory tree with
umount.

How we'd go about implementing this, I'm not sure though. Maybe we
should widen this discussion to include linux-fsdevel? This might even
be good LSF/MM discussion fodder.

[1]: 8033426e6bdb vfs: allow umount to handle mountpoints without revalidat=
ing them
--=20
Jeff Layton <jlayton@kernel.org>
