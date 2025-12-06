Return-Path: <linux-nfs+bounces-16971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3ABCA9E80
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 03:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8382630698C7
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 02:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522922F755;
	Sat,  6 Dec 2025 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udeLB0h4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618828695;
	Sat,  6 Dec 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987809; cv=none; b=p0OckyTnea0wYWtLArU4Bvot5acwMAQwyGEw/BbqYLPY2it3PU8p1X1PYdSdvg2JmrcXRQViOrrri3QsTZ05tbMUlFvnRKGZdg/jCbtVRCOjRIS0k6F0JO/ZpxKVrRqYe1Q+yGUH9H9VPXs7XMCej4d1lmBS5gbiTkkVwS8sNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987809; c=relaxed/simple;
	bh=XDwPkTU084rW4ZIOzS+8kR9yLx4I3sMlmXwz8nKm+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9xywmSCPB3Wp9RHUNFYOJDLFBHf/605N4Wm+Ljg9OD1NH2IDC6OVJsJ5Q/ltFErp0Vf0MlLDG/bPdt3HrxG2nioz4ShSfkQDW7Mo6+VgTYzI8q4p9iF1jgvktK5rynzTzZTTNfNgOkioACRSudhvUHM5mlyMg7P0CXcDosWufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udeLB0h4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F463C4CEF1;
	Sat,  6 Dec 2025 02:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764987808;
	bh=XDwPkTU084rW4ZIOzS+8kR9yLx4I3sMlmXwz8nKm+cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udeLB0h417iDrgzky0Yj7Gw2CSJFezUrnfLfDVA+/vHPqFADGpTI42xMeTFS0HaoG
	 leBrGsgFRyv4/0G7cSKxuFI8ndJvRYL2On2JZZkRF2+9BCsPjkqjrI46GGXpESiHQ2
	 qxlBYlm+FJBRdebWAj0SaMFfig+hODj1eF0Bj0cxjFd0A8TTivhSwp2dwqJ8piFUVt
	 Xii2F1bH9HGiE9gWpZS/GABHG9FkKD27a7HzdVR3Ar7WxZP4Ty0eQIePAIM4PaeVMa
	 126SaE9fc4rKv3r5WCzjRermBsizYZvqFceknUPkeDUCpc+E+Me1mpFGUb0jfrTOpi
	 tpZIoXqb7mxWw==
Date: Fri, 5 Dec 2025 21:23:27 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Brauner <brauner@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus'
 tree]
Message-ID: <aTOTn3n-0V42j8he@kernel.org>
References: <20251205111942.4150b06f@canb.auug.org.au>
 <aTIwhhOF847CcQGl@kernel.org>
 <64034c4b052649773272c6fa9c3c929e28ecd40d.camel@kernel.org>
 <aTN6d0Qkh3WKt796@kernel.org>
 <CAHk-=wh58ZKQTC1iogoMy+Rj+gOuSQM_r2jT3NKD_jiiLyvU8Q@mail.gmail.com>
 <CAHk-=wj3B1-nZ-4jUP0FsLH4f1bbpO=Q9J88Ziz=wxE-Jm-skw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3B1-nZ-4jUP0FsLH4f1bbpO=Q9J88Ziz=wxE-Jm-skw@mail.gmail.com>

On Fri, Dec 05, 2025 at 05:55:50PM -0800, Linus Torvalds wrote:
> On Fri, 5 Dec 2025 at 17:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let me do that once I finish my "merge various architecture updates".
> > I'm almost done with that side - just one more SoC pull to go, I think
> > - and can go back to looking at filesystem changes.
> 
> Ok, done and pushed out. Can you please verify that the current git
> tree looks like you expected?

Looks good.  Thanks

