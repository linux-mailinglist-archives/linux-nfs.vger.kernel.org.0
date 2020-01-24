Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C4149013
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgAXVXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 16:23:06 -0500
Received: from fieldses.org ([173.255.197.46]:40014 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAXVXG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 Jan 2020 16:23:06 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 31C241C7B; Fri, 24 Jan 2020 16:23:06 -0500 (EST)
Date:   Fri, 24 Jan 2020 16:23:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank Sorenson <sorenson@redhat.com>
Cc:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: expiry_time should be seconds not timeval
Message-ID: <20200124212306.GD26874@fieldses.org>
References: <20200124101154.22760-1-rbergant@redhat.com>
 <438af54f-e1a8-467a-4ef1-821b67b7bb6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438af54f-e1a8-467a-4ef1-821b67b7bb6c@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 24, 2020 at 10:53:19AM -0600, Frank Sorenson wrote:
> On 1/24/20 4:11 AM, Roberto Bergantinos Corpas wrote:
> > When upcalling gssproxy, cache_head.expiry_time is set as a
> > timeval, not seconds since boot. As such, RPC cache expiry
> > logic will not clean expired objects created under
> > auth.rpcsec.context cache.

Looks like expiration times have worked this way since 2010's
c5b29f885afe "sunrpc: use seconds since boot in expiry cache".
gss_proxy_save_rsc was added in 2012 with 030d794bf498 "SUNRPC: Use
gssproxy upcall for server RPCGSS authentication", so it's the gssproxy
code that introduced the bug.  That's a while for this to lurk, but it
sounds like it required a bit of an extreme case to make it obvious.

Applying with a stable cc, Frank's Tested-by and a note on the above.
Thanks, everyone!

--b.

> > 
> > This has proven to cause kernel memory leaks on field.
> > 
> > Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > ---
> >  net/sunrpc/auth_gss/svcauth_gss.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
> > index 8be2f209982b..725cf5b5ae40 100644
> > --- a/net/sunrpc/auth_gss/svcauth_gss.c
> > +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> > @@ -1211,6 +1211,7 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
> >  		dprintk("RPC:       No creds found!\n");
> >  		goto out;
> >  	} else {
> > +		struct timespec boot;
> >  
> >  		/* steal creds */
> >  		rsci.cred = ud->creds;
> > @@ -1231,6 +1232,9 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
> >  						&expiry, GFP_KERNEL);
> >  		if (status)
> >  			goto out;
> > +
> > +		getboottime(&boot);
> > +		expiry -= boot.tv_sec;
> >  	}
> >  
> >  	rsci.h.expiry_time = expiry;
> > 
> 
> The accumulating  become apparent when the client uses kerberos tickets
> with very short (10 seconds or fewer) lifetimes and renewable lifetimes:
> 
> mount server:/exports /mnt/tmp -overs=4,sec=krb5p
> life="2s"
> rlife="3s"
> while true ; do
> 	while true ; do
> 		kinit -l $life -R >/dev/null 2>&1 && break
> 		echo 'PASSWORD' | kinit -l $life -r $rlife \
> 			>/dev/null 2>&1 && break
> 	done
> 	timeout -k 1 2 touch /mnt/tmp/foo
> 	echo -n .
> done
> 
> Due to the entry expiration occurring 50 years in the future, the
> customer had accumulated in excess of 400,000 entries in the cache over
> about a month with just 6 nfs clients.  The entries, with all the
> accompanying structs which had been allocated consumed over 2 GiB from
> various slab caches.
> 
> A flush of the cache cleans everything out, however they will again
> accumulate afterward.
> 
> This patch fixes the expiration issue.
> 
> Tested-By: Frank Sorenson <sorenson@redhat.com>
> 
> 
> Frank
> --
> Frank Sorenson
> sorenson@redhat.com
> Principal Software Maintenance Engineer
> Global Support Services - filesystems
> Red Hat
> 
> 
> 
> 
> 
> 
> 
