Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13022D1983
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJIUTv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 16:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIUTv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Oct 2019 16:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F8C130A5401;
        Wed,  9 Oct 2019 20:19:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-39.rdu2.redhat.com [10.10.121.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3208360606;
        Wed,  9 Oct 2019 20:19:51 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id C305120BF9; Wed,  9 Oct 2019 16:19:50 -0400 (EDT)
Date:   Wed, 9 Oct 2019 16:19:50 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd4: fix up replay_matches_cache()
Message-ID: <20191009201950.GG8791@coeurl.usersys.redhat.com>
References: <20191009191137.28007-1-smayhew@redhat.com>
 <20191009195121.GA23703@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009195121.GA23703@fieldses.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 09 Oct 2019 20:19:51 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Oct 2019, J. Bruce Fields wrote:

> On Wed, Oct 09, 2019 at 03:11:37PM -0400, Scott Mayhew wrote:
> > When running an nfs stress test, I see quite a few cached replies that
> > don't match up with the actual request.  The first comment in
> > replay_matches_cache() makes sense, but the code doesn't seem to
> > match... fix it.
> 
> Thanks, I'll apply.  But I'm curious whether you're seeing any practical
> impact from this?  I don't think it should matter.

Yes, the client is occasionally getting tied up into knots.  It appears
to always be a REMOVE request getting a cached OPEN reply, and that
loops over and over.  It seems like a client bug because when it
happens, the client sends an OPEN and immediately sends a REMOVE using
the same slot (bumping the seqid) without waiting for the OPEN reply.
The server replies with NFS4ERR_SEQ_MISORDERED, and the client
decrements the seqid and re-sends the REMOVE request.  Then the server
sends the reply to the original OPEN and sends the cached OPEN reply in
response to all the subsequent REMOVE requests.  I haven't had much luck
in tracking it down though...

-Scott

> 
> --b.
> 
> > 
> > Fixes: 53da6a53e1d4 ("nfsd4: catch some false session retries")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c65aeaa812d4..08f6eb2b73f8 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3548,12 +3548,17 @@ static bool replay_matches_cache(struct svc_rqst *rqstp,
> >  	    (bool)seq->cachethis)
> >  		return false;
> >  	/*
> > -	 * If there's an error than the reply can have fewer ops than
> > -	 * the call.  But if we cached a reply with *more* ops than the
> > -	 * call you're sending us now, then this new call is clearly not
> > -	 * really a replay of the old one:
> > +	 * If there's an error then the reply can have fewer ops than
> > +	 * the call.
> >  	 */
> > -	if (slot->sl_opcnt < argp->opcnt)
> > +	if (slot->sl_opcnt < argp->opcnt && !slot->sl_status)
> > +		return false;
> > +	/*
> > +	 * But if we cached a reply with *more* ops than the call you're
> > +	 * sending us now, then this new call is clearly not really a
> > +	 * replay of the old one:
> > +	 */
> > +	if (slot->sl_opcnt > argp->opcnt)
> >  		return false;
> >  	/* This is the only check explicitly called by spec: */
> >  	if (!same_creds(&rqstp->rq_cred, &slot->sl_cred))
> > -- 
> > 2.17.2
