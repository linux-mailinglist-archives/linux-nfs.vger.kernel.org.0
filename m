Return-Path: <linux-nfs+bounces-3683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE0904A36
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BD7B22A82
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65E23769;
	Wed, 12 Jun 2024 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGKiVMK8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16271224C9
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167707; cv=none; b=ZyD80mGKWnaO+hEUVB63R8EiI2Z5azFGPiKn92Rhp6mxZhdfHCPSPq2MFOJmG1vheo1G5REDRp+k3DJvj5ohooE8HZqGtT+GSNmajdxE9TvDokxNATTVNzxYQRgFK/ZPE2xNazJRjYPy0te11xtTQgWRi26Z+KH0R3NqKJG2ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167707; c=relaxed/simple;
	bh=NeFXs9Zzf5zX3FxMq5Vsj5Wi16TuWLRfd5GKd5J0B2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOYcGKG1ykTN+HP6lmrnEAtOSF2ItAVoyGYFdpZWjmxIZHvjbcrQPpinD7fnCXd1Bzws6r4wU/ihbVtjjXKjeWcCzghPXVC3nBCy4JFAQe9wVY/4S20xOsB06JC1yqDy6ZBnprtBF7zPsJ8kqwmShfOnsY4Wo+5u6N+enPKzsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGKiVMK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6EC32786;
	Wed, 12 Jun 2024 04:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718167706;
	bh=NeFXs9Zzf5zX3FxMq5Vsj5Wi16TuWLRfd5GKd5J0B2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGKiVMK8Ap+maRj7Hm4NW3/7y/BlTsU+0E52OtvcVWNR9BK9AxcjNhesB5hfvCPWr
	 U6oGL1+Y6sZhFek+J9HYKaeYIoFfN1aV2OxRLtqV6FInKspVDwausJLR0qxdSv0vEw
	 8szQEnJy5bswxNVykF3rb8pFZiVgAPXYeHAnfNmCoTzSpcy6iR7snXZrhgdxQ+qom1
	 NGJrvPNB7fUHGr+z2NxI6kFhre1+8Y6M0Yi+YnW73nYG/qfdRxIK3K3yoghNDpxe8F
	 SscKytzBnioKxotQcwiO/EROt1SR0IqWOKEt/dGLxp4efsGIs8nuwrRm0UiF1HJcGD
	 IAfqq9paV7FLA==
Date: Wed, 12 Jun 2024 00:48:25 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
Message-ID: <ZmkomfPEA2ETa8kt@kernel.org>
References: <>
 <ZmkZAJtd3MhlXM7O@kernel.org>
 <171816536144.14261.4040713092050012288@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171816536144.14261.4040713092050012288@noble.neil.brown.name>

On Wed, Jun 12, 2024 at 02:09:21PM +1000, NeilBrown wrote:
> On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > On Wed, Jun 12, 2024 at 01:17:05PM +1000, NeilBrown wrote:
> > > On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > > > 
> > > > SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
> > > > ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > > > 
> > > > [the lack of useful refcounting with the current code kind of blew me
> > > > away.. but nice to see it existed not too long ago.]
> > > > 
> > > > Rather than immediately invest the effort to revert commit
> > > > 1e3577a4521e for my apparent needs... I'll send out v2 to allow for
> > > > further review and discussion.
> > > > 
> > > > But it really does feel like I _need_ svc_{get,put} and nfsd_{get,put}
> > > 
> > > You are taking a reference, and at the right time.  But it is to the
> > > wrong thing.
> > 
> > Well, that reference is to ensure nfsd (and nfsd_open_local_fh) is
> > available for the duration of a local client connected to it.
> > 
> > Really wasn't trying to keep nn->nfsd_serv around with this ;)
> > 
> > > You call symbol_request(nfsd_open_local_fh) and so get a reference to
> > > the nfsd module.  But you really want a reference to the nfsd service.
> > > 
> > > I would suggest that you use symbol_request() to get a function which
> > > you then call and immediately symbol_put().... unless you need to use it
> > > to discard the reference to the service later.
> > 
> > Getting the nfsd_open_local_fh symbol once when client handshakes with
> > server is meant to avoid needing to do so for every IO the client
> > issues to the local server.
> > 
> > > The function would take nfsd_mutex, check there is an nfsd_serv, sets a
> > > flag or whatever to indicate the serv is being used for local_io, and
> > > maybe returns the nfsd_serv.  As long as that flag is set the serv
> > > cannot be destroy.
> > >
> > > Do you need there to be available threads for LOCAL_IO to work?  If so
> > > the flag would cause setting the num threads to zero to fail.
> > > If not ....  that is weird.  It would mean that setting the number of
> > > threads to zero would not destroy the service and I don't think we want
> > > to do that.
> > > 
> > > So I think that when LOCAL_IO is in use, setting number of threads to
> > > zero must return EBUSY or similar, even if you don't need the threads.
> > 
> > Yes, but I really dislike needing to play games with a tangential
> > characteristic of nfsd_serv (that threads are what hold reference),
> > rather than have the ability to keep the nfsd_serv around in a cleaner
> > way.
> > 
> > This localio code doesn't run in nfsd context so it isn't using nfsd's
> > threads. Forcing threads to be held in reserve because localio doesn't
> > want nfsd_serv to go away isn't ideal.
> 
> I started reading the rest of the patches and it seems that localio is
> only used for READ, WRTE, COMMIT.  Is that correct?  Is there
> documentation so that I don't have to ask?

The header for v2's patch 7 (nfs/nfsd: add "localio" support) starts with:
Add client support for bypassing NFS for localhost reads, writes, and
commits.

But I should've made it clearer by saying the same in the 0th header.

> Obviously there are lots of other NFS requests so you wouldn't be able
> to use localio without nfsd threads running....

That's very true.

> But a normal remote client doesn't pin the nfsd threads or the
> nfsd_serv.  If the threads go away, the client blocks until the service
> comes back.  Would that be appropriate semantics for localio??  i.e.  on
> each nfsd_open_local_fh() call you mutex_trylock and hold that long
> enough to get the 'struct file *'.  If it fails because there is no
> serv, you simply fall-back to the same path you use for other requests.
> 
> Could that work?

I can try it, but feels like it'd elevate nfsd_mutex to "contended",
as such it feels heavy.

> > Does it maybe make sense to introduce a more narrow svc_get/svc_put
> > for this auxillary usecase?
> 
> I don't think so.  nfsd is a self-contained transactional service.  It
> doesn't promise to persist beyond each transaction.
> Current transactions return status and/or data.  Adding a new transaction
> that returns a 'struct file *' fits that model reasonable well.

Sure. But to be clear, I am adding global state to nfs_common that
tracks nfsd_uuids. Those change every time a new nfsd_net is created
for a given server (client will then lookup the uuid to see if local).

But even if we went to the extreme where nfsd instances are bouncing
like crazy, the 'nfsd_uuids' list in nfs_common should work fine.

Just not seeing what is gained by nfsd being so ephemeral.  Maybe your
point is, it should work in that model too?.. I think it would, just
less efficiently due to make-work to re-get resources it needs.

> Taking an external reference to the nfs service is quite a big
> conceptual change.

Getting the nfsd_open_local_fh() symbol in a coarse-grained manner
isn't about anything other than efficiency.  Ensures localio client
calls to nfsd_open_local_fh will work for as long as it exists on that
local server -- nfs.ko's indirect reference to nfsd.ko (via
nfs_localio.ko getting symbol for nfsd_open_local_fh) is dropped when
client is destroyed.

Mike

