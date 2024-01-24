Return-Path: <linux-nfs+bounces-1318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C083B48C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 23:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9ECD283686
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362DF135406;
	Wed, 24 Jan 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="USzRvPvK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FF1353E6
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134383; cv=none; b=PlrgPph+KcTY9OtQx+J48NbKcFqjahT7sJWeifKJJ5Z0blD0Zdz4Bj/WwZnix+fl2kCOWYRJ8FR2N7Yo17klE+RdTtslXA1qyNgFts0oQGQtcken9QkqiDTiJb4v+BPbOSJ6eOatO4BW6Yr753/x41vKraf/AAfUHTmNc9lhmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134383; c=relaxed/simple;
	bh=VDZk1vtMdwVOY+6Q4gYe1lp1kvysWipMGdIezOZXxxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGilC52rxO9Hbbkxj+t3xAvIFycmfK/BddD5eyxqBuBNWKLT+mB5JCNEBV5fajvc7ppO45jEiBMwOIvYDhn8Kf7vHP5IAlq458txnJb/BKDqEYLcepJerFHdMTlqiI0Rec7mqXg2/eSN0giHuxUFooSC/caGSIObHNVDMDY6dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=USzRvPvK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-602ab446cd8so4966677b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706134380; x=1706739180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhd+Kca7spQQsikOOjtjYsc1ZcHEhwoAVzpYtf1DMQk=;
        b=USzRvPvK2bUSGKH9MyVCfrvCfHlFgThD3fjG/7DmMm2aFfizgYoa2AS3u0g2Bk8psw
         5nTGnTUz2ErEazio11KX1jcc5dOuCV8gK4BYmcyHMYNLuhs37Ok0QP04kJnwdmHdbGbY
         mX6JiqPkBUZ/LcTVpjYNjJZJYD0xpzLg/niuutfy8pCsZW9KE8kFQ4q6N60FAznsa4Op
         YJpWCi9EXInrywHRGjm5b6w5ypT202O0uYwm+VOs8Hhk+MLri6cNcvWGoqQbRkoCM1aX
         WnTYoQaBrAzYQ+88nZljNihDGD3h8HehiUxWKO3dXkFn0QLHoUbPR/iJ6jVrN+dC+JdW
         D1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134380; x=1706739180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhd+Kca7spQQsikOOjtjYsc1ZcHEhwoAVzpYtf1DMQk=;
        b=sCNp726ZpCwXEHs1tewc6Fep6HzTFR9yOCIC9Rm88s+EuUlafm2I6mT7WbwT34V7gS
         uW7BLcdhD790LlaBpVnX8ZUejUIAhedr1Vs1vFsm9LqIWG3KaeXjrViLLJbWHpzg621X
         es7odUylLK1sdce3VQP1pNSbux5AKmC59xA9FIUX8xbcxVgrNvl1KdFbCGuQGXSw7jqK
         eE/sxGikeNOhJMGyEeab6+POKcTU4H1nFK/T4TbPDwL0p6C/P8no7s4B728jxAkIOKGe
         zpOSEWDQgPm6INWo3v+5XtM7me9KVv64JV08yxpFGQA7RiDQqRaIPjrRSGZztZoxrvt/
         vxaA==
X-Gm-Message-State: AOJu0YxBZqYLUM63m0hg2Zv4Q8yDVsyPxgEOOTyjpZIDzYE5cOEiTd8f
	doLsyIeZClCiENwm5sevtcSVnakDE4ChoblNm3Wp1mceegEalIvhDVT0CkSRs2o=
X-Google-Smtp-Source: AGHT+IFhTjITix10LeXMj/qmMHGbYykokokLT8B4udSlab8QvceU90buFBmCpHMhnAguTSDRW4u2rQ==
X-Received: by 2002:a81:7c8a:0:b0:5d4:97:8b51 with SMTP id x132-20020a817c8a000000b005d400978b51mr1631278ywc.4.1706134379937;
        Wed, 24 Jan 2024 14:12:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05690c250200b005ffde38415dsm225059ywb.15.2024.01.24.14.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:12:59 -0800 (PST)
Date: Wed, 24 Jan 2024 17:12:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Message-ID: <20240124221258.GA1243606@perftesting>
References: <cover.1706124811.git.josef@toxicpanda.com>
 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
 <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFzxmV6zgi/TACb@tissot.1015granger.net>

On Wed, Jan 24, 2024 at 03:32:06PM -0500, Chuck Lever wrote:
> On Wed, Jan 24, 2024 at 02:37:00PM -0500, Josef Bacik wrote:
> > We are running nfsd servers inside of containers with their own network
> > namespace, and we want to monitor these services using the stats found
> > in /proc.  However these are not exposed in the proc inside of the
> > container, so we have to bind mount the host /proc into our containers
> > to get at this information.
> > 
> > Separate out the stat counters init and the proc registration, and move
> > the proc registration into the pernet operations entry and exit points
> > so that these stats can be exposed inside of network namespaces.
> 
> Maybe I missed something, but this looks like it exposes the global
> stat counters to all net namespaces...? Is that an information leak?
> As an administrator I might be surprised by that behavior.
> 
> Seems like this patch needs to make nfsdstats and nfsd_svcstats into
> per-namespace objects as well.
> 
> 

I've got the patches written for this, but I've got a question.  There's a 

svc_seq_show(seq, &nfsd_svcstats);

in nfsd/stats.c.  This appears to be an empty struct, there's nothing that
utilizes it, so this is always going to print 0 right?  There's a svc_info in
the nfsd_net, and that stats block appears to get updated properly.  Should I
print this out here?  I don't see anywhere we get the rpc stats out of nfsd, am
I missing something?  I don't want to rip out stuff that I don't quite
understand.  Thanks,

Josef

