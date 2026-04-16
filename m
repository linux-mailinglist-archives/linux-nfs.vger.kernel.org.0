Return-Path: <linux-nfs+bounces-20866-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFAHKF364GlloAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20866-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:03:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBE4101F7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC521306E803
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716633E0C73;
	Thu, 16 Apr 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="AR89u9J7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30A30B50F
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351817; cv=none; b=cwj/YBfjrM9xLVdcnEjd0a56mbe/lIU1NuigeTP+seJBXUwxaMYA/tW0nMAoDzJrI/4wTWjwh7MEO2/josZ/EOjdThYiKge6iaP9wz1XdmJ4eXb6ozGIPDwMXqxx7TOlRPFpWHf9MwdxMa3OF020Fuc8rPe1hyAbB13xfnsn+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351817; c=relaxed/simple;
	bh=+mNJcrO6vmQsCpcnjmzq4O6ycexv38y/zgLqmb6G7RE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qjqMwB6Pwtrxpm4Ma8wFCadAaAEBrGr51ZcN1KQ2BmwqkbOUVDwHqrXv4cBHBeCnWOx3OMEK8+qiPfZU8p8UIn0IxxdIeGjxHVvGXiRhQE8lsAUNmgM/6kzqS3Z5LBRTicHuOqHYplGiY9tJOUpbnh0q6Zfp/DQ3c8XhPOB6l7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=AR89u9J7; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 6b7bd890-39a5-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6b7bd890-39a5-11f1-bea8-005056992ed3;
	Thu, 16 Apr 2026 17:03:26 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 6b82696d-39a5-11f1-80f0-00505699693e;
	Thu, 16 Apr 2026 17:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=j+uVJmBOGkgDS0z3tsIW2Ds+Jzpa4897P/UEqyiLhFs=;
	b=AR89u9J7Q6mqG/hdbsQT2sdW9o1iuPP93DpDyFbGxCpI8vKlFahRNTFIbjscMVjFR8PKSfsN7ftXN
	 bV10BEqMu8dk5oSpGlfMj/M5NRspo5adBrbynfN18ijy8cBDdMLID783d5SK5mrRCErXO2WIXpN0u5
	 qn01fYYFgcS5hkACWjXBMLgU8GhQk8LrutwYI5afGyE6PzKK4xida/auLEO0WUum7NOaUhOs/b7Wj0
	 0k8l/qjYbkisJhXxwKUG00MIJQ8Bf1J4A9i75cPelvUsoOmBCEIDO2Z5GNwm/SQ64amwN0MymFfhRk
	 8NeLDn9xlKhTen185TDM9M2QqNxUIXA==
X-KPN-MID: 33|wJ0GzT1sPbVlbBcoabM91bC41dVb/Ga4nsWJ/EpxFrhuIQycwUMK4bxZuP5XZ3x
 VOH9Gqe9wYt2+6vh4IzPTWcvdtVyILU3eLs2zqmoVg7U=
X-CMASSUN: 33|ARgsuoLPyhASVApF6ob+ciCM+w5WX+1LWil0n1t+A21zqXv47hSkcgkJ4f9g4f4
 rzBYBTDsNbq5Yl5TdU4Qq0w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 6b72fd5c-39a5-11f1-b8d7-005056995d6c;
	Thu, 16 Apr 2026 17:03:26 +0200 (CEST)
Date: Thu, 16 Apr 2026 17:03:26 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com,
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com,
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, tsbogend@alpha.franken.de,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com,
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org,
	miklos@szeredi.hu, hansg@kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>
Message-ID: <1714293523.333222.1776351806025@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
 <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20866-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu,cyphar.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kpc.webmail.kpnmail.nl:mid,xs4all.nl:dkim,xs4all.nl:email]
X-Rspamd-Queue-Id: 81BBE4101F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 16-04-2026 16:21 CEST schreef Dorjoy Chowdhury <dorjoychy111@gmail.com=
>:
>=20
> =20
> On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> >
> > On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include=
/uapi/asm/fcntl.h
> > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > @@ -34,6 +34,7 @@
> > >
> > >  #define O_PATH               040000000
> > >  #define __O_TMPFILE  0100000000
> > > +#define OPENAT2_REGULAR      0200000000
> > >
> >
> > I don't quite understand why we are adding OPENAT2_REGULAR inside the
> > O_* flag range. Wasn't this supposed to be only supported for openat2()=
?
> > If so, I don't see the need to waste an O_* flag bit. But maybe I am
> > missing something.
> >
>=20
> Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
> got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
> bit range. But as far as I understand, for the old open system calls
> we can't easily add new O_* flags as the older codepaths don't strip
> off unknown bits which openat2 does. It's not easy to add new O_*
> flags for the old open system calls since that could break userspace
> programs.

If I recall correctly, Aleksa has suggested we might also want to add
O_EMPTYPATH to openat() instead of only allowing this for openat2().
I am waiting to see what Christian thinks of this.

I guess in that case it is relatively harmless to change UAPI
behavior because openat() with an empty path never works; so it
would be silly if there are userspace programs that make
this call, which always fails and does nothing, and somehow rely on
that.

> So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
> range anyway? (Also lots of code paths take 32bit flags param right
> now and those would need changing to take uint64_t instead but this is
> of course not a reason to not add the new flag outside of the 32
> bits).
>=20
> Regards,
> Dorjoy

Thanks,
Jori.

