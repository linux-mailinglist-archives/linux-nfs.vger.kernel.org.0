Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90302FDF52
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 03:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391398AbhATXw1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 18:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403761AbhATXRc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 18:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611184565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCLezltie5wYfotbXWmNg/1d/WjS5Yn5+WFWhZV0qS4=;
        b=Sq3efJUUdazZKs/5U40zeU53rkOt896uXw9euRRDfdvlCawYuR0++vsNqO4v3N2oJufO3n
        YLX4StLZh8VDw1pQkPM/W5ZAYXK/LT0MaMd4k36XXBpNZjRBeszEVtfI2KL9mgCXvv5ype
        VEMcFHNZTsI0RTUvuyqDqaJ9YNGuCAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-9TrC2rF2PVSgiySlJ-SOMQ-1; Wed, 20 Jan 2021 18:01:05 -0500
X-MC-Unique: 9TrC2rF2PVSgiySlJ-SOMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 386A5107ACE8;
        Wed, 20 Jan 2021 23:01:04 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-179.phx2.redhat.com [10.3.113.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09E591B47B;
        Wed, 20 Jan 2021 23:01:04 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 0FF5A12054F; Wed, 20 Jan 2021 18:01:03 -0500 (EST)
Date:   Wed, 20 Jan 2021 18:01:02 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] nfsd: refactor lookup_clientid
Message-ID: <20210120230102.GC167212@pick.fieldses.org>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
 <1611095729-31104-5-git-send-email-bfields@redhat.com>
 <D646BC66-D79B-4EA7-807E-A60B5255FFF9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D646BC66-D79B-4EA7-807E-A60B5255FFF9@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 20, 2021 at 09:02:25PM +0000, Chuck Lever wrote:
> 
> 
> > On Jan 19, 2021, at 5:35 PM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > I think set_client is a better name, and the lookup itself I want to
> > use somewhere else.
> 
> Should this be two patches?
> - Rename lookup_clientid() to set_client()
> - Refactor the lookup_clientid() helper

Sure.

> nfs4state.c stops compiling with this patch. See below.

Oops, thanks.

If these look OK otherwise, I can resend.

--b.

> 
> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++-----------------------
> > 1 file changed, 24 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ba955bbf21df..d7128e16c86e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4633,40 +4633,40 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
> > 	return nfserr_bad_seqid;
> > }
> > 
> > -static __be32 lookup_clientid(clientid_t *clid,
> > +static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
> > +						struct nfsd_net *nn)
> > +{
> > +	struct nfs4_client *found;
> > +
> > +	spin_lock(&nn->client_lock);
> > +	found = find_confirmed_client(clid, sessions, nn);
> > +	if (found)
> > +		atomic_inc(&found->cl_rpc_users);
> > +	spin_unlock(&nn->client_lock);
> > +	return found;
> > +}
> > +
> > +static __be32 set_client(clientid_t *clid,
> > 		struct nfsd4_compound_state *cstate,
> > 		struct nfsd_net *nn,
> > 		bool sessions)
> > {
> > -	struct nfs4_client *found;
> > -
> > 	if (cstate->clp) {
> > -		found = cstate->clp;
> > -		if (!same_clid(&found->cl_clientid, clid))
> > +		if (!same_clid(&cstate->clp->cl_clientid, clid))
> > 			return nfserr_stale_clientid;
> > 		return nfs_ok;
> > 	}
> > -
> > 	if (STALE_CLIENTID(clid, nn))
> > 		return nfserr_stale_clientid;
> > -
> > 	/*
> > 	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
> > 	 * cached already then we know this is for is for v4.0 and "sessions"
> > 	 * will be false.
> > 	 */
> > 	WARN_ON_ONCE(cstate->session);
> > -	spin_lock(&nn->client_lock);
> > -	found = find_confirmed_client(clid, sessions, nn);
> > -	if (!found) {
> > -		spin_unlock(&nn->client_lock);
> > +	cstate->clp = lookup_clientid(clid, sessions, nn);
> > +	if (!cstate->clp)
> > 		return nfserr_expired;
> > -	}
> > -	atomic_inc(&found->cl_rpc_users);
> > -	spin_unlock(&nn->client_lock);
> > -
> > -	/* Cache the nfs4_client in cstate! */
> > -	cstate->clp = found;
> > 	return nfs_ok;
> > }
> > 
> > @@ -4688,7 +4688,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
> > 	if (open->op_file == NULL)
> > 		return nfserr_jukebox;
> > 
> > -	status = lookup_clientid(clientid, cstate, nn, false);
> > +	status = set_client(clientid, cstate, nn, false);
> > 	if (status)
> > 		return status;
> > 	clp = cstate->clp;
> > @@ -5298,7 +5298,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > 
> > 	trace_nfsd_clid_renew(clid);
> > -	status = lookup_clientid(clid, cstate, nn, false);
> > +	status = set_client(clid, cstate, nn, false);
> > 	if (status)
> > 		return status;
> > 	clp = cstate->clp;
> > @@ -5681,8 +5681,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > 		CLOSE_STATEID(stateid))
> > 		return nfserr_bad_stateid;
> > -	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
> > -				 false);
> > +	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
> > 	if (status == nfserr_stale_clientid) {
> > 		if (cstate->session)
> > 			return nfserr_bad_stateid;
> > @@ -5821,7 +5820,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > 
> > 	cps->cpntf_time = ktime_get_boottime_seconds();
> > 	memset(&cstate, 0, sizeof(cstate));
> > -	status = lookup_clientid(&cps->cp_p_clid, &cstate, nn, true);
> > +	status = set_clientid(&cps->cp_p_clid, &cstate, nn, true);
> 
> This doesn't compile. I think you meant set_client() here.
> 
> 
> > 	if (status)
> > 		goto out;
> > 	status = nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
> > @@ -6900,8 +6899,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 		 return nfserr_inval;
> > 
> > 	if (!nfsd4_has_session(cstate)) {
> > -		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
> > -					 false);
> > +		status = set_client(&lockt->lt_clientid, cstate, nn, false);
> > 		if (status)
> > 			goto out;
> > 	}
> > @@ -7085,7 +7083,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> > 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
> > 		clid->cl_boot, clid->cl_id);
> > 
> > -	status = lookup_clientid(clid, cstate, nn, false);
> > +	status = set_client(clid, cstate, nn, false);
> > 	if (status)
> > 		return status;
> > 
> > @@ -7232,7 +7230,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
> > 	__be32 status;
> > 
> > 	/* find clientid in conf_id_hashtbl */
> > -	status = lookup_clientid(clid, cstate, nn, false);
> > +	status = set_clientid(clid, cstate, nn, false);
> 
> Ditto.
> 
> 
> > 	if (status)
> > 		return nfserr_reclaim_bad;
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

