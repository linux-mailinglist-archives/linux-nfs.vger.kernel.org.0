Return-Path: <linux-nfs+bounces-2243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B71B876A4F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F349284CD6
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E78C1A;
	Fri,  8 Mar 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IobzzfMe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F379E5
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920684; cv=none; b=AVPeuU4Xz8tFXAfW3UwIEePtJK047N8KggagTkNsIlYviqF9+W9pE7fq/MO3xclWchwAVzDitGTNp80b1kNerZ5yLXjqVqXFgaDLBxHWbCFkGSb1zVafUIqKWEhQ+c+BXikKp4ZWUXXyEwvuAllW9HBpGdwV9+CGekYSrt53AAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920684; c=relaxed/simple;
	bh=DyK1/S9aKYE+NrOxvd62x8a+t7H1Zy0tfX9uTakIeDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmTSEwj5L4OqiPGbWFRfReTpNRbkM0dGBCX7yrc/ZRUvogBlLsmrfF7qmpxZm9WQ/XAKcU8LVf16UtRAkYu858nbFh+PrEFdVyOZSsjxj8712nfC+SplfeBvnxOeBNnx/cwXLndP7+J02l/Lb7hfE8nt9F3MMqofUNJLQOZHFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IobzzfMe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78852394838so37645285a.3
        for <linux-nfs@vger.kernel.org>; Fri, 08 Mar 2024 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709920682; x=1710525482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yM2BMLqfp8VvBpq+4w/dWr0bg1t52MXInvHhw7/E9bs=;
        b=IobzzfMeSchVPj6gJFRJ8oN2oNVZYQjlw4BMTawmXOVKqAieCL8UmaylwOfvRM8VRW
         EEl/2yHKnvFNs81dPL7eDYpXM0M/BZXGU1cCuDjjKwAMGQhmfWhLBYTlUEO1Topnfy1S
         s6jkkp7ZYgSknD43DMvoQ/GeWcyjW+19oejGvStemHksNFxn1WYeX5wWYd6n8OmD4HAR
         fBuOs+3tD4o5NbqIWIMpH7iAEp19lv+HR0jOsSv63/FQXYEgDzVKDepPsCRUl8vi8SNB
         v0hiUDJuFxNV2AaeM3sErjbXH40+oYng28qCP3AndJvYIpZbxehI7ycAQejS4+sVjskt
         zIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920682; x=1710525482;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM2BMLqfp8VvBpq+4w/dWr0bg1t52MXInvHhw7/E9bs=;
        b=kDVi5DvBlwcR72OLQnxgZd3Mh+QinDC2evOCcno/L1qpJVl4VoGibHuBgWWmatM6VY
         KIFHpF/Hcef44rw4pt7QGrQ4MyOLiqBXxTuOZMV/+iTSzM+p+p5dPEFZzA9io2iEg0Oz
         F5DLQ19fJU+JGrwfBrUmHxjyUJipydn3/qw1NvCR+KLJSiI6uffq8u50AA09eLtzIdgD
         B3JEA/arn5zyd6A7cgMmKErnN41lVD335zN99xljBsf3C2TvPob5TnpjtgmvKeyzlpLQ
         Gr2FIMg2CH11f4bDOMMNGA+wR/4pZ+eBbj6co6CQfgjFHghTc0pR2OLtWZTtAvigC1re
         he6A==
X-Gm-Message-State: AOJu0YxQxwhQil0yISxV1Jr1arnfMeLyE6gji9kEfJBkdMhLhy3dnQaU
	msxlkgb/c/8SXMPH/duY59Sa2hrpDdc6QAFQF7/19tLFF5KL8r8=
X-Google-Smtp-Source: AGHT+IEeUjAhpLG/lyvZJBA9fmsOGROIHpcgtmMNMBtPNu+tG6+S1NfLFsW8R+ehbyFjT9vbgfaF6w==
X-Received: by 2002:a05:620a:22ca:b0:787:fafd:bf with SMTP id o10-20020a05620a22ca00b00787fafd00bfmr11420768qki.15.1709920682164;
        Fri, 08 Mar 2024 09:58:02 -0800 (PST)
Received: from [192.168.75.138] (c-73-145-170-161.hsd1.mi.comcast.net. [73.145.170.161])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a16a700b0078829ce9716sm5384027qkj.78.2024.03.08.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:58:01 -0800 (PST)
Message-ID: <73c3764baa022623599d8add31a8b7d8393970c9.camel@gmail.com>
Subject: Re: [PATCH] nfsd: allow more than 64 backlogged connections
From: Trond Myklebust <trondmy@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Steve Dickson <SteveD@redhat.com>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 08 Mar 2024 12:58:00 -0500
In-Reply-To: <5ec92aa8270969500e7b457c73f279c30fd6887f.camel@kernel.org>
References: <20240307213913.2511954-1-trond.myklebust@hammerspace.com>
	 <5ec92aa8270969500e7b457c73f279c30fd6887f.camel@kernel.org>
Autocrypt: addr=trondmy@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-08 at 11:54 -0500, Jeff Layton wrote:
> On Thu, 2024-03-07 at 16:39 -0500, trondmy@gmail.com=C2=A0wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > When creating a listener socket to be handed to
> > /proc/fs/nfsd/portlist,
> > we currently limit the number of backlogged connections to 64.
> > Since
> > that value was chosen in 2006, the scale at which data centres
> > operate
> > has changed significantly. Given a modern server with many
> > thousands of
> > clients, a limit of 64 connections can create bottlenecks,
> > particularly
> > at at boot time.
> > By converting to using an argument of -1, we allow the backlog to
> > be set
> > by the default value in /proc/sys/net/core/somaxconn.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0utils/nfsd/nfssvc.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
> > index 46452d972407..c781054dbdae 100644
> > --- a/utils/nfsd/nfssvc.c
> > +++ b/utils/nfsd/nfssvc.c
> > @@ -205,7 +205,7 @@ nfssvc_setfds(const struct addrinfo *hints,
> > const char *node, const char *port)
> > =C2=A0			rc =3D errno;
> > =C2=A0			goto error;
> > =C2=A0		}
> > -		if (addr->ai_protocol =3D=3D IPPROTO_TCP &&
> > listen(sockfd, 64)) {
> > +		if (addr->ai_protocol =3D=3D IPPROTO_TCP &&
> > listen(sockfd, -1)) {
> > =C2=A0			xlog(L_ERROR, "unable to create listening
> > socket: "
> > =C2=A0				"errno %d (%m)", errno);
> > =C2=A0			rc =3D errno;
>=20
> It does look like the kernel casts the value to unsigned int before
> trying to interpret it, but that doesn't seem to be documented
> anywhere
> that I can find. It's certainly not in the manpage
>=20
> There is this in /usr/include/bits/socket.h:
>=20
> =C2=A0=C2=A0=C2=A0 /* Maximum queue length specifiable by listen.=C2=A0 *=
/
> =C2=A0=C2=A0=C2=A0 #define SOMAXCONN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
4096
>=20
> ...but I guess that's problematic if you set "somaxconn" sysctl
> higher.
> I wonder if SOMAXCONN should be redefined as "(int)UINT_MAX" in the
> UAPI
> headers?

Fair enough. I'll respin with SOMAXCONN. It looks as if that is what
POSIX expects us to use as well.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



