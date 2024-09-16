Return-Path: <linux-nfs+bounces-6525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF197A8E9
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B5B22B58
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A613D62F;
	Mon, 16 Sep 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Fxa64976"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780439443
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726523734; cv=none; b=eUEJnwtn62fYrc/toGPynknF53IupuiTDIp1Sk5oGl4pUBVFud1vo8LqILudJ00hwa+4vHinh1jgJECy01oepHiCQUltkfqQn2DUYoZDEoBNMi7Suh3uIxHwcUwCYr/wh6ix52Q2C+SPP+H1ckRRqPTwF5RY9AP0reJvNx7HBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726523734; c=relaxed/simple;
	bh=dvdb/hPpUaIakFW38vCDL3nT+2nz/7o6ghkRKdQ6CU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlbdLyteuEYmgTNbJB3bSpDho8dshwcCJA75NXGQC8ie++RoFiVgGS4/OQPgBo5EB2amaXINPoKaBKKkvuKd9vHjJtLBebfj7RvC1UOzdLKiIUnpSo6YmdBlZmYbN1feFRDWUIrirfdz/ON620psrnGgVh7Bexk+rnNTENdgMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Fxa64976; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20792913262so30169055ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726523733; x=1727128533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+QcDyNxCWCtWt9+G6UHYM5MMFaIylSmdocAH+GqoOc=;
        b=Fxa64976TA7DtMxglyvo+6ObR75CazhewmJo1VoSdVwZHOHeYjrN3k7/+X9WF8RQ7W
         u4QByY1vEBGgj2m640CWQ1Uh68js277k6m+YwIjt8SO21P75SOhllw/N/GgMEX0m8+oA
         JvCv68RUC/aZ5VCR9wnk5jiZwGtcDkat9Fg2jp4nZQunVtAHobSjUP1dneE4CN4NTFVa
         gHk8PA/eDCqpNcZeS1XGd7oqBsBUHeiE6sfWHH1FdBLCc2znYkNvkNPH09hjGTkeUYYo
         genM5QQQIHsrTr+zmGWg7V5+exYEN76ZGSbWj4A7daN+QWGrj+5a3PbaAbS08AvJ50kL
         JbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726523733; x=1727128533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+QcDyNxCWCtWt9+G6UHYM5MMFaIylSmdocAH+GqoOc=;
        b=flRTW7EJaHwXyGUVZd3gX37Kj817xXXvBUNiFa5sAwjcVIBb/hQ+N6hZhzT7Ze/vfM
         l8mpw2dB8nfM3KJmSN/2SIUYVYfl/WFVu2Pz4PPPTBxAIXLOL0KF2UySvJa/QX/CQmfe
         ss0qYN5RRFA28j10JK4ufBcfUvnOBDFecAIn3KoOrzykbYMXkvHgLaDGsgCcWq+mGGRT
         QFfBK+SAKiX4eNdkPjZdwpOXIBzLLtCA8YDj2zZ0AmPJzyGY/mjVgz2dco0IaNtLWTFA
         2k7GpCF0+XMlGWzUzt/ttYaI/v2OcdgxFyy+cHaGoE7ryPI7b0qnGOC/vhx6szyaMV7r
         eKfg==
X-Forwarded-Encrypted: i=1; AJvYcCX6G/Xw+Q2vE9DXdshurR6/IcC6lLQUgu3EZK19cO50gswYKH0ucPP8TyrRICxGpoh0vQekA0L6TKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtm7ovCM+sRxngva8GEKK4nnbcB/wlvaTbRMX2eqV5tTiqLeB
	w2jQeaClepl3iMstO0kA7MkbNB9O1G2Iv5ihnmIBLQY3+SdRjQE+XBqKpTRzOII=
X-Google-Smtp-Source: AGHT+IF0iFN6cnO2/4mZbjdywZwBn/2zzJXSThiMoB3CX3BD1WHtQH9VedLiduQdloMWcI2cvwTppQ==
X-Received: by 2002:a17:902:c946:b0:207:5ca3:8d23 with SMTP id d9443c01a7336-20782b9e330mr183198465ad.59.1726523732632;
        Mon, 16 Sep 2024 14:55:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460111asm40742535ad.90.2024.09.16.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 14:55:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqJgv-0066Fa-1C;
	Tue, 17 Sep 2024 07:55:29 +1000
Date: Tue, 17 Sep 2024 07:55:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: trondmy@kernel.org, Mike Snitzer <snitzer@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] filemap: Fix bounds checking in filemap_read()
Message-ID: <ZuipUe6Z2QAF9pZs@dread.disaster.area>
References: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>
 <ZuSCwiSl4kbo3Nar@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSCwiSl4kbo3Nar@casper.infradead.org>

On Fri, Sep 13, 2024 at 07:21:54PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 13, 2024 at 01:57:04PM -0400, trondmy@kernel.org wrote:
> > If the caller supplies an iocb->ki_pos value that is close to the
> > filesystem upper limit, and an iterator with a count that causes us to
> > overflow that limit, then filemap_read() enters an infinite loop.
> 
> Are we guaranteed that ki_pos lies in the range [0..s_maxbytes)?
> I'm not too familiar with the upper paths of the VFS and what guarantees
> we can depend on.  If we are guaranteed that, could somebody document
> it (and indeed create kernel-doc for struct kiocb)?

filemap_read() checks this itself before doing anything else:

	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
                return 0;

i.e. there is no guarantee provided by the upper layers, it's first
checked right here in any buffered read path...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

