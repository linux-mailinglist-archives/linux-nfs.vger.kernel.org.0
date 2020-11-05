Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594BC2A89B4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgKEWZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 17:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgKEWZf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 17:25:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19773C0613CF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:25:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2824040BC; Thu,  5 Nov 2020 17:25:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2824040BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604615134;
        bh=2FMTCCr/vM0tqD3rC7rEJQ92CbbjE/dr3HwBH07ZDA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYEs0F8MGzNI5AjlZsmbog5ML2JMPU9BA26RcD4LQOWDQzf8rvHhKTJhH34Sl7rXM
         16cZEiXXsqzv1EnqGyyhzAF/8dntA4E3mA9K+cZMWqwxOu1oKWbKJIsCRmCgnp/bzK
         EeDAZqnXg4Y4bSZqqe6HSpA7wrgtXqPNVP+TFORU=
Date:   Thu, 5 Nov 2020 17:25:34 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
Message-ID: <20201105222534.GG25512@fieldses.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029190716.70481-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying for 5.10, thanks!

--b.

On Thu, Oct 29, 2020 at 03:07:14PM -0400, Dai Ngo wrote:
> Observed use-after-free messages in /var/log/messages of destination
> server when doing inter-server copy. These come from 2 different places
> in the code, one from the nfsd4_cleanup_inter_ssc when nfsd_file_put
> is called for the source file and the other from nfs4_put_copy when
> it's called from nfsd4_cb_offload_release.
> 
> Fixed by removing the call to nfsd_file_put; the object is not allocated
> by nfsd_file_alloc, and by initializing refcount for nfsd4_copy in
> nfsd4_do_async_copy.
> 
>  fs/nfsd/nfs4proc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
