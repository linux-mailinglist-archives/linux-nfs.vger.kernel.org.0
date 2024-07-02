Return-Path: <linux-nfs+bounces-4525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B36923E5E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BC4B2353B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B511849E3;
	Tue,  2 Jul 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mbJBlOH6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CE16F858
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925494; cv=none; b=qAHSE4HBu1w1JFzXMHjoKndKhRS40oaKgkWYhxiSkWgD6ewy58cpu4dGrHB6HQrSF5g0CCJjzaUaqzfD2SMeaXodSfAbRGfjFDeeHer8zKp9avv55jFC/X8p5YFdW/GJWTekG3VU5yPv58TE6qn8jm2OlwyG9C1ocQhaU9A/oTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925494; c=relaxed/simple;
	bh=2ba5zC4nFi1Ed7n+ilW+b+NppWtTr+8BGra23dw6gPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE00TgqgEdVYN5jQxz78Cw4NqZTc18orQ2DDDn2kDeBsn2XndppaENrYyHMQE4K42YNjB55tcq4bszxHCFe4+uZKJtBt53V1t6/FRxwlIoiaoZuZVVZ+UIUVsnOJMOVTzMGyyFjC8HDT+ajNTApp1G8FNhjY9d0WjvP1V2u+2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mbJBlOH6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706b539fcaeso3698253b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719925492; x=1720530292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCUKJtxjiVHBrnRFpZSTwe0fkpTf7lz1L5LAQ0jpucY=;
        b=mbJBlOH6JALXKhEKbeuIWMvF8LmVeRZjHjnJAj7ejHMMAz0P0eHpf7RM1ktfOpyPWq
         9ELRU70O5n49qzLCWNVuNa85zXxoVpxjpdxIJL78zfFU6ILjNLULqWiJNF5MgZkXh1A3
         1NIrCNPGkDHatILvQKUydC/7bF+8iehvK1IVbHvXjZS2kGyp/nxXG6Wy/mS+M8+vAC81
         HTJgwPe6eDeaTgQtkkqXt6AMu/E0+iwXtBmzDhe4c9jYe3hp6Sjgh2hIuHcBgiRiJdY8
         37L/fLJMW1XbM88/YD+TKTVCzAwcxYW7mNoyKmUwbIEjP4uSsE5DtxWVq02CSTKgEaq+
         rGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925492; x=1720530292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCUKJtxjiVHBrnRFpZSTwe0fkpTf7lz1L5LAQ0jpucY=;
        b=XAst6Q5hGxq68sgS45nMVnD0xfXIu7pY6J+7rqIxvaiyXOEOMmzuD2+0NjDuRSXyCT
         OiML0YKfs9bYEfOaeZNUScI4xFqwhXrdwc/eNjb/mG3EaGwyiAV90mwqWX22e1cd8kb9
         WMbxyZQDEyhti3WqqJduQ7d8QBoCg9Ms0n1VAovVK9KvC7ZAw/Pf/1H9f63yc9BNxNLG
         cFO9byca+nSKZZEg0Z7sLBFR+YgynyVfj1XEW21+UPo4X88WGMN/9oR/0SDDMSicx8nv
         qrgw+8m14fnZUkKR/E3bPfiOz3MrNsLiSYWETK9xYUHBhVYDOHfBBQCwQwyF5NJZhVPe
         DL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfCzpa53oLw31HgkPgbxPOgAXpi871aYG9Ofr6QmBSyl/Jr/GRQuKz2jcGjis5A4bV+l5lw2OpOO376gQRcaD2QWr+qL488PZK
X-Gm-Message-State: AOJu0YyV1/hTnKpYB7t3Bwrmjv0itPopmq/3WExsVexfSLPabbcAn/GJ
	P67h3W6gAMMqQ1W0PEGBD6fxpSwt1dxv9dwQ40ChQ/iZQbgvYL70wXUPoerL3Len1tkDtOq+Fkl
	t
X-Google-Smtp-Source: AGHT+IHRMG8haob/98+FO+t2UO8ASY0vn12OW1IElLmLKDK4EpZ0lzqW0mh73cVdUSgNn0L5QHWK5A==
X-Received: by 2002:a05:6a20:9711:b0:1b5:cc1f:38d4 with SMTP id adf61e73a8af0-1bee4927f8fmr15938594637.17.1719925492374;
        Tue, 02 Jul 2024 06:04:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d00b5aasm6614155a12.83.2024.07.02.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:04:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sOdBh-001WSP-0j;
	Tue, 02 Jul 2024 23:04:49 +1000
Date: Tue, 2 Jul 2024 23:04:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "snitzer@kernel.org" <snitzer@kernel.org>,
	"bfoster@redhat.com" <bfoster@redhat.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoP68e8Ib2wIRLRC@dread.disaster.area>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
 <ZoHuXHMEuMrem73H@dread.disaster.area>
 <ZoK5fEz6HSU5iUSH@kernel.org>
 <f54618f78737bab3388a6bb747e8509311bf8d93.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54618f78737bab3388a6bb747e8509311bf8d93.camel@hammerspace.com>

On Tue, Jul 02, 2024 at 12:33:53PM +0000, Trond Myklebust wrote:
> On Mon, 2024-07-01 at 10:13 -0400, Mike Snitzer wrote:
> > On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> > > IMO, the only sane way to ensure this sort of nested "back-end page
> > > cleaning submits front-end IO filesystem IO" mechanism works is to
> > > do something similar to the loop device. You most definitely don't
> > > want to be doing buffered IO (double caching is almost always bad)
> > > and you want to be doing async direct IO so that the submission
> > > thread is not waiting on completion before the next IO is
> > > submitted.
> > 
> > Yes, follow-on work is for me to revive the directio path for localio
> > that ultimately wasn't pursued (or properly wired up) because it
> > creates DIO alignment requirements on NFS client IO:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-6.11-testing&id=f6c9f51fca819a8af595a4eb94811c1f90051eab

I don't follow - this is page cache writeback. All the write IO from
the bdi flusher thread should be page aligned, right? So why does DIO
alignment matter here?

> > But underlying filesystems (like XFS) have the appropriate checks, we
> > just need to fail gracefully and disable NFS localio if the IO is
> > misaligned.
> > 
> 
> Just a reminder to everyone that this is replacing a configuration
> which would in any case result in double caching, because without the
> localio change, it would end up being a loopback mount through the NFS
> server.

Sure. That doesn't mean double caching is desirable and it's
something we try should avoid if we trying to design a fast
server bypass mechanism.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

