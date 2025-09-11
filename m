Return-Path: <linux-nfs+bounces-14297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3028CB53771
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233013A5304
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F634DCE4;
	Thu, 11 Sep 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAcirdMh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED834DCC9
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603789; cv=none; b=Y8Y9S82VmeJskI/v56jOwiKs1kPhmnCuyzMrA1qXARU6hvJn8h4ZSfpB07Px7Jk51eBkMlKq+Sr20hNu84wkn5r2YAspzyFmpgG+CqV/RXJESe8y8i+vhYDBLavKPc4H6wW7gKqz+VYTKETL67uDsTYVOqQ+lYGRAAz2p32i/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603789; c=relaxed/simple;
	bh=a4bwTTm8DDy1QIkTCmgQZy35/P1OSicCOauHAgByEfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCx8GXW3FhgROZ8SiYbqlKP0Ovpr/yDs5GnF26aJxOvYi76xR46MpUe9w6pucL+18N52PpggIpgOoxEz1E7pXJ+kNBcSmDOKMNL//ijSMw8DXuUCCHE/kJneV9o3F+zmI6c18C4MKpV+iyRteNt5WnPiKz7N8fZwRT6mnxnKGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAcirdMh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so390620a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757603786; x=1758208586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wBo822YD+jvyd1+EsiFuVc9oA9ouix4aflKx2NsrPs=;
        b=AAcirdMh/paP8CvnwYN0WRwP/4NlghsmNdDHjiHYsSZrehyr7phxTUNvfxxxMzGgNh
         W/pumbX+m+DF3IUpX0y/CqFw8GzXNkN+mU45BXcxzFJAV1suGvKT9+Av2wIHMte4Fbqr
         fkyM++zQwG/21hMqVPKLgWVzQ1HdXnkxr/zRmqI+NbWV8s4QJiZjLS7OMY/kA9xkpYfh
         UoUFs26Jf4sZOmDuqhLPLzsjU9dwg2Bs3JhZP6pXEKSmsbzufxuIa7AlZCL/ROjutUu4
         YzhnAYHFzLSqSNDlFVAyYxvnjjses8MKw2zW5So/2vpnsSi+ogfx0J2Ukr5fUaQqA0MU
         xbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603786; x=1758208586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wBo822YD+jvyd1+EsiFuVc9oA9ouix4aflKx2NsrPs=;
        b=Jf8nyvHAUObpMZTThV7og5Dkkrow3dGRmViDQTTjEmDczfKT2KHcWhxrJABosJNABE
         UCMyMk3jMn0mCWZ6wwkWV6jyO8PDhbYbGL30FLiXZf5g2ric2XTAyKvIk5TLtVKI70ZZ
         W6sbIdY5ucUsn1NjFyNQpKsPYvuojs7ZfBP0LuqnEVqMsPrgwcs8XQEc2iQLoSnzEqxr
         OzGpSxzjSvJkLAu779mtC4tH1IjDallRahAqm+L6O2/mGG0UYsKyDMQaDNWajMNDIANj
         1B+TMaemoaadZoM7lqI2K3Kte/H/PJF9RWUn8TkNVT1zJy/bLxKGus33P4Iel9WYY2nw
         s+7w==
X-Forwarded-Encrypted: i=1; AJvYcCUEaZBaY9bLUhlpxyiRtCX8e+yXPyg69DvD7Z/YbO/Nr+GbhVSSsQT/BMrGzXUwtaV8QU9+ZCNVvJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/ubeFQdCKllxPU1WCvp46RZG9jvZDoJOFtGL0q6wkUOih58S
	FFC2LaBcBSS6C+Oh2HzgDTEZw4IRvmqApVPXc9+ZH/OY/8FqNDpjft0ZhaasntAoXl+ab+E6jhD
	KTIoIdktnxotPoA42PAISrQgiMZlzcx/gA3Jq
X-Gm-Gg: ASbGncscg6d5PRXYhlt5sWnKHSRVNktL5AKMNlhJoEcFWPWzyD9T6YB08vEVBdsr2aI
	+cVuqMbmCU5/Imf1SiiZYf39ZooLEEY6dNSgISeaOVI2XzJQoqb1Q5iJcesuZqkk5Nm965w3z2q
	AtgVuhXDOkyDBLDt5dCEQPDgqJYzrfitnTkAHu4finz9tDQE44bgFHPzDkLHvth+1pnGFCNUnSB
	2yl4k6XDv4fyww/0g==
X-Google-Smtp-Source: AGHT+IEWJHProfqe9MkMrApe0nu8Lni7uWBd5hMokDX8mM8AOlkDsbauNr0xucI3RgQ39BL1u0WyoFXJ+HknrvtHBLw=
X-Received: by 2002:a05:6402:2343:b0:61e:ca25:3502 with SMTP id
 4fb4d7f45d1cf-623771096b8mr18353367a12.17.1757603785655; Thu, 11 Sep 2025
 08:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
 <20250910214927.480316-11-tahbertschinger@gmail.com> <aMLAkwL42TGw0-n6@infradead.org>
 <CAOQ4uxiKXq-YHfYy_LPt31KBVwWXc62+2CNqepBxhWrHcYxgnQ@mail.gmail.com> <DCQ2J75IZ9GN.29DY2W9SV3JPU@gmail.com>
In-Reply-To: <DCQ2J75IZ9GN.29DY2W9SV3JPU@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 17:16:14 +0200
X-Gm-Features: Ac12FXwWObOdteDLG_KWCcYb5SJCTz6npELP39lbmWonT28sMQmBU7w0_t-zMqY
Message-ID: <CAOQ4uxiQL9m2fBW6HhRkcsw=uBcU_YZT6Bs1KWw+Zppokar66Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] xfs: add support for non-blocking fh_to_dentry()
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 5:10=E2=80=AFPM Thomas Bertschinger
<tahbertschinger@gmail.com> wrote:
>
> On Thu Sep 11, 2025 at 6:39 AM MDT, Amir Goldstein wrote:
> > On Thu, Sep 11, 2025 at 2:29=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> >>
> >> On Wed, Sep 10, 2025 at 03:49:27PM -0600, Thomas Bertschinger wrote:
> >> > This is to support using open_by_handle_at(2) via io_uring. It is us=
eful
> >> > for io_uring to request that opening a file via handle be completed
> >> > using only cached data, or fail with -EAGAIN if that is not possible=
.
> >> >
> >> > The signature of xfs_nfs_get_inode() is extended with a new flags
> >> > argument that allows callers to specify XFS_IGET_INCORE.
> >> >
> >> > That flag is set when the VFS passes the FILEID_CACHED flag via the
> >> > fileid_type argument.
> >>
> >> Please post the entire series to all list.  No one has any idea what y=
our
> >> magic new flag does without seeing all the patches.
> >>
> >
> > Might as well re-post your entire v2 patches with v2 subjects and
> > cc xfs list.
> >
> > Thanks,
> > Amir.
>
>
> Thanks for the advice, sorry for messing up the procedure...
>
> Since there are a few quick fixups I can make, I may go straight to
> sending v3 with the correct subject and cc. Any reason for me to not do
> that -- is it preferable to resend v2 right away with no changes?

No worries. v3 is fine.
But maybe give it a day or two for other people to comment on v2
before posting v3. Some people may even be mid review of v2
and that can be a bit annoying to get v3 while in the middle of review of v=
2.

Thanks,
Amir.

