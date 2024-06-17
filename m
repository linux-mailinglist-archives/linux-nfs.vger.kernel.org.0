Return-Path: <linux-nfs+bounces-3888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3790A811
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537F6B27758
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FA190462;
	Mon, 17 Jun 2024 08:03:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074C18FDD3;
	Mon, 17 Jun 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611404; cv=none; b=G3lndZijoRYmVmv5XxJXOjbqNCSNpyy8HqHlfSQlo+1Me9vBhE5ZP+xlvXzG7Wy0sZqxLg0WRNAOhsFjzQXBlFES2CgAmGWcFUa7vlcX2DvyzOH8JEsJ3vqq6K0hmSWpd//8nsZHV7U2iNrIrzUxw6KXbNEnCaecXi1hvNTfRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611404; c=relaxed/simple;
	bh=CHDJVgk91TxR/+XQc7/ItXthL+Qn8sLdr9z3wCtPZq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6/4X09b1+zYVhGyy6YNfXWdAacmPUC1vOSBP8GneJ5LLOwSeCDtzHvyqBg9Uqsl1a1/uWaaSFwUPxbVKgbeWJrOuR0oil4PabMWEH1+xx+ThB5tsKwiGD5HDeWYOlrw9t1PoYYB6w8lDlfAk0ZyWeKQRuVQxzT4G7TciSJ6XtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2110CDA7;
	Mon, 17 Jun 2024 01:03:46 -0700 (PDT)
Received: from [10.57.73.35] (unknown [10.57.73.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC2D23F64C;
	Mon, 17 Jun 2024 01:03:19 -0700 (PDT)
Message-ID: <9ef638fc-5606-45da-a237-2e09ee05bbeb@arm.com>
Date: Mon, 17 Jun 2024 09:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240614100329.1203579-1-hch@lst.de>
 <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de>
 <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/06/2024 11:23, Barry Song wrote:
> On Sun, Jun 16, 2024 at 4:54 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sun, Jun 16, 2024 at 12:16:10PM +1200, Barry Song wrote:
>>> As I understand it, this isn't happening because we don't support
>>> mTHP swapping out to a swapfile, whether it's on NFS or any
>>> other filesystem.
>>
>> It does happen.  The reason why I sent this patch is becaue I observed
>> the BUG_ON trigger on a trivial swap generation workload (usemem.c from
>> xfstests).
> 
> This is quite unusual. Could you share your setup and backtrace? I'd
> like to reproduce the issue, as the mm code only supports mTHP
> swapout on block devices. What is your swap device or swap file?
> Additionally, on what kind of filesystem is the executable file built
> from usemem.c located?

Yes, I'm also confused by this, since as Barry says, the swap-out changes to
support mTHP are only intended to be activated when the swap device is a
non-rotating block device - swap files on file systems are explicitly not
supported and all swapping should be done page-by-page in that case. This
constraint is exactly the same as for the pre-existing PMD-size THP swap-out
support. So if you are seeing large folios being written after the mTHP swap-out
change, you should also be seeing large folios before this change.

Hopefully the stack trace will tell us what's going on here.

(Sorry for my slow responses/lack of engagement over the last month; its been a
combination of paternity leave/lack of sleep/working on other things. I'm hoping
to get properly back into this stuff within the next couple of weeks).

Thanks,
Ryan


