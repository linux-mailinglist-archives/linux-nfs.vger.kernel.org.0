Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67917997B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgCDUGK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 15:06:10 -0500
Received: from fieldses.org ([173.255.197.46]:39064 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDUGK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Mar 2020 15:06:10 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 283731C19; Wed,  4 Mar 2020 15:06:09 -0500 (EST)
Date:   Wed, 4 Mar 2020 15:06:09 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix build error
Message-ID: <20200304200609.GA26924@fieldses.org>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
 <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 04, 2020 at 01:00:12PM -0500, Chuck Lever wrote:
> Hi-
> 
> > On Mar 4, 2020, at 8:18 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> > 
> > fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
> > nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
> > fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
> > nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
> > fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
> > nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
> > nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
> > 
> > Add dependency to NFSD_V4_2_INTER_SSC to fix this.
> > 
> > Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > fs/nfsd/Kconfig | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index f368f32..fc587a5 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
> > 
> > config NFSD_V4_2_INTER_SSC
> > 	bool "NFSv4.2 inter server to server COPY"
> > +	depends on !(NFSD=y && NFS_FS=m)
> 
> The new dependency is not especially clear to me; more explanation
> in the patch description about the cause of the build failure
> would definitely be helpful.
> 
> NFSD_V4 can't be set unless NFSD is also set.
> 
> NFS_V4_2 can't be set unless NFS_V4_1 is also set, and that cannot
> be set unless NFS_FS is also set.
> 
> So what's really going on here?

I don't understand that "depends" either.

The fundamental problem, though, is that nfsd is calling nfs code
directly.

Which I noticed in earlier review and then forgot to follow up on,
sorry.

So either we:

	- let nfsd depend on nfs, fix up Kconfig to reflect the fact, or
	- write some code so nfsd can load nfs and find those symbols at
	  runtime if it needs to do a copy.

The latter's certainly doable, but it'd be simplest to do the former.
Are there actually a lot of people who want nfsd but not nfs?  Does that
cause a real problem for anyone?

--b.
