Return-Path: <linux-nfs+bounces-202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E77FF020
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9501DB20E29
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FE47A4C;
	Thu, 30 Nov 2023 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yY1PZb5f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16E3C693;
	Thu, 30 Nov 2023 13:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D592AC433C7;
	Thu, 30 Nov 2023 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701350936;
	bh=JfQCHvXQb7AsIGAJsIWuTELlA180Z0upErGZCCvpdik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yY1PZb5fiAU7NCaXYilJGL3hMHI3WmcZqAHl+A1erPsKs4hZ1MuLgSAE08/qjjagy
	 QWcS8E2dRL8WkRf/RB8RmkbpavvBYJPkElE+wM/3q6PP6yXqdRg2SKv282ptmXZhq1
	 IiYdXXUokBjFhc0XW/HsEWY66jdZNdl9LRTL66QQ=
Date: Thu, 30 Nov 2023 13:28:45 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd fixes for 6.6.y
Message-ID: <2023113035-monologue-stump-645c@gregkh>
References: <170120862772.1376.15036820033774301160.stgit@klimt.1015granger.net>
 <E01AE605-9548-40AF-A72D-01D46B8A749E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E01AE605-9548-40AF-A72D-01D46B8A749E@oracle.com>

On Tue, Nov 28, 2023 at 10:05:45PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 28, 2023, at 4:58 PM, Chuck Lever <cel@kernel.org> wrote:
> > 
> > Backport of upstream fixes to NFSD's duplicate reply cache. These
> > have been hand-applied and tested with the same reproducer as was
> > used to create the upstream fixes.
> 
> These applied with fuzz and offset but no rejection.

All now queued up, thanks.

greg k-h

