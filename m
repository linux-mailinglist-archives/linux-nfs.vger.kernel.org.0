Return-Path: <linux-nfs+bounces-11432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E6DAA84DF
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5F1898CF2
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC0175D39;
	Sun,  4 May 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOePsVyX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7C13DDBD;
	Sun,  4 May 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348524; cv=none; b=m4lXPzA8xe3uNYfupvr7vcu1YCZCMC/QV2nNTpnlRQHjdrXuKdOCLQMCQCPea1gbND/1xrLn3NykcxLkxo3xYRksuV+ir1SmB4YZ3Lno1om7AD4Qtxb8/ZTgnSbEznMwBABsn3lCmzZX27vu8rEwKs7brR6ytp0NJHngsApXrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348524; c=relaxed/simple;
	bh=JZnWQGowh57Pzg9HavZUu3m/YDhZr6puyroHAF+qYsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY60gKbpC8hV7UlFoMVdH9AKW36FSJl9e0FrjBUEojb2Iu2Va/cH6CT9NiJkYepjI3CGlW9wT62uGSX7VX+xsniOSElpjITYN+nB6kEN1Fvt5sbNxQwoeXgYgVE8LVz603dZmle0jvNug7YtBcAb3dAPu37OYL7R/l6WOQkFETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOePsVyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2508BC4CEE7;
	Sun,  4 May 2025 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746348524;
	bh=JZnWQGowh57Pzg9HavZUu3m/YDhZr6puyroHAF+qYsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOePsVyXlzuLdbd0rGpHeNWxjX5ri0AsdfTvz+uGRQe+ADVhQlWXhxrb67vk1JwNW
	 N0HNWV3vB4wodd76143nzT192m4D1VtOMgiQIV+RvQ1IFFQ1yM3/GDSU9oRH1QC4W1
	 yw9DKbvbMS24yFGX83ee5LW0TZTP3KMQprvMoMztxznaASGSS63kzyet+cv8bd7mfn
	 EYEhj035ttXiI2eNZRv6//ppRYbMXIav40ue+UXzdBVBGDWg8TFDMGdk0UWZIhaD0l
	 6T2+3Aw78EmXCIhkm2RmRg4BVN6t6vjBAol4sXdCMjZ/zCUZKiWHgFr3HB8rzLYjUf
	 2OdjieecBEQVg==
Received: by pali.im (Postfix)
	id 02937731; Sun,  4 May 2025 10:48:40 +0200 (CEST)
Date: Sun, 4 May 2025 10:48:40 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20250504084840.4n47y4zhqjqsk6bu@pali>
References: <20240912130220.17032-1-pali@kernel.org>
 <20241222164018.id3ul7ucaxsrdkyq@pali>
 <20250418180313.h4jxi2rfxsmroumf@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418180313.h4jxi2rfxsmroumf@pali>
User-Agent: NeoMutt/20180716

PING?

On Friday 18 April 2025 20:03:13 Pali Rohár wrote:
> PING?
> 
> On Sunday 22 December 2024 17:40:18 Pali Rohár wrote:
> > PING? If there is no objection, could you include series into -next?
> > 
> > On Thursday 12 September 2024 15:02:15 Pali Rohár wrote:
> > > Linux NFS3 kernel client currently has broken support for NFS3
> > > AUTH_NULL-only exports and also broken mount option -o sec=none
> > > (which explicitly specifies that mount should use AUTH_NULL).
> > > 
> > > For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> > > export with AUTH_UNIX authentication which results in unusable mount
> > > point (any operation on it fails with error because server rejects
> > > AUTH_UNIX authentication).
> > > 
> > > Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> > > one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> > > server does not announce it even when the export has the only AUTH_NULL
> > > auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> > > is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> > > for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> > > AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> > > 
> > > Main problem on the client side is that mount option -o sec=none for
> > > NFS3 client is not processed and Linux NFS kernel client always skips
> > > AUTH_NULL (even when server announce it, and also even when user
> > > specifies -o sec=none on mount command line).
> > > 
> > > This patch series address these issues in NFS3 client code.
> > > 
> > > Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> > > by trying AUTH_NULL authentication as an absolutely last chance when
> > > everything else fails. And honors user choice of AUTH_NULL if user
> > > explicitly specified -o sec=none as mount option.
> > > 
> > > AUTH_NULL authentication is useful for read-only exports, including
> > > public exports. As authentication for these types of exports do not have
> > > to be required.
> > > 
> > > Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> > > AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> > > MNTv3 userspace server. And also tested with exports from modified MNTv3
> > > server to properly return AUTH_NULL support in response list.
> > > 
> > > Patch series is based on the latest upstream tag v6.11-rc7.
> > > 
> > > Pali Rohár (5):
> > >   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
> > >     server
> > >   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
> > >   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
> > >   nfs: Fix -o sec=none output in /proc/mounts
> > >   nfs: Remove duplicate debug message 'using auth flavor'
> > > 
> > >  fs/nfs/client.c | 14 ++++++++++-
> > >  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
> > >  2 files changed, 65 insertions(+), 13 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > > 

