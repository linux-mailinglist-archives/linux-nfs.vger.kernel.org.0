Return-Path: <linux-nfs+bounces-21752-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKcRKlbkDmrACwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21752-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 12:54:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B525A3A36
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33FF13009F52
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48323AEB29;
	Thu, 21 May 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8rOS1cG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877053859FA;
	Thu, 21 May 2026 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360849; cv=none; b=AiwPHxNfR/8E5vElKjlBZ+GtAytjkb01jMwdufSnxogVZBeepLEtATAMLG/jfuCVp7aPVUjZQikAk/t6jgrFqz4c85kMnJ37P7yPwbPqmT4L+2Uc8uT8cVMfX0cviwFkvmrlAAlw4qnwWvH5/r7g3jM3Ql4EZ8UOUKVgk9Tl1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360849; c=relaxed/simple;
	bh=tMnuYwHgo7w7gPx8laBi+vh4biK3BacbRE3N0c3HULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axyV6XOy9rnkopkiUzgQlJzH80gVIDis2YjiL0TxlZ1Qp4eHJW1LIkHtHJryI8ClKe3bnE3Cz3unmbpFCQHkLT/Pdga2LsI2dusfEBreHSGtAr5Ei3dDbuFilLNoud3ks+MyKqltDJJcq+n141622JrR513e4K86hYo44V33nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8rOS1cG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284D11F000E9;
	Thu, 21 May 2026 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779360848;
	bh=hReAb/JnSiPheNetMpN9KuPDi9ArATr3SUITGa4P4hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A8rOS1cGqyEFWheeZg7Gevs8sfK5NeBIFPOWaiaMtEpuax0stwjgnfBRYXfe42fw+
	 PkNdqWpTczhnsT+5zzafbfYYvZnE4lsb8LCl3MbH4SiEBUzeWbsTW/TwyEUH0EIWI7
	 rXjTEEae4IQY/alXlNlwPRciBuM89DudZ/0g8hE6byUVFb4DnQ8vNmVB3OHZAvQaOL
	 XbhBeyiBJWf6wy9ijtvnhwfR525PNDcFDIE5KN6Tbtkp0Pynq0S6/Wx6IaNQC4z55O
	 nUvMijOU4uSW0CyHmDv2UcBnjr0lOBq1iiL/FkAZ6Ns5OmsYyneoVPjm5n+3fraI/R
	 kde4w0nv6lkqw==
Date: Thu, 21 May 2026 12:53:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Message-ID: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21752-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uapi-group.org:url]
X-Rspamd-Queue-Id: 48B525A3A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature suggestion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
> > and thought it would be something I could do as a first patch and get to
> > know the kernel code a bit better.
> > 
> > The following filesystems have been tested by building and booting the kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
> > regular files can be successfully opened and non-regular files (directory, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> > 
> > [...]
> 
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
> 
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
> 
> - I split the EFTYPE errno introduction into a separate patch.

So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
the upper 64-bit and internally use a __O_REGULAR bit. After having
thought about it makes a lot more sense to move the openat2() only
features into the upper 32-bit for the uapi space. I also ported the
selftests to the TEST* framework to fit with Aleksa's recent rework.

