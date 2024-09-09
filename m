Return-Path: <linux-nfs+bounces-6347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799B971CFC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44093283462
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADF1B2EE6;
	Mon,  9 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuswX2lj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB86B641
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893159; cv=none; b=cfjuvD8j57LdI9Uhy9bFXHRBdKq+R8sfjGJ2QJHZMqeDS/BT/4y2Dsodo9AZznl+Flzp6naqdA54DdtwMxcTNvaep0/Iu62s0spMO41dM5Q2ucOCWLkVZW3apuXD0IAIO3FTsum1oA+UpNepSgeWYa0/2D5upFGJRZLukl7oGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893159; c=relaxed/simple;
	bh=hewPIOrBLoMezBMmlJo3QGbfMofYXzcx5LjbfcKznvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vlz3uw9a4DdNLmPAJa6LWTlANhGGwZ11G+Z1V2ZvADI/+tc9pNKimYfg6wl0SU7kRo8v2JrJWYBKcMW7a0WXYL+y0DhWV6I8G4w5fdWEOPdO4ewRh9VzgG7HHgNMmhrjmHW2aQlLoDNuVWdGvjPV3/F8mcHxAcgx3cPu2oGiFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuswX2lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E1EC4CEC5;
	Mon,  9 Sep 2024 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725893159;
	bh=hewPIOrBLoMezBMmlJo3QGbfMofYXzcx5LjbfcKznvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuswX2ljr+8z4niQ2eqFEh0XutqcDTio/64O96I7PYI1FuiAth0pMt7VoMxh2tzkt
	 8UQ7PbpPhFqEi3bfc6YMml7L0FWwNaZmIo4SVynsQCD03Am0j1Ek2X5xsfLDgZWxmF
	 7/cEp25/r5rXBHw2yMONVO101TFD32CPeMOn4dGkLqbt5p8Z+ZmYmtfN9QOET9Rnyt
	 V/y+OxWmqmhkESi56hxUqVNx8nQ3HZctDpoxtKIIdXNQ5qJFOV0fZ808SYbdjalqBp
	 R2XG+aRXHGeY7TBA8ygIVUTRy7WtqKqMGnkVyDtYjrb2utAv3HARJoGwnTOMYlswme
	 MGk10TX3IO0Gg==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at least 30 seconds
Date: Mon,  9 Sep 2024 10:45:36 -0400
Message-ID: <172589292304.64754.15427183970746379670.b4-ty@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 09 Sep 2024 15:06:36 +1000, NeilBrown wrote:                                              
> The pair of bloom filtered used by delegation_blocked() was intended to
> block delegations on given filehandles for between 30 and 60 seconds.  A
> new filehandle would be recorded in the "new" bit set.  That would then
> be switch to the "old" bit set between 0 and 30 seconds later, and it
> would remain as the "old" bit set for 30 seconds.
> 
> Unfortunately the code intended to clear the old bit set once it reached
> 30 seconds old, preparing it to be the next new bit set, instead cleared
> the *new* bit set before switching it to be the old bit set.  This means
> that the "old" bit set is always empty and delegations are blocked
> between 0 and 30 seconds.
> 
> [...]                                                                        

Applied to nfsd-next for v6.12, thanks!                                                                

[1/1] nfsd: fix delegation_blocked() to block correctly for at least 30 seconds
      commit: bd400f0ac66e0a6e1276d6455d73aed6ce6a1453                                                                      

--                                                                              
Chuck Lever


