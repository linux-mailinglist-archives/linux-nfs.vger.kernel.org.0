Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628F53687D5
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhDVUYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhDVUYK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 16:24:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D5EC06174A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 13:23:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7C3D27274; Thu, 22 Apr 2021 16:23:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7C3D27274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619123014;
        bh=wju6rqfQraDvpNSdlSV17R9d7TZOJyxmYmwf/DxttSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLDkjKiUP6Pp+CldusibHHAC4SJW5+lm1cz49fI4MoxZTXsZ0cB5mQ1RplOaxR0+V
         yVdKblYgREFDP7XMfJNnkv5qk/TITITdp35f+JWQm7d0kTOA7YKcDetKJkGZZBHTjn
         Yr98BHVH9Sx3/LQnY5KFX7B3Uydw6sqkT8sNAte4=
Date:   Thu, 22 Apr 2021 16:23:34 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <20210422202334.GB25415@fieldses.org>
References: <20210422191803.31511-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422191803.31511-1-pvorel@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> LTP NFS tests (which use netns) fails on tmpfs since d4066486:
> 
> mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory

We should figure out the reason for the failure.  A network trace might
help.

--b.

> 
> Fixes: d4066486 ("mount.nfs: improve version negotiation when vers=4 is specified.")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> not sure, if this is a correct fix thus RFC (I'm not from @umn.edu :)).
> I suppose tmpfs is still meant to be supported, but maybe I'm wrong.
> 
> I did testing with LTP [1]:
> 
> $ for i in 3 4 4.1 4.2; do echo "* version: $i"; PATH="/opt/ltp/testcases/bin:$PATH" nfs01 -v $i -t tcp; done
> 
> Core of the tests is nfs_lib.sh [2], which sets network namespace (with
> help of tst_net.sh [3]) and setup nfs with exportfs (use fsid to be
> working properly on tmpfs) and run various tests with these NFS
> versions: 3, 4, 4.1, 4.2.
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp
> [2] https://github.com/linux-test-project/ltp/blob/master/testcases/network/nfs/nfs_stress/nfs_lib.sh
> [3] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_net.sh
> 
>  utils/mount/Makefile.am |  3 ++-
>  utils/mount/stropts.c   | 29 ++++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index ad0be93b..d3905bec 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -28,7 +28,8 @@ endif
>  mount_nfs_LDADD = ../../support/nfs/libnfs.la \
>  		  ../../support/export/libexport.a \
>  		  ../../support/misc/libmisc.a \
> -		  $(LIBTIRPC)
> +		  $(LIBTIRPC) \
> +		  $(LIBPTHREAD)
>  
>  mount_nfs_SOURCES = $(mount_common)
>  
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 174a05f6..3961b8ce 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -31,6 +31,7 @@
>  #include <time.h>
>  
>  #include <sys/socket.h>
> +#include <sys/statfs.h>
>  #include <sys/mount.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
> @@ -50,6 +51,7 @@
>  #include "parse_dev.h"
>  #include "conffile.h"
>  #include "misc.h"
> +#include "nfsd_path.h"
>  
>  #ifndef NFS_PROGRAM
>  #define NFS_PROGRAM	(100003)
> @@ -104,6 +106,21 @@ struct nfsmount_info {
>  				child;		/* forked bg child? */
>  };
>  
> +/*
> + * Returns TRUE if mounting on tmpfs, otherwise FALSE.
> + */
> +static int is_tmpfs(struct nfsmount_info *mi)
> +{
> +	struct statfs64 st;
> +
> +	if (nfsd_path_statfs64(mi->node, &st)) {
> +		nfs_error(_("%s: Failed to statfs64 on path %s: %s"),
> +			  progname, mi->node, strerror(errno));
> +		return 0;
> +	}
> +
> +	return st.f_type == 0x01021994;
> +}
>  
>  static void nfs_default_version(struct nfsmount_info *mi)
>  {
> @@ -873,6 +890,9 @@ static int nfs_try_mount_v4(struct nfsmount_info *mi)
>  		case EACCES:
>  			continue;
>  		default:
> +			if (is_tmpfs(mi))
> +				return 1;
> +
>  			goto out;
>  		}
>  	}
> @@ -951,9 +971,12 @@ check_result:
>  	}
>  
>  fall_back:
> -	if (mi->version.v_mode == V_GENERAL)
> -		/* v2,3 fallback not allowed */
> -		return result;
> +	if (mi->version.v_mode == V_GENERAL) {
> +
> +		/* v2,3 fallback not allowed unless tmpfs */
> +		if (!is_tmpfs(mi))
> +			return result;
> +	}
>  
>  	/*
>  	 * Save the original errno in case the v3 
> -- 
> 2.31.1
