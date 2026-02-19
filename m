Return-Path: <linux-nfs+bounces-19057-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMRiIXmjl2mf3wIAu9opvQ
	(envelope-from <linux-nfs+bounces-19057-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 00:57:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F3163BC9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 00:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EC2530137AC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208182BD01B;
	Thu, 19 Feb 2026 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Y/P/oh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E3274B37
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545450; cv=none; b=ddCyCTurGsyuWHff1puXNk1ZVYD7Qe5j6sk2VnrDKH1bVGtfFqPk72CAmKvaERinlO2342Tx+WQPRy7JodVwU5ElLYp82pbr4y90JbXsmPIrbD4MLy7SF/UNcFYSTrmotlwD3GG78KG+4kmdGM1vWBZFiNG4lyHhmPZ/lvxhuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545450; c=relaxed/simple;
	bh=TLwkLwyTVxIMt4gAW+uGQOI19DPnhVbMngx1XsO+PpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYCr7YCK4FTCfzfrjeITpLIfTVbO4Q58dKjDl0Caq3swx5S1pMJfFaKNrBhsbfUMyBraUekWr4q8WKZQLzwFZ0/WPGr03Y6quN/HwM5KxIoLl1ptvbSTv+fHsaBNPkwj6F/9HLOLU99savgvBswBTSXWvj7nXB78AAiIjGBbFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Y/P/oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A54AC4CEF7;
	Thu, 19 Feb 2026 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545449;
	bh=TLwkLwyTVxIMt4gAW+uGQOI19DPnhVbMngx1XsO+PpU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b0Y/P/ohIxMq52wb3Osq2CrPq1cLvf5JkBT1ON6n+ZjQlnWs8kEagjz+2gFdbMOJd
	 LV4VcbpB5tIPdvtmmtZnbb1pFv4bvQxBjD4umrGYvRfPEmILYRgbJsB1oUDG7AFQhg
	 +0yf/IeN6IDZvI79a572cwvG9aCg91VqsxsmP3qDCXfAy+ZOAMuYWJXyU/UDVHlf6h
	 IqJ2CQIF4ddpfQKI+6cQbZuCA2jFdxH3i9Sc4PZz2UAHrtdUUy46HXyqDouYtM5Rib
	 rDpWJBcRXCU0x08irGoTfXFNggQXnsP6MpOT8Pn3QrRxaAl/fbSVM01I9JdIyXynud
	 NwbDyTiYhlNNg==
Message-ID: <4d1a2b195f0d2ece9d0db5524e69462d71d3b626.camel@kernel.org>
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
  Jeff Layton <jlayton@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 19 Feb 2026 18:57:28 -0500
In-Reply-To: <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
References: <20260219221352.40554-1-snitzer@kernel.org>
	 <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19057-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE2F3163BC9
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 17:21 -0500, Chuck Lever wrote:
>=20
> 2. Do you have a plan for similar passthru support for the NFSv4.2
> POSIX
> draft ACL extension?
>=20

Why would we need that?

The current need for a passthrough mechanism is being driven by the
fact that knfsd unconditionally imposes it's own lossy mapping onto the
NFSv4 ACLs.

I'm assuming that for POSIX ACLs, knfsd will just pass them through
unmolested to the VFS layer. Subsequently, they will get passed to the
NFS client via the POSIX ACL interface, which pass them on to any
server that does support that kind of ACL, and fail if not.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

