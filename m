Return-Path: <linux-nfs+bounces-16158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2CC3DA28
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 23:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E5D4E29F7
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDA340A7F;
	Thu,  6 Nov 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKKLEWGJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB62F6598
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468746; cv=none; b=qBrH8MYamIdErHcK+nFpE90DLdAqFAol4yr4Tvunk2m3L8cmnwvx242A7S0yRk683XhRjE9B63hLdI1xSwgP8kBiYQuS92sQgl25Y2yTYm0ymgBoJ13HVFGvr8+Hz42Xj2J3h5u1cB6JVBtXHxiFyiw3oBMdCClgeDr613rFcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468746; c=relaxed/simple;
	bh=dQTtWWtvyzc2H7Lp6EdqwIpKqIiuFeQg6mnqpqIuOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkMgyMnJvcDvelY2n5BPXi4Y/MPHhDPEbbWNoRLXVtJOB29wdgEK8LDMV0PcJNsHW+uWuDFR4S44S1aICVk6o2eP1tcrbBv+BIcFHWEfxTcqkq7rH+8yWZLx7GuhCsaS/Ev9Ihyviyh0UhdtGxUuQs0vqwHMlxkCAlUuhEa14kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKKLEWGJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so477555e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 06 Nov 2025 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762468742; x=1763073542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvmO56TQZyZt1WfBUK+dQBCPcTJ2tahvqZ92g11w3Cw=;
        b=fKKLEWGJ/7fMoXWTubL8X9pvGzmsg4nOFuCC4yeDShjbzkLxFUOfXXvMjHtS0c9UU+
         MIZpY4fObsWq6nPzeHss4IAfKDKx1FXZsDijTQr2/os0Ct2Bo87h8xBcYOvyJUnNSQgk
         mjvCNPftz6EtaVJbNqSsGA6icjaq9h2bJY0RW5401PgiJQ7PQuXobqQiz5eeaNkAX7Yt
         2mqV2pLsqWqG23HuWT0xeAca8WmO/nXGjqn9hiSaZSMic/ZxsGbCRJ5djKwTdooHcMkB
         jzi9DvjPz8xIIv09bNPOL7yuncRdlH/R7eHL40cM8MMAhanEjX6cqRvMTmO9P1HvtSEY
         3KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468742; x=1763073542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvmO56TQZyZt1WfBUK+dQBCPcTJ2tahvqZ92g11w3Cw=;
        b=nIRiNv0OHUtfYhix+J1OaJzFWjF4KkHi9RoXstVnn3GXl0Q2EFOHN8NsyAsClg6fFK
         xfZTz/9TRydqWWh3Y9aEDBztOIx5PuAHAFtiDN+LAG4MKPudD8cMDLlULyLxCuwRfR04
         KO5Ab9Ayoj8odiCzXRN/M/f/SIJg93GWLpnLnU0M/nI7dCIuUh8PuCO9CnyTq2raR8ar
         2PU5o7zjjDSMX90zrPZhr0BpSUTDtzz477mEWQz51AqiRYH53XLrfNCtMeqwB0jcgyfc
         QDgis3AjDxl8HqZMiV19EztYHMvtSVFim48cPIOgeCUcVFv4OWYZR70V1HdubgxL9Eoz
         IZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzmlVmpXUvpUXGOnGvOqWQKAAyYrJYOrG0IgVzyTZVpLnm70b7QHMrxoVktHqxjoYOLzPeu1iBQQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYRf5IgmXj02qBU7kY0JsDqvDMlV+UUqILoUqzU+qSGNXdG7x
	Fo7hz6U6SHCdQihTxIxBL6e9WqPjC6t3X6AB0kb6qOSGDZUH2nI5OQLE
X-Gm-Gg: ASbGncv/lMEO0ueIkvH5VImOwqYynb0PmeNEFvdBSXLBewFXQpXOLstHFPYKqAXYdWu
	2EiAb0QZVFS2u2CEBMx4gSG7GObs9iiv1lszo0tAKTZBqykDWvlKsaNxfq21K5gwt8foKPWoMFY
	nOX4w0MbexglF6dOnKE2fiIvXncSW6CIYdll6lJh47e+O9o5G4MvWVBNY84BcIRYEhBNUju+VUK
	EA5I8MaWDdmts1CWWT5WAroHOww6vH9RgV/N4942KcOUw8xAKAYflSYX5+ZoArJ/EqiXSJAfa3u
	RrfUMgIRtPHrU8C8Fj83097UCFbj5Yph5QlapkJgGMkEgj8LdDCuhMkTqmzd5/9AOZrXNGzhW7r
	N2SkAFaRfpW660hhLV+yLmUyPHT8Du+ti2x6KvRQiVIZPclyzyqxTyVJB8fVkqyRYZQjAcxHnTA
	QFKbwaXpuChkzp+OiJ1TCCRekFxZj2yR4TOkhmXXMMYdwu6dZfAhx6
X-Google-Smtp-Source: AGHT+IGp9VK1FmwODmkxmuo6qaCaABfSmuo0fPuPW2x4aPOG29B3ENDgha+amSzqAdhMgYqm+thjug==
X-Received: by 2002:a05:600c:a319:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-47761ffd202mr39663995e9.3.1762468742262;
        Thu, 06 Nov 2025 14:39:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe64fd90sm1530134f8f.21.2025.11.06.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:39:01 -0800 (PST)
Date: Thu, 6 Nov 2025 22:39:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
Message-ID: <20251106223900.3893d7d9@pumpkin>
In-Reply-To: <8cf5dc85-dee8-4e83-8f83-6b3411dddbee@kernel.org>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
	<37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
	<20251106192210.1b6a3ca0@pumpkin>
	<8cf5dc85-dee8-4e83-8f83-6b3411dddbee@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 14:32:34 -0500
Chuck Lever <cel@kernel.org> wrote:

> On 11/6/25 2:22 PM, David Laight wrote:
> > On Thu, 6 Nov 2025 09:33:28 -0500
> > Chuck Lever <cel@kernel.org> wrote:
> >   
> >> FYI
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=220745  
> > 
> > Ugg - that code is horrid.
> > It seems to have got deleted since, but it is:
> > 
> > 	u32 slotsize = slot_bytes(ca);
> > 	u32 num = ca->maxreqs;
> > 	unsigned long avail, total_avail;
> > 	unsigned int scale_factor;
> > 
> > 	spin_lock(&nfsd_drc_lock);
> > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > 	else
> > 		/* We have handed out more space than we chose in
> > 		 * set_max_drc() to allow.  That isn't really a
> > 		 * problem as long as that doesn't make us think we
> > 		 * have lots more due to integer overflow.
> > 		 */
> > 		total_avail = 0;
> > 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> > 	/*
> > 	 * Never use more than a fraction of the remaining memory,
> > 	 * unless it's the only way to give this client a slot.
> > 	 * The chosen fraction is either 1/8 or 1/number of threads,
> > 	 * whichever is smaller.  This ensures there are adequate
> > 	 * slots to support multiple clients per thread.
> > 	 * Give the client one slot even if that would require
> > 	 * over-allocation--it is better than failure.
> > 	 */
> > 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> > 
> > 	avail = clamp_t(unsigned long, avail, slotsize,
> > 			total_avail/scale_factor);
> > 	num = min_t(int, num, avail / slotsize);
> > 	num = max_t(int, num, 1);
> > 
> > Lets rework it a bit...
> > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> > 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> > 	} else {
> > 		total_avail = 0;
> > 		avail = 0;
> > 		avail = clamp(0, n + sizeof(xxx), 0);
> > 	}
> > 
> > Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> > with 'lo <= hi' otherwise the result is dependant on the order of the
> > comparisons.
> > The compiler sees the second one and rightly bleats.
> > I can't even guess what the code is actually trying to calculate!
> > 
> > Maybe looking at where the code came from, or the current version might help.  
> 
> The current upstream code is part of a new feature that is not
> appropriate to backport to LTS kernels. I consider that code out of
> play.
> 
> The compiler error showed up in 6.1.y with the recent minmax.h
> changes -- there have been no reported problems in any of the LTS
> kernels until now, including with 32-bit builds.
> 
> The usual guidelines about regressions suggest that the most recent
> backports (ie, minmax.h) are the ones that should be removed or reworked
> to address the compile breakage. I don't think we should address this by
> writing special clean-ups to code that wasn't broken before the minmax.h
> changes. Cleaning that code up is more likely to introduce bugs than
> reverting the minmax.h changes.

No, that code needs fixing. It is broken.....
The compiler warning/error is completely valid.
The result of that clamp() has never been well defined.
It is likely that it always generated the wrong result.
It might be that a much older version of the function exists
before someone changed a pair of conditionals to be a call to clamp().
That old version may well be fine.

	David

> 
> 
> > It MIGHT be that the 'lo' of slotsize was an attempt to ensure that
> > the following 'avail / slotsize' was as least one.
> > Some software archaeology might show that the 'num = max(num, 1)' was added
> > because the code above didn't work.
> > In that case the clamp can be clamp(avail, 0, total_avail/scale_factor)
> > which is just min(avail, total_avail/scale_factor).
> > 
> > The person who rewrote it between 6.1 and 6.18 might now more.
> > 
> > 	David
> > 	  
> >>
> >>
> >> -------- Forwarded Message --------
> >> Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit
> >> slotsize greater than high limit total_avail/scale_factor
> >> Date: Thu, 06 Nov 2025 07:29:25 -0500
> >> From: Jeff Layton <jlayton@kernel.org>
> >> To: Mike-SPC via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
> >> neilb@ownmail.net, trondmy@kernel.org, linux-nfs@vger.kernel.org,
> >> anna@kernel.org, neilb@brown.name
> >>
> >> On Thu, 2025-11-06 at 11:30 +0000, Mike-SPC via Bugspray Bot wrote:  
> >>> Mike-SPC writes via Kernel.org Bugzilla:
> >>>
> >>> (In reply to Bugspray Bot from comment #5)    
> >>>> Chuck Lever <cel@kernel.org> replies to comment #4:
> >>>>
> >>>> On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:    
> >>>>> Mike-SPC writes via Kernel.org Bugzilla:
> >>>>>     
> >>>>>> Have you found a 6.1.y kernel for which the build doesn't fail?    
> >>>>>
> >>>>> Yes. Compiling Version 6.1.155 works without problems.
> >>>>> Versions >= 6.1.156 aren't.    
> >>>>
> >>>> My analysis yesterday suggests that, because the nfs4state.c code hasn't
> >>>> changed, it's probably something elsewhere that introduced this problem.
> >>>> As we can't reproduce the issue, can you use "git bisect" between
> >>>> v6.1.155 and v6.1.156 to find the culprit commit?
> >>>>
> >>>> (via https://msgid.link/ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org)    
> >>>
> >>>
> >>> Yes, your analysis is right (thanks for it).
> >>> After some investigation, the issue appears to be caused by changes introduced in
> >>> include/linux/minmax.h.
> >>>
> >>> I verified this by replacing minmax.h in 6.1.156 with the version from 6.1.155,
> >>> and the kernel then compiles successfully.
> >>>
> >>> The relevant section in the 6.1.156 changelog (https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.156) shows several modifications to minmax.h (notably around __clamp_once() and the use of
> >>> BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...)), which seem to trigger a compile-time assertion when building NFSD.
> >>>
> >>> Replacing the updated header with the previous one resolves the issue, so this appears
> >>> to be a regression introduced by the new clamp() logic.
> >>>
> >>> Could you please advise who is the right person or mailing list to report this issue to
> >>> (minmax.h maintainers, kernel core, or stable tree)?
> >>>     
> >>
> >> I'd let all 3 know, and I'd include the author of the patches that you
> >> suspect are the problem. They'll probably want to revise the one that's
> >> a problem.
> >>
> >> Cheers,  
> >   
> 
> 


