Return-Path: <linux-nfs+bounces-21197-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGnyHf1z72kcBgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21197-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:34:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16352474734
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17A1302A7DF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBFA3D4127;
	Mon, 27 Apr 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaVW7JqJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F94211A09;
	Mon, 27 Apr 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300156; cv=none; b=GHZbunpnT0wofU74BQJm0mYx79vJEwWaBiZ/+Lg0XJ07nASzWLkllpA4Wnja++ycWsI6YCagyGhvR+joakPHdh/iYq/zL+AQSfXXR6hMdSUby7BkFLciQLZwCXPxSL95NWaD/g5/B/o0LjPLbn3CtnYxk/XfgTHi22eovORUdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300156; c=relaxed/simple;
	bh=IeJ6/tR47YZBKRTpElig6fYdm36HLG0LBoH4pMTb9Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmzqZYFXfXoQz+6ZOb7nZOQZ0X6QZAzNDg+el6eqWg/uzvALD5QVyojpH6wlFWOKOjX7efNXe3j5hLjhln6DtBsWWbQ/UyhkjlZxUwpmzLs36qr9ibP49NG5TdFShWy5n2XC6Jk/TgMG6QzAzhp3844Db9jKQggTxYyVtTcbtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaVW7JqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8724C19425;
	Mon, 27 Apr 2026 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777300156;
	bh=IeJ6/tR47YZBKRTpElig6fYdm36HLG0LBoH4pMTb9Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaVW7JqJIhjsWuA02RrbXUpEKeg6fJmXF6/fbacFtpWNkW9wvYSePbUoq2NW3ABF6
	 fhDez9OSFGCU+Z3afcKIJptioaH4pyvHDG6jEZ/Xrr6msoWANBUyoZ3eToGL/j87fQ
	 PS/ePP+Y4IkrFLp4PrVmepomLIKsv/gyxmo2xcynsHgUqOnIYNBsNHvLHWfVI7EWH3
	 n4psZS6wQ+lShVCxjogKc6xX+dTYrQf7IOQ2sLO0fVQi8biaGDNEhsY4N4tl9lbxkV
	 +g3rV6DxqjNrShnGDPLGfHQ6iP53NrjUhUgP77FIadDMSuuyaRQ254A6sKvts12Qrx
	 FQNtBApDmEeRA==
Date: Mon, 27 Apr 2026 16:29:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <20260427-begreifbar-sandbank-84e3990e7c37@brauner>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
 <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
X-Rspamd-Queue-Id: 16352474734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21197-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 08:17:43PM +0600, Dorjoy Chowdhury wrote:
> On Mon, Apr 27, 2026 at 7:28 PM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Dorjoy Chowdhury:
> >
> > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> > > index 92e7ae493ee3..bd78e69e0a43 100644
> > > --- a/include/uapi/asm-generic/errno.h
> > > +++ b/include/uapi/asm-generic/errno.h
> > > @@ -122,4 +122,6 @@
> > >
> > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > >
> > > +#define EFTYPE               134     /* Wrong file type for the intended operation */
> > > +
> > >  #endif
> >
> > This is what POSIX says about EFTYPE, in the Rationale for System
> > Interfaces:
> >
> > “
> > [EFTYPE]
> >     This error code was proposed in earlier proposals as "Inappropriate
> >     operation for file type", meaning that the operation requested is
> >     not appropriate for the file specified in the function call. This
> >     code was proposed, although the same idea was covered by [ENOTTY],
> >     because the connotations of the name would be misleading. It was
> >     pointed out that the fcntl() function uses the error code [EINVAL]
> >     for this notion, and hence all instances of [EFTYPE] were changed to
> >     this code.
> > ”
> >
> > So I'm not sure if reusing this name is a good idea.
> >
> 
> Thanks for pointing this out. I had started out the patch series with
> ENOTREGULAR and it was discussed that EFTYPE was a better and more
> generic error code which is also used in BSD systems like FreeBSD[1]
> and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
> change to something else if everyone agrees.
> 
> cc Christian Brauner who originally suggested EFTYPE for input on this.
> 
> [1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
> [2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Given that both the bsds and macos already use that is there a good
reason to return ENOTTY for this other than a standard we ignore most of
the time anyway? I'm honestly asking.

