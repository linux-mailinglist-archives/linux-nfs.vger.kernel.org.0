Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A6F3E3A81
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhHHNmT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 09:42:19 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:35890 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHNmS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 09:42:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07772837|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0699849-0.00302431-0.926991;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Kx0uTNU_1628430117;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx0uTNU_1628430117)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 08 Aug 2021 21:41:58 +0800
Date:   Sun, 8 Aug 2021 21:41:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Hao Xu <haoxu@linux.alibaba.com>
Cc:     fstests@vger.kernel.org,
        Frank van der Linden <fllinden@amazon.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] common/attr: remove the MAX_ATTRS and MAX_ATTRVAL_SIZE
 for nfs
Message-ID: <YQ/fJW/56wW9g0VT@desktop>
References: <20210804074148.203065-1-haoxu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804074148.203065-1-haoxu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 04, 2021 at 03:41:48PM +0800, Hao Xu wrote:
> The block size of localfs for nfs may be different with nfs itself.
> So it's pointless to test nfs on xattrs size, just remove the special
> judge code.
> 
> Fixes: commit da3cdb3b91ca ("common/attr: set MAX_ATTR values correctly for NFS")
> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
> ---
>  common/attr | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 42ceab92335a..542dff34bf55 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -253,7 +253,7 @@ _getfattr()
>  
>  # set maximum total attr space based on fs type
>  case "$FSTYP" in
> -xfs|udf|pvfs2|9p|ceph|nfs)
> +xfs|udf|pvfs2|9p|ceph)
>  	MAX_ATTRS=1000

This makes generic/020 _notrun on nfs, I don't think that's what we
want.

I think MAX_ATTRS is a best-effort guess based on filesystem block size,
it's not a accurate hard limit. And if there's no good way to tell the
fs blocksize on nfs server side, then we could make a conservative
assumption, e.g. the blocksize is 1k, and colculate MAX_ATTRS and
MAX_ATTRVAL_SIZE based on that assumption.

Thanks,
Eryu

>  	;;
>  *)
> @@ -273,7 +273,7 @@ xfs|udf|btrfs)
>  pvfs2)
>  	MAX_ATTRVAL_SIZE=8192
>  	;;
> -9p|ceph|nfs)
> +9p|ceph)
>  	MAX_ATTRVAL_SIZE=65536
>  	;;
>  bcachefs)
> -- 
> 2.24.4
