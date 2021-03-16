Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11D133E15A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCPWZ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 18:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhCPWZT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Mar 2021 18:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F86464F04;
        Tue, 16 Mar 2021 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615933518;
        bh=Lw+Pm12xKhQpijkih3hmvXmUdOgzse16pCczA5XoNsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRcarp4Mi8j4LqQGS41QnoBtc7qdGD4Nbp+FAT3gsqkkIB0SP1TJPnpw8631mi1P/
         O1oxXBa9XiyTXXewBgBGUWxEJvV4llLHmpyaWEkvmaM7vpcmozLNlBmux/Vv8kbURS
         1UMgU4+edlqcWNQ2TcZTkyN7/Otvi+HVXteDD75iOcAYy9weTT7uKg0ATcB1esKtEH
         C6zuuumw1X/ax716wC4K/7uKaMjvfNdCDELejOE72dg0qX5yyqhy/AHAGit6GsFnuc
         qiLWCY95YyIm/yLCZYIgLiI7h3HjuBFCFYv+MZ9osKtJwOUyDoGQUrzneapbj7X5oZ
         Zs22WkjXyn0AA==
Date:   Tue, 16 Mar 2021 15:25:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-nfs@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
Message-ID: <20210316222514.erlng3lsgmqgpcv4@archlinux-ax161>
References: <20210223141901.1652-1-timo@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223141901.1652-1-timo@rothenpieler.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 23, 2021 at 03:19:01PM +0100, Timo Rothenpieler wrote:
> This follows what was done in 8c2fabc6542d9d0f8b16bd1045c2eda59bdcde13.
> With the default being m, it's impossible to build the module into the
> kernel.
> 
> Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
> ---
>  fs/nfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index e2a488d403a6..14a72224b657 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -127,7 +127,7 @@ config PNFS_BLOCK
>  config PNFS_FLEXFILE_LAYOUT
>  	tristate
>  	depends on NFS_V4_1 && NFS_V3
> -	default m
> +	default NFS_V4
>  
>  config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
>  	string "NFSv4.1 Implementation ID Domain"
> -- 
> 2.25.1
> 

Hi all,

I bisected a new modpost warning that I see with 5.12-rc3 to this commit:

$ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mipsel-linux- O=build/mipsel distclean defconfig all
...
WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol check will be entirely skipped.
...

$ git bisect log
# bad: [1e28eed17697bcf343c6743f0028cc3b5dd88bf0] Linux 5.12-rc3
# good: [a38fd8748464831584a19438cbb3082b5a2dab15] Linux 5.12-rc2
git bisect start 'v5.12-rc3' 'v5.12-rc2'
# good: [f78d76e72a4671ea52d12752d92077788b4f5d50] Merge tag 'drm-fixes-2021-03-12-1' of git://anongit.freedesktop.org/drm/drm
git bisect good f78d76e72a4671ea52d12752d92077788b4f5d50
# bad: [420623430a7015ae9adab8a087de82c186bc9989] Merge tag 'erofs-for-5.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
git bisect bad 420623430a7015ae9adab8a087de82c186bc9989
# good: [261410082d01f2f2d4fcd19abee6b8e84f399c51] Merge tag 'devprop-5.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 261410082d01f2f2d4fcd19abee6b8e84f399c51
# good: [ce307084c96d0ec92c04fcc38b107241b168df11] Merge tag 'block-5.12-2021-03-12-v2' of git://git.kernel.dk/linux-block
git bisect good ce307084c96d0ec92c04fcc38b107241b168df11
# bad: [f296bfd5cd04cbb49b8fc9585adc280ab2b58624] Merge tag 'nfs-for-5.12-2' of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect bad f296bfd5cd04cbb49b8fc9585adc280ab2b58624
# good: [9afc1163794707a304f107bf21b8b37e5c6c34f4] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good 9afc1163794707a304f107bf21b8b37e5c6c34f4
# bad: [fd6d3feed041e96b84680d0bfc1e7abc8f65de92] NFS: Clean up function nfs_mark_dir_for_revalidate()
git bisect bad fd6d3feed041e96b84680d0bfc1e7abc8f65de92
# bad: [f0940f4b3284a00f38a5d42e6067c2aaa20e1f2e] SUNRPC: Set memalloc_nofs_save() for sync tasks
git bisect bad f0940f4b3284a00f38a5d42e6067c2aaa20e1f2e
# bad: [ad3dbe35c833c2d4d0bbf3f04c785d32f931e7c9] NFS: Correct size calculation for create reply length
git bisect bad ad3dbe35c833c2d4d0bbf3f04c785d32f931e7c9
# bad: [a0590473c5e6c4ef17c3132ad08fbad170f72d55] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
git bisect bad a0590473c5e6c4ef17c3132ad08fbad170f72d55
# first bad commit: [a0590473c5e6c4ef17c3132ad08fbad170f72d55] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default

$ mipsel-linux-gcc --version
mipsel-linux-gcc (GCC) 10.2.0
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

I doubt this is a bug with this specific commit but I am not sure so I
have added Masahiro and the kbuild list as well as the MIPS list even
though it might not be MIPS specific (although I only see it with the
32-bit MIPS configs)

Cheers,
Nathan
