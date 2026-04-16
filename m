Return-Path: <linux-nfs+bounces-20867-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJY2KGn94GlloAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20867-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:16:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BB410733
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E0C30BD61A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0253E2760;
	Thu, 16 Apr 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrMnB8CX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC527EC7C;
	Thu, 16 Apr 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352571; cv=none; b=SjAoG5UGtD35OaQMbHONHqrEjPVY/aMVb8+P5HcJH5QFXgLSzHchQ/8YsD8aA6qQe+YO+RVZanowgla1YXQDCUalCCvnhukX/Ce7rxSdFqNA8/UDwAJy9/X/V9r74YcYLn/HNGQZje0nmZPBrhfOMovfbPO2TZKWHNz0+JADd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352571; c=relaxed/simple;
	bh=R/VXngqidib4280DMAEsDTQLmoqwzttjaI/QiZ/CBEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7aadqQgUceYvpEouRzA54KQzplfRILMnKrXUuSRLTZ/A5yhchdmOoszqpW4abWmXut9fprM5gC+LTXGO2DP3pnMhavhe8XYmNVP2RPQR6QpDA2NVpT0A7BPFxHbsjwKeP6Jz0IoLsHCTeCOqlzmR0SUekb4CwD8eQ7QYWsKQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrMnB8CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D8C2BCAF;
	Thu, 16 Apr 2026 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352571;
	bh=R/VXngqidib4280DMAEsDTQLmoqwzttjaI/QiZ/CBEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrMnB8CXeTKkquRmmNdHRBG2I3Clbf9zRyvulAAnhDPl6tdWJcLBMAegbWD/eqBxK
	 ULmP+xl+QzJGXa61DRhhWvjZhCXfKrWnP5KN+LdFzF7gFbMiROu80sjr1iMd1fRlok
	 3rnUs2y1JD3TeWl2kyD3FiAkL3W1FWUP5whyOSb9CVPsVU3NBjQUfx9Fx6zkjfZxxz
	 G3vd9azRg8MFjzhgxtlu6Pfr6wCPBu0Y91RQezlZ8eGrQRdj0ZDVadKcNewHzDrIGL
	 pQQgLMnpXoOlR0OHk18epMQQMUueYwI72il5BIGPLvl/vZP8KDohZ6KTiXsKUYw9Bs
	 KLEpMfCkZVjyQ==
Date: Thu, 16 Apr 2026 17:15:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
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
	miklos@szeredi.hu, hansg@kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <20260416-aufbau-sorgenfrei-cfa87c9ddc11@brauner>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
 <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
 <1714293523.333222.1776351806025@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1714293523.333222.1776351806025@kpc.webmail.kpnmail.nl>
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
	TAGGED_FROM(0.00)[bounces-20867-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu,cyphar.com];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E0BB410733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 05:03:26PM +0200, Jori Koolstra wrote:
> 
> > Op 16-04-2026 16:21 CEST schreef Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > 
> >  
> > On Thu, Apr 16, 2026 at 7:52 PM Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > >
> > > On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
> > > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > @@ -34,6 +34,7 @@
> > > >
> > > >  #define O_PATH               040000000
> > > >  #define __O_TMPFILE  0100000000
> > > > +#define OPENAT2_REGULAR      0200000000
> > > >
> > >
> > > I don't quite understand why we are adding OPENAT2_REGULAR inside the
> > > O_* flag range. Wasn't this supposed to be only supported for openat2()?
> > > If so, I don't see the need to waste an O_* flag bit. But maybe I am
> > > missing something.
> > >
> > 
> > Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
> > got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
> > bit range. But as far as I understand, for the old open system calls
> > we can't easily add new O_* flags as the older codepaths don't strip
> > off unknown bits which openat2 does. It's not easy to add new O_*
> > flags for the old open system calls since that could break userspace
> > programs.
> 
> If I recall correctly, Aleksa has suggested we might also want to add
> O_EMPTYPATH to openat() instead of only allowing this for openat2().
> I am waiting to see what Christian thinks of this.

We can do that, yes. For O_EMPTYPATH that is workable.

I don't mind too much if we leave OPENAT2_REGUALR in the 32-bit flag
space. It'll silently be ignored but the flag name should give it away.

