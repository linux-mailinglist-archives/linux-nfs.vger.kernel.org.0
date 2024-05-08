Return-Path: <linux-nfs+bounces-3215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E388C0478
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2781F2061B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66A523D;
	Wed,  8 May 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD1liXR8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D123B646
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193234; cv=none; b=k33LbPI8KEOflYT5Q9MrvS5PiTvpKGkWCQpusDUlB41jrVq55/HykjYB3WcDBWR6f8p0vAU13Lg1KzWq/mj0XH5WpPz5QG8AljjQRza+bJfWpcARHUHL54LnFsmT1vpS1bI5Fyqveox51W/nTOUFNZuX0/+e0A+pYXHJOAWEV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193234; c=relaxed/simple;
	bh=g+HqJ1CUvm4VzzbLp0xkPWXNOPb0l89O8Jev7OdD3Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6kGzUe0KU4m3Tzz4/+mau1fiGm1ioo6I1/JYQtd2BNMKrKfNv1e32Prn5F1bwA84Kip1bBYEQ7tfTKcIe8xPlomNMhBdDnGI3IrK9etl8+Sn7Fdo7UThdauhjJYjfpXXBXNJO7u9mCKen+wFyqaEBSjwQ1A+W+IusnfNMhYJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD1liXR8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bL0EjI2dQeSOH83oHnaf1GJRQWnFFLnWwURRR5TuDx4=;
	b=PD1liXR8Yjz1tf9fzv+uXFF+bhJwM1p+pfvZdnaEAkHoHsnOgLYr+Am8K/6Ch1IqjjnSuy
	sT9HssgI5dgOtd9Bl6I2Jk2AiSrZZvXz2aZ8YCiDgtAAbo2Hgrq2h1aJuT5ONj0xiIsUsQ
	drbve2F6rFECU2Vnb7UCxzUDqfJ5mUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-0HIehfqKMwOjNE2z5757Xg-1; Wed, 08 May 2024 14:33:49 -0400
X-MC-Unique: 0HIehfqKMwOjNE2z5757Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99290185A78E;
	Wed,  8 May 2024 18:33:48 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 984741C060AE;
	Wed,  8 May 2024 18:33:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS/filelayout: fixup pNfs allocation modes
Date: Wed, 08 May 2024 14:33:46 -0400
Message-ID: <B3A3E63F-E8E4-4B59-B833-7D1BE8938F52@redhat.com>
In-Reply-To: <CAN-5tyGNaWsfxo0dCGc+hW36Q9jSZXaQZgvHTOw5gGQ_HDxFqw@mail.gmail.com>
References: <20240507151545.26888-1-olga.kornievskaia@gmail.com>
 <35158E21-2724-4C1A-950F-5A6A616C862A@redhat.com>
 <CAN-5tyGNaWsfxo0dCGc+hW36Q9jSZXaQZgvHTOw5gGQ_HDxFqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 8 May 2024, at 13:13, Olga Kornievskaia wrote:

> On Wed, May 8, 2024 at 11:25=E2=80=AFAM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
>>
>> On 7 May 2024, at 11:15, Olga Kornievskaia wrote:
>>
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Change left over allocation flags.
>>>
>>> Fixes: a245832aaa99 ("pNFS/files: Ensure pNFS allocation modes are co=
nsistent with nfsiod")
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/filelayout/filelayout.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filel=
ayout.c
>>> index cc2ed4b5a4fd..85d2dc9bc212 100644
>>> --- a/fs/nfs/filelayout/filelayout.c
>>> +++ b/fs/nfs/filelayout/filelayout.c
>>> @@ -875,7 +875,7 @@ filelayout_pg_init_read(struct nfs_pageio_descrip=
tor *pgio,
>>>                                                     req->wb_bytes,
>>>                                                     IOMODE_READ,
>>>                                                     false,
>>> -                                                   GFP_KERNEL);
>>> +                                                   nfs_io_gfp_mask()=
);
>>>               if (IS_ERR(pgio->pg_lseg)) {
>>>                       pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
>>>                       pgio->pg_lseg =3D NULL;
>>> @@ -899,7 +899,7 @@ filelayout_pg_init_write(struct nfs_pageio_descri=
ptor *pgio,
>>>                                                     req->wb_bytes,
>>>                                                     IOMODE_RW,
>>>                                                     false,
>>> -                                                   GFP_NOFS);
>>> +                                                   nfs_io_gfp_mask()=
);
>>>               if (IS_ERR(pgio->pg_lseg)) {
>>>                       pgio->pg_error =3D PTR_ERR(pgio->pg_lseg);
>>>                       pgio->pg_lseg =3D NULL;
>>> --
>>> 2.39.1
>>
>> Looks fine, but I didn't think you could get here from rpciod/nfsiod
>> context.  I might be missing something, how did you get here from ther=
e?
>
> I have to admit I don't fully understand (if at all) the implications
> of having the wrong flags. I also don't follow what you mean by this
> code not being executed by the rpciod/nfsiod context. This code is
> done while doing (buffered) IO and performed by the rpciod context?

I was thrown off by the Fixes: tag. The nfs_io_gfp_mask() doesn't have to=
 do
with that context per se, but rather if we're in writeback due to memory
pressure.  That's what the PF_WQ_WORKER check is for which Trond explains=

this commit 515dcdcd4873.

> In truth I was making it consistent with what flexfiles is doing for
> their pnfs_update_layout() usage.

Gotcha, makes sense to me now, thanks for helping me.

FWIW:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


