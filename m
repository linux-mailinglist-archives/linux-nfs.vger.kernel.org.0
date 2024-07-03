Return-Path: <linux-nfs+bounces-4576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB3924CEA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 02:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A41C21341
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3B184E;
	Wed,  3 Jul 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF9fc9S+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6254139D
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968280; cv=none; b=mR/paitg8HPjtKfi3Yftm6nDApYllbZIjfyHt5GuVXqYD/XDmGBUr29ARJBdNsmXGvpdNjThtZwGEevUoDvUgeSCKJYnbmW3X6jfy9pc41D6ttIbdtForMzo8rzaTx4LqpwW3sVscAtgoVaPglx+8ZXQ/ZG5KIVgLaGw3EUMllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968280; c=relaxed/simple;
	bh=pvHwM6fJDzn+TnNI/Pvs/Ba9Wv6BTbipNRPJ8cPRKFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6gn9rC/7PVRCQHxMMtSkhs6codd0ejBlR7geaQLJjGl/NXCpP9/dSfhGeHVdNF/1ZCLGmBmvLR35rFCP1+AfqnsHHVU7Xw7OyYvPmrmww6tPhfVwiQJlcA3h+4xvmdyMvWYDDvJNRuqFBZeoPZD4Nbks7MdNpbvIWXWo0H9Jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF9fc9S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264BC116B1;
	Wed,  3 Jul 2024 00:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719968280;
	bh=pvHwM6fJDzn+TnNI/Pvs/Ba9Wv6BTbipNRPJ8cPRKFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF9fc9S+qJvMCiL/u7vB8qmUK5yD439U/4jYOS8telmx9cYtBoDY9dfm5i803Ej3o
	 NigRVEzciE0XpHqELVphEZzsGvvoXTk/hY3Wixitt7yCD7uAKr5ve9TQqD2E09yl8r
	 bz1Iwm4IWojMBFp8O+7gTsSBMaS+KvYdDnKW9/AxGxhrT+LGiqEAnl0SnzWx6XgsDH
	 aY3b4Xp5INsW9c4z8C+4yNPyBaMCl5Zr3IYp6dTI2BgMS4NPFaSWg2a1vCLZ9pU5cn
	 o0gKy5xFyO2O6+vgmMxV5CF3xMyDgE1I+DpWF0o21w9OPBGM5W9RIMjeHxrpg59W7F
	 mzEI2mdz5tXtw==
Date: Tue, 2 Jul 2024 20:57:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoSiFuIkpJXHj1zQ@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoRHt3ArlhbzqERr@kernel.org>
 <D59D6432-0D47-427C-9549-EF60C59595C4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D59D6432-0D47-427C-9549-EF60C59595C4@oracle.com>

I am an upstream Linux kernel maintainer too.  My ideals and approach
are different but they are my own ;)

The first localio RFC (that made it to list as v2) was posted on June
11.  I have tried to work well with you and everyone willing to help
and engage.  So for it to come to this exchange is unfortunate.

Development with excess rebases is just soul-sucking.  My v11's 0th
header certainly conveyed exhaustion in that aspect of how things have
gone as this series has evolved.

I clearly upset you by suggesting v11 suitable to merge for 6.11.  I
really wasn't trying to be pushy.  I didn't think it controversial,
but I concede not giving you much to work with if/when you disagreed.
Sorry about painting you into a corner.

v11 is a solid basis to develop upon further.  I am all for iterating
further, am aware it is my burden to carry, and am hopeful we can get
localio staged in linux-next early during the 6.12 development window.
Let it soak (Anna's instinct was solid).

However, I'm hopeful to avoid the hell of frequent rebasing ontop of
refactored code that optimizes approaches that this v11 baseline
provides.

SO I'd like to propose I carry the v11 baseline in my git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
And any changes (e.g. Neil's promising refactor to avoid needing
"fake" svc_rqst) can be based on 'nfs-localio-for-next' with
standalone incremental commits that can possibly get folded via a
final rebase once we're happy with the end result of the changes?

Thanks,
Mike

