Return-Path: <linux-nfs+bounces-1439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD483CEED
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661228FCF9
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DD131E4F;
	Thu, 25 Jan 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d50yC0Rc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF481CA89
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219650; cv=none; b=olrSW6xJR2CKJx1F+S+uHKwUrPhWFrDTUJ/m+mL7QnfEDaEDKwsLdP+VfxWC7NKrK02B6A/cPjZRTpxZ0NUeV6bBuFzi5Z3ANIqfg5rXwlU1JbIMsOJFkKs5yhYCewfllPuknJqvpAkmhxUYXbvWRoeOO2wHlfdHUDNolrQ/3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219650; c=relaxed/simple;
	bh=M6VH+2dyhj7SuZh/sCNDpT5tGGLyldvX9JaNq5W4ZOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyeOND+P98puBGpttXqPL+V1TQl30DeVJL9dI1fxqsusoRqjNOIH6AECpDAP54b6qjWkyaRmPV1dvJcHaejW/jZ7SU6kYq16lqkdFR8lfA//vRcw6g/e/ZV80YnRZPnmKZmALcXGIAeDK0OqHWwpiZvYD8Ry78ut6VlKbFsIwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d50yC0Rc; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff790d41bdso53433997b3.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706219647; x=1706824447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6esFHQ6f2epN79rzGzIy3r4o0TXoNXs2g1awrW8DBX4=;
        b=d50yC0Rctk8/2gg7OHAblrMjbumO4cRkXsQGanVZ6x1hmfr8lopkE68GdDKuuW5hXT
         qrC4sPCabF7JHeS19fDVZnzg8P4lsMHbLrGnftvHVepjD58ZTwr1ieRavcGc/jwMVPqO
         uD8A9OezTrhALOfYSOjJ0CwapJ1+pxoTiG+X+mx+kIJ4C6ocom6dPue3qPAlwvYCiwaA
         M9jOcXjl+ZBiaoejnvcp/rAs3AjLj0uLtz/Giir78TotuZBFIO96a6zIkt6yFLULLkaD
         ncyorpusPuhjTxmzTmrRCvO9H027E+cXvJ1D1gdV6MRHC0cay2/gns5EqW3fkj7iKrJp
         FIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219647; x=1706824447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6esFHQ6f2epN79rzGzIy3r4o0TXoNXs2g1awrW8DBX4=;
        b=aECNhhcDeVeNNSyDFVrz6hKT5tSNGKUCu1D5Jl7U716Rc0EekxTLJOsZXfGC98n39c
         dx16u4ic6003GStc3Da7+ug8aJY8WEeUxS/BvrjvCLyOERbeVQd0rGxxnAd/Q/qGL8O+
         P0irVq4mTQh4phhRZDF1QIUkAr7AoS5ylODQsffQeoTKZfbCddaZpERENJWsNvZ6800O
         kxel/YYfVNnb/KlFt8hq5OIXJRLmqnReE1cvMSS/TY7b17qECzoVA27ymnrKcVYTFRDB
         H1zBNB37AbQX6jVq87QCyhHxLvkNXvE2TzDoS6dv8v36a61uUD9NIBQODrbiPzqrfKQX
         F1tg==
X-Gm-Message-State: AOJu0YwfHYG3KvJUfxq1JmU2LiPfSOJD/iHR/0Yw4fIev0iov5WHOni1
	gZOuBKkbRuT6QxCpaZsl8SiVBv9ETBTZcgtGih7vrq0Dxme/C4I4X3keOSUKzGBAj343w+OOo/s
	x
X-Google-Smtp-Source: AGHT+IE0+4mmjJP5MJWyLacRIK9+02z8dzEolds3wLcu0adHkP4+9U9Y588hGh50Z2iTzhTMHOspag==
X-Received: by 2002:a81:84d2:0:b0:602:9b98:822e with SMTP id u201-20020a8184d2000000b006029b98822emr478068ywf.62.1706219647460;
        Thu, 25 Jan 2024 13:54:07 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gr12-20020a05690c448c00b005ff9264e841sm916847ywb.6.2024.01.25.13.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:54:06 -0800 (PST)
Date: Thu, 25 Jan 2024 16:54:06 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 05/13] sunrpc: add a struct rpc_stats arg to
 rpc_create_args
Message-ID: <20240125215406.GA1602047@perftesting>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <4cc2a7aca55ff56ac3ced32aafa861f57f59db02.1706212208.git.josef@toxicpanda.com>
 <ZbLKRC1GkiKUkK+L@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLKRC1GkiKUkK+L@tissot.1015granger.net>

On Thu, Jan 25, 2024 at 03:53:24PM -0500, Chuck Lever wrote:
> On Thu, Jan 25, 2024 at 02:53:15PM -0500, Josef Bacik wrote:
> > We want to be able to have our rpc stats handled in a per network
> > namespace manner, so add an option to rpc_create_args to specify a
> > different rpc_stats struct instead of using the one on the rpc_program.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/nfs/client.c             | 2 +-
> >  include/linux/sunrpc/clnt.h | 1 +
> >  net/sunrpc/clnt.c           | 2 +-
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> I know it isn't obvious to an outside observer, but the
> maintainership of the NFS server and client are separate.
> 
> NFS client patches go To: Trond and Anna, Cc: linux-nfs
> 
> NFS server patches go To: Jeff and Chuck, Cc: linux-nfs
> 
> and you can Cc: server patches on the reviewers listed in
> MAINTAINERS too if you like.

Sounds good, should I split the series up completely?  I think the nfsd and nfs
sunrpc related changes are unique to either stack so I can split it out into two
different series if that would help.  Thanks,

Josef

