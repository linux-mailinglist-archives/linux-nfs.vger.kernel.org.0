Return-Path: <linux-nfs+bounces-3672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB5904967
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B77B21A14
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F3BA31;
	Wed, 12 Jun 2024 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKUYSZTe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C483171C4
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161975; cv=none; b=Y0yHoMxPOIZ1SYJbUB8urwCUe5MTOChpGBqZpoeMunhajymWvuq73oJ0oZpqA8YpOCjGAhFzInN17/1x76pVThHmYSqHHSVuzQFP0xc4UPddL2kgAVRA4/bgjSl9dZsoyJf2a21buGZDiw3gtbH3iMkYzfzeSiwNIgfK1t8CzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161975; c=relaxed/simple;
	bh=XGiIKywJZ4DFqkvS+GDur0BKV0hZ6F7H+a0mGSa3muI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWyc/P5DLoFlnmBq5mbHhgUThfBIKdWb+rk+JB6bLfkO/Dd4y8fRSMSsxqrnu6jnWEsmvzrUoQE8/eg+tl9y5I3nko/vxzhBw/4jhb/nGrJOhxQq3VHZx3E8z9i+yxusxJaMiwsxj82C/uwnwMHW/UuQFl/0/pT0FkcqxAfa59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKUYSZTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C5C2BD10;
	Wed, 12 Jun 2024 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161974;
	bh=XGiIKywJZ4DFqkvS+GDur0BKV0hZ6F7H+a0mGSa3muI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKUYSZTetUY7c8r4Wixa3zmSgJIENum2jaejHU1erpKrxNgzgGRimcvuY7xAB0zbM
	 W5Yc4bARGRRr2oenjPzMBO+AAg/woLIvvGD6Z7Nd2mrXWcvBvVqfe+uIAPJbsYTQBO
	 8hfepFY/KG7VgbuA/GevJR9DAQHFBfpLd6nLYQWT5B8uNAagPJbc803fzFae/5Bzeb
	 Cs7hIN761iXiK2oUUftXc+761zsfaXKUe+CZHOquqfFhd+NM31cAh21hYaN9YOdjZw
	 W19mLphw+4sBPsVXT+OjMak7Ng7uugi73eVn67PbeMr/6Rrg62qTbSE/FeAcYezj5B
	 zzbVU22dbkmlA==
Date: Tue, 11 Jun 2024 23:12:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 00/15] nfs/nfsd: add support for localio
Message-ID: <ZmkSNUqa-WN7V4UJ@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>

Here is my git tree for these changes:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11

