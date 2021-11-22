Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E50458810
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 03:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhKVClA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 21:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhKVClA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Nov 2021 21:41:00 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43334C061574
        for <linux-nfs@vger.kernel.org>; Sun, 21 Nov 2021 18:37:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 602EC3703; Sun, 21 Nov 2021 21:37:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 602EC3703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637548673;
        bh=EfCzhMArz2UgVHXQiKszjrvN8I6Xdk7B1SD5ABl7Z4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l08D1PRZbNbGSqozu2IIreFBblRcZbvbQnH5nQxOoE/+pfm4re+W/ZFXHcZTG0eud
         W6M8BfH225vIZ+hi/4Mk6CUIyzJeoHoTVBv7xX/67rZHa2de+t3poHoY3p+ADLo8Ef
         zxV2xSUqhCR92o2zwPgK2zC12n+lsm/4TkWiqA7Q=
Date:   Sun, 21 Nov 2021 21:37:53 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
Message-ID: <20211122023753.GC12035@fieldses.org>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
 <20211117141231.GA24762@fieldses.org>
 <163753863448.13692.4142092237119935826@noble.neil.brown.name>
 <20211122005639.GA12035@fieldses.org>
 <20211122005901.GB12035@fieldses.org>
 <163754358887.13692.5665882865660886756@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163754358887.13692.5665882865660886756@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 22, 2021 at 12:13:08PM +1100, NeilBrown wrote:
> On Mon, 22 Nov 2021, J. Bruce Fields wrote:
> > On Sun, Nov 21, 2021 at 07:56:39PM -0500, J. Bruce Fields wrote:
> > > On Mon, Nov 22, 2021 at 10:50:34AM +1100, NeilBrown wrote:
> > > > On Thu, 18 Nov 2021, J. Bruce Fields wrote:
> > > > > On Wed, Nov 17, 2021 at 11:46:49AM +1100, NeilBrown wrote:
> > > > > > I have a dream of making nfsd threads start and stop dynamically.
> > > > > 
> > > > > It's a good dream!
> > > > > 
> > > > > I haven't had a chance to look at these at all yet, I just kicked off
> > > > > tests to run overnight, and woke up to the below.
> > > > > 
> > > > > This happened on the client, probably the first time it attempted to do
> > > > > an nfsv4 mount, so something went wrong with setup of the callback
> > > > > server.
> > > > 
> > > > I cannot reproduce this and cannot see any way it could possible happen.
> > > 
> > > Huh.  Well, it's possible I mixed up the results somehow.  I'll see if I
> > > can reproduce tonight or tomorrow.
> > > 
> > > > Could you please confirm the patches were applied on a vanilla 5.1.6-rc1
> > > > kernel, and that you don't have the "pool_mode" module parameter set.
> > > 
> > > /sys/module/sunrpc/parameters/pool_mode is "global", the default.
> > 
> > Oh, and yes, this is what I was testing, should just be 5.16-rc1 plus
> > your 14 patches:
> > 
> > 	http://git.linux-nfs.org/?p=bfields/linux-topics.git;a=shortlog;h=659e13af1f8702776704676937932f332265d85e

OK, tried again and it did indeed reproduce in the same spot.

> I did find a possible problem.  Very first patch.
> in fs/nfsd/nfsctl.c, in _write_ports_addfd()
>   if (!err && !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> 
> should be "err >= 0" rather than "!err".  That could result in a
> use-after free, which can make anything explode.
> If not too much trouble, could you just tweek that line and see what
> happens?

Like the following?  Same divide-by-zero, I'm afraid.

--b.

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 28c26429988e..442581d5a1ca 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -743,7 +743,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (!err && !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+	if (err >= 0 && !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
 	nfsd_put(net);
