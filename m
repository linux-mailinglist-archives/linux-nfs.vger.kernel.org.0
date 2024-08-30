Return-Path: <linux-nfs+bounces-6045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F06965F7A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E28E28AE6A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822AA184543;
	Fri, 30 Aug 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUY2WBLQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32C188A34
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014464; cv=none; b=u0ANI6FQFFPLK0lHwgi7G7yzncBhGSiaFTFyuz/J+2/ZOC9Y4ITD6volmfCZdZ61Hmz/aza+EWWHbIVdkN5UPiZ7yU4NsTIex3sb/IHYmpBxXiDdqhuEirWwM1na1r0u2jLGEZhskihcYxp6+Lh8DMmG9Z60vR9EHvsJIBnbU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014464; c=relaxed/simple;
	bh=LEz7YIxCC+aM42T/70kAoYS5dugmd7APjJ9g664QU6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nospHc/MOYB1OT1n+dv5SGc2PCad/YPwKcNkzdzSUXxVBMY4M9xBWanpAYoV0wWMfGCtSZ66NcuyDOup1UKPu/WsMHgiM0JF2sjQewQJ7ROBgSxXyc2w4/AgiTxK5PBBp013C63w29HY86seOfGAeOCjl4xe/ASpWYT2XvrSP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUY2WBLQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf8a662467so8952916d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725014461; x=1725619261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8jQbW5f/fdh4PKJPSs9IgjFUW9MDC46oKREStkd1Ck=;
        b=JUY2WBLQz4RmYw1fmgm3VVaXsPshzOfpjB7WoxzIWH4rrPq6NAZc3otfxrkM/3PpE2
         wGM3zSFl+Ufh8t68XFLXrAnG7WfnCKylNJChVlKR+aEHjV4nO+gapUIu89Mxhyutmwrw
         umrIbzx0f55OmPRPh7HNAnEkCErOuq50kH/9Pv+rUAYiPsUmwAiVlMZpuUftWy5bLvWj
         U4wBEw8n7Z8ZyGLjPx30Cm1WnHepjoepae6nEyBF7beSO9Y4bokFDE8m+9UsX5GgrSPj
         FR/mN3fGScRerV9nOdmxmV7xY3s6ixGuA3jLiWNc95Q1GkWDMFxK72wY1DD2gry3pjBM
         TPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014461; x=1725619261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8jQbW5f/fdh4PKJPSs9IgjFUW9MDC46oKREStkd1Ck=;
        b=tHHv1cGldBYeWB1Q9jxCLC+X/PqlUWttA4434uhF5G8suSIDjOlf5uGzxjizrCXSop
         Jnl0K/JE5X7WzBdfQH5CZ425koMVbFWu0TuQI2BHhGHYKOSKE3pS1C1SxXfQ974szZha
         XcMmu7deWiJfqbdoJB4tR6ORkPZ5SzstnoV773wTKhHAPkYj9mv8RWSeY3bWtNN08yni
         sXy9bgThn5lUAsliRdTOo71uAxTzrwq6gZ2ayVI97ZBm3s918cF8MRDhrtxhOWmTQHs8
         SPqxCpZG8nGGkIpa+9ErRwqEZy3MlIin/gapZAtIbuWh0IX3iOLvQQLKi5121K97k62w
         mwtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTqjSN2UWV5LuSn9mhMkPrnxFslwOGy4ZjU5iLrkbTCg7wnNftBxWgRh05zxfK+a9i++ZNKMktQ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR63oftz1BOTh7aJvPy00o40Q0sj5pQZvw8AxY+Xj7/u0jPChH
	W6zlHuKL6uKlstzz0MCMGJziiAKIfYbZ5ed0PNE6laGQKw506iRWWiD8BnjhitF4HDf7j/mJLZn
	9XbY+KPzQP8dHcQ9ryRwkY7sZOmg=
X-Google-Smtp-Source: AGHT+IG7gLRChau9UhGW5/ROyWGdzE0Y5xm56pkPdUPVQ6A6M94vSV9xBD87VaUi6Ka0NKRNbuVtSHhZtgj8cFyulNk=
X-Received: by 2002:a05:6214:4905:b0:6bf:8971:1320 with SMTP id
 6a1803df08f44-6c33e62305cmr59115586d6.18.1725014461255; Fri, 30 Aug 2024
 03:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830070653.7326-1-neilb@suse.de>
In-Reply-To: <20240830070653.7326-1-neilb@suse.de>
From: Santosh Pradhan <santosh.pradhan@gmail.com>
Date: Fri, 30 Aug 2024 16:10:50 +0530
Message-ID: <CAOuNp5m9zencvTnEsE6ovq__A_pyVo4omjUJAhoT7RQHTnXkhQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] nfsd: improvements for wake_up_bit/var
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,
Do we need a barrier in nfs4_disable_swap() as well ?

10830         set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
10831         clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
>>> HERE>>>>
10832         wake_up_var(&clp->cl_state);

Regards,
Santosh

On Fri, Aug 30, 2024 at 12:37=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> I've been digging into wake_up_bit and wake_up_var recently.  There are
> a lot of places where the required barriers aren't quite right.
>
> This patch fixes them up for nfsd.  The bugs are mostly minor, though
> the rp_locked on might be a credible problem on weakly ordered hosts
> (e.g.  power64).
>
> NeilBrown
>
>  [PATCH 1/2] nfsd: use clear_and_wake_up_bit()
>  [PATCH 2/2] nfsd: avoid races with wake_up_var()
>

