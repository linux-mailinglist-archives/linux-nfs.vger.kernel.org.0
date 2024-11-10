Return-Path: <linux-nfs+bounces-7834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D822C9C34FC
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E42816D0
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B89157E78;
	Sun, 10 Nov 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WoHpfVhP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33FC157487
	for <linux-nfs@vger.kernel.org>; Sun, 10 Nov 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731276544; cv=none; b=YHXwiwDlvxB9/njJUMVM3FFkfQoApCNjbJ7BQBn9oTSwpvVq+6ppqjhdjAhIng6svba8IqcmtiPHzEecfArSqG6mUmPJcE3f86ponE/GLQV9JPYlkaHRAKGl87obLI6WDlstIVfTXacGXgqcImREyXqa8TJkSZKUtKbrwj8AVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731276544; c=relaxed/simple;
	bh=0MQpXldGbOUiOX0Q59t4XbUm1yl5q3vOpFkNG4YlEq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9wXkKLP90MU793fhao2AA1ONf30eAIHiiqIm2Ko7figWfHGOOQBGznvvIcMHSefAPS9x6GbYdvtLmunCLVCbjlgUhrDtjtc/78O6vg5QgTFP7eGvEXLi1vTwMQuButilKvUNCPYUF1mkA2wGYe+vzt0isKahuLsPweSp8OROf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WoHpfVhP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed49edd41so703698566b.0
        for <linux-nfs@vger.kernel.org>; Sun, 10 Nov 2024 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731276541; x=1731881341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=WoHpfVhPFmF4qtrm5+pQzvO9gtw6BzwxXh7kzuXxqPAoNQvqzRhAC4MzAM6dSLkvQy
         rIfEulAAy1WKOBakV1C7fXrs9jIeFOF/InT87rzGjcO8KefuwVTpKG/QubfF7Ya8uOCt
         GjkJrhTCpTH8KdMtrAsvKAtykA/cNbqZf6wC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731276541; x=1731881341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=GfvQhxfh3m9eyGVl1JrZ/ZVI3Cdu7GJkw3qq+OjgJP8zB6Pt0NUP3z2G8eaZk2RktY
         0Yp5I0JleerE1z0MnyPT/2/TwPCWC83RnNupD5Tq+SOyDjnghkSAfbX1kEphCK3a/Q0T
         o6oZsfO06kbqvFv5CwKMmsd/znfQJKDUw7oMDiJlZcpf44LPnvMXbXmVyJWxyEgk9XSN
         ullvMU9HnxJyy/bsxdBlX1M9Ju9v/BQIrLdhGFYZH7EqFGRKcY0aAtAuQtraiRn7vle4
         d1im53yuGiAKkN6MQhd84f7s6tXqp7gHiMJxVnW5meIDVZI3xvjujsq62PfDyWVsbOoa
         fi4w==
X-Forwarded-Encrypted: i=1; AJvYcCV9taINPORxb8/pMnbvSF19OustVelbXWVecIxtBsc5xBtK2XDd4pSrd3QY8x8+DFq2JDkovQ2H+jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCedZYcWSg+p86R8R/uC2VTH8vGYHvT3+Jc40TE6ZeCL0XVWj5
	T5N2S6RJSgFpyzqhAnnRj/18IDjoDNwlu+/8xbK87K/PCcIWeeJYYVRUF/bNUq1hHQGNWJF/Exq
	h/Hg=
X-Google-Smtp-Source: AGHT+IFGJIwTN2jQnko0jhsRE00UMxG52urBrNvc28OxXeBP3B0lf46IoMBKZNIoOS2kkvh+23LEqw==
X-Received: by 2002:a17:907:3f9b:b0:a9a:c57f:9634 with SMTP id a640c23a62f3a-a9eefff1204mr1066708766b.42.1731276540796;
        Sun, 10 Nov 2024 14:09:00 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc56fcsm527300966b.125.2024.11.10.14.08.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 14:08:59 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4811082a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 10 Nov 2024 14:08:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKwXUhvF142JjuVWEhKOCY5pajxlwgB7Ww9hjsY/8S5662BcZmTFzYw/1YFuq7vIZ3I+16cKm4MAA=@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:82d2:3168 with SMTP id
 a640c23a62f3a-a9eefff1525mr946225066b.46.1731276539301; Sun, 10 Nov 2024
 14:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>
 <ZzDphC-x1XEFlDvD@kernel.org>
In-Reply-To: <ZzDphC-x1XEFlDvD@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Nov 2024 14:08:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Subject: Re: [PATCH RESEND] filemap: Fix bounds checking in filemap_read()
To: Mike Snitzer <snitzer@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, trondmy@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 09:12, Mike Snitzer <snitzer@kernel.org> wrote:
>
> This mm fix is still needed for 6.12.

Thanks for pointing it out. I've applied it directly,

            Linus

