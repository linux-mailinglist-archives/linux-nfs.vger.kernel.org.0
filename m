Return-Path: <linux-nfs+bounces-22095-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC27L72FGmrN5AgAu9opvQ
	(envelope-from <linux-nfs+bounces-22095-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 08:37:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3E60B749
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 08:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CADD7302164C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A543350285;
	Sat, 30 May 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdxXmZ8c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73A274B5C;
	Sat, 30 May 2026 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123064; cv=none; b=U4Xy3QFjsP/1dnxgvM/65pUN5FtKn+el+RY+072ltOwdZdzu1x8LFeKos75IwHovQRME4wOoCTzCVzOwRxBzlbrZwYFd7rcVTgq0wjPFTHRW3dEWl+zQy3TC6K8jbrLM1BG3MZ3mVmnDMKzkA8PAoYUZwT0bQ6+NNIrJvWZtHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123064; c=relaxed/simple;
	bh=gEiLYM2doJphVnKry/4lwBBYT6Td5kWBst9SCeRY4i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NKEkWftJNyVovuu7ejnMxrriOvQUtWnUpdB2gqKBrPZf4URKKcqk+yf5oUQVjZhrJ7jB2o/xchuiDzYKIMSyTay/aaPG4fQqQqcVzGxqDNYehWRGbpXtW2bL3+jQn1jbwDcbdDpS0qawqGaCyRiJkE7JKNnrsKGJ1qrFt2PRmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdxXmZ8c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B11F00893;
	Sat, 30 May 2026 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780123063;
	bh=Mzd8gJewC6ZnzoHSZe0g9lGsqiB7x1YwPjmy3uHsLJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NdxXmZ8cpAMtFoutTjErUjVgPVF1lhWu4Xr3G5az1fxws6LfqDq1Tcp9dpaKCciR+
	 uw5j4DDFS+vtxkufjRjRuYkH9XglS+aP1rpg/F3PizHvZXEUlfVDqrkhH428aViO0Z
	 lcQdew2FTS6VRW9ZHBkeJYP2xNtteoWfXjQa0/yFBF2RtK/q8kVhFzkVIfQEjWF7j0
	 +VQPpQbfjfcklLna3J9VwxuQsggqVCyrVHCrqQydtdSoySf5hcc7tG+L/rHpTFf5EJ
	 ZjrcIexopAM9847aV1DjXXJDUxhI3eD3Bhbp5rYy0gLZ+o/yDAq/ZK6HfyVwprmTBw
	 vcu+dxLYCrlfQ==
From: Carlos Maiolino <cem@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
In-Reply-To: <20260520003503.2399326-1-dai.ngo@oracle.com>
References: <20260520003503.2399326-1-dai.ngo@oracle.com>
Subject: Re: [PATCH 0/2] xfs: correct pNFS layout mappings
Message-Id: <178012306198.22275.7605201361489277249.b4-ty@b4>
Date: Sat, 30 May 2026 08:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22095-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BFF3E60B749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 17:32:57 -0700, Dai Ngo wrote:
> This patch series fixes pNFS layout mapping issues exposed by running
> xfstests generic/075 against an NFSv4.2 block layout export. The first
> change stops xfs_fs_map_blocks() from propagating an uninitialized
> mapping record after xfs_bmapi_read() fails.
> 
> The second change removes the XFS_BMAPI_ENTIRE flag so each request
> only returns the range the client asked for, eliminating overlapping
> in LAYOUTGET replies.
> 
> [...]

Applied to for-next, thanks!

[1/2] xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
      commit: 97bdbf2613eb89428b739ce09d1a6e1c8435a286
[2/2] xfs: fix overlapping extents returned for pNFS LAYOUTGET
      commit: 36ca6f11424a5b6d92b88df37c40bf2fe825d5a0

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


