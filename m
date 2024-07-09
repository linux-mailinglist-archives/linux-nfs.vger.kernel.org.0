Return-Path: <linux-nfs+bounces-4752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867092BEB1
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E620F1F22805
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD01DFCF;
	Tue,  9 Jul 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SavzbhcU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AA19D8A2
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jul 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539954; cv=none; b=OsaxGnVBWhf2q04MiSE5rPdxaobVucDNH5svSLDDZ1elDtU8Tck/zF7Lsm51y55HZop6fSvqIWWIS2locSrhUjdLzLVIAUhMG5vXdOrkm4iAFo1YR1m4h/iddIrK2ecerWVu9zM9DJ+0CjxvAiEu6PTpKRqojJhlBGtG+U01Ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539954; c=relaxed/simple;
	bh=7MIZDTvWJQDMEFTPhJwLGYKTJfZ055xD0aePFvQkAA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV9mkbFe7UbU4bClIEqPNSICu4Va2aFyuzs2Z2FkZ7NYgB8m9U8S13PU678sbPI54A18UOQBth7CaI0ew0GjW3o3GN91XxeGC+tr6qHc5Xdq1o0ulF8oD3YrxmmtWBs2iQWF6Q4ufZbcCdz3DQK2ezsBC9Ke2Fk8zIOUxXuftfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SavzbhcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720539951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flE8fOMTLGKk8D0DK+akRh096z9u4VqC8VojxO2wgXQ=;
	b=SavzbhcUvDepBZC82eYTtmlqqIzxHrYOH6HYt+bPyxyNWJdlfXZnFrouRl3QDMMdU6WbsI
	+mZmNs5Sye1L7QNU7ltJxxU/WvMLUR+WR2v6UtO4XhPEY5BMVYeRvgowzE7+njhlZ8wult
	LIwnAsTEaKudHacgC5q8BTIxe9ZcwuA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Xgf2FnYWOL64r4WIFiS9Kg-1; Tue, 09 Jul 2024 11:45:50 -0400
X-MC-Unique: Xgf2FnYWOL64r4WIFiS9Kg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c9fca572adso1737530a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2024 08:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539949; x=1721144749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flE8fOMTLGKk8D0DK+akRh096z9u4VqC8VojxO2wgXQ=;
        b=KTNdl4wTsCnj+5DbYWgDGXjbXRcHdTplAA1dLasaC9qxFsNB1Bunql1rhIwICK7FGy
         Nraec7cGuE1Mc2mkJKMGM+Wgk5Ys8xenYihLoaWN3S1btfxoH+d3izfE87Qgo14x3gDN
         jRroa9aPrJF6fsxfytSDHZS/ucF1wfZsbcKGMLn2x8cz12+95g0ld0xIHsA3VbLvNUot
         eeIWXuw0RoxrrrvgdfpQIm4dn2HyIOvPvvD27wmb8yZdv14683reXLbKVM/xV0XShO6q
         Uhlt1CzaHoO0kQ6FGmDc5AICLUTN7ABERgcfIwMii97Hzm3bFNFBKeJewzjiFO9jI92P
         PLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlaQh/l4NbtZk2rcwtG6xVlRKEMj09xSOiV8c0/lFflyxo8Y0ItlvJ3B+FyoT0gmMfm+o6Ow8TC8gBV4AvuFOqHwPD+mAOsbGb
X-Gm-Message-State: AOJu0YwxUrdjoIBt6JvxedBe9l++wMVtI8rV888hrWsYelUFVMdXfy7h
	crMxWuZvVrd5IphO6tmV5go6t0jLXtaCxSGBL9s4vahYd27R0yUy7zIKrwopoF07nW86uIexOUk
	q94qmIWlWqabVVj7j9gFr/0ii1Mb5kXY4TbIvGnuvVw4DnRUBUO5X3WDXy09l3wxchjKm1JTufc
	kzoKe3Ps3INjx3gzzQMaEmvC1uC5l1WWTu
X-Received: by 2002:a17:90b:8d:b0:2c9:99e4:51bd with SMTP id 98e67ed59e1d1-2ca35c822fdmr2570857a91.29.1720539948997;
        Tue, 09 Jul 2024 08:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7jyvJW2v2DDUKTP4r8H17C9rsds6AoxWKLZ0QBDUFwOZf4FeewwqkXD6bu0HJDDA6m1GxAhXIGsJPiD8pivU=
X-Received: by 2002:a17:90b:8d:b0:2c9:99e4:51bd with SMTP id
 98e67ed59e1d1-2ca35c822fdmr2570843a91.29.1720539948704; Tue, 09 Jul 2024
 08:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C225EF84-ED3A-435F-B90D-7A5EF6AC8430@oracle.com>
 <CALF+zOkKf=5YcSZg6OyYHFzTqL3Fktzch95PQ9UOB0SDzqFZgg@mail.gmail.com>
 <DA939E32-2E25-4EDE-BC25-2D5E50F4B711@oracle.com> <CALF+zOkwYrZcen=xat9nQ_EhOcfRFdLji56nrXsqWh4w_3RAHg@mail.gmail.com>
 <ZoTc3-Bzfr-gY4-o@infradead.org> <FF24B77F-638E-4F31-ABB6-B07D48AF73B4@oracle.com>
 <Zof5c_eQE3bRn6PR@infradead.org>
In-Reply-To: <Zof5c_eQE3bRn6PR@infradead.org>
From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 9 Jul 2024 11:45:11 -0400
Message-ID: <CALF+zOmzGNrovLCojgXUku4dV8p1r9gz8EDUVvBa6DC2BRqY2Q@mail.gmail.com>
Subject: Re: BUG in nfs_read_folio() when tracing is enabled
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Dave Wysochanski <wysochanski@pobox.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:48=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Jul 05, 2024 at 01:45:11PM +0000, Chuck Lever III wrote:
> > So Dave, I haven't tested the patch you posted a couple
> > days ago, because there hasn't been a clear answer about
> > whether nfs_read_folio() needs to protect itself against
> > the ->mapping changing, in which case, that's probably
> > a better fix.
>
> ->read_folio is called with the folio locked and only unlocks it
> on I/O completion, so it doesn't really need any protection.  So the
> patch to simply move the trace point to before unlocking the folio
> should fix the issue.
>
I didn't see this so maybe you sent it privately or I missed a message.

> Alternatively we could just use the mapping from the inode variable
> and pass it in.
>
I'm not sure I follow - are you suggesting fixing the tracepoint?

Regardless of possible tracepoint movement or other fixes,
nfs_folio_length() needs to be patched because it should
handle folio->mapping =3D=3D NULL.  Ditto for nfs_page_length().


