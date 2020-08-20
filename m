Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9704324C65B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHTTo3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTTo3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 15:44:29 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32744C061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 12:44:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 76BC379CB; Thu, 20 Aug 2020 15:44:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 76BC379CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597952668;
        bh=WiCDOXah6ugChuAy4i/bEwiFrsFjzaIgMeIGq/h7A+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDemEZ7gmZa/uLhO5e78wAvSR3ThKZRJByLztWdWHPTB+/A54IOZeol8kcQp1lcjv
         MuPvMmKzhwEp9amqFUFeaaUKO0PqVORGfmFUoL4eVy6ufKj75IdP4V+cUKNzMVsWt3
         0Cyi/vMAL4S9kBW9UVMU4Dd5dJeKdbTyY7m6M93s=
Date:   Thu, 20 Aug 2020 15:44:28 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
Message-ID: <20200820194428.GB28555@fieldses.org>
References: <20200820193951.GA28555@fieldses.org>
 <1FECF29B-E908-4408-A70D-A876229BB0DB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FECF29B-E908-4408-A70D-A876229BB0DB@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 20, 2020 at 03:42:14PM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 20, 2020, at 3:39 PM, Bruce Fields <bfields@fieldses.org> wrote:
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
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> I think I've got this queued already. Is this different than:
> 
> http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commit;h=34b09af4f54e6485e28f138ccad159611a240cc1

Oh, OK, great.--b.

> 
> 
> > ---
> > fs/nfsd/nfs4state.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > Oops, I've had this sitting around a couple weeks but I must have
> > forgotten to send it in.  This is needed for 5.9.
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 4b70657385f2..0e5302f6df52 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4598,6 +4598,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
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
