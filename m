Return-Path: <linux-nfs+bounces-4116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD990FB52
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 04:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5407F1C2102E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519D18EB1;
	Thu, 20 Jun 2024 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZYmmB8UO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16A18026
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850593; cv=none; b=GOaPieKxWV8IgzZYx/hDnhXYIa6oTqMfxvyvFZpgSWsekAbnvmqw+GhXBkH2zH9DML/H8sJRfBUhidD6G0HE4UOJp9XLwyrtthrJ7It21stI7j0qY5gXNs0ll+d6EVsUGnDP7HG3SfjMpooJqq72x3AYRFW9u8bV1eLnCmJipv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850593; c=relaxed/simple;
	bh=ZN/yUztiflSypU5XZHBcAzhwfv+y5G7UGSLU+QD0dmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBjQbtrqCJ2mGNntVkEQHIBrADZxnkrx5lcT/aFvbtJ09Y4CgReIaPf1U6WYgHT3vmLrlX85qIocgi4rR9MdP5c+cbcjnAQCn/NJTdLs4YGrs1nQWu8TUU3BlT/ce7Q4pcoj0RWerym56m6ODqehUghskiGOyMkyhBucqt86OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZYmmB8UO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-705c739b878so1167437b3a.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718850591; x=1719455391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8EaUlUOk+HjfAwBhANMKCFHMXQzPEc2JC/+uItdL1P4=;
        b=ZYmmB8UOJ7RCHjxtrq4sCZFMFN3BTmQwyyqDsxumLy/0O+wdolKDy+iqFS9Zgjv5cm
         jABdHPCp7S+rdj7gAFRQfTcNZPOk9URTLLPQzPN1AY+ZesLLXfwnu8kf6m0oXpY2TWV9
         f8OZRSw2PrGdk3Yh0b95GdLdSQ27MV5h6LFXsBnayAJaEoJnlnx7UAsMMGkAQwh8Eluo
         OfoALZZWgVxoQ4gfM/FAQS0K7bM1Gr5whmg7DivRLTQqK5Mf7UejvAoQV3WIu4wc/Qu1
         uwe/LJzOXUipVJx8Fb0Mmcx7vLYRax150i2ZdHGCccMM78ByFJLhJJhEzLnLk84bfip8
         vUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718850591; x=1719455391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EaUlUOk+HjfAwBhANMKCFHMXQzPEc2JC/+uItdL1P4=;
        b=TmehbnnFvMiYQHC2k8W56Ebv8QZZealEhZRQf1agSga06xAuX6doPXSVQ2hsgzh4gR
         QL9eEZLCF91HpbSDmcTE1oosp+cvEPNQAmow265tVM8WFvMExB5u5KGeKTjCMuyvx2W1
         IjDtfD2Cqf+eCF5okW9YiQytHSIIft58KAJPGMW/bx1WiGjvGurPPT5BdmBGwkZgpnZu
         f6OlHSdCn75SN60SzMsJZjlbm0E1rhXTrksaw5MPuLLscb3gk5wBiTSGnFBGFUGJNGuJ
         tTTk7fHHPaEi8zsLFqPVwuPxt/FrLrjU2ipHCCOeJHu+prWgCeHb0pmXiHgo5h6e+ens
         Sx5g==
X-Forwarded-Encrypted: i=1; AJvYcCUxTHjj/s/vI5f2yQ/1xn57DwYquwBMDEF4zc/MpTY3/7aPXgVbpIvSrtiMtauUohECBPxmbMaWAJ+o/U/ZfEp604OK3YbCptax
X-Gm-Message-State: AOJu0Yx0rgVT04y+3WMEMCJlLLzvD+TZeSqxhk/VLurirRTonRotU8SJ
	IUzSFkOAxxAiofanREiaNQgl56E/PUPwUwHyyiKOHQMpDIR0U957P7cYmEUIpRC6mn3zNLcl6Wv
	T
X-Google-Smtp-Source: AGHT+IH6teNIDRP6uLHKRVLDV+RMKy0k3b/C30GTHwX8de0CAR//b4yNSuSgFTpLI9ySYohO8IdiUw==
X-Received: by 2002:a17:90b:303:b0:2c7:b170:7d6a with SMTP id 98e67ed59e1d1-2c7b1707dd5mr6362932a91.14.1718850591361;
        Wed, 19 Jun 2024 19:29:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16a58dsm10249499a12.29.2024.06.19.19.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 19:29:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sK7YZ-004a4q-3A;
	Thu, 20 Jun 2024 12:29:48 +1000
Date: Thu, 20 Jun 2024 12:29:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: knfsd performance
Message-ID: <ZnOUG2Nh80vTJXxe@dread.disaster.area>
References: <>
 <ZnIpfgCrRe95sXdr@dread.disaster.area>
 <171875886281.14261.15016610844409785952@noble.neil.brown.name>
 <171883231568.14261.16495433738354176501@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171883231568.14261.16495433738354176501@noble.neil.brown.name>

On Thu, Jun 20, 2024 at 07:25:15AM +1000, NeilBrown wrote:
> On Wed, 19 Jun 2024, NeilBrown wrote:
> > On Wed, 19 Jun 2024, Dave Chinner wrote:
> > > On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > On Jun 18, 2024, at 3:50 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > > > > 
> > > > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > > >> 
> > > > >> 
> > > > >>> On Jun 18, 2024, at 3:29 PM, Trond Myklebust
> > > > >>> <trondmy@hammerspace.com> wrote:
> > > > >>> 
> > > > >>> On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > >>>> 
> > > > >>>> 
> > > > >>>>> On Jun 18, 2024, at 2:32 PM, Trond Myklebust
> > > > >>>>> <trondmy@hammerspace.com> wrote:
> > > > >>>>> 
> > > > >>>>> I recently back ported Neil's lwq code and sunrpc server
> > > > >>>>> changes to
> > > > >>>>> our
> > > > >>>>> 5.15.130 based kernel in the hope of improving the performance
> > > > >>>>> for
> > > > >>>>> our
> > > > >>>>> data servers.
> > > > >>>>> 
> > > > >>>>> Our performance team recently ran a fio workload on a client
> > > > >>>>> that
> > > > >>>>> was
> > > > >>>>> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> > > > >>>>> (infiniband) against that resulting server. I've attached the
> > > > >>>>> resulting
> > > > >>>>> flame graph from a perf profile run on the server side.
> > > > >>>>> 
> > > > >>>>> Is anyone else seeing this massive contention for the spin lock
> > > > >>>>> in
> > > > >>>>> __lwq_dequeue? As you can see, it appears to be dwarfing all
> > > > >>>>> the
> > > > >>>>> other
> > > > >>>>> nfsd activity on the system in question here, being responsible
> > > > >>>>> for
> > > > >>>>> 45%
> > > > >>>>> of all the perf hits.
> > > 
> > > Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
> > > 
> > > llist_reverse_order() is an O(n) algorithm involving full length
> > > linked list traversal. IOWs, it's a worst case cache miss algorithm
> > > running under a spin lock. And then consider what happens when
> > > enqueue processing is faster than dequeue processing.
> > 
> > My expectation was that if enqueue processing (incoming packets) was
> > faster than dequeue processing (handling NFS requests) then there was a
> > bottleneck elsewhere, and this one wouldn't be relevant.
> > 
> > It might be useful to measure how long the queue gets.
> 
> Thinking about this some more ....  if it did turn out that the queue
> gets long, and maybe even if it didn't, we could reimplement lwq as a
> simple linked list with head and tail pointers.
> 
> enqueue would be something like:
> 
>   new->next = NULL;
>   old_tail = xchg(&q->tail, new);
>   if (old_tail)
>        /* dequeue of old_tail cannot succeed until this assignment completes */
>        old_tail->next = new
>   else
>        q->head = new
>
> dequeue would be
> 
>   spinlock()
>   ret = q->head;
>   if (ret) {
>         while (ret->next == NULL && cmp_xchg(&q->tail, ret, NULL) != ret)
>             /* wait for enqueue of q->tail to complete */
>             cpu_relax();
>   }
>   cmp_xchg(&q->head, ret, ret->next);
>   spin_unlock();

That might work, but I suspect that it's still only putting off the
inevitable.

Doing the dequeue purely with atomic operations might be possible,
but it's not immediately obvious to me how to solve both head/tail
race conditions with atomic operations. I can work out an algorithm
that makes enqueue safe against dequeue races (or vice versa), but I
can't also get the logic on the opposite side to also be safe.

I'll let it bounce around my head a bit more...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

