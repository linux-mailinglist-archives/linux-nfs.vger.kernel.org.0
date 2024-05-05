Return-Path: <linux-nfs+bounces-3163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F08BC373
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 22:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB41281291
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991C6DCF5;
	Sun,  5 May 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="QfDKhYGf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1873C092
	for <linux-nfs@vger.kernel.org>; Sun,  5 May 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714939842; cv=none; b=rTMpajKHqFuYowh2fgQp2SSBUyiGzl9zgd37yLSo0mi3JpjUolJZQ5yueKWOohD+v0VLu1DWQB3b1oSmTKTvnLMgmOQDkEQMBVU4JsyCcvjFk3H9h+okvJaGVLc7PvPqn6rVdiT8pOLKTc1Ji7mu63Dtv4fq4LEPhNQL3ragZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714939842; c=relaxed/simple;
	bh=aB4XTyEzVT8Qv7ELok6Q+7bDZUtTGhHE97+O12jWW+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D08ol4Sr2MxkmNaqd56ENOaNItFRr0cRRErh7DRng68ZEG0HaHfBSa2A6f2VOg/gsCqxW+c1Yw9nSwU3dfO9i/sGrMByN4j6/N7ZlYHWrdjp5QSJJOrrlZYUSrAaPK8WcdXu89FXQiXGtUilyAkDUFLM5M5G/GuXNN6cjyo0zz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=QfDKhYGf; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso14416821fa.2
        for <linux-nfs@vger.kernel.org>; Sun, 05 May 2024 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1714939839; x=1715544639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qph189wY9guhOUXHC17BhrNvOdhtjBIEGtXCi4fKZ8Y=;
        b=QfDKhYGfzt1vMul1yIxnu2P5i3Hk6Ipd3CxWQyhRHh2s4BrZnNLqgudjoGBkQQm4Uc
         3jaC7exgOjgLk85j0RYw9nNw2Dv+AshbUfX+puvnqNdyeMfd7t6OgQHZS/zoNqxH9XjI
         kuQHWKuaQcQove0qxGbjsF7uxNS79QRFfNcH96qz1av6UQR00hfEop16xj2jiwcgbitc
         QmANLvYDij2bZ0UQOu0nzZZoYl93uh5yYfhBbSoImYDev/e/F0SHz3OD36DNLO1ZsGZy
         5gIa6CQAfmdT8LPCIz4IPy8TkR+GiXOWefgny8jzGT5jQvW2De47xMFQVUJpu2D6TcBI
         /YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714939839; x=1715544639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qph189wY9guhOUXHC17BhrNvOdhtjBIEGtXCi4fKZ8Y=;
        b=uR39bFr+agB+Ys8bwk93NuWBGDS2osTZbAO+vUB5bIl8kPaQc0m7+hL5Ct56tOSrwF
         HlCDBZr2TqtHafXzp9QA7HJXBzFBwkOLXUS5ubpAWJUSTpUX2FXbXr2giPvdJWiI/o6d
         LMBTwbBCJjReAtD6WgeTRxBqstMX0ysNdWlBCtlGRKmJGuPapDbavEPEjPmOJZl+NHut
         IZzm2BXOVMywAQbc3f2ktgvbipcsJxEgn1Zlp3Ngl9fCND6LF7cdYf0ldykDRRWlHVR+
         3kletKhm8fEoiMKhUoiVVYnlaC4lR9j1ZdqXCK1c7dZs8R2oDGPRLFjPX7EAie0ZFvcu
         2IwQ==
X-Gm-Message-State: AOJu0YzOciHJAt6PhBLFlRMAcNl49rbKtwSCVP6WCiTVt/suxbW6pQ/D
	ZWLTuCvNafEelarTvPEfalBs/6NM44WWxnLRNt3Tst5ZdujsnKTXAlkFLUejdSYQ9C+PmXXlZ53
	l
X-Google-Smtp-Source: AGHT+IGIYutSlr1jr9GthVqrMSYbDFatd3VYR8E6FV4NbKtQOCsc5xavh1zxMhszZgr8PGz4FGXZhQ==
X-Received: by 2002:a2e:7319:0:b0:2dd:372e:959 with SMTP id o25-20020a2e7319000000b002dd372e0959mr6076101ljc.8.1714939838929;
        Sun, 05 May 2024 13:10:38 -0700 (PDT)
Received: from gmail.com ([176.230.79.220])
        by smtp.gmail.com with ESMTPSA id bg4-20020a05600c3c8400b0041bf29ab003sm17536019wmb.30.2024.05.05.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 13:10:38 -0700 (PDT)
Date: Sun, 5 May 2024 23:10:35 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Message-ID: <20240505201035.eya22s7spmejnpdf@gmail.com>
References: <20240505124910.1877325-1-dan.aloni@vastdata.com>
 <ZjeZQmi7um7LDOd3@tissot.1015granger.net>
 <20240505183628.g2hhzkrtna5asz6b@gmail.com>
 <ZjfXOiQxyGNZpHOj@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjfXOiQxyGNZpHOj@tissot.1015granger.net>

On 2024-05-05 15:00:10, Chuck Lever wrote:
> On Sun, May 05, 2024 at 09:36:28PM +0300, Dan Aloni wrote:
> > On 2024-05-05 10:35:46, Chuck Lever wrote:
> > [..]
> > > Second, I wonder if, when bonding interfaces, there's an opportunity
> > > for the verbs consumer to take an additional transport reference.
> > > Cc'ing linux-rdma for input on that issue. Can you show a brief
> > > diagram of when the ep reference count changes when bonding?
> > 
> > Not sure we need an additional reference here.
> 
> We already have two mechanisms in play:
> 
> - the ep reference count
> - the re_connect_status value
> 
> I would prefer not to add a boolean here. Seems like
> re_connect_status could do that job if we need it to.

That's possible. So before overrides e.g. `ep->re_connect_status =
-ENODEV` we would need to remember whether it was `1` and across the
call to `rpcrdma_force_disconnect()`, to do the putref() after it.
Anyway, the patch will be a big larger I guess.

>[..]
> > Testing 6.8.9 with both the patch and `wake_up_all(&ep->re_connect_wait);`
> > for `RDMA_CM_EVENT_DEVICE_REMOVAL` works for me, showing proper recovery
> > on bonding, I'll post in a reply.
> 
> It looks like you are trying to fix several issues in one patch. So
> I need you to separate these issues and the fixes, and let's focus
> on the upstream kernel (v6.9-rc6) because there's nothing I can do
> about the RHEL9 kernel, which is clearly a different source base
> than the one I work on.
> 
> If we need a "wake_up_all(&ep->re_connect_wait);" during
> DEVICE_REMOVAL, that should be a separate patch. And you need to
> figure out if ADDR_CHANGE needs the same treatment: the v2 you just
> sent changes the behavior of ADDR_CHANGE too but does not mention
> whether it intended that change.

Was it just the `rpcrdma_ep_put` change in this case? Will feel less
comfortable changing it without a repro of the `ADDR_CHANGE` case. Going
to isolate it.

> Without a reproducer or a detailed explanation of how the ep
> reference count changes in step with CM events, I can't properly
> assess your proposed fix.

With 6.8 I only see a single `RDMA_CM_EVENT_DEVICE_REMOVAL` event
arriving, driving a single `rpcrdma_ep_put` call to put the reference
back at 1, and it waits forever. Getting late here, I'll check on 6.9-rc
tomorrow.

Maybe for a repro, you can generate a single interface bond? I haven't
tried, but possibly it would occur on a single one too if the underlying
port is down.

-- 
Dan Aloni

