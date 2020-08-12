Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C23243027
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHLUgs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 16:36:48 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:41003 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUgm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Aug 2020 16:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597264602; x=1628800602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NM3dgEvzc8AqCgv9SF3jY+ZEoUdRg81UVR//pTF6ST0=;
  b=tLmaTwNs3fixjFqpg4HaTUxeVTBWYiFqn1i93LRwPkeQsktpAqfNPz4Z
   0Or/BnicdAQHdwg+nqlc2Ll+VA34sFKQXtPQKXeaQJthbceAM9cHfc3XQ
   Ojh5SpWsDHK3qeix+ijOzv5G3X+XSuEmI6v3WTNL8rRC8jLwxUXVyGsDK
   w=;
IronPort-SDR: 5YWVmavH7vj56eFNMR58KSQrhehIo3al0on02mUf/8xhPhAIa0uPs5GRg0fOjKNqnxFHtWJbkA
 rnxY9drNeBJg==
X-IronPort-AV: E=Sophos;i="5.76,305,1592870400"; 
   d="scan'208";a="67567773"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-60ce1996.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Aug 2020 20:36:33 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-60ce1996.us-west-2.amazon.com (Postfix) with ESMTPS id 5B458A3250;
        Wed, 12 Aug 2020 20:36:32 +0000 (UTC)
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 12 Aug 2020 20:36:31 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 12 Aug 2020 20:36:31 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 12 Aug 2020 20:36:31 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 5E986C352B; Wed, 12 Aug 2020 20:36:31 +0000 (UTC)
Date:   Wed, 12 Aug 2020 20:36:31 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd: Remove unnecessary assignment in nfs4xdr.c
Message-ID: <20200812203631.GA13358@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200812141252.21059-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200812141252.21059-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 12, 2020 at 03:12:51PM +0100, Alex Dewar wrote:
> 
> In nfsd4_encode_listxattrs(), the variable p is assigned to at one point
> but this value is never used before p is reassigned. Fix this.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  fs/nfsd/nfs4xdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 259d5ad0e3f47..1a0341fd80f9a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4859,7 +4859,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
>                         goto out;
>                 }
> 
> -               p = xdr_encode_opaque(p, sp, slen);
> +               xdr_encode_opaque(p, sp, slen);
> 
>                 xdrleft -= xdrlen;
>                 count++;
> --
> 2.28.0
> 

Yep, I guess my linting missed that, thanks for the fix.

- Frank
