Return-Path: <linux-nfs+bounces-3328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D531C8CBA60
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 06:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958F6282566
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 04:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0B5644E;
	Wed, 22 May 2024 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="fwWXR4Sq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116137144
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716352877; cv=none; b=sfF2kyTx+k9sORT0cbNjVt39pgh/0a+PqwP+RzLR+kbVm7e7JACLyqKxZorbq1CXW8AJqsrmwe2DPV80UOz04W6YAphm7RliMpYXppGzcZwSLdldkg5RNhEBVKeJuelw6o8t3kaKSP52Uh9s7jx5e4+xO/IX1WXnup6Hcr5lPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716352877; c=relaxed/simple;
	bh=p9//CrtTUW+EMsbUG5A6FYK4d8V2HWt/qTe/+Eq8wwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loF5bltVHkQa2oRQ6KgDeUlX4BhHIVimNUKV6s2EpbJJuHqwBLA5ocfpAm+Z6oXXAJmLRACWPotuP38K0DH5C/z+JCLbO11s+2lkDYuZ1SXoDmPuqDPF4iJ/+f/Wkfm5iS+jrAu4QTRp/EmryXEkFH2q5lrm84+TlZ5fzoH1ucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=fwWXR4Sq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41fc5645bb1so34590365e9.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 21:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1716352874; x=1716957674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d+gZ7TPGMHgbj3wT3KIN6u7iPmTwg63xf8D4iKfOels=;
        b=fwWXR4SqIyu5eozfef4/dv7VZe9Tma23SLzzyu5ulj9xb/4NQHq0BccH5ITRK/rSMQ
         /kyxBhbQvHY7jguCjSHuiqtYAtQwmgvFIXxLhCgbtEaTabkizW+d2YBqMI/qIBGZirYv
         /6diFj15xJ37f/f5QupadxbudpSWN7xvSQTEUOvn8W1lSyCTj3vQ9sX4YlowO/otsp2Z
         H6LbROoAwDgI8WO7jv6OVDSIeJK8ZQ/3rEZgJjcYZIXPJg9WZCigivrWYLAE0A36LqXd
         LLn/aMfQRIIemy0rMcNSYpU4ARL7h8VQ13XwDT+spSyk3L6jwWuVanOf9m3CYFHsrp+J
         0Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716352874; x=1716957674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+gZ7TPGMHgbj3wT3KIN6u7iPmTwg63xf8D4iKfOels=;
        b=OLRpDVHrAq628InWs6zZDCtjmgCxu5O1rIrIsEMPnkOB9Q69kND9AEG/ORCWGCTqb+
         F+9FhSzTHjeGeJuW+RgPHWBxodHNXY+DxJ/uZU+fuU2K4PAxTvlOlTx+0ZqGp6VxbzZn
         2Q1k1VF6zKhC1IUTuooH872d00tcIby7nIJysSomrmZYzhxTJ+9DUR886PtMQufeso8v
         nzyrOMLqHuhzoi+eIkU0W5QhY4ETMWLyXWBLLWrPdchH4wrfoADiKNZYyLywSrXTvkb0
         sgBwTpxrsLPQRR5LIUpZHS3BPROrn7ZxFfcN65ssoTA57RtjMAB6aIvqsGbg9R5D1ceJ
         iFnw==
X-Forwarded-Encrypted: i=1; AJvYcCU9QPeEsjw47ow2hSyNLCEswyvIq22dgi+HPrVhvHF+8ECCZ9tuoofByPG2GfUcWOdga2BSX99qqJemlBl7lPsvoPFJhtSxEBvM
X-Gm-Message-State: AOJu0Yw08JyoQ6X1PPIiiA2e4Cdiar2nFTrJvFskWcZAMxN/Ahra7gX0
	j2Y9elp54HKxTnjAIZ1ucUDqoqKaoKCatgQo/PUf9eRbJyTcZDq5ltMat0OYvsjPeRZA2ldvcwD
	pmfo=
X-Google-Smtp-Source: AGHT+IEwdrLz1aBDcFete7BMs4l07SuhrRx23KqEZixFDNuZ/M4ROTdWHedw79sCmO9TfbeMG3IgzQ==
X-Received: by 2002:a05:600c:1d19:b0:41e:8894:3f48 with SMTP id 5b1f17b1804b1-420fd35fe48mr5110275e9.27.1716352873739;
        Tue, 21 May 2024 21:41:13 -0700 (PDT)
Received: from gmail.com (IGLD-84-229-89-93.inter.net.il. [84.229.89.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2449sm485879145e9.16.2024.05.21.21.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 21:41:13 -0700 (PDT)
Date: Wed, 22 May 2024 07:41:10 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Message-ID: <20240522044110.rwqyldj6u6523alm@gmail.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
 <53269EF0-4995-474B-9460-29A640E8A46F@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53269EF0-4995-474B-9460-29A640E8A46F@oracle.com>

On 2024-05-21 15:24:19, Chuck Lever III wrote:
> 
> 
> > On May 21, 2024, at 11:13 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > On Tue, 2024-05-21 at 18:05 +0300, Sagi Grimberg wrote:
> >> 
> >> 
> >> On 21/05/2024 16:22, Jeff Layton wrote:
> >>> On Tue, 2024-05-21 at 15:58 +0300, Sagi Grimberg wrote:
> >>>> There is an inherent race where a symlink file may have been
> >>>> overriden
> >>>> (by a different client) between lookup and readlink, resulting in
> >>>> a
> >>>> spurious EIO error returned to userspace. Fix this by propagating
> >>>> back
> >>>> ESTALE errors such that the vfs will retry the lookup/get_link
> >>>> (similar
> >>>> to nfs4_file_open) at least once.
> >>>> 
> >>>> Cc: Dan Aloni <dan.aloni@vastdata.com>
> >>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>>> ---
> >>>> Note that with this change the vfs should retry once for
> >>>> ESTALE errors. However with an artificial reproducer of high
> >>>> frequency symlink overrides, nothing prevents the retry to
> >>>> also encounter ESTALE, propagating the error back to userspace.
> >>>> The man pages for openat/readlinkat do not list an ESTALE errno.
> >>>> 
> >>>> An alternative attempt (implemented by Dan) was a local retry
> >>>> loop
> >>>> in nfs_get_link(), if this is an applicable approach, Dan can
> >>>> share his patch instead.
> >>>> 
> >>>>   fs/nfs/symlink.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>> 
> >>>> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
> >>>> index 0e27a2e4e68b..13818129d268 100644
> >>>> --- a/fs/nfs/symlink.c
> >>>> +++ b/fs/nfs/symlink.c
> >>>> @@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file
> >>>> *file, struct folio *folio)
> >>>>   error:
> >>>>    folio_set_error(folio);
> >>>>    folio_unlock(folio);
> >>>> - return -EIO;
> >>>> + return error;
> >>>>   }
> >>>>   
> >>>>   static const char *nfs_get_link(struct dentry *dentry,
> >>> git blame seems to indicate that we've returned -EIO here since the
> >>> beginning of the git era (and likely long before that). I see no
> >>> reason
> >>> for us to cloak the real error there though, especially with
> >>> something
> >>> like an ESTALE error.
> >>> 
> >>>      Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> 
> >>> FWIW, I think we shouldn't try to do any retry looping on ESTALE
> >>> beyond
> >>> what we already do.
> >>> 
> >>> Yes, we can sometimes trigger ESTALE errors to bubble up to
> >>> userland if
> >>> we really thrash the underlying filesystem when testing, but I
> >>> think
> >>> that's actually desirable:
> >> 
> >> Returning ESTALE would be an improvement over returning EIO IMO,
> >> but it may be surprising for userspace to see an undocumented errno.
> >> Maybe the man pages can be amended?
> >> 
> >>> 
> >>> If you have real workloads across multiple machines that are racing
> >>> with other that tightly, then you should probably be using some
> >>> sort of
> >>> locking or other synchronization. If it's clever enough that it
> >>> doesn''t need that, then it should be able to deal with the
> >>> occasional
> >>> ESTALE error by retrying on its own.
> >> 
> >> I tend to agree. FWIW Solaris has a config knob for number of stale
> >> retries
> >> it does, maybe there is an appetite to have something like that as
> >> well?
> >> 
> > 
> > Any reason why we couldn't just return ENOENT in the case where the
> > filehandle is stale? There will have been an unlink() on the symlink at
> > some point in the recent past.
> 
> To me ENOENT is preferable to both EIO and ESTALE.

Another view on that, where in the scenario of `rename` causing the
unlinking, there was no situation of 'no entry' as the directory entry
was only updated and not removed. So ENOENT in this regard by the
meaning of 'no entry' would not reflect what has really happened.

(unless you go with the 'no entity' interpretation of ENOENT, but that
would be against most of the POSIX-spec cases where ENOENT is returned
which deal primarily with missing path components i.e. names to
objects and not the objects themselves)

-- 
Dan Aloni

