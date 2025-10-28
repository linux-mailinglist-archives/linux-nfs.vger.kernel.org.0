Return-Path: <linux-nfs+bounces-15724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C02C15887
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FD31A62BB0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBAF225416;
	Tue, 28 Oct 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ+tYXTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D19345721
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665874; cv=none; b=CZBFWkMX2jYgoyjq3lPluTapPo8g4FmuLgwWSoNnfObxaqEaaBnpWjM5zoWGhtBO93j0+ZyF1zMTPjxoXw5yE+PBsUy4XNOJA29V8hbuXWSyKdVhuL9J5PjAZEWxDSF5YtQZcUNCztZXJvnYeVjWjUBXRXeYq5N05+6Gdsq+LKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665874; c=relaxed/simple;
	bh=Vfo16RkxGUMFRQ5/1zSCoDbxs970R/1GZofRDjCBlKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bkmgytj8DnRJuzp10GnABuMd6MxN9g2beBNk9hb3IHtwLmUjJeAYhVfshkRo4JjzGqoVlWARnBJZV3Pl9XSUcRtih0zGCyDHe3hXiGtkGeIytj+To5EB4o/SGkSXgZ5QPhpVb1JEFE5KCc1Fb1AO+Tell9Q0PNtr2RlxtR2c/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ+tYXTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A41CC4CEE7;
	Tue, 28 Oct 2025 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665874;
	bh=Vfo16RkxGUMFRQ5/1zSCoDbxs970R/1GZofRDjCBlKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQ+tYXTET7wiM4wsg2EOG6jHFJKpEHV5SRyuqfu4JfcuUDkUdv2UOu3wojSHlt6lQ
	 YplRB1X6Hv2cpWOeJvSxJdmPNQ0zzkJgACXzEfmg5Kb3e1hGGvbIiXwqhKOKcXk0RB
	 DPp7Szyql9Gphv5apBTq1kkQiZDp2J1q2F3G1d9YAu2eR21d2B4p8RP/sTx5wtEFzF
	 7K08Mpvb8L7tX2Yo/V5K+6GygNy86BTnyZOOiFuB4yA/XxoeBVLCjRF2vPedyVRak2
	 i/n+Vx5q3KcOejl4GCsIgCdnOsQY8z+XiH48qTSSXluCgiIQTOs+5x2NOSI3q3bRcx
	 ZE/Y4sAI6r4Qw==
Message-ID: <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
Date: Tue, 28 Oct 2025 11:37:52 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org> <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQA4AkzjlDybKzCR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 11:26 PM, Mike Snitzer wrote:
> So can we please revisit your desire to eliminate the use of
> IOCB_DSYNC for NFSD_IO_DIRECT WRITEs?

Let's have a little less breathless panic, please. The whole point of
review is to revisit our decisions. And nothing I've done so far is
written in stone... even after merge, we can still apply patches. If
the consensus is we don't like v8 or some particular patch, I will
rewrite or replace it, as I've already said.

You might view me as a whimsical and authoritarian maintainer, but
actually, I am resisting the urge to merge a patch that the community
(that is now responsible for free long-term support of the patch) hasn't
yet fully learned about and carefully reviewed. I see my role as
enforcing a consensus process, and both learning and consensus takes
time.


>> So perhaps the issue here is that the rationale for using IOCB_DSYNC
>> for all NFSD_IO_DIRECT writes is hazy and needs to be clarified.

> How is it still hazy?  We've had repeat discussion about the need for
> IOCB_DSYNC (and IOCB_SYNC if we really want to honor intent of
> NFS_FILE_SYNC).

TL;DR: it's hazy for folks who were not in the room in Raleigh.

I don't see any comments that explain /why/ the unaligned ends need to
be durable along with the middle segment. It appears to be assumed that
everyone agrees it's necessary. Patch review has shown that is perhaps
not a valid assumption.

So far it's been discussed verbally, but we really /really/ want to have
this documented, because we're all going to forget the rationale in a
few months.

And please do not forget that this is open source code. The code has to
be able to be modified by developers outside our community. Right now it
isn't well enough documented for anyone who was outside of the room in
Raleigh two weeks ago to understand WTF is going on. The point being
that we cannot make final decisions in a closed room -- eventually they
need to face the larger community.

If we need to insist that NFSD_IO_DIRECT mode is always going to be
fully durable, that design choice needs to be explained in code comments
that are very close to the code that implements it.


> Christoph has repeatedly said DSYNC is needed with O_DIRECT, yet you
> keep removing it.

That's not what I read. Over the course of three email threads, he wrote
that:

- IOCB_DSYNC is always needed when IOCB_SYNC is set, whether or not
  we're using IOCB_DIRECT.

- in order to guarantee that a direct write is durable, we /either/ need
  IOCB_DSYNC + IOCB_DIRECT, /or/ IOCB_DIRECT by itself with a follow-up
  COMMIT.

- for some commonly deployed media types, IOCB_DSYNC with IOCB_DIRECT
  might be slower than IOCB_DIRECT followed up with COMMIT.

Therefore, we need to carefully justify why the current patches stick
with only IOCB_DSYNC + IOCB_DIRECT, or decide it's truly not necessary
to force all NFSD_IO_DIRECT writes to be IOCB_DSYNC.

Christoph and I (if I may put words in his mouth) both seem to be
interested in making NFSD_IO_DIRECT useful in contexts other than a very
specific enterprise-grade server with esoteric NVMe devices and ultra
high bandwidth networking. After all, one of the deep requirements for
merging something upstream is that it is likely to be useful to more
than a very narrow constituency (see recent discussions about merging
TernFS).

If we truly care about making NFSD_IO_DIRECT valuable for small memory
NFSD systems, then we need to acknowledge that their durable storage is
likely to be virtual or in some other way bandwidth-compromised, and not
a directly-attached real NVMe device.


>> Or, we might decide that, no, NFS WRITE has no data visibility mandate;
>> applications achieve data visibility explicitly using COMMIT and file
>> locking, so none of this matters.
> 
> We don't have that freedom if we cannot preserve file offset integrity
> (as would be the case if we removed IOCB_DSYNC when handling all 3
> segments of a misaligned DIO WRITE).  Removing IOCB_DSYNC would
> compromise misaligned DIO WRITE as implemented.

As I understand it, IOCB_DSYNC has nothing to do with whether the three
segments are directed to the correct file offsets. Serially initiating
the writes with the same iocb should be sufficient to ensure
correctness.

The concern about integrity is that in the multi-segment case, the
segments won't make it to durable storage at the same time, and an
intervening NFS READ might see an intermittent file state.

If the risk of a torn write is an actual problem for an application, it
should serialize its reads, writes, and flushes itself. I think there
are already plausible situations in today's non-DIRECT world where
incomplete writes are visible, so it might be sensible not to worry too
much about it here.

Jeff, please do clarify if I've misunderstood your concern.


>>> And we already showed that doing so really isn't slow.
>>
>> Well we don't have a comparison with "IOCB_DIRECT without IOCB_DSYNC".
>> That might be faster than what you tested? Plus I think your test was
>> on esoteric enterprise NVMe devices, not on the significantly more
>> commonly deployed SSD devices.
> 
> IOCB_DIRECT without IOCB_DSYNC isn't an option because we must ensure
> the data is ondisk.

You are stating the exact assumption that we are testing right now. It
is not 100% clear from code and comments in these patches why "we must
ensure the data is on disk".


-- 
Chuck Lever

