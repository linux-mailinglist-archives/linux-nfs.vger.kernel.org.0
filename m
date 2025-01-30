Return-Path: <linux-nfs+bounces-9781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52072A22EA9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C1E3A1D0E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D11DFDA5;
	Thu, 30 Jan 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdSNEao/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8911BBBEB
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245881; cv=none; b=aenalzBAAlK2Kg5YgWPGJ9YtmRHqtzUgoMlU7ZGLsfBVNA+PSvembq9Nf1uiov8WEJGHhxeaToxQzh0mFiwWzeKe+RkJbJxjHZyj+mfqYwYl2uKXKB2q8cAbPLXwJ7T+3JbHVUAeQf5+1X8DvkOaJFrO2XqaC7/wiL9nDwRQ1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245881; c=relaxed/simple;
	bh=dT+RVMrOifbQ6jx0eSHX4lPLsJGFSy1LLjavW7lk7hg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ZTxaD3NYYIQwnCFYp6OkQ7cVwtDz57TPVGd9MkW+frqYvbXPcT+xPMEASKczUp3YR8yf+/Pc/iXPv7WJ1uFA/IG8sbWV8ddt3nb9jNas5C+NiVb+LppoYROnp6+x8wyJr7JrOkbyjjTtnnHf8P0nwxc36jOn1N6hmd0U3PK3fJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdSNEao/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC08C4CED2;
	Thu, 30 Jan 2025 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738245881;
	bh=dT+RVMrOifbQ6jx0eSHX4lPLsJGFSy1LLjavW7lk7hg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=PdSNEao/FTXym3kWrVc6MqW3jytQEPgdipqsiOAycQKB8hOUXnmz2U0v1sGrkUdTR
	 0UrjJotq8CcZBWFOdZViSGb0NE8BM5cVwy+qvelME0VVHxjH+Ewo42MJBRhB774GNs
	 8IyoMDSEWp2L3vwZwXbQXiNSGcuHWhbnTv82wQbOLFgEPOunLEDMkWrJJBjqEPtMKo
	 +/nvdL9oaUktBJys0Tfjlqqurd5S0Aj1CY+R0wAm2/wVsWJ/msWVglj/TBNrHIPztW
	 lVz2r17h9lb7Gj8FZp94SqQ4Jx1gfsAuxYtJpMe2oCNCS/8xLsINogmcMvIYbmkM9Z
	 1qP8PhbHdS7hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76D0D380AA66;
	Thu, 30 Jan 2025 14:05:08 +0000 (UTC)
From: "rik.theys via Bugspray Bot" <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 14:05:31 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, anna@kernel.org, cel@kernel.org, 
 chuck.lever@oracle.com, baptiste.pellegrin@ac-grenoble.fr, 
 benoit.gschwind@minesparis.psl.eu, tom@talpey.com, carnil@debian.org, 
 trondmy@kernel.org, harald.dunkel@aixigo.com, herzog@phys.ethz.ch, 
 linux-nfs@vger.kernel.org
Message-ID: <20250130-b219710c27-30431c460912@bugzilla.kernel.org>
In-Reply-To: <20250129-b219710c25-59fffd877fe9@bugzilla.kernel.org>
References: <20250129-b219710c25-59fffd877fe9@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

rik.theys writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #25)
> > [Wed Jan 29 10:11:17 2025] cb_status=-521 tk_status=-10036
> 
> -521 = -EBADHANDLE (NFS4ERR_BADHANDLE)
> 
> -10036 = -NFS4ERR_BAD_XDR
> 
> I see several similar events in the trace.dat report. My guess is the client
> is generating BADHANDLE (nfs4_callback_getattr) but the server is having
> some trouble decoding that result.
> 
> My first impression is that XDR result decoders are supposed to return -EIO
> in this case. NFS4ERR_BAD_XDR is supposed to mean the /remote side/ was not
> able to decode a Call, not the local side couldn't decode the Reply.
> 
> RFC 8881 Section 20.1.3 states:
> 
> "If the filehandle specified is not one for which the client holds an
> OPEN_DELEGATE_WRITE delegation, an NFS4ERR_BADHANDLE error is returned."
> 
> This appears to be a bug in the new CB_GETATTR implementation. It might or
> might not cause the callback workqueue to stall, but it should probably be
> filed as a separate bug.

I've opened Bug #219737 for this.

Regards,
Rik

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c27
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


