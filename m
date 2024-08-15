Return-Path: <linux-nfs+bounces-5399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531FE952B54
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 07CA41F21E9B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB1178CC5;
	Thu, 15 Aug 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="XIEQM+vD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AF13C80E
	for <linux-nfs@vger.kernel.org>; Thu, 15 Aug 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711512; cv=none; b=YxWAS+TOFJpadpojBovRoykdUKe6Eas0CgvkOgtOxJsX+u42vo1wRVS8/oXAdI5e8iGPOJuUX16xf8nUj7W+Rt28buRK56LB7X3e8DKQOw0C06+xCZzhJPOQu2UO5HKWeQA+hTw8y72cD+7egj+o1Kn3oj7lknPvDugqk4BEAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711512; c=relaxed/simple;
	bh=6lgaLm6AUj8bbvxhKJA+cSqlnLe6FTjWrRnbU4dntmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb/MGIlG8mvR5ROSaSiGBfFz47CmE2YbJIbn9xXVWZhZ7i3jGtJLXeoE1Ke/HQf8vd/jD7jnBKGXpLTyhFwZ/o07iNN//+56Du6AgHK0CzxedF95ILNWknr/JW52JaO+KK+w5ibD/jYoLKCZ+1eISJkPDcIGKTFg7bQZy7FWXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=XIEQM+vD; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70936061d0dso436591a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Aug 2024 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1723711509; x=1724316309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzF+2Ka7VyQ+Kt9Hmh16kfyhiv0zAGO/ONJnQIiINqo=;
        b=XIEQM+vDdl10wDHPL9uX9TFtEPMerq9pNLHvxJqrMCACOYjjOXvjuIdxtm1XXqOX1V
         H0ZShV1NH1RSyX+dpiiS25CFL8rF2B2+LGVy2lNGzZ6uOnTnRVnzNtNXo/gAl6GDlA9R
         JPy5tv02co8MGeyOSPjlWvg4ay9/q+ZFpkTDEh7JC8H8d5Kef2aMdwhfWmM6dsZrG35+
         ZGhLDDNcuoh1DpFd1DkO8i/5qtGbeYO9JWZk909RqbPh47bFqN1b3BFzD01U1eaACwYk
         EE19qujJgUfa++7X/bZE24LlSM6GQ+kCCAdV5hunamGOtxP1L+UTpqHowXYYZLOCAku4
         nHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723711509; x=1724316309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzF+2Ka7VyQ+Kt9Hmh16kfyhiv0zAGO/ONJnQIiINqo=;
        b=vbk8vWwz4D6Ikm9AQoYZiDXPZehWlem7KucqZORfgBV210W/VEMsb5BykuGdSXh2ZS
         dZ561+OxNK7myDHOsIB5TZ0/K8c2o4ACzwMJPqk+0tEDLQj14PpPUUVDMdwXloV0N3wU
         q3qPoNZF/VxKp4gzAuN6PiVssuq5vOmUx3YxGpJl+QaKw7Le6fF7vFCpHnXTnSs2LJSQ
         CBSfw2KbQS1HGNXzP3oCSHvMQsInS3ZfraqyDziJFiEXExFuRWF1YqpNKMAIAY384zIJ
         wlAwJPYoxbKJ/498qrgNn8+Agw24uGQ9QIubDhDb4PrVe9PbTaKC3rsd9YdGoxW0/Sos
         KEiA==
X-Gm-Message-State: AOJu0Yy2kxbOzztCjI8q7YRbFpx0Wxb02slO+Q9WBySKV7770MHXdtmE
	/pO2me5LOrjNgtwiJduiBjVqaeFzVMRLgcOc9LKd2tyTO2IZWqyZYNgPLopSmWAc9lZ7LJRKm6M
	BAuciJrnNv94BegVF7aFtQtz/YE3UzGbWnt79XA==
X-Google-Smtp-Source: AGHT+IFuHu/AzBri4ImBmHnQMNL/5fwiUEeXarTncH1eGl3Y4zMAuR+MwdTRDcN3UzVnSEjDIO5UMkBVVOUMdVGFFP8=
X-Received: by 2002:a05:6830:6115:b0:703:69b5:1518 with SMTP id
 46e09a7af769-70c9d968f8amr6494370a34.16.1723711508858; Thu, 15 Aug 2024
 01:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3mN6XO1HCrcdCGAi4QKh2Pr_th+f+J5Wfr1wX-ngoJOjPp1w@mail.gmail.com>
 <96538e6c71afcc77eb352e52798e52562aa9f239.camel@kernel.org>
In-Reply-To: <96538e6c71afcc77eb352e52798e52562aa9f239.camel@kernel.org>
From: Roi Azarzar <roi.azarzar@vastdata.com>
Date: Thu, 15 Aug 2024 11:44:57 +0300
Message-ID: <CAF3mN6V85HekE24y+fJK2nCAta_u+=A2yBD_zktXngx484XCFQ@mail.gmail.com>
Subject: Re: nfs4 delegation - couple of questions - 6.10.3-custom kernel
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the answer,

reg 1,  in which cases the server should increase the seqid in the
delegation stateid then?

Another question regarding locks, in case the client has only write
delegation stateid (for example while using WANT_DELEGATION or
OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION), which means he can cache
opens and locks, in case of a recall -  the stateid of the opens and
the locks will be the stateid of the delegation ?

On Wed, Aug 14, 2024 at 4:14=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2024-08-14 at 08:46 +0300, Roi Azarzar wrote:
> > scenario 1 that I tested - 2 opens from the same client different
> > owners (pcap attached).
> > I'm wondering what should be the behavior in case the server received
> > 2 opens with access read with want_read_deleg.
> > I thought the server should give the same delegation state in the 2nd
> > open and increase the seqid but I see the server doesn't grant
> > delegation at all, can you explain it please?
> >
>
> An open stateid can only have one owner, so when you issue the OPEN
> request with a different owner, the server has to issue you a new
> stateid.
>
> Delegations are a bit different, since they are issued to the client,
> and not to a specific openowner. The server will not issue more than
> one delegation to a client at a time, which is why it didn't issue one
> here.
>
> > Another behavior that I'm trying to understand is size,change  attrs
> > in cb_getattr, I tested the following scenario:
> >
> >  client 1 open for write
> > client 1 write
> > client 2 do stat on file
> > client 1 write again
> > client 2 do stat on file again
> >
> > Each stat caused the serv to send cb_geattr but in the response from
> > the client I saw the same change and size values, can you explain it?
> >
> > both serv and client versions
> > >
> > > ]$ uname -r
> > > 6.10.3-custom
> >
>
> That sounds like a client bug.
> --
> Jeff Layton <jlayton@kernel.org>

