Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA382FF638
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 21:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhAUUoY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 15:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbhAUUoX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 15:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611261776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UWo4HhYlxv8tjZFSA5JyB4j+mQIxQ0foRuMH+nRTDS8=;
        b=SArUZHARDJlkCjutbNHcobB+phIkJaIMmBcuGYzMH9TRiig72HuYkkTsrA0WmFlLRNBA14
        fDU0LFI3uBtJsF892FoKYTMyn59HTnW5Q7psTeFw6jhW/TyethlYlV8MlCbrgGgwkT4gjC
        mjNEhpdXmVV0Q1aQxFBCNsJ9cTicb/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-iLnLYfU8MrKiiiZx8ivYTw-1; Thu, 21 Jan 2021 15:42:54 -0500
X-MC-Unique: iLnLYfU8MrKiiiZx8ivYTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D52B1800D41;
        Thu, 21 Jan 2021 20:42:53 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-121-75.rdu2.redhat.com [10.10.121.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE53C5D9C6;
        Thu, 21 Jan 2021 20:42:52 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 208271204AB; Thu, 21 Jan 2021 15:42:51 -0500 (EST)
Date:   Thu, 21 Jan 2021 15:42:51 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] nfsd: remove unused set_clientid argument
Message-ID: <20210121204251.GB13298@pick.fieldses.org>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
 <1611254995-23131-7-git-send-email-bfields@redhat.com>
 <FFAFBDA2-A047-424E-971D-B32CB08D45F6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFAFBDA2-A047-424E-971D-B32CB08D45F6@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 08:20:53PM +0000, Chuck Lever wrote:
> 
> 
> > On Jan 21, 2021, at 1:49 PM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > Every caller is setting this argument to false, so we don't need it.
> > 
> > Also clarify comments a little.
> 
> Some nits:
> 
> - The subject says "set_clientid" but the function name is "set_client"

Thanks, fixed.

> - Is the WARN_ON_ONCE() still needed? (noticed yesterday, but I forgot
> to mention it)

No, I don't think that's an especially interesting case to check for.
I'll drop it.

> 
> - This one doesn't compile:

Oops, thanks, yes, I missed a caller that gets deleted in the next
patch.

> I think I will need a v3 of this series because 8/9 will have to
> be fixed up too. Please be sure to add the series version number
> when you repost.

OK!--b.

> 
> Thanks!
> 
> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 22 +++++++++-------------
> > 1 file changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index db10fef1c1d2..7c95f8808324 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4648,8 +4648,7 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
> > 
> > static __be32 set_client(clientid_t *clid,
> > 		struct nfsd4_compound_state *cstate,
> > -		struct nfsd_net *nn,
> > -		bool sessions)
> > +		struct nfsd_net *nn)
> > {
> > 	if (cstate->clp) {
> > 		if (!same_clid(&cstate->clp->cl_clientid, clid))
> > @@ -4658,13 +4657,10 @@ static __be32 set_client(clientid_t *clid,
> > 	}
> > 	if (STALE_CLIENTID(clid, nn))
> > 		return nfserr_stale_clientid;
> > -	/*
> > -	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
> > -	 * cached already then we know this is for is for v4.0 and "sessions"
> > -	 * will be false.
> > -	 */
> > +	/* For v4.1+ we should have gotten the client in the SEQUENCE op: */
> > 	WARN_ON_ONCE(cstate->session);
> > -	cstate->clp = lookup_clientid(clid, sessions, nn);
> > +	/* So we're looking for a 4.0 client (sessions = false): */
> > +	cstate->clp = lookup_clientid(clid, false, nn);
> > 	if (!cstate->clp)
> > 		return nfserr_expired;
> > 	return nfs_ok;
> > @@ -4688,7 +4684,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
> > 	if (open->op_file == NULL)
> > 		return nfserr_jukebox;
> > 
> > -	status = set_client(clientid, cstate, nn, false);
> > +	status = set_client(clientid, cstate, nn);
> > 	if (status)
> > 		return status;
> > 	clp = cstate->clp;
> > @@ -5298,7 +5294,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > 
> > 	trace_nfsd_clid_renew(clid);
> > -	status = set_client(clid, cstate, nn, false);
> > +	status = set_client(clid, cstate, nn);
> > 	if (status)
> > 		return status;
> > 	clp = cstate->clp;
> > @@ -5681,7 +5677,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > 		CLOSE_STATEID(stateid))
> > 		return nfserr_bad_stateid;
> > -	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
> > +	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
> > 	if (status == nfserr_stale_clientid) {
> > 		if (cstate->session)
> > 			return nfserr_bad_stateid;
> > @@ -6905,7 +6901,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 		 return nfserr_inval;
> > 
> > 	if (!nfsd4_has_session(cstate)) {
> > -		status = set_client(&lockt->lt_clientid, cstate, nn, false);
> > +		status = set_client(&lockt->lt_clientid, cstate, nn);
> > 		if (status)
> > 			goto out;
> > 	}
> > @@ -7089,7 +7085,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> > 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
> > 		clid->cl_boot, clid->cl_id);
> > 
> > -	status = set_client(clid, cstate, nn, false);
> > +	status = set_client(clid, cstate, nn);
> > 	if (status)
> > 		return status;
> > 
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 
> 

