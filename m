Return-Path: <linux-nfs+bounces-18754-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOX6KxGnhGnV4AMAu9opvQ
	(envelope-from <linux-nfs+bounces-18754-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 15:20:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47473F3E00
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2262B300616E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43E3EFD3B;
	Thu,  5 Feb 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ0QOupL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C663EFD28;
	Thu,  5 Feb 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301198; cv=none; b=MlehlZ1RerhpnWjbO0ZbaTiBotX8brpbgRwR/X3qn4RZRJ2iMJJUERxGZVV4cqvgyyXm2iMKVz9z4UcSDZBobEn6DCxNeat3LOp1e3dn4c2IaEqnknDtTtkQVbN0LW+hKBKKRPdXxb2zrjrbYwzds4uni8a+aSDEiHcMhb8hbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301198; c=relaxed/simple;
	bh=wxz0xiJpsKFC77EfDP9XcC1ROIL9BC7+HETWtxtvbP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxbpDc8voS+8GXm5XbC/M6pUoIL3Lgjx6z0iUwlw/HGNRC0Uhyk/K3aBMx4MdxfCPXmijd9HXLU2QvX9z0vSkzlCOlvvRLDsUEHuS9GRP8Y6/+i/nsbpNaaHEKTaHLsI7hWBrZAPi/NQXSN/ktWIjM21vovUfSN7BW8kvj6+LV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ0QOupL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AD9C116D0;
	Thu,  5 Feb 2026 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770301198;
	bh=wxz0xiJpsKFC77EfDP9XcC1ROIL9BC7+HETWtxtvbP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJ0QOupL1dj2b1OwhrsvJLPhJfAGcrPCz1b7N6aaJjBlfxWfS0gxaWGJk75+ib3LV
	 xOTPBbLYL0jMnpn4+S9kubG1hfOBibReU32nSG9MdXMv0ASiHK13NpGFSN18M8bVMT
	 2jqv8EeDfBCgdv6OuGHDuLzsk/IJVmlgB6HCVuo9QvkBZ7LoaWUgdHIV6sEC/lmUuL
	 MrnKFVQsN+aiLrnQN0krzljW8Gt1yL2mOl0zDKQ7GoTTf/GvF93zvFFyoBbfwBwrpL
	 L7IjmBUuY/TWNhOaU3qvDlV3A0I+9CEbSwttcLSwjR4StcVKZ0fSujHzRYgvgou8wY
	 vxya3dl4Yt4tA==
Message-ID: <54cff24b-f010-4824-9b56-34beabf63401@kernel.org>
Date: Thu, 5 Feb 2026 09:19:56 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: report the requested maximum number of threads
 instead of number running
To: Jeff Layton <jlayton@kernel.org>, Mike Owen <mjnowen@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
 <2abf7a33-789f-405d-8993-8fbf30153aaa@app.fastmail.com>
 <bb9c7c2c53d5a4196ceb0ec81dcee747dd7df5e9.camel@kernel.org>
 <6944906a-9256-4f10-88fa-822a639eb5eb@gmail.com>
 <d0484cf69968e0415e4c0b9fca9217ebeca928e7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <d0484cf69968e0415e4c0b9fca9217ebeca928e7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18754-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,oracle.com,brown.name,redhat.com,talpey.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47473F3E00
X-Rspamd-Action: no action

On 2/5/26 6:18 AM, Jeff Layton wrote:
> You won't be able to get to the min-threads setting from /proc. That's
> only available via netlink. If you enable dynamic threading (via
> netlink), then the traditional "th" count in /proc currently shows you
> the number of running threads. If this patch is applied, it'll show you
> the requested maximum instead.
> 
> So, with this patch applied you can query both the min and max number
> of threads via netlink. We don't yet have an interface to query the
> number of threads currently running. In principle, you can get that
> info from "ps", but we could add that to the netlink interface if
> someone can make a good use-case for it.

I use `pgrep -c nfsd`


-- 
Chuck Lever

