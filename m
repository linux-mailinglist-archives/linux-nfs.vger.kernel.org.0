Return-Path: <linux-nfs+bounces-9798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE9A230EE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02741885C99
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52821E8835;
	Thu, 30 Jan 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pboLX469"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF91E284C
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250383; cv=none; b=aAzVf9/xMsRct1NE2EhCIQPHYx5+a6EYh6USnfQ9SCv5tZPd31kNNG3gZSLuf29ihVOwq+Qqgfb34M0CMR8xsej/FW6OU5WcI08k2IOzdr2BeYqDG8VgOxKUvNcr28n8Cs3yVCXjV0zjB/6ncOssrD3Oyv4Qgzwdt/q93khkj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250383; c=relaxed/simple;
	bh=gulsZ+sM9y8zTOY/RY/Y/sVFSi/zEuveZ8jCb8vKRbI=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=HtrG2vyew87DOa1RbGdWdUaxo4ifFNQVh25BhYrnx0uXKNJJ3Yc0kmC9Q+qiCeDMumZzbArdJPdKb0Y3vsGclmwt3wnBYW6FE2NRodkM/fCM1SP6mvkynqVOUbiUFZoVY8XcTsxnLWDq2aPaMTRdPjxhXnGvCreXaD2FQ3QPFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pboLX469; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FCFC4CED2;
	Thu, 30 Jan 2025 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738250382;
	bh=gulsZ+sM9y8zTOY/RY/Y/sVFSi/zEuveZ8jCb8vKRbI=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=pboLX469yYN50bqC9qNTB1OAnufUGLoHLphkFBtenZ9gmLVwQbkZgrHktX6tNynLb
	 0EjkoLcIBXxFnPyuvDzACA2qOBBFKDm//EIxzfjvydDBtWjKwMwE6Cpfdl4qs9X7eM
	 HFrknIL2H7xujjlewHdVTEdSLeJYwo/k9x2ecevpLSJJSNPBlhVT1RV3lqkwFtR534
	 +Ah5P1HVihrx9FB8UR9sLtzBHtJvDyijNHVhgq+y12E5+/hw+zO1qdaSGXvVE8NIIi
	 2X2OEb1pA5Sxk4bFrlF4O8rlBUdHcdbWG8WIWsVIgwGOPR7fG6s2l5rRAA/B8uV98K
	 nJvqXMfq16flA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C2E8380AA66;
	Thu, 30 Jan 2025 15:20:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 15:20:08 +0000
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
Message-ID: <20250130-b219737c4-ed5364ddf3cd@bugzilla.kernel.org>
In-Reply-To: <CAN-5tyFeGvihaucNL1rPPhbkxM04gMfOvDz04V0+-05mLbCS4w@mail.gmail.com>
References: <CAN-5tyFeGvihaucNL1rPPhbkxM04gMfOvDz04V0+-05mLbCS4w@mail.gmail.com>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #3)
> Olga Kornievskaia <aglo@umich.edu> replies to comment #1:
> 
> > First issue is the explicit use of NFS4ERR_BAD_XDR in the CB_GETATTR reply
> > decoder. Should be EIO instead.
> >
> > Second issue is the CB_GETATTR reply decoder does not seem capable of
> > handling a non-zero status code in the reply.
> >
> > Third issue is whether NFS4ERR_BADHANDLE means the server requested a
> > CB_GETATTR for the wrong file, or if it is an expected situation.
> 
> Isn't this because 6.12.x is still missing the patch "NFSD: fix
> decoding in nfs4_xdr_dec_cb_getattr" that just went into 6.14?

Yes, second and third issues are addressed by 1b3e26a5ccbf ("NFSD: fix decoding in nfs4_xdr_dec_cb_getattr").

The first issue has not yet been addressed upstream.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


