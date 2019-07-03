Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1765E839
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCP4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 11:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2955 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCP4n (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 11:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2C0B308FBAF;
        Wed,  3 Jul 2019 15:56:37 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-123-62.rdu2.redhat.com [10.10.123.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E53B91F43;
        Wed,  3 Jul 2019 15:56:36 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id F05AE1803CA; Wed,  3 Jul 2019 11:56:34 -0400 (EDT)
Date:   Wed, 3 Jul 2019 11:56:34 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chris Tracy <ctracy@engr.scu.edu>, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-nfs@molgen.mpg.de
Subject: Re: [PATCH] nfsd: Fix overflow causing non-working mounts on 1 TB
 machines
Message-ID: <20190703155634.GB23076@parsley.fieldses.org>
References: <20190702165107.93C8A2067CFDD@mx.molgen.mpg.de>
 <8c3e0249-b17f-4bd2-4a46-afd4d35f4763@molgen.mpg.de>
 <0b5fdd56-d570-c787-cd56-7e6d0ba65225@molgen.mpg.de>
 <860b4d19-49bd-5d76-aa06-c2d9aeffb452@molgen.mpg.de>
 <17f8948d-19b9-beac-cab1-e4bc587d9612@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17f8948d-19b9-beac-cab1-e4bc587d9612@molgen.mpg.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 03 Jul 2019 15:56:42 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good catch!  And thanks for the detailed explanation.  Applying for 5.2
and stable.

On Wed, Jul 03, 2019 at 02:54:43PM +0200, Paul Menzel wrote:
> Date: Wed, 3 Jul 2019 13:28:15 +0200
> 
> Since commit 10a68cdf10 (nfsd: fix performance-limiting session
> calculation) (Linux 5.1-rc1 and 4.19.31), shares from NFS servers with
> 1 TB of memory cannot be mounted anymore. The mount just hangs on the
> client.
> 
> The gist of commit 10a68cdf10 is the change below.
> 
>     -avail = clamp_t(int, avail, slotsize, avail/3);
>     +avail = clamp_t(int, avail, slotsize, total_avail/3);
> 
> Here are the macros.
> 
>     #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
>     #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
> 
> `total_avail` is 8,434,659,328 on the 1 TB machine. `clamp_t()` casts
> the values to `int`, which for 32-bit integers can only hold values
> −2,147,483,648 (−2^31) through 2,147,483,647 (2^31 − 1).
> 
> `avail` (in the function signature) is just 65536, so that no overflow
> was happening. Before the commit the assignment would result in 21845,
> and `num = 4`.
> 
> When using `total_avail`, it is causing the assignment to be
> 18446744072226137429 (printed as %lu), and `num` is then 4164608182.
> 
> My next guess is, that `nfsd_drc_mem_used` is then exceeded, and the
> server thinks there is no memory available any more for this client.
> 
> Updating the arguments of `clamp_t()` and `min_t()` to `unsigned long`
> fixes the issue.
> 
> Now, `avail = 65536` (before commit 10a68cdf10 `avail = 21845`), but
> `num = 4` remains the same.
> 
> Fixes: 10a68cdf10 (nfsd: fix performance-limiting session calculation)
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> 1.  No, idea if `min_t()` arguments also need updating.
> 2.  Instead of `unsigned long`, should `size_t` be used?
> 
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 618e66078ee5..1a0cdeb3b875 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1563,7 +1563,7 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  	 * Never use more than a third of the remaining memory,
>  	 * unless it's the only way to give this client a slot:
>  	 */
> -	avail = clamp_t(int, avail, slotsize, total_avail/3);
> +	avail = clamp_t(unsigned long, avail, slotsize, total_avail/3);
>  	num = min_t(int, num, avail / slotsize);
>  	nfsd_drc_mem_used += num * slotsize;
>  	spin_unlock(&nfsd_drc_lock);
> -- 
> 2.22.0
> 


