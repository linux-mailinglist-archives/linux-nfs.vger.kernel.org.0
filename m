Return-Path: <linux-nfs+bounces-13192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1A1B0E3CE
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD0F3A6CBF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87080034;
	Tue, 22 Jul 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGzu485x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386217E4
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210919; cv=none; b=DnpCtOCrruawz397o7S185gIbwYvM5Vfab/gNRMruy1plE2+K4K4F9nIcXO01rAy1BJXDA0ZoaV974GpQwHdjxrhAn8BfRITsbXUiyioAv418IyFnqoHB0f5CywroXvAkq2xwaHqK2F8uqckuHDZNXJuj594wCyOGgdg0uscSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210919; c=relaxed/simple;
	bh=gCQMpx3FzXCzes40CWBGpPZFyV1A+BWjLjEtHDLIKgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROoXRVwFwjd0O3AwNqQRXwSWzfOTBRfbZwFrbSro3t5LhN7hXdJQUGVnoi2am/tQREhKDPZ4s9rRWKuUJxCGxu/WRqqLY0aAb9phf0BrravaBlrtH5uCCpn/gpTYTPwqN1IW6AgUc5BTom7qc8akol13erGfbb80JO6tVgXmXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGzu485x; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710e344bbf9so55774057b3.2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753210917; x=1753815717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km+j2pXjtdNbBacSfY8bqK9X+6zUBCQJVka5EpGl7ms=;
        b=CGzu485xQR5mr9lqSNZXLwUQJXBMv2tpWZsiovStjwFcPGIlfFc6tFHWmCgLCvV2hC
         wtuai1yxpmfQuWRlb+wX+/BUSfyUNpa4FmuHYd58CGJancYtbgJb5ErCEq4mgHP1Gl5z
         oHz5yNlr6AkNl2eHpOMw+dGyj4A4GxLM0AshIB9G6CcsoxT2mMGpufFH9qn3E37LXPrU
         BwjDyW9Y1us6ROJcxN1S1LOk5GK2CzYoYT6d7F4vcasK+UyFvmB1AKbF/AYDE9XDsKKl
         GkS1Arvl9Jo5dGAjUsV8SjqfBn1hAeCbIxuJEUnDfU59gR7J8+zkwiDIUEB7xFgr1g2U
         xCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210917; x=1753815717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km+j2pXjtdNbBacSfY8bqK9X+6zUBCQJVka5EpGl7ms=;
        b=O2B9dYRmAPebXL+0/hMUIE559MZMY7qVcTVNVWjB8PrOzwnMLPLa+rh7acJqaxzEth
         bGLA7WAVRQ2etPTUlmWOEdugPpFQ+paPsvzyLX4JcfZ9+v/HF2BiWqfbGzZ1b5DR+Ra9
         8CRwFf8LMGAmbZzxEZlwbDwlKin9LALt9KPp9t8WQZiIz7cbEKpkQP3aJz+8nl6psIub
         tegA3G03YKTgphEQbbBH4FJOu1McA5/GWV5DJXjArcKT5Bal9OKhK5zfk2AZAkHtBlbC
         R5X6Np2caZD3r3P6glNIuR85dqXLOePQUhhBp5ECz6RfLOfBuiTRNe/xBQ1WRROjrgZ1
         Qrog==
X-Gm-Message-State: AOJu0YywKmWfv8cafGGVNkIWbIH6KnVC9cimfyRpvVytzxjcz9R3dC46
	c1pAWOreD2RwerF/fXgeNSRq1Wjb3pkzHLxGDutSnCCZBnxdZCLQHbwrSFchuj6Wg9DoW6FbA6W
	nUIVgh57O3RacO4p4d8lRPR2Ss9oYAa2/7e2F
X-Gm-Gg: ASbGncutdPp81xhJZnaSp0oBtNpBoxtHl1y3VuHZiB18f3But5PYwz5beY0qZ5gzhNO
	nw27qRUINNJv/ukXS2Fbw7ueUaVrT+DDKa5vfWTrYJauK4uSm3E7x0xXfzl4jc6tHCA1SkcGUJe
	oQ19neeho3LYywUrQyvYYneZy5N2PwQrxeGlGUHu+7tC/1UQgHAb/iDOKQZFm7I7MO4nmhSZupY
	s9LKO2b
X-Google-Smtp-Source: AGHT+IFt8P3LY60W5TA693Gr5Eh4NKnw7KU+DCvtsJc06Ovy4iV45dh8oMRVSccuUEmzpADQGJ/pbdtsO3Y3O4EQfwQ=
X-Received: by 2002:a05:690c:6a07:b0:70d:f15d:b18f with SMTP id
 00721157ae682-719b422710emr3874717b3.26.1753210917009; Tue, 22 Jul 2025
 12:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjqvKAE_dUiCTr8D5UShNK5fxJuUHpP=nDFadF-OYhYbfw@mail.gmail.com>
 <76c35f2fc9386f3e77defe87375c4ad110618aaf.camel@kernel.org>
In-Reply-To: <76c35f2fc9386f3e77defe87375c4ad110618aaf.camel@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 22 Jul 2025 22:01:47 +0300
X-Gm-Features: Ac12FXyFX97ZLokMk9bWWndXjA9kML9UB3JXdtMNWo4s6ohF8sm5li0ulUuT3qE
Message-ID: <CAAiJnjrmeZUexNkJJmvuUDKvTqvuQhahWY2uFhOgBOmoLrLbLw@mail.gmail.com>
Subject: Re: nfs client and io_uring zero copy receive
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The only way you can avoid memory copies here is to use RDMA to allow
> the server to write its replies directly into the correct client read
> buffers.

I remounted with rdma

[root@23-127-77-6 ~]# mount -t nfs -o
proto=3Drdma,nconnect=3D16,rsize=3D4194304,wsize=3D4194304 192.168.0.7:/mnt
/mnt
[root@23-127-77-6 ~]# mount -v|grep -i rdma
192.168.0.7:/mnt on /mnt type nfs4
(rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard,f=
atal_neterrors=3Dnone,proto=3Drdma,nconnect=3D16,port=3D20049,timeo=3D600,r=
etrans=3D2,sec=3Dsys,clientaddr=3D192.168.0.8,local_lock=3Dnone,addr=3D192.=
168.0.7)
[root@23-127-77-6 ~]#

and repeat sequential read.

According to perf top, memcpy is gone,

Samples: 64K of event 'cycles:P', 4000 Hz, Event count (approx.):
22510217633 lost: 0/0 drop: 0/0
Overhead  Shared Object                      Symbol
  13,12%  [nfs]                              [k] nfs_generic_pg_test
  11,32%  [nfs]                              [k] nfs_page_group_lock
  10,42%  [nfs]                              [k] nfs_clear_request
   5,41%  [kernel]                           [k] gup_fast_pte_range
   4,11%  [nfs]                              [k] nfs_page_group_sync_on_bit
   3,36%  [nfs]                              [k] nfs_page_create
   3,13%  [nfs]                              [k] __nfs_pageio_add_request
   2,10%  [nfs]                              [k] __nfs_find_lock_context

but it didn't improve read bandwidth at all.  Even slightly worse
compared to proto=3Dtcp.

Anton

=D0=B2=D1=82, 22 =D0=B8=D1=8E=D0=BB. 2025=E2=80=AF=D0=B3. =D0=B2 21:43, Tro=
nd Myklebust <trondmy@kernel.org>:
>
> On Tue, 2025-07-22 at 21:10 +0300, Anton Gavriliuk wrote:
> > Hi
> >
> > I am trying to exceed 20 GB/s doing sequential read from a single
> > file
> > on the nfs client.
> >
> > perf top shows excessive memcpy usage:
> >
> > Samples: 237K of event 'cycles:P', 4000 Hz, Event count (approx.):
> > 120872739112 lost: 0/0 drop: 0/0
> > Overhead  Shared Object                      Symbol
> >   20,54%  [kernel]                           [k] memcpy
> >    6,52%  [nfs]                              [k] nfs_generic_pg_test
> >    5,12%  [nfs]                              [k] nfs_page_group_lock
> >    4,92%  [kernel]                           [k] _copy_to_iter
> >    4,79%  [kernel]                           [k] gro_list_prepare
> >    2,77%  [nfs]                              [k] nfs_clear_request
> >    2,10%  [nfs]                              [k]
> > __nfs_pageio_add_request
> >    2,07%  [kernel]                           [k] check_heap_object
> >    2,00%  [kernel]                           [k] __slab_free
> >
> > Can nfs client be adopted to use zero copy ?, for example by using
> > io_uring zero copy rx.
> >
>
> The client has no idea in which order the server will return replies to
> the RPC calls it sends. So no, it can't queue up those reply buffers in
> advance.
>
> The only way you can avoid memory copies here is to use RDMA to allow
> the server to write its replies directly into the correct client read
> buffers.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

