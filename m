Return-Path: <linux-nfs+bounces-13534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7234B1F641
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB87178A69
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531371B394F;
	Sat,  9 Aug 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mybqsThq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD6AD5A
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754773366; cv=none; b=GB71jEbQ6QGUU52HexlDqRg0OrMySd8daU4Rsf8M90d/aBs0Grb/cRnf2hoA2nNz3lzrzz0d8I7kjngSvvDBDC1aAU3HEcLAg82SZEHZRSs5OM2uxKisQquxVVQYHIb9qXM4fh4T/AR0XGUDq4J4RNY4T78PCJmXmRyJMMTb5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754773366; c=relaxed/simple;
	bh=Lr2PrgxYE81GaBtmTyOvqG6O90jRNKiZj+1BmcWBYdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeUiS8rQReEfSUwjYkZs9twMeUXTSTKVhTxK1ncDGKK/5x0ZVwoFYNodkpE87kDzFGCYmqL/LSSaSRIcsWdZ6qgvXsx+HgGha/6MGFGZS2YYB6KpedmphdIzosE9+315RGGTmUK0IJkdGyjty6KnlwoXdB6bQvgrP5eybf3H6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mybqsThq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af94e75445dso586067166b.0
        for <linux-nfs@vger.kernel.org>; Sat, 09 Aug 2025 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754773363; x=1755378163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZFSNuvUwMgn1IPIJxKTkMsooeskNeI0zv/uMTISkL0=;
        b=mybqsThq4AqWc4PBRjn4WI9X/iqb5XMLMB0XsnG77iU1uPQSWLnCFw/kfqUc3UYsKp
         aLUKhQlWYVNRM8Bn3gb0iuLBBboduk3o4CuJsjLNkjKa/olxxib0o6UH2UAHRI8aOWEK
         AP5fj0EPhmPes2BEpBPSY3hmqSjjQhWi1QEhPiZZYmezZX5JngaeU56McyLZHJnwpfc2
         6+KIvVSRqcasxEeCv4eRequdznoT2W6808AjCdwXVdMgLpspvLz04iazIUnDV4Qwjz0c
         L9HAzeHL+/fJSI2a7PpeABzInHz7aIjh9xQM/LF8REGBVE8I4F17gSI6EHCq6JQRcafj
         l0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754773363; x=1755378163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZFSNuvUwMgn1IPIJxKTkMsooeskNeI0zv/uMTISkL0=;
        b=GUgnDRKfRTflSYYZrgosyXzq0ppmFwoCdh5PaNrjtRgwEepdDUBwXhmUbhRFhjFBWY
         cpHEZGLctX8W9EBbPuTa9gEVQ6qwhFoWTV+vRAVzUz+lSGFf1x/5VLe1M0zggtB06IoS
         yxn/AybJmBApUrcta8CmybvfvyUccyfBBw/LmYFjNBFbFUIOc7nXuOBSen3xaTOZWtiI
         tk8hX/PeVJMHUk6c7Fy8LeixNj1AU9J5sljcpRlgyNbU5cQFBY5ThLFglvM6cjCZb1xA
         ZpZGLbwQwXAR9/zwDvndN0OCclkw7cDSj/Mn5ojARfHqJx/YGVszPZddmsxVksRzKYsV
         hZow==
X-Forwarded-Encrypted: i=1; AJvYcCVs+EOmmZP2PGezZtb4pnPqrtZLGW01o6bUMWOw8Psfpkh+3X+8j4vpk9DAPZ4yjmTSP3JZySofSDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydxQtznae3lpEyrDc/LxPN10rRy1tRkEcmz3b+J6eHyEhdy7OO
	0yf7oLvWjulgw7h++nrfNdoBbJS+QfeAXuP2K1KoMtxgz18FAmXXaAEDmEMiVbfdPo1fNSg8t32
	T+6PsSfhc0iMkTmuuG+ZTzp3xN3oxhg9X
X-Gm-Gg: ASbGnctJr593COpLAXIS3ke/phNd4R+bvMrIFzrsrrNpIT2M7wjJTMhjNEXGqT7l89c
	yLDMG+o6bhq8SUPWG2CUuS180mLp7K6v7bqFs0rBzREcPknNsf7LYQ5ekY6leegmSVRisv9h1Ko
	PI+y6KOTP5XXNBqmsiCuh3emN3COUIPAgFiFWvBr+DFonDdR4zDjPbKLEykVG24MOX6hY8dxnzV
	veGpyqRvfK8ODEOXQGnFeJYrzBdrHUuDDhqBHA=
X-Google-Smtp-Source: AGHT+IH3rfMkEssvCZ2fT80VY25JnUUDFiuC5ZDL5QokmUsBhTm+mJM6B4q3nyTPgFgG9V86YnHV+8T0JNH2DF0lEKQ=
X-Received: by 2002:a17:907:1c22:b0:af9:71c2:9f7 with SMTP id
 a640c23a62f3a-af9c63b0ca7mr601023066b.2.1754773362497; Sat, 09 Aug 2025
 14:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4L1Smwc-H01AuKjNbtu9WMzWxJVRtuOjr0Fp_yLiZX7Q@mail.gmail.com>
 <CAABAsM5nzVzPDB3Ubeqg35F7Qd8pBveiYPi1M+KFnMPjb2dxXw@mail.gmail.com>
 <CAM5tNy7Aab8fQ58BghMBsWvs6Xc5U90q9gXWaKeEaZaqcs2Ltw@mail.gmail.com> <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
In-Reply-To: <CADaq8jeAhdOLrD9Y6o1xJsMuGYZLoJdMAonfB5RuX63xV_i0UA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 9 Aug 2025 14:02:30 -0700
X-Gm-Features: Ac12FXyV_PXS3M7SI3sKat43Hd-st4zGKdTC-0b6JKX8xpKqwbdlJ6tRbslIM8M
Message-ID: <CAM5tNy4kPWfPHHRVr712AG=g5wJ+fThG9KFX_9JoT85seTSE=g@mail.gmail.com>
Subject: Re: [nfsv4] Is NFSv4.2's clone_blksize per-file or per-file-system?
To: David Noveck <davenoveck@gmail.com>
Cc: Trond Myklebust <trondmy@gmail.com>, NFSv4 <nfsv4@ietf.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 1:12=E2=80=AFPM David Noveck <davenoveck@gmail.com> =
wrote:
>
>
>
> On Friday, August 8, 2025, Rick Macklem <rick.macklem@gmail.com> wrote:
>>
>> On Fri, Aug 8, 2025 at 8:38=E2=80=AFPM Trond Myklebust <trondmy@gmail.co=
m> wrote:
>> >
>> >
>> >
>> > On Fri, Aug 8, 2025 at 9:47=E2=80=AFPM Rick Macklem <rick.macklem@gmai=
l.com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> I'm looking at RFC7862 and I cannot find where it
>> >> states if the clone_blksize attribute is per-file or
>> >> per-file-system.
>> >>
>> >> If it is not in the RFC, which do others think it is?
>
>
>  Before you told us about ZFS,  I would have assumed per-fs.
>
> Given the uncertainty in the spec, you may wind up dealing clients that a=
ssume it is per-fs.
>
> Although this is not a  catastrophe, you might want to file an errata rep=
ort explaining the negative consequences of assuming this is per-fs. It won=
't get into a spec for a long while but it does provide as much warning as =
you can right now .
>
>
>
>>
>> >> (Or maybe, if you have implemented CLONE,
>> >> which does your implementation assume?)
>> >>
>> >> In case you are wondering why I am asking,
>> >> it turns out that files in a ZFS volume can have
>> >> different block sizes. (It can be changed after the
>> >> file system is created.)
>
>
> The guy who allowed that probably thinks it's a helpful feature.  Sigh!
It's not just a feature change after creation, it turns out to be based
on file size as well.  A small file gets 512 and a larger one gets a full r=
ecord
(128K on my test system).

And, yes, block cloning requires alignment with 512bytes or 128Kbytes
depending on the file.

I can return 128K for clone_blksize and that will (sub-optimally) handle
the 512byte case, but I think it is also possible to increase the record
size from 128K-> after the file system has files in it.

I'll take a look at the Linux client to try and see if/how it uses
clone_blksize.  I need to decide if I should always return 128K
(or whatever the full recordsize is) or 512 for the small files.

Thanks for the comments, rick

>
>> >>
>
>
>>
>> >> Thanks, rick
>> >>
>> >
>> > Yes, but since ZFS only supports filesystem level snapshots, and not a=
ctual file cloning, does that matter to anything?
>> ZFS now has a feature it calls block cloning, which does clone file rang=
es.
>> (It was only added recently. I do not know if the Linux port uses it yet=
?)
>>
>> rick
>>
>> >
>> > Cheers
>> >   Trond
>>
>> _______________________________________________
>> nfsv4 mailing list -- nfsv4@ietf.org
>> To unsubscribe send an email to nfsv4-leave@ietf.org

