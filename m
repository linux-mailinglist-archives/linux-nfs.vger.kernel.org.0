Return-Path: <linux-nfs+bounces-6420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D150A9773BC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F91C23D24
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2481BDA94;
	Thu, 12 Sep 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvFtScBp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A22C80
	for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177456; cv=none; b=Y+9svTG3gGFm1PMiC7lY3OKWKzmPXjubD+oy6eju/iFy6xOjg0ZFci8aws2/j44fPdwTQug3SbuYPMpCypJFIc1DOL8W/z7zHaSUd4VE/i7Eqr8URrPTdG3yUdyHXSgJTEhF+GAJAY4fabLVChbM63wJTyu+trlWoSSZvlSuz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177456; c=relaxed/simple;
	bh=NQZS7vdk2eMiIotW3tW4W6R/pN0x2R4QMmqapBdBJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc8gC1SkerDzyQBOcn7YITqIL1ga7XvnA69zrHDKeQp5aXYwyTqXEwBR8VuepvkTmcLAosh3D+L/LxoeFeyyPEYuppewAIpcG0PwerhQJgH5hgHrAfyUfAawak1+dmxD1eAKDKSOnnSzWHhchzm0xQKnsFz+IyCVNluO6zguvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvFtScBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDF5C4CEC3;
	Thu, 12 Sep 2024 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726177454;
	bh=NQZS7vdk2eMiIotW3tW4W6R/pN0x2R4QMmqapBdBJIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvFtScBp6Qn8F53QZppiIXC/CaYtedXmGf3NKAxTU9t5X/kv6cYHhIpvyUdKK/azj
	 vaM69FYCXy69ULjZq3pGlT4CUwWJ6hbyEv0SGe/Jfcx20JaQZyID9n0avKKeihTj9P
	 XOC7P+Y0z0D5z/Pp+c24CB7UiWNLPWsBQioFX74s=
Date: Thu, 12 Sep 2024 17:44:13 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Bugspray Bot <bugbot@kernel.org>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org, 
	trondmy@kernel.org, cel@kernel.org
Subject: Re: New bug in the File System/NFSD component
Message-ID: <20240912-silky-cuckoo-from-venus-e74de4@lemur>
References: <20240912-b219268c0-341707066a14@bugzilla.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912-b219268c0-341707066a14@bugzilla.kernel.org>

On Thu, Sep 12, 2024 at 09:41:44PM GMT, Bugspray Bot wrote:
> Please ignore, testing mailing list integration with the new "File System/NFSD" bugzilla component.

Testing mailing list bridge write-back to the bug.

-K

