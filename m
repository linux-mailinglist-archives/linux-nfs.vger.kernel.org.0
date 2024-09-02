Return-Path: <linux-nfs+bounces-6120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8596868C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D81F23C57
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B61D6C6B;
	Mon,  2 Sep 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgfRAEdk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F11D67A1
	for <linux-nfs@vger.kernel.org>; Mon,  2 Sep 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277653; cv=none; b=YFbcNQg0j8UhSQ+opyXPx5KHXWXLodewxaZEyzrWHB3VlUZfXaK3r2bIPriLOREttn5rHGqIae0elJP5eLy3n7dexE4IrwNDRQZGkxZ5On1i973jT351pL5TlXy24yBVA4z/+0rsAyrqHIdrACEZpK/91JOdn0Lnd4ybOzc5ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277653; c=relaxed/simple;
	bh=zYrr5M3OeFB9TBshgCL9T2S4hXf9cS1NBRc9t+YUNEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icLLgfCGOzzlfFfAs/a/gwHwncL7LJRldOSgquk8XiTnSX1kXxvow/lzNB7HwZ9si2Po/ngKfCoDT1eC3DMJ4EOk6VWq3t7rMRuglA8TWSwW9AqR9S+lP/LqI6BChDYHU/x0v+1L4Q9ZpbCJ/ou9sdIcQ8TmjrOLC9NfMh72KGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgfRAEdk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-456774a0fe7so22630781cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2024 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725277650; x=1725882450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmkdnwlSerOnz16nfYv4J9q25exICbOT5rjg2+Kj6lo=;
        b=XgfRAEdkD6tEwYxQZvFwyam9bTBba6c5BoOdcqHT3raqnOfqNiTaSMBnhKNKdzBCnL
         Marm9FH7meZSJizlvUzsVfCFTR7HZRb1llBiXgsnbb2kxQRlKAvZRTshXZldI5X5kNdj
         b3dry102tEL8sO23gSPygjl1V3G6dZ/nde39YhYvXARN6vy59UCo4aKUb+OnYmFVHCj/
         UNHKjVRDo7b45BqhyLizE1QFxE2nfkdDoO0YGd3PRDBles08PZuhSeM6xe7yEfBxwYez
         imFrhkKJvGDGpF+rqC1AQM5cQAqMu+reIy5uUB7z9Q7EzhWhKt1Fov9RjhEhKaeL3YMc
         wGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277650; x=1725882450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmkdnwlSerOnz16nfYv4J9q25exICbOT5rjg2+Kj6lo=;
        b=W39gRq3oGKGQCQ+iYsFbnyabDhC5YjAoQGyATSTotqxH3I8BBdVfbUaWcdCJCZSzgi
         uYWhNGKHAQaEC4VCQMgpbK6udhZEgyBJ3zUI+AnVwFK8S17ChPMKc/W8NDkFXIHvH8gy
         CqH0doYKsqUl26Fy28wbMtHcCiSNuZG0pOJjqWPNFuDHGw9aSJ+dCYeLhQrdTjvgmY0z
         jfKlIn8Dzyh+XESBcJILzdx2toeRQPfnbWEjMXK1+Nb/1mUBsyxh9ZYU3e+trl01JUk+
         Db7FdOoWfjKt5Tq4EnRhM0xKLL/YqHw8pl3a8LtL+U0XKOT+3g1xh7f0xZ91ticEZQRj
         qS6A==
X-Forwarded-Encrypted: i=1; AJvYcCWUdVr6NIxJqWEN2IZXyl52uZ4fhnmnAFyTvdvPja1cJEIqVhFPjcZMM1ptQwuZKTyDJDk0l6HhMWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51V/pkJMH3bS2/j7mnDIY0opjYP2mEjaCh5nmJXA7AntLRIRJ
	bpRMCcjJJJDyFhCIsfby+nEA2YV/eBFvVDTMJ/lnXsIuHGoUvtctIPeDE6Lzup+8VXEaidGXEi2
	5TMuD6le2hVZuPYaAJddrJDKSOa5Hiqj+mI1geA==
X-Google-Smtp-Source: AGHT+IFIsSARMtKU0g5FSaa9UWlCgiZOvixsNCAnWK4GqMpNsF2Hke0PDXVDoJo1TWxigk4xdQQ1MRBQYR2Omld/J10=
X-Received: by 2002:a05:6214:2d4a:b0:6bf:9eff:55e5 with SMTP id
 6a1803df08f44-6c33e6b1c93mr167696616d6.41.1725277650302; Mon, 02 Sep 2024
 04:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091340.2043-1-laoar.shao@gmail.com> <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com> <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
In-Reply-To: <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 19:46:53 +0800
Message-ID: <CALOAHbD0vhRypzEJDKJgCzYTzrhoiofzRZWF4rgr304NMXTjBw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:57=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 29 Aug 2024, at 8:54, Yafang Shao wrote:
>
> > On Thu, Aug 29, 2024 at 8:44=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> On 29 Aug 2024, at 5:13, Yafang Shao wrote:
> >>
> >>> In our production environment, we noticed that some files are missing=
 when
> >>> running the ls command in an NFS directory. However, we can still
> >>> successfully cd into the missing directories. This issue can be illus=
trated
> >>> as follows:
> >>>
> >>>   $ cd nfs
> >>>   $ ls
> >>>   a b c e f            <<<< 'd' is missing
> >>>   $ cd d               <<<< success
> >>>
> >>> I verified the issue with the latest upstream kernel, and it still
> >>> persists. Further analysis reveals that files go missing when the dts=
ize is
> >>> expanded. The default dtsize was reduced from 1MB to 4KB in commit
> >>> 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS r=
eaddir").
> >>> After restoring the default size to 1MB, the issue disappears. I also=
 tried
> >>> setting the default size to 8KB, and the issue similarly disappears.
> >>>
> >>> Upon further analysis, it appears that there is a bad entry being dec=
oded
> >>> in nfs_readdir_entry_decode(). When a bad entry is encountered, the
> >>> decoding process breaks without handling the error. We should revert =
the
> >>> bad entry in such cases. After implementing this change, the issue is
> >>> resolved.
> >>
> >> It seems like you're trying to handle a server bug of some sort.  Have=
 you
> >> been able to look at a wire capture to determine why there's a bad ent=
ry?
> >
> > I've used tcpdump to analyze the packets but didn't find anything
> > suspicious. Do you have any suggestions?
>
> I'd check to make sure the server isn't overrunning the READDIR request's
> dircount and maxcount (they should be the same for the linux client).  If
> the server isn't exceeding them, then there's a likely client bug.
>
> Ben
>

Hello Ben,

Upon thorough examination, we have identified the root cause of the
issue to lie within the NFS server, specifically its behavior of
truncating file listings to match the client's READDIR RPC args->size
parameter without appropriately adjusting the cookie value. After
implementing a fix on the server side, the issue has been resolved.
However, to enhance resilience and mitigate future server-side
vulnerabilities, it may be prudent to implement client-side handling
mechanisms for such issues. What do you think?

--=20
Regards
Yafang

