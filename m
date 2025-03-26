Return-Path: <linux-nfs+bounces-10907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC33A71872
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ECA3AB952
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B04A29;
	Wed, 26 Mar 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="corAm9gF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC61E1020
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999208; cv=none; b=Q2L6yFUIQyysTdZTNmJb6R5yFrsOJwpd9z5ZvN1ZOLQDXSjMEQBVelPvEgSw2B4amDL8ogovM20SxVAAvBt5VCgCrnGfmL8uYpTjNMStIhCb2Ju2M7Wkk41NzMqEnq+SaIOru9mQgRdunexHrSK47bLzZLefLII1nWfXpmICaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999208; c=relaxed/simple;
	bh=EdB6BGoeUfGRQ5w83BTygiYfvlVXHni8lDMtJ8kYvH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SlBWzFuDReZzuj8peQFuKduvr5Yw1h1JLQ3ZIs9kv9Wh4/Mfs25ORDQ0uSVZxg2n1gMN77Pg2s4Pgi4ekP56tACnU5akuFtWiiOgcdlIQAL91bs4WbxnjrDyOTK5mn59VrqN0B912M2AUTiR+iGX+3GEONLoM87LEC7hedWgMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=corAm9gF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso1243799366b.2
        for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742999205; x=1743604005; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbO8xfG/9JTXO3+cec9iQTUA6UfbOd0I8jG2dHLWJnM=;
        b=corAm9gFxhKvWElHO8jdM/OJaXU8hQJMWCcdeTwQnhEAYObQWH+3VhU0Ssph5eMOLo
         cbWz3vh1Lc6bcYZ+vHxN76khwXJ5OCc7SYnVzb3Aw56q5MG8bOXpHGoxw965ljomOxYr
         8RFfSVDeV5suYh6IlQ56alUEzjZIMvM5dDO5kD3Bq91eEjm0ritd5ULqwngcfOaWiToE
         FA4uUvubEkfBJVnbt5L/VQ1c+fmaVLAYPu85V7CQVIRkH0Rynf3m+uBJjn7NTFgkekcA
         rq2BUVkrPljv5TYAQCCZhJ9fogDSporOW82gwQQ0q7NgJCEcbHJl1YzrJ1XZpJhZlThU
         y7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999205; x=1743604005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbO8xfG/9JTXO3+cec9iQTUA6UfbOd0I8jG2dHLWJnM=;
        b=MEYJZG7mHps1+KIEcR6qZ/PFeMRPFQE5IlRntV/KWV5HaEkWF2QomUxTt3aZX1FPJp
         TodaVETNRDVQ+zCEqBp9vQqOMNP4C+K9Sj7KxHUh+ec6csKM46lIS25TwNjNb0iXiWnq
         x868RZyOX0zOe4waFP1LTrJjR8F9pzmfCKFhLzyFlLRkGhO309A3V6SA+gRmLD8ULQpx
         o+9wVEHlOnj8qK7j6O4C9/ViMrC72d8XetoiTQ28dk3ds0P/VUmLq3Sx5gnZ47Emldtx
         la0jSraKnfsH0kEvpGONljuYFRcP100zwfhAEQjee9mN6uSz8hgUJpartAHwQ+pv41Aw
         6d+w==
X-Gm-Message-State: AOJu0Yyyy5TSsZD1Gn899EHTwtBdSfFuqHRLQVgiZGUHpgyBLwqYhP7b
	HdG2ETPDkiiOBL/Bk14IwbStXf0977YXQiEhlOO9C3SqWqym6rx4pbc5h2sDka6lglpbTms+saE
	xdMaVhZlf887PhwqIFqAQK8N2VuN2T5oCK4U=
X-Gm-Gg: ASbGnctLRfXUBPc9Td5J4e3BINiMcwmj1yxMdpHq9P/DT6OFrv55oOMI6wIX0sxWPxE
	e+mFEqK+T72YZLMYKwWrWwWmTJ8YM393qnLxCJcLrkdEBja3RRub6GWpz8QfYy7Tjf4c5494Vzu
	8kcnnQTjwR+cOXpMk4EMpl4aVqrw==
X-Google-Smtp-Source: AGHT+IGubAXNPddWILxEEhJsu92O3oUAH8PDd4HVp41API8H8f2EXUpaNBQTwt50fyKxUqC4mnpj5ojfSVz9KlHjxqU=
X-Received: by 2002:a17:907:2ce3:b0:ac3:17bb:34fc with SMTP id
 a640c23a62f3a-ac3f2530bb2mr1962925866b.52.1742999204701; Wed, 26 Mar 2025
 07:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6NoWzPikoEtbVN1esw9d5KDgfOfds1iLfpUNeFcXzaA2w@mail.gmail.com>
 <9324cfc2-4a74-4577-bcfd-704ffd25240d@oracle.com> <CANH4o6Pq1Snhyk9sFeG5sdZ1LKekpSOrLb0Hc-sb-5wSDPDA4w@mail.gmail.com>
In-Reply-To: <CANH4o6Pq1Snhyk9sFeG5sdZ1LKekpSOrLb0Hc-sb-5wSDPDA4w@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 26 Mar 2025 15:26:08 +0100
X-Gm-Features: AQ5f1JrnXdIaRHyytOiTP1mtvIICrxRe7MFCZjG-eM5sCpjHmjg3rxVa_niw2To
Message-ID: <CANH4o6MOtoQPZp7=5KV+o_42++XKqTUPpGVgtOOwS0eVDQaTNg@mail.gmail.com>
Subject: Re: pynfs tests for NFSv4.1 OPENATTR / O_XATTR?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:16=E2=80=AFPM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> On Tue, Mar 25, 2025 at 9:03=E2=80=AFPM Calum Mackay <calum.mackay@oracle=
.com> wrote:
> >
> > hi Martin,
> >
> > On 24/03/2025 2:29 pm, Martin Wege wrote:
> > > Hello!
> > >
> > > Does pynfs have tests for NFSv4.1 OPENATTR / O_XATTR?
> >
> > Yes, have a look at the "xattr" flag, the XATT1=E2=80=93XATT12 tests, a=
nd:
> >
> >         https://git.linux-nfs.org/?p=3Dcdmackay/pynfs.git;a=3Dblob;f=3D=
nfs4.1/server41tests/st_xattr.py
>
> No, these are https://datatracker.ietf.org/doc/rfc8276/ FATTR4_XATTR_*.
>
> We need tests for NFSv4.x OPENATTR, the alternate data stream support.

... also known as "Named Attributes", specified in
https://datatracker.ietf.org/doc/html/rfc5661#section-5.3

Thanks,
Martin

