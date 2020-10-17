Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA30F291047
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Oct 2020 08:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408156AbgJQG7U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Oct 2020 02:59:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36978 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393311AbgJQG7U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Oct 2020 02:59:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09H0nO7T044504;
        Sat, 17 Oct 2020 01:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7w+krdrgwfD3G+q95O39qh+p3vL1oPF0Llx+4xellNA=;
 b=FlK5E/OujW8ntFvWxLbklVFzZpfXYw2ELqTZmSI7WWVGZ4DUmmy/Orfo/mNXrK802Sz6
 cJdf5MkGvP9KJ3qMncCyBNY6qGNbYB2D9tIYrVSeu9i8dD7TRNHf4uGQ9U0+csmuuzjF
 cxWoVnLVbb5t3oJR94vpGrgRur0ExPDbDqhOa/kxcA2KJvFv6krJBQv/unGPwnK5yGUS
 jBvGUYdUbiACfNORjEHcCZ2sGuusX1c+FdcmLuEc/S7gt5MclMtVuZOgwIvMbTkIMgqV
 F0ywZKDFVAwpaDRqXqIPBsK1RyuWl6LQOkWtV78gHrowFgCjLaxMcQdZSz4GNcNO36io uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3434wm47fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 17 Oct 2020 01:11:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09H19naG100875;
        Sat, 17 Oct 2020 01:09:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 347pn882de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Oct 2020 01:09:48 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09H19bTE014526;
        Sat, 17 Oct 2020 01:09:42 GMT
Received: from dhcp-10-154-97-228.vpn.oracle.com (/10.154.97.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Oct 2020 18:09:37 -0700
Subject: Re: [PATCH v3 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20201009062819.92173-2-dai.ngo@oracle.com>
 <20201016175936.GA7332@fieldses.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <675a9261-0be4-a55c-5174-bafd45adf3b4@oracle.com>
Date:   Fri, 16 Oct 2020 18:09:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016175936.GA7332@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=11 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010170003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=11 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010170002
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Bruce for reviewing the patch.
I'll update the patch in v3.

-Dai

On 10/16/20 10:59 AM, J. Bruce Fields wrote:
> On Fri, Oct 09, 2020 at 02:28:19AM -0400, Dai Ngo wrote:
>> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
>> build errors and some configs with NFSD=m to get NFS4ERR_STALE
>> error when doing inter server copy.
>>
>> Added ops table in nfs_common for knfsd to access NFS client modules.
> This looks like a good start, but I think it could be a lot simpler:
>
>> Fixes: 3ac3711adb88 ("NFSD: Fix NFS server build errors")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> changes from v2: fix 0-day build issues.
>> ---
>>   fs/nfs/nfs4file.c       |  40 +++++++++++--
>>   fs/nfs/nfs4super.c      |   6 ++
>>   fs/nfs/super.c          |  20 +++++++
>>   fs/nfs_common/Makefile  |   1 +
>>   fs/nfs_common/nfs_ssc.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/Kconfig         |   2 +-
>>   fs/nfsd/nfs4proc.c      |   3 +-
>>   include/linux/nfs_ssc.h |  77 +++++++++++++++++++++++++
>>   8 files changed, 289 insertions(+), 8 deletions(-)
>>   create mode 100644 fs/nfs_common/nfs_ssc.c
>>   create mode 100644 include/linux/nfs_ssc.h
>>
>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>> index fdfc77486ace..7d242fcb134a 100644
>> --- a/fs/nfs/nfs4file.c
>> +++ b/fs/nfs/nfs4file.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/falloc.h>
>>   #include <linux/mount.h>
>>   #include <linux/nfs_fs.h>
>> +#include <linux/nfs_ssc.h>
>>   #include "delegation.h"
>>   #include "internal.h"
>>   #include "iostat.h"
>> @@ -314,9 +315,8 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
>>   static int read_name_gen = 1;
>>   #define SSC_READ_NAME_BODY "ssc_read_%d"
>>   
>> -struct file *
>> -nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
>> -		nfs4_stateid *stateid)
>> +static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
>> +		struct nfs_fh *src_fh, nfs4_stateid *stateid)
>>   {
>>   	struct nfs_fattr fattr;
>>   	struct file *filep, *res;
>> @@ -398,14 +398,42 @@ struct file *
>>   	fput(filep);
>>   	goto out_free_name;
>>   }
>> -EXPORT_SYMBOL_GPL(nfs42_ssc_open);
>> -void nfs42_ssc_close(struct file *filep)
>> +
>> +static void __nfs42_ssc_close(struct file *filep)
>>   {
>>   	struct nfs_open_context *ctx = nfs_file_open_context(filep);
>>   
>>   	ctx->state->flags = 0;
>>   }
>> -EXPORT_SYMBOL_GPL(nfs42_ssc_close);
>> +
>> +static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
>> +	.sco_owner = THIS_MODULE,
>> +	.sco_open = __nfs42_ssc_open,
>> +	.sco_close = __nfs42_ssc_close,
>> +};
>> +
>> +/**
>> + * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
>> + *
>> + * Return values:
>> + *   On success, returns 0
>> + *   %-EINVAL if validation check fails
>> + */
>> +int nfs42_ssc_register_ops(void)
>> +{
>> +	return nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
>> +}
>> +
>> +/**
>> + * nfs42_ssc_unregister_ops - wrapper to un-register NFS_V4 ops in nfs_common
>> + *
>> + * Return values:
>> + *   None.
>> + */
>> +void nfs42_ssc_unregister_ops(void)
>> +{
>> +	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
>> +}
>>   #endif /* CONFIG_NFS_V4_2 */
>>   
>>   const struct file_operations nfs4_file_operations = {
>> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
>> index 0c1ab846b83d..ed0c1f9fc890 100644
>> --- a/fs/nfs/nfs4super.c
>> +++ b/fs/nfs/nfs4super.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/mount.h>
>>   #include <linux/nfs4_mount.h>
>>   #include <linux/nfs_fs.h>
>> +#include <linux/nfs_ssc.h>
>>   #include "delegation.h"
>>   #include "internal.h"
>>   #include "nfs4_fs.h"
>> @@ -273,6 +274,10 @@ static int __init init_nfs_v4(void)
>>   	err = nfs4_xattr_cache_init();
>>   	if (err)
>>   		goto out2;
>> +
>> +	err = nfs42_ssc_register_ops();
>> +	if (err)
>> +		goto out2;
>>   #endif
>>   
>>   	err = nfs4_register_sysctl();
>> @@ -297,6 +302,7 @@ static void __exit exit_nfs_v4(void)
>>   	unregister_nfs_version(&nfs_v4);
>>   #ifdef CONFIG_NFS_V4_2
>>   	nfs4_xattr_cache_exit();
>> +	nfs42_ssc_unregister_ops();
>>   #endif
>>   	nfs4_unregister_sysctl();
>>   	nfs_idmap_quit();
>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>> index 7a70287f21a2..65636fef6a00 100644
>> --- a/fs/nfs/super.c
>> +++ b/fs/nfs/super.c
>> @@ -57,6 +57,7 @@
>>   #include <linux/rcupdate.h>
>>   
>>   #include <linux/uaccess.h>
>> +#include <linux/nfs_ssc.h>
>>   
>>   #include "nfs4_fs.h"
>>   #include "callback.h"
>> @@ -85,6 +86,11 @@
>>   };
>>   EXPORT_SYMBOL_GPL(nfs_sops);
>>   
>> +static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
>> +	.sco_owner = THIS_MODULE,
>> +	.sco_sb_deactive = nfs_sb_deactive,
>> +};
>> +
>>   #if IS_ENABLED(CONFIG_NFS_V4)
>>   static int __init register_nfs4_fs(void)
>>   {
>> @@ -106,6 +112,16 @@ static void unregister_nfs4_fs(void)
>>   }
>>   #endif
>>   
>> +static int nfs_ssc_register_ops(void)
>> +{
>> +	return nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
>> +}
>> +
>> +static void nfs_ssc_unregister_ops(void)
>> +{
>> +	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
>> +}
>> +
>>   static struct shrinker acl_shrinker = {
>>   	.count_objects	= nfs_access_cache_count,
>>   	.scan_objects	= nfs_access_cache_scan,
>> @@ -133,6 +149,9 @@ int __init register_nfs_fs(void)
>>   	ret = register_shrinker(&acl_shrinker);
>>   	if (ret < 0)
>>   		goto error_3;
>> +	ret = nfs_ssc_register_ops();
>> +	if (ret < 0)
>> +		goto error_3;
>>   	return 0;
>>   error_3:
>>   	nfs_unregister_sysctl();
>> @@ -152,6 +171,7 @@ void __exit unregister_nfs_fs(void)
>>   	unregister_shrinker(&acl_shrinker);
>>   	nfs_unregister_sysctl();
>>   	unregister_nfs4_fs();
>> +	nfs_ssc_unregister_ops();
>>   	unregister_filesystem(&nfs_fs_type);
>>   }
>>   
>> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
>> index 4bebe834c009..fa82f5aaa6d9 100644
>> --- a/fs/nfs_common/Makefile
>> +++ b/fs/nfs_common/Makefile
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
>>   nfs_acl-objs := nfsacl.o
>>   
>>   obj-$(CONFIG_GRACE_PERIOD) += grace.o
>> +obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
>> diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
>> new file mode 100644
>> index 000000000000..6d99a6d2d6b9
>> --- /dev/null
>> +++ b/fs/nfs_common/nfs_ssc.c
>> @@ -0,0 +1,148 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * fs/nfs_common/nfs_ssc_comm.c
>> + *
>> + * Helper for knfsd's SSC to access ops in NFS client modules
>> + *
>> + * Author: Dai Ngo <dai.ngo@oracle.com>
>> + *
>> + * Copyright (c) 2020, Oracle and/or its affiliates.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/fs.h>
>> +#include <linux/nfs_ssc.h>
>> +#include "../nfs/nfs4_fs.h"
>> +
>> +MODULE_LICENSE("GPL");
>> +
>> +/*
>> + * NFS_FS
>> + */
>> +static void nfs_sb_deactive_def(struct super_block *sb);
>> +
>> +static struct nfs_ssc_client_ops nfs_ssc_clnt_ops_def = {
>> +	.sco_owner = THIS_MODULE,
>> +	.sco_sb_deactive = nfs_sb_deactive_def,
>> +};
>> +
>> +/*
>> + * NFS_V4
>> + */
>> +static struct file *nfs42_ssc_open_def(struct vfsmount *ss_mnt,
>> +		struct nfs_fh *src_fh, nfs4_stateid *stateid);
>> +static void nfs42_ssc_close_def(struct file *filep);
>> +
>> +static struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_def = {
>> +	.sco_owner = THIS_MODULE,
>> +	.sco_open = nfs42_ssc_open_def,
>> +	.sco_close = nfs42_ssc_close_def,
>> +};
>> +
>> +
>> +struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl = {
>> +	.ssc_nfs4_ops	= &nfs4_ssc_clnt_ops_def,
>> +	.ssc_nfs_ops = &nfs_ssc_clnt_ops_def
>> +};
>> +EXPORT_SYMBOL_GPL(nfs_ssc_client_tbl);
>> +
>> +
>> +static struct file *nfs42_ssc_open_def(struct vfsmount *ss_mnt,
>> +		struct nfs_fh *src_fh, nfs4_stateid *stateid)
>> +{
>> +	return ERR_PTR(-EIO);
>> +}
>> +
>> +static void nfs42_ssc_close_def(struct file *filep)
>> +{
>> +}
> I don't think we need any of these "_def" ops.  We just shouldn't be
> calling any of these ops in the case the operations aren't loaded.
>
>> +
>> +#ifdef CONFIG_NFS_V4_2
>> +/**
>> + * nfs42_ssc_register - install the NFS_V4 client ops in the nfs_ssc_client_tbl
>> + * @ops: NFS_V4 ops to be installed
>> + *
>> + * Return values:
>> + *   On success, return 0
>> + *   %-EINVAL  if validation check fails
>> + */
>> +int nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops)
>> +{
>> +	if (ops == NULL || ops->sco_open == NULL || ops->sco_close == NULL)
>> +		return -EINVAL;
> This function only has one caller, and we know it won't do these things.
>
> It's not worth the check and the error handling in the caller for
> something so unlikely.
>
>> +	nfs_ssc_client_tbl.ssc_nfs4_ops = ops;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nfs42_ssc_register);
>> +
>> +/**
>> + * nfs42_ssc_unregister - uninstall the NFS_V4 client ops from
>> + *				the nfs_ssc_client_tbl
>> + * @ops: ops to be uninstalled
>> + *
>> + * Return values:
>> + *   None
>> + */
>> +void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops)
>> +{
>> +	if (nfs_ssc_client_tbl.ssc_nfs4_ops != ops)
>> +		return;
>> +
>> +	nfs_ssc_client_tbl.ssc_nfs4_ops = &nfs4_ssc_clnt_ops_def;
>> +}
>> +EXPORT_SYMBOL_GPL(nfs42_ssc_unregister);
>> +#endif /* CONFIG_NFS_V4_2 */
>> +
>> +/*
>> + * NFS_FS
>> + */
>> +static void nfs_sb_deactive_def(struct super_block *sb)
>> +{
>> +}
>> +
>> +#ifdef CONFIG_NFS_V4_2
>> +/**
>> + * nfs_ssc_register - install the NFS_FS client ops in the nfs_ssc_client_tbl
>> + * @ops: NFS_FS ops to be installed
>> + *
>> + * Return values:
>> + *   On success, return 0
>> + *   %-EINVAL  if validation check fails
>> + */
>> +int nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
>> +{
>> +	if (ops == NULL || ops->sco_sb_deactive == NULL)
>> +		return -EINVAL;
> Ditto, let's drop these checks.
>
>> +	nfs_ssc_client_tbl.ssc_nfs_ops = ops;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nfs_ssc_register);
>> +
>> +/**
>> + * nfs_ssc_unregister - uninstall the NFS_FS client ops from
>> + *				the nfs_ssc_client_tbl
>> + * @ops: ops to be uninstalled
>> + *
>> + * Return values:
>> + *   None
>> + */
>> +void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
>> +{
>> +	if (nfs_ssc_client_tbl.ssc_nfs_ops != ops)
>> +		return;
>> +	nfs_ssc_client_tbl.ssc_nfs_ops = &nfs_ssc_clnt_ops_def;
>> +}
>> +EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
>> +
>> +#else
>> +int nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
>> +{
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nfs_ssc_register);
>> +
>> +void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
>> +#endif /* CONFIG_NFS_V4_2 */
>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>> index 99d2cae91bd6..f368f3215f88 100644
>> --- a/fs/nfsd/Kconfig
>> +++ b/fs/nfsd/Kconfig
>> @@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
>>   
>>   config NFSD_V4_2_INTER_SSC
>>   	bool "NFSv4.2 inter server to server COPY"
>> -	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
>> +	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
>>   	help
>>   	  This option enables support for NFSv4.2 inter server to
>>   	  server copy where the destination server calls the NFSv4.2
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index eaf50eafa935..84e10aef1417 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -38,6 +38,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/kthread.h>
>>   #include <linux/sunrpc/addr.h>
>> +#include <linux/nfs_ssc.h>
>>   
>>   #include "idmap.h"
>>   #include "cache.h"
>> @@ -1247,7 +1248,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>   static void
>>   nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>   {
>> -	nfs_sb_deactive(ss_mnt->mnt_sb);
>> +	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>   	mntput(ss_mnt);
>>   }
>>   
>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>> new file mode 100644
>> index 000000000000..45a763bd6b0b
>> --- /dev/null
>> +++ b/include/linux/nfs_ssc.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * include/linux/nfs_ssc.h
>> + *
>> + * Author: Dai Ngo <dai.ngo@oracle.com>
>> + *
>> + * Copyright (c) 2020, Oracle and/or its affiliates.
>> + */
>> +
>> +#include <linux/nfs_fs.h>
>> +
>> +extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>> +
>> +/*
>> + * NFS_V4
>> + */
>> +struct nfs4_ssc_client_ops {
>> +	struct module *sco_owner;
>> +	struct file *(*sco_open)(struct vfsmount *ss_mnt,
>> +		struct nfs_fh *src_fh, nfs4_stateid *stateid);
>> +	void (*sco_close)(struct file *filep);
>> +};
>> +
>> +/*
>> + * NFS_FS
>> + */
>> +struct nfs_ssc_client_ops {
>> +	struct module *sco_owner;
>> +	void (*sco_sb_deactive)(struct super_block *sb);
>> +};
>> +
>> +struct nfs_ssc_client_ops_tbl {
>> +	const struct nfs4_ssc_client_ops *ssc_nfs4_ops;
>> +	const struct nfs_ssc_client_ops *ssc_nfs_ops;
>> +};
>> +
>> +extern int nfs42_ssc_register_ops(void);
>> +extern void nfs42_ssc_unregister_ops(void);
>> +
>> +extern int nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops);
>> +extern void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops);
>> +
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +static inline struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>> +		struct nfs_fh *src_fh, nfs4_stateid *stateid)
>> +{
>> +	struct file *file;
>> +
>> +	if (!try_module_get(nfs_ssc_client_tbl.ssc_nfs4_ops->sco_owner))
>> +		return ERR_PTR(-EIO);
> The module load already happened back when we did the get_fs_type in
> nfsd4_interssc_connect(), and it's not going away at this point (or
> there's something already terribly wrong with ss_mnt).
>
> So I don't think we need any try_module_get()s or module_put()s.
>
> --b.
>
>> +	file = (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_open)(ss_mnt, src_fh, stateid);
>> +	module_put(nfs_ssc_client_tbl.ssc_nfs4_ops->sco_owner);
>> +	return file;
>> +}
>> +
>> +static inline void nfs42_ssc_close(struct file *filep)
>> +{
>> +	if (!try_module_get(nfs_ssc_client_tbl.ssc_nfs4_ops->sco_owner))
>> +		return;
>> +	(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>> +	module_put(nfs_ssc_client_tbl.ssc_nfs4_ops->sco_owner);
>> +}
>> +#endif
>> +
>> +/*
>> + * NFS_FS
>> + */
>> +extern int nfs_ssc_register(const struct nfs_ssc_client_ops *ops);
>> +extern void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops);
>> +
>> +static inline void nfs_do_sb_deactive(struct super_block *sb)
>> +{
>> +	if (!try_module_get(nfs_ssc_client_tbl.ssc_nfs_ops->sco_owner))
>> +		return;
>> +	(*nfs_ssc_client_tbl.ssc_nfs_ops->sco_sb_deactive)(sb);
>> +	module_put(nfs_ssc_client_tbl.ssc_nfs_ops->sco_owner);
>> +}
>> -- 
>> 1.8.3.1
