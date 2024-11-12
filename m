Return-Path: <linux-nfs+bounces-7909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93B9C60DA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 19:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65001283FD1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879A217F2A;
	Tue, 12 Nov 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/8lzLTB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60202178EE
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437609; cv=none; b=N6PKvaYwe0cV7tD3k+BHiPNxiOcnbE0OikNOf86WUvHgoQETc5wz/g+OhF1Y/Jf7Qx4nRpQy/J4COkpaAtOO8rDUCQMdWUsWvS/hZb7HoO6ckJjcdpyPFv5hmGq3Sgxj5mIO83CtmZUXJKCtjD+WnkqejV4o8+DVLeRUQgqRfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437609; c=relaxed/simple;
	bh=DuxultC2nqdYyI88YsUtrbHYZEt17o+8RlXCGbmwT+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GLrE2KGCzBjB98N/wqUr68jHgO6sVGn6Dd5ZNRuGEb97I/NdDxMjOpsiXk8QcmPXHPmrwE9AEHECGlCzvdvYms4YhqElr/NMosIqQecfbsW/OBEhjPwu5zUSaUp0Ow2mYRzqHVEHvhSIAWZOu1Dlxjjgrp90yrETchABq1YOp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/8lzLTB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ee097a478so404101666b.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731437604; x=1732042404; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OErAQy/YKBwWfQDki7kljFFUivEkeIWk2VVxKCMujTc=;
        b=F/8lzLTBOSGTBKwnE88QY2KN2BW23SRfXF9kmIvKlpctdA3WhGEWQDJhEpyTWqr9e/
         ogVhiCAapURUVbnfi8IkNkd/1ZYMWdCnRTG7NWEjqScb/+PhnZGcbePfUgfI6BhPIbnx
         Yh6aAQAH1qf9rUkWNFv8U3qPtjZAJtn2I5UrzdCyVCR8xi2+2fvinR4+mEUcH+OV5Ir2
         yT6AarA1eRotb4lg9EZwhKSv+wGJAsVLVU/wDUS9Qhqu7/oIDvuNli+UlCa/pTV+1cNW
         qSpaKosCRmgziWneJansHpaLm/+3l+K6VPKnMSEHvD5+e2d+b2KoeO83LCGt8Amdtu6a
         Vu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437604; x=1732042404;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OErAQy/YKBwWfQDki7kljFFUivEkeIWk2VVxKCMujTc=;
        b=RVo3eEljELw9hI8pZJPuduW/3dWO+p7kOuYUmOeRJZPCpql2d/fPKauSbLtjk6uE4n
         l1FYHBqWU/QGVKLwM6rH9uHZPzr0d+s2+Jp7G5qztASeG73a1WiKK3w8Uqc6Wbg7RWxc
         R+Kc6yaaShREPElG4IAd1849L3jptMZlC6YEvbJ1xyc4azIjRSCyOkH6DIVj+h+3bx2e
         CKUnIC0pQnvVSyLfo2a/VH/+SnrMeSKdVIT/P6/q6VB3upFkJT4yrIzQW0hyI+QsVKZP
         suVncatGsiNTLiBUu8dyr3qAniQFKA6JYCfNNvnRRyCoFKt7AFY/NGCe/SDr6g+jsyIQ
         MCEw==
X-Gm-Message-State: AOJu0YwrliaqgUqxah4hepdEwCy6yqS1TwcAiir55OSbgjxRYEZNfQqH
	d1tpoVgJ1n6PNzCRh48igVn6CcGved8wsP5uu+yMhla7JN/sphQ7K2F6u9+FU3XMrtkyI22vNcQ
	/76obTe8oRjbgyCfNYnies+BpXe5UcA==
X-Google-Smtp-Source: AGHT+IEK9AgRCKCFp4OPVvLuvrDS3ZIj1qZpvgRIAfvzyr3PpHvnk2NKvJdavgNHnOmr5Sn2RavonqdGarNQdYeKaBI=
X-Received: by 2002:a05:6402:845:b0:5ce:de19:472a with SMTP id
 4fb4d7f45d1cf-5cf0a31ffc8mr20135275a12.16.1731437604370; Tue, 12 Nov 2024
 10:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 12 Nov 2024 19:52:00 +0100
Message-ID: <CALXu0UfwT89owXiGPaGnBKfJcVsgY9mx7BB1XZM_aCczwt7Ofw@mail.gmail.com>
Subject: Re: [PATCH] nfs(5): Update rsize/wsize options
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 08:25, Seiichi Ikarashi (Fujitsu)
<s.ikarashi@fujitsu.com> wrote:
>
> The rsize/wsize values are not multiples of 1024 but multiples of PAGE_SIZE
> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_size().

This is an implementation bug, NOT a documentation bug.

>
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>

r- (patch rejected)

The rsize/wsize value must not depend on a variable, per-machine
value. For example SPARCv9 can use 8k, 32k, 512k and so on.
AARCH64/ARM64 can use 4k or 64, all selectable at boot parameters.
Better we fix the kernel code to count in 1k for rsize and wsize options.
Only question is whether we "round up", or "round down" to the
machine's page size.

I shudder already at this stupid scenario: Entries in /etc/fstab can
no longer be deployed via puppet, because a script must always use
/usr/bin/pagesize to peel our the machine's default page size, do some
calculations with /bin/bc and do a mount via script.
Sarcastic bonus points go to the person who decided to put
/usr/bin/pagesize into a separate package which is not installed by
default in Debian+RH.

Ced

> ---
> utils/mount/nfs.man | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 233a717..01fa22c 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -215,15 +215,18 @@ or smaller than the
>  setting. The largest read payload supported by the Linux NFS client
>  is 1,048,576 bytes (one megabyte).
>  .IP
> -The
> +The allowed
>  .B rsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +.BR PAGE_SIZE ,
> +or a power of two if it is less than
> +.BR PAGE_SIZE .
>  Specified
>  .B rsize
>  values lower than 1024 are replaced with 4096; values larger than
>  1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>  .IP
>  If an
>  .B rsize
> @@ -257,16 +260,19 @@ setting. The largest write payload supported by the Linux NFS client
>  is 1,048,576 bytes (one megabyte).
>  .IP
>  Similar to
> -.B rsize
> -, the
> +.BR rsize ,
> +the allowed
>  .B wsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +.BR PAGE_SIZE ,
> +or a power of two if it is less than
> +.BR PAGE_SIZE .
>  Specified
>  .B wsize
>  values lower than 1024 are replaced with 4096; values larger than
>  1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>  .IP
>  If a
>  .B wsize
>


-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

