Return-Path: <linux-nfs+bounces-19439-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLl6GCsCo2kJ8wQAu9opvQ
	(envelope-from <linux-nfs+bounces-19439-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 15:56:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAB1C3BF0
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 678EB3072A55
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AB644BCB6;
	Sat, 28 Feb 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRFZjUr3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7944BC9F
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290600; cv=pass; b=YZbLoYPbaK2Mt8guyeCT6UntcbBmHbw4vfqJCD8x/aSnaUVuuJFP+KxMYr2UVl7KJPPWdccDmQ5t6ddnLmCofc6HHs693buR+igudvCxh3Ayj1g37akHtajqz9HIw/L8PMzCSVXsgBt0AYiHUxtbAcYs5MbjQpKVw4W8Xvk4E94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290600; c=relaxed/simple;
	bh=l+nc2CFJi1IXeWZ82OvdasY9ZeRciIOALxG7YyaSEV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnIJksNf5sXR5ThgeI2sqbzZOElJHqAWLq9w8beW2BMe90AOdiBOYjsDp0QWmQr+IegADqQmSET71gssnG44UOyNvym0kS7OhKikKGFCZ+d5Za7WWpHuerz85ympahCNoZig2jajozX6RoIdVZcVArurQ6hHg8OdjhiZUMZKiYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRFZjUr3; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ff0c095b69so1944158137.0
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 06:56:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290598; cv=none;
        d=google.com; s=arc-20240605;
        b=LsfUA5D2oEpKLcxq39tNBlmOXb173UiY/iXFGiNm7M/3SToE0ri8yoi1NxyDfde7cP
         69RLIQpJFLjYDuwA7WC5p0GELIgG5Nj7gr42XM3tGd4XUGKoUGppGHjir+ZEVDgh1ccr
         1PgWmWORST/ixFKfvI8ZiH0eV1lwCcoQhoW+V6i9V+btzBkQoyhccbZFTeSsv7Nuuiii
         yGZf+xPNJDS18dM8gFf3sqrF/k4hO+FQT3A13RGRg4Jo7BEfEP5jgPZ+dH7d0mh4p/hd
         kJWk91ul8Dmbu64/gP5A+VqFnOu4F+QBtfGiUL4PHv7NKSF4RwvZj8H+Ene+BqR98mN7
         B0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        fh=Yv3a1sJdorhdXf6uMMX4kJyNGUksNf3fY/sv793FvCc=;
        b=NOajsvUsqIL/jw4iZY6vDLpQAvlbX68u4HCxDvHtfR40zo2+o6C6hiB/L6ysknShKJ
         RgXxa3E7Ph+4QC/8H0w/h+/7A9Gam0kU4JqXo9mdonjxNjUOO/1pX+mzHgeNnwKMPKIj
         6fzqisiXlROwgHm0X24hi+KJV6eo23nRjM+7Lv/SWpSo5tV0hn+XIjTzylx12koaw6wf
         azrqOHXSEd/B7DSJ4ojGlVobpikontWqkV5NaQxo4hS3Qoq6JKm/a5XdYQ/GplPhqpw0
         DqFPUD5KGUimzxFVI7cF0w3oN1Z0ARCQOYP2763B92gzqmr/TW5S1b3ci7dYv48SiSts
         nseA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772290598; x=1772895398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        b=MRFZjUr3stHeSFDAbiTg0Xlo3O0DuoW4Bu+UxZ8lnhYtsJM2ziWUwXy3Giswwxz7xI
         6YBqfla6tTbQmNlrYLK9xWjq9Wh8gdhcH6OsGJVYPwOyTcldrylYDe83RaPDCNAWB4HX
         fsTui7m1ovYKB3+RCLZOTZwcG1BomY3Rv2rJVfTe2dbKwOt1ztaX4JW1tufW/SHTDeRd
         XKmr10DKK8f0C19v25eZA4HURRMadl7GE2xAklIity+yOCGb2eO/7kFl0JspfcOxo+JN
         9YSysGwlA6deblgiQDke/uxRQPR0ggQtapMtLZ/isNFB7sNBgsmq1W3LNQR2w/c0Sg2N
         vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290598; x=1772895398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pqk9COadEgvOBFb/23CErHBEu+433fHexiL/qnBiq1I=;
        b=AdGztZGBSpJKTiPx+NG+HJ0SBIXd7wPTCDg+45PHz5ZLuPXUEtAxhLdApJ87vp7hif
         1wJU/ycFFcJwNH3EtVNlmAyvSl/b0p6u4FMH0rt2GVnhfPwAfJ40lnC/SIwbhAu44sOi
         y6w7Up3gBK/lDpDTEDeRO708eaOsN9a18c2xItycXBAKbApJGte6WbiqeDqJCWIx2Dx2
         HQGVjMKRlkeg/p4oyjA2ly5sejrHQzEbJHjQGLRPVZD5V4+YozmOLsi17DabEtii/aZ8
         8visdhRqAga+WARXwu1zmq+h01i/XOOJu6mzz8sVkWEtQwFcRjCTtaezyZShNg9xPWVO
         JOuA==
X-Forwarded-Encrypted: i=1; AJvYcCWurwT3yChiC8HmYpr7EXFbEtFDgsmBdIjSsJae7keICERSV9Tt8mzYGS8BN1YQ3yW9mieEKLJXRTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGjHm/AFC35wacFTWUPuhKmet448CRdc/21QAOf3cNviySJld
	jZ+23ZsuzZgcR9JMZoTW+kf+Yc/3RiNnY9z2HVCCkytvCNANAnEpXJmxZ1mPI0Hlmp1kLjWsYnG
	2RFVDDgXOjl+my1bGnRy2+TOPsZQZoYk=
X-Gm-Gg: ATEYQzz0+HzeB7EFhEhqkv2uJU3+zaVrbxvirSeWWOjZyIuqxTPNTLW+BTjSZ5KWYTy
	uiDtYtkxrgZ7oC7/dVLotIuHluziZqbSwf2HrD3HtJKZil5bMDDbK0/wyjNgzAfsyeCVZGFMX5f
	aJLTX08ptIg1WqZaC5ehIMAXrM2PzZ9cIzdPeE6BhCQrBEXrOt/C/VrLey4gI5q+VlLCR6MAIGM
	h24CPowgfR3KDJbHO3HO3BXtC/f9d3h3B8Pq53ewDaiCozTX1sCoBmjhoQQBUl0ez7ZIn51oofD
	i3fkMg==
X-Received: by 2002:a05:6102:2ad5:b0:5ff:8b8:9f8c with SMTP id
 ada2fe7eead31-5ff324b0b90mr3953066137.26.1772290598463; Sat, 28 Feb 2026
 06:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com> <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch> <20260227181532.1616f720@pumpkin>
In-Reply-To: <20260227181532.1616f720@pumpkin>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sat, 28 Feb 2026 22:56:26 +0800
X-Gm-Features: AaiRm53ag-1hfVVtgj1u_FKTnMnX_cLLjpCwm7mRUL74ZPqZKwszjpRVlGXEPTY
Message-ID: <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19439-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07EAB1C3BF0
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 2:15=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Feb 2026 18:57:33 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > >  # define ifdebug(fac)            if (0)
> > > > -# define dfprintk(fac, fmt, ...) do {} while (0)
> > > > -# define dfprintk_rcu(fac, fmt, ...)     do {} while (0)
> > > > +# define dfprintk(fac, fmt, ...) no_printk(fmt, ##__VA_ARGS__)
> > > > +# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARG=
S__)
> > >
> > > You can omit fmt, then you don't need the ##
> > > #define dfprintk(fac, ...)  no_printk(__VA_ARGS__)
> >
> > /*
> >  * Dummy printk for disabled debugging statements to use whilst maintai=
ning
> >  * gcc's format checking.
> >  */
> > #define no_printk(fmt, ...)                           \
> > ({                                                    \
> >       if (0)                                          \
> >               _printk(fmt, ##__VA_ARGS__);            \
> >       0;                                              \
> > })
> >
> > Without fmt, gcc cannot do format checking. Or worse, it takes the
> > first member of __VA_ARGS__ as the format, and gives spurious errors?
>
> By the time the compiler looks at it the pre-processor has expanded
> __VA_ARGS__.
> So it doesn't matter that the format string is in the __VA_ARGS__
> list rather than preceding it.
>

Hi David,
Thanks for the explanation. I agree that since __VA_ARGS__ will
always contain the format string in this context, the ## and explicit
fmt are indeed redundant. Since no_printk itself already handles
the ##__VA_ARGS__ logic internally, there's no need to duplicate
it in the dfprintk definition.

I'll switch to the simpler in v5:
-# define dfprintk(fac, fmt, ...)            no_printk(fmt, ##__VA_ARGS__)
-# define dfprintk_rcu(fac, fmt, ...)     no_printk(fmt, ##__VA_ARGS__)
+#define dfprintk(fac, ...)                   no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)           no_printk(__VA_ARGS__)

Best regards,
Sean

