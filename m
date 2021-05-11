Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7537AD49
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhEKRou (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhEKRot (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 13:44:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E835C061574
        for <linux-nfs@vger.kernel.org>; Tue, 11 May 2021 10:43:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C5A484F7D; Tue, 11 May 2021 13:43:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C5A484F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620755022;
        bh=7Jp1+3JatcX0FZneHcRD/YX+kYuvX3/uoIdxmsSzMik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdQNgu75NfpgL8Ji1+1HYVifTT5OkvSDhrrSPkFIwQTOS2YkLKKdNlZLgpLKStSXI
         IPu+x68QzK1mPfzMkFwKSRDnvUlI+afNCKWSbbiAkvOdq57BySsi/teI7Y8qemuEFo
         miqgqujlqeGkFNHJZ2ma1ZZfyBglujnFKptmpBHs=
Date:   Tue, 11 May 2021 13:43:42 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>
Subject: Re: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Message-ID: <20210511174342.GC5416@fieldses.org>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
 <7922E4B6-BB7F-4D9E-B85D-D1A97835AF3F@oracle.com>
 <20210511173839.GB5416@fieldses.org>
 <87867BC3-EA29-4C94-B8DD-6B927BEC9522@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87867BC3-EA29-4C94-B8DD-6B927BEC9522@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 11, 2021 at 05:40:20PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 11, 2021, at 1:38 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Tue, May 11, 2021 at 03:59:00PM +0000, Chuck Lever III wrote:
> >> As Dave reported yesterday, this patch is unfinished and is probably
> >> junk. But any thoughts on how the tracepoints should be organized
> >> in this code would help.
> >> 
> >> So I was thinking we probably want a tracepoint to fire for each
> >> case that is handled in this code (and in nfsd4_exchangeid).
> >> However, this comment in nfsd4_setclientid:
> >> 
> >>   /* Cases below refer to rfc 3530 section 14.2.33: */
> >> 
> >> Is confusing.
> >> 
> >> - RFC 3530 is superceded by RFC 7530, and the section numbers have changed.
> >> 
> >> - The cases in this section in both RFCs aren't numbered, they are
> >> bullet points.
> > 
> > Honestly I think those particular comments should just go.  The code
> > doesn't even follow those bullet points very closely any more.
> 
> OK, I'll squash this in, and include similar changes to
> nfsd4_setclientid_confirm().

The setclientid_confirm cases are a little more complicated and I think
the code there may map more closely to the RFC bullet points.

But I'm not particularly attached to them, feel free to use your
judgement for those....

--b.

> 
> 
> > --b.
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index f47f72bc871f..2aa5d15b08ed 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3954,11 +3954,9 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 	new = create_client(clname, rqstp, &clverifier);
> > 	if (new == NULL)
> > 		return nfserr_jukebox;
> > -	/* Cases below refer to rfc 3530 section 14.2.33: */
> > 	spin_lock(&nn->client_lock);
> > 	conf = find_confirmed_client_by_name(&clname, nn);
> > 	if (conf && client_has_state(conf)) {
> > -		/* case 0: */
> > 		status = nfserr_clid_inuse;
> > 		if (clp_used_exchangeid(conf))
> > 			goto out;
> > @@ -3970,7 +3968,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 	unconf = find_unconfirmed_client_by_name(&clname, nn);
> > 	if (unconf)
> > 		unhash_client_locked(unconf);
> > -	/* We need to handle only case 1: probable callback update */
> > 	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
> > 		copy_clid(new, conf);
> > 		gen_confirm(new, nn);
> 
> --
> Chuck Lever
> 
> 
