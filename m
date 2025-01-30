Return-Path: <linux-nfs+bounces-9799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81253A230EF
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 16:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896803A4CFF
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF41E9B17;
	Thu, 30 Jan 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr8MT6lh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76351E9B00
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250383; cv=none; b=XahEcS85DDqWZHf6VtGrLSW0JpDR3GXpRQBuP64b23K9pboYVzcenVfLep+eMiKwGned9SyMC+0g9xRxnOBvzooXCHRj0qk1sb37LFVZXuduOFpkt49KJg6T2MxSp/q3m9eC1Zi4IiqRlULCnX9EoH3YGTUBuvcTKXItTjtB/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250383; c=relaxed/simple;
	bh=Jct2ZwK4+W+jYiJw7vjaqlgtQMxQcCCHCeg9Kd1oe90=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=nwtsNiFT3I2Pe15FGox53VtdxLt5bcpTV1oJnVuMNkkGPYQ5pBwE/Omf5Txoe71T4jvMeN/sN8bG6HM/J4Z+DYMloEISK6p4VLlDiny8S8+9lpKY59mNjF6WBDZIPsx1/oBnaOR3GgxdKtnP3xC+I9NCXaz6XRPOexP4hNgixQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr8MT6lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D596C4CEE0;
	Thu, 30 Jan 2025 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738250383;
	bh=Jct2ZwK4+W+jYiJw7vjaqlgtQMxQcCCHCeg9Kd1oe90=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Yr8MT6lhEFn5wZgYxwyX7a2tw8KMYAtw+WQhL5bHQLhiotT2U92FFw+0nywmLMU/5
	 epAUL8nx+Qac6L6k7hHSA9p5JE7Aw8Q08RljHkgtass58kIWZNiUg4T8eMyivQckvQ
	 ljAx8fCAL+ylsiWWjSPhBs80vhMicsh8DjAZH8kDjWGPfsWOA9k+5d8haaODgYH53P
	 gXgZPL+Chg99mMw5a+3//vE3PpdOgxPKcgHXExL+ipg5OoM412SIf+wUXD+XdoJDSa
	 uA3fONhoFhwZenSDxEVqUHlZ7DeS6FMCPEwHWJ6kEmRj7IBfnJvTqoTa5l/74bwADU
	 13nMRYdGb1/cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE326380AA66;
	Thu, 30 Jan 2025 15:20:10 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 15:20:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, trondmy@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 aglo@umich.edu, linux-nfs@vger.kernel.org
Message-ID: <20250130-b219737c5-407a49d87e0d@bugzilla.kernel.org>
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
> 
> The first issue has not yet been addressed upstream.

The first issue isn't a big deal, though. Applying 1b3e26a5ccbf should address this bug.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c5
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


