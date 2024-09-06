Return-Path: <linux-nfs+bounces-6293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919296E750
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1656E1C231DE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AA1DA21;
	Fri,  6 Sep 2024 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAW6geP+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE01CA94;
	Fri,  6 Sep 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586469; cv=none; b=LsbwGs99a9QB2MBQhX88wbrmQrDeSfV3YooPFkabQ3DnBO0fO9ni7IfFBfTVRzKAY/otvzpi2d7HISUF50w1y5i+f54QRmqV/tnleG+SjE/O//ifw4kvax7DhIr5hlwmxjp+GgvoUDWFE7SfYMMbJM0G3h2vVongpqvFDMUrly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586469; c=relaxed/simple;
	bh=DhY6rGfOlLTMtYFY6JMioPUvjaIkctEMK5oG3sIAKKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZj6DHM0BbZor4WEKxIwrhy6PX147HeXQq0Cx8fjDjWU1vGw+5sA76AQL3vZIH20tIA/Pp3FIBWGw4rcLDvWkGiJcGvfhX4ypDkBgth1P4+RNp5UR67ygPxYIOF9HzA/LWVsM9OiQF9nQ5FTDNGMTxsF0GMoMogPNsVxPqSZk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAW6geP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931CFC4CEC3;
	Fri,  6 Sep 2024 01:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725586468;
	bh=DhY6rGfOlLTMtYFY6JMioPUvjaIkctEMK5oG3sIAKKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAW6geP+l/1A7xcK1gfy30FPnS/X9eRktTLABf0RTHny7zuS3fUAVgAYxkv9SUrN+
	 A0v/Ji1O3R34gXq+nFwN4JMqgrxeE6dZDk2AQFFmT4F1LaV5NPXqtNlOB5OtE3gEmz
	 j8WOiiUA4BAK1iisAzWQKVIK2LcBnr/v1qU58sa2D3cFk+jUfDtO6O2k6tgGaZMsLc
	 VakmieRckRYZtwFhd4hN9syttFl2+06L+HqrWM2KTnVv8uxh5r1h2eAaBSJF2sA4og
	 mY128FTnfL9EAO5ai4zKA+a9qfJ3/NnBLn7vcgYtwACUAHY5qlEmIxBNENOU3msnp+
	 XYfkZBkT4qJ2A==
Date: Thu, 5 Sep 2024 15:34:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sami Tolvanen <samitolvanen@google.com>, linux-nfs@vger.kernel.org
Subject: Re: sharing rescuer threads when WQ_MEM_RECLAIM needed? [was: Re: dm
 verity: don't use WQ_MEM_RECLAIM]
Message-ID: <ZtpcI-Qv_Q6g0Q6Z@slm.duckdns.org>
References: <20240904040444.56070-1-ebiggers@kernel.org>
 <086a76c4-98da-d9d1-9f2f-6249c3d55fe9@redhat.com>
 <20240905223555.GA1512@sol.localdomain>
 <ZtpATbuopBFAzl89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtpATbuopBFAzl89@kernel.org>

Hello,

On Thu, Sep 05, 2024 at 07:35:41PM -0400, Mike Snitzer wrote:
...
> > I wonder if there's any way to safely share the rescuer threads.
> 
> Oh, I like that idea, yes please! (would be surprised if it exists,
> but I love being surprised!).  Like Mikulas pointed out, we have had
> to deal with fundamental deadlocks due to resource sharing in DM.
> Hence the need for guaranteed forward progress that only
> WQ_MEM_RECLAIM can provide.

The most straightforward way to do this would be simply sharing the
workqueue across the entities that wanna be in the same forward progress
guarantee domain. It shouldn't be that difficult to make workqueues share a
rescuer either but may be a bit of an overkill.

Taking a step back tho, how would you determine which ones can share a
rescuer? Things which stack on top of each other can't share the rescuer cuz
higher layer occupying the rescuer and stall lower layers and thus deadlock.
The rescuers can be shared across independent stacks of dm devices but that
sounds like that will probably involve some graph walking. Also, is this a
real problem?

Thanks.

-- 
tejun

