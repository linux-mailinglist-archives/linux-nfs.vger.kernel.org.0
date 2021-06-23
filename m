Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4839A3B13C8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 08:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWGRC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 02:17:02 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:60537 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGRC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 02:17:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.200054-0.0233855-0.776561;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KWe18Ox_1624428882;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KWe18Ox_1624428882)
          by smtp.aliyun-inc.com(10.147.43.95);
          Wed, 23 Jun 2021 14:14:43 +0800
Date:   Wed, 23 Jun 2021 14:14:44 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162440994038.28671.7338874000115610814@noble.neil.brown.name>
References: <20210622151407.C002.409509F4@e16-tech.com> <162440994038.28671.7338874000115610814@noble.neil.brown.name>
Message-Id: <20210623141444.C4F2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_60D2C94200000000C4E7_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------_60D2C94200000000C4E7_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

This patch works very well. Thanks a lot.
-  crossmnt of btrfs subvol works as expected.
-  nfs/umount subvol works well.
-  pseudo mount point inode(255) is good.

I test it in 5.10.45 with a few minor rebase.
( see 0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch,
just fs/nfsd/nfs3xdr.c rebase)

But when I tested it with another btrfs system without subvol but with
more data, 'find /nfs/test' caused a OOPS .  and this OOPS will not
happen just without this patch.

The data in this filesystem is created/left by xfstest(FSTYP=nfs,
TEST_DEV).

#nfs4 option: default mount.nfs4, nfs-utils-2.3.3

# access btrfs directly
$ find /mnt/test | wc -l
6612

# access btrfs through nfs
$ find /nfs/test | wc -l

[  466.164329] BUG: kernel NULL pointer dereference, address: 0000000000000004
[  466.172123] #PF: supervisor read access in kernel mode
[  466.177857] #PF: error_code(0x0000) - not-present page
[  466.183601] PGD 0 P4D 0
[  466.186443] Oops: 0000 [#1] SMP NOPTI
[  466.190536] CPU: 27 PID: 1819 Comm: nfsd Not tainted 5.10.45-7.el7.x86_64 #1
[  466.198418] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.0 12/06/2019
[  466.206806] RIP: 0010:fsid_source+0x7/0x50 [nfsd]
[  466.212067] Code: e8 3e f9 ff ff 48 c7 c7 40 5a 90 c0 48 89 c6 e8 18 5a 1f d3 44 8b 14 24 e9 a2 f9 ff ff e9
 f7 3e 03 00 90 0f 1f 44 00 00 31 c0 <80> 7f 04 01 75 2d 0f b6 47 06 48 8b 97 90 00 00 00 84 c0 74 1f 83
[  466.233061] RSP: 0018:ffff9cdd0d3479d0 EFLAGS: 00010246
[  466.238894] RAX: 0000000000000000 RBX: 0000000000010abc RCX: ffff8f50f3049b00
[  466.246872] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
[  466.254848] RBP: ffff9cdd0d347c68 R08: 0000000aaeb00000 R09: 0000000000000001
[  466.262825] R10: 0000000000010000 R11: 0000000000110000 R12: ffff8f30510f8000
[  466.270802] R13: ffff8f4fdabb2090 R14: ffff8f30c0b95600 R15: 0000000000000018
[  466.278779] FS:  0000000000000000(0000) GS:ffff8f5f7fb40000(0000) knlGS:0000000000000000
[  466.287823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  466.294246] CR2: 0000000000000004 CR3: 00000014bfa10003 CR4: 00000000001706e0
[  466.302222] Call Trace:
[  466.304970]  nfsd4_encode_fattr+0x15ac/0x1940 [nfsd]
[  466.310557]  ? btrfs_verify_level_key+0xad/0xf0 [btrfs]
[  466.316413]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
[  466.321973]  nfsd4_encode_dirent+0x160/0x3b0 [nfsd]
[  466.327434]  nfsd_readdir+0x199/0x240 [nfsd]
[  466.332215]  ? nfsd4_encode_getattr+0x30/0x30 [nfsd]
[  466.337771]  ? nfsd_direct_splice_actor+0x20/0x20 [nfsd]
[  466.343714]  ? security_prepare_creds+0x6f/0xa0
[  466.348788]  nfsd4_encode_readdir+0xd9/0x1c0 [nfsd]
[  466.354250]  nfsd4_encode_operation+0x9b/0x1b0 [nfsd]
[  466.360430]  nfsd4_proc_compound+0x4e3/0x710 [nfsd]
[  466.366352]  nfsd_dispatch+0xd4/0x180 [nfsd]
[  466.371620]  svc_process_common+0x392/0x6c0 [sunrpc]
[  466.377650]  ? svc_recv+0x3c4/0x8a0 [sunrpc]
[  466.382883]  ? nfsd_svc+0x300/0x300 [nfsd]
[  466.387908]  ? nfsd_destroy+0x60/0x60 [nfsd]
[  466.393126]  svc_process+0xb7/0xf0 [sunrpc]
[  466.398234]  nfsd+0xe8/0x140 [nfsd]
[  466.402555]  kthread+0x116/0x130
[  466.406579]  ? kthread_park+0x80/0x80
[  466.411091]  ret_from_fork+0x1f/0x30
[  466.415499] Modules linked in: acpi_ipmi rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache rfkill intel_rapl_m
sr intel_rapl_common iTCO_wdt intel_pmc_bxt iTCO_vendor_support dcdbas ipmi_ssif sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_si rapl intel_cstate mei_me ipmi_devintf intel_uncore j
oydev mei ipmi_msghandler lpc_ich acpi_power_meter nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm rdmavt nfsd rdma
_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl lockd grace nfs_ssc ip_tables xfs mgag200
 drm_kms_helper crct10dif_pclmul crc32_pclmul btrfs cec crc32c_intel xor bnx2x raid6_pq drm igb mpt3sas ghash_
clmulni_intel pcspkr nvme megaraid_sas mdio nvme_core dca raid_class i2c_algo_bit scsi_transport_sas wmi dm_mu
ltipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sunrpc i2c_dev
[  466.499551] CR2: 0000000000000004
[  466.503759] ---[ end trace 91eb52bf0cb65801 ]---
[  466.511948] RIP: 0010:fsid_source+0x7/0x50 [nfsd]
[  466.517714] Code: e8 3e f9 ff ff 48 c7 c7 40 5a 90 c0 48 89 c6 e8 18 5a 1f d3 44 8b 14 24 e9 a2 f9 ff ff e9
 f7 3e 03 00 90 0f 1f 44 00 00 31 c0 <80> 7f 04 01 75 2d 0f b6 47 06 48 8b 97 90 00 00 00 84 c0 74 1f 83
[  466.539753] RSP: 0018:ffff9cdd0d3479d0 EFLAGS: 00010246
[  466.546122] RAX: 0000000000000000 RBX: 0000000000010abc RCX: ffff8f50f3049b00
[  466.554625] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000000
[  466.563096] RBP: ffff9cdd0d347c68 R08: 0000000aaeb00000 R09: 0000000000000001
[  466.571572] R10: 0000000000010000 R11: 0000000000110000 R12: ffff8f30510f8000
[  466.580024] R13: ffff8f4fdabb2090 R14: ffff8f30c0b95600 R15: 0000000000000018
[  466.588487] FS:  0000000000000000(0000) GS:ffff8f5f7fb40000(0000) knlGS:0000000000000000
[  466.598032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  466.604973] CR2: 0000000000000004 CR3: 00000014bfa10003 CR4: 00000000001706e0
[  466.613467] Kernel panic - not syncing: Fatal exception
[  466.807651] Kernel Offset: 0x12000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xfffff
fffbfffffff)
[  466.823190] ---[ end Kernel panic - not syncing: Fatal exception ]---


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/23

> On Tue, 22 Jun 2021, Wang Yugui wrote:
> > > 
> > > btrfs subvol should be treated as virtual 'mount point' for nfsd in follow_down().
> > 
> > btrfs subvol crossmnt begin to work, although buggy.
> > 
> > some subvol is crossmnt-ed, some subvol is yet not, and some dir is
> > wrongly crossmnt-ed
> > 
> > 'stat /nfs/test /nfs/test/sub1' will cause btrfs subvol crossmnt begin
> > to happen.
> > 
> > This is the current patch based on 5.10.44. 
> > At least nfsd_follow_up() is buggy.
> > 
> 
> I don't think the approach you are taking makes sense.  Let me explain
> why.
> 
> The problem is that applications on the NFS client can see different
> files or directories on the same (apparent) filesystem with the same
> inode number.  Most application won't care and NFS itself doesn't get
> confused by the duplicate inode numbers, but 'find' and similar programs
> (probably 'tar' for example) do get upset.
> 
> This happens because BTRFS reuses inode numbers in subvols which it
> presents to the kernel as all part of the one filesystem (or at least,
> all part of the one mount point).  NFSD only sees one filesystem, and so
> reports the same filesystem-id (fsid) for all objects.  The NFS client
> then sees that the fsid is the same and tells applications that the
> objects are all in the one filesystem.
> 
> To fix this, we need to make sure that nfsd reports a different fsid for
> objects in different subvols.  There are two obvious ways to do this.
> 
> One is to teach nfsd to recognize btrfs subvolumes exactly like separate
> filesystems (as nfsd already ensure each filesystem gets its own fsid).
> This is the approach of my first suggestion.  It requires changing
> nfsd_mountpoint() and follow_up() and any other code that is aware of
> different filesytems.  As I mentioned, it also requires changing mountd
> to be able to extract a list of subvols from btrfs because they don't
> appear in /proc/mounts.  
> 
> As you might know an NFS filehandle has 3 parts: a header, a filesystem
> identifier, and an inode identifier.  This approach would involve giving
> different subvols different filesystem identifiers in the filehandle.
> This, it turns out is a very big change - bigger than I at first
> imagined.
> 
> The second obvious approach is to leave the filehandles unchanged and to
> continue to treat an entire btrfs filesystem as a single filesystem
> EXCEPT when reporting the fsid to the NFS client.  All we *really* need
> to do is make sure the client sees a different fsid when it enters a
> part of the filesystem which re-uses inode numbers.  This is what my
> latest patch did.
> 
> Your patch seems to combine ideas from both approaches.  It includes my
> code to replace the fsid, but also intercepts follow_up etc.  This
> cannot be useful.
> 
> As I noted when I posted it, there is a problem with my patch.  I now
> understand that problem.
> 
> When NFS sees that fsid change it needs to create 2 inodes for that
> directory.  One inode will be in the parent filesystem and will be
> marked as an auto-mount point so that any lookup below that directory
> will trigger an internal mount.  The other inode is the root of the
> child filesystem.  It gets mounted on the first inode.
> 
> With normal filesystem mounts, there really is an inode in the parent
> filesystem and NFS can find it (with NFSv4) using the MOUNTED_ON_FILEID
> attribute.  This fileid will be different from all other inode numbers
> in the parent filesystem.
> 
> With BTRFS there is no inode in the parent volume (as far as I know) so
> there is nothing useful to return for MOUNTED_ON_FILEID.  This results
> in NFS using the same inode number for the inode in the parent
> filesystem as the inode in the child filesystem.  For btrfs, this will
> be 256.  As there is already an inode in the parent filesystem with inum
> 256, 'find' complains.
> 
> The following patch addresses this by adding code to nfsd when it
> determines MOUINTD_ON_FILEID to choose an number that should be unused
> in btrfs.  With this change, 'find' seems to work correctly with NFSv4
> mounts of btrfs.
> 
> This doesn't work with NFSv3 as NFSv3 doesn't have the MOUNTED_ON_FILEID
> attribute - strictly speaking, the NFSv3 protocol doesn't support
> crossing mount points, though the Linux implementation does allow it.
> 
> So this patch works and, I think, is the best we can do in terms of
> functionality.  I don't like the details of the implementation though.
> It requires NFSD to know too much about BTRFS internals.
> 
> I think I would like btrfs to make it clear where a subvol started,
> maybe by setting DCACHE_MOUNTED on the dentry.  This flag is only a
> hint, not a promise of anything, so other code should get confused.
> This would have nfsd calling vfs_statfs quite so often ....  maybe that
> isn't such a big deal.
> 
> More importantly, there needs to be some way for NFSD to find an inode
> number to report for the MOUNTED_ON_FILEID.  This needs to be a number
> not used elsewhere in the filesystem.  It might be safe to use the
> same fileid for all subvols (as my patch currently does), but we would
> need to confirm that 'find' and 'tar' don't complain about that or
> mishandle it.  If it is safe to use the same fileid, then a new field in
> the superblock to store it might work.  If a different fileid is needed,
> the we might need a new field in 'struct kstatfs', so vfs_statfs can
> report it.
> 
> Anyway, here is my current patch.  It includes support for NFSv3 as well
> as NFSv4.
> 
> NeilBrown
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9421dae22737..790a3357525d 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/namei.h>
>  #include <linux/module.h>
> +#include <linux/statfs.h>
>  #include <linux/exportfs.h>
>  #include <linux/sunrpc/svc_xprt.h>
>  
> @@ -575,6 +576,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
>  	int err;
>  	struct auth_domain *dom = NULL;
>  	struct svc_export exp = {}, *expp;
> +	struct kstatfs statfs;
>  	int an_int;
>  
>  	if (mesg[mlen-1] != '\n')
> @@ -604,6 +606,10 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
>  	err = kern_path(buf, 0, &exp.ex_path);
>  	if (err)
>  		goto out1;
> +	err = vfs_statfs(&exp.ex_path, &statfs);
> +	if (err)
> +		goto out3;
> +	exp.ex_fsid64 = statfs.f_fsid;
>  
>  	exp.ex_client = dom;
>  	exp.cd = cd;
> @@ -809,6 +815,7 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
>  	new->ex_anon_uid = item->ex_anon_uid;
>  	new->ex_anon_gid = item->ex_anon_gid;
>  	new->ex_fsid = item->ex_fsid;
> +	new->ex_fsid64 = item->ex_fsid64;
>  	new->ex_devid_map = item->ex_devid_map;
>  	item->ex_devid_map = NULL;
>  	new->ex_uuid = item->ex_uuid;
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index ee0e3aba4a6e..d3eb9a599918 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -68,6 +68,7 @@ struct svc_export {
>  	kuid_t			ex_anon_uid;
>  	kgid_t			ex_anon_gid;
>  	int			ex_fsid;
> +	__kernel_fsid_t		ex_fsid64;
>  	unsigned char *		ex_uuid; /* 16 byte fsid */
>  	struct nfsd4_fs_locations ex_fslocs;
>  	uint32_t		ex_nflavors;
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0a5ebc52e6a9..f11ba3434fd6 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -367,10 +367,18 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	case FSIDSOURCE_FSID:
>  		fsid = (u64)fhp->fh_export->ex_fsid;
>  		break;
> -	case FSIDSOURCE_UUID:
> +	case FSIDSOURCE_UUID: {
> +		struct kstatfs statfs;
> +
>  		fsid = ((u64 *)fhp->fh_export->ex_uuid)[0];
>  		fsid ^= ((u64 *)fhp->fh_export->ex_uuid)[1];
> +		if (fh_getstafs(fhp, &statfs) == 0 &&
> +		    (statfs.f_fsid.val[0] != fhp->fh_export->ex_fsid64.val[0] ||
> +		     statfs.f_fsid.val[1] != fhp->fh_export->ex_fsid64.val[1]))
> +			/* looks like a btrfs subvol */
> +			fsid = statfs.f_fsid.val[0] ^ statfs.f_fsid.val[1];
>  		break;
> +		}
>  	default:
>  		fsid = (u64)huge_encode_dev(fhp->fh_dentry->d_sb->s_dev);
>  	}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..5f614d1b362e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -42,6 +42,7 @@
>  #include <linux/sunrpc/svcauth_gss.h>
>  #include <linux/sunrpc/addr.h>
>  #include <linux/xattr.h>
> +#include <linux/btrfs_tree.h>
>  #include <uapi/linux/xattr.h>
>  
>  #include "idmap.h"
> @@ -2869,8 +2870,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	if (err)
>  		goto out_nfserr;
>  	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
> +		       FATTR4_WORD0_FSID |
>  			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
>  	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
> +		       FATTR4_WORD1_MOUNTED_ON_FILEID |
>  		       FATTR4_WORD1_SPACE_TOTAL))) {
>  		err = vfs_statfs(&path, &statfs);
>  		if (err)
> @@ -3024,6 +3027,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		case FSIDSOURCE_UUID:
>  			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
>  								EX_UUID_LEN);
> +			if (statfs.f_fsid.val[0] != exp->ex_fsid64.val[0] ||
> +			    statfs.f_fsid.val[1] != exp->ex_fsid64.val[1]) {
> +				/* looks like a btrfs subvol */
> +				p[-2] ^= statfs.f_fsid.val[0];
> +				p[-1] ^= statfs.f_fsid.val[1];
> +			}
>  			break;
>  		}
>  	}
> @@ -3286,6 +3295,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  				goto out_nfserr;
>  			ino = parent_stat.ino;
>  		}
> +		if (fsid_source(fhp) == FSIDSOURCE_UUID &&
> +		    (statfs.f_fsid.val[0] != exp->ex_fsid64.val[0] ||
> +		     statfs.f_fsid.val[1] != exp->ex_fsid64.val[1]))
> +			    /* btrfs subvol pseudo mount point */
> +			    ino = BTRFS_FIRST_FREE_OBJECTID-1;
> +
>  		p = xdr_encode_hyper(p, ino);
>  	}
>  #ifdef CONFIG_NFSD_PNFS
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index b21b76e6b9a8..82b76b0b7bec 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -160,6 +160,13 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
>  				    AT_STATX_SYNC_AS_STAT));
>  }
>  
> +static inline __be32 fh_getstafs(const struct svc_fh *fh, struct kstatfs *statfs)
> +{
> +	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
> +			 .dentry = fh->fh_dentry};
> +	return nfserrno(vfs_statfs(&p, statfs));
> +}
> +
>  static inline int nfsd_create_is_exclusive(int createmode)
>  {
>  	return createmode == NFS3_CREATE_EXCLUSIVE


--------_60D2C94200000000C4E7_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch"
Content-Disposition: attachment;
 filename="0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch"
Content-Transfer-Encoding: base64

RnJvbSA3ZjY3NDg1M2VkZGU3OWYzNzU4OTU4NmVmMjE5Yjg2NTBlNDA5Njc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+CkRhdGU6IFdlZCwg
MjMgSnVuIDIwMjEgMTA6NTk6MDAgKzEwMDAKU3ViamVjdDogW1BBVENIXSBhbnkgaWRlYSBhYm91
dCBhdXRvIGV4cG9ydCBtdWx0aXBsZSBidHJmcyBzbmFwc2hvdHM/CgpPbiBUdWUsIDIyIEp1biAy
MDIxLCBXYW5nIFl1Z3VpIHdyb3RlOgo+ID4KPiA+IGJ0cmZzIHN1YnZvbCBzaG91bGQgYmUgdHJl
YXRlZCBhcyB2aXJ0dWFsICdtb3VudCBwb2ludCcgZm9yIG5mc2QgaW4gZm9sbG93X2Rvd24oKS4K
Pgo+IGJ0cmZzIHN1YnZvbCBjcm9zc21udCBiZWdpbiB0byB3b3JrLCBhbHRob3VnaCBidWdneS4K
Pgo+IHNvbWUgc3Vidm9sIGlzIGNyb3NzbW50LWVkLCBzb21lIHN1YnZvbCBpcyB5ZXQgbm90LCBh
bmQgc29tZSBkaXIgaXMKPiB3cm9uZ2x5IGNyb3NzbW50LWVkCj4KPiAnc3RhdCAvbmZzL3Rlc3Qg
L25mcy90ZXN0L3N1YjEnIHdpbGwgY2F1c2UgYnRyZnMgc3Vidm9sIGNyb3NzbW50IGJlZ2luCj4g
dG8gaGFwcGVuLgo+Cj4gVGhpcyBpcyB0aGUgY3VycmVudCBwYXRjaCBiYXNlZCBvbiA1LjEwLjQ0
Lgo+IEF0IGxlYXN0IG5mc2RfZm9sbG93X3VwKCkgaXMgYnVnZ3kuCj4KCkkgZG9uJ3QgdGhpbmsg
dGhlIGFwcHJvYWNoIHlvdSBhcmUgdGFraW5nIG1ha2VzIHNlbnNlLiAgTGV0IG1lIGV4cGxhaW4K
d2h5LgoKVGhlIHByb2JsZW0gaXMgdGhhdCBhcHBsaWNhdGlvbnMgb24gdGhlIE5GUyBjbGllbnQg
Y2FuIHNlZSBkaWZmZXJlbnQKZmlsZXMgb3IgZGlyZWN0b3JpZXMgb24gdGhlIHNhbWUgKGFwcGFy
ZW50KSBmaWxlc3lzdGVtIHdpdGggdGhlIHNhbWUKaW5vZGUgbnVtYmVyLiAgTW9zdCBhcHBsaWNh
dGlvbiB3b24ndCBjYXJlIGFuZCBORlMgaXRzZWxmIGRvZXNuJ3QgZ2V0CmNvbmZ1c2VkIGJ5IHRo
ZSBkdXBsaWNhdGUgaW5vZGUgbnVtYmVycywgYnV0ICdmaW5kJyBhbmQgc2ltaWxhciBwcm9ncmFt
cwoocHJvYmFibHkgJ3RhcicgZm9yIGV4YW1wbGUpIGRvIGdldCB1cHNldC4KClRoaXMgaGFwcGVu
cyBiZWNhdXNlIEJUUkZTIHJldXNlcyBpbm9kZSBudW1iZXJzIGluIHN1YnZvbHMgd2hpY2ggaXQK
cHJlc2VudHMgdG8gdGhlIGtlcm5lbCBhcyBhbGwgcGFydCBvZiB0aGUgb25lIGZpbGVzeXN0ZW0g
KG9yIGF0IGxlYXN0LAphbGwgcGFydCBvZiB0aGUgb25lIG1vdW50IHBvaW50KS4gIE5GU0Qgb25s
eSBzZWVzIG9uZSBmaWxlc3lzdGVtLCBhbmQgc28KcmVwb3J0cyB0aGUgc2FtZSBmaWxlc3lzdGVt
LWlkIChmc2lkKSBmb3IgYWxsIG9iamVjdHMuICBUaGUgTkZTIGNsaWVudAp0aGVuIHNlZXMgdGhh
dCB0aGUgZnNpZCBpcyB0aGUgc2FtZSBhbmQgdGVsbHMgYXBwbGljYXRpb25zIHRoYXQgdGhlCm9i
amVjdHMgYXJlIGFsbCBpbiB0aGUgb25lIGZpbGVzeXN0ZW0uCgpUbyBmaXggdGhpcywgd2UgbmVl
ZCB0byBtYWtlIHN1cmUgdGhhdCBuZnNkIHJlcG9ydHMgYSBkaWZmZXJlbnQgZnNpZCBmb3IKb2Jq
ZWN0cyBpbiBkaWZmZXJlbnQgc3Vidm9scy4gIFRoZXJlIGFyZSB0d28gb2J2aW91cyB3YXlzIHRv
IGRvIHRoaXMuCgpPbmUgaXMgdG8gdGVhY2ggbmZzZCB0byByZWNvZ25pemUgYnRyZnMgc3Vidm9s
dW1lcyBleGFjdGx5IGxpa2Ugc2VwYXJhdGUKZmlsZXN5c3RlbXMgKGFzIG5mc2QgYWxyZWFkeSBl
bnN1cmUgZWFjaCBmaWxlc3lzdGVtIGdldHMgaXRzIG93biBmc2lkKS4KVGhpcyBpcyB0aGUgYXBw
cm9hY2ggb2YgbXkgZmlyc3Qgc3VnZ2VzdGlvbi4gIEl0IHJlcXVpcmVzIGNoYW5naW5nCm5mc2Rf
bW91bnRwb2ludCgpIGFuZCBmb2xsb3dfdXAoKSBhbmQgYW55IG90aGVyIGNvZGUgdGhhdCBpcyBh
d2FyZSBvZgpkaWZmZXJlbnQgZmlsZXN5dGVtcy4gIEFzIEkgbWVudGlvbmVkLCBpdCBhbHNvIHJl
cXVpcmVzIGNoYW5naW5nIG1vdW50ZAp0byBiZSBhYmxlIHRvIGV4dHJhY3QgYSBsaXN0IG9mIHN1
YnZvbHMgZnJvbSBidHJmcyBiZWNhdXNlIHRoZXkgZG9uJ3QKYXBwZWFyIGluIC9wcm9jL21vdW50
cy4KCkFzIHlvdSBtaWdodCBrbm93IGFuIE5GUyBmaWxlaGFuZGxlIGhhcyAzIHBhcnRzOiBhIGhl
YWRlciwgYSBmaWxlc3lzdGVtCmlkZW50aWZpZXIsIGFuZCBhbiBpbm9kZSBpZGVudGlmaWVyLiAg
VGhpcyBhcHByb2FjaCB3b3VsZCBpbnZvbHZlIGdpdmluZwpkaWZmZXJlbnQgc3Vidm9scyBkaWZm
ZXJlbnQgZmlsZXN5c3RlbSBpZGVudGlmaWVycyBpbiB0aGUgZmlsZWhhbmRsZS4KVGhpcywgaXQg
dHVybnMgb3V0IGlzIGEgdmVyeSBiaWcgY2hhbmdlIC0gYmlnZ2VyIHRoYW4gSSBhdCBmaXJzdApp
bWFnaW5lZC4KClRoZSBzZWNvbmQgb2J2aW91cyBhcHByb2FjaCBpcyB0byBsZWF2ZSB0aGUgZmls
ZWhhbmRsZXMgdW5jaGFuZ2VkIGFuZCB0bwpjb250aW51ZSB0byB0cmVhdCBhbiBlbnRpcmUgYnRy
ZnMgZmlsZXN5c3RlbSBhcyBhIHNpbmdsZSBmaWxlc3lzdGVtCkVYQ0VQVCB3aGVuIHJlcG9ydGlu
ZyB0aGUgZnNpZCB0byB0aGUgTkZTIGNsaWVudC4gIEFsbCB3ZSAqcmVhbGx5KiBuZWVkCnRvIGRv
IGlzIG1ha2Ugc3VyZSB0aGUgY2xpZW50IHNlZXMgYSBkaWZmZXJlbnQgZnNpZCB3aGVuIGl0IGVu
dGVycyBhCnBhcnQgb2YgdGhlIGZpbGVzeXN0ZW0gd2hpY2ggcmUtdXNlcyBpbm9kZSBudW1iZXJz
LiAgVGhpcyBpcyB3aGF0IG15CmxhdGVzdCBwYXRjaCBkaWQuCgpZb3VyIHBhdGNoIHNlZW1zIHRv
IGNvbWJpbmUgaWRlYXMgZnJvbSBib3RoIGFwcHJvYWNoZXMuICBJdCBpbmNsdWRlcyBteQpjb2Rl
IHRvIHJlcGxhY2UgdGhlIGZzaWQsIGJ1dCBhbHNvIGludGVyY2VwdHMgZm9sbG93X3VwIGV0Yy4g
IFRoaXMKY2Fubm90IGJlIHVzZWZ1bC4KCkFzIEkgbm90ZWQgd2hlbiBJIHBvc3RlZCBpdCwgdGhl
cmUgaXMgYSBwcm9ibGVtIHdpdGggbXkgcGF0Y2guICBJIG5vdwp1bmRlcnN0YW5kIHRoYXQgcHJv
YmxlbS4KCldoZW4gTkZTIHNlZXMgdGhhdCBmc2lkIGNoYW5nZSBpdCBuZWVkcyB0byBjcmVhdGUg
MiBpbm9kZXMgZm9yIHRoYXQKZGlyZWN0b3J5LiAgT25lIGlub2RlIHdpbGwgYmUgaW4gdGhlIHBh
cmVudCBmaWxlc3lzdGVtIGFuZCB3aWxsIGJlCm1hcmtlZCBhcyBhbiBhdXRvLW1vdW50IHBvaW50
IHNvIHRoYXQgYW55IGxvb2t1cCBiZWxvdyB0aGF0IGRpcmVjdG9yeQp3aWxsIHRyaWdnZXIgYW4g
aW50ZXJuYWwgbW91bnQuICBUaGUgb3RoZXIgaW5vZGUgaXMgdGhlIHJvb3Qgb2YgdGhlCmNoaWxk
IGZpbGVzeXN0ZW0uICBJdCBnZXRzIG1vdW50ZWQgb24gdGhlIGZpcnN0IGlub2RlLgoKV2l0aCBu
b3JtYWwgZmlsZXN5c3RlbSBtb3VudHMsIHRoZXJlIHJlYWxseSBpcyBhbiBpbm9kZSBpbiB0aGUg
cGFyZW50CmZpbGVzeXN0ZW0gYW5kIE5GUyBjYW4gZmluZCBpdCAod2l0aCBORlN2NCkgdXNpbmcg
dGhlIE1PVU5URURfT05fRklMRUlECmF0dHJpYnV0ZS4gIFRoaXMgZmlsZWlkIHdpbGwgYmUgZGlm
ZmVyZW50IGZyb20gYWxsIG90aGVyIGlub2RlIG51bWJlcnMKaW4gdGhlIHBhcmVudCBmaWxlc3lz
dGVtLgoKV2l0aCBCVFJGUyB0aGVyZSBpcyBubyBpbm9kZSBpbiB0aGUgcGFyZW50IHZvbHVtZSAo
YXMgZmFyIGFzIEkga25vdykgc28KdGhlcmUgaXMgbm90aGluZyB1c2VmdWwgdG8gcmV0dXJuIGZv
ciBNT1VOVEVEX09OX0ZJTEVJRC4gIFRoaXMgcmVzdWx0cwppbiBORlMgdXNpbmcgdGhlIHNhbWUg
aW5vZGUgbnVtYmVyIGZvciB0aGUgaW5vZGUgaW4gdGhlIHBhcmVudApmaWxlc3lzdGVtIGFzIHRo
ZSBpbm9kZSBpbiB0aGUgY2hpbGQgZmlsZXN5c3RlbS4gIEZvciBidHJmcywgdGhpcyB3aWxsCmJl
IDI1Ni4gIEFzIHRoZXJlIGlzIGFscmVhZHkgYW4gaW5vZGUgaW4gdGhlIHBhcmVudCBmaWxlc3lz
dGVtIHdpdGggaW51bQoyNTYsICdmaW5kJyBjb21wbGFpbnMuCgpUaGUgZm9sbG93aW5nIHBhdGNo
IGFkZHJlc3NlcyB0aGlzIGJ5IGFkZGluZyBjb2RlIHRvIG5mc2Qgd2hlbiBpdApkZXRlcm1pbmVz
IE1PVUlOVERfT05fRklMRUlEIHRvIGNob29zZSBhbiBudW1iZXIgdGhhdCBzaG91bGQgYmUgdW51
c2VkCmluIGJ0cmZzLiAgV2l0aCB0aGlzIGNoYW5nZSwgJ2ZpbmQnIHNlZW1zIHRvIHdvcmsgY29y
cmVjdGx5IHdpdGggTkZTdjQKbW91bnRzIG9mIGJ0cmZzLgoKVGhpcyBkb2Vzbid0IHdvcmsgd2l0
aCBORlN2MyBhcyBORlN2MyBkb2Vzbid0IGhhdmUgdGhlIE1PVU5URURfT05fRklMRUlECmF0dHJp
YnV0ZSAtIHN0cmljdGx5IHNwZWFraW5nLCB0aGUgTkZTdjMgcHJvdG9jb2wgZG9lc24ndCBzdXBw
b3J0CmNyb3NzaW5nIG1vdW50IHBvaW50cywgdGhvdWdoIHRoZSBMaW51eCBpbXBsZW1lbnRhdGlv
biBkb2VzIGFsbG93IGl0LgoKU28gdGhpcyBwYXRjaCB3b3JrcyBhbmQsIEkgdGhpbmssIGlzIHRo
ZSBiZXN0IHdlIGNhbiBkbyBpbiB0ZXJtcyBvZgpmdW5jdGlvbmFsaXR5LiAgSSBkb24ndCBsaWtl
IHRoZSBkZXRhaWxzIG9mIHRoZSBpbXBsZW1lbnRhdGlvbiB0aG91Z2guCkl0IHJlcXVpcmVzIE5G
U0QgdG8ga25vdyB0b28gbXVjaCBhYm91dCBCVFJGUyBpbnRlcm5hbHMuCgpJIHRoaW5rIEkgd291
bGQgbGlrZSBidHJmcyB0byBtYWtlIGl0IGNsZWFyIHdoZXJlIGEgc3Vidm9sIHN0YXJ0ZWQsCm1h
eWJlIGJ5IHNldHRpbmcgRENBQ0hFX01PVU5URUQgb24gdGhlIGRlbnRyeS4gIFRoaXMgZmxhZyBp
cyBvbmx5IGEKaGludCwgbm90IGEgcHJvbWlzZSBvZiBhbnl0aGluZywgc28gb3RoZXIgY29kZSBz
aG91bGQgZ2V0IGNvbmZ1c2VkLgpUaGlzIHdvdWxkIGhhdmUgbmZzZCBjYWxsaW5nIHZmc19zdGF0
ZnMgcXVpdGUgc28gb2Z0ZW4gLi4uLiAgbWF5YmUgdGhhdAppc24ndCBzdWNoIGEgYmlnIGRlYWwu
CgpNb3JlIGltcG9ydGFudGx5LCB0aGVyZSBuZWVkcyB0byBiZSBzb21lIHdheSBmb3IgTkZTRCB0
byBmaW5kIGFuIGlub2RlCm51bWJlciB0byByZXBvcnQgZm9yIHRoZSBNT1VOVEVEX09OX0ZJTEVJ
RC4gIFRoaXMgbmVlZHMgdG8gYmUgYSBudW1iZXIKbm90IHVzZWQgZWxzZXdoZXJlIGluIHRoZSBm
aWxlc3lzdGVtLiAgSXQgbWlnaHQgYmUgc2FmZSB0byB1c2UgdGhlCnNhbWUgZmlsZWlkIGZvciBh
bGwgc3Vidm9scyAoYXMgbXkgcGF0Y2ggY3VycmVudGx5IGRvZXMpLCBidXQgd2Ugd291bGQKbmVl
ZCB0byBjb25maXJtIHRoYXQgJ2ZpbmQnIGFuZCAndGFyJyBkb24ndCBjb21wbGFpbiBhYm91dCB0
aGF0IG9yCm1pc2hhbmRsZSBpdC4gIElmIGl0IGlzIHNhZmUgdG8gdXNlIHRoZSBzYW1lIGZpbGVp
ZCwgdGhlbiBhIG5ldyBmaWVsZCBpbgp0aGUgc3VwZXJibG9jayB0byBzdG9yZSBpdCBtaWdodCB3
b3JrLiAgSWYgYSBkaWZmZXJlbnQgZmlsZWlkIGlzIG5lZWRlZCwKdGhlIHdlIG1pZ2h0IG5lZWQg
YSBuZXcgZmllbGQgaW4gJ3N0cnVjdCBrc3RhdGZzJywgc28gdmZzX3N0YXRmcyBjYW4KcmVwb3J0
IGl0LgoKQW55d2F5LCBoZXJlIGlzIG15IGN1cnJlbnQgcGF0Y2guICBJdCBpbmNsdWRlcyBzdXBw
b3J0IGZvciBORlN2MyBhcyB3ZWxsCmFzIE5GU3Y0LgoKTmVpbEJyb3duCi0tLQogZnMvbmZzZC9l
eHBvcnQuYyAgfCAgNyArKysrKysrCiBmcy9uZnNkL2V4cG9ydC5oICB8ICAxICsKIGZzL25mc2Qv
bmZzM3hkci5jIHwgMTAgKysrKysrKysrLQogZnMvbmZzZC9uZnM0eGRyLmMgfCAxNSArKysrKysr
KysrKysrKysKIGZzL25mc2QvdmZzLmggICAgIHwgIDcgKysrKysrKwogNSBmaWxlcyBjaGFuZ2Vk
LCAzOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzZC9l
eHBvcnQuYyBiL2ZzL25mc2QvZXhwb3J0LmMKaW5kZXggOTQyMWRhZTIyNzM3Li43OTBhMzM1NzUy
NWQgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvZXhwb3J0LmMKKysrIGIvZnMvbmZzZC9leHBvcnQuYwpA
QCAtMTUsNiArMTUsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51
eC9uYW1laS5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L3N0
YXRmcy5oPgogI2luY2x1ZGUgPGxpbnV4L2V4cG9ydGZzLmg+CiAjaW5jbHVkZSA8bGludXgvc3Vu
cnBjL3N2Y194cHJ0Lmg+CiAKQEAgLTU3NSw2ICs1NzYsNyBAQCBzdGF0aWMgaW50IHN2Y19leHBv
cnRfcGFyc2Uoc3RydWN0IGNhY2hlX2RldGFpbCAqY2QsIGNoYXIgKm1lc2csIGludCBtbGVuKQog
CWludCBlcnI7CiAJc3RydWN0IGF1dGhfZG9tYWluICpkb20gPSBOVUxMOwogCXN0cnVjdCBzdmNf
ZXhwb3J0IGV4cCA9IHt9LCAqZXhwcDsKKwlzdHJ1Y3Qga3N0YXRmcyBzdGF0ZnM7CiAJaW50IGFu
X2ludDsKIAogCWlmIChtZXNnW21sZW4tMV0gIT0gJ1xuJykKQEAgLTYwNCw2ICs2MDYsMTAgQEAg
c3RhdGljIGludCBzdmNfZXhwb3J0X3BhcnNlKHN0cnVjdCBjYWNoZV9kZXRhaWwgKmNkLCBjaGFy
ICptZXNnLCBpbnQgbWxlbikKIAllcnIgPSBrZXJuX3BhdGgoYnVmLCAwLCAmZXhwLmV4X3BhdGgp
OwogCWlmIChlcnIpCiAJCWdvdG8gb3V0MTsKKwllcnIgPSB2ZnNfc3RhdGZzKCZleHAuZXhfcGF0
aCwgJnN0YXRmcyk7CisJaWYgKGVycikKKwkJZ290byBvdXQzOworCWV4cC5leF9mc2lkNjQgPSBz
dGF0ZnMuZl9mc2lkOwogCiAJZXhwLmV4X2NsaWVudCA9IGRvbTsKIAlleHAuY2QgPSBjZDsKQEAg
LTgwOSw2ICs4MTUsNyBAQCBzdGF0aWMgdm9pZCBleHBvcnRfdXBkYXRlKHN0cnVjdCBjYWNoZV9o
ZWFkICpjbmV3LCBzdHJ1Y3QgY2FjaGVfaGVhZCAqY2l0ZW0pCiAJbmV3LT5leF9hbm9uX3VpZCA9
IGl0ZW0tPmV4X2Fub25fdWlkOwogCW5ldy0+ZXhfYW5vbl9naWQgPSBpdGVtLT5leF9hbm9uX2dp
ZDsKIAluZXctPmV4X2ZzaWQgPSBpdGVtLT5leF9mc2lkOworCW5ldy0+ZXhfZnNpZDY0ID0gaXRl
bS0+ZXhfZnNpZDY0OwogCW5ldy0+ZXhfZGV2aWRfbWFwID0gaXRlbS0+ZXhfZGV2aWRfbWFwOwog
CWl0ZW0tPmV4X2RldmlkX21hcCA9IE5VTEw7CiAJbmV3LT5leF91dWlkID0gaXRlbS0+ZXhfdXVp
ZDsKZGlmZiAtLWdpdCBhL2ZzL25mc2QvZXhwb3J0LmggYi9mcy9uZnNkL2V4cG9ydC5oCmluZGV4
IGVlMGUzYWJhNGE2ZS4uZDNlYjlhNTk5OTE4IDEwMDY0NAotLS0gYS9mcy9uZnNkL2V4cG9ydC5o
CisrKyBiL2ZzL25mc2QvZXhwb3J0LmgKQEAgLTY4LDYgKzY4LDcgQEAgc3RydWN0IHN2Y19leHBv
cnQgewogCWt1aWRfdAkJCWV4X2Fub25fdWlkOwogCWtnaWRfdAkJCWV4X2Fub25fZ2lkOwogCWlu
dAkJCWV4X2ZzaWQ7CisJX19rZXJuZWxfZnNpZF90CQlleF9mc2lkNjQ7CiAJdW5zaWduZWQgY2hh
ciAqCQlleF91dWlkOyAvKiAxNiBieXRlIGZzaWQgKi8KIAlzdHJ1Y3QgbmZzZDRfZnNfbG9jYXRp
b25zIGV4X2ZzbG9jczsKIAl1aW50MzJfdAkJZXhfbmZsYXZvcnM7CmRpZmYgLS1naXQgYS9mcy9u
ZnNkL25mczN4ZHIuYyBiL2ZzL25mc2QvbmZzM3hkci5jCmluZGV4IDBhNWViYzUyZTZhOS4uZjEx
YmEzNDM0ZmQ2IDEwMDY0NAotLS0gYS9mcy9uZnNkL25mczN4ZHIuYworKysgYi9mcy9uZnNkL25m
czN4ZHIuYwpAQCAtMTUzLDExICsxNTMsMTkgQEAgc3RhdGljIF9fYmUzMiAqZW5jb2RlX2ZzaWQo
X19iZTMyICpwLCBzdHJ1Y3Qgc3ZjX2ZoICpmaHApCiAJY2FzZSBGU0lEU09VUkNFX0ZTSUQ6CiAJ
CXAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsICh1NjQpIGZocC0+ZmhfZXhwb3J0LT5leF9mc2lkKTsK
IAkJYnJlYWs7Ci0JY2FzZSBGU0lEU09VUkNFX1VVSUQ6CisJY2FzZSBGU0lEU09VUkNFX1VVSUQ6
IHsKKwkJc3RydWN0IGtzdGF0ZnMgc3RhdGZzOworCiAJCWYgPSAoKHU2NCopZmhwLT5maF9leHBv
cnQtPmV4X3V1aWQpWzBdOwogCQlmIF49ICgodTY0KilmaHAtPmZoX2V4cG9ydC0+ZXhfdXVpZClb
MV07CisJCWlmIChmaF9nZXRzdGFmcyhmaHAsICZzdGF0ZnMpID09IDAgJiYKKwkJICAgIChzdGF0
ZnMuZl9mc2lkLnZhbFswXSAhPSBmaHAtPmZoX2V4cG9ydC0+ZXhfZnNpZDY0LnZhbFswXSB8fAor
CQkgICAgIHN0YXRmcy5mX2ZzaWQudmFsWzFdICE9IGZocC0+ZmhfZXhwb3J0LT5leF9mc2lkNjQu
dmFsWzFdKSkKKwkJCS8qIGxvb2tzIGxpa2UgYSBidHJmcyBzdWJ2b2wgKi8KKwkJCWYgPSBzdGF0
ZnMuZl9mc2lkLnZhbFswXSBeIHN0YXRmcy5mX2ZzaWQudmFsWzFdOwogCQlwID0geGRyX2VuY29k
ZV9oeXBlcihwLCBmKTsKIAkJYnJlYWs7CisJCX0KIAl9CiAJcmV0dXJuIHA7CiB9CmRpZmYgLS1n
aXQgYS9mcy9uZnNkL25mczR4ZHIuYyBiL2ZzL25mc2QvbmZzNHhkci5jCmluZGV4IDdhYmVjY2I5
NzViMi4uNWY2MTRkMWIzNjJlIDEwMDY0NAotLS0gYS9mcy9uZnNkL25mczR4ZHIuYworKysgYi9m
cy9uZnNkL25mczR4ZHIuYwpAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3N1bnJw
Yy9zdmNhdXRoX2dzcy5oPgogI2luY2x1ZGUgPGxpbnV4L3N1bnJwYy9hZGRyLmg+CiAjaW5jbHVk
ZSA8bGludXgveGF0dHIuaD4KKyNpbmNsdWRlIDxsaW51eC9idHJmc190cmVlLmg+CiAjaW5jbHVk
ZSA8dWFwaS9saW51eC94YXR0ci5oPgogCiAjaW5jbHVkZSAiaWRtYXAuaCIKQEAgLTI4NjksOCAr
Mjg3MCwxMCBAQCBuZnNkNF9lbmNvZGVfZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3Ry
dWN0IHN2Y19maCAqZmhwLAogCWlmIChlcnIpCiAJCWdvdG8gb3V0X25mc2VycjsKIAlpZiAoKGJt
dmFsMCAmIChGQVRUUjRfV09SRDBfRklMRVNfQVZBSUwgfCBGQVRUUjRfV09SRDBfRklMRVNfRlJF
RSB8CisJCSAgICAgICBGQVRUUjRfV09SRDBfRlNJRCB8CiAJCQlGQVRUUjRfV09SRDBfRklMRVNf
VE9UQUwgfCBGQVRUUjRfV09SRDBfTUFYTkFNRSkpIHx8CiAJICAgIChibXZhbDEgJiAoRkFUVFI0
X1dPUkQxX1NQQUNFX0FWQUlMIHwgRkFUVFI0X1dPUkQxX1NQQUNFX0ZSRUUgfAorCQkgICAgICAg
RkFUVFI0X1dPUkQxX01PVU5URURfT05fRklMRUlEIHwKIAkJICAgICAgIEZBVFRSNF9XT1JEMV9T
UEFDRV9UT1RBTCkpKSB7CiAJCWVyciA9IHZmc19zdGF0ZnMoJnBhdGgsICZzdGF0ZnMpOwogCQlp
ZiAoZXJyKQpAQCAtMzAyNCw2ICszMDI3LDEyIEBAIG5mc2Q0X2VuY29kZV9mYXR0cihzdHJ1Y3Qg
eGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsCiAJCWNhc2UgRlNJRFNPVVJDRV9V
VUlEOgogCQkJcCA9IHhkcl9lbmNvZGVfb3BhcXVlX2ZpeGVkKHAsIGV4cC0+ZXhfdXVpZCwKIAkJ
CQkJCQkJRVhfVVVJRF9MRU4pOworCQkJaWYgKHN0YXRmcy5mX2ZzaWQudmFsWzBdICE9IGV4cC0+
ZXhfZnNpZDY0LnZhbFswXSB8fAorCQkJICAgIHN0YXRmcy5mX2ZzaWQudmFsWzFdICE9IGV4cC0+
ZXhfZnNpZDY0LnZhbFsxXSkgeworCQkJCS8qIGxvb2tzIGxpa2UgYSBidHJmcyBzdWJ2b2wgKi8K
KwkJCQlwWy0yXSBePSBzdGF0ZnMuZl9mc2lkLnZhbFswXTsKKwkJCQlwWy0xXSBePSBzdGF0ZnMu
Zl9mc2lkLnZhbFsxXTsKKwkJCX0KIAkJCWJyZWFrOwogCQl9CiAJfQpAQCAtMzI4Niw2ICszMjk1
LDEyIEBAIG5mc2Q0X2VuY29kZV9mYXR0cihzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3Qg
c3ZjX2ZoICpmaHAsCiAJCQkJZ290byBvdXRfbmZzZXJyOwogCQkJaW5vID0gcGFyZW50X3N0YXQu
aW5vOwogCQl9CisJCWlmIChmc2lkX3NvdXJjZShmaHApID09IEZTSURTT1VSQ0VfVVVJRCAmJgor
CQkgICAgKHN0YXRmcy5mX2ZzaWQudmFsWzBdICE9IGV4cC0+ZXhfZnNpZDY0LnZhbFswXSB8fAor
CQkgICAgIHN0YXRmcy5mX2ZzaWQudmFsWzFdICE9IGV4cC0+ZXhfZnNpZDY0LnZhbFsxXSkpCisJ
CQkgICAgLyogYnRyZnMgc3Vidm9sIHBzZXVkbyBtb3VudCBwb2ludCAqLworCQkJICAgIGlubyA9
IEJUUkZTX0ZJUlNUX0ZSRUVfT0JKRUNUSUQtMTsKKwogCQlwID0geGRyX2VuY29kZV9oeXBlcihw
LCBpbm8pOwogCX0KICNpZmRlZiBDT05GSUdfTkZTRF9QTkZTCmRpZmYgLS1naXQgYS9mcy9uZnNk
L3Zmcy5oIGIvZnMvbmZzZC92ZnMuaAppbmRleCBiMjFiNzZlNmI5YTguLjgyYjc2YjBiN2JlYyAx
MDA2NDQKLS0tIGEvZnMvbmZzZC92ZnMuaAorKysgYi9mcy9uZnNkL3Zmcy5oCkBAIC0xNjAsNiAr
MTYwLDEzIEBAIHN0YXRpYyBpbmxpbmUgX19iZTMyIGZoX2dldGF0dHIoY29uc3Qgc3RydWN0IHN2
Y19maCAqZmgsIHN0cnVjdCBrc3RhdCAqc3RhdCkKIAkJCQkgICAgQVRfU1RBVFhfU1lOQ19BU19T
VEFUKSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgX19iZTMyIGZoX2dldHN0YWZzKGNvbnN0IHN0cnVj
dCBzdmNfZmggKmZoLCBzdHJ1Y3Qga3N0YXRmcyAqc3RhdGZzKQoreworCXN0cnVjdCBwYXRoIHAg
PSB7Lm1udCA9IGZoLT5maF9leHBvcnQtPmV4X3BhdGgubW50LAorCQkJIC5kZW50cnkgPSBmaC0+
ZmhfZGVudHJ5fTsKKwlyZXR1cm4gbmZzZXJybm8odmZzX3N0YXRmcygmcCwgc3RhdGZzKSk7Cit9
CisKIHN0YXRpYyBpbmxpbmUgaW50IG5mc2RfY3JlYXRlX2lzX2V4Y2x1c2l2ZShpbnQgY3JlYXRl
bW9kZSkKIHsKIAlyZXR1cm4gY3JlYXRlbW9kZSA9PSBORlMzX0NSRUFURV9FWENMVVNJVkUKLS0g
CjIuMzAuMgoK
--------_60D2C94200000000C4E7_MULTIPART_MIXED_--

