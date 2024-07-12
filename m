Return-Path: <linux-nfs+bounces-4874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF014930273
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 01:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868C1F2294B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC813210F;
	Fri, 12 Jul 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wBpPTfZv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11150132133
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827909; cv=none; b=rtuVt+YMKS6a8uuI/aAS8qmpTMH31C6Qv8Lnc1lolf6ypy0g8kYz6b0gLHmtWMwYrzsigeXnh/eRhTsJ6fgaawjSEuGP0xNwDeNmgz890xr42OGR2DbelXNzl0XBa7kYYlZuWGcghP287CELyBsgeKYLDjG/NNqN7Y5d2LxNJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827909; c=relaxed/simple;
	bh=h/LZxrwxUqXy9hHal5VrE3B30TUOcWcT3pccI5GYe+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMWUbr23lKUpYQtHN+JzbziBJ7hYqjETn+Dv262ble0a5D2IsksA+bTAGNDJJGK68NArd/S/3rQsVoqo7N01sm+6/q/OsRijWiMjq5bKcg8+EGkmU0q85qGueH5GV+Zp0dgNkxstxTE4KdA9uDfDnN/rr1E4O890lcfXqIcZOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wBpPTfZv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b31272a04so2401068b3a.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720827907; x=1721432707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eVWW/yo+o+buCpSvXz+qF7lpdbm1tv6lfeVq5aWPiGo=;
        b=wBpPTfZvE/IO2T4qOOXn8dPiHo2CGJVTzU8SbR1UGy4mh7QN+lSo7d/ZfVtAnRCLVO
         GFUT6HeiWLrPqnmloLr5cHYei591815hz41LvFqn0TAGODGgrrvDlMoMwcD6LKIBGvb3
         y5Mcgqy510Q6Khj1e0z8D4AyC9aCA9YqZ3V6+QffMOfJOCENlVwmCjs3h3tOMTCsRmK9
         20IPvn1SH35HeDY/s+TvZ2sTRl6aFEX7dGQ+7+kpQkvf5lcKHO7+MDbdtADGUBPc+pj/
         4NTLEnz8gpF8cb0921U73oBIT0lLGhbuwvueRi7fY3btwpMTzwZGtbAa9IRu444Y4FQe
         /nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720827907; x=1721432707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVWW/yo+o+buCpSvXz+qF7lpdbm1tv6lfeVq5aWPiGo=;
        b=ezq005sVlcXrapGdxjZmpQLvb0SWjBSXwshUu+NnjZ/IAvOnALWKivB23HxaK7Lq4E
         WAeUq25HNv9XZjTbt7dqhM5+kNLwytSQZn4KGKK7BiF68pUV+sgyTmnWu5O5BW4H/1SD
         L4M+vmk61ZCtQG8YlQ2zWq+Fdo1HxUSt8XVNMWm+JN+qwW9mi6u5TUhcJTIqAWgG28sZ
         oAhCLOrLTDP8Oy8rEnOsOrniv2sMN0Fw2gRvaXrb/dOAgpkSWRjAp93RzZlPGEW/rfuw
         QwU9KPlkYFhiHbZoEYlDU4JkKdCiet52v+QwanQmxVbYnM+657zrSRKgyavbF8dJQebP
         wF7g==
X-Forwarded-Encrypted: i=1; AJvYcCXgtUgq4bTUN4w/Ov1f3LHw1GhV1oe4cL5/4B0zIKpbu5pS57RmEKBZezqrwcOx+uoPlnAUuVGGsrBOGCmkYeXVB7n8tewtpsIy
X-Gm-Message-State: AOJu0YwXvBHyesi9Rmh+V5+KpjmCcXRX8cTNQNnEKIeYmzCmvMu4AJpa
	SFFQDkNqXVxakmMK6Ht2h2w6p1xhIcUuUVXbqWaExAMxjJYN77JiLs0DFB/eoMM=
X-Google-Smtp-Source: AGHT+IGWisA19bn2YoMInNJz/sJ5PJTqPKkg3TXIW5l7SdIQvRdDtZbh1uY+chVkqYDosHhx6rxBDw==
X-Received: by 2002:a05:6a20:734b:b0:1c2:8c0c:e60e with SMTP id adf61e73a8af0-1c3becfaf24mr6608825637.15.1720827907218;
        Fri, 12 Jul 2024 16:45:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c97fsm97002b3a.9.2024.07.12.16.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 16:45:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sSPwl-00DksW-2o;
	Sat, 13 Jul 2024 09:45:03 +1000
Date: Sat, 13 Jul 2024 09:45:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: Dragan =?utf-8?Q?Milivojevi=C4=87?= <galileo@pkm-inc.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, it+linux-raid@molgen.mpg.de
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
Message-ID: <ZpG///ZaN9KfPPcf@dread.disaster.area>
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area>
 <7c300510-bab8-4389-adba-c3219a11578d@pkm-inc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c300510-bab8-4389-adba-c3219a11578d@pkm-inc.com>

On Fri, Jul 12, 2024 at 05:54:05AM +0200, Dragan Milivojević wrote:
> On 11/07/2024 01:12, Dave Chinner wrote:
> > Probably not a lot you can do short of reconfiguring your RAID6
> > storage devices to handle small IOs better. However, in general,
> > RAID6 /always sucks/ for small IOs, and the only way to fix this
> > problem is to use high performance SSDs to give you a massive excess
> > of write bandwidth to burn on write amplification....
> RAID5/6 has the same issues with NVME drives.
> Major issue is the bitmap.

That's irrelevant to the problem being discussed. The OP is
reporting stalls due to the bursty incoming workload vastly
outpacing the rate of draining of storage device. the above comment
is not about how close to "raw performace" the MD device gets on
NVMe SSDs - it's about how much faster it is for the given workload
than HDDs.

i.e. waht matters is the relative performance differential, and
according to you numbers below, it is at least two orders of
magnitude. That would make a 100s stall into a 1s stall, and that
would largely make the OP's problems go away....

> 5 disk NVMe RAID5, 64K chunk
> 
> Test                   BW         IOPS
> bitmap internal 64M    700KiB/s   174
> bitmap internal 128M   702KiB/s   175
> bitmap internal 512M   1142KiB/s  285
> bitmap internal 1024M  40.4MiB/s  10.3k
> bitmap internal 2G     66.5MiB/s  17.0k
> bitmap external 64M    67.8MiB/s  17.3k
> bitmap external 1024M  76.5MiB/s  19.6k
> bitmap none            80.6MiB/s  20.6k
> Single disk 1K         54.1MiB/s  55.4k
> Single disk 4K         269MiB/s   68.8k
> 
> Tested with fio --filename=/dev/md/raid5 --direct=1 --rw=randwrite
> --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --numjobs=1
> --group_reporting --time_based --name=Raid5

Oh, you're only testing a single depth block aligned async direct IO
random write to the block device. The problem case that was reported
was unaligned, synchronous buffered IO to multiple files through the
the filesystem page cache (i.e. RMW at the page cache level as well
as the MD device) at IO depths of up to 64 with periodic fsyncs
thrown into the mix. 

So the OP's workload was not only doing synchronous buffered writes,
they also triggered a lot of dependent synchronous random read IO to
go with the async write IOs issued by fsyncs and page cache
writeback.

If you were to simulate all that, I would expect that the difference
between HDDs and NVMe SSDs to be much greater than just 2 orders of
magnitude.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

