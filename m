Return-Path: <linux-nfs+bounces-21942-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFTKJvxiFWo9UwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21942-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:08:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086965D2FF2
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 456123028F59
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542A3D1ABE;
	Tue, 26 May 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbEXU9/u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797B3D090A;
	Tue, 26 May 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786431; cv=none; b=uWDQeWQEsQ72u6z2U8B85g+NvvMO+XrbUKWJTUd3/1tNaAgGGYFNQBtOR1M9WDF2FvQ+Z4LZUjIz1qe+lLxfLXfU3arrpyGj4qMdL8j6LX+UwkaULgCjDaSx5D4JQgzcJmBoZ0QqtT4XAN5y+11JPRkFFHmHRnnQ2JkAjtmvpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786431; c=relaxed/simple;
	bh=QfLNF+8MN7+UA5jASUGjhqz1VuWW5dkCYTwYJ47UEw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPFmal5myF+5CRoNB8I9fsPHdE/tPwHSXXv4qsPJOQDSgnpQ8ow0J67UDEJfDBN+5VKoWJ2lS/LrUxat4pTUa+KYe5T9OI7nXYtnEVMhZ8ZKU9IeYNXAa743aqKis+9WK4tf4Dvy0OYq1CojNTJn2C6UN/vduLiQ91jS76wT374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbEXU9/u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06EE1F000E9;
	Tue, 26 May 2026 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779786430;
	bh=X4dMIY6FGLg34QRadG1/HG9iWSvS0YAF4MlMdh2Kq3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbEXU9/uZCN+Vwwr63QjTBV/FcuhwVfwE1G+xkgW/pj9WZHp/LQdAuV3xkOBHeSVD
	 AkVVQtdnRcNWv1Bw2/evi6mIuYT8M6sdvUP021zd2BviqBaFduuPTu6GVcAaL1kq+a
	 yKhCJ/vtQe57mGf0+XB50jud7L1iGR+3Nxbqn2wdPXOcyof2MefuGY6uRaRF2CuJg7
	 WMCo9eaUxvKLIqX4WPVlUGktTPR2+4NMiJFCzGRIAyt+qpGqLdJcQVrkOFkTQH14+C
	 SjFKDsC537UZa+0+zKQpAXFjuIC2XAnLkx7R7IqX94mMj62X14Wy3VSmaRPz7oaMOc
	 6AA7mo4wiYdoA==
Date: Tue, 26 May 2026 12:06:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/17] fs/namespace: use __getname() to allocate mntpath
 buffer
Message-ID: <ahVisehwQGXEoM0g@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-14-275e36a83f0e@kernel.org>
 <lwnrjpmzbv6swapmnmb5jki3xxxzqsxuks5vykniwhakvhqh7i@rhff3qrwfnoj>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lwnrjpmzbv6swapmnmb5jki3xxxzqsxuks5vykniwhakvhqh7i@rhff3qrwfnoj>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21942-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 086965D2FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 06:22:13PM +0200, Jan Kara wrote:
> On Sat 23-05-26 20:54:26, Mike Rapoport (Microsoft) wrote:
> > mnt_warn_timestamp_expiry() allocates memory for a path with
> > __get_free_page() although there is a dedicated helper for allocation of
> > file paths: __getname().
> > 
> > Replace __get_free_page() for allocation of a path buffer with __getname().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  fs/namespace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index fe919abd2f01..2ed9cd846a81 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3303,7 +3303,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
> >  	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> >  		char *buf, *mntpath;
> >  
> > -		buf = (char *)__get_free_page(GFP_KERNEL);
> > +		buf = __getname();
> 
> Fair but d_path() below should then get PATH_MAX and not PAGE_SIZE.

Ack.
 
> >  		if (buf)
> >  			mntpath = d_path(mountpoint, buf, PAGE_SIZE);
> >  		else
> > @@ -3319,7 +3319,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
> >  
> >  		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
> >  		if (buf)
> > -			free_page((unsigned long)buf);
> > +			__putname(buf);
> 
> And __putname() is fine with NULL so no need for the if (buf) check here.

Will fix.
 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Sincerely yours,
Mike.

