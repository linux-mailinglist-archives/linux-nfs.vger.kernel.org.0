Return-Path: <linux-nfs+bounces-15507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B492DBFB963
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF44EEF0D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B53314CD;
	Wed, 22 Oct 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtZ7IAcJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA30330B29
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131810; cv=none; b=hXcOnAjarnruGKAQC9XaTVzq42h2uPhizyDJNmSNph7IgnO295C2lJmSQLyVYZGXT4pfOnTHMTjdFDB2lxm4Q2zp7tSXt55cWygyuqMtmjcToqTpIy6+HQ6S8be8HxHHaW/+QqjFQ2hHkCAn96FzEsu2w4J9CDCilTBXsAeCOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131810; c=relaxed/simple;
	bh=MkLx2R4aQDQRSte1k6rDu2d4S0+mLWdRZ24YtDib+QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUHUBZT69kMTh7jqUxOzMCGm5g7SgtHad97uq1z6F/mnEvBV3LjYLoEKOpFQOFTBe4TknIX42cgbeSxVk9p9M5CLc8DIZqIxtrmh8nTmvYJTkpFaUCNkEsxTnktqOLPphLFcOSWGPUCwzYUByCMVkc5deF534G84mAwoczLQDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtZ7IAcJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so12191386a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761131807; x=1761736607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=GtZ7IAcJ+qPUT1UbyjSQlczc/FYy37J5wFuyZSAtHhyN8k8n4AQCldnUC7PgsdQ/Ds
         nQ9DwjeO5G3bQs1dfBeP0ZiaA3kwUeIuVqrrrDMmpvXtbKgkoC3YE0aRj0MSiIIjOQfm
         O0h28Bn0E38Y8RxtcMLU6yN6BOzpM0KSZALGkq+kphNBZkwBB1zabOwMjBnSGgIYLHoj
         eAPCezGxDjNyexsTJwbVrWuZkI1m6S0PagwCbHBXelSO40N+BIGIQkNIso4gV9LZIKak
         obLWnXS/nhyY3mC2H1SbOaX1toSgPt/gVJdbgNTrfE1lwxxiFxCyYLdjYTyDgoYgd7vb
         Oc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131807; x=1761736607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUpfROanALk009O5ukzxUjqqmJACMBILWAOKJHciC34=;
        b=Qi1xkIb36XpnAvrlNuVrmAn6tR6BHAByIWFlf250SywLfhqv/Zk80fAqYRkvLnc1br
         1GLmTztMqV9VPr+aE7ZcnYT2vPK+WDzGpiiq+gDAN1eFysfFrWkL5uVsWhuQX8knyRBT
         V+YUC6JIRF/+MiV8PPjly/RXCh5S+tyXNZbVOLERE93hqFDJJXFQviT42F4PfK1p1/m/
         f+G9o7TQa376DshgZNxcHqg/tL78rBAKSgaGZL/7wDCq5B3ES9uV8R9SBT0eYn6I+oNC
         3nBc6h7z1rczoG+H7ZlmMTUg7sEpLkdwE5qOde6AVbrSenHVdVMD1aznJtAsNgG8QI6h
         XwJg==
X-Forwarded-Encrypted: i=1; AJvYcCXe5PRWIYKq2yNWBjg1lxgBryqOS7zBiQkTpVnGT2LIm23zwi/SqM8GdS6q24m7gaPZ+Ya8Y7A09h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmjVhMuM/XGuJ4V9p4LqxKQ11LwdEFxZ9Y0ewAU4x+kobWGZ5
	4Jfki5MbXTQo68xHYcj8UBwdq0RERjh8WwlEQmUQC1YEpWdSpPI+75REZO7I2K2FKyGoKFWoqcA
	hTN/b8BcezxXkqnYJAf1ABl5JfL5kzV7YkCkL
X-Gm-Gg: ASbGncuxNeV5nRUYGmLMQjnLxEFJ89MqCXW0rNEMrp660/5G6b81O2AZ5GPwL+D6U1X
	7IraS8NprV6oMXB/LvHVvIz1QizIa7W1OmdJZBSq+iQEb+gNHWz9Lnzf8VZk32kRKSNU7YFxyO6
	n1AveGhBAvt8FsUQ7pCRBS6MdEmUT3uX/4yXIqeGJxVXb/2wQZOLTxnSFGGVPZJl2c5zk2XNGEc
	fBxGDIkiO7JYGUcPLPlXLVsPxDkpW94WDBLrWYErFak8mignIZVee4kS8i0yl7bp1Rw1WyumfeW
	lRDhyt/y72F+K5t2mcLxkBC4pw==
X-Google-Smtp-Source: AGHT+IFeLMsqZpbHAvlJBzKIdahXOOBShjYQZyOY7ATbt5n7WHdXXR/ON08TB4hturxLMLEB0GOq3i/bLAd52DC8p3U=
X-Received: by 2002:a05:6402:13ca:b0:62f:8274:d6bd with SMTP id
 4fb4d7f45d1cf-63c1f626dd4mr21176233a12.8.1761131807215; Wed, 22 Oct 2025
 04:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-6-alistair.francis@wdc.com> <dc19d073-0266-4143-9c74-08e30a90b875@suse.de>
 <CAKmqyKNBN7QmpC8Lb=0xKJ7u9Vru2mfTktwKgtyQURGmq4gUtg@mail.gmail.com> <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
In-Reply-To: <4b2e5998-a646-4f99-8c87-95975ff8fe66@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 21:16:19 +1000
X-Gm-Features: AS18NWBDgW-hay2VUeCdIjfUCzoI0NhxABO1jEUfCaPHUmJ8eBnU71SyICyiPWc
Message-ID: <CAKmqyKM-uX6_a+Ru01RD3-CwoucTN7P_sU+d=MEKSo2pxG_tDA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] nvme-tcp: Support KeyUpdate
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:56=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/22/25 06:35, Alistair Francis wrote:
> > On Mon, Oct 20, 2025 at 4:22=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> [ .. ]>>> @@ -1723,6 +1763,7 @@ static void nvme_tcp_tls_done(void
> *data, int status, key_serial_t pskid,
> >>>                        ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
> >>>                key_put(tls_key);
> >>>                queue->tls_err =3D 0;
> >>> +             queue->user_session_id =3D user_session_id;
> >>
> >> Hmm. I wonder, do we need to store the generation number somewhere?
> >> Currently the sysfs interface is completely oblivious that a key updat=
e
> >> has happened. I really would like to have _some_ indicator there telli=
ng
> >> us that a key update had happened, and the generation number would be
> >> ideal here.
> >
> > I don't follow.
> >
> > The TLS layer will report the number of KeyUpdates that have been
> > received. Userspace also knows that a KeyUpdate happened as we call to
> > userspace to handle updating the keys.
> >
> Oh, the tlshd will know that (somehow). But everyone else will not; the
> 'tls_pskid' contents will stay the the same.
> Can we have a sysfs attribute reporting the sequence number of the most
> recent KeyUpdate?

Why do we want to reveal that to userspace though?

Realistically it should just be ~2^64 and it'll should remain the same
number, even after multiple updates

Alistair

> Cheers,
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

