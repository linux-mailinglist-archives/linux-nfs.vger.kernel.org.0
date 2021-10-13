Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00142C5A5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJMQCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhJMQCi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 12:02:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505CDC061570
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 09:00:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E323F6C87; Wed, 13 Oct 2021 12:00:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E323F6C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634140834;
        bh=FNisKxIjQ3tDZ1uQo9iaXTYKbmZG/os/FKYpoGTrGns=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=SqoDuDH7PtD1f6EfcugRiBZVCjuJEAzgwuXE2ru/BGmqwiy2vzXfVYuTe7UVrRol0
         LN1IEARUrj1w/9z9I0LkzmAEpU8v+ozwJAZBcC80xip1znTJSCRe0pIZi5m+UxwpXn
         /HwxR9S7LJ446nDCn63nkioUVQCRdBzJCVBUL1Zo=
Date:   Wed, 13 Oct 2021 12:00:34 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Update synopsis of .pc_encode callback
Message-ID: <20211013160034.GD6260@fieldses.org>
References: <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 10:40:52AM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> Similar changes to the encode side.

Looks good, thanks.--b.

> 
> ---
> 
> Chuck Lever (3):
>       NFSD: Save location of NFSv4 COMPOUND status
>       SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
>       SUNRPC: Change return value type of .pc_encode
> 
> 
>  fs/lockd/svc.c             |   3 +-
>  fs/lockd/xdr.c             |  29 +++--
>  fs/lockd/xdr4.c            |  29 +++--
>  fs/nfs/callback_xdr.c      |   4 +-
>  fs/nfsd/nfs2acl.c          |   8 +-
>  fs/nfsd/nfs3acl.c          |  22 ++--
>  fs/nfsd/nfs3xdr.c          | 210 +++++++++++++++++--------------------
>  fs/nfsd/nfs4proc.c         |   2 +-
>  fs/nfsd/nfs4xdr.c          |  20 ++--
>  fs/nfsd/nfsd.h             |   3 +-
>  fs/nfsd/nfssvc.c           |  15 ++-
>  fs/nfsd/nfsxdr.c           |  82 +++++++--------
>  fs/nfsd/xdr.h              |  14 +--
>  fs/nfsd/xdr3.h             |  30 +++---
>  fs/nfsd/xdr4.h             |   5 +-
>  include/linux/lockd/xdr.h  |   8 +-
>  include/linux/lockd/xdr4.h |   8 +-
>  include/linux/sunrpc/svc.h |   3 +-
>  18 files changed, 237 insertions(+), 258 deletions(-)
> 
> --
> Chuck Lever
