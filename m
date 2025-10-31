Return-Path: <linux-nfs+bounces-15854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EAEC25CF8
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C140B4E50DA
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C7284689;
	Fri, 31 Oct 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flsKwqEE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8325CC4D
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923831; cv=none; b=ZAxNtTOxlVWb9ghR5NRB8DGA9sGN2Mb2bCemRAr85juoJJUbn4Ky/z27l5A37k2YBP28JlN22Bhb4P7M7Ba0QtU9W8kZHPTCG2fUYBOT5bf7BM23L+DY2TEyeoAHwTyQEcNHkvZatH3OwFXCZWNQM8pjPL4L/j4j2oJcP4I7lFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923831; c=relaxed/simple;
	bh=/64G3Pjqy9FMLi7gr2rIYsRpDGylQM/2Au6iGLlFaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2dFIEAhAL+QVW/FK5JU9xqXs3p9GnoKwL+k0uzWdv1iLkyX6ShD3WikixNZsVBW4KJG2xZJvLsMzEpMmKwpVMQoSYNi3krg5zcKK4JRmj4RV+sp/VxxRwq45RvGKTaaCc0C9X1iL9NcYyjN9+kNecc/DgLn0j3fWFi1iHsMIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flsKwqEE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761923828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q11xKH2kHPpRanHFwiumdAhgBlGGPuzVoyJ1SVgNj2g=;
	b=flsKwqEEPIiBRFDg7LdEhg1JCk1cZa2LK5XeZITeGVYOcz3JlTXmRjB2VLtk907GwS2w2s
	Gh+DUCk0E5T5gZ1X87Fbw0/4ik+h8hWZ5Lf/S6K6oYPclsU96JOX//gkcEIlbwGTbVVL/A
	Ocid/scd5KFgGzpCSsCE6q4cp4I6AZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-q7nzIBh9OMC2LDNdjTxpIg-1; Fri,
 31 Oct 2025 11:17:06 -0400
X-MC-Unique: q7nzIBh9OMC2LDNdjTxpIg-1
X-Mimecast-MFC-AGG-ID: q7nzIBh9OMC2LDNdjTxpIg_1761923825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811CC1956048;
	Fri, 31 Oct 2025 15:17:05 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C10719560A2;
	Fri, 31 Oct 2025 15:17:05 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 43B7E4DCA3D; Fri, 31 Oct 2025 11:17:03 -0400 (EDT)
Date: Fri, 31 Oct 2025 11:17:03 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Benjamin J Coddington <ben.coddington@hammerspace.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: ensure the open stateid seqid doesn't go backwards
Message-ID: <aQTS76CWF_jArVq6@aion>
References: <20251029193135.1527790-1-smayhew@redhat.com>
 <91B71657-6813-478A-98EC-27FDE7114B37@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91B71657-6813-478A-98EC-27FDE7114B37@hammerspace.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, 30 Oct 2025, Benjamin J Coddington wrote:

> On 29 Oct 2025, at 15:31, Scott Mayhew wrote:
> 
> > We have observed an NFSv4 client receiving a LOCK reply with a status of
> > NFS4ERR_OLD_STATEID and subsequently retrying the LOCK request with an
> > earlier seqid value in the stateid.  As this was for a new lockowner,
> > that would imply that nfs_set_open_stateid_locked() had updated the open
> > stateid seqid with an earlier value.
> >
> > Looking at nfs_set_open_stateid_locked(), if the incoming seqid is out
> > of sequence, the task will sleep on the state->waitq for up to 5
> > seconds.  If the task waits for the full 5 seconds, then after finishing
> > the wait it'll update the open stateid seqid with whatever value the
> > incoming seqid has.  If there are multiple waiters in this scenario,
> > then the last one to perform said update may not be the one with the
> > highest seqid.
> >
> > Add a check to ensure that the seqid can only be incremented, and add a
> > tracepoint to indicate when old seqids are skipped.
> >
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c  | 7 +++++++
> >  fs/nfs/nfs4trace.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 411776718494..840ec732ade4 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -1780,6 +1780,13 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
> >                 if (nfs_stateid_is_sequential(state, stateid))
> >                         break;
> >
> > +               if (nfs4_stateid_match_other(stateid, &state->open_stateid) &&
> 
> Should we unroll or modify nfs_stateid_is_sequential() which is already
> doing the match_other check here?  Maybe it could become
> nfs_stateid_is_sequential_or_.. skipped?  lost?

I think folding the check into nfs_stateid_is_sequential() would make
the code less readable.  nfs_stateid_is_sequential() returns a bool.  If
we add our check in there, then we'd need some extra info to indicate
why it's returning false.  Is it because the incoming stateid seqid is
more than 1 greater than the open stateid seqid (in which case we want
the caller to wait)?  Or is it <= to the open stateid seqid (in which
case we just want the caller to exit)?

I suppose we could change the return value to -1/0/1 or add and output
parameter or something.  Personally I just think it's clearer to have the
extra check.

-Scott
> 
> This is going to be a super-rare occurrence, but when it happens we should
> be aware that we're going to process the waiters out-of-order.
> 
> I'm trying to see any harmful side-effects of doing so, but not coming up
> with anything.  I guess we could have mis-ordered setting of
> NFS_DELEGATED_STATE, but I think we race to that anyway.
> 
> I've tried to think this over carefully - so:
> 
> Reviewed-by: Benjamin Coddington <ben.coddington@hammerspace.com>
> 
> Ben
> 
> 
> > +                   !nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
> > +                       trace_nfs4_open_stateid_update_skip(state->inode,
> > +                                                           stateid, status);
> > +                       return;
> > +               }
> > +
> >                 if (status)
> >                         break;
> >                 /* Rely on seqids for serialisation with NFSv4.0 */
> > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > index 9776d220cec3..6285128e631a 100644
> > --- a/fs/nfs/nfs4trace.h
> > +++ b/fs/nfs/nfs4trace.h
> > @@ -1353,6 +1353,7 @@ DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_setattr);
> >  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_delegreturn);
> >  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update);
> >  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_wait);
> > +DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_skip);
> >  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_close_stateid_update_wait);
> >
> >  DECLARE_EVENT_CLASS(nfs4_getattr_event,
> > --
> > 2.51.0
> 


