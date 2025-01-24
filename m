Return-Path: <linux-nfs+bounces-9574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E21A1B795
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DC0188F2E8
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEC78F23;
	Fri, 24 Jan 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="fr/xLQGV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE828614E;
	Fri, 24 Jan 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727675; cv=none; b=n/KSQ/nMQzZ0mfIVFSlpYdrN8NQ8naFGVnnzGWLWA2JdZp253MrpIRHn+JipTNEYivvLQ0jUPqVSqpMsV+oxfnVzzihpqypGniApIUzf9w83iSal80MXx8CBWmIOskp5nxur1gJ7yt5oBAcIAJMZsnRno9H0dYAW19Rr6gM6jO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727675; c=relaxed/simple;
	bh=c5TQs5wxsgX6dCmGKRNNGIwr8UK+qKgeQVNNMkuJal0=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=bnqYKosnn0kORXA3eHMyMkBQNJBKymkOkJGLANJ5QQNFtdut+nFGqeP2pu6eUU9t0y3Xbek2gk4UwnP1IxcpFq/6TKxrPdpoO7M3m6WxCZ47vxq0hHkuyV6YcbhqCBTFik2ls4awG/Mb26eHRe8B8XHeGsbNuBkOVv+DrZ4oqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=fr/xLQGV; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id 89F34FA111; Fri, 24 Jan 2025 09:00:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org 89F34FA111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1737727248;
	bh=cnY+PjJPxBJIsVwGmcrb7Sff2z+2xdN/d7twRRHEDaQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=fr/xLQGV1Yzr0W+GdhAsaHfLBdpKuAE9FA75UlPg5dinMwu3DSEsFrn7JiUC3zd0z
	 0wi+1wQUZqE3bpyBFM4yGbgR2iGGvVkC+qx2npgiwzxJTESzQL1vACKrRIaEd2YNTX
	 /rGePE3gJ6PD65FIPaFafO3gkhDBifx9HUvlSlhA=
Date: Fri, 24 Jan 2025 09:00:48 -0500
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Kinglong Mee <kinglongmee@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
Message-ID: <Z5OdECjsie-MCFel@poldevia.fieldses.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
 <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Thu, Jan 23, 2025 at 06:20:08PM -0500, Jeff Layton wrote:
> On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
> > On 1/23/25 3:25 PM, Jeff Layton wrote:
> > > RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
> > > 
> > > "For any of a number of reasons, the replier could not process this
> > >   operation in what was deemed a reasonable time. The client should wait
> > >   and then try the request with a new slot and sequence value."
> > 
> > A little farther down, Section 15.1.1.3 says this:
> > 
> > "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
> >   retried in full with the SEQUENCE operation containing the same slot
> >   and sequence values."
> > 
> > And:
> > 
> > "If NFS4ERR_DELAY is returned on an operation other than the first in
> >   the request, the request when retried MUST contain a SEQUENCE operation
> >   that is different than the original one, with either the slot ID or the
> >   sequence value different from that in the original request."
> > 
> > My impression is that the slot needs to be held and used again only if
> > the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
> > the NFS4ERR_DELAY was the status of the 2nd or later operation in the
> > COMPOUND, then yes, a different slot, or the same slot with a bumped
> > sequence number, must be used.
> > 
> > The current code in nfsd4_cb_sequence_done() appears to be correct in
> > this regard.
> > 
> 
> Ok! I stand corrected. We should be able to just drop this patch, but
> some of the later patches may need some trivial merge conflicts fixed
> up.
> 
> Any idea why SEQUENCE is different in this regard?

Isn't DELAY on SEQUENCE an indication that the operation is still in
progress?  The difference between retrying the same slot or not is
whether you're asking the server again for the result of the previous
operation, or whether you're asking it to perform a new one.

If you get DELAY on a later op and then keep retrying with the same
seqid/slot then I'd expect you to get stuck in an infinite loop getting
a DELAY response out of the reply cache.

--b.


> This rule seems a
> bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
> matter which slot you use when retransmitting? The responder is just
> saying "go away and come back later".
> 
> What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
> it's under resource pressure), and also shrinks the slot table in the
> meantime? It seems like that might put the requestor in an untenable
> position.
> 
> Maybe we should lobby to get this changed in the spec?
> 
> > 
> > > This is CB_SEQUENCE, but I believe the same rule applies. Release the
> > > slot before submitting the delayed RPC.
> > > 
> > > Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >   fs/nfsd/nfs4callback.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc908833a384d741e966a8db 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > >   		goto need_restart;
> > >   	case -NFS4ERR_DELAY:
> > >   		cb->cb_seq_status = 1;
> > > +		nfsd41_cb_release_slot(cb);
> > >   		if (!rpc_restart_call(task))
> > >   			goto out;
> > >   
> > > 
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

