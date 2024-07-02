Return-Path: <linux-nfs+bounces-4574-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D0924C68
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 01:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B8C1F23095
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAB15B10B;
	Tue,  2 Jul 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qmA1GX+j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314517A5B1
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964286; cv=none; b=KB8PcRpamx8aOOwRnjHUzF8w2HQZ/5TGuc/bs4IwRjqXABkGY48cNx9gbq7ItOHCvTGi1YA8PffXZkX+1jv1mKtuB9kSxEDp/g6IwBPu1Qo0t/HDrQmcXxhvONv0ytqRliCU1Xi55LlRzeKpl9PhzmThPO4a3eiKEkTF8xFCuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964286; c=relaxed/simple;
	bh=heOKtfnADzMhe/MoJhYhpLsd+GdXsFugF2eub9FrScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYs5cr6DsnCEr07baZFyHbsa3JOQkvcZ1ES0dzAZkHtLcQ/UdlzcdExJKYVl/8+9MY/deN6H9KXdNlmzWQipOeMavdgl8h4X0fxZXigYqVWH7Aj7cZFM2wAV41Sy0SaWb22VaGFmSrBOkfHgkfRqb3HBls9KhAcPBvBluUE/L50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qmA1GX+j; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25c9786835eso2804793fac.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719964284; x=1720569084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6du070xXmJymYEkb83ctmWy++Rs5iSF330UqSLYNCw=;
        b=qmA1GX+jeD44Nf2TCuil1bgkdpTUSUlT60TsgmIqFabhX1uSLnOFlRxX29w4hEEnzy
         T/UUS7TbigHqsgcbzE0HEOejCAG8WutcNCtV9Vp6FlUz6OQPOcfrpfBHnMCYtJ16b09X
         ogL2bCc8ghKwNoLqkGFxnG+vfe1GyH/9/3dbauhXYKIknf5Ks8YT5GJvTBeMC65BAvoY
         QFXzt6VKFLJQvJnHkIDVRpKXsA5TkOIzVZh/cvcdVrOr4CJpamBc8GAEi6B9RIhUR91S
         4RNVO3qX7tMrZi83/E2cLPIr9nzMF2MWu6pBgMqq8TlIOvKja+1dDHSmTHM+P9z43mUI
         Rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719964284; x=1720569084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6du070xXmJymYEkb83ctmWy++Rs5iSF330UqSLYNCw=;
        b=Y/G8O6IfHR9SmA6XefhU/U3PBESkpO+Mt9VaglhXI1lp/NwMCrLUlvTsWG8oRumIJI
         rFr5Alrz5nTJ5AQDUwqJpuzIPWZZiVFI71ziAoeTIz9509vn1LCjez9ueOzwTqjPj5Bm
         mVlOthwKEIjGZ27hcdCXYoci8fqL1fy6R7q9tTB9LANVEWZ7Tbr4rNu9Ver+/q18X0/A
         kRVureXtnSWDO2qh4yLlfVlDs2DkzJtdVFl3rKiKLxZzmBde3o+f/hmXFWBV+yBGyKyk
         behQzgK4EFDidLqYhkWFsSA+Nbgt1CpS/S7kNb/4Tm1q+NIAkVUwqZZ3AQIhtPPB24li
         9acw==
X-Forwarded-Encrypted: i=1; AJvYcCXdnoQbBdhOfYTp5qKbv3ro2NjJZNDvGYe2zMXYU1Q3ZYRhUvpkoZ4q/jOLJaNPLJjETDjBGqcZIR7bFgHGPJF+8SWhg7ffZrjF
X-Gm-Message-State: AOJu0Yy21Btm5V4DsU/h6lKq5n+OHWEneLk63n8obG0yHwM5C42dUmTP
	dNep8A6d4HX8fcig7nrMZa4JeHq/0+onQsYDIx+f64feOy29T8+Zek43vVJnqug=
X-Google-Smtp-Source: AGHT+IE46R4zd9/ivoUu+xK+/d8ah4zUHfBbtR8DaUUQK//8dih0yO9NWu4bkwyIHHyzpj2W21Egwg==
X-Received: by 2002:a05:6870:472b:b0:254:b74e:d654 with SMTP id 586e51a60fabf-25db340df76mr9180217fac.22.1719964283556;
        Tue, 02 Jul 2024 16:51:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044adb21sm9401789b3a.141.2024.07.02.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 16:51:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sOnHL-00230I-3C;
	Wed, 03 Jul 2024 09:51:20 +1000
Date: Wed, 3 Jul 2024 09:51:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoSSd5xp30iQ3YDc@dread.disaster.area>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
 <ZoHuXHMEuMrem73H@dread.disaster.area>
 <ZoI0dKgc8oRoKKUn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoI0dKgc8oRoKKUn@infradead.org>

On Sun, Jun 30, 2024 at 09:45:40PM -0700, Christoph Hellwig wrote:
> On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> > Oh, that's nasty.
> 
> Yes.
> 
> > We now have to change every path in every filesystem that NFS can
> > call that might defer work to a workqueue.
> 
> Yes.  That's why the kernel for a long time had the stance that using
> network file systems / storage locally is entirely unsupported.
> 
> If we want to change that we'll have a lot of work to do.

Yep. These sorts of changes really need to be cc'd to linux-fsdevel,
not kept private to the NFS lists. I wouldn't have known that NFS
was going to do local IO to filesystems if it wasn't for this patch,
and it's clear the approach being taken needs architectural review
before we even get down into the nitty gritty details of the
implementation.

Mike, can you make sure that linux-fsdevel@vger.kernel.org is cc'd
on all the localio work being posted so we can all keep track of it
easily?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

