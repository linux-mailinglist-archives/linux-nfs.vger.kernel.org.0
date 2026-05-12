Return-Path: <linux-nfs+bounces-21494-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOnqJHrUAmpFyAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21494-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:19:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68E51BAED
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA343032653
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001E402B9C;
	Tue, 12 May 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv2j7SCC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4A379C54;
	Tue, 12 May 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569908; cv=none; b=Y6L6EMenhJ9j6t1NwTZAV7rzH2SloB5RuqzFSS5F4huiAYs1SbNcZ6hL6cNBDsHkgXMBIlC3tCx3+XARvaXG9G6hMpFv1FJ3XjgvAl7bs6e0uvfl7maNFYdNYZp6CzgfFajw4kJnwcWTWqWsXoSqN6aWyVCsMZ6GVm8t+G5cEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569908; c=relaxed/simple;
	bh=oTkeOjEXbl4bVt9/z0YucKpdktlh9eD+Ruo6SFZVlhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBN395YteCwA71QDMpdpC9DQBKAGyhQnQhPAC1WbXFSKsVRebmnjLw5vmIigY+TbxOi2BGPKijHDQyV3jvbMvmRmDpQ67nMLP6qRF557qzIHRppNkSv1i61BzX1T7XsQXUseOk9EXjX+EWG3gI7vs6RZ2UkydRCMsCXuePZP3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv2j7SCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43CAC2BCB0;
	Tue, 12 May 2026 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778569908;
	bh=oTkeOjEXbl4bVt9/z0YucKpdktlh9eD+Ruo6SFZVlhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uv2j7SCChIAEuE5qdpNPXKPK9XFm+A2Y9VuBIpNTsBxttCqQYaWMN0rsAiGBhYiXY
	 W3pwmePaa1PphsLrHjKeA35fljhz50Cf+sh/UmqmjHZbmcoHeYD5Gbne7/WO2GBTd2
	 X3X72l8mRd2d8MWemJYGD0xJlOv+/50gI2qzcROm9S82EYaVSziWoJ79GWnVZPb9VI
	 y0PW2ETNW/5xkD7S679nuHkbfvAum5YdPX9FXUZGmYNyxPPQIPE/finUoal0Jy+h1y
	 jtRPiHUDeIUQTue4219h+SzjEvAPoXvq5kSlP14yDV+lekrne4Xtwqu/qxgUIAGQNG
	 tHvpg7vzQMTgA==
Message-ID: <b00249ba-928a-4f56-aed3-89354c0abf52@kernel.org>
Date: Tue, 12 May 2026 16:11:42 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] swap: move boilerplate code into the core swap code
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE68E51BAED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21494-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 14:35, Christoph Hellwig wrote:
> Make the core swap code calculate sis->pages, nr_extents and the span,
> re-set sis->max based on it and don't require passing the current offset
> into the swap file to swap_add_extent as all that can trivially be
> calculated internally.  Also truncate the spans based on the available
> information.
> 
> All this removes a lot of boilerplate code in the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For the zonefs bits,

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

