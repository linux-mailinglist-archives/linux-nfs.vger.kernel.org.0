Return-Path: <linux-nfs+bounces-13907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F6B373F3
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723FA363EAF
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E130CD81;
	Tue, 26 Aug 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc+u2/sr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BD285071
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240893; cv=none; b=gi77+XeXuCXbl6Go9Ou8uQB46wuS4WkPTB0WJaDiyMgO742zXeScJI2BpTQ7PHsiWI0b+H6b9TKYdOT+2ZFAfgyFuXkpW1OyZCNiMDLnwVEDetvNGE9rh/ijxslTXuS5WyBLNPalBxIaZJjT3tK1wJpMyc9hmL4T8QZRKP5XMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240893; c=relaxed/simple;
	bh=j4T9W1daAz+N+Zv2iygmqPt7Y2t9xrj5JctOCpO7dws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRtMVuV9ES+5tbkxtFCqFGl6guXgJNUdXoKDx7RZzu/wVUJOlueTlnu9cIqKoiI1kvxJf0A7cCuZe/56K4PR2ZqlACKAyqEwCkqvp0H2hOxoqlzPcut+RsQFCJ/RuMKwod/x5ehlzOSSWqVj/A0Pojty/aoOXgaCkHWrhWnxvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc+u2/sr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756240890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqHSVnEFkISt+89x5bWEwiLQbCZGSakbElSAZvNBx6A=;
	b=Sc+u2/sraOrpH+tEMvMBap85NSgNVOkTjBIvv7qL4PcX6PpS2BHaZGjGO4O/IeME9n67p6
	oEm+/fTH+E2qpTEhRxkFRW2PB+3n69Xosw3sQFby4AnnuIyQ4mIVyCg6qfGPHKsqiPpU1D
	TUS4thZu1XrdZwEVDa6bulcu83fDScc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-XoKuYHl3PDGGCVVJDUy3Cg-1; Tue, 26 Aug 2025 16:41:18 -0400
X-MC-Unique: XoKuYHl3PDGGCVVJDUy3Cg-1
X-Mimecast-MFC-AGG-ID: XoKuYHl3PDGGCVVJDUy3Cg_1756240878
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eefbb2da62so26321975ab.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 13:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240877; x=1756845677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqHSVnEFkISt+89x5bWEwiLQbCZGSakbElSAZvNBx6A=;
        b=cq7zTCIWJMWO+Q/H6koQN0w6/kc+VpDJIM8ndGT0HPSBFczPVfDc57KOvIy9+hnsxK
         6VKpxB//HtF20zm3kASsXmbMFv0l0+DsPtsM6SXoy5T80K7cGeJuAjTL9E2tA34SLCd1
         /uw4yIIPg7hSw2r9aEGc7oNb5CcHOyr+oM4os65xLL9WiRtsIhTLX3TPkKlHnKbCruwe
         V7RYOxlrEb5tySg5WAeqFsIBP7fVkbUtyxC3pG0OxI+rlgYJpRXzgK31r1hJeCxzmw/s
         vFoZouXoBWGcLTLbN4BjYIzbeh4WBF2x9fDcJ5EM3V+yBgPqzv4rHkqbZoSIeD9CFVhB
         OEgw==
X-Gm-Message-State: AOJu0YwAxmQIYxqxQN4ych1wnacNnx00q6ii0wjqHqBp5BWKKwx1XjQV
	nSzF8a/MkBk+RPOamVClLs8f0mXEIXXGpjTZutfgUnmBfVbLxQuDRURUkUAa4G0QL2IgjoGxd16
	9LIQ4O12lMD3v4T8hU9Z51a4EuLyCVDbWJ1Dq3Wl05ePbasaYwlS54ynx1DMR0GnpOi9p/KT0lT
	IZaV1bmMTHOiV4zapVVG87eqz9UeYG8peyoG9Sx+d43BGBmPLBVw==
X-Gm-Gg: ASbGnctyp7ogBDZYqzr59qiwjIEiU3zCkIWGfdVXlH9r/zB9MVaZTZ0qVTl4X66sGoM
	fN9TvzuNQzQQ5bEgnXWIo4D3cswyRGZmLBvzuG70WYSA/0d6ydzK6Hncjk16kPwEUyX2YjSNzOi
	kpHaWIHiQO0dp1UJlD6EmO
X-Received: by 2002:a05:6e02:214c:b0:3ee:a3ff:96c7 with SMTP id e9e14a558f8ab-3eea3ff97bbmr46543885ab.17.1756240877631;
        Tue, 26 Aug 2025 13:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrQGgEI8i0aARkPVbFHsPFgMOC63vQRDoQ1u0bDmolEkUTgcJhsZWRMdpZOotRGMe6ZN/ZLNNTOr1PZoKJ8vQ=
X-Received: by 2002:a05:6e02:214c:b0:3ee:a3ff:96c7 with SMTP id
 e9e14a558f8ab-3eea3ff97bbmr46543685ab.17.1756240877254; Tue, 26 Aug 2025
 13:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812213822.403844-1-tbecker@redhat.com> <7e8be3e3-f766-4120-8c8f-6ad5b715dcc8@redhat.com>
In-Reply-To: <7e8be3e3-f766-4120-8c8f-6ad5b715dcc8@redhat.com>
From: Thiago Becker <tbecker@redhat.com>
Date: Tue, 26 Aug 2025 17:41:05 -0300
X-Gm-Features: Ac12FXzrpmUZr177IiWTOeRxWoRIYZ45RyPcbLWBrNDBjbiM-3JbK18JXbxSCXI
Message-ID: <CAD_rW4XojqZj72OGL7As32LfVRog1YDUq=M1=8zF54k4B6ZNEw@mail.gmail.com>
Subject: Re: [PATCH] nfsrahead: modify get_device_info logic
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The success is detected in the loop in get_device_info, in the
stopping clause: if the call to get_mountinfo succeeds, the loop
stops, and the function returns success. If the call fails for the
number of retries plus one, the last error is returned, detected in
the caller, which logs an error.

The 50000 us is arbitrary. We need to give the kernel some time to
update mountinfo, and 50 ms is a value that works well, reducing the
number of attempts to 2 to succeed. The current implementation tries
for 50 times and fails because it executes too fast. Using a larger
value doesn't improve the success rate, and a smaller value increases
the number of retries (at least on my PC).

-- Thiago


On Mon, Aug 18, 2025 at 10:03=E2=80=AFAM Steve Dickson <steved@redhat.com> =
wrote:
>
> Hello,
>
> On 8/12/25 5:38 PM, tbecker@redhat.com wrote:
> > From: Thiago Becker <tbecker@redhat.com>
> >
> > There are a few reports of failures by nfsrahead to set the read ahead
> > when the nfs mount information is not available when the udev event
> > fires. This was alleviated by retrying to read mountinfo multiple times=
,
> > but some cases where still failing to find the device information. To
> > further alleviate this issue, this patch adds a 50ms delay between
> > attempts. To not incur into unecessary delays, the logic in
> > get_device_info is reworked.
> >
> > While we are in this, remove a second loop of reptitions of
> > get_device_info.
> >
> > Signed-off-by: Thiago Becker <tbecker@redhat.com>
> > ---
> >   tools/nfsrahead/main.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> > index 8a11cf1a..b7b889ff 100644
> > --- a/tools/nfsrahead/main.c
> > +++ b/tools/nfsrahead/main.c
> > @@ -117,9 +117,11 @@ out_free_device_info:
> >
> >   static int get_device_info(const char *device_number, struct device_i=
nfo *device_info)
> >   {
> > -     int ret =3D ENOENT;
> > -     for (int retry_count =3D 0; retry_count < 10 && ret !=3D 0; retry=
_count++)
> > +     int ret =3D get_mountinfo(device_number, device_info, MOUNTINFO_P=
ATH);
> > +     for (int retry_count =3D 0; retry_count < 5 && ret !=3D 0; retry_=
count++) {
> > +             usleep(50000);
> >               ret =3D get_mountinfo(device_number, device_info, MOUNTIN=
FO_PATH);
> > +     }
> get_mountinfo() will error out with an errno value (ret !=3D 0) so
> how is how are error detected? What am I missing...
>
> Also why was a value of 50000 used to sleep?
>
> steved.
>
> >
> >       return ret;
> >   }
> > @@ -135,7 +137,7 @@ static int conf_get_readahead(const char *kind) {
> >
> >   int main(int argc, char **argv)
> >   {
> > -     int ret =3D 0, retry, opt;
> > +     int ret =3D 0, opt;
> >       struct device_info device;
> >       unsigned int readahead =3D 128, log_level, log_stderr =3D 0;
> >
> > @@ -163,11 +165,7 @@ int main(int argc, char **argv)
> >       if ((argc - optind) !=3D 1)
> >               xlog_err("expected the device number of a BDI; is udev ok=
?");
> >
> > -     for (retry =3D 0; retry <=3D 10; retry++ )
> > -             if ((ret =3D get_device_info(argv[optind], &device)) =3D=
=3D 0)
> > -                     break;
> > -
> > -     if (ret !=3D 0 || device.fstype =3D=3D NULL) {
> > +     if ((ret =3D get_device_info(argv[optind], &device)) !=3D 0 || de=
vice.fstype =3D=3D NULL) {
> >               xlog(D_GENERAL, "unable to find device %s\n", argv[optind=
]);
> >               goto out;
> >       }
>


--=20
Thiago Rafael Becker
Software Maintenance Engineer
redhat.com


