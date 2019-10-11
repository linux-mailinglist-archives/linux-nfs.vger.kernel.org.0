Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C387D4634
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfJKRHK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 13:07:10 -0400
Received: from fieldses.org ([173.255.197.46]:59064 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfJKRHK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 13:07:10 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id EDD7C1C97; Fri, 11 Oct 2019 13:07:09 -0400 (EDT)
Date:   Fri, 11 Oct 2019 13:07:09 -0400
To:     Thomas Deutschmann <whissi@gentoo.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfs-utils: v3 mounts broken due to statx() returning EINVAL
Message-ID: <20191011170709.GE19318@fieldses.org>
References: <ef1023fa-25e4-8ce7-945e-bc210e635e10@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1023fa-25e4-8ce7-945e-bc210e635e10@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 08, 2019 at 10:23:56PM +0200, Thomas Deutschmann wrote:
> Hi,
> 
> we have some user reporting that NFS v3 mounts are broken
> when using glibc-2.29 and linux-4.9.x (4.9.128) because
> statx() with mask=STATX_BASIC_STATS returns EINVAL. 
> 
> Looks like this isn't happening with <nfs-utils-2.4.1 or
> newer kernels.
> 
> The following workaround was confirmed to be working:
> 
> --- a/support/misc/xstat.c	2019-06-24 21:31:55.260371592 +0200
> +++ b/support/misc/xstat.c	2019-06-24 21:32:29.098777436 +0200
> @@ -47,6 +47,8 @@
>  			statx_copy(statbuf, &stxbuf);
>  			return 0;
>  		}
> +		if (errno == EINVAL)
> +			errno = ENOSYS;
>  		if (errno == ENOSYS)
>  			statx_supported = 0;
>  	} else
> 
> 
> Bug: https://bugs.gentoo.org/688644
> 
> At the moment I have no clue whether this is kernel/glibc or
> nfs-utils related; if the patch is safe to apply...

Well, sounds like nfs-utils started using statx in 2.4.1.  And just the
fact that varying the kernel version makes it sound like there was a
kernel bug causing an EINVAL return in this case, and that bug got
fixed.

One way to confirm might be running mount under strace and looking for
that EINVAL return.

I might also try looking through the kernel logs for nfs or the stat
code to see if there's a mention of this (didn't see it on a quick
look.)  Or try bisecting kernel versions to find the one where this was
fixed.

--b.

> 
> Any help is appreciated. Thanks!
> 
> 
> -- 
> Regards,
> Thomas Deutschmann / Gentoo Linux Developer
> C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5
> 



