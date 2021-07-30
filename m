Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF33DB9E6
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhG3OBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 10:01:42 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33153 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231247AbhG3OBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jul 2021 10:01:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UhRhdA5_1627653694;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UhRhdA5_1627653694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 22:01:34 +0800
Date:   Fri, 30 Jul 2021 22:01:34 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Hao Xu <haoxu@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for
 nfs
Message-ID: <20210730140134.GM60846@e18g06458.et15sqa>
References: <20210730124252.113071-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730124252.113071-1-haoxu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[cc linux-nfs for review]

On Fri, Jul 30, 2021 at 08:42:52PM +0800, Hao Xu wrote:
> The block size of localfs for nfs may be much smaller than nfs itself.
> So we'd better set MAX_ATTRS and MAX_ATTRVAL_SIZE to 4096 to avoid
> 'no space' error when we test adding a bunch of xattrs to nfs.
> 
> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>

Since the xattr support is relatively new (merged a year ago for
NFSv4.2), I'd like nfs folks to take a look as well.

> ---
> 
> It's better to set BLOCK_SIZE to `_get_block_size $variable`
> here $variable is the localfs for nfs, since I'm not familiar with
> xfstests, anyone tell what's the name of it.

fstests doesn't know the exported filesystem under NFS, so I don't think
we could the block size of it.

> 
>  common/attr | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 42ceab92335a..a833f00e0884 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -253,9 +253,13 @@ _getfattr()
>  
>  # set maximum total attr space based on fs type
>  case "$FSTYP" in
> -xfs|udf|pvfs2|9p|ceph|nfs)
> +xfs|udf|pvfs2|9p|ceph)
>  	MAX_ATTRS=1000
>  	;; 
> +nfs)
> +	BLOCK_SIZE=4096
> +	let MAX_ATTRS=$BLOCK_SIZE/40
> +	;;
>  *)
>  	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
> @@ -273,12 +277,15 @@ xfs|udf|btrfs)
>  pvfs2)
>  	MAX_ATTRVAL_SIZE=8192
>  	;;
> -9p|ceph|nfs)
> +9p|ceph)
>  	MAX_ATTRVAL_SIZE=65536
>  	;;
>  bcachefs)
>  	MAX_ATTRVAL_SIZE=1024
>  	;;
> +nfs)
> +	MAX_ATTRVAL_SIZE=3840
> +	;;

Where does this value come from?

Thanks,
Eryu

>  *)
>  	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
> -- 
> 2.24.4
