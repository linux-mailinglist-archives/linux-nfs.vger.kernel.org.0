Return-Path: <linux-nfs+bounces-13489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2413B1E0A2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 04:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4129F3BA62A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31077462;
	Fri,  8 Aug 2025 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuA9Lu72"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFEF367
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754620477; cv=none; b=X3QaPmi6TqAtVh3y49KKJxmYV2AprFnVj+uk9TmMBWzVuT1mqfRo0KLrr9Uw5+J2bf9gtq6jT8JExci0plPFH1RWbLHvlAJAE8zcAUMZywf48MrdYbeeU8Dh5PjoBmE1RIdJCk7+n9KCtJupSekr7yJe5NvNE0qFWlL+F9fukWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754620477; c=relaxed/simple;
	bh=QlH/5Z+vnBA3mLLo+L6rYMD/aadAUq46nJN+hrD4sMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV6rAIHEhrBzc/Lg13apQ8CKP7Ia5Sj9xbetB4f65CRXixBLolU8ePBq3sHi+esvfTTCaaG/uzCYXWAbYpWVRAwox895SW7PtKMCc+SzTtO5PDFuuVMBahW8Wd3nhLA0YwidKfDLh0crvEA8wHqrAW4y9vYUIr/w2DemvSvXIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuA9Lu72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0FBC4CEEB;
	Fri,  8 Aug 2025 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754620477;
	bh=QlH/5Z+vnBA3mLLo+L6rYMD/aadAUq46nJN+hrD4sMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuA9Lu72bGVO9GQxVJ6pUekCV8x7xWESroVyCQ4G5d/sMmBV3Qk3yDbleSmh5iGoP
	 W5EOhhGW9YaCoRrvg+uh5+KzpS/G2YWSBujILF2dElHGC6dvaYEnGN5YztFC5ahJrT
	 F0lXA9UkPZsvl19jNCE+ZokPdab0mOhWhiVcavVQvRn0DMv5kbnDGyC7jRqv1q8KGZ
	 2hhiHiJlQ0NE4TY1rbw5/ksyCp2G1kbNw0fZvUBNyLUrq3U/mHH1pT55fJpSfUlRx6
	 8FU7iBZnDwzxR/1sDDmcrK2H2xqLpfRjSUgZW97TO9IyZM4ejnvisMZTsgPdULUtNr
	 3Rb1SV0BSuDVw==
Date: Thu, 7 Aug 2025 22:34:36 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, zlang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: Re: nfs/localio: restore creds before releasing pageio data
Message-ID: <aJViPHUfZDQmpMpj@kernel.org>
References: <aJKUHsz79TOHHQE7@kernel.org>
 <20250807164938.2395136-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807164938.2395136-1-smayhew@redhat.com>

On Thu, Aug 07, 2025 at 12:49:38PM -0400, Scott Mayhew wrote:
> Otherwise if the nfsd filecache code releases the nfsd_file
> immediately, it can trigger the BUG_ON(cred == current->cred) in
> __put_cred() when it puts the nfsd_file->nf_file->f-cred.
> 
> Fixes: b9f5dd57f4a5 ("nfs/localio: use dedicated workqueues for filesystem read and write")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> Mike - I applied the four patches you mentioned and I still see the oops
> quite frequently.  This patch fixes it for me.

Looks good. Interesting that I've never experienced this BUG_ON.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Thanks!

