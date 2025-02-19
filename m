Return-Path: <linux-nfs+bounces-10190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5EEA3AD19
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 01:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA583AA57C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E996819;
	Wed, 19 Feb 2025 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bv+2Rdim"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5A4A0C
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925230; cv=none; b=LyaHF+L3UHc9bYRLzGLa96Mco/EqqrqawCqVFOrpHDs/PKs1vROUMZW/m+Tte1Z1qGVsd7uVohMNpS8f+c4gUWS7MsXQN3dJ+ZHKVUhxlMSztMoMt3tK2eRzRdpyVg7rbsDEbYxAzi2PBalrPFMybrYKjFn8CukrW/9kmpzYuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925230; c=relaxed/simple;
	bh=HoyPGLrasPZ2pB0g6Tk04PdbTAOef25MqLLcDifcr74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTK+XfQKkg/AGmdeCR31TGyIqusrIF3S1SzD6lgVyfJZyzBst6U0hBKHb4YsMOwkTRC2eL+Uz/k8Rji2mO1RJJNseTcyCFOYodamNeN0vWDlFh+UkvNi+qBhUu6OsdXRi4vhCZcT6jZr2jad05vz00dq7nbZf2N0mv8cc7NDLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bv+2Rdim; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22128b7d587so52060505ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739925228; x=1740530028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEgP+FAyF5J+nWEqmUWydCyPMiCQ8DNsdbdxUFtCrao=;
        b=bv+2RdimtKxTzwc53W+FW3vhJPcVBOy4CV7T8zfy8fTOMO9IJi1ObY2mr2QP3PNrjD
         D/ER4SfW2yHh0fQHbMg85I7r7vk/CqDXCX2PIeeStjs/Eltt+y7jYveBRO1nwd61RvYL
         /Wwj4mulY1q90GFGxLRpAuLcG07l0YqX9Ucmqn80KmGvzwGAVu2NL9xzZ/wdDaJxR7R2
         QICWi0eCHXxvark4qkzRvngHOcIzwS8TkTBEkGOMDBwUnLvdzieTJMQq665hAwj0Scjp
         I66ITfcy5hWfGsutOgFoJ5WoG/+HZbXV3oLZfJk4lWr3En5ig2yJQBYzVkeVl23IMPOS
         xTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739925228; x=1740530028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEgP+FAyF5J+nWEqmUWydCyPMiCQ8DNsdbdxUFtCrao=;
        b=j7xmX9ki6eIXaxwBJ3s6PA8HS3685UqqoQtgeIgz81/VVA8VxetSiP6aN+kalhCIGO
         aVQyiYy0wOIdapIenXn7zwb9wjr2dMXP3Fr9zw/oTZesuhapqvKrljxzqMFONGVMcth+
         iBtb3CicVTpZLC/TttzSfyTVwkHcqr0dzkM83D7U+NWuugvXDwKFRfMJldKSeyCj0bD1
         6ZqLTww9Cj2vJUmwId9K8GSJ1fCsrQGJQDMr0qQ/lthdC8vxcXi5TBLTu3HFz2SzIRKy
         0VBlqP6wS9BnqAPpmBS5a8yoMgZ0IDqdWsJtZ3ykDTHA9L1c0SRTZ1HK+ku094U09xZq
         Ja1A==
X-Forwarded-Encrypted: i=1; AJvYcCWGwrYHLRCgviZhWq2r+ECwU9dnJIaXTndKmuLriGnAH1dbcBWwGztjmrrIgd5uejEZpdExZsLtPTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SkHRIffG5xvPYUXyJHTUb+gFjTf+bVaTWVDrmGdq64Yg089T
	mY2NEYy6pI35ErpT7G+LhqyWowFEAw8/KbQCmRtDD6kEQLhhOX+57oAiJfXxlEnjFW2oExVsUgy
	9
X-Gm-Gg: ASbGncv5YsZRrEsDWOXPXvVcKX04uWHqkTXApuZeT5UprzlGoY0jrqlVrVBYKzu1+H3
	YiQbVtNBoufk+HbTnBzDy0DwawVlVopvwvMht0uHl6Cy5KgeCDUiIUHN3LRHPxR/7be50pHyaA7
	pMBdzQuiE2lMN7Ed0WEdCcHH88Fr6GouQstEO5VliK2momIABaJ6dacOEmxIGyn41GHBsVwT84v
	eKJShmoBtgYh/KApldZgKCt9sc2qWx5Zu57NzwdgmK7BBVcP5FTc3KwN3GnhQNiZubUDaWOcmwc
	Y8N6wXsxYyR8v5EWpV2m+/V0ZdonTs6Oj+YkGkUet8/QKWq1v2PoceTu9ZsqKEDA7A4=
X-Google-Smtp-Source: AGHT+IHKCRdkAnyYyJGduiy5bdh7QzXX/teTSCDqUL9tvpZFPCM70ZWKVi/kcOujAI8PtnaR3V+TSA==
X-Received: by 2002:a05:6a00:22d5:b0:730:9204:f0c6 with SMTP id d2e1a72fcca58-7329df0143emr1988291b3a.16.1739925228546;
        Tue, 18 Feb 2025 16:33:48 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326902f401sm6958708b3a.60.2025.02.18.16.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 16:33:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkY25-000000031Wv-1Kxr;
	Wed, 19 Feb 2025 11:33:45 +1100
Date: Wed, 19 Feb 2025 11:33:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/7] NFSD: Re-organize nfsd_file_gc_worker()
Message-ID: <Z7Um6Ujm3DwC73gw@dread.disaster.area>
References: <20250218153937.6125-1-cel@kernel.org>
 <20250218153937.6125-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218153937.6125-3-cel@kernel.org>

On Tue, Feb 18, 2025 at 10:39:32AM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Dave opines:
> 
> IMO, there is no need to do this unnecessary work on every object
> that is added to the LRU.  Changing the gc worker to always run
> every 2s and check if it has work to do like so:
> 
>  static void
>  nfsd_file_gc_worker(struct work_struct *work)
>  {
> -	nfsd_file_gc();
> -	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +	if (list_lru_count(&nfsd_file_lru))
> +		nfsd_file_gc();
> +	nfsd_file_schedule_laundrette();
>  }
> 
> means that nfsd_file_gc() will be run the same way and have the same
> behaviour as the current code. When the system it idle, it does a
> list_lru_count() check every 2 seconds and goes back to sleep.
> That's going to be pretty much unnoticable on most machines that run
> NFS servers.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 909b5bc72bd3..2933cba1e5f4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -549,9 +549,9 @@ nfsd_file_gc(void)
>  static void
>  nfsd_file_gc_worker(struct work_struct *work)
>  {
> -	nfsd_file_gc();
> +	nfsd_file_schedule_laundrette();
>  	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +		nfsd_file_gc();
>  }

IMO, the scheduling of new work is the wrong way around. It should
be done on completion of gc work, not before gc work is started.

i.e. If nfsd_file_gc() is overly delayed (because load, rt preempt,
etc), then a new gc worker will be started in 2s regardless of
whether the currently running gc worker has completed or not.

Worse case, there's a spinlock hang bug in nfsd_file_gc(). This code
will end up with N worker threads all spinning up in nfsd_file_gc()
chewing up all the CPU in the system, not making any progress....
If we schedule new work after completion of this work, then gc might
hang but it won't slowly drag the entire system down with it.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

