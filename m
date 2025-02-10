Return-Path: <linux-nfs+bounces-10033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E2A2FE75
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 00:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFE016080C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75501BBBCC;
	Mon, 10 Feb 2025 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hMBjNAoG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362F26462B
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230388; cv=none; b=uNIDI5XLfx/Oa3RIultv3NondtVeKMGofMqPTFFO1CNz0vjBPDkhPtVVzMc83E2HYWhzxvebpOhr+NzT33d9eLor62x/b/40kDcBG9uOhuST41dmNJlUPKMUHO2dNQ2+6te+v2zf/Ohwf6F2zLgK21C+uJuHoaGv/ztqRw+lP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230388; c=relaxed/simple;
	bh=txO7Ya6DoxHHxCZ4RfwMENAZ6TM/9HqgMNXY08WQ70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCOUtWyo2P5n+C1eCAwSTlYF+4uK/H+TXESERHgoj9tRdsgDTp5QtZEBN7J4c+FYj8BZhl0weBTg5nBWlPYJ786Hnq1ppawTPf3zdzu+tSa3XTlg1YQw+hoCkadZIMhU2xgzKe6Im+S6QX+Fmo6mmXLrt+TVRlc2JylvqSTxpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hMBjNAoG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f78b1fb7dso32574625ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739230386; x=1739835186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MzfkEVGPxMfAlGlbr+KYg64Hw4CZerHEmjPwp/b/sk=;
        b=hMBjNAoGq2xfLMIhDfm4TTbvJaVkmSbaK8V2h/7XEgnOQyx2sSO1a7mofttEptoEOY
         96Lgxi0z7GzsLpkGBOOR/chP3XK29SD8mMvVCEW22qDYj1Hi1YRzL1mQ0jUWJA7bmEso
         MBuqYw/FZkiiIeMJlJW+FR4OpzgXJlofflfH8uFr6KiDr8W6kLGklVZ5r3HNKnWKUR1+
         lJ8oAc5qg1JbpzbyEWFUbIXoPzoYSPEQJno6w6X6255URaTqJAq/Gf/6oj82CFDqB203
         RdILFUbtrJF4z3g0x89uyCZWkhiYJB5mZduR2GfJd3k4UI/c/78arovMr5c82FGIkNcZ
         K8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739230386; x=1739835186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MzfkEVGPxMfAlGlbr+KYg64Hw4CZerHEmjPwp/b/sk=;
        b=YUKYZnEnXOEN+rjZzxuGKgdNiD4qtsaLcZAUVMhnRe9Dt64i9VIf/bKOqzNivuQAYv
         xgvEfpZX0LpTQOwqg3BuX33r1MJgCC0BM7GxnXtC6hN7WigaT4ChbxHmpVFgOtuSvnds
         Dyvr5o67HE22Lpj8OOJuqkFIG4195doAF485TJ+tHmL10aYAwyuSgNGXGoGbU1HVPKRa
         Y7xmbEyNaTy8JsoVhYWuW65BALgoGW3GTdfMaSkhHUeR4P0qVRq5Xq5f/HXEsthp9J7D
         9J4x+2xAD425TOFPSMLJg0dwHfYjGg/bRbNCMebgrRyte/5B6kzDQfFB2w9qOjTbs2G8
         dPUA==
X-Forwarded-Encrypted: i=1; AJvYcCUHDPG/4fmEbB6GStbrTOHdbS0RMsOAYavUK+rWBAyLOjfFAVbtpl7S4+WyAfDzT8VP1uMT6+AG9I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbeWCSqeuTw0Sgz3dJoknlZZpbxk7t34dQqU9hHWIWfMtXDIL
	7cl/i4RxAUdn/qLi1ZV8QGWdY9Oa4+LWct7U7+bUhqSW7vA8S1l/utzJtitE6y5l93VqqedZ9Jl
	3
X-Gm-Gg: ASbGncujt3mcacxvsp2S34+cvFBz9ndlT8lfc45Sh+cZJ9QmMcnQKq8adDe3e5CtNmX
	hrgvJ4OgUikYo3ydOZKNgQ4DzzW6MOfwbDx4fGaBOmhy9f7HQylHVVzSGrJ4mI1K/Vu8DL0eeb7
	oMBglGqELlLSJqNaRZ/OSdxf69UOHsxyHBoFKAtr1uznHKpowCrxlfX1t+eHKOuPgTGAq1fLNC6
	zFx2A4mmn5Db7eBTOKNhSSDKkA7df+rMx+RqfvvMWvWjXEfX5jI7lCS13qHzEs1IvYEMzP/3+H2
	O/uabWPjHs/cYW0OREytOLzxMht3jCI55PD06V915+lIWHDXOU9nyBF/5CxMuGC7uGs=
X-Google-Smtp-Source: AGHT+IGVGj2S4N6CUBu0rV4px1gDH1azvJRZMVHrzcKiurkSpts5tF652RN1nu1jJ2OlOvW32A+Gtg==
X-Received: by 2002:a17:902:f60a:b0:216:7410:7e14 with SMTP id d9443c01a7336-21f4e7597fcmr263694285ad.34.1739230385987;
        Mon, 10 Feb 2025 15:33:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da40asm84953085ad.257.2025.02.10.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:33:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thdGw-0000000HEpP-3Q34;
	Tue, 11 Feb 2025 10:33:02 +1100
Date: Tue, 11 Feb 2025 10:33:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: filecache: remove race handling.
Message-ID: <Z6qMrhV11Dtcveja@dread.disaster.area>
References: <20250207051701.3467505-1-neilb@suse.de>
 <20250207051701.3467505-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207051701.3467505-2-neilb@suse.de>

On Fri, Feb 07, 2025 at 04:15:11PM +1100, NeilBrown wrote:
> The race that this code tries to protect against is not interesting.
> The code is problematic as we access the "nf" after we have given our
> reference to the lru system.  While that take 2+ seconds to free things
> it is still poor form.
> 
> The only interesting race I can find would be with
> nfsd_file_close_inode_sync();
> This is the only place that really doesn't want the file to stay on the
> LRU when unhashed (which is the direct consequence of the race).
> 
> However for the race to happen, some other thread must own a reference
> to a file and be putting in while nfsd_file_close_inode_sync() is trying
> to close all files for an inode.  If this is possible, that other thread
> could simply call nfsd_file_put() a little bit later and the result
> would be the same: not all files are closed when
> nfsd_file_close_inode_sync() completes.
> 
> If this was really a problem, we would need to wait in close_inode_sync
> for the other references to be dropped.  We probably don't want to do
> that.
> 
> So it is best to simply remove this code.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..b13255bcbb96 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -371,20 +371,10 @@ nfsd_file_put(struct nfsd_file *nf)
>  
>  		/* Try to add it to the LRU.  If that fails, decrement. */
>  		if (nfsd_file_lru_add(nf)) {
> -			/* If it's still hashed, we're done */
> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -				nfsd_file_schedule_laundrette();
> -				return;
> -			}
> -
> -			/*
> -			 * We're racing with unhashing, so try to remove it from
> -			 * the LRU. If removal fails, then someone else already
> -			 * has our reference.
> -			 */
> -			if (!nfsd_file_lru_remove(nf))
> -				return;
> +			nfsd_file_schedule_laundrette();
> +			return;

Why do we need to start the background gc on demand?  When the nfsd
subsystem is under load it is going to be calling
nfsd_file_schedule_laundrette() all the time. However, gc is almost
always going to be queued/running already.

i.e. the above code results in adding the overhead of an atomic
NFSD_FILE_CACHE_UP bit check and then a call to queue_delayed_work()
on an already queued item. This will disables interrupts, make an
atomic bit check that sees the work is queued, re-enable interrupts
and return.

IMO, there is no need to do this unnecessary work on every object
that is added to the LRU.  Changing the gc worker to always run
every 2s and check if it has work to do like so:

 static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
-	nfsd_file_gc();
-	if (list_lru_count(&nfsd_file_lru))
-		nfsd_file_schedule_laundrette();
+	if (list_lru_count(&nfsd_file_lru))
+		nfsd_file_gc();
+	nfsd_file_schedule_laundrette();
 }

means that nfsd_file_gc() will be run the same way and have the same
behaviour as the current code. When the system it idle, it does a
list_lru_count() check every 2 seconds and goes back to sleep.
That's going to be pretty much unnoticable on most machines that run
NFS servers.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

