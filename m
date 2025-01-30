Return-Path: <linux-nfs+bounces-9800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C09A23139
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 16:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF5A3A675B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635B1E98F3;
	Thu, 30 Jan 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKBdlQ6y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19701E1C22
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252482; cv=none; b=IEZ5qEtOCZLt0wLQuFJFMi3OKMcI0Ij44XkLLLmQLfUAJNG2iJ+93jbIO82oKs3w6RUTXP1R9U5HA1N4gQzCxm/ub2K+EFWIukWZvniIRt2aXCxo1mNBM4iWPDQsM9YNkExGeLuRmfBpqPcIEnxod1+8FXnrcCEupcxPgaJs7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252482; c=relaxed/simple;
	bh=HRP8RZHHHJjwuHeDUBMNZuDTMoBMgdAHMjQ93QaFyk8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=MnX7z4Cr+ErRu9Jw/lKUJVvKk1+kjruYCnsxOSCoLrlbIsbpCEi5uny3OKOB1iWss1s/OEBHEqYrbV8ar/9OI4Bp3zPYgape6wNkWBBGw8Zmw3BxCz34En1wIdtLhxSP6Wiwj3SWIvzbNfKtJcGQyqbSMIR4SZqFH8kfkpeNKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKBdlQ6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA4CC4CEE0;
	Thu, 30 Jan 2025 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738252482;
	bh=HRP8RZHHHJjwuHeDUBMNZuDTMoBMgdAHMjQ93QaFyk8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=pKBdlQ6yNOnNpr7oHM4ERCkgMAWqH01/z9+ytL6ZeO5BVROiR8H8hyBpx2w7APraf
	 DBmG3wrnx8fmceW6aB7hUgIla+afZ/wJoWVi1syQM1Nc/2Vs8q7eKzc87AAWxcp9yJ
	 Nytx3P04LU6pYP1FQ8u0/5UkqWrAs41EoEZeFLdCKJQRhehVX8oQDt9uIFq2jN5uxj
	 MzS+OG3X7Vuc7TFOnYgqFSm950wH32u/UhCa1HOlLnT4AVxo31nSmGaVYAgIBSCTMT
	 ESlJGRfj16UvcWPyNV5By+2+kMHtA9hoLt6fm5yRyCAfMFO/Wpo7OM1pR9XmJwXCxD
	 rzygZeUjxo4hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7700A380AA66;
	Thu, 30 Jan 2025 15:55:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 15:55:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 trondmy@kernel.org, anna@kernel.org, aglo@umich.edu
Message-ID: <20250130-b219737c6-6072bb2792cb@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c4-ed5364ddf3cd@bugzilla.kernel.org>
References: <20250130-b219737c4-ed5364ddf3cd@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #4)
> (In reply to Bugspray Bot from comment #3)
> > Olga Kornievskaia <aglo@umich.edu> replies to comment #1:
> > 
> > > First issue is the explicit use of NFS4ERR_BAD_XDR in the CB_GETATTR
> reply
> > > decoder. Should be EIO instead.
> > >
> > > Second issue is the CB_GETATTR reply decoder does not seem capable of
> > > handling a non-zero status code in the reply.
> > >
> > > Third issue is whether NFS4ERR_BADHANDLE means the server requested a
> > > CB_GETATTR for the wrong file, or if it is an expected situation.
> > 
> > Isn't this because 6.12.x is still missing the patch "NFSD: fix
> > decoding in nfs4_xdr_dec_cb_getattr" that just went into 6.14?
> 
> Yes, second and third issues are addressed by 1b3e26a5ccbf ("NFSD: fix
> decoding in nfs4_xdr_dec_cb_getattr").

I take it back: The third issue is not addressed by 1b3e26a5ccbf. Why is the server sending the client a delegation that it rejects? And does the server recover properly in this case?

But again, 1b3e26a5ccbf should prevent the warning reported here.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


