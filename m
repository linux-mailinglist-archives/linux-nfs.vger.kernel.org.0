Return-Path: <linux-nfs+bounces-20620-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKY6D8zbzmmGqgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20620-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 23:12:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8594138E463
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6E33038173
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685439EF2C;
	Thu,  2 Apr 2026 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeV0+wbp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BB3845AA;
	Thu,  2 Apr 2026 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164146; cv=none; b=nxxLQoKLKSkPnVWK4msIL7p4PI6cGpSA8V8Wy4tMKvLKe+5nPGWX72UZa8B2Y1X5Jx3tvRTjQUEo7xl1elrl24gwkza1n0c9XtaMj7wvpMbhD3qvViRakL2618HoSlFDY9UqMbkNjjGzfR5oL3jSPZfGfT7XKSO8pJGk6z8l4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164146; c=relaxed/simple;
	bh=lwCy29waT3Q53bSxnN45ExMQq8i7y/2BLFZG2iNAgkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU8gZ3OXAufqe9kEkRrg2PjnmW2h3GofuFtrUetaD7b2KZp5tu8wvpQAkUO7IlfftnVibvs/cvmeQ08Emt8UVUqNYQvbViHh2JFU1RdTcLKK5lihbpJ0tBytXQf2JkPOTNOYqPx3jTQJCYm78QzVosks/pwYPjJKiqiEKewA4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeV0+wbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30316C116C6;
	Thu,  2 Apr 2026 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775164146;
	bh=lwCy29waT3Q53bSxnN45ExMQq8i7y/2BLFZG2iNAgkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeV0+wbpsHpERkEYiLeYkcJZBYe0gjD1IOivBwF/+VHcN3BDCB0DQaVSRDsyBxvu/
	 yMMrSA7VmWNB1cQoWTeiskkP9NUpeCItzgvv1xNlYwSviNeq3tNmbf2VvjdzARZ9o9
	 jq/yrihp9DTIZTt2UMUWuNd3h2O8JWx84M5jy1k+VL6QFBWLLLwAZzLYi2BdIpxTbi
	 5kDRXkbtnUBazHk87rH0nvdzEzMpRpOlzRnUtLSXptQW4Z09SR8jvkEjBJ7y3ECP60
	 iCQzQqRH9C6HFzJXx9dOb1wWmOE4o6RSrGjxF4Q1UJBuzkRMa1AbcTobP2pkLoqb7P
	 xWTYWqbiX/idg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: cleanup block-style layouts exports v2
Date: Thu,  2 Apr 2026 17:09:01 -0400
Message-ID: <177516411715.3059543.10370852558871615557.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401144059.160746-1-hch@lst.de>
References: <20260401144059.160746-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,lst.de];
	TAGGED_FROM(0.00)[bounces-20620-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8594138E463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 01 Apr 2026 16:40:21 +0200, Christoph Hellwig wrote:
> this series cleanups the exportfs support for block-style layouts that
> provide direct block device access.  This is preparation for supporting
> exportfs of more than a single device per file system.
> 
> Changes since v1:
>  - consity struct exportfs_block_ops
>  - fix spelling
> 
> [...]

Applied to nfsd-testing, thanks!

[1/4] nfsd/blocklayout: always ignore loca_time_modify
      commit: ff6bb92c2f41eac178f9886d15a62cb7f8acf111
[2/4] exportfs: split out the ops for layout-based block device access
      commit: 86cc64ab3045f7130c2d2d7c458646038282938a
[3/4] exportfs: don't pass struct iattr to ->commit_blocks
      commit: 949378be2cd289d749ef9a826ea6cf376bca973e
[4/4] exportfs,nfsd: rework checking for layout-based block device access support
      commit: e0259785dffcb12f6850450344ab0f99b6283d60

--
Chuck Lever


