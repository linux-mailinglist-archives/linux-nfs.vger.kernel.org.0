Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A743141FE10
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Oct 2021 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhJBUkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Oct 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUkd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Oct 2021 16:40:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CEC061714
        for <linux-nfs@vger.kernel.org>; Sat,  2 Oct 2021 13:38:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id AE1BC7048; Sat,  2 Oct 2021 16:38:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AE1BC7048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633207126;
        bh=178vheGxjIIKhJmjBZVo6FcDzuG0gUZPSktLqWVbKu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0ZRjoQmW2NJeeRSKg67vdgcT3Au3/73Pud2ayYxzy2XA19XzHRJy/830HayuEZU1
         ByWh+oVMYKiYO+oitd/eYuPa8VOlS9KAVpc2koCa0C+f3i0d5eRJzeXRTrpPPg+eYK
         ZRPHrDwkH62Uy1LlShbQAARZcsglunrudNnkcBhY=
Date:   Sat, 2 Oct 2021 16:38:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/2] NFSD: Clean ups for recent XDR work
Message-ID: <20211002203846.GD26608@fieldses.org>
References: <163303585936.5125.6042907247616993649.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163303585936.5125.6042907247616993649.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 30, 2021 at 05:06:09PM -0400, Chuck Lever wrote:
> As we discussed, here are a couple of minor improvements for the
> xdr_stream_subsegment() API added when the NFSv4 XDR functions were
> recently overhauled. Notably, the second patch changes the NFSv2 and
> NFSv3 decoders to work like the NFSv4 one.

Looks good to me; applying.

--b.

> 
> ---
> 
> Chuck Lever (2):
>       SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
>       NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
> 
> 
>  fs/nfsd/nfs3proc.c         |  3 +--
>  fs/nfsd/nfs3xdr.c          | 12 ++----------
>  fs/nfsd/nfs4proc.c         |  3 +--
>  fs/nfsd/nfsproc.c          |  3 +--
>  fs/nfsd/nfsxdr.c           |  9 +--------
>  fs/nfsd/xdr.h              |  2 +-
>  fs/nfsd/xdr3.h             |  2 +-
>  include/linux/sunrpc/svc.h |  3 +--
>  net/sunrpc/svc.c           | 11 ++++++-----
>  net/sunrpc/xdr.c           | 32 +++++++++++++++++---------------
>  10 files changed, 32 insertions(+), 48 deletions(-)
> 
> --
> Chuck Lever
