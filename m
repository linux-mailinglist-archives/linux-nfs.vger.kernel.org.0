Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF849EB35
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiA0TmK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245642AbiA0TmJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:42:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C67EC061714
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:42:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EBE82608A; Thu, 27 Jan 2022 14:42:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EBE82608A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643312527;
        bh=T9iBe/wUpXbJVucrY4lsUNK3tBVT9rgR0Z3HQ5eOm+0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=I/TUJmY8pPRtPZ7LR1znGzLoo8Oo9boQbayiPbQwwhSGYRbiGhhexzXSJUZBIefVe
         IMuH4/AwDiVlD1wvE1Fd48ykV4L/JJui58G3K2wtK/SyVcBZXo1sLRU4X8tiYN4YBc
         c2D5vg7VOjdUgdb6aaBSFw7co6ur906vzktK/zg4=
Date:   Thu, 27 Jan 2022 14:42:07 -0500
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Message-ID: <20220127194207.GA3459@fieldses.org>
References: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
 <5D07AA4C-D6ED-4E53-AFFE-D0B91B11622C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D07AA4C-D6ED-4E53-AFFE-D0B91B11622C@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 27, 2022 at 03:51:54PM +0000, Chuck Lever III wrote:
> Hi Dai-
> 
> > On Jan 26, 2022, at 4:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > From RFC 7530 Section 16.34.5:
> > 
> > o  The server has not recorded an unconfirmed { v, x, c, *, * } and
> >   has recorded a confirmed { v, x, c, *, s }.  If the principals of
> >   the record and of SETCLIENTID_CONFIRM do not match, the server
> >   returns NFS4ERR_CLID_INUSE without removing any relevant leased
> >   client state, and without changing recorded callback and
> >   callback_ident values for client { x }.
> > 
> > The current code intents to do what the spec describes above but
> > it forgot to set 'old' to NULL resulting to the confirmed client
> > to be expired.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> 
> On it's face, this seems like the correct thing to do.
> 
> I believe the issue was introduced in commit 2b63482185e6 ("nfsd:
> fix clid_inuse on mount with security change") in 2015. I can
> add a Fixes: tag and apply this for 5.17-rc.

Looks right to me too--thanks, Dai.

--b.

> > ---
> > fs/nfsd/nfs4state.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 72900b89cf84..32063733443d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4130,8 +4130,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> > 			status = nfserr_clid_inuse;
> > 			if (client_has_state(old)
> > 					&& !same_creds(&unconf->cl_cred,
> > -							&old->cl_cred))
> > +							&old->cl_cred)) {
> > +				old = NULL;
> > 				goto out;
> > +			}
> > 			status = mark_client_expired_locked(old);
> > 			if (status) {
> > 				old = NULL;
> > -- 
> > 2.9.5
> > 
> 
> --
> Chuck Lever
> 
> 
