Return-Path: <linux-nfs+bounces-13128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6DB0886F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430523B82CD
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD0289351;
	Thu, 17 Jul 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctk6BJua"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FF28724A;
	Thu, 17 Jul 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742242; cv=none; b=fKuJa8idKyMLKPriH7o/a19ITLOJ8+IaEy78+RyKwziLEHDL5euO/f9UFP+YxL/A+V5K7e7p7FfkjA/vgR78RPSmtjPyIhsJspA2S+0YVfY36qimbzD1mAUP2wWl1MGZnq+QEaQQjECTlUX3V33fZ1jmWg5mNHMp00nYLWpxPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742242; c=relaxed/simple;
	bh=hSUwB2Rkn6GwUnqElF3ycdaKapO5eQPIfHXpVmKmQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0IKHopZNMtZrjTwdeUCo4+sFlBiNssTO0PjAMpaVC1Qazelmj75uOM79dleNNI5EnghM1tOLH4sce+2MO29XYjqmuLPV31eaHZo0aypE8vOoGT8Yxk9ZOvcB0m+30lI52B6wr9X4WMIKwrp6/b3h0uZz6nIAwTiqtA71vT7IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctk6BJua; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588b1so781185e87.1;
        Thu, 17 Jul 2025 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752742238; x=1753347038; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2lx5iA902TzGSJo4q8BNEZwisigf9Cj6fV1YQOnO5U=;
        b=ctk6BJuadoHhwsmyITDLRX/55UrO2Wr+/xFfIp1kMrPnhkJPUVq88/C8K3NphQc2CD
         97UQYtg9VEz7vdNYG7qn2x+1YY6Kohr4NxX1K0EXJgIJdF960ZvchatGyZQ189g5dnj9
         6ynTAJ4bP72DQ/cqPgSgTel1NheZH9ldJL2j0792CV+oVvJM1HV9pnMHVL+skisLhVO2
         /b6HbJIxT/RCaSips/NNaaiW6wvbQ/M84hXukgop0GDPCvBGjNWLJl75gnUm1eKgVjAb
         h513PqVh2xBBc1OG3Rhkp4pXR17CpAl399njfczNwbdTRhgXnd8W+6KQpDDx6/C5Tt0B
         +MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752742238; x=1753347038;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2lx5iA902TzGSJo4q8BNEZwisigf9Cj6fV1YQOnO5U=;
        b=ImgfZDA1uM5b5afRZ+nf5XAD/iGQdy542mebzAfUajApbn4T1yaXwmgaxQgQGEPdc5
         X8lATYmt7b1brdk/HxBOba1hgYTBA6xh0TlVnwenZkgStsgOf3GqSiia1FG2smPFlD4P
         Z9aB9g1kS0L6Dp5pR6/sw700YQR/C3EGJHBOnItIOYIM99zfGoGES6gh/BM9vd6+BRxw
         jil0bjlUe9n0g3R8IkWipFCbnIJEeo6tKDTdvNrxZLZXlSBp0Vq122GfZI3L+IV3NTmd
         lNxbG4Q0Se5nIqqyhx/KB87y8h2yEiZ+DAPj6284yDgIXM8RUwpClUNFiEIb5HP0kaIB
         dJGg==
X-Forwarded-Encrypted: i=1; AJvYcCVWbGbjdiTK98Z0+n0wWL32pcDJTKB2X3ZIuUzxonmxm+qvCfqIALhSjxu1y4Sc5zkYFMTdAulTfmqUKVs=@vger.kernel.org, AJvYcCW8jXFJnPdZw94HZAo4tRWttL8hMXrgsw1NPCXPQSatfUW7W8REXQp7Cz/eUFQ5PG5lnb36jCHWL0cI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2k4T24YAGzoDrWUhr+yFsXn2Kw/uKylLqOM+8jEr5YiWzYSRB
	nuwcQ+WdyY8ipfbazBHQ92g3/+ojUPWmHQNBUvmBv40UHvzgViQKaYXx
X-Gm-Gg: ASbGncsx98XwhvychSev9B3uRFL9HFBgsSL5Q83ls6fgxKk6wld+mB18UNgQfMdJA/X
	+CY58FHRa8tEfpoJUGuMaT0uH8rYprSfPbe2R+ta6Zj+YiNRYzrkLhmOgFWIVDjEtxY0045ZIVH
	qSUyD7GZ1P3HINNQ/ccdKJGA06utbP6QC4VWPjSR5z9pzhGWsBXb6iCHXpcdF8DzDOXB2uyyrNd
	yuq4jjTu6DfiKrJVZgO3J7b/lEyAqRD+ZTM1YVSrFkG7dmHKansTXe0RWzcPbiIyKvoYDFSRXLG
	yKcQem+0RmONHupoFzVe1PKf7NJaKqIumzy7uh/ssQmggsrokc3KVnOyuQNk9AriQCp6u54AmUY
	9SMvXMUTT4AUQU9X5xb5zGDQco0dC8W/Ao79n/TOspxeBNv7ZgnU=
X-Google-Smtp-Source: AGHT+IGSxV413k604UJGtlq7ScVSWLRihC73xMIQWa9p1uSC0wY+k6OBC7dQeJxyoKd3yhuZShec6g==
X-Received: by 2002:a05:6512:ac8:b0:553:aa60:faff with SMTP id 2adb3069b0e04-55a23f0e640mr1656819e87.23.1752742237872;
        Thu, 17 Jul 2025 01:50:37 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d08f3sm2941950e87.103.2025.07.17.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:50:37 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:50:36 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Konstantin Evtushenko <koevtushenko@yandex.com>, Sergey Bashirov <sergeybashirov@gmail.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <gveqi6a4a7zt2v3iytoold5y2fevhzm5vaokelfpwkdzbiuwed@edr7ruel66ga>
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
 <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
 <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>
User-Agent: NeoMutt/20231103

Hi Antonio, Dan,

I have an idea how to refactor the code a little to make the static
analyzer happy. Will send a patch soon, but first I want to check
that it won't affect functionality.

On Thu, Jul 17, 2025 at 10:01:42AM +0200, Antonio Quartulli wrote:
> On 17/07/2025 06:56, Dan Carpenter wrote:
> > No, it won't.  I feel like the code is confusing enough that maybe a
> > comment is warranted.  /* We always iterate through the loop at least
> > once so be_prev is correct. */
> >
>
> I agree a comment would help.

I see, will add a comment.

> > Another option would be to initialize the be_prev to NULL.  This will
> > silence the uninitialized variable warning.
>
> But will likely trigger a potential NULL-ptr-deref, because the static
> analyzer believes we can get there with count==0.

I agree, this will most likely result in another warning.

--
Sergey Bashirov

