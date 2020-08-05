Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A923D1A8
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHEUEv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHEUEG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Aug 2020 16:04:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC234C061575
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 13:04:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0BC9A9238; Wed,  5 Aug 2020 16:04:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0BC9A9238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1596657844;
        bh=YRg2R34NRjtN5yAFjk0x/3Qng5bSwGsyvPwsm0GPng0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEt014Mem8XdiMZXn4jdHTFi/cVRDbNsqtZJ1+6l4sBfZOp7s0CbjygBW4i2Wl6cF
         qio+DH/X9SvQppIZqgs7HuubkaYqtdCdCjhj2FVoDUUl3yAEQIntV6BxUq3BJZGyw3
         NNM480Fwx4VLLAlPnes9YzS64tezq00qU4MIrz2s=
Date:   Wed, 5 Aug 2020 16:04:04 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
Message-ID: <20200805200404.GC14429@fieldses.org>
References: <20200805191011.GB14429@fieldses.org>
 <C7E5BAD1-FB46-4A0D-9D3A-031E9C09002C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7E5BAD1-FB46-4A0D-9D3A-031E9C09002C@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 05, 2020 at 03:17:54PM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> > On Aug 5, 2020, at 3:10 PM, bfields@fieldses.org wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > If an NFSv2/v3 client breaks an NFSv4 client's delegation, it will hit a
> > NULL dereference in nfsd_breaker_owns_lease().
> > 
> > Easily reproduceable with for example
> > 
> > 	mount -overs=4.2 server:/export /mnt/
> > 	sleep 1h </mnt/file &
> > 	mount -overs=3 server:/export /mnt2/
> > 	touch /mnt2/file
> > 
> > Reported-by: Robert Dinse <nanook@eskimo.com>
> > Fixes: 28df3d1539de50 ("nfsd: clients don't need to break their own delegations")
> 
> May I add
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208807
> 
> And send this in the first NFSD v5.9 -rc pull request?

Sounds good, thanks!

--b.

> 
> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9fc0a1b9e4dd..45f3832d70d4 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4597,6 +4597,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> > 	if (!i_am_nfsd())
> > 		return NULL;
> > 	rqst = kthread_data(current);
> > +	if (!rqst->rq_lease_breaker)
> > +		return NULL;
> > 	clp = *(rqst->rq_lease_breaker);
> > 	return dl->dl_stid.sc_client == clp;
> > }
> > -- 
> > 2.26.2
> > 
> 
> --
> Chuck Lever
> 
> 
