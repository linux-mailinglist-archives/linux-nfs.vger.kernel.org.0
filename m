Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186ACBADDE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404463AbfIWGg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 02:36:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32965 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404364AbfIWGg7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Sep 2019 02:36:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so14187339wme.0
        for <linux-nfs@vger.kernel.org>; Sun, 22 Sep 2019 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ecG1bmTShe60pG2RED2U4z+fupj7aQkwqDk6tWfgYaQ=;
        b=nCFwVsKb4CIP+mvaCUNjTNxXaM62n6mNYJ1d7Ui/I5EwBYv6zgMGxXB2rk4eFxlcAH
         AryC0BslBHCguXqgdNFL2E2CzWo4nstgUtMQcd7MTUZNHOVBYu1pRf+bAYJoESNTDtzv
         jAK3SyEalVv1GxVTg9f7emC+N4ZcN0EaeUPzHmggUpbzxW/X+xYESF7U2SAGbpoLNWhC
         a6UDds+N/d4LKLVfsyIDQTliEATK1DPfcpKJxrgmsBXkRsuVswRLhQpr0BVKV8vXsgEO
         2mdYmGiNPyaXSVUMp+xDdTsqfqQ1/eG1GS2AHAwyU4o95u3dFzmrtq3G2Y7ij67m/IFT
         qeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecG1bmTShe60pG2RED2U4z+fupj7aQkwqDk6tWfgYaQ=;
        b=WBuGIpkE1l8zpvj6RDGKJMhrt5p7uKLvf6FUoGPTGj2uCOn05sKSScAVDFZLf936db
         s6T53dpoCrBF20FmXW0sgKJH1kDLmrT5afFqgq3dZswqbPCNtwkfbhbXuYEuYheDiuhb
         qB0WTpRWQaTrogPQ+G3aOkldtSGV2mVmY6YpmeSowcQcUWw54iLkS528NZx5LNhVLfIp
         N33ydQQtXW9Bok89foGqkWUJXDwMGsxzWHWP8sYXqSXbIiEQP1p80ccI9kUn1jKt3no2
         ziqT24+qLUVwoMeeClzy4hMnJcpHMcPl5vnFwZqcXuEdBnI+fBGpUT077HerUCX+hm8U
         JJBg==
X-Gm-Message-State: APjAAAVIVrXwu13B0m+D40xZSuhgNmjwJHCrxqpyBSqxMOHyTk1FhxoR
        Rdcc0KXKGiAT4eocKFMCxCQrG7Hk
X-Google-Smtp-Source: APXvYqwOfATm8seVxHEX5PhgV5acHKPIrONETUbovQxNEJzFBUshhlgbiHGkgCYxzZOvCSzM4hGTVQ==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr1551299wmk.20.1569220617186;
        Sun, 22 Sep 2019 23:36:57 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id v4sm14910015wrg.56.2019.09.22.23.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 23:36:56 -0700 (PDT)
Subject: Re: [PATCH] NFS: Optimise the default readahead size
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190922190749.54156-1-trond.myklebust@hammerspace.com>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <a9b7d011-b244-f7d4-4545-d302dd51b5b7@gmail.com>
Date:   Mon, 23 Sep 2019 09:36:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922190749.54156-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you Trond, you're awesome!

I don't know if it's appropriate, but I thought I'd send some recent 
benchmarks about this:

Netbooting a system over 100 Mbps,tcp,timeo=600,rsize=1M,wsize=1M,
then `rm -rf .mozilla; echo 3>/proc/sys/vm/drop_caches; firefox`

| Readahead | Boot sec | Boot MB | Firefox sec | Firefox MB |
|-----------|----------|---------|-------------|------------|
|    4 KB   |    34    |   158   |     27      |    120     |
|  128 KB   |    36    |   355   |     27      |    247     |
|    1 MB   |    83    |  1210   |     60      |    661     |

If I understand it correctly, the new default is 128 KB, which feels 
like a great generic default, while for remote / or /home for multiple 
clients, 4 KB might be more appropriate, so software like LTSP or klibc 
nfsmount that focus there, may adjust readahead from the 
/sys/devices/virtual/bdi interface.

Thanks again,
Alkis Georgopoulos
LTSP developer


On 9/22/19 10:07 PM, Trond Myklebust wrote:
> In the years since the max readahead size was fixed in NFS, a number of
> things have happened:
> - Users can now set the value directly using /sys/class/bdi
> - NFS max supported block sizes have increased by several orders of
>    magnitude from 64K to 1MB.
> - Disk access latencies are orders of magnitude faster due to SSD + NVME.
> 
> In particular note that if the server is advertising 1MB as the optimal
> read size, as that will set the readahead size to 15MB.
> Let's therefore adjust down, and try to default to VM_READAHEAD_PAGES.
> However let's inform the VM about our preferred block size so that it
> can choose to round up in cases where that makes sense.
> 
> Reported-by: Alkis Georgopoulos <alkisg@gmail.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/internal.h | 8 --------
>   fs/nfs/super.c    | 9 ++++++++-
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index e64f810223be..447a3c17fa8e 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -16,14 +16,6 @@ extern const struct export_operations nfs_export_ops;
>   
>   struct nfs_string;
>   
> -/* Maximum number of readahead requests
> - * FIXME: this should really be a sysctl so that users may tune it to suit
> - *        their needs. People that do NFS over a slow network, might for
> - *        instance want to reduce it to something closer to 1 for improved
> - *        interactive response.
> - */
> -#define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
> -
>   static inline void nfs_attr_check_mountpoint(struct super_block *parent, struct nfs_fattr *fattr)
>   {
>   	if (!nfs_fsid_equal(&NFS_SB(parent)->fsid, &fattr->fsid))
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 703f595dce90..c96194e28692 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -2627,6 +2627,13 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
>   }
>   EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
>   
> +static void nfs_set_readahead(struct backing_dev_info *bdi,
> +			      unsigned long iomax_pages)
> +{
> +	bdi->ra_pages = VM_READAHEAD_PAGES;
> +	bdi->io_pages = iomax_pages;
> +}
> +
>   struct dentry *nfs_fs_mount_common(struct nfs_server *server,
>   				   int flags, const char *dev_name,
>   				   struct nfs_mount_info *mount_info,
> @@ -2669,7 +2676,7 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
>   			mntroot = ERR_PTR(error);
>   			goto error_splat_super;
>   		}
> -		s->s_bdi->ra_pages = server->rpages * NFS_MAX_READAHEAD;
> +		nfs_set_readahead(s->s_bdi, server->rpages);
>   		server->super = s;
>   	}
>   
> 

