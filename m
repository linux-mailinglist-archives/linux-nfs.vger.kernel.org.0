Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC53ACC4B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jun 2021 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhFRNgc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Jun 2021 09:36:32 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:44734 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhFRNg2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Jun 2021 09:36:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04446485|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.184994-0.0132849-0.801721;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KUMy-6a_1624023256;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KUMy-6a_1624023256)
          by smtp.aliyun-inc.com(10.147.42.241);
          Fri, 18 Jun 2021 21:34:17 +0800
Date:   Fri, 18 Jun 2021 21:34:17 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-Reply-To: <20210618152631.F3DE.409509F4@e16-tech.com>
References: <162397637680.29912.2268876490205517592@noble.neil.brown.name> <20210618152631.F3DE.409509F4@e16-tech.com>
Message-Id: <20210618213417.2314.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> > On Thu, 17 Jun 2021, Wang Yugui wrote:
> > > > Can we go back to the beginning.  What, exactly, is the problem you are
> > > > trying to solve?  How can you demonstrate the problem?
> > > > 
> > > > NeilBrown
> > > 
> > > I nfs/exported a btrfs with 2 subvols and 2 snapshot(subvol).
> > > 
> > > # btrfs subvolume list /mnt/test
> > > ID 256 gen 53 top level 5 path sub1
> > > ID 260 gen 56 top level 5 path sub2
> > > ID 261 gen 57 top level 5 path .snapshot/sub1-s1
> > > ID 262 gen 57 top level 5 path .snapshot/sub2-s1
> > > 
> > > and then mount.nfs4 it to /nfs/test.
> > > 
> > > # /bin/find /nfs/test/
> > > /nfs/test/
> > > find: File system loop detected; '/nfs/test/sub1' is part of the same file system loop as '/nfs/test/'.
> > > /nfs/test/.snapshot
> > > find: File system loop detected; '/nfs/test/.snapshot/sub1-s1' is part of the same file system loop as '/nfs/test/'.
> > > find: File system loop detected; '/nfs/test/.snapshot/sub2-s1' is part of the same file system loop as '/nfs/test/'.
> > > /nfs/test/dir1
> > > /nfs/test/dir1/a.txt
> > > find: File system loop detected; '/nfs/test/sub2' is part of the same file system loop as '/nfs/test/'
> > > 
> > > /bin/find report 'File system loop detected'. so I though there is
> > > something wrong.
> > 
> > Certainly something is wrong.  The error message implies that some
> > directory is reporting the same dev an ino as an ancestor directory.
> > Presumably /nfs/test and /nfs/test/sub1.
> > Can you confirm that please. e.g. run the command
> > 
> >    stat /nfs/test /nfs/test/sub1
> > and examine the output.
> 
> # stat /nfs/test /nfs/test/sub1
>   File: /nfs/test
>   Size: 42              Blocks: 32         IO Block: 32768  directory
> Device: 36h/54d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:50:55.409457648 +0800
> Modify: 2021-06-13 10:05:10.830825901 +0800
> Change: 2021-06-13 10:05:10.830825901 +0800
>  Birth: -
>   File: /nfs/test/sub1
>   Size: 8               Blocks: 0          IO Block: 32768  directory
> Device: 36h/54d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:51:14.463621411 +0800
> Modify: 2021-06-12 21:59:10.598089917 +0800
> Change: 2021-06-12 21:59:10.598089917 +0800
>  Birth: -
> 
> same 'Device/Inode' are reported.
> 
> 
> but the local btrfs mount,
> # stat /mnt/test/ /mnt/test/sub1
>   File: /mnt/test/
>   Size: 42              Blocks: 32         IO Block: 4096   directory
> Device: 33h/51d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:50:55.409457648 +0800
> Modify: 2021-06-13 10:05:10.830825901 +0800
> Change: 2021-06-13 10:05:10.830825901 +0800
>  Birth: -
>   File: /mnt/test/sub1
>   Size: 8               Blocks: 0          IO Block: 4096   directory
> Device: 34h/52d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-18 13:51:14.463621411 +0800
> Modify: 2021-06-12 21:59:10.598089917 +0800
> Change: 2021-06-12 21:59:10.598089917 +0800
>  Birth: -
> 
> 'stat' command should cause nfs/crossmnt to happen auto, and then return
> the 'stat' result?
> 
> 
> > As sub1 is considered a different file system, it should have a
> > different dev number.  NFS will assign a different device number only
> > when the server reports a different fsid.  The Linux NFS server will
> > report a different fsid if d_mountpoint() is 'true' for the dentry, and
> > follow_down() results in no change the the vfsmnt,dentry in a 'struct
> > path'.
> > 
> > You have already said that d_mountpoint doesn't work for btrfs, so that
> > is part of the problem.  NFSD doesn't trust d_mountpoint completely as
> > it only reports that the dentry is a mountpoint in some namespace, not
> > necessarily in this namespace.  So you really need to fix
> > nfsd_mountpoint.
> > 
> > I suggest you try adding your "dirty fix" to nfsd_mountpoint() so that
> > it reports the root of a btrfs subvol as a mountpoint, and see if that
> > fixes the problem.  It should change the problem at least.  You would
> > need to get nfsd_mountpoint() to return '1' in this case, not '2'.
> > 
> > NeilBrown
> 
> I changed the return value from 2 to 1.
>         if (nfsd4_is_junction(dentry))
>                 return 1;
> +       if (is_btrfs_subvol_d(dentry))
> +               return 1;
>         if (d_mountpoint(dentry))
> 
> but the crossmnt still does not happen auto.
> 
> I tried to mount the subvol manual, 
> # mount.nfs4 T7610:/mnt/test/sub1 /nfs/test/sub1
> mount.nfs4: Stale file handle
> 
> we add trace to is_btrfs_subvol_d(), it works as expected.
> +static inline bool is_btrfs_subvol_d(const struct dentry *dentry)
> +{
> +    bool ret= dentry->d_inode && dentry->d_inode->i_ino == 256ULL &&
> +		dentry->d_sb && dentry->d_sb->s_magic == 0x9123683E;
> +	printk(KERN_INFO "is_btrfs_subvol_d(%s)=%d\n", dentry->d_name.name, ret);
> +	return ret;
> +}
> 
> It seems more fixes are needed.

for a normal crossmnt,
	/mnt/test			btrfs
	/mn/test/xfs1		xfs
this xfs1 have 2 inode,
1) inode in xfs /mn/test/xfs, as the root.
2) inode in btrfs /mnt/test, as a directory.
when /mn/test/xfs1 is mounted, nfs client with nocrossmnt option will
show 2).

but for a btrfs subvol,
	/mnt/test		btrfs
	/mnt/test/sub1	 btrfs subvol
this sub1 have just 1 inode
1) inode in /mnt/test/sub1, as the root

This difference break the nfs support of btrfs multiple subvol?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/18

