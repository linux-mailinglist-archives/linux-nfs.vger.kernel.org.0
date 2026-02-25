Return-Path: <linux-nfs+bounces-19246-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EqeLy0ln2mPZAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19246-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:37:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6D119AC36
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E3823015BA8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000173D6460;
	Wed, 25 Feb 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0N0xAhf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BE3B52F8
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037050; cv=pass; b=h8N/FM0vOvJZkT91jDP642IHMp9tLUTLPQ8+z5FaLDSw59mZydBz6E31c4PIynHDmHQLthjMtA199kQhCu/67rayFXObMKdCyefsHyD5Fk5Lwt5N0pCqPy3HCa/f46lLPIJifwk+AKK82PYUJcONuZqJJptP1ZR/KcXcrowvjO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037050; c=relaxed/simple;
	bh=3BhgU4L3d3Mb8w3H8cisiauldWjQo/B5P7z5b8+Wfic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd0XfGnxyhrj+Pk3vu4hzxV/ESJAC6KePWwIrkZWOhROJTQWCoB94cW/lvkJXYLOMHEj9FVAj5Wzw8lxYOLQ1T6vu7mCbd7QpjZthZG6Xb+cIJJp5lDQPiNfueQQk23DSCufVyKpXomZweLNgTviIItrWGdaVRhFaifa/7bR3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0N0xAhf; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94dd6f452f0so1246050241.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 08:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037049; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+2WpFbVDYKr3+H8LFQ+60/SbXMWEq0SOPtQzt/WyQ1stv0sywOuJmQ0MlM4QT2ErQ
         0L+Jvn3TxJW8SUaSFWQ6T4dCw5xo9/tHMFls2al1a5k+NPDdaV+QhD3ydHHpHfIJ4jTN
         j2Fnkgypqb0Dz8XKBCOIGnW92fJjAnR9OnNoeF5LxK3A9hqwbXjOzsavcDx6QVCTYC/n
         QrfTFU3oPLWceILaJjiMi+7sSaEdsvErt8oDF4CqB//cucMogHhLxd3dkmKG/wsu5WES
         pRZHhwFRe/JgkJLbjmsS8Isac0IPAS2iEbDTl1MIBCtopGjTra5Nbxp/op3D4hCy6a5G
         62sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        fh=Th73lSR3sHuR034IjDvxBY4u85QAuFqEreLur9tpKS8=;
        b=L/WbWYgRp5JR0uKatyU4VG9EAw4HfIR1EFWyBpEhLPAOWHAtYZdeJfCi+dGmc+TCHE
         i3HHEebLNjs6nR85lpZjgnHo5+3I5OmZBEZ/I+beGrhmxgqCef0KCEGxI05sfwF8KIdv
         X7f2UYojqXmUeGzYN/GKnE1U971oTptuRO5iWAePOXCpaLQ2TprkoQ0HNRP+SOOqyZXE
         QrJuc4S/ImjK/t6fmErnkFBLf5XwsTT8Rv/m8dDtpPSUtqTh5etQCoALfCDZflal8mms
         8c+ldVJBEXuicTXZEjnoRbsuqI++wyWxXMq8i4whdOacPemXR5VxqlRESzdw+lbijdby
         BvPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037049; x=1772641849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        b=A0N0xAhfN/PLdjok9F1h3RI1kazjXPFQnYhC+Q6pCkf8srnz1ufB2obc1gM1/N5xX1
         YTP9xvvIDrR5ajF67csTKGjc/qofn3SQaOH0xEdZhPpuIU3g8qWPkSJfTwXlRdi1cJ2X
         +LRmU8r9L4qYGVuw0inSkgiDOh72p+yVKpBq5jGsBPl85YniA14QdYFvLTT6YFwtghqj
         DJWzffXA71vm7bTRHZ2vEAJVcGOkVIdvQ8XAukAY18l3bnJuxvv7bMGfCUR85+/V3zkF
         DzVcJxEqkIbWE2ar1B+8VR+O+DCmCtEV0GQ1YqXY+1ZOnbbxVWTmNCFzrQtbv2JtzMYi
         14BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037049; x=1772641849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        b=Zccw6eBVh7/ayhW3SGvQ06VcLNr6+r4G7kGwjXhYJDKnuWhnkw0plPU0NeoTLKv5ka
         0s9HAJoJ0hlkzfcLeFetxXq0OxIInzcFPsiburaCEalPHPIwdbaQMqmXHmqxqrNeNUZ8
         5IBd8L0+KUuMjCjAOM/I6yCtWZccsguNY/ljSI5tZU/Na13gDuBYQYL5Aov8zLcBWrTv
         yXhmtrYhVG5oQ3eCKvLEaa/cnGddzbUEUY45ekffRV+FviRReoHJblwI/TbmytCGTdlz
         7zUzeARMhvo7O0hOczkAieg9Hrps6+Xk/kfXJajgEOnNuSKJ+j9ZDmdVen2saDshp2gU
         n9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9draRpGvNkDFDvgdR1y1nBdchi8zHygsg0MpxSiARQlrHlK7iPDjgkH5iCbqG9pBpH21Sbrao0xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2808KxNXgq9Y6FL5bzP1IlNKmGzsP5mgyvu7DPTMjpe+C2uO/
	Jb7QBsv+7rBI05/LP570dDoQZw+RD0Ba8SUmniz+CmUx3jn/dGxmTiRt5Fcvz8koJC7dVm0uTD/
	CMzB8ToA/68sdhgSvNVVfpyVm7JZVv4c=
X-Gm-Gg: ATEYQzzmP1g0YeRGLmX1aSpWhJZ+YbrgETiw30t3Zn0Pieek6b63hwVGrLV5hB4cEfV
	yfXfHf2R+BpASj6GPXuS+UTa/TkrP7eQ1vGVM/Tg+ldtGUbVrLDXhPnIAB3MU2DFwqkEUKmN3tc
	ETDsfiQ9R+R7cLtRV1sCz7PJnJGL1pP4+Z035GnR5nxgt+sjwodau5RDQJOQmYdY3sv0cqqevwy
	0iD7n9888BOOQ6MttWlA4oH/o3cHvu9eLlnMRzHKOhH6JgSjy6peJvwiUgupYWrMEIMuirDszee
	3FzKKZbT
X-Received: by 2002:a05:6102:3585:b0:5f5:3c00:1813 with SMTP id
 ada2fe7eead31-5feb2ea36cemr8990942137.1.1772037048458; Wed, 25 Feb 2026
 08:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224165435.17648-1-seanwascoding@gmail.com>
 <20260224165435.17648-2-seanwascoding@gmail.com> <55375148-e26f-4d62-8690-c0eae8bb1b39@lunn.ch>
In-Reply-To: <55375148-e26f-4d62-8690-c0eae8bb1b39@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Feb 2026 00:30:35 +0800
X-Gm-Features: AaiRm51wqt_5ZFcIrlM0pn3TUxq4cQLSELEgu3f2TttRboIi-k-mxs5UMSzZWzQ
Message-ID: <CAAb=EJXj+tsFp+Pm3sOY97YaGBBazWYmfi4j5R-F1+rw9P-+1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] nfs: fix unused variable warning when
 CONFIG_SUNRPC_DEBUG is disabled
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19246-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: DB6D119AC36
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilela=
yout/flexfilelayout.c
> > index 9056f05a67dc..de9e8bad6af2 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > @@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pn=
fs_layout_segment *lseg,
> >  {
> >       struct nfs4_ff_layout_mirror *mirror;
> >       u32 status =3D *op_status;
> > -     int err;
> > +     int err __maybe_unused;
>
> Sorry, but this is ugly. There must be a better way to fix this.
>
> Maybe look at no_printk().
>
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/video/fbdev/core/=
fbmon.c#L50
>
> #ifdef DEBUG
> #define DPRINTK(fmt, args...) printk(fmt,## args)
> #else
> #define DPRINTK(fmt, args...) no_printk(fmt, ##args)
> #endif
>

You are absolutely right, adding __maybe_unused to every
variable is indeed ugly and repetitive. I investigated the suggestion
of using no_printk(). It provides the same dummy-function
behavior while allowing the compiler to perform type checking
on the arguments. This effectively silences the -Wunused-variable
warnings without generating any machine code.

I propose modifying include/linux/sunrpc/debug.h to update the
stubs for dfprintk and dfprintk_rcu when CONFIG_SUNRPC_DEBUG
is disabled:
- # define dfprintk(fac, fmt, ...)      do {} while (0)
- # define dfprintk_rcu(fac, fmt, ...)  do {} while (0)
+ # define dfprintk(fac, fmt, ...)      no_printk(fmt, ##__VA_ARGS__)
+ # define dfprintk_rcu(fac, fmt, ...)  no_printk(fmt, ##__VA_ARGS__)

Best regards,
Sean

