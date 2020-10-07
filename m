Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D0286907
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 22:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgJGU3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgJGU3V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 16:29:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32762C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 13:29:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3FC306EF5; Wed,  7 Oct 2020 16:29:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3FC306EF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602102560;
        bh=oUJaG2nfCdnYCcHR8MOSETKfZaCtgHB0oXNds9seZUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxEwnsUQX33Oz1cmfMHtoexJveAruEVf7V0FCb6dJ7WFjVoqvpjrWUrTWBrzQA35a
         w3ZmSL71jOaUm+pN3WOPvy3sa4BpQ2zY+/82loVSDwgjwe/mbc1LW+FgGVKQNurlnX
         aqR6zyUa0R/b/0oaml4bpFf9/ypW2ZN7rg9jyDC8=
Date:   Wed, 7 Oct 2020 16:29:20 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20201007202920.GH23452@fieldses.org>
References: <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
 <20201007160556.GE23452@fieldses.org>
 <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
 <20201007171559.GF23452@fieldses.org>
 <5998d49f790736aa49e7a2ac89b555bc99f3b543.camel@hammerspace.com>
 <20201007180514.GG23452@fieldses.org>
 <a761cb67ba5704ee95a95b863af5a283d554bd20.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a761cb67ba5704ee95a95b863af5a283d554bd20.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 07:11:49PM +0000, Trond Myklebust wrote:
> On Wed, 2020-10-07 at 14:05 -0400, bfields@fieldses.org wrote:
> > On Wed, Oct 07, 2020 at 05:29:26PM +0000, Trond Myklebust wrote:
> > > On Wed, 2020-10-07 at 13:15 -0400, Bruce Fields wrote:
> > > > Yeah, honestly I don't understand the details of that case
> > > > either.
> > > > 
> > > > (There is one related thing I'm curious about, which is how close
> > > > we
> > > > are
> > > > to keeping clients in different containers completely separate
> > > > (which
> > > > we'd need, for example, if we were to ever permit unprivileged
> > > > nfs
> > > > mounts).  It looks to me like as long as two network namespaces
> > > > use
> > > > different client identifiers, the client should keep different
> > > > state
> > > > for
> > > > them already?  Or is there more to do there?)
> > > 
> > > The containerised use case should already work. The containers have
> > > their own private uniquifiers, which can be changed
> > > via /sys/fs/nfs/net/nfs_client/identifier.
> > 
> > I was just looking at that commit (bf11fbd20b3 "NFS: Add sysfs
> > support
> > for per-container identifier"), and I'm confused by it: it adds code
> > to
> > nfs/sysfs to get and set "identifier", but nothing anywhere that
> > actually uses the value.  I can't figure out what I'm missing.
> > 
> 
> No, you're right. Something slipped under the radar there. The
> intention was that when it is set, the container-specific 'identifier'
> should replace the regular system-wide uniquifier. I thought I had
> merged patches for that, but apparently something got screwed up. Let
> me fix that up for 5.10...

Great, thanks.

--b.
