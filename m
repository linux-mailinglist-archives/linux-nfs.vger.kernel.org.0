Return-Path: <linux-nfs+bounces-1868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41ED84EE34
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58943B21729
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CC15C8;
	Fri,  9 Feb 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRgM0slr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A681370
	for <linux-nfs@vger.kernel.org>; Fri,  9 Feb 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437404; cv=none; b=AhuS6q6LnQnDXC5Wdha0e5ciySlpkM4s2gEf5gjVeg+8VqtUu6GMReXyxwthGTqOyxc/N1/8EZ0sCwfPzlfPHyLat07l2Md8mI2JC/9xqwtuIb6PtgZkdbyuxX74uktEsJQA7oIHvBRN9WM1jLHGGEbLQKCu+GMqjbzbeglvOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437404; c=relaxed/simple;
	bh=JVN4qk0Fublj/mAv9u+YaFZnNpmOUrhqQjJh/6l9NYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tXBK0tK1Im518lJSEeGhxXj0BBgwTlt7YAtAaMq6dFdoRA9HF4UKv9e3wZq8a2fV69lGunRu9NR2Ss46P51pm+YXhazjR6ZsBUA5ijssuNx5nvZoMBYF0D6wdC7zMpbt13MQes7fYMZ8zuM0EPH7EIQ3dSDtTtdMhnipRHEwYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRgM0slr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51167e470f7so481574e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 08 Feb 2024 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437399; x=1708042199; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrwl2Jh2+QUYlCVTqrMD/48nJAwcte479Eawk8KWBXM=;
        b=NRgM0slrrSEToDXzeKqBEM2Ru7+DTbsH6iMXgNLZMGycoUCY3GngnT4rYg225ojVGO
         R/DMMcoiTQuBEiDCcTNiu4hK6aKxEnT5nqq2/IBVGGeJ4uaFKCqCBn6uURxfx2lB09AP
         +si0emmdHrKcNFfuUc7EFuGjrFxELROl7hfGFFjZAb5nPinD5nswTn5AbAoUgpNDHVDi
         xwkR/wrtCZDJMDX44fgm399KzfXkFo1LL5gL5tc+5ekDdETlcPACCKvvCJmvUS3z5/gr
         Ui++5PdnbPDFJFLpsesiH37Y2HhUx7Ow7m6chm43cJeFeG28E/hc0+GBy+IN2ld3PLDs
         P/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437399; x=1708042199;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrwl2Jh2+QUYlCVTqrMD/48nJAwcte479Eawk8KWBXM=;
        b=P6beUenGtkQg5Zpc4mE9Ow4YKwVFmAmAVz5AZizGSHzXTAm59LB5PAkb9Fps5/Q//Y
         vQzh6uu2IEJxUiWmELg4J2NONJXa84Uubv2B3ecuNFUYk9KFaol3wDdevCS6ID4s5jcc
         1pz7NN/jVzBYIY7aGYcmqRuTVSxeCnrW+7N6gckj+cY87aJ5cMomtLhVYkBQawFAlvON
         a6xalK7zo9miIhNP4pPQi0iVjvUrxs+EdWt+9rAOYjIlO8p8KdPj1vOBCq8/p947hsUW
         EGJ5R78VtZdODi/rab9w/y0Zl2LVfGU6ERBYriymc9MKTqG+FH8IaAr8kqykK9Eiyzgl
         nDKA==
X-Gm-Message-State: AOJu0YwTpB8dzYVBVSxOKvS4EP4jnB73XCkvYAU0Dc4pZF5yClc0oJDs
	+mwNE+lgpqcvK0z4z5oqqR8bICWuB29S0p+enLnOIhjWNy8t4KDfPzBgDl3f79P8jv77sEqzRxY
	ty+FC0WzoYAi1zlfBJkGaxm1efUHc+ZzKYnw=
X-Google-Smtp-Source: AGHT+IETwKfI0qkYqalPzEiNmXeTeVqNFjUksn8zVMpKCZmReGrwb+hASPM7taVaXFw2FEeGOzXXKAF56BtAhKN7TO4=
X-Received: by 2002:a05:6512:15a1:b0:511:75e2:6b5e with SMTP id
 bp33-20020a05651215a100b0051175e26b5emr287565lfb.36.1707437398997; Thu, 08
 Feb 2024 16:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCgNnNKHYDdC9-5UESONEgHL=D5jziJP6CkS2rnUhPBTg@mail.gmail.com>
In-Reply-To: <CAAvCNcCgNnNKHYDdC9-5UESONEgHL=D5jziJP6CkS2rnUhPBTg@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 9 Feb 2024 01:08:00 +0100
Message-ID: <CAAvCNcDt9XgpNvq_ZudShxEyyXq_YCMD6Jo-V_kwQARbkUHGsw@mail.gmail.com>
Subject: Re: Booting NFSv4-NFSROOT?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

?

On Wed, 31 Jan 2024 at 21:37, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> Hello!
>
> Is it possible to use only NFSv4 (not NFSv3/v2) to boot a diskless
> machine (aka nfsroot)?
>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd



-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

