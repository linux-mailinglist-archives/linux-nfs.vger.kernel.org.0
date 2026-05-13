Return-Path: <linux-nfs+bounces-21593-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJy5BC0sBGoDFAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21593-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 09:45:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725A52EE52
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8EE0305777F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8F3D6CC6;
	Wed, 13 May 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W88QhGV5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683353D45ED;
	Wed, 13 May 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658300; cv=none; b=ARgSZwA60aJ7u7PYwYqgcoWRLN3SIrjl48wKTi99iQEPiLtlCn2gDdzbvbq21+m4+i4ereiEbzqD2LNLQtX4lXX2YVtaVd0qXEm5mmFidEsjPRh0VN/C6hBnOEw5h8GjQDFVpSY379uEm0cgazbbqsHZ9N2c4z1vUndEL1BK1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658300; c=relaxed/simple;
	bh=Dg2nW1p160NOCn5umFdjytzvydm/ZD4Y8VIlSf+k0CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtNbTVwYaPydxxyfaIk4XIcA0fEKB1KM6EiLVoANWvnwJtZL3Ln9KyBWyMH8q4cf5zyDzPI3ADh1o4g0gzb0knIgnuxum3U1QNjFL1GIt3qc4QGgZZNaOFmn7b2aRsUYcOdQGRfex/nYg9sAiM4aTuOf5G/dpB/Bp3T34QSqpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W88QhGV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B4FC2BCB7;
	Wed, 13 May 2026 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778658300;
	bh=Dg2nW1p160NOCn5umFdjytzvydm/ZD4Y8VIlSf+k0CM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W88QhGV5fNBgG29b6A8+2aMpfRcsRHQN/DvQSObUW7md2OERCUFlHgf1cKsHqoq2S
	 8ykZnWkud0SccegE0umMkD4j5jJ7KgzhBrzoBcb9I/I9zNm6SNrd0Urp9aI7aA2mFH
	 Ls43dph0TYLcQ7SHMgIKKiqIjYNGHdG0bRvkSKaUSVLbUqXi1S0+3eREdcpqS6vbou
	 pjHmEbKTKNOrbnUGt7tcluhtcMyTN3bE6oKaewls6oT44KMpU3eYtzejZxITRlsKNU
	 MrtDtAfOwb3/X7OZISUgYCyAwxQnZAGj2NCGbnTCksT5zjWWNFVhk+szDVycr1iBRH
	 EXReRb+kSdmJg==
Message-ID: <acd6428b-a352-4f7b-a349-b2c9e341fd87@kernel.org>
Date: Wed, 13 May 2026 16:44:53 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260513055806.GC1236@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5725A52EE52
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
	TAGGED_FROM(0.00)[bounces-21593-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 14:58, Christoph Hellwig wrote:
> On Tue, May 12, 2026 at 10:08:46AM -0700, Darrick J. Wong wrote:
>>> +	/* Only one bdev per swap file for now. */
>>> +	if (!sis->bdev)
>>> +		sis->bdev = bdev;
>>> +	else if (bdev != sis->bdev)
>>> +		return -EINVAL;
>>
>> Should this return error if the bdev is zoned?  AFAICT XFS and zonefs
>> already guard against this, but other fses might be more naïve.
> 
> Yes, now that the bdev is passed down to add_swap_extent we could
> consolidate the check here.

Hmmm... With zonefs, swap files can be created on top of conventional zone
files. So enforcing "no swap on zoned device" here would break that.


-- 
Damien Le Moal
Western Digital Research

