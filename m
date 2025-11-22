Return-Path: <linux-nfs+bounces-16667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86CC7C8EB
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 07:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71F3A34B4F6
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DD25FA13;
	Sat, 22 Nov 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OB7qVBZW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994C24677B;
	Sat, 22 Nov 2025 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794614; cv=none; b=dSDNb+KmZGtiQ3YI+aUxF9A1FxidKWNUq1izLz/s3K5AE4Mr0zWCngsawcRP2pWbU0pBBZmAHT22k0/7NXRAZA8sZrqUNyRAWPO1WIhGfDLO9LpW+F1342hi3vW3lP/tVXEIdSE38q2CvT2kX8f+vAweuCwlpB0Xg9N9sqdGQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794614; c=relaxed/simple;
	bh=zrf9TflH3fL64W47svYyJNEAOfWM2Bs9XK7YUATtbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo7hg+tV6COOrVfQvzF8mizoON4GzpSZ8ql4adVafpdAZ2g2d+CTGFHIFRX6k44ZL3ddwsoOZEc0IR/27+6Xw987JRTLr9QWu8vxPl6sm7rBvlGMTCw2xF4MgvGxHZO5KWOFjjdJJx0xjiZ6POy+sNVYgUu4Z0IJuDV+abOHljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OB7qVBZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD98C4CEF5;
	Sat, 22 Nov 2025 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763794614;
	bh=zrf9TflH3fL64W47svYyJNEAOfWM2Bs9XK7YUATtbWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OB7qVBZWPuyxJ5/3ZKdTwfsgJoQPcuR1/KFC3TqpQLwdlWqD4h2ytBv4m0j5E+U2K
	 A/uGxA+XauxuHO3bOAEYPoDrTKe7yQ2+f3dIQJc/Xti7q4a960C7hYMjDO4vqrkkzG
	 qMOm0w0C+e+aWIOM+pSYRtfHbSCFu0Xkxa01Plq0=
Date: Sat, 22 Nov 2025 07:56:51 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"trondmy@kernel.org" <trondmy@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [REGRESSION] nfs: Large amounts of GETATTR calls after file
 renaming on v5.10.241
Message-ID: <2025112203-paddle-unweave-c0a2@gregkh>
References: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>

On Fri, Nov 21, 2025 at 06:56:31PM +0000, Ahmed, Aaron wrote:
> Hi,
> 
> We have had customers report a regression on kernels versions 5.10.241 and above in which file renaming causes large amounts of GETATTR calls to made due to inode revalidation. This regression was pinpointed via bisected to commit 7378c7adf31d ("NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity") which is a backport of 36a9346c2252 (“NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity”). 
> 
> We were able to reproduce It with this script:
> REPRO_PATH=/mnt/efs/repro
> do_read()
> {
>     for x in {1..50}
>     do
>         cat $1 > /dev/null
>     done
>     grep GETATTR /proc/self/mountstats
> }
> 
> echo foo > $REPRO_PATH/bar
> echo "After create, before read:"
> grep GETATTR /proc/self/mountstats
> 
> echo "First read:"
> do_read $REPRO_PATH/bar
> 
> echo "Sleeping 5s, reading again (should look the same):"
> sleep 5
> do_read $REPRO_PATH/bar
> 
> mv $REPRO_PATH/bar $REPRO_PATH/baz
> echo "Moved file, reading again:"
> do_read $REPRO_PATH/baz
> 
> echo "Immediately performing another set of reads:"
> do_read $REPRO_PATH/baz
> 
> echo "Cleanup, removing test file"
> rm $REPRO_PATH/baz
> which performs a few read/writes. On kernels without the regression the number of GETATTR calls remains the same while on affected kernels the amount increases after reading renamed file. 
> 
> This original commit comes from a series of patches providing attribute revalidation updates [1].  However, many of these patches are missing in v.5.10.241+. Specifically, 13c0b082b6a9 (“NFS: Replace use of NFS_INO_REVAL_PAGECACHE when checking cache validity”) seems like a prerequisite patch and would help remedy the regression.

Can you please send the needed backports to resolve this issue as you
can test and verify that this resolves the problem?

thanks,

greg k-h

