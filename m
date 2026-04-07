Return-Path: <linux-nfs+bounces-20685-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YISTFOGU1GknvgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20685-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 07:23:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9123A9E92
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A1043012CB1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946E3603C9;
	Tue,  7 Apr 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv64BI6C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01073368BD
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539413; cv=pass; b=dtYsBQJlZHK1336sEfRgiJjkY7rgZSb5VaWD/JBQRKJCHIyPM649dQ4cjlDb74wmL/owk7Bv5lxY/HvjOd4wtUSQ5hBobMQLHH+w2OxeHmLLf5n8l4ezaSkzm6gsfLl878hl/0etldITK23NBpFA4HpOJ0weTwRFRWBFTAYE9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539413; c=relaxed/simple;
	bh=P8O2ngwzlTIl/uy4u/wT03bNDC1WrdJurhMAb0y8elo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZ1QDcI271gIrb2JznGpiYQQaYnimygg2AwjbVGENKHIYqBA/R7COpLlQuedc+WuNId7Od+8yXzq6SPA/4JqNPo3AlX/+G3Tm6Q9zklXQcHkC4RVutsnfskhtzNsIiFZ9SnKJfic8YV0kxEu04AukIm3z3wZAYNBiZxxg9/ZeLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv64BI6C; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so5792276e87.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Apr 2026 22:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775539410; cv=none;
        d=google.com; s=arc-20240605;
        b=XlMoB98WvG4/yK1qt+ErnlcN6h7gG76OJ9/cVv1xrGAIvaYANnqkao/dwDCmw/1nWf
         JXlxc7Qh5T6y/6D0OyumtBo/Fv6iBQn9lpvB4IElDiOWKn+rMCAePx/M834cpV7LOtOR
         J27OKM8dNuGBZd41202zX8FKKMW+8EbBdXqsPPLDvlFLU+DMYUc7uwjZZ+mVybQzfS0O
         MDmSY/5OLzrC46f97DDPgJUW4VDFE3bDH2LMtXkD+Ilk5UR0kbpezE556jD30hJ5/1as
         6J+8gNrT+ozeXZlEW0nmFeyZJa5R7vtmWNRqFnswp77Nh7za587gjQ+ASrA+1VYV2iC5
         z/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fjg3eO3/vMoXvlonW9NarXLCG/5ulT+rkoLku1AFMCo=;
        fh=5TsjfVuDyfJzKWE5oHYPOF6fejzPRQzZg+qvrEiOSjA=;
        b=Z035RgBuFnKIMLwfZ7EE06t0B3bRCXoZXkDlPZJhZJ2d7hnvRTezQPN4meaXVZJbRC
         /RWiyiwiK4fAEF2JBLbFx9wBw5AmwKjLatHOA8YpnUJfV/cmZDmkApO9VLFMYu/vzEAx
         Xe7hEnrWwGkuW+TWZdrRFQu2ysjI31gu8sS0Vj2taB1k4w9qvurL5lVk1ZM8QBxF4lA7
         fFbrzzAHHI8ZYikmz0zn3PpUvJ+uqsu+CI5GpRKRSzH6/D8M72tA6wuWlV7OeMeuA/lf
         HYOj/aZO4y4E54Wf1nOzg3x7KcZzHkx0g3iNOerNDOASqM4VL4Icnl5L2UZYUxDYQL9H
         A+ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775539410; x=1776144210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjg3eO3/vMoXvlonW9NarXLCG/5ulT+rkoLku1AFMCo=;
        b=Wv64BI6CuWuPns7HaXN5i/UON90Nvhzu/iYbGcJdFq/jhGZP1eyyvoI6vXwCTZnCUF
         BbDgBdVHUTVA2OXw+cHG8HF8I6V7JEfEikgLA5/b6LJ4PVu8yAFA61vigBlY9zDdas3z
         Pl8R3WVSQAaoEf165xcEHD8GnxZ5bJ0bHs9CzH3wXmsxd1hplcQDrWbhAMaF+aFU0KcS
         /aTZTHIEJlQymB4iXI1H+51uKpDh8tM7bAqhjAQwM4ejCcH78hWUpGFplauXDEIsy3Ic
         m2NOqIHYd3Vq9beZtpjfniosB5kVzucylRKXe8u5nAVZGQdLG/W/NisetRJ/7jjTtelW
         Owqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539410; x=1776144210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fjg3eO3/vMoXvlonW9NarXLCG/5ulT+rkoLku1AFMCo=;
        b=MwBjqEguD57q9XH7i4fRbX0NrKx5hvPTfY6e+hjuMQ72hCyV7Bnembdce3PLHCOazR
         60n50Gd04CTeevfOZrvstAqt/GJ1+GyO4WMboa3wsIOeUKqAh7oBV3oLlUzqSWO4teeP
         NKrtxrpR54TPeP/32BfaNOkKsMOhW5uBX8TCKVNc4ipaxoazb8RZpG7xJe0ezudq161C
         yKUbvxRvLw3nLYfvlBuhHEq52QqLa+AhDn86EYQlUOOTOgncdwSnGatx5T6lQ3F5AGJB
         F4nVY65tBGxA0RqDylbFsv9WHi+TzSvrK5O8m1v4CMFmvWbAuUHfpXT9HYe4i80ACRHE
         iOgA==
X-Gm-Message-State: AOJu0Yztnt+Sk2DleuGZYCo2Ew+qntkx7xRRyTBphV94A8nUsNky8Mlf
	oE8WWwE39xxLKhH6eJiVUg2xOhmB734Yz9aov7OOElBtmksm6v7jPzNUTxeUpDLJOw6nA3O6ubj
	Ueti5dXorv7BcD5s81H4P9bBAPRlcLYKsZ0ak
X-Gm-Gg: AeBDiev1nwwX8fetNYkTgLgJoTOSbFiN0WM1M+1wKgNPMG0jTvWpVqK8CQeV39rIc2T
	57BD9SpDJyql7iCcghXqlS0B5fNbsUT1nKYRE5awHisH5eb9gUf+JeteTHWQw0F+zJsud8kiTZa
	hyD5bnUW18oKhLK6O99z63bazdIjbl7y02u/g9BBcpsNTTJN/XRbZ4Z7HXjHoKq2Av4zF8DU/VI
	E1NcHuaLeCG5Vz4xhNEXdB6UFyOyVUjomSk8L9Np+YlHqXHnDqTxc88wdjUcIc8kxaYUvg68sfc
	oHOrMMqKi+lgBNarOfeN4QhdFJ9dkJ014FwOIw==
X-Received: by 2002:a05:6512:234c:b0:5a2:b58e:e3dc with SMTP id
 2adb3069b0e04-5a337584a26mr4815111e87.24.1775539409794; Mon, 06 Apr 2026
 22:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Tq-RqDP_BAroLX6wVrNY1BMwC9BOZ-UorLje=TXBdEOj8hjQ@mail.gmail.com>
 <CA+Tq-RouZ784rWHjwSz6GoJc4f5f66A2mr2-PdyFJ2bK2Y20wA@mail.gmail.com> <d259c550-4cf3-425d-8485-86c126c1d256@app.fastmail.com>
In-Reply-To: <d259c550-4cf3-425d-8485-86c126c1d256@app.fastmail.com>
From: Hiroyuki Sato <hiroysato@gmail.com>
Date: Tue, 7 Apr 2026 14:23:18 +0900
X-Gm-Features: AQROBzAeAf-xq6ONbEzt861DRkWVAPNagvw2W1G8ddE7LkWCduSew30e9HZQOj4
Message-ID: <CA+Tq-RqYx4iuWuF0LpSKuxwhM3agxwvDUG9-r0Ob-Z_NLoJJwQ@mail.gmail.com>
Subject: Re: [Q] NFSD: COMPOUND reply tag padding not zeroed? (e.g. \xff\xff)
To: Chuck Lever <cel@kernel.org>
Cc: nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20685-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hiroysato@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: DC9123A9E92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Thank you for your comment.

I'm new to Linux kernel development, but I'll prepare a patch and send it l=
ater.

Best regards,

2026=E5=B9=B44=E6=9C=886=E6=97=A5(=E6=9C=88) 22:15 Chuck Lever <cel@kernel.=
org>:
>
>
>
> On Mon, Apr 6, 2026, at 12:22 AM, Hiroyuki Sato wrote:
> > Helo,
> >
> > I can reproduce the same behavior on Linux 7.0-rc7 as well.
> > (591cd656a1bf5ea94a222af5ef2ee76df029c1d2)
> > The COMPOUND reply tag padding sometimes contains non-zero bytes
> > (e.g. 0x69, 0xff) instead of zero, which appears to be the same
> > issue as previously reported.
> >
> > Would a change like the following make sense here?
> > It seems to zero-fill the XDR padding explicitly for the reply tag.
> >
> > With this change applied, the padding appears to be zeroed
> > consistently in my testing.
> >
> > Best regards,
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 9d2349131..b33e031bf 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -6377,16 +6377,18 @@ nfs4svc_encode_compoundres(struct svc_rqst
> > *rqstp, struct xdr_stream *xdr)
> >  {
> >         struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> >         __be32 *p;
> > +       size_t padded_len;
> >
> >         /*
> >          * Send buffer space for the following items is reserved
> >          * at the top of nfsd4_proc_compound().
> >          */
> >         p =3D resp->statusp;
> > +       padded_len =3D XDR_QUADLEN(resp->taglen) * XDR_UNIT;
> >
> >         *p++ =3D resp->cstate.status;
> >         *p++ =3D htonl(resp->taglen);
> > -       memcpy(p, resp->tag, resp->taglen);
> > +       memcpy_and_pad(p, padded_len, resp->tag, resp->taglen, 0);
> >         p +=3D XDR_QUADLEN(resp->taglen);
> >         *p++ =3D htonl(resp->opcnt);
> >
> > 2026=E5=B9=B44=E6=9C=885=E6=97=A5(=E6=97=A5) 13:17 Hiroyuki Sato <hiroy=
sato@gmail.com>:
> >>
> >> Hello,
> >>
> >> 1. Observed behavior
> >>
> >> * When sending a COMPOUND request with the tag "create_session" (14 by=
tes),
> >>   the reply is expected to include XDR padding to a 4-byte boundary,
> >>   i.e. "create_session" + "\x00\x00".
> >> * On 5.14.0-611.45.1.el9_7.x86_64 (AlmaLinux 9), the padding bytes
> >>   are sometimes observed to be non-zero (e.g. "\xff\xff").
> >> * From inspection of recent upstream code, nfs4svc_encode_compoundres(=
)
> >>   also appears not to explicitly zero-fill the padding.
> >>
> >> 2. Questions
> >>
> >> * Is this understanding correct?
> >> * If so, is this a known issue or something that should be fixed?
>
> I think the rules are:
>
> 1. The sender SHOULD clear the bytes in an XDR pad but doesn't have to
> 2. The receiver MUST ignore the bytes in an XDR pad
>
> Feel free to clean up your fix and send it as a contribution with
> a full patch description (Signed-off-by, Fixes tags, etc etc).
>
>
> --
> Chuck Lever



--=20
Hiroyuki Sato

