Return-Path: <linux-nfs+bounces-20260-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOK8ItLfumk3cwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20260-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 18:24:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB362C0333
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D2731DFE9B
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7139C00C;
	Wed, 18 Mar 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5HEUmxl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A13EF0B6
	for <linux-nfs@vger.kernel.org>; Wed, 18 Mar 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850916; cv=pass; b=WyajXOyCJA1gZrb/w/PubkTQNTaMvDBO50lemjSBWp2qmjIDryRaknANHY+mIqtvwFK2GPANfT4w+36FBQpHnDC4x5Waxcn7WANdVwcmsxv7PixTDTTv+OO0KcotQ2OaPoHp2p7ffTMMHJfnfMlzLa6KA344YpGZcRmY6cnZuPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850916; c=relaxed/simple;
	bh=1mY0vMdx3K8sY9OrMLKo8bHAtDNNQrwI+eIMWXDn2W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWC7vw7t6AkLVWzGGreWKLRabH+YHUFbOZl1/pXqrzdl7Sh8gJZR5JxpgKD7AqP32lREuLHZTzei1QBwslO7+51G6UBBmm03LCtvtvotn1gUnNgJcJ78Alk6puGIO3qn21oo6Nl20a4RxZoHHwIiNa5cZPKkOpQ0LYpSN9QDFtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5HEUmxl; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b65ef9441so4524385e0c.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Mar 2026 09:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773850912; cv=none;
        d=google.com; s=arc-20240605;
        b=Kk1LY4YW3PsZplBCfjMa+zEVnvaT7P/pSLGIc9rVdOjPlDK8pGQed9gQ5vhERbgoil
         WDVG6OYG7JLBv1Z0xYXJxhW/VoDpCy6kdBxA1yU8S6vGu8wLi4ui22/XsJVpjzLMLRNh
         m2y/wMHM+6xhepn9AuU31ua7BjnSQCJNwK5VTylo+pK3tbh5G+JHhDqZmBdExujN0m6J
         YWldbhwmSmHWvnK2mP7xi/GFJHzTLyXlfjl231N80xne+lpRuO+NlC/9jnTG1zAYDDoz
         BvXQjWAM72t79I/9OLx4NT6uK4FKAJEKV87K58bVYojTRxVy2qVtoOdb+hk3yUVae8Xj
         uq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        fh=iA0wy3x75UotAkDDwtHltk53Il/vZ5i1tiG+cYSNWe0=;
        b=eiLAwN4y2xcicktX/4OB00rvkj2V4SIxpYuj0hq2a0qe7VCx19uxRrUHptEtjBox0S
         8IVnJ/sKu/gEldJsHaCjYOLQ9www/HBG14nbL3Sir8H3YvwlhHJoiQjDjN+mKNBXaId9
         5lSYnrgFKj0/wuxsLIYM/jjcBm9hfd09YUvkmvYTifGJjysqxeZOrxtxT+IV06E1mdOy
         C1WuLpXoEZ4W4uPk/3BLlAwaWRR/c2GKB1WaQi3LLQg3Zv00TozczF6XI+fWHe4iL//w
         pJd6D1VygROa8wl3zectP2+t5yPQb2oPE+nFF6ig6aF6jrqjGBz+erKMlZbLzDePQXy1
         /5HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850912; x=1774455712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        b=d5HEUmxlvq3Zxzzz1sv9qgh8UqxH1M9QhLfmQDhv5eAtk7Yb6SNYvp0kGB+EegfCr7
         37Oxxizoz3YKi9aDNNuCdvqXW8LEyw3eznAKab0cydtcjFq4eADYx1QK1e942bMCgLfJ
         xDJZZqHDFPYGpsbsJJ8Ymx7NChyueUdNAd487t1UBlf/a96zyr16Hj+k7lVNl9JyJSLI
         ohWqsRlVTxkUicC0UVSNuoOnPTupxBdqQdkEjJ6EThnz2UfilE18d5KdkdBOgg+ROWhG
         7ucU0CXS4i1elofKqF7OQUVZaHMlcp1lFbXFBKl6n5xmacqijX9gUsrwPmAww4GpTry+
         HFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850912; x=1774455712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        b=cej9GDRkW8I/fZk30RirJ/7GcSLLKb4VbFjY2ZOdmEU/Tn/TgYPDE9AaOo3v1vSFvu
         cGaRwX/LQ8aJusxHwS1oe1rToWa9VcuU9l/zVnDVaCCiCUAEFjDbDt8OrPxcowDLjbEI
         2yn5W+154qHnYCzmpXYp3xhWLGt1qSHdhQJvbNopeD1DDedcYtPVk4oQMbmVT4bsAsGS
         OOVBqr+tpwlJoblY33aPmS6NIeQXGLWqWdqagpPY7n6bZpyG3eNjgphTNMB/8u7aan6M
         aaoLUYqCxpkVgYm1Fa2gicdDO5dpqPFvVoQ037CcUCjd1lq2pBPMnNIm0fliBD6m6ppA
         iLVw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKrUBFHDkVKyhGmhDrR1Z/qxQDp1gLYj1ou4XllMBIAlBZWLzs5MOC/T24OgZ/gWnXHBxPBsiHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbhyf6Rm4mU+m+mx21ltyIoEGqSEjY9F2AJFIf8JeI1HY4p54E
	3qfUPHJ8kGs1khPjsr+LPXDi34Vse+MRze+X8xEn9v4pTIzz/9DPmcFQYHMv7NGDn0RyefKtSKQ
	/OdCi0KOkJJpNrIH/K92M0fx7uk4Ab9U=
X-Gm-Gg: ATEYQzzSl4cdQFTn5VI6LxEF71ZzxD5CjxDmlPtj9VMIFvpcCLCHkl+IEdpsyem+YkQ
	0HvggDdqFdnTH8TwEkYwRHLMxHz9LX+pnrWsGAReFYf//8VVMS1abCbgiZ/M00z+592qbTHbarz
	ZFk7gyztdHRy4jCYu1cFRYaGiP1tDUMjyaz8yUDUpqRL1nkdTA7NG2zZ/Oaaj791YigxCFFLbby
	ACP95wkzsk68un8ClS1CU87qoy+t40O8iz8RkxRI13hfbt2bkoCjmJGcPuOEr+9CiE2CSECMRYQ
	OQQQQMA=
X-Received: by 2002:a05:6102:cd1:b0:600:20:74f8 with SMTP id
 ada2fe7eead31-6027d12e74cmr2244655137.13.1773850912407; Wed, 18 Mar 2026
 09:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com> <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com> <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
 <abljNCs_wjNELf6b@ashevche-desk.local>
In-Reply-To: <abljNCs_wjNELf6b@ashevche-desk.local>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 19 Mar 2026 00:21:41 +0800
X-Gm-Features: AaiRm52RxoZ9zoDXEHEReqGGGsP114OiKOh1K2PEy0S4Gpi8Filgw6YhnVYGX-c
Message-ID: <CAAb=EJXA+SVPWLcWu1WRr-8A5Vk0k4za09+ROFqYX2eceH65XA@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-20260-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEB362C0333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > > > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> > > >
> > > > Regarding the LKP report:
> > > > I have reproduced the Sparse warning (void vs int mismatch) locally=
.
> > > > To resolve this, I'll use the do-while(0) form in v3 to ensure the =
macro
> > > > always evaluates to void:
> > > > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > > > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > > > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__)=
; } while (0)
> > > > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__)=
; } while (0)
> > >
> > > Wouldn't be better to drop ({}) in nfs_error*() macros?
> >
> > I understand that the ({}) wrapper might look redundant at first
> > glance. However,
> > even if I remove it, the return type remains an issue because no_printk=
() (which
> > dprintk() expands to) already contains its own ({}) statement expressio=
n.
> >
> > To resolve this without refactoring errorf(), which hasn't been
> > touched in years,
> > I believe modifying dfprintk() is the better path.
> >
> > One alternative is to explicitly force the return type to void like thi=
s:
> > ({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })
> >
> > While this ensures the return type remains void (consistent with the
> > behavior before
> > dprintk() was redefined), it is admittedly clunky. We could wrap
> > (void)0 in a macro like
> > #define nothing_to_do ((void)0), but that adds unnecessary complexity.
> >
> > Therefore, I still prefer Option 1, as it restores the original
> > behavior from before the
> > recent commits and maintains the cleanest code structure for this subsy=
stem.
> > What do you think?
>
> Personally I found the ({}) in nfs_error*() redundant and the point of th=
ose
> functions not being touched in years doesn't work for internal APIs. Do y=
ou
> know the reason why it wasn't touched? Perhaps there was nothing to do si=
mply
> with that until dprintk() issue reveals some (legacy?) stuff to improve.
>
> I would not go with (void)0 approach, but I also think that dropping unne=
eded
> (if confirmed) expression wrapping is a good thing to do.
>

Hi Andy,
Thanks for your comment, how about removing the ({}) and ternary operator t=
o
prevent sparse throw incompatible types. And use the do{} while(0) to preve=
nt
dangling-else problem.

#define nfs_errorf(fc, fmt, ...) do { \
    if ((fc)->log.log) \
        errorf(fc, fmt, ## __VA_ARGS__); \
    else \
        dprintk(fmt "\n", ## __VA_ARGS__); \
} while (0)

