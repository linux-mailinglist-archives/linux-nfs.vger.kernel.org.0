Return-Path: <linux-nfs+bounces-20277-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDScIKwPvGmFrwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20277-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:01:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A52CD53C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF773040238
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF93BED39;
	Thu, 19 Mar 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewme2c6M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649435839E
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932356; cv=pass; b=FgUBb5/c2x/lAEUA9paUUFg55IkVJCZwH6GPz3CCNA5GO+qd1n4IMXW2NSybvuAes6Um/Go4mMeQhNcqPj3I796MKLI2uVQsBj/B3487HXm7YZUm8hiN70Ed038/BWGMTkkqIQ4B84Fjh7A51utiCvpMm1bmiQojVVkam9Yf4KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932356; c=relaxed/simple;
	bh=6sDmh2K1ddd/qqvjeJ3o2QQSM/r3uurP4Rh1fp088y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnPTby3SH6TO/t+/p4OC2DZanhf4pXfLnknRSpgyPB+YAHSJv7p2cfCkTFs6dFb3+ik7b1ywvMxyogIbxnvFXG3Z4WTZSOmpW4xCKMtVcT7MnNAPALrf5kAeWWPIYN7bdwZ3HHJ6le5hrO5Q/261d9Mt3VSKrxMjVYaqpnbTA2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewme2c6M; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-950b77942deso264320241.1
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 07:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932353; cv=none;
        d=google.com; s=arc-20240605;
        b=gfnoEKzf6RwtyC9LeQLdxyjBzB0hhTtZjhE6ycPhIfYeooi2j64uFZRlKsXyQ0THJ6
         AhiS/XuI13mT32vXvHYfBS0DBAsKe/Ha5YZvXdhgjk1hiX+nQ3VOba7CPxTUDGC3F62f
         ygywpBRbnXr8dFfHV2ZWFS5lh6Ec4OV2wsFz0Pcks77l/6XR62TBRSbgBIjLoUnijexh
         aCrfeN8RPWRgCkriNnGpK1A909HsXFNwT7Ti5QdOvdicHEhCtNz1rdId+voOIdV6GvFA
         XglmQ5KpbJbFQAk31vVCFDa/202q7/Y92tp3JCQ/H9PDFP+JqwRbgXvYazTJX2E+31AZ
         gYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        fh=LTqkVecWJiqLUBg3Udm0Ss94JBy1kyXxeHf++OuAbJQ=;
        b=UeBqE1eviD+it6BNZ0fENNZ+0luiRsDEH/2fbVegc/hB32HgZ9XCMh9nAXQrLkK5Vx
         Ao4Hw9sBfV+JNpRssSfNJhd3GgwU0QcCm+lyObw4PL2l8/c4oXegAtDtxsgQlBWyxE/O
         YGjtaSJollnJyhOjJCdphmpnAjGcWy5tmetjD1rjz3CXAYI+6VFUYlShxS5kL2e7rnkK
         u+Tb5SbVGl5W2/PYtF3Pj773inkvixxilyaHbuK48AByJk0n6Btu0mEW+TO+kf7mhR9m
         ansWrFgDcs6Afoc2ghLhVTf513HsV1hzjdu1Hd6jRXsWNuQ+H4OZMY0ZfJl+Fcq+Zoxq
         WonA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932353; x=1774537153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        b=Ewme2c6MB6ZIkT842pVens1EfuelsTlCksC2FxcK5Sad6YScL2F8UZ/9qavAWWC5lb
         XRIuYS1h4ba9ELYYB4VhPdkFGoimWVVMxCmvPmvv84huy7yA64SPx+fSt6OuI1dALUxJ
         V1XQ/mmvEvkr35VcLfEH+f2PYmy7Ow0OnEUxA4qM9ZyxA9ha54ZahtuMKdUbOIxfLEwn
         clKCoa42uRcXi8Em9WoDnlCNhzQwLI/9K67zhKiP5QFAVskT6kdNwn35LgDWtAE/d0pi
         d81sS6jiimjXPdxiXDbYcrpQiu+x2aTQ0lUmaa04m7RRfjcu85J6Or+ir5EgJ64hUPod
         H75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932353; x=1774537153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        b=QvZ7c/Ek74/R+IUmeCACUvS1Wi2xknp22CYnkAQTYLSLodR89qGNMivG9pIZ3oKnE1
         /V5B6UNjxv9P5RF+cSeA48PgSEiA+kBVuRKzOtPOsXm+sGK2sbXVZGSK1SVc1AZ6BLIZ
         VCXbqzxp3u3/VBOFmXmfZQEoXoflugNQ4RK8Xmz5Lf8fHn3tvSPEhZLz9bLso9LPl2CW
         9i3+N91glM5xGe5id7GqRcFNOj4L1+wtqOrrRVSUuvXPeJACOUSj9jiMhN/v3pVCM9Lk
         WHTaxfkBoACC8qUJhGDU7lHoadNI24yl7dCy2QuyxEzosLiAKGA6u0wDN2J8u/tAPeZt
         qZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2bWnS6jEEpqOUPrZY7WjVyYPyZLDi2YM3sBVbQmBHeurZMMPmdF8kuw9+sHHpKn65vOsWFv48aHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUheNLkDZL72Zcyua8tAMBFMHX9etqKjwtsIpKhmDLv5DI6/a
	uAe2gyEroBWWOX3mKjpETALpJu8TgPygHptFDgQmfhHSBKog0x42NFKQo7exuwTc7KIGa0rb6ns
	88XpmGs2RCeMAI4RJRu+oKbPGnegEGNysDiDm
X-Gm-Gg: ATEYQzy3xG+E+IaSCi1R2lvL+ZExAwgO9/GxqiP7aJdqVjAEovrU0CBis/dTJPfB5V5
	5urM/ZpCCIi/z5c7E2KrG96pEvvxmeH3OS3fgyv1mzn+jEveHwb+T29fHzryPWgBri5Pyo99vH1
	irx9sb/oVvgJoseUFEdEAPST0kQmB7XrTy8p4tCf//N6QQ/kedm/4kC+VruiwaS3DLAUgPGqha2
	ebGgczkxb6r87UxILTzrOL5NqDXuEehhJtKn3aZClkCwNhPdPcgut5ea1ReEu/Cjzoo8V0NE8IM
	WwQyy00=
X-Received: by 2002:a05:6102:2089:b0:602:908d:3ba5 with SMTP id
 ada2fe7eead31-602908d75b3mr1604803137.36.1773932353056; Thu, 19 Mar 2026
 07:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319141846.78222-1-seanwascoding@gmail.com>
 <20260319141846.78222-4-seanwascoding@gmail.com> <abwLFk0L_kCZqIiK@ashevche-desk.local>
In-Reply-To: <abwLFk0L_kCZqIiK@ashevche-desk.local>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 19 Mar 2026 22:59:02 +0800
X-Gm-Features: AaiRm53HfEhbR7_2qsTpJtH-fp383GOiuoRUVlvrS4drdeqj357T51ILS8tg7q0
Message-ID: <CAAb=EJVCkn9_iO_YHMbLU1VR1OsKqTSg5Jo9jviaT3dEq0k5vQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused ones
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20277-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.625];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 021A52CD53C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 19, 2026 at 10:18:46PM +0800, Sean Chang wrote:
> > refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> > pattern for safer macro expansion and kernel style compliance.
> >
> > additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
> > confirms they have no callers in the current tree.
>
> ...
>
> >  #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?            \
> >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
>
> >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> >       ({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
>
> Why not all of them?
>

I initially only refactored nfs_errorf because it doesn't return a value.
For nfs_invalf, it will always return -EINVAL. Would you prefer me to
refactor it using the ({ ... }) statement expression pattern to keep the
return value, or is it better to leave it as is ?

#define nfs_invalf(fc, fmt, ...) ({            \
    if ((fc)->log.log)                \
        invalf(fc, fmt, ## __VA_ARGS__);    \
    else                        \
        dfprintk(fac, fmt "\n", ## __VA_ARGS__);\
    -EINVAL;                    \
})

