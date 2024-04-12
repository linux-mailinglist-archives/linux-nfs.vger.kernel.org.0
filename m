Return-Path: <linux-nfs+bounces-2777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A68A2CDC
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE772864F3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021642075;
	Fri, 12 Apr 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AF/lgYOV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2325380F;
	Fri, 12 Apr 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919021; cv=none; b=QzpCaqCYYuBvXPiTjs9xE2WscXUsCC7CMvSTkNW/k5MAW7p0Ih0tGqj1YfVGlTRnyL4Q+lzeR0ET6agh5WvMu2oMO5Vbnz1gfITs7phCbbUNtMEyvzYJjVr/ma4oANEPm5J36vdRvjk7KVuVV3Q/55l8NA2gDv7zsUvWaOwQkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919021; c=relaxed/simple;
	bh=nG5//PQX8Ccmwb0z7Xegu0yxztKcLOij0AQ5eVxEn7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv1kcHlXEfILQtwzkb3TLpRrYBkldZ5z8akAjkZSqgVjhhpXu2qobK6l9Mm4lAwJg22KzqZXmzG6DuXyjp++Jct4in04HRjFI0zKx3orFY/OQMLwDHC6xNa1QsS7C++4f+4QCsRuYpg3EbtgXoB18GicEjlsUSxq5ssWpmXNvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AF/lgYOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9BCC113CC;
	Fri, 12 Apr 2024 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712919019;
	bh=nG5//PQX8Ccmwb0z7Xegu0yxztKcLOij0AQ5eVxEn7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AF/lgYOVzLA2DdxByiw3bw5EhMxO8ClOxYUHnYbqXlIOcZfGYhQbNLceCJ3fftICV
	 YEJY6iXokw8pixsDdTperQoJkfeWsob6gmC1f4hHGqwjykQepVCGuMtVv2/yXa0Sap
	 CXkHmGt13PUO5tx5W5drE2fZUZwta4Snc3Ctz9yc=
Date: Fri, 12 Apr 2024 12:50:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Calum Mackay <calum.mackay@oracle.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <2024041257-repulsive-balancing-a685@gregkh>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>

On Fri, Apr 12, 2024 at 03:55:34PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> 
> On 11/04/24 15:27, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.155 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > Anything received after that time might be too late.
> > 
> 
> I have noticed a regression in lts test case with nfsv4 and this was
> overlooked in the previous cycle(5.15.154). So the regression is from
> 153-->154 update. And I think that is due to nfs backports we had in
> 5.15.154.
> 
> # ./runltp -d /tmpdir -s fcntl17
> 
> <<<test_start>>>
> tag=fcntl17 stime=1712915065
> cmdline="fcntl17"
> contacts=""
> analysis=exit
> <<<test_output>>>
> fcntl17     0  TINFO  :  Enter preparation phase
> fcntl17     0  TINFO  :  Exit preparation phase
> fcntl17     0  TINFO  :  Enter block 1
> fcntl17     0  TINFO  :  child 1 starting
> fcntl17     0  TINFO  :  child 1 pid 22904 locked
> fcntl17     0  TINFO  :  child 2 starting
> fcntl17     0  TINFO  :  child 2 pid 22905 locked
> fcntl17     0  TINFO  :  child 3 starting
> fcntl17     0  TINFO  :  child 3 pid 22906 locked
> fcntl17     0  TINFO  :  child 2 resuming
> fcntl17     0  TINFO  :  child 3 resuming
> fcntl17     0  TINFO  :  child 1 resuming
> fcntl17     0  TINFO  :  child 3 lockw err 35
> fcntl17     0  TINFO  :  child 3 exiting
> fcntl17     0  TINFO  :  child 1 unlocked
> fcntl17     0  TINFO  :  child 1 exiting
> fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
> fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes
> by hand
> fcntl17     2  TPASS  :  Block 1 PASSED
> fcntl17     0  TINFO  :  Exit block 1
> fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir:
> rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed:
> unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcnp7lqPn) failed; errno=2: ENOENT
> <<<execution_status>>>
> initiation_status="ok"
> duration=10 termination_type=exited termination_id=5 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> <<<test_start>>>
> tag=fcntl17_64 stime=1712915075
> cmdline="fcntl17_64"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> fcntl17     0  TINFO  :  Enter preparation phase
> fcntl17     0  TINFO  :  Exit preparation phase
> fcntl17     0  TINFO  :  Enter block 1
> fcntl17     0  TINFO  :  child 1 starting
> fcntl17     0  TINFO  :  child 1 pid 22909 locked
> fcntl17     0  TINFO  :  child 2 starting
> fcntl17     0  TINFO  :  child 2 pid 22910 locked
> fcntl17     0  TINFO  :  child 3 starting
> fcntl17     0  TINFO  :  child 3 pid 22911 locked
> fcntl17     0  TINFO  :  child 2 resuming
> fcntl17     0  TINFO  :  child 3 resuming
> fcntl17     0  TINFO  :  child 1 resuming
> fcntl17     0  TINFO  :  child 3 lockw err 35
> fcntl17     0  TINFO  :  child 3 exiting
> fcntl17     0  TINFO  :  child 1 unlocked
> fcntl17     0  TINFO  :  child 1 exiting
> fcntl17     1  TFAIL  :  fcntl17.c:429: Alarm expired, deadlock not detected
> fcntl17     0  TWARN  :  fcntl17.c:430: You may need to kill child processes
> by hand
> fcntl17     2  TPASS  :  Block 1 PASSED
> fcntl17     0  TINFO  :  Exit block 1
> fcntl17     0  TWARN  :  tst_tmpdir.c:342: tst_rmdir:
> rmobj(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed:
> unlink(/tmpdir/ltp-jRFBtBQhhx/LTP_fcn9Xy4hM) failed; errno=2: ENOENT
> <<<execution_status>>>
> initiation_status="ok"
> duration=10 termination_type=exited termination_id=5 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20240129-167-gb592cdd0d
> 
> 
> Steps used after installing latest ltp:
> 
> $ mkdir /tmpdir
> $ yum install nfs-utils  -y
> $ echo "/media *(rw,no_root_squash,sync)" >/etc/exports
> $ systemctl start nfs-server.service
> $ mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir
> $ cd /opt/ltp
> $ ./runltp -d /tmpdir -s fcntl17
> 
> 
> 
> This does not happen in 5.15.153 tag.
> 
> Adding nfs people to the CC list

Any way you can run 'git bisect' to find the offending change?  There's
a lot to dig through :(

thanks,

greg k-h

