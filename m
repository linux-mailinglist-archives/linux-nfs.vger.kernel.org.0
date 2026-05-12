Return-Path: <linux-nfs+bounces-21503-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBIPOXzZAmqbyAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21503-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:40:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D851C031
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E673073779
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA544418F0;
	Tue, 12 May 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLRtx/UM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F2384CF2;
	Tue, 12 May 2026 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571302; cv=none; b=m75oqb+kfuuPGHMNC1Q9pEGRWgzu4WbZQGkMXTO1IBDQuRtzHJezPo6CFTDhsVT5+nhPiyEH4sTLI+30Dux8iIZVR1ClIhiXDcFFvKgP6aYODEKNlk+Uf5fjsNe0mtgILdTmU7KELFK1KueDq5nUOZq/R6oL5X/CK4f7eUUHfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571302; c=relaxed/simple;
	bh=s/liCqvWpwzbf+Ors2mYM2xHnFEKG2Ez9stMzBy2CUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/cKh3sMlQSKF/qvqNqUKdxLr/7mWOiRF63CpMof0Xd33Qj7YQUnOo7sqH610173k/4UtumhXAEblcsaKd86lSjE05uGAi241GQFijECGN4ZhP7foVlR4IguquU+3mFkpvFb4le+RogxZ3jME88mNR2ZFSPUGwhjNL7PdIJaX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLRtx/UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46713C2BCB0;
	Tue, 12 May 2026 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778571301;
	bh=s/liCqvWpwzbf+Ors2mYM2xHnFEKG2Ez9stMzBy2CUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CLRtx/UM0efOdLrvjlbvsWzTtbQven4c5sLOwml2whwHzcCcqJMd7bCclOjdEZ20O
	 UXxIhdcs2qt054/GJeHr0t3YI+ofKCUnTiipODTRt7ADIbQc9JEeasCk+xcR9aOeew
	 Gi2vyLOb8+DJmCJSkdwtTx7cYb0d2rd57ymwPj9cTLhIyaPzAcrpNE2ILkt0jpqzId
	 HkOrmdLVr7An8cZeKIiB8TlR7lnPGvQeaV1/jiF25kcRdf1pFOXUoCx3u/XpqANN/f
	 VbTmMIKsMtE+C2cPfrNbk1D6HdbQj6D6wJTNfrXhs2YxKIj4hNpJ6iQIh+220eEt3H
	 1k5nf0s7jSIog==
Message-ID: <b2fab68d-541a-4f58-85a6-a304134cf127@kernel.org>
Date: Tue, 12 May 2026 16:34:55 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
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
 <20260512053625.2950900-10-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 777D851C031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21503-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

On 5/12/26 14:35, Christoph Hellwig wrote:
> Only the file operation method knows what block device we'll swap
> to.  So move down setting sis->bdev and the special blockdev flag
> into ->swap_activate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below. Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -141,7 +141,6 @@ int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
>  		continue;
>  	}
>  	return 0;
> -

whiteline change.

>  bad_bmap:
>  	pr_err("swapon: swapfile has holes\n");
>  	return -EINVAL;
-- 
Damien Le Moal
Western Digital Research

