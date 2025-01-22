Return-Path: <linux-nfs+bounces-9495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C9A19A37
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8216216A25C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0281C5D4A;
	Wed, 22 Jan 2025 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S4MPYi5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VZUgzuUr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S4MPYi5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VZUgzuUr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BA1C5D49
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580493; cv=none; b=hOwBtRvgAC8HLi8QA/Kiq7hJ0A8c4gOkgUxnsZDGzMMLAVcjiXfo8KyLOgJwZhIY4UQchq3M5hj0SYfrNLnPK1p7Lq2rdxihAV2kG39MblEbQpvBIqbwvzBvb2W+L3K0m5jMjOsLzpDc4q7By1c4at4dB8LuuhWV+gOtMtyPLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580493; c=relaxed/simple;
	bh=U0IeU1noBuEB950eXvfWKDLo9JixThhDv79ADOHYw/w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NTb6onjylCJH0L3OxpaEC8L6Jvy5E99wiLFOLsjc6C3WEK76GXxupTAQvJJWk7V3MX9FybsSvcJP0U0gK8kAEaP+b04KBmjGhYZC5p8H8sEe+Ut9eOJX02PpkWA2HpmACRoYsadhMSlBTtpfNwcNT07jNrDN9PycX5a2ptE5mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S4MPYi5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VZUgzuUr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S4MPYi5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VZUgzuUr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA54621178;
	Wed, 22 Jan 2025 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737580489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/yYUyFwA5oAKs9Olh3PG37DRpATKp/bUjGmvoAotp4=;
	b=S4MPYi5aDFhCCzSI9ZEWzbQLfLtvRNNfi/4hEMORmI+wNNS6ZLbuaGyBr9xTa7TPG8MPbd
	axkPa0XgQgV5/G7UpZAJN+ZZEEwzx7L7oOK6lCjnYQQk2kN/HZMS5jhreaQVg26ZpQU2Ae
	RaPODeYIv7RNIzmyWTcFKgfhx9y+RhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737580489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/yYUyFwA5oAKs9Olh3PG37DRpATKp/bUjGmvoAotp4=;
	b=VZUgzuUrgxX16SWn5u7CD8zZYgEX55lzy3upDFrRturDvHC4fUI9LY7CwEl0x5QI++qV/g
	aRs7cd6bMOsDxiBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737580489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/yYUyFwA5oAKs9Olh3PG37DRpATKp/bUjGmvoAotp4=;
	b=S4MPYi5aDFhCCzSI9ZEWzbQLfLtvRNNfi/4hEMORmI+wNNS6ZLbuaGyBr9xTa7TPG8MPbd
	axkPa0XgQgV5/G7UpZAJN+ZZEEwzx7L7oOK6lCjnYQQk2kN/HZMS5jhreaQVg26ZpQU2Ae
	RaPODeYIv7RNIzmyWTcFKgfhx9y+RhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737580489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/yYUyFwA5oAKs9Olh3PG37DRpATKp/bUjGmvoAotp4=;
	b=VZUgzuUrgxX16SWn5u7CD8zZYgEX55lzy3upDFrRturDvHC4fUI9LY7CwEl0x5QI++qV/g
	aRs7cd6bMOsDxiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83108136A1;
	Wed, 22 Jan 2025 21:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +O9qDcdfkWfBQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 21:14:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 3/4] nfsd: filecache: change garbage collection list management.
In-reply-to: <2adc801552b18e1f9b006513c8cdcd7881438585.camel@kernel.org>
References: <>, <2adc801552b18e1f9b006513c8cdcd7881438585.camel@kernel.org>
Date: Thu, 23 Jan 2025 08:14:44 +1100
Message-id: <173758048419.22054.7069906473728685831@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 23 Jan 2025, Jeff Layton wrote:
> On Wed, 2025-01-22 at 14:54 +1100, NeilBrown wrote:
> > @@ -487,88 +512,32 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
> >  		int i;
> >  
> >  		spin_lock(&l->lock);
> > -		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
> > -			list_move(l->freeme.next, &dispose);
> 
> While you're in here, could you document why we only take 8 at a time?
> Maybe even consider turning it into a named constant?

I've added a patch to do that.

> > @@ -577,9 +546,20 @@ nfsd_file_gc_worker(struct work_struct *work)
> >  {
> >  	struct nfsd_fcache_disposal *l = container_of(
> >  		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
> > -	nfsd_file_gc(l);
> > -	if (list_lru_count(&l->file_lru))
> > +
> > +	spin_lock(&l->lock);
> > +	list_splice_init(&l->older, &l->freeme);
> > +	list_splice_init(&l->recent, &l->older);
> > +	/* We don't know how many were moved to 'freeme' and don't want
> > +	 * to waste time counting - guess a half.
> > +	 */
> > +	l->num_gc /= 2;
> 
> Given that you have to manipulate the lists under a spinlock, it
> wouldn't be difficult or expensive to keep accurate counts. nfsd
> workloads can be "spiky", so it seems like this method may be wildly
> inaccurate at times.

The only way I can think of to get an accurate count is to iterate the
list under the spin lock, and the cost of iterating long lists under a
spinlock is what started this whole exercise.

I could keep an accurate count of recent+older+freeme but giving that to
the shrinker could cause it to shrink too much as the objects on
"freeme" cannot be freed any faster.

Maybe when freeme is not empty I could give zero to the shrinker...

Any ideas?

NeilBrown

