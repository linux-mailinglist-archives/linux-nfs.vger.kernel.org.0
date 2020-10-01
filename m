Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2728080E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgJATvn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJATvn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 15:51:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0AC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 12:51:42 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 085451BE7; Thu,  1 Oct 2020 15:51:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 085451BE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601581902;
        bh=NrdNo+ms9yfFZSEd7SU3wTffNGm9Nrj833RkKwqNb80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6Gva+lmnze3ld7h6tuJoGR0EmLZ/2/6voQMIp/mdjmdzJupQvuWs+0yPEccf+BEj
         08b5nbEucZEpNK8KfuknBGHPOE/Oa/ZxIwlEXF24ljmR06aDEgT1BKgJhqXTJn/Tr0
         UVcs53Pc4NVJvaA6Hzma5ULEnKWOsHPV5y/IgmwI=
Date:   Thu, 1 Oct 2020 15:51:42 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
Message-ID: <20201001195142.GG1496@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
 <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
 <20201001184118.GE1496@fieldses.org>
 <1424d45ba1d140bfcff4ae834c70b0a79daa6807.camel@hammerspace.com>
 <20201001192602.GF1496@fieldses.org>
 <a6294c25cb5eb98193f609a52aa8f4b5d4e81279.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6294c25cb5eb98193f609a52aa8f4b5d4e81279.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 01, 2020 at 07:29:51PM +0000, Trond Myklebust wrote:
> On Thu, 2020-10-01 at 15:26 -0400, bfields@fieldses.org wrote:
> > On Thu, Oct 01, 2020 at 07:24:42PM +0000, Trond Myklebust wrote:
> > > NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR should normally be good enough
> > > to
> > > allow the above optimisation, yes. I'm less sure about whether or
> > > not
> > > we are correct in returning NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR when
> > > in
> > > fact we are adding the ctime and filesystem-specific change
> > > attribute,
> > > but we could fix that too.
> > 
> > Could you explain your concern?
> > 
> 
> Same as before: that the ctime could cause the value to regress if
> someone messes with the system time on the server. Yes, we do add in
> the change attribute, but the value of ctime.tv_sec dominates by a
> factor 2^30.

Got it.

I'd like to just tell people not to do that....

If we think it's too easy a mistake to make, I can think of other
approaches, though filesystem assistance might be required:

- Ideal would be just never to expose uncommitted change attributes to
  the client.  Absent persistant RAM that could be terribly expensive.

- It would help just to have any number that's guaranteed to increase
  after a boot.  Of course, if would to go forward at least as reliably
  as the system time.  We'd put it in the high bits of the on-disk
  i_version.  (We'd rather not just mix it into the returned change
  attribute as we do with ctime, because that would cause clients to
  discard all their caches unnecessarily after boot.)

--b.
