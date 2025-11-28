Return-Path: <linux-nfs+bounces-16782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 961ABC932E1
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B57233473A8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32452246BC7;
	Fri, 28 Nov 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nUlGN0NR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IXvM5AJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8B1DE2AD
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364843; cv=none; b=UtICxZ6163VuCK8sqEyYU2A8rRKvPgqGm5NUKm+HioIPCjPd8sNQhEghAf7IrStPz647mcLz301QNal7efKZ0czyw+kk2PsVcf9usXP3a1aBkmvgHTaOOqB7Ky5yDBuBoLJC455hTJjO6424d662u2kqzDDARunrqafRqS+q9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364843; c=relaxed/simple;
	bh=rDRu152hEmwxHrRczfbqgwepqYB00+cTXZzj6JcWpeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIgpKBkX8FdioWj5cnsOmQKwgFHnxAXjSsBV9gY6qg8seB7repSyoOiqmByZ6Y0q0UoL24KeFsDvXFFViMS7bzgC3gP/A1Vv67ThLPdVQjl1iU/5BMjL4fVXwrLAqGIrovFtTmgYvHNqMAmVmkWIEQYt39EGFl9F/zE56vkI+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nUlGN0NR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IXvM5AJe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC62B3376B;
	Fri, 28 Nov 2025 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764364839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUuA+EbVmRkE8AAGZMeKrX2qVPlqAaV4vprXKDXarDM=;
	b=nUlGN0NRL1sKtBg11vNimworHAdmXlyCPOX6P5KNQzRMC+Ji3Gr2F/rMNuS17+s3sqiXHE
	2KfmRaybJ99afDCuY6RRAnePzqvvtu8X7wgEadsAhFxw2GItlrw/rwjFh7G9qtHAbNCIMj
	PtTZCDf9BUEg3dc3s0KKhYWLXH/EneY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IXvM5AJe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764364838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUuA+EbVmRkE8AAGZMeKrX2qVPlqAaV4vprXKDXarDM=;
	b=IXvM5AJesGHidWQYGPUkePgpTnzJIUZkmDZvXwTgHb6dQDlyRcX9STH80Pkt2BQIDztmfW
	TD9zmMwjGa+SnvnyULw9bsvNIRugwtllvo4a07DRxawqrIv2+o0RJFwOQyZvtDUb3RxjC7
	WUJcEQ52S5q6fpKH/RBk8l5rRRIspSQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912643EA63;
	Fri, 28 Nov 2025 21:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAJZICYSKmnuWQAAD6G6ig
	(envelope-from <ailiop@suse.com>); Fri, 28 Nov 2025 21:20:38 +0000
Date: Fri, 28 Nov 2025 22:20:37 +0100
From: Anthony Iliopoulos <ailiop@suse.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: never defer requests during idmap lookup
Message-ID: <aSoSJcYIXDEi3kvJ@technoir>
References: <20251127175753.134132-1-ailiop@suse.com>
 <20251127175753.134132-2-ailiop@suse.com>
 <388da717-eb5a-4497-99f7-6a6f34405b58@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388da717-eb5a-4497-99f7-6a6f34405b58@app.fastmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EC62B3376B
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri, Nov 28, 2025 at 11:09:52AM -0500, Chuck Lever wrote:
> 
> 
> On Thu, Nov 27, 2025, at 12:57 PM, Anthony Iliopoulos wrote:
> > During v4 request compound arg decoding, some ops (e.g. SETATTR) can
> > trigger idmap lookup upcalls. When those upcall responses get delayed
> > beyond the allowed time limit, cache_check() will mark the request for
> > deferral and cause it to be dropped.
> 
> The RFCs mandate that NFSv4 servers MUST NOT drop requests. What
> nfsd_dispatch() does in your case is return RPC_GARBAGE_ARGS to
> the client, which is distinct behavior from "dropping" a request.

It actually does drop the request, as pc_decode doesn't fail when this
happens.

For example in one instance of this issue which occurs while decoding a
SETATTR op that has FATTR4_WORD1_OWNER/GROUP set, nfsd4_decode_setattr
returns with status set to nfserr_badowner. This is set in op->status in
nfsd4_decode_compound, which will stop decoding further ops, but stil
returns true.

During nfsd4_decode_setattr, nfsd_map_name_to_[ug]id will end up calling
cache_check in idmap_lookup. What that does is basically:

- issue the upcall
- wait for completion with a short timeout
- attempt to defer the request if the upcall hasn't updated the cache entry
  in the meantime

That happens by calling svc_defer which will set RQ_DROPME on the
rqstp->rq_flags, causing nfsd_dispatch to return through the
out_update_drop, and in turn there will be no response sent out by
svc_process.

> > Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
> > nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.
> 
> Help me understand how the upcall failure during XDR decoding is
> handled later? What server response is returned? Is it possible
> for the proc function to execute anyway with incorrect uid and
> gid values?

Without the next patch in this series, if the request isn't deferred it
will send back the NFS4ERR_BADOWNER status, which the nfs client will
map to -EINVAL and return to userspace.

With the next patch, it will return NFS4ERR_DELAY so that the client
will keep retrying the request until the id mapping completes.

In either case, even when the request is being dropped, the proc
function is never executed. While nfsd_dispatch will proceed to call the
pc_func, nfsd4_proc_compound checks for the op->status which was set in
the decoding stage, and jumps to nfsd4_encode_operation without calling
the op_func. In the particular instance of the SETATTR op, the encoder
will encode an empty attrsset bitmap to indicate the inability to set
any attributes.

Regards,
Anthony

