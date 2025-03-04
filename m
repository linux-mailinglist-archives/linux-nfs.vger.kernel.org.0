Return-Path: <linux-nfs+bounces-10447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74163A4D54F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 08:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8921D1695BF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1C1FAC59;
	Tue,  4 Mar 2025 07:46:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF61F63F5
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074380; cv=none; b=oBhNjrV3LKJZUfYShhEWzjaM7fP1SBH02R2z5L+Uxl4XyRi/+GF0SOKWMc95Zx4ePcjK+0Ou+sCkhPR6vBrSn5vgoAU3NKhGyCv76bumn0PXP62/l4hGUXKrv+wiyIpvlAugvg/6EgXbH2W/eEbAFVGjtqDKFXfrqjW0u3Cwr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074380; c=relaxed/simple;
	bh=CWjfxo+lqepkcZy7RY8Q0t4CY4gywe5o14w1KPriLCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=FSgYMtbGfGD5JoQ7dHg+sFlqDgNgMsauHc6au6NR0Uiwa2LKixx+Jm4YOS55Ui23ayxcre1V8/hbS8Uxv7DaCImtm914ASY87kGNQ0PtdgyaAkGTIPuhYhdBuY9bNM3arig/3pLw7eQoFEQjaeMUSwEKPREXiXsJKs965LGbWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z6SM60z3QzvWqJ;
	Tue,  4 Mar 2025 15:42:26 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FEBA14035E;
	Tue,  4 Mar 2025 15:46:13 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 15:46:12 +0800
Message-ID: <4fd8d17a-b10a-4c4a-9a7c-8ccfb05c0fa9@huawei.com>
Date: Tue, 4 Mar 2025 15:46:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: Regression for client nfs_compare_super with NFS_SB_MASK
To: Philip Rowlands <linux-nfs@dimebar.com>, <linux-nfs@vger.kernel.org>
References: <12d7ea53-1202-4e21-a7ef-431c94758ce5@app.fastmail.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
CC: yangerkun <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou
 Tao <houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
In-Reply-To: <12d7ea53-1202-4e21-a7ef-431c94758ce5@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi Philip,

In the future, if you have questions about my patches, please include me 
on the CC list.
This way, I won't accidentally miss the discussion and can address any 
concerns promptly. :)

Here's my reply:

While investigating the non-root mount behavior differences between NFSv3
and NFSv4, I observed some characteristics that might explain the issue.

For NFSv3:
1) A single superblock is created for the initial mount.
2) When mounted read-only, this superblock carries the SB_RDONLY flag.
3) Before commit 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs"):
Subsequent rw mounts would not share the existing ro superblock due to
flag mismatch, creating a new superblock without SB_RDONLY.
After the commit:
   The SB_RDONLY flag is ignored during superblock comparison, and this 
leads
   to sharing the existing superblock even for rw mounts.
   Ultimately results in write operations being rejected at the VFS layer.

do_new_mount
  vfs_get_tree
   nfs_get_tree
    nfs_fs_context_validate
     nfs_parse_source
    nfs_try_get_tree
     nfs_try_mount_request
      nfs_request_mount
       nfs_mount
       // "NFS: sending MNT request for localhost:/export/stuff"
     nfs_get_tree_common
      sget_fc // the only sb, with "ro"

For NFSv4:
1) Multiple superblocks are created and the last one will be kept.
2) The actually used superblock for ro mounts doesn't carry SB_RDONLY flag.
Therefore, commit 52cb7f8f1778 doesn't affect NFSv4 mounts.

do_new_mount
  vfs_get_tree
   nfs4_try_get_tree
    do_nfs4_mount
     fc_mount
      vfs_get_tree
       nfs_get_tree_common
        sget_fc // sb for root, with "ro", will be free
     mount_subtree
      vfs_path_lookup
       filename_lookup
        path_lookupat
         link_path_walk
          step_into
           __traverse_mounts
            nfs_d_automount
             nfs4_submount
              nfs_do_submount
               vfs_get_tree
                nfs_get_tree_common
                 sget_fc // sb for subtree, without "ro"

This fundamental difference in superblock management between protocol 
versions
explains why the regression only manifests in NFSv3 use cases.

Perhaps avoiding the SB_RDONLY flag on the superblock during the initial 
mount
would be a good idea.

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b069385eea17..67565e1fd3f0 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1514,6 +1514,9 @@ static int nfs_get_tree(struct fs_context *fc)

         if (err)
                 return err;
+
+       fc->sb_flags &= ~SB_RDONLY;
+
         if (!ctx->internal)
                 return ctx->nfs_mod->rpc_ops->try_get_tree(fc);
         else

I'll have another round of discussions with the team on the solution 
approach
and perform more thorough testing.

Thanks.

在 2025/1/8 3:30, Philip Rowlands 写道:
> Kernel 6.1.120 / 6.12.2 and others recently changed the definition of NFS_SB_MASK which is used by nfs_compare_super to find existing superblocks.
>     nfs: ignore SB_RDONLY when mounting nfs
>     [ Upstream commit 52cb7f8f177878b4f22397b9c4d2c8f743766be3 ]
>
> As a result, we now see mount options shared at the superblock level which should not be shared, such as ro.
>
> Steps to reproduce on Fedora 40:
>
> mkdir -p /export/{stuff,things}/dir{1,2,3,4}
> echo '/export/stuff  *(rw)' >> /etc/exports
> echo '/export/things *(rw)' >> /etc/exports
> systemctl restart nfs-server
>
> mount -t nfs -o ro,vers=3 localhost:/export/stuff  /mnt/stuff
> mount -t nfs -o rw,vers=3 localhost:/export/things /mnt/things
> grep -w nfs /proc/mounts
>
> # note that both mountpoints are ro, despite the explicit ro/rw options
> # reversing the order of mounts gives a different result
>
> I don’t fully understand the previous problem report regarding repeated mounts with different options to the same mountpoint, but by rolling back the specific patch, we no longer see the above unintended-ro issue.
>
> Is there a reason that NFSv4 mounts don’t seem to trigger the bug?
>
>
> Cheers,
> Phil
>
>

