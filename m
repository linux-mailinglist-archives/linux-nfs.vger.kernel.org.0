Return-Path: <linux-nfs+bounces-20969-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBYlIp005mmOtQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20969-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 16:13:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5AB42CC5E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1917309F3CD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFBC3A75BD;
	Mon, 20 Apr 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhpJLaE/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516313A3810;
	Mon, 20 Apr 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691227; cv=none; b=NyG28+6LOXzj1uRNIYKpImFIWfmXVyrsAbcqLsugoY/Bso4GHy1B9ZvUm1HWhRPWthsQPs4seatHvYW+ux4DlKogFviIGEyoGmR8sX448TBVf4//QN7BGeQ+pPMlygYFIsoiomcxXKYYoN0dNBQOFuqeTtLXxFSh7d85pZO9jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691227; c=relaxed/simple;
	bh=kRWmMUrKQhCcXsNj5gvf2DeCpyxg39zc5I1mOBXFzBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXDy0vtPSoCtdVkI++1zn26J3u9Ot7Piw3dMmFUftAaLWFlsm/a1Nkj7QXI5jti/Vd8xV3Jw4gA3/HOLvV2N3Y6iV9InNBmGOeRNBslJzBbI0smzhmsHC9t6LMnbiLfIeVF7Cf7ZQJt41hPg1bpPs0jc+G83YRAmtwu5/zoG340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhpJLaE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B117C2BCB4;
	Mon, 20 Apr 2026 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691227;
	bh=kRWmMUrKQhCcXsNj5gvf2DeCpyxg39zc5I1mOBXFzBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhpJLaE/kYJkAk598rwPEJ5O6S/vqTqpLxnnHSXxnk9Cri0j4gy7bMyYG8F49O2va
	 Bxeixi62jf25y9uRkCSdmpa5jTioC3fHCxLWCsLN/Kg02M6dwhf2+Xaa37H9OQ5AQF
	 FCOQ+xLc8bBprPWT5Q4yrBIK049tr5JtOJFv7g3IeVYYHrT26LMeOCG760Uh6qt0vD
	 jMPBv1LODhtZwfMICOgq5W2jtc5kdps7YgYVfTMghk/iM5u5/5jr7SNliMR1qc1Ruh
	 O/s7NJvHFQxaCz8IgjwEfGrGKjbY5d3kJtS3KQF+2YL2aIiMLBnWiZBaJEBZ8Zzfs3
	 bK5BJuuS2b4QQ==
Date: Mon, 20 Apr 2026 15:20:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, 
	mjguzik@gmail.com, smfrench@gmail.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Message-ID: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner>
 <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20969-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB5AB42CC5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> On Thu, Apr 16, 2026 at 7:07 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature suggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
> > > and thought it would be something I could do as a first patch and get to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting the kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
> > > regular files can be successfully opened and non-regular files (directory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is that
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
> >
> > ---
> 
> Thanks for fixing up and picking this one up!
> 
> >
> > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.openat.regular branch should appear in linux-next soon.
> >
> 
> I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> git.kernel.org.  Maybe this hasn't been pushed yet?

Nothing will get pushed prior to -rc1 which is due this Sunday.

