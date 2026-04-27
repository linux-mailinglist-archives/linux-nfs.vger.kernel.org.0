Return-Path: <linux-nfs+bounces-21196-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOADF5hw72mHBQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21196-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:20:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7656474393
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B213058E0B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65183D3CED;
	Mon, 27 Apr 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV7XlqUV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74823D34A1
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299477; cv=pass; b=SosE3Ek+SEmo8io4UPmCse5if2n1CsnG9c7RCF36Oc/3xc47LzdW4qTdUBSFYq1/dL2FvFzXGVM6i+deNfFDECJb4OAxAUWUQWTMO8XPnTklVtLhcoHscrSlWETKmwjn/hV4l7eiquq3Lns/fBAFNVYr2cUIyvbFmf/pExJHUjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299477; c=relaxed/simple;
	bh=dCas8RQKsBsKm7RPEue3wRPtJ4lneFcySX6TUqGbvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZo1as4Kb+WtIp1eWNbvsC9HwMGG6lheEIk6FGLm7hREBvv1i06DCULRfJguUyjYoxzUS3bD9Zdto+CgpsiwleORXzQ0qaDhtETCiwhCDzKdLFVcCDz/MbAuMmUr8U7HLcQkJmk1ATm6nkJ6eCfiGuKTCvYu+uBQz4+uwJcWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV7XlqUV; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso6276471241.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299475; cv=none;
        d=google.com; s=arc-20240605;
        b=BWFNiJ+EH2VOA4ya+Ue90cSxJmPbL2HOg1dH4pJ7u7E7yeVwDaM8DUZOV1zNalHUUw
         +keGmIWLlxdW3lvZSLN/MIDqcB3afEfQsyPVNUr2+1NfNCZiUeOV6bJmhbUEQYtcgjeM
         iP1xEk21S0ltdfPOS0JEzSD2wx9WtCTQsyK21/xKmeYbLR6UjciixraTmJ6oe6/IXYee
         BqL8B2ESFsiL7ACvELI0a711PLRQTY+CG6V7ExXBvrcht19/udukfapwPellexxROe/g
         s6syDaJ40805S2vD0L2kK1HKo+8GwEw+ZBCSYkPxgmb78jN1fzEIAdm6DxaYQ077m6Pu
         0lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        fh=3M3WiR6JvPlMdaOmdadwwJD9PhoyqdQGnmOP1ncuSPU=;
        b=V5esCwB8LJpdPL28ABbxlcwoD+dVD77kXIKzI4KyRd8BNUcb4tltaWgJ1be4LHLKog
         Nij4u1SNZd+iy108O9X95dhYmFBM9AWTUuOT98dtxTqagsF+oGiFhm3WWGwx2SURCzGC
         9wavnyN9G1937ljPEp70azLS6ZZJ34BqxNvgrKECXFekfiSGLY7n1MZwNwW67nV2/40d
         g7QWNkD9r60KMvbf7wPL/ijgc+clEf57EKKLJw+63kSR1wt25xwxNbpR59/df22taSC4
         xMCsUZBarM7uEI6RjzT60/Ejhk01376IBGJm7GYujr9tro1sXFn8PpJxfZQcZVyO3IrB
         4ddQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299475; x=1777904275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=UV7XlqUVvinNvlG4ozIHjmCDkWLWkXqWdHVlwKleD4e0udKlFPCyhDThue+4KCSFuf
         4PPkqV7PBmqSm85u3fIzULTAc9+wtQaK8rViECu4uoP52DqNbn15+/ac4reFdyXrn/B1
         s3/x0N6JxPqqHQ+SvjX5nH64ret3FMse3JDW0UFDRIL8eY4pp1TNXlldauyddtT20e1L
         qF3CPo8D4Y7Ek3KN8fARmEEs5LMSb+8CfKYUV0BkpMnaU5nmr2gie+0EpOmT51BfojAE
         Cr7faIb0pQuMBU6P/HjjO15sUUH7oPx7M3XGM8FLv2JB+tutyWbnxLL5ubYguDpuqSMe
         bJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299475; x=1777904275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=NQlTeqEapH4X1AyIunn6ik5d9nOKCVedqwCm2xBLa/hUfyz7prOC3PpZW2CCF38vPJ
         OCWozgKeNA+ShcTCEj30JIBXGLHi1x803SrfvufPKBb/KUn2U517G5myC6ntBSnMrdAQ
         D79LipearZ2m7K/4umTEe4y5/6hw1KGhPwB0UMmn052GxOlfp/Igoyrij6P+ibUk3DON
         gvT96d6jnXs5VNTepGv+AJzq1V1bNMgyCUmmUj35SrKmJ6AfUGMsrDbvcfKLhTF6l53v
         JW0Y4uIPDV1XrUSIBBhFNlhlMK+8tsdMXIfaNrLVgxHfHqpDJyiCvnTt6u9uu/xxGQiz
         ETXA==
X-Forwarded-Encrypted: i=1; AFNElJ8KNxmui6WNS6rWDiASg1O3H8iQ0XUAgQRAEA8lI96h8RcUmwgA19qpknNPcrYapBFeVIRzMlBVlmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiguVnGxWsp6YuSjYCdZEKqXW4eBh35M7g0GsS9/3AcskTL6b
	KzlTy0+EXbAGALkmjGYGF38JJlRITTzLeMOoPgEMRZXSLwkdDeijZieD7z5FcNQrtxug1eFA2jj
	r4MpAAlj8mYacRuk1RR5+cbmNa6te900=
X-Gm-Gg: AeBDiev5/pGKz20HKc/THhI2ysFgIiYTnqq7rM+AHezqKlvytOosjvCiY+ZUOsrZKa3
	vRxUGQa32gtfAV25Sp0S2tiN9nsdYkzJ22yBXbjod67tEYhvlEO+RAFrSBFx5od+SNcdbifUSlN
	/oyNbvnQC5LD8l7c/Q2TrVsPSTH/g9Qhr+VDYpfZQxKiWhFObik26Cv8C+HE+PooaprTZ2GY7Ue
	a6usjnPBmP3xGzcrhV3zSKP7hnh6c7pfY6PDN9HGZDMQUu9ENX1/l8XLMJ1pLEiE061o280sUlP
	cBjHc8Lo076AUyBf5/70QsIlY4ykvqRuC2Ovi2lgUC/8FdyTmQxG
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr21307327e0c.5.1777299474612; Mon, 27 Apr 2026
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 20:17:43 +0600
X-Gm-Features: AVHnY4JD2JZaiwDyyuW_kBt_sHjEkoUZKURjGdK7nlj6KmXsjRIqpl4zFGzklnA
Message-ID: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Florian Weimer <fweimer@redhat.com>, brauner@kernel.org, 
	Alejandro Colomar <alx@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E7656474393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21196-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 7:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Dorjoy Chowdhury:
>
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..bd78e69e0a43 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define EFTYPE               134     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
>
> This is what POSIX says about EFTYPE, in the Rationale for System
> Interfaces:
>
> =E2=80=9C
> [EFTYPE]
>     This error code was proposed in earlier proposals as "Inappropriate
>     operation for file type", meaning that the operation requested is
>     not appropriate for the file specified in the function call. This
>     code was proposed, although the same idea was covered by [ENOTTY],
>     because the connotations of the name would be misleading. It was
>     pointed out that the fcntl() function uses the error code [EINVAL]
>     for this notion, and hence all instances of [EFTYPE] were changed to
>     this code.
> =E2=80=9D
>
> So I'm not sure if reusing this name is a good idea.
>

Thanks for pointing this out. I had started out the patch series with
ENOTREGULAR and it was discussed that EFTYPE was a better and more
generic error code which is also used in BSD systems like FreeBSD[1]
and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
change to something else if everyone agrees.

cc Christian Brauner who originally suggested EFTYPE for input on this.

[1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
[2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Regards,
Dorjoy

