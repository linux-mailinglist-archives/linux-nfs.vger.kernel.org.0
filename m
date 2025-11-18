Return-Path: <linux-nfs+bounces-16498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A10C6BB34
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 22:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0B6C229D22
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3C2DC332;
	Tue, 18 Nov 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVeopj1Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E271221739
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500644; cv=none; b=LbcnDB23sghbDdWtx5S4pIYkV5fCfvYMFH/Gb53jrZZscUGkBYKgkIRzKVbgjoBkCxMBWTuRWuEzSm4n28Iz7a6Ml+R22kCleoLjlbA8s7a0LvxPtoocs6rCc09wpf23s7lvQbLvfGgNoU4TZZQOUyW0jKznyRWlCTboQCrpSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500644; c=relaxed/simple;
	bh=CHGNxnP2dRC5gRiz5jo1RtLaXI0EgEg0QfSjGRkegwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5khm/1UFCL9oao8YGQqZ5obUIqAucBsUwKL6elwrKpOt3DpIYoah47wzvvxSds7DNnG9ckkYC+an+CZyTcHZWKMQZ6++vK62t7+PLzyzujFGuWWW3tgxO6gq3O0gY3bH3IpxkFNC/7IghlDmJwzrVA6sBAymSPqfCwPxm9fCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVeopj1Y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so3656841f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763500641; x=1764105441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/1B0ohMDe9gTMm64AEJT/zRWlaJlSs1dMj20p5G84w=;
        b=cVeopj1YzNnFvWAsNpTaT3uikGeDyP4ioUsYZ5sb1BbRsT3xDf8Mu3H1RUUYZz1rNT
         gmHVwhHFSCZ0R2J9dY2Pu7SduxD7hLCOO/4izzl+Wz7qs8Lw3MtZNLCuwkF4VtzlvqVW
         4UMe7G3avmj+tUocvwldcTXo/gWdQNeQBq5w7InYjJ6yTG6L9aatgOrm+2oLVAbCBTVN
         gWzx2i+S29kiQY4OCQFB/HRMQrb3cGHcwcxtYhFKuJdXu5V5PsdZj0Ng4xHzP8RhFad4
         itzImBYMfmJS4W1BdaXtiWd8rj75GczhqfmI4eggsNQ2vkVAYhMRcVoYIuF5ke7NNesS
         wxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500641; x=1764105441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/1B0ohMDe9gTMm64AEJT/zRWlaJlSs1dMj20p5G84w=;
        b=JzXqLdHuwEslVnioCGqm6OOX0pbXJPRo1FOA1IPp4YWCvMNowuZzTVqmZAkMoPnwXj
         y11Gk8qZyojU5X/MvReyQ6VZhJLcOVPdMcVx7yyYtUkML1fiS58e0WOcihGJf5GbEuu8
         cmfC0l1KrBzUVHAv245+HgRfczU6+395N/tENV67f6hj11jkXrRPGV60kEb1OWk/X6oJ
         bc4D0uydfoG117g+r0SXpaKi0KyjALs9VO75Vy92cKYT2CSRtDC8iIfVpBzpj/2lDHqv
         vg95CN5RrSexmdEO8LP56ozH6LKsrBNP5hx0U+mGWje4gV7xoiXom6ODQkDDrmUP3Mpw
         uKvQ==
X-Gm-Message-State: AOJu0YzeFQ/5W9zrrlAv9UnPCOq4wEEgZkyWeg6ojelyG1kKfOGiyHGj
	bewh5Cl676IFb+PVRfn8YCtqKmK0X4nGBQ2JCJUrikRxCydDjTUVFduRWaHqTw==
X-Gm-Gg: ASbGncs03M4ZS5E+RghGTp4F6hG84mH4Ievx7mW4WAkksrFuLuh6lnjCoPubydZRJmD
	Q859P0DbxnHhOTOQ3LyQEmXzFCwxxjHsjz1s4YFydbMmkDRqwttXrkcjanyw+AdvKm3mI15YLlX
	aUOut8YfA/U/uLTFG90z84IENXyVzgIGRjFXu592wo6PhoLS1+Qwoe2S6dwcD96Q5q+bD9QzX/w
	YittVCvJ91kV6mOACABLHaxO48ZBwWAMOa7bHbRGJApMvqrc18at9sJsyjV1Ynu1wZlfPWJLbwz
	5PSaUFOC+bPYmZ5TRxD4idshUMOFjxK/jdNJWPbICi3JqiH74/dk7rLNrpBqaN0fZSPxteFlLPA
	/vgPfwfsBiesNBuwhWCONf6jZkDrrxMVwBDJ6PEF1Z7dc9d8JaWR4fdx90bRT6j4WmKfCTnqitX
	yCBjEDpTskFDmBEjv4rV1O2lEqw2h+meJ7EKVRuT4Tkn0NlnfIHXyxHE6yVpDUTxM=
X-Google-Smtp-Source: AGHT+IEy8hQJw+8xUd0JEomG1xKZACwDL8RYHGd+36FCWbFJAajR9Gdiv+7updTaEhFfK0Jumlsdtw==
X-Received: by 2002:a05:6000:2f81:b0:42b:2c53:3aba with SMTP id ffacd0b85a97d-42b59339417mr16166770f8f.10.1763500640615;
        Tue, 18 Nov 2025 13:17:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm33855555f8f.1.2025.11.18.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:17:20 -0800 (PST)
Date: Tue, 18 Nov 2025 21:17:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
Message-ID: <20251118211719.14879eaf@pumpkin>
In-Reply-To: <f89eaa5c-886e-4dc1-ac69-27ff6fdcff6e@omp.ru>
References: <e0d1a313-f359-4ad0-bee3-3fcf0ffc0cda@omp.ru>
	<20251113224113.4f752ccc@pumpkin>
	<f89eaa5c-886e-4dc1-ac69-27ff6fdcff6e@omp.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 22:51:09 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> On 11/14/25 1:41 AM, David Laight wrote:
> [...]
> 
> >> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
> >> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
> >> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
> >> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
> >> field is multiplied by HZ -- that might overflow before being implicitly
> >> cast to *unsigned long*. Actually, there's no need to multiply by HZ at all
> >> the call sites of nfs4_set_lease_period() -- it makes more sense to do that
> >> once, inside that function, calling check_mul_overflow() and falling back
> >> to 1 hour on an actual overflow...
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> >> analysis tool.
> >>
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >> Cc: stable@vger.kernel.org  
> 
> [...]>> Index: linux-nfs/fs/nfs/nfs4renewd.c
> >> ===================================================================
> >> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
> >> +++ linux-nfs/fs/nfs/nfs4renewd.c
> >> @@ -137,11 +137,15 @@ nfs4_kill_renewd(struct nfs_client *clp)
> >>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
> >>   *
> >>   * @clp: pointer to nfs_client
> >> - * @lease: new value for lease period
> >> + * @period: new value for lease period (in seconds)
> >>   */
> >> -void nfs4_set_lease_period(struct nfs_client *clp,
> >> -		unsigned long lease)
> >> +void nfs4_set_lease_period(struct nfs_client *clp, u32 period)
> >>  {
> >> +	unsigned long lease;
> >> +
> >> +	if (check_mul_overflow(period, HZ, &lease))
> >> +		lease = 60UL * 60UL * HZ; /* one hour */  
> > 
> > That isn't good enough, just a few lines higher there is:
> > 	timeout = (2 * clp->cl_lease_time) / 3 + (long)clp->cl_last_renewal
> > 		- (long)jiffies;  
>    Indeed, I should have probably capped period at 3600 secs as well...
> 
> > So the value has to be multipliable by 2 without overflowing.
> > I also suspect the modulo arithmetic also only works if the values
> > are 'much smaller than long'.  
> 
>    You mean the jiffies-relative math? I think it should work with any
> values, with either 32- or 64-bit *unsigned long*...

There might be tests of the form (signed long)(jiffies - value) > 0.
They only work if the interval is less than half (the time) of jiffies.
Such values are insane - but you are applying a cap that isn't strong enough.

> 
> > With HZ = 1000 and a requested period of 1000 hours the multiply (just)
> > fits in 32 bits - but none of the code is going to work at all.
> > 
> > It would be simpler and safer to just put a sanity upper limit on period.  
> 
>    Yes.
> 
> > I've no idea what normal/sane values are (lower as well as upper).  
> 
>    The RFCs don't have any, it seems...
> 
> > But perhaps you want:
> > 	/* For sanity clamp between 10 mins and 100 hours */
> > 	lease = clamp(period, 10 * 60, 100 * 60 * 60) * HZ;  
> 
>    Trond was talking about 1-hour period... And I don't think we need the
> lower bound (except maybe 1 second?)...

If 1 hour might be a reasonable value, then clamp to something much bigger
that won't break the code.
In the past I've used at least twice the limit from the 'standard'.
I've also had methods of setting values outside the limits (useful
for testing timers that are supposed to be at least 10 minutes.

> 
> >> +
> >>  	spin_lock(&clp->cl_lock);
> >>  	clp->cl_lease_time = lease;
> >>  	spin_unlock(&clp->cl_lock);  
> > 
> > Do I see a lock that doesn't?  
> 
>    Doesn't do anything useful, you mean? :-)

You can think of a 'lock' as something that locks two or more
operations together - often just a compare and update.

That one is (at most) a WRITE_ONCE().

	David

> 
> [...]
> 
> MBR, Sergey


