Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F235234F7B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfFDSB1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 14:01:27 -0400
Received: from fieldses.org ([173.255.197.46]:33830 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFDSB0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 14:01:26 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7CAFD1C17; Tue,  4 Jun 2019 14:01:26 -0400 (EDT)
Date:   Tue, 4 Jun 2019 14:01:26 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/3] mountd: Ensure nfsd_path_strip_root() uses the
 canonicalised path
Message-ID: <20190604180126.GA2953@fieldses.org>
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
 <20190603171227.29148-2-trond.myklebust@hammerspace.com>
 <20190603171227.29148-3-trond.myklebust@hammerspace.com>
 <20190604154611.GC19422@fieldses.org>
 <1fb61a70b5eea0cd4735aa5ae3050382b317f886.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb61a70b5eea0cd4735aa5ae3050382b317f886.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 04, 2019 at 05:58:59PM +0000, Trond Myklebust wrote:
> On Tue, 2019-06-04 at 11:46 -0400, J. Bruce Fields wrote:
> > On Mon, Jun 03, 2019 at 01:12:26PM -0400, Trond Myklebust wrote:
> > > When attempting to strip the root path, we should first
> > > canonicalise
> > > the root pathname.
> > > 
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  support/misc/nfsd_path.c | 17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> > > index 2f41a793c534..9b38dd96007f 100644
> > > --- a/support/misc/nfsd_path.c
> > > +++ b/support/misc/nfsd_path.c
> > > @@ -1,6 +1,7 @@
> > >  #include <errno.h>
> > >  #include <sys/types.h>
> > >  #include <sys/stat.h>
> > > +#include <limits.h>
> > >  #include <stdlib.h>
> > >  #include <unistd.h>
> > >  
> > > @@ -62,13 +63,21 @@ nfsd_path_nfsd_rootdir(void)
> > >  char *
> > >  nfsd_path_strip_root(char *pathname)
> > >  {
> > > +	char buffer[PATH_MAX];
> > >  	const char *dir = nfsd_path_nfsd_rootdir();
> > >  	char *ret;
> > >  
> > > -	ret = strstr(pathname, dir);
> > > -	if (!ret || ret != pathname)
> > > -		return pathname;
> > > -	return pathname + strlen(dir);
> > > +	if (!dir)
> > > +		goto out;
> > > +	if (realpath(dir, buffer)) {
> > > +		ret = strstr(pathname, buffer);
> > > +		if (ret == pathname)
> > > +			return pathname + strlen(dir);
> > > +	} else
> > > +		xlog(D_GENERAL, "%s: failed to resolve path %s: %m",
> > > +				__func__, dir);
> > > +out:
> > > +	return pathname;
> > 
> > I still don't get this.
> > 
> > So in the case strstr doesn't find anything, it returns the path
> > unchanged.
> > 
> > That means that if the next_mnt() caller asks whether there are any
> > mounts underneath /rootdir/a/b, and nextdir finds a mountpoint at
> > /a/b/c, it can return that, right?
> > 
> 
> Ack. Sending out a v2 of these patches.

Oh, good, thanks, I thought I was going crazy.

(Always a possibility, especially when I'm looking at code.)

--b.
