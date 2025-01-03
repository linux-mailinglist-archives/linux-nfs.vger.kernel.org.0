Return-Path: <linux-nfs+bounces-8905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322FA01057
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EB4188490F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00C193091;
	Fri,  3 Jan 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEZgcS5l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187A2E401
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944798; cv=none; b=L8Dos/KM/AQfmj5ftk3WZArI9PGIY6JfS+hcGBksxyiGFwmlmZHwmgr34oU6Oy93hRpJJL5qwL012oq+IwXStCD+MUlt949IGq58Y8PIA1ul3vAUTVK3SdZB9hB02ETyH7Q+aqvokG8QnfLABdmbOTzyE0hBF5lG/aijAq7YEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944798; c=relaxed/simple;
	bh=s+G0JQm1a7GumhnJjw46+Y+l6Hm5AkB9+SjXhal7izQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjuV4cwGMcGa3ujpUMWEpTMqTm+tnYQ/nmxr8/E2FjDFkHIinVWgdIltTMEY/ZIJ92A0x+NUt8R/a0t6Qesk5EeXVYeBZq/ZeOL7y1hnl5exD/5Ol/rmY/uciKuv0fdO9pS134zcZnBeasAZJHtQ1RKSngW/GIr+s2koDIjkR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEZgcS5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BDFC4CEDD;
	Fri,  3 Jan 2025 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735944797;
	bh=s+G0JQm1a7GumhnJjw46+Y+l6Hm5AkB9+SjXhal7izQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEZgcS5lci7Q3LXrAKwwyrJUJpNDbZVLxnnSgYPcSAiPbbU1gWegMq8gqU70i35cM
	 A1Hj46uaboSjJBJGYDua4hBbwjzcIM+ELRaOdJ9DPaPqhmOLdQl+yv8xb1xmOBAcp3
	 36FwugWGuFfRtS1Vqmd7j7/mET1JRlYyPRon8EE00zR/rDDPdqS9QJpaCkRakchklr
	 iZAYUsvB2EPD3noayeqb41DJHMEPS2zfZ6p6tQBTVovT5dGvVDr2RR1pVS+TLlKuRM
	 vNtZDpr+5gaY/kc/Op6UBzxusVOKi0VOOt0QLqKvesVhIqX/BXaYUpNGF9qvt9O8JU
	 nsl6jobWJzDlQ==
Date: Fri, 3 Jan 2025 12:53:16 -1000
From: Tejun Heo <tj@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue
 again
Message-ID: <Z3hqXM9ENCQFMRK6@slm.duckdns.org>
References: <20250103010002.619062-1-cel@kernel.org>
 <20250103010002.619062-2-cel@kernel.org>
 <173594463285.22054.5607940116597245970@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173594463285.22054.5607940116597245970@noble.neil.brown.name>

On Sat, Jan 04, 2025 at 09:50:32AM +1100, NeilBrown wrote:
> On Fri, 03 Jan 2025, cel@kernel.org wrote:
...
> I think that instead of passing "list_lru_count()" we should pass some
> constant like 1024.
> 
> cnt = list_lru_count()
> while (cnt > 0) {
>    num = min(cnt, 1024);
>    list_lru_walk(...., num);
>    cond_sched()
>    cnt -= num;
> }
> 
> Then run it from system_wq.
> 
> list_lru_shrink is most often called as list_lru_shrink_walk() from a
> shrinker, and the pattern there is essentially that above.  A count is
> taken, possibly scaled down, then the shrinker is called in batches.

BTW, there's nothing wrong with taking some msecs or even tens of msecs
running on system_unbound_wq, so the current state may be fine too.

Thanks.

-- 
tejun

