Return-Path: <linux-nfs+bounces-4044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312AD90E267
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 06:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C33283E3E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC934CB4B;
	Wed, 19 Jun 2024 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH2r3wVJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767F33CC2;
	Wed, 19 Jun 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718772269; cv=none; b=uwylI4Pvc2hKqDfT+3K10/vr/nkOZvjJ5MJoDff8feDj2O56vSWV5VWQu6kDSami8K7iBvmXeiMqAM1lV+6fNf2ALa0kO/uQ5oUQFC02Xjw2J2o8RXiDuYv3kXtu4BpLlgPLFEMndifAlY0uP6RekoaDqcfEGE30LS83yFj4ZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718772269; c=relaxed/simple;
	bh=KxmZuPxHi/39BukvlwpybJY4cd2F1hm7tXLqVHjFKqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOGb3CaFETU35r+P7OvG1kSN2YtdQM7/ovvoz0s3FWqsBfHQV8KKIQwgUmNu41L+N8phhd5J3Bzx2nIg0ZoZKqHFVKZZV9K/7sZbGbmh3fFbeWUWjrm3WBOU7C+NZsRgTxvm4yWHeC1LyjOxUQ7PyCdTudhsjZtyap25Oxg8hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH2r3wVJ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48c3402e658so2196655137.0;
        Tue, 18 Jun 2024 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718772267; x=1719377067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kSbyK4rfjsHEY+Lpbm26zgIzNqvsWdMEElHVTqPiyk=;
        b=PH2r3wVJivcIFc9QSnd7FRjrawpnqWFBv1xf2HcRSfj9+VWpY5i3YaZz8mEWxSAV3M
         Ry+uvmujcan71H8Wfd2BgZ2kokKtS/7GWiAjnyd+4mF+Zlz/U1CGrzxlq2190YaKKejK
         yy0MM87xaYNCnH5cPxv72EHZfxAhCeZAmSrMVu6xN4nmpXh02Jbt4aBZNuwz7p5pOSF3
         qXx+xjPkN3s37QapaAz/NHr5SE/p79qAb8v+F9/Z3pBvVvQxbyYIKaZg8rj/1ruzzn53
         bBRXwhaYhZtIe2cL9VcgvMpbEVj9nbPYmQsjfQjMOkYH7Bz/htKaFKOspFtq93b/XwDP
         cnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718772267; x=1719377067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kSbyK4rfjsHEY+Lpbm26zgIzNqvsWdMEElHVTqPiyk=;
        b=IYDGDXB36s9nbrYjWUAPoYpZi9AuG7iUsj6yDSys6owl2d1s/A74zOqP5WvCODUN8t
         +UT/0g7BS4ZAlxUyRx7KzWvOuKkkSi0QEfUhApJOBA0w/E5e88f9icbPZv98euwu+FiE
         YrC9YqrNDmnr7PAQW5LgKdgZl21PhPK48AJDj4bGd2hhFVt4DWO/h8oUbhvcaUq35o1P
         JpCLxz2kgrRK0aVmEkHJgeHk7x0EaMXci3pOnZsZchSXazOsF3zXRIlyvriNPlrP1RG/
         lQq7TaOtgw02A/inGq5/kZuX4a9mZI3RUROOc1AisedF/NPrDijBxkVX9QB/zVVOGT50
         m6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ovTN9f37NoGOC3g6YuRe62a8K6ILnu4VmWjY71YP+zi9fz1JsSp8Xvze7UtXdWYAk47jPGdc++dmz7KzLl7tOzbnw88Y9eAaAQn3PxAC+904hgmetmGZe02I/k0POa/B0A3L4yPrrekeaTOanYR3KHxv4kx54zKlYSd26A==
X-Gm-Message-State: AOJu0Yz220NGuOCgl+6dZwCc0Jex6phAXpYer6BQWKHc+JWlSCVK1w1g
	ptzQd8ii9qNf6OfFyKIl6n4TzBr35R1dEBsxBzHQWCgArtO9vZS2TMiXVuU2NQh2MD2dCXfOuHF
	7+iK/Dm9BTl4fcH7yKVhSyPoXTZY=
X-Google-Smtp-Source: AGHT+IHKzo6EwIMqUwbhmwNQAL3um1qjSrNKdFWC9jMclsciycNF3jZF/k86XZVVhAV16DzqmwIyXGJv7yyTrWsC5w8=
X-Received: by 2002:a67:eb88:0:b0:48d:943b:43bc with SMTP id
 ada2fe7eead31-48f130e678cmr1593329137.26.1718772266823; Tue, 18 Jun 2024
 21:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618072258.33128-1-21cnbao@gmail.com> <CAH2r5mtRHf3bQh=aeVddFykMX_MokqujMyLn3W-4wXo1MO5=iw@mail.gmail.com>
In-Reply-To: <CAH2r5mtRHf3bQh=aeVddFykMX_MokqujMyLn3W-4wXo1MO5=iw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 19 Jun 2024 16:44:15 +1200
Message-ID: <CAGsJ_4x9A5jHPOPiPhsznsCBnj_T-XRk8YNs86i11P9rmrPG1w@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: drop the incorrect assertion in cifs_swap_rw()
To: Steve French <smfrench@gmail.com>
Cc: akpm@linux-foundation.org, linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	sfrench@samba.org, anna@kernel.org, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hch@lst.de, jlayton@kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	ryan.roberts@arm.com, stable@vger.kernel.org, trondmy@kernel.org, 
	v-songbaohua@oppo.com, ying.huang@intel.com, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:48=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> tentatively merged into cifs-2.6.git for-next pending testing and any add=
itional review

Steve, Thanks! I guess you missed an email from mm-commits.

A couple of hours ago, this was pulled into mm-hotfixes-unstable, likely
for the same purpose. Will this cause any conflicts when both changes hit
linux-next?

https://lore.kernel.org/mm-commits/20240618195943.EC07BC3277B@smtp.kernel.o=
rg/

Will we just keep one?

>
> On Tue, Jun 18, 2024 at 3:56=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
>>
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
>> swap-space"), we can plug multiple pages then unplug them all together.
>> That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
>> actually equals the size of iov_iter_npages(iter, INT_MAX).
>>
>> Note this issue has nothing to do with large folios as we don't support
>> THP_SWPOUT to non-block devices.
>>
>> Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-spa=
ce")
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Closes: https://lore.kernel.org/linux-mm/20240614100329.1203579-1-hch@ls=
t.de/
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Anna Schumaker <anna@kernel.org>
>> Cc: Steve French <sfrench@samba.org>
>> Cc: Trond Myklebust <trondmy@kernel.org>
>> Cc: Chuanhua Han <hanchuanhua@oppo.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Chris Li <chrisl@kernel.org>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Cc: Paulo Alcantara <pc@manguebit.com>
>> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>> Cc: Shyam Prasad N <sprasad@microsoft.com>
>> Cc: Tom Talpey <tom@talpey.com>
>> Cc: Bharath SM <bharathsm@microsoft.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>  -v2:
>>  * drop the assertion instead of fixing the assertion.
>>    per the comments of Willy, Christoph in nfs thread.
>>
>>  fs/smb/client/file.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>> index 9d5c2440abfc..1e269e0bc75b 100644
>> --- a/fs/smb/client/file.c
>> +++ b/fs/smb/client/file.c
>> @@ -3200,8 +3200,6 @@ static int cifs_swap_rw(struct kiocb *iocb, struct=
 iov_iter *iter)
>>  {
>>         ssize_t ret;
>>
>> -       WARN_ON_ONCE(iov_iter_count(iter) !=3D PAGE_SIZE);
>> -
>>         if (iov_iter_rw(iter) =3D=3D READ)
>>                 ret =3D netfs_unbuffered_read_iter_locked(iocb, iter);
>>         else
>> --
>> 2.34.1
>>
>>
>
>
> --
> Thanks,
>
> Steve

