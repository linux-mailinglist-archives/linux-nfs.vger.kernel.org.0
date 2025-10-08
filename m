Return-Path: <linux-nfs+bounces-15053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD8BC57AB
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A9319E1309
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABC2EC562;
	Wed,  8 Oct 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqCOyJXR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A32EC09A
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934975; cv=none; b=RIQZaCLpmnmvITtu0frwkeejUd2PaUfGixCr+dhmycQDMyEAMv6sE2BHECYXkJBylrFmYfr3uLUHUgwrx6EJn9TkzaYy/vcqxwwpkrMfv5PmHG88YQvBDN0UBxqqJYp4998xbT3dTPsa09sKtY9X0JPwYtI/17Bdz4hn8gFjX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934975; c=relaxed/simple;
	bh=2oz4055tSs+ZLXmvAtmckJ9z5uGepgRmiB+RNzcDoZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXuNOb02ctI4fSvwPBOLmR0E/KMfo6hk6SZHgF353n3u0DzDw6Adu8H6KKO335mz/ZxaJ/KtoOnhsnqAxKNVf3nR5YnTsqbHvqgF7upvUtS+H5LWC9luejHFehrQu3mMUcitpqE6Xf0g9uE5UmYpo3EJmT/bR7hr9ljw7XlB66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqCOyJXR; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-633be3be1e6so1539666d50.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Oct 2025 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759934972; x=1760539772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcyaXLUPShgmIDCl33cHm/vwKuNgk2xrFWZ6LINoljM=;
        b=fqCOyJXR+xxnYM34HBhJfbxalqBTWYYIDFA+INmQykJpkFZ2+KiTrqJ/37pyAP1FTx
         QlJx8tvA647GFwCJ67FOKkbmfKemsC7wvb6Mmeyc7WAg7lwbLD4APo0QhX+thwdZfO15
         vjpKl+7JkxbvcXHcuKjd3OSbPi2Oexpgf2EyGluNjgcYIe9TF3PbszAWxOUjXjF61PUb
         7YWOA+Dt8NK3nhuUHwe6P5K3tduixazIORhkGl7qptxKpKMxXOxPhY945iLxMuzptFeT
         +d/K6kG8Ejda4+Z1AoA7rJhTpUmbsgbhaHv5ss7JpcVxm4Qc6gyOuVff8xPtMDsKLEn4
         /TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934972; x=1760539772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcyaXLUPShgmIDCl33cHm/vwKuNgk2xrFWZ6LINoljM=;
        b=TG8ButDxKojqBVBuz3Sfn85VHL8uQ/sPYesNQybG6oH+MBwTyHsDQpc4R6sPOErj5I
         mLGB62lm48GN1NY5bcyBw1UZpi3HoEneEhSGJ0wKMHcWZy3laGyhiWd8txwEZKe3tqkJ
         LWjoLVw8BKBpLEAwxQP56R+02UdDbbxequCGP3uvTK0grZr1SQmxiOO/BWSkW+GzwOk/
         ZiVJJSKyu0OIrnJEWwZyAWYWdaEb2GswJCVgugRmqECwz5VP3pei1vyzwdRyio/IBrpz
         LoUGLnp5yjzbj98djJtmEb/ZSRBbHRxF6YMUrZ34HwBX/pLAa3vsXqhwnLoHr8+ypi67
         md2g==
X-Forwarded-Encrypted: i=1; AJvYcCXIVJeJcvQq4e9fQwHsj6ha/cMDKC5mssX7QW/9tVsN3ItRyeVLBwjawSJ7MBYF/pniurLsHOzw6nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUQpLQ6AV1zRw6KHUAHvZ7zQSmYmmA6Cl2Il4udxxUP1/2/P0
	8i83zU0q5rOkPK3MvqZkT9vHnmPtbzpFfnieaOU21OGZaGAN+cGdrXHm44T0Q8su3B6M+WDwVlV
	TKKF6WzRChAQqFi4YHOTK+tYC3BnQObw=
X-Gm-Gg: ASbGncvpvEdT/4puc9yIVnz6BQZbq+bp9H1rp4cr9loZo7TP/4VX6t6DBuxFbZ80tRs
	JSUd9Eykp20PGs/0U8odFVJI9cZ372rp97usYtn6L92TqiSZw8v7B8vK0ME/1iMP4zwCJztN0Cm
	Ef/bA54xbrOpocNu1Nm6rTIluljQKxFxfXMAz10qEe3NTGFqszr8zyKXaApa3UAiMtrjZdKQ1UK
	NfI8QK1H6Qwo0q20owCnds0JcM2lFKH4iJRRMsaK3okbQ==
X-Google-Smtp-Source: AGHT+IEEvRqkuJ82Z/1uDguuR+kVgtpAwObB6vWeI3q8N/eP1FxDL09AonZPB36dClmDoJcAb7GULptIPduQRTZOjdw=
X-Received: by 2002:a53:b847:0:b0:635:4ecf:f0ce with SMTP id
 956f58d0204a3-63cbe14cc08mr6282876d50.26.1759934971823; Wed, 08 Oct 2025
 07:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121100539.605818-1-jimzhao.ai@gmail.com> <20251007161711.468149-1-JPEWhacker@gmail.com>
 <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
In-Reply-To: <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 8 Oct 2025 08:49:20 -0600
X-Gm-Features: AS18NWCpKHFseMz7HnNNaZWGPOtA5ZcFiGPgcQxn7wnVm-h7S75ViS7O41MSTZM
Message-ID: <CAJdd5GY1mmi83V8DyiUJSZoLRVhUz_hY=qR-SjZ8Ss9bxQ002w@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
To: Jan Kara <jack@suse.cz>
Cc: jimzhao.ai@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 5:14=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 07-10-25 10:17:11, Joshua Watt wrote:
> > From: Joshua Watt <jpewhacker@gmail.com>
> >
> > This patch strangely breaks NFS 4 clients for me. The behavior is that =
a
> > client will start getting an I/O error which in turn is caused by the c=
lient
> > getting a NFS3ERR_BADSESSION when attempting to write data to the serve=
r. I
> > bisected the kernel from the latest master
> > (9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). =
Also,
> > when I revert this commit on master the bug disappears.
> >
> > The server is running kernel 5.4.161, and the client that exhibits the
> > behavior is running in qemux86, and has mounted the server with the opt=
ions
> > rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,sof=
t,proto=3Dtcp,port=3D52049,timeo=3D600,retrans=3D2,sec=3Dnull,clientaddr=3D=
172.16.6.90,local_lock=3Dnone,addr=3D172.16.6.0
> >
> > The program that I wrote to reproduce this is pretty simple; it does a =
file
> > lock over NFS, then writes data to the file once per second. After abou=
t 32
> > seconds, it receives the I/O error, and this reproduced every time. I c=
an
> > provide the sample program if necessary.
>
> This is indeed rather curious.
>
> > I also captured the NFS traffic both in the passing case and the failur=
e case,
> > and can provide them if useful.
> >
> > I did look at the two dumps and I'm not exactly sure what the differenc=
e is,
> > other than with this patch the client tries to write every 30 seconds (=
and
> > fails), where as without it attempts to write back every 5 seconds. I h=
ave no
> > idea why this patch would cause this problem.
>
> So the change in writeback behavior is not surprising. The commit does
> modify the logic computing dirty limits in some corner cases and your
> description matches the fact that previously the computed limits were low=
er
> so we've started writeback after 5s (dirty_writeback_interval) while with
> the patch we didn't cross the threshold and thus started writeback only
> once the dirty data was old enough, which is 30s (dirty_expire_interval).
>
> But that's all, you should be able to observe exactly the same writeback
> behavior if you write less even without this patch. So I suspect that the
> different writeback behavior is just triggering some bug in the NFS (eith=
er
> on the client or the server side). The NFS3ERR_BADSESSION error you're
> getting back sounds like something times out somewhere, falls out of cach=
e
> and reports this error (which doesn't happen if we writeback after 5s
> instead of 30s). NFS guys maybe have better idea what's going on here.
>
> You could possibly workaround this problem (and verify my theory) by tuni=
ng
> /proc/sys/vm/dirty_expire_centisecs to a lower value (say 500). This will
> make inode writeback start earlier and thus should effectively mask the
> problem again.

Changing /proc/sys/vm/dirty_expire_centisecs did indeed prevent the
issue from occurring. As an experiment, I tried to see what the lowest
value I could use that worked, and it was also 500. Even setting it to
600 would cause it to error out eventually. This would indicate to me
a server problem (which is unfortunate because that's much harder for
me to debug), but perhaps the NFS folks could weigh in.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

