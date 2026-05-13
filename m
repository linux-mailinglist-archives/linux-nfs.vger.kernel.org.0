Return-Path: <linux-nfs+bounces-21595-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNGyHKcvBGo/FAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21595-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 10:00:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614252F3DC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03D8C300D9F5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9563D79FE;
	Wed, 13 May 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7A9hVUV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1D3B5846;
	Wed, 13 May 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659123; cv=none; b=SF7zWZBBQ8XurtRcQXFjKBDwjuvDzR2iYbTQ3QR49IHV98mAsrg0+Vb9U84INYGDab3qbx/rxerhitrf0xdBbDhruRlOZPMD/JA4w837l6THuyq/gZ72h+QC9+AwMEKPw64qW+Lpztmwick/E2NLAoEKZ0Cr/udz/07Hqx3/GXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659123; c=relaxed/simple;
	bh=ZFOLhdTLTDwHAC91xE1k1QxOntVrUq2R8VzrDX/0eKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFr9vpY9Fqivbs5YD08tN2kmho/ssY0tTK0PfW0+1GFiHEjhHDpJ/yewnGtjZO46IYogWidNToYxYfjqdTfTQX9SaR30ko6P+hf38BQsD/zGxQrrvN4htZxd2pGBve/N/ityqvO0tz0OnWhQn0PDJqevz7v3pgAORa0xCGvblKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7A9hVUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF3C2BCB7;
	Wed, 13 May 2026 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778659123;
	bh=ZFOLhdTLTDwHAC91xE1k1QxOntVrUq2R8VzrDX/0eKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N7A9hVUV0qRwGIlPSwv6zb8J15Avw/8OiY0tC2pYfT3vAImBYoTK+1lI8++KSnfTQ
	 enquvQ1kQFG5q2SLMBOMl5LIdaa3HrPz8yfV/mB+IPtRZ9EwSTq915aLv9gnYaUSZ0
	 2czee33FVo8GdHO98/Unlcwyp8wZLK0wN4oPZakxBFnLVZVt/BEiOmCdWJRI4N+cY+
	 3MR1Iv22FF+LhxmqxonfMaEmbjDzyvgI6p8HLq6tmndsgXMGnxPjs/zzCmTTAuJh8z
	 ofabM7G9g1LGbCLvCfh554V2u3vKBFrubmNJsMCnPLUeVj1Xtx7dZ5jJC2Yhh6Ns+W
	 0VbT0WJxHsqZQ==
Message-ID: <b37ca8a7-289e-45a0-8cbd-eb14d7453b97@kernel.org>
Date: Wed, 13 May 2026 16:58:37 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Christian Brauner <brauner@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
 <20260512170846.GJ9555@frogsfrogsfrogs> <20260513055806.GC1236@lst.de>
 <acd6428b-a352-4f7b-a349-b2c9e341fd87@kernel.org>
 <20260513074608.GA3693@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260513074608.GA3693@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0614252F3DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21595-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 16:46, Christoph Hellwig wrote:
> On Wed, May 13, 2026 at 04:44:53PM +0900, Damien Le Moal wrote:
>> Hmmm... With zonefs, swap files can be created on top of conventional zone
>> files. So enforcing "no swap on zoned device" here would break that.
> 
> We can check that none of the extents fall onto sequential zones instead
> of just devices.
> 
> I still wonder why you bother with swap to zonefs at all, though.

Yeah. I do not think anyone actually use that... But since it is there from the
start, kind of stuck with it now.


-- 
Damien Le Moal
Western Digital Research

