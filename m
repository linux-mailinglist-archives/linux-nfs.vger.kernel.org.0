Return-Path: <linux-nfs+bounces-4246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DD913EFF
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C0E1C209BA
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D0183079;
	Sun, 23 Jun 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WO042xN3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GuxZmp2F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eGYXdJak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMYXdfz0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B4156678
	for <linux-nfs@vger.kernel.org>; Sun, 23 Jun 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719181678; cv=none; b=HWdyGnJG7Ut+o2d+ah06rrzeGHluHJQ5D/LI3Vb3nkBIhUFiafN6aBBilLMWUtBMZdcEagh4L1FkUyutW1w4zzPj4/hZgvzh19MVSnixbOZAVfnqSR0R7TNjI4lcNaKHN5wEKfpP0+9/tNHdTBGWZp0/ltuQCTzR5BwJ5t2KoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719181678; c=relaxed/simple;
	bh=K2gwhnVtm1c+F4hnxdHKLPVMBJ1oUkPhUnrK8TH0s5c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pqk8QD7yEAO4K4ZXZCLZYtr4J0ooixQUN1zzXZdR2UAWaR9ad943fJlw9Lqxx+/X94S1FidxEhKJ04Rn3KvGnUfJ9ZrjAiPHOlIYKXpNS8+SiydkkPE8MjTUe92BqNq4ZA/VK9K69NIYm0ZkExVO6AakOcRsK/EyRxR1qwxxGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WO042xN3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GuxZmp2F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eGYXdJak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMYXdfz0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41F371F393;
	Sun, 23 Jun 2024 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719181668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBh9TMU0CXp3i8HNE9qwrZoK3v+hQdobQfy+ZQH80M0=;
	b=WO042xN3E3hgrNC6+jXQwWHbMO0qOB3e2ezfavVf1TkmAONXcWJHJgN2MKA3y4ks7Ij/tC
	RvsTRylLV51N+PsXg1RMujDLuTuRHaTBQRgiG1fnaZ/vk/SrjYvYaoXvi8jeVjxwufNftf
	IOQPmSXxXCyK2MLCnI+4QMwn0RJt9Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719181668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBh9TMU0CXp3i8HNE9qwrZoK3v+hQdobQfy+ZQH80M0=;
	b=GuxZmp2FaeCpaRvchMmM4L0A0rS5+k/iy06F1BgRSliyLC/pca7htdTRhJ4jLAy5pNrD2V
	pUhopPvgYnwO9LCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eGYXdJak;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wMYXdfz0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719181667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBh9TMU0CXp3i8HNE9qwrZoK3v+hQdobQfy+ZQH80M0=;
	b=eGYXdJakITS2WsZxP96QPnzuTA0k6x10M2Oi15a4l9X0r67X3RxF4pHW0wD9760PsxtVDp
	eV3F6rlEptM3gMwVmB57i1UGdCE8ZRyJwK29uYS/bXtaFYJUEUXiho3UCyh0hWq6qDgKTt
	89hoeQk40u3Y9i9MK9ONhqq+aIFDUcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719181667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBh9TMU0CXp3i8HNE9qwrZoK3v+hQdobQfy+ZQH80M0=;
	b=wMYXdfz0ezWdIvw2Bk80uGbqXzjFfDZVWcamJUXDlg4vURmK04ySYXlSi5dHkaRCxCNJqF
	TTu3aYt4CpkkRyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77061398F;
	Sun, 23 Jun 2024 22:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4i0RE2CheGayagAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 23 Jun 2024 22:27:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v6 06/18] nfs/nfsd: add "localio" support
In-reply-to: <ZnYMh35G6WC1YgCA@kernel.org>
References: <>, <ZnYMh35G6WC1YgCA@kernel.org>
Date: Mon, 24 Jun 2024 08:27:39 +1000
Message-id: <171918165963.14261.959545364150864599@noble.neil.brown.name>
X-Rspamd-Queue-Id: 41F371F393
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat, 22 Jun 2024, Mike Snitzer wrote:
> On Fri, Jun 21, 2024 at 04:08:20PM +1000, NeilBrown wrote:
> > 
> > Both branches of this if() do exactly the same thing.  iov_iter_advance
> > is a no-op if the size arg is zero.
> 
> iov_iter_advance doesn't look to be a no-op if the size arg is zero.

void iov_iter_advance(struct iov_iter *i, size_t size)
{
	if (unlikely(i->count < size))
		size = i->count;
	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
		i->iov_offset += size;
		i->count -= size;
	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
		/* iovec and kvec have identical layouts */
		iov_iter_iovec_advance(i, size);
	} else if (iov_iter_is_bvec(i)) {
		iov_iter_bvec_advance(i, size);
	} else if (iov_iter_is_discard(i)) {
		i->count -= size;
	}
}

This adds "size" to offset, and subtracts "size" from count.  For iovec
and bvec it is a slightly complicated dance to achieve this, but that is
the net result.
So if "size" is zero there is no change to the iov_iter.  Just some
wasted cycles.  Do those cycles justify the extra conditional branch?  I
don't know.  I would generally prefer simpler code which is only
optimised with evidence.  Admittedly I don't always follow that
preference myself and I won't hold you to it.  But I thought the review
would be incomplete without mentioning it.


>  
> > Is it really worth increasing the code size to sometimes avoid a
> > function call?
> >
> > At least we should for the iov_iter_bvec() inconditionally, then maybe
> > call _advance().
> 
> For v7, I've fixed it so we do what you suggest.

Thanks.

> > > +static void
> > > +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> > > +{
> > > +	struct kstat stat;
> > > +
> > > +	if (fattr != NULL && vfs_getattr(&filp->f_path, &stat,
> > > +					 STATX_INO |
> > > +					 STATX_ATIME |
> > > +					 STATX_MTIME |
> > > +					 STATX_CTIME |
> > > +					 STATX_SIZE |
> > > +					 STATX_BLOCKS,
> > > +					 AT_STATX_SYNC_AS_STAT) == 0) {
> > > +		fattr->valid = NFS_ATTR_FATTR_FILEID |
> > > +			NFS_ATTR_FATTR_CHANGE |
> > > +			NFS_ATTR_FATTR_SIZE |
> > > +			NFS_ATTR_FATTR_ATIME |
> > > +			NFS_ATTR_FATTR_MTIME |
> > > +			NFS_ATTR_FATTR_CTIME |
> > > +			NFS_ATTR_FATTR_SPACE_USED;
> > > +		fattr->fileid = stat.ino;
> > > +		fattr->size = stat.size;
> > > +		fattr->atime = stat.atime;
> > > +		fattr->mtime = stat.mtime;
> > > +		fattr->ctime = stat.ctime;
> > > +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> > 
> > This looks wrong for NFSv4.  I think we should use
> > nfsd4_change_attribute().
> > Maybe it isn't important, but if it isn't I'd like to see an explanation
> > why.
> > 
> > > +		fattr->du.nfs3.used = stat.blocks << 9;
> > > +	}
> > > +}
> 
> Not following, this is client code so it doesn't have access to
> nfsd4_change_attribute().

This is nfs-localio code which blurs the boundary between server and
client...

The change_attr is used by NFS to detect if a file might have changed.
This code is used to get the attributes after a write request.
NFS uses a GETATTR request to the server at other times.  The
change_attr should be consistent between the two else comparisons will
be meaningless.

So I think that nfs_get_vfs_attr() should use the same change_attr as
the one that would be used if the NFS GETATTR request were made.
For NFSv3, that is nfs_timespec_to_change_attr() as you have.
For NFSv4 it is something different.

I think that having inconsistent change_attrs could cause NFS to flush
its page cache unnecessarily.  As it can read directly from the
server-side where is likely is cached, that might not be a problem.  If
that reasoning does apply it should be explained.

However there is talk of exporting the "i_version" number to userspace
through xattr.  For NFS that is essentially the change_attr. If we did
that we would really want to keep the number consistent.

We could easily move nfsd4_change_attribute() into nfs_common or even
make it an inline in some common include file.  It doesn't use any nfsd
internals.

Thanks,
NeilBrown


> 
> Pending clarification, and further review on my part, leaving this
> item to one side (so won't be addressed in v7).
> 
> Thanks,
> Mike
> 


