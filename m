Return-Path: <linux-nfs+bounces-7517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BE9B20EB
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108541C20841
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018DD17DFFD;
	Sun, 27 Oct 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZX6b8T8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ikhKFR9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X3YiyULl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z8BeYdp1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51310538A
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065823; cv=none; b=Pk7Irr2B9KOtBbiVf6bz2MCgPhjH0AT1d6+Wc46TWU8jNVF0S9xJmN5gu1vDZHM+RQ/sY8sv+6AR9AHRDXkEh/kV93+jfXR5uJs3Wj91aWuy9TbTdqWIcvMlLorXqRMdnYIpwO7KfOd4RrXfTnMVeQAJHDw7qTJw/zBUZ5cAubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065823; c=relaxed/simple;
	bh=nMXhYU0nEw+vCOBnPHtc/80oo080aYFRWWB9nQebYTw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=u96JIi4VK6qkwKyTfwlnlMsh7poEpcrbY2rx2hD4/IzsBCcY054GczUW24N3JNtSLc/MoRBt9ENfRg69UoSn2/JRIkt+iAi0XoDLmxxRSnYlhVpb9hPxIv5mErATpT3YxVYxDRxu3eU0wBeOZOo87IWxES0+m554bKI16VBXZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZX6b8T8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ikhKFR9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X3YiyULl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z8BeYdp1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6319A1FD43;
	Sun, 27 Oct 2024 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730065819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1/o8CNIvnvGwm72/b4X1oRaSYMoMUR8vHuFIder8K8=;
	b=dZX6b8T8LocvtnDUg46AN9aR3wUcrtpnuKrXOvyo636/yNxvYgZPx6HOcJPgDZOAQBbU0P
	7b0LSsYtBgQaO317r51uKMbMlaOwPON9ujenXfV/VDIKR1N9OkE3zICcniXZDStz7gsp2d
	Z3NfVDd/xEjOzEcXt3Tr4AtNoE0cq4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730065819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1/o8CNIvnvGwm72/b4X1oRaSYMoMUR8vHuFIder8K8=;
	b=/ikhKFR9/ZTJ3bKvMRRhdlrsfX2/Ohf9u2ZRQUdm/KPs9D/EddlDlNyLKhYvFa1++Muj5F
	UchOQmKOOeIB2MDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X3YiyULl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z8BeYdp1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730065818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1/o8CNIvnvGwm72/b4X1oRaSYMoMUR8vHuFIder8K8=;
	b=X3YiyULl0HmTTG2lHThParZQu0QDNQszc4L0kcpKQm2703rLJJewIoZT6XfgcDtYyjyZt/
	i3rWq7YeOQAnQKGUjH1RgGCU/i4PchWlWSEsIL+1id7HR79bhQdHLRNyzzMQAyTebMT0E+
	CUC1TSjlHli8nk+hxw8tL1LEhrplp0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730065818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1/o8CNIvnvGwm72/b4X1oRaSYMoMUR8vHuFIder8K8=;
	b=Z8BeYdp1uQ8a3Sgx+dJaaBcCHh06volzg0yP267/zEUFek40Umndo6qyxFuIZcC5+uwWEv
	xdrlyFujwvbXkgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42AC0136C7;
	Sun, 27 Oct 2024 21:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yYtSOpe1HmfcAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 27 Oct 2024 21:50:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
In-reply-to: <85775192213d9c536a73e1721b317a98970d66aa.camel@kernel.org>
References: <>, <85775192213d9c536a73e1721b317a98970d66aa.camel@kernel.org>
Date: Mon, 28 Oct 2024 08:49:57 +1100
Message-id: <173006579790.81717.13227618123896085720@noble.neil.brown.name>
X-Rspamd-Queue-Id: 6319A1FD43
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 26 Oct 2024, Jeff Layton wrote:
> On Fri, 2024-10-25 at 13:31 +0000, Trond Myklebust wrote:
> > On Fri, 2024-10-25 at 12:52 +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Oct 24, 2024, at 11:00 PM, NeilBrown <neilb@suse.de> wrote:
> > > > 
> > > > I'm wondering about the request for a garbage-collected nfsd_file
> > > > though.  For NFSv3 that makes sense.  For NFSv4 we would expect the
> > > > file
> > > > to already be open as a non-garbage-collected nfsd_file and opening
> > > > it
> > > > again seems wasteful.  That doesn't need to be fixed for this patch
> > > > and
> > > > maybe doesn't need to be fixed at all, but it seemed worth
> > > > highlighting.
> > > 
> > > I don't think using a GC'd nfsd_file for LOCALIO is a bug.
> > > 
> > > NFSv4 guarantees an OPEN to pin the nfsd_file, and a CLOSE
> > > (or lease expiry) to release it. There's no desire for or
> > > need for garbage collection.
> > > 
> > > NFSv3 and LOCALIO use each nfsd_file for the life of one I/O
> > > operation, and that nfsd_file is cached in the expectation
> > > that another I/O operation on the same file will happen with
> > > frequent temporarl proximity. Garbage collection is needed
> > > for both cases.
> > > 
> > 
> > No. There is a huge difference between the two. In the case of NFSv3,
> > the server has no idea whether or not there is further need for the
> > file (stateless), whereas in the localio case, the client is able to
> > tell exactly when the application holds the file open or not
> > (stateful).
> > 
> > The only reason for jumping through all these hoops in the case of
> > localio is the 'user may want to unmount' exception.
> > 
> > Is there any reason why we couldn't add a notification for that, to
> > give knfsd the opportunity to clear out any open file state? The
> > current approach appears to be flat out optimising for the exception.
> > 
> > 
> 
> No, and after discussing it with others here at the bake-a-thon, I
> think that might be the best path forward here. At a high level:
> 
> Add a callback to the client that runs just before calling
> nfsd_file_cache_purge() in expkey_flush(). The client would be expected
> to return all of its nfsd_files "soon" and switch back to normal
> network I/O. After that point, it can try to get a new nfsd_file and
> start up localio at that point. With that change too you can switch to
> using non-GC'ed nfsd_files. The client can just hold them open and do
> I/O to them at will.

I don't think a "callback" is the best approach - certainly not in the
sense of a function pointer that nfs gives to nfsd.  Rather we want some
protocol, mediated by nfs-local, which allows nfsd to invalidate a thing
and nfs to know when it has been invalidated and to signal its release.

I suspect the "thing" is an nfsd_file.  I think a suitable protocol
involves SRCU.  There would be one SRCU state for all of nfsd.

nfs gets a reference to an nfsd_file and holds it as long as it likes.
Before accessing nf_file (or nf_inode) it gets srcu_read_lock() on nfsd
and checks that the nfsd_file is still valid - probably if it is still
hashed.  If not it drops the reference.  If it is valid it can safely
use nf_file for an IO, and then srcu_read_unlock() to release it.

nfsd_file_cache_purge() add a synchronize_srcu() call just before
calling nfsd_file_dispose_list()

We would need two different refcounts - on for localio to use which must
be augmented with srcu and which doesn't prevent nfsd_file_cond_queue()
from queuing for deletion, and the current one which does prevent queuing.

The new refcount would be a kref and when when it reaches zero the
nfsd_file is freed.  So nfsd_file_slab_free() wouldn't free the
nfsd_file but would kref_put() it.

NeilBrown

> 
> I think that's probably less brittle than trying to keep opaque inode
> pointers around, and would probably mean better performance since you
> won't be thrashing the filecache as much.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 


