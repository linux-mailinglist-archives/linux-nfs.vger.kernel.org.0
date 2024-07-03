Return-Path: <linux-nfs+bounces-4613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC2926C35
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9255C281472
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE518F2D9;
	Wed,  3 Jul 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j+1cPsQs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3413DBAA
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047734; cv=none; b=JZ2qrXOKtmf17/V9SF1kAWLKDv14330y0lwHLQW1LosN/72GQmed5b30qUWsv7q7z+tvviwuqGkvKgt37oLZ/4AxuS0ypkO5aGH5ZesocGQMGKe2M3b6GTQADYraIm0FhrGjUFo1Z4e7dO4+E4i+8h/TGaBzo2Lo0+UL2/euoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047734; c=relaxed/simple;
	bh=b/tZudZ4MxQfNa6R4TJI1O0ixve9TnQVGqOVLhkkSHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PANFri18Y5bZeTWaoSJYmVlqsfaJCHbNhEuz2bDET4k2Bqm0E9UdgPohFZ2hw4lKlB+m2YW/MfFTsy1gM323q0ckAnncDPHWxmr7nTmOsnkyh1DQv3lbq4++/1w0mVjpCEFnP8GkzlHC+ZaNEtOOWkMMocJrP1zkzsKe4Redg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j+1cPsQs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so501805ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jul 2024 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720047732; x=1720652532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ8689AvEPkediPvUKKNjHlFAD8V9KTAIbnDO82hhz0=;
        b=j+1cPsQsz5fytIJ+RqfR0WhTiscQEvMuj8Z274BiII5YGlagYMsoIhjlsMlL02YKO4
         siQqZm+hwfDuPBvHKGImpO3ySk2Uvp70LXtHnd2WfbgWKN6AYrXaosISiP8uxVWquxfw
         GOtm/fOP1CHU5jZ79imeW3fj8A+xbnKzi0ylZadyYAyIwQhKsuVr80MBM0R0dKrzuB3R
         HtMl2LczpmTZ65lr2Sn+ikGyBHtBkfnLM8yeYfTSI650ylUggu2EkAHM+K2enJrO9Cc9
         Z/sTnoW8qcXFwFeKFA/VEIMK2MkBLEqJyi79aixQFuYLyFEPuCPRkjv+jLt96d0MgLL/
         Xx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047732; x=1720652532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ8689AvEPkediPvUKKNjHlFAD8V9KTAIbnDO82hhz0=;
        b=kgyzAvK5K588DHLWGJl+Oy66yHwNrOgBXr3duzDA5gt+3hkGJwPpGKwx1J+e9YTbQr
         2F8hqTWpRTc7SGlWV0rYrKK4qNCclNHx/bBSG834x8VDCABl0iSc/j1F7VkD5fCPaKTU
         +B357OUYTvL+/d6WrNpZPJjL1POkDlV9cqaP6BTMKrzDpiYKUuG3bPTHNFUUaVauBiIe
         x9wUAfnlg/9KAAOXNPllV8ywdEuRXTb/N3yZwf1la/ixrKebQtwLGfmZ9SYTKpHrq4xJ
         AJ8C1M6hbMLwqcHnuqmhM/lhUwAqagrQL60/w9SJlJrymnlY/kdage2GNZ9vjSTwynmD
         DdQA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kyZGTlB30prcG0/xldBmZkSjQSK5znhV+R8aQl6cs+C8X6DM4Dz5nKBZRgeatue9mcCNHV6kfZQC+I/lEBuVMl+y+WeeU0AP
X-Gm-Message-State: AOJu0YwZku4jhBqFOeiqBq4aJESc+A39ds1VlT18BjHuHjsKSABLHpqR
	jsV3xMKNY7TYCkx9o0aiej0ds2xW8ptAA9bq19e7S1MOXzzRu0g0UTajVH0oVTYB1VjQ4BkliC5
	D
X-Google-Smtp-Source: AGHT+IGLJxyk3WkMtbQ0yuAmN9CXHoHO/7sN9iAr/E8zwGNefnoIPl0V4O+kd0pz+bQHVaJSp5nwAw==
X-Received: by 2002:a17:902:fc45:b0:1fa:d491:a472 with SMTP id d9443c01a7336-1fb1a04e7dfmr47354265ad.11.1720047732469;
        Wed, 03 Jul 2024 16:02:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb2f38983fsm3268355ad.18.2024.07.03.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:02:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sP8zJ-003BI3-2e;
	Thu, 04 Jul 2024 09:02:09 +1000
Date: Thu, 4 Jul 2024 09:02:09 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoXYcbWmYouaybfE@dread.disaster.area>
References: <>
 <ZoI0dKgc8oRoKKUn@infradead.org>
 <172000614061.16071.4185403871079452726@noble.neil.brown.name>
 <ZoVdAPusEMugHBl8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVdAPusEMugHBl8@infradead.org>

On Wed, Jul 03, 2024 at 07:15:28AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 09:29:00PM +1000, NeilBrown wrote:
> > I know nothing of this stance.  Do you have a reference?
> 
> No particular one.
> 
> > I have put a modest amount of work into ensure NFS to a server on the
> > same machine works and last I checked it did - though I'm more
> > confident of NFSv3 than NFSv4 because of the state manager thread.
> 
> How do you propagate the NOFS flag (and NOIO for a loop device) to
> the server an the workqueues run by the server and the file system
> call by it?  How do you ensure WQ_MEM_RECLAIM gets propagate to
> all workqueues that could be called by the file system on the
> server (the problem kicking off this discussion)?

Don't forget PF_LOCAL_THROTTLE, too.  I note that nfsd_vfs_write()
knows when it is doing local loopback write IO and in that case sets
PF_LOCAL_THROTTLE:

	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
            !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
                /*
                 * We want throttling in balance_dirty_pages()
                 * and shrink_inactive_list() to only consider
                 * the backingdev we are writing to, so that nfs to
                 * localhost doesn't cause nfsd to lock up due to all
                 * the client's dirty pages or its congested queue.
                 */
                current->flags |= PF_LOCAL_THROTTLE;
                restore_flags = true;
        }

This also has impact on memory reclaim congestion throttling (i.e.
it turns it off), which is also needed for loopback IO to prevent it
being throttled by reclaim because it getting congested trying to
reclaim all the dirty pages on the upper filesystem that the IO
thread is trying to clean...

However, I don't see it calling memalloc_nofs_save() there to
prevent memory reclaim recursion back into the upper NFS client
filesystem.

I suspect that because filesystems like XFS hard code GFP_NOFS
context for page cache allocation to prevent NFSD loopback IO from
deadlocking hides this issue. We've had to do that because,
historically speaking, there wasn't been a way for high level IO
submitters to indicate they need GFP_NOFS allocation context.

Howver, we have had the memalloc_nofs_save/restore() scoped API for
several years now, so it seems to me that the nfsd should really be
using this rather than requiring the filesystem to always use
GFP_NOFS allocations to avoid loopback IO memory allocation
deadlocks...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

