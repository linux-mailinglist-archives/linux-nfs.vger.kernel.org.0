Return-Path: <linux-nfs+bounces-8945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E6A0440C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0838D1886A75
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24191F2370;
	Tue,  7 Jan 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="j+i4y5Pp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CE195808
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263089; cv=none; b=DLrXya4jMXWyGii6d9tarxE2TJ4hDRABug7z1JmZBL4wtaFuQAuLwOpJdDbBNqJvuNU25sz85KkWOTipAVwHgMf3MIbYDebUE29HT6dYu2vqcu8+Cx21i8ryNpi7m284D9U5FZ5VUVT8KPcSHMExNklxv35g2sggKJ7ZSWI26kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263089; c=relaxed/simple;
	bh=QhQZNm44rVLaNdsaumVEOL9NYtkpvLczIFnmJDjzXB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL4Gf1h7Yav1b3FbFZxBOgRtRZ6sOU7WShwPyGrwCvmPwWgkIauHlsvHD3CohlXSxVG6ZxtX1H82KYgSYnXXsrDLqYiyxxdtSRADklJBvJ3VzYX7AN3GQLXYjheN0cpVBPoGXcpXh7pdFq+5i6ykx+jhV65o34F2ZpwSCpCJHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=j+i4y5Pp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-305d840926fso21465101fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1736263085; x=1736867885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhQZNm44rVLaNdsaumVEOL9NYtkpvLczIFnmJDjzXB0=;
        b=j+i4y5PpAovZMUpJv4WD72uXw8mKiH9CIfGZreDXzL5VNUo0ozcg4+KLBubkMuI1Nr
         sfXJ5HtEAD/A/Kf/Usmt2s0A/I+bGrm/LOHojcUb3O4PWBVG5kIsJejcgSkoGi/yo/oU
         ZesE+oNNMUFjoy2Vj0qjl/6XzBYZJy38JlJztZRk66DeQ8N+UOGdjPoeQFmC4C1r3vMw
         YySxwnwLnmZl8xux/jNx7dJ482xCrcgvc+ullNZbSL9abgBisaVa7IBlsfiNRYVy4DOb
         gYG4XNiPlijhI4G8Dkq3UXkOa7QwcNNKa5PyJUKLRX2QviUg6u3C9ZJU1HJlFC99xSOZ
         +DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736263085; x=1736867885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhQZNm44rVLaNdsaumVEOL9NYtkpvLczIFnmJDjzXB0=;
        b=APNH3QX5ij1k0uAInvpSAn2asOXBd1fLUQGaYGims237UE2efeF2WreZiIXi7Vf979
         sgjbrIQjpEkMBb0sERtd6EYRzaf/NdmDATssf+ebdYoUHopI9VKdZwW7JNiV72Rnl2J5
         pBQ/LK2132aN6YhHk0om5RL1Y+qiSNu2KArGdzo67JbIoQaJay5YqOVvEFzQAtS4USCo
         DudL8qSH17HSOJ6IBequAdXYQbx/Qa0xHaeLHmkRcFVPWHxsoVwhE1M8Pi5S3DsY7fbK
         2FJGQwk5tVkP0bp7sq9pbprQcoqeIMxtJHDxjISGlrLxh2K7PHNxVw64+vzygw1U8HmQ
         fUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRBab28EaL7++AF00tArifHd05BhdyO3tip2XUXt/uRSpf1dmgdOAjrlQecYs7hBkjWdavyBcFmK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DbozXkRP3F2Tb/LLsG7kTMyxkkoW5mbddgxer7rwE/5Q4smn
	v/qo90MuqBEED8TdL3Ci6oXhMYNcVHH+DziRPDlaCeTm8OdyTgevJzHZK1Id4xIdydaIQn7zjNm
	DIO62rOvwIr9+J8aDksHOpUsuOgY=
X-Gm-Gg: ASbGncurxk4awrn4N4F9WDeLaL0wp6XlkbYu+oKakW/h6UPqgrdK39cbiEFiDubwj50
	rKNPkOyqVCNxOczJLSkwwUvzOYvTxOaOPubINEENLoy1WxvD6laZkhcQC/9NqAH00thBOnysx
X-Google-Smtp-Source: AGHT+IGbGuZKx/Q+OLkGFTbnU96vsLusgnhfjVEmt5Gl6u4Km7zxBCRpF5QDOYJNzCnCtVdDoOB0ZI9dbzYJRKpY3g0=
X-Received: by 2002:a05:651c:547:b0:302:2620:ec84 with SMTP id
 38308e7fff4ca-3046851fd09mr187253061fa.7.1736263085235; Tue, 07 Jan 2025
 07:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
 <948ffb91-caa5-4244-b0fd-19f460ebd7a6@oracle.com> <CALXu0UeMT019gHRW0GpiQBn1vh0TTRqEg50CFUyKLHUoL8BJSQ@mail.gmail.com>
 <4a6fc718-aced-4f02-a4b6-bdc8fccd329e@oracle.com>
In-Reply-To: <4a6fc718-aced-4f02-a4b6-bdc8fccd329e@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 7 Jan 2025 10:17:53 -0500
X-Gm-Features: AbW1kvaeWOXEofIggoHCi-JKFdDmXkXfyM75jHRK-YOqQWP3RIxj9s3qDHXq6hk
Message-ID: <CAN-5tyG6e2d7GrAY=6bs3A5gTgpqaoVhD_RA9nyifv_fyJ_rDg@mail.gmail.com>
Subject: Re: cp(1) using NFS4.2 CLONE?
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:35=E2=80=AFAM Anna Schumaker <anna.schumaker@oracl=
e.com> wrote:
>
>
>
> On 1/7/25 2:10 AM, Cedric Blancher wrote:
> > On Mon, 6 Jan 2025 at 18:30, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>
> >>
> >> On 1/4/25 10:44 PM, Cedric Blancher wrote:
> >>> Good morning!
> >>>
> >>> Can standard Linux cp(1) use NFS4.2 CLONE?
> >>
> >> yes, use option '--reflink=3Dauto'
> >>
> >
> > Why is this not on by default?
>
> That's a question for the GNU coreutils people, since that's how they imp=
lemented it.
>
> I thought that the copy_file_range system call would try to do a clone fi=
rst, but it looks like that behavior changed a while ago. Now the system ca=
ll will only attempt a clone on filesystems that don't specifically impleme=
nt copy.

As far as I can see CLONE is still the first thing that's tried (linux
6.13-rc kernel) when cp is done. CentOS9 distro. No need to use
--reflink as far I know.

>
> Anna
>
> >
> > Ced
>
>

