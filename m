Return-Path: <linux-nfs+bounces-21931-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMHQBSeFFGo2OAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21931-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 19:21:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A359E5CD50C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 19:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 108953004DD2
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF971F4611;
	Mon, 25 May 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFLYqe1t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53452D661C
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729699; cv=none; b=Rg++qJwCpcR45cYRrdRUwJzxMWtWmvyhdaDnh0nBKtzydQuj+o8IGau5etvdoUNCPlu+HDTAHM9xp0Fw7AL5tc8+DJ8IaJf6edzLYS84Qzpt58x+znM+XedPLV9tGC8B1QcGF+Hv7sw1erqaIcvXFWgvSSZzw9XVxzbMsLt1FDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729699; c=relaxed/simple;
	bh=VCEFYOA8bvBB0He6GPuue1J5cPggJ9r83oKY1RULIeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh3+loVD6uKCQcH1SJbmdbrnUhGEM1oU4u6rxHK+NDh4LzX5HRoU5SBh44rJGzLnFt1A8B1ggp7aeuatgmMyuXyK+RjJiMLu6tTtX7WPQVX2YeSauKZ9ZW22Xt4q+JYllxBIUez5LOw6CKBVX1aiGyrF6lRcUUSFcjJyUTjlq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFLYqe1t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so45498505e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729696; x=1780334496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNWXusXZo+ITDqzjd8lv9UPW26DbKQzVTY3kSMXJqIc=;
        b=nFLYqe1tk7qwCxZBvuRvWqGDl/PP1t56e6sHt9JBmmmYmlbOXU8xnMDPX+8rPndMNa
         2zgBc7yUrnJOp9pyEBh4d/26MNx5cn3UNMTWA5ijw8O2EKGD44exJ9D+89Ul/Qc1Pt+R
         /EOZDji4aBNJqur9ul7T5t00BS5di3PrdKi2XezOB//+KK/86ne/3D2AmRBY6ANpdjCb
         ThvzY2xpYZ+2BNNBxmDNt1N/CaZP22TNh0pp4Q7X428uuzBIbbBges+roGw8JwlrYKUn
         xPu/34xris6plMkYf5LQoMtInpdT2hWsLdOTyXxGzT9tEeMg/Y98J2QfxTtUdj6zOITs
         b2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729696; x=1780334496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNWXusXZo+ITDqzjd8lv9UPW26DbKQzVTY3kSMXJqIc=;
        b=c63b222EEPvAcswuZCEUZgZ2QhlLJqM1zVewZQfC6I4rDf/Bryjt7zaTGVGRwyg4wK
         +CwZvAWls59FKGcYO2AjUSPWbqGlEJ871L3JkWgfgDUdXtNqVRp6OlPze7xwqC5u8wr7
         m897tvs6o/Ri8TM2oaWf7RccQbe/8hB931XSVu0pe0Pb/d+/OEExeCDAPxjE4wkrCMFd
         G98gDsxojWwpm97oxCKYgTmffByl3FAuAcD2H80nSqNDEbajrvH61jLbL0CV1gu0yVor
         z0dFzC1mTwZPPBHsyNoP9ZKK12f1d54yPF+wX086C66G152I+IG/kBTNTOf9YeHZSQU8
         mSpg==
X-Forwarded-Encrypted: i=1; AFNElJ/ABZHF13Y62YLIa4+z6x/SyuEFlBojXDOOJiCn6gb0gK0b3SC1Tz2Ib0aIK1/7b9eflEY3uvUexNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZKw4hndEqkL0nDVmL94vdHCKSiLPphB8Wir2oPXTPdr/xlMO
	fjuIIPr1A7qg33Dk91zMrTIorSJm8O/12SteT4MV9mBkVaiGHH048Ck8
X-Gm-Gg: Acq92OGcaIPdXnxf0yOWsEkS001M/ougc+l0oqipPsqHcEDIvlhoFDyCOWMqNUJC1Qq
	RmnUbCSbMkD50s0Y8XbWROidAyIzHLVnI9OFqGl/WZiWC9ay5D+O16srCxtEDJSaFulk8dgnyis
	0i4AHs5Cgi4Dn2cbPLhf8ikNX58GD0g9WbRr1sJWksYWFyrSstXKVX5T9RVZXUPszrAZedzLG8N
	j7oJdB+iwKsCTnD1ddSI34l0zVHQPHPVK009pigv0EY1ZVyYCKQp+HCLQZg7GsHVJhBIZe5sVpy
	Wu/hHAg0XTf5ttWzWivBCvM06OHq1ndT06IVDmvcWSaEyjSoGIVHf3Abr8NMcoe+QPQZKtzwWLY
	+nENxMIh9rF8mf+CLqU39D0Sg0tjIxQOveCNZYyZ+XiJAi7IqXVaFHGUbT/DC5YOhkljRQ0WEPJ
	CUxEw7DzAzft/4tQ2tRubS/2XhFFjiHXeTm1y/rrz+xgq2pHSLYxpeWfsy2EI2l4gb
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id 5b1f17b1804b1-4905872e758mr158057335e9.18.1779729696288;
        Mon, 25 May 2026 10:21:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d63f8sm88577605e9.18.2026.05.25.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:21:35 -0700 (PDT)
Date: Mon, 25 May 2026 18:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jan Kara <jack@suse.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Dave
 Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi
 <miklos@szeredi.hu>, Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Kees Cook <kees@kernel.org>, "Tigran A. Aivazian"
 <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <20260525182134.04045610@pumpkin>
In-Reply-To: <2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	<20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
	<2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21931-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.cz:email]
X-Rspamd-Queue-Id: A359E5CD50C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 18:17:04 +0200
Jan Kara <jack@suse.cz> wrote:

> On Sat 23-05-26 20:54:22, Mike Rapoport (Microsoft) wrote:
> > jbd2_alloc() falls back from kmem_cache_alloc() to __get_free_pages() for
> > allocations larger than PAGE_SIZE.
> > But kmalloc() can handle such cases with essentially the same fallback.
> > 
> > Replace use of __get_free_pages() with kmalloc() and simplify
> > jbd2_free() as both kmem_cache_alloc() and kmalloc() allocations can be
> > freed with kfree().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>  
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I'll just note that we allocate here fs block size large buffer so the same
> kind of allocator as we use for folios would be even better. But that's a
> different cleanup I guess.

Would kvalloc() be more appropriate here?
Does __get_free_pages() return physically contiguous memory?

-- David

> 
> 								Honza
> 
> > ---
> >  fs/jbd2/journal.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 4f397fcdb13c..1137b471e490 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2784,7 +2784,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
> >  	if (size < PAGE_SIZE)
> >  		ptr = kmem_cache_alloc(get_slab(size), flags);
> >  	else
> > -		ptr = (void *)__get_free_pages(flags, get_order(size));
> > +		ptr = kmalloc(size, flags);
> >  
> >  	/* Check alignment; SLUB has gotten this wrong in the past,
> >  	 * and this can lead to user data corruption! */
> > @@ -2795,10 +2795,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
> >  
> >  void jbd2_free(void *ptr, size_t size)
> >  {
> > -	if (size < PAGE_SIZE)
> > -		kmem_cache_free(get_slab(size), ptr);
> > -	else
> > -		free_pages((unsigned long)ptr, get_order(size));
> > +	kfree(ptr);
> >  };
> >  
> >  /*
> > 
> > -- 
> > 2.53.0
> >   


