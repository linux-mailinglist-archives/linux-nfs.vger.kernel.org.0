Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06522F573
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jul 2020 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgG0Qe3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jul 2020 12:34:29 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:14326 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgG0Qe2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jul 2020 12:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595867668; x=1627403668;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=/cBDHdYCAXlViX573ZuBBDuzPl3N86QXDlOplOxSvlc=;
  b=eAehBTMqV1iclpK+c9K7JGCantcitNucymlc7F2lcwhyBbEpf+3Ts7NB
   xgSmkmqvyJTfbFBXAIbmoXUcEVvsDl/l6l4Lf/9tUhI2FijygdK9Pi4Z3
   0ludKyc96nhflcCsOudSgGmT4xASvqDArgoK4fvWQWVI7Kb/Rz4BN/0le
   o=;
IronPort-SDR: KDiFI1pNEGnY8t3HNcLEToLYtj7UZ4Oh78FSRrmex7JTaXxo6nCr9fOCvGquTPc5k0HQjEkyYK
 kYCelvRK+KyA==
X-IronPort-AV: E=Sophos;i="5.75,402,1589241600"; 
   d="scan'208";a="44320302"
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Jul 2020 16:34:26 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id EA093A056B;
        Mon, 27 Jul 2020 16:34:24 +0000 (UTC)
Received: from EX13D11UEB002.ant.amazon.com (10.43.60.63) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 16:34:24 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D11UEB002.ant.amazon.com (10.43.60.63) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 16:34:24 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 27 Jul 2020 16:34:23 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C7F31C13F8; Mon, 27 Jul 2020 16:34:23 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:34:23 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Message-ID: <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200727112344.GH389488@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727112344.GH389488@mwanda>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

On Mon, Jul 27, 2020 at 02:23:44PM +0300, Dan Carpenter wrote:
> 
> 
> This should return -ENOMEM on failure instead of success.
> 
> Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr caching.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> ---
>  fs/nfs/nfs42xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index 23fdab977a2a..e75c4bb70266 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -1040,8 +1040,10 @@ int __init nfs4_xattr_cache_init(void)
>                 goto out2;
> 
>         nfs4_xattr_cache_wq = alloc_workqueue("nfs4_xattr", WQ_MEM_RECLAIM, 0);
> -       if (nfs4_xattr_cache_wq == NULL)
> +       if (nfs4_xattr_cache_wq == NULL) {
> +               ret = -ENOMEM;
>                 goto out1;
> +       }
> 
>         ret = register_shrinker(&nfs4_xattr_cache_shrinker);
>         if (ret)
> --
> 2.27.0
> 

Thanks for catching that one. Since this is against linux-next via Trond,
I assume Trond will add it to his tree (right?)

In any case:


Reviewed-by: Frank van der Linden <fllinden@amazon.com>


- Frank
