Return-Path: <linux-nfs+bounces-3141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7401D8BA7D8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D785B20D5B
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB071474AB;
	Fri,  3 May 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt22eiuZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE98146D75;
	Fri,  3 May 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721543; cv=none; b=jbtp55EXT70Nsu7Nr15U/IGwVr6cPcktwtyCUCsopzctodCYUdM8nPYjYfiB2f7dJTWXnCEO67HfzcQ4Uah+MVxjoTGP1rJIcwhvKFjbDvLzHW2OnwXXevJ0NxY4fdz+9CwPYhlNOPithTI5U6z2XAmd7UlefanFft7tL/efhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721543; c=relaxed/simple;
	bh=/wcCtlIeTh13HBwXdEzU1rj1/fGksM+XmZoNKBcCYSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJr0kFY5991dOZXcHWx2CAJv/HoWKravE/UEDyzzcKAYxJb8BHESa/f2rlJOUPugUTa4XZsu73Wh+GQ/ymcZIGpeWzwAtdpGjowdS9HoIsZHDWxIUbeSKZLbpi2qvrSy8JeuZkwAT1WhwtWnj54n5q8db6adKDb8HgJ0vHn+AWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt22eiuZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714721541; x=1746257541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wcCtlIeTh13HBwXdEzU1rj1/fGksM+XmZoNKBcCYSo=;
  b=kt22eiuZ6+ds2JBRoQ7mGJopa8AcMpg3jwC5JQmvmhMrZPtI/QGLqbX2
   faRv49PPggOEPFiKROkOowOc/3Zyol+OXJ3IK2aicy6xLaS3SpUQ0d6+f
   IY/3pgCeR9RY6heAQ8+4utQXJkqMd8j8aZN+DUs3qxeR2ik9BCtNth4Dw
   bnMvCR3O2Dgg8pTtJSMmRvPjhk3jw+aAK4LJc7f+mMnCW/03VMjxhDPf+
   ubv0BTGpyLuqAgGbS2IQJ71Vr4x2XUQ2U0SdEZn87Ez5CjPgQFNVrPx6n
   lvAOQzG0l7S1+8zQSzuC2i2Sv7AjhFx8hyAZielV1nU+BoOhw/2egKtLQ
   w==;
X-CSE-ConnectionGUID: SUDwi7S0QTG55l1pZwJPtw==
X-CSE-MsgGUID: FbSl0SrfQbqc9piuYv6iXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10683878"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10683878"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 00:32:21 -0700
X-CSE-ConnectionGUID: TX93ohRkRRiCu459xhKfhg==
X-CSE-MsgGUID: 5PVBgaKZT4aJm9cZbdWpyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27353333"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 May 2024 00:32:18 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2nOx-000BQF-3C;
	Fri, 03 May 2024 07:32:15 +0000
Date: Fri, 3 May 2024 15:31:35 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com, omosnace@redhat.com,
	linux-security-module@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] nfsd: set security label during create operations
Message-ID: <202405031516.kghPPWFt-lkp@intel.com>
References: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502195800.3252-1-stephen.smalley.work@gmail.com>

Hi Stephen,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Smalley/nfsd-set-security-label-during-create-operations/20240503-040242
base:   linus/master
patch link:    https://lore.kernel.org/r/20240502195800.3252-1-stephen.smalley.work%40gmail.com
patch subject: [PATCH v2] nfsd: set security label during create operations
config: arm64-randconfig-r123-20240503 (https://download.01.org/0day-ci/archive/20240503/202405031516.kghPPWFt-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce: (https://download.01.org/0day-ci/archive/20240503/202405031516.kghPPWFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031516.kghPPWFt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/nfsd/nfsproc.c:10:
   In file included from fs/nfsd/cache.h:12:
   In file included from include/linux/sunrpc/svc.h:17:
   In file included from include/linux/sunrpc/xdr.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> fs/nfsd/nfsproc.c:392:24: error: incompatible pointer types passing 'struct iattr *' to parameter of type 'struct nfsd_attrs *' [-Werror,-Wincompatible-pointer-types]
     392 |                 if (nfsd_attrs_valid(attr))
         |                                      ^~~~
   fs/nfsd/vfs.h:63:56: note: passing argument to parameter 'attrs' here
      63 | static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
         |                                                        ^
   5 warnings and 1 error generated.


vim +392 fs/nfsd/nfsproc.c

   240	
   241	/*
   242	 * CREATE processing is complicated. The keyword here is `overloaded.'
   243	 * The parent directory is kept locked between the check for existence
   244	 * and the actual create() call in compliance with VFS protocols.
   245	 * N.B. After this call _both_ argp->fh and resp->fh need an fh_put
   246	 */
   247	static __be32
   248	nfsd_proc_create(struct svc_rqst *rqstp)
   249	{
   250		struct nfsd_createargs *argp = rqstp->rq_argp;
   251		struct nfsd_diropres *resp = rqstp->rq_resp;
   252		svc_fh		*dirfhp = &argp->fh;
   253		svc_fh		*newfhp = &resp->fh;
   254		struct iattr	*attr = &argp->attrs;
   255		struct nfsd_attrs attrs = {
   256			.na_iattr	= attr,
   257		};
   258		struct inode	*inode;
   259		struct dentry	*dchild;
   260		int		type, mode;
   261		int		hosterr;
   262		dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
   263	
   264		dprintk("nfsd: CREATE   %s %.*s\n",
   265			SVCFH_fmt(dirfhp), argp->len, argp->name);
   266	
   267		/* First verify the parent file handle */
   268		resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
   269		if (resp->status != nfs_ok)
   270			goto done; /* must fh_put dirfhp even on error */
   271	
   272		/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
   273	
   274		resp->status = nfserr_exist;
   275		if (isdotent(argp->name, argp->len))
   276			goto done;
   277		hosterr = fh_want_write(dirfhp);
   278		if (hosterr) {
   279			resp->status = nfserrno(hosterr);
   280			goto done;
   281		}
   282	
   283		inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
   284		dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
   285		if (IS_ERR(dchild)) {
   286			resp->status = nfserrno(PTR_ERR(dchild));
   287			goto out_unlock;
   288		}
   289		fh_init(newfhp, NFS_FHSIZE);
   290		resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
   291		if (!resp->status && d_really_is_negative(dchild))
   292			resp->status = nfserr_noent;
   293		dput(dchild);
   294		if (resp->status) {
   295			if (resp->status != nfserr_noent)
   296				goto out_unlock;
   297			/*
   298			 * If the new file handle wasn't verified, we can't tell
   299			 * whether the file exists or not. Time to bail ...
   300			 */
   301			resp->status = nfserr_acces;
   302			if (!newfhp->fh_dentry) {
   303				printk(KERN_WARNING 
   304					"nfsd_proc_create: file handle not verified\n");
   305				goto out_unlock;
   306			}
   307		}
   308	
   309		inode = d_inode(newfhp->fh_dentry);
   310	
   311		/* Unfudge the mode bits */
   312		if (attr->ia_valid & ATTR_MODE) {
   313			type = attr->ia_mode & S_IFMT;
   314			mode = attr->ia_mode & ~S_IFMT;
   315			if (!type) {
   316				/* no type, so if target exists, assume same as that,
   317				 * else assume a file */
   318				if (inode) {
   319					type = inode->i_mode & S_IFMT;
   320					switch(type) {
   321					case S_IFCHR:
   322					case S_IFBLK:
   323						/* reserve rdev for later checking */
   324						rdev = inode->i_rdev;
   325						attr->ia_valid |= ATTR_SIZE;
   326	
   327						fallthrough;
   328					case S_IFIFO:
   329						/* this is probably a permission check..
   330						 * at least IRIX implements perm checking on
   331						 *   echo thing > device-special-file-or-pipe
   332						 * by doing a CREATE with type==0
   333						 */
   334						resp->status = nfsd_permission(rqstp,
   335									 newfhp->fh_export,
   336									 newfhp->fh_dentry,
   337									 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
   338						if (resp->status && resp->status != nfserr_rofs)
   339							goto out_unlock;
   340					}
   341				} else
   342					type = S_IFREG;
   343			}
   344		} else if (inode) {
   345			type = inode->i_mode & S_IFMT;
   346			mode = inode->i_mode & ~S_IFMT;
   347		} else {
   348			type = S_IFREG;
   349			mode = 0;	/* ??? */
   350		}
   351	
   352		attr->ia_valid |= ATTR_MODE;
   353		attr->ia_mode = mode;
   354	
   355		/* Special treatment for non-regular files according to the
   356		 * gospel of sun micro
   357		 */
   358		if (type != S_IFREG) {
   359			if (type != S_IFBLK && type != S_IFCHR) {
   360				rdev = 0;
   361			} else if (type == S_IFCHR && !(attr->ia_valid & ATTR_SIZE)) {
   362				/* If you think you've seen the worst, grok this. */
   363				type = S_IFIFO;
   364			} else {
   365				/* Okay, char or block special */
   366				if (!rdev)
   367					rdev = wanted;
   368			}
   369	
   370			/* we've used the SIZE information, so discard it */
   371			attr->ia_valid &= ~ATTR_SIZE;
   372	
   373			/* Make sure the type and device matches */
   374			resp->status = nfserr_exist;
   375			if (inode && inode_wrong_type(inode, type))
   376				goto out_unlock;
   377		}
   378	
   379		resp->status = nfs_ok;
   380		if (!inode) {
   381			/* File doesn't exist. Create it and set attrs */
   382			resp->status = nfsd_create_locked(rqstp, dirfhp, &attrs, type,
   383							  rdev, newfhp);
   384		} else if (type == S_IFREG) {
   385			dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
   386				argp->name, attr->ia_valid, (long) attr->ia_size);
   387			/* File already exists. We ignore all attributes except
   388			 * size, so that creat() behaves exactly like
   389			 * open(..., O_CREAT|O_TRUNC|O_WRONLY).
   390			 */
   391			attr->ia_valid &= ATTR_SIZE;
 > 392			if (nfsd_attrs_valid(attr))
   393				resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
   394							    NULL);
   395		}
   396	
   397	out_unlock:
   398		inode_unlock(dirfhp->fh_dentry->d_inode);
   399		fh_drop_write(dirfhp);
   400	done:
   401		fh_put(dirfhp);
   402		if (resp->status != nfs_ok)
   403			goto out;
   404		resp->status = fh_getattr(&resp->fh, &resp->stat);
   405	out:
   406		return rpc_success;
   407	}
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

