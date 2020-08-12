Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFE424302E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHLUhp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 16:37:45 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61758 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHLUho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Aug 2020 16:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597264664; x=1628800664;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=7ulsafoPFhSQH9wyvIktGiISa6bYClB/qBk7hlnLrwM=;
  b=pnGgSXsYzLs1x7K+2Qms+cVFHi6v5PaNAB6Qn5b+gKajcDFLrrprP/rA
   Xx/WLD6WKxtQCAV9IxsqutIMnpw2yL68swY0TeMX78TPF+spxVESjwDXN
   xLyHBWq9s5xBzZ1SVnc0NgiFC/MIP5u6ZdQfhnGoPXqfzVaxM760OV6sD
   4=;
IronPort-SDR: /ABVB6UE24M2K2EsohF/scVIPaNl6yzm0MSblU07KxLPmGqKVpY4zVHUCQuMZVDMyrXxEbjRp2
 3CdJYCpSHU3w==
X-IronPort-AV: E=Sophos;i="5.76,305,1592870400"; 
   d="scan'208";a="47636865"
Subject: Re: [PATCH 2/2] nfsd: Fix typo in comment
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Aug 2020 20:37:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 72842A2261;
        Wed, 12 Aug 2020 20:37:41 +0000 (UTC)
Received: from EX13D12UEA002.ant.amazon.com (10.43.61.107) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 12 Aug 2020 20:37:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D12UEA002.ant.amazon.com (10.43.61.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 12 Aug 2020 20:37:40 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 12 Aug 2020 20:37:40 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 8E099C352B; Wed, 12 Aug 2020 20:37:40 +0000 (UTC)
Date:   Wed, 12 Aug 2020 20:37:40 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <20200812203740.GB13358@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200812141252.21059-1-alex.dewar90@gmail.com>
 <20200812141252.21059-2-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200812141252.21059-2-alex.dewar90@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 12, 2020 at 03:12:52PM +0100, Alex Dewar wrote:
> 
> Fix typos in nfs4xdr.c.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1a0341fd80f9a..3db789139a71f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4828,7 +4828,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
>                 slen = strlen(sp);
> 
>                 /*
> -                * Check if this a user. attribute, skip it if not.
> +                * Check if this is a user attribute, skip it if not.
>                  */
>                 if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
>                         goto contloop;
> --
> 2.28.0
> 

"this a" should indeed by "this is a", but "user." is not a typo - it is
talking about checking the prefix of the extended attribute, which is
"user.", so the "." is intended to be there.

Thanks,

- Frank
