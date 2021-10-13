Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6083842C340
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJMOeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbhJMOdb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 10:33:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33BAC061749
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 07:31:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1C5A66C87; Wed, 13 Oct 2021 10:31:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1C5A66C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634135485;
        bh=7neI4NRfxHBC0DuGJuEpJwJ+Tr5MAoMaTHPESom+Gag=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=gsB6Kzgx/0PUprHfNLmoSeTbasfrWRvn1aaSmZz4dpkyTU+awHdnzI7Xlf5cNjXPQ
         atRhSxZ2Etg4PBw2l/axRwCsx+UbJNCIS8f62rej/h1RRYKOg7hvWmOUXzSrtBV57f
         Iim65+dyfSJLFcrch0qg5WxkOpUfUJHgpDFYHPnE=
Date:   Wed, 13 Oct 2021 10:31:25 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Update synopsis of .pc_decode callback
Message-ID: <20211013143125.GA6260@fieldses.org>
References: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 12, 2021 at 11:57:15AM -0400, Chuck Lever wrote:
> As we discussed many moons ago, here are clean-up patches that
> modernize the .pc_decode callback's synopsis, based on the
> recent XDR overhaul work.

Looks sensible to me.

Applying pending some testing.

--b.

> 
> ---
> 
> Chuck Lever (2):
>       SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
>       SUNRPC: Change return value type of .pc_decode
> 
> 
>  fs/lockd/svc.c             |   3 +-
>  fs/lockd/xdr.c             | 123 +++++++++++++---------------
>  fs/lockd/xdr4.c            | 124 ++++++++++++++--------------
>  fs/nfsd/nfs2acl.c          |  36 ++++----
>  fs/nfsd/nfs3acl.c          |  26 +++---
>  fs/nfsd/nfs3xdr.c          | 163 +++++++++++++++++--------------------
>  fs/nfsd/nfs4xdr.c          |  28 +++----
>  fs/nfsd/nfsd.h             |   3 +-
>  fs/nfsd/nfssvc.c           |  11 ++-
>  fs/nfsd/nfsxdr.c           |  92 ++++++++++-----------
>  fs/nfsd/xdr.h              |  21 ++---
>  fs/nfsd/xdr3.h             |  31 +++----
>  fs/nfsd/xdr4.h             |   2 +-
>  include/linux/lockd/xdr.h  |  19 +++--
>  include/linux/lockd/xdr4.h |  19 ++---
>  include/linux/sunrpc/svc.h |   3 +-
>  16 files changed, 334 insertions(+), 370 deletions(-)
> 
> --
> Chuck Lever
