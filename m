Return-Path: <linux-nfs+bounces-21495-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMDhNOfTAmrPxwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21495-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:16:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE351BA22
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11F853002B68
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E15379C2A;
	Tue, 12 May 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw4jpXeE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FC368D5C;
	Tue, 12 May 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570199; cv=none; b=mDh9H/Z6wS4Gwsn9XZEwR04t9EgGRXFrKiLQ5ftFTpIHzHrJud2D7Iq/44PxqFD9QG8eG5Tw0HJq54O0k/u4cr8dYHlM3R/zsJtiMqZqkZCpMTSSyTJ2pEFM6ynCafDhowcPjChB63N/sqJqPc50e0Jgr+juafa95ePrNd/pM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570199; c=relaxed/simple;
	bh=nKvg9k4i7+/FdWNoLP39fTA2AIBDoli2gh2Xo3a+f/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4VC67BR7w3ST6ZEssqYWFjMdbYkqgUTM8SgK7oBbLocMYXildzYJF35C7OBQOWPXset+PjG77y0MyyOlHs/h8H2vNRwpjVitr8Ny95MmrAScgyKPLJmBrynzCZyKerAh9Y2luRxiXFHP+renhLiWk+yoY8jWaceieUrOHmyzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw4jpXeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E618C2BCB0;
	Tue, 12 May 2026 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778570198;
	bh=nKvg9k4i7+/FdWNoLP39fTA2AIBDoli2gh2Xo3a+f/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iw4jpXeE4iOTdRjtloaKtPRiHhRVD9YnDTRygvwHuj80w5Lt/GGuuos8S4Oa2+A4Z
	 ID/zwJQlick5hyU4VnwvCe6wnMLR7YE22/84JKPCiUWJE12TXkUBwoW0Xx2o2Y8Kbc
	 Ap/ZZWL6+KNR2fCfNMakCOH0HKbNFRfpp1IrwQXWNsRyjaMjSJeMwYfsVxKH432Az1
	 +dfRTVKY4Sm+FYuGhaV5UL3jeIxzP+M4dP/TEGsLXxEyYvgq3HndEAdgOqi/TC+AS7
	 TEKARoNX1z73Pn9qVgIaMUuNjbH5til+b8JTgFa+cH3UZwf+2RvwC+OmA8Cl38G9Nu
	 8hXejv+EqUw2Q==
Message-ID: <f34a9a4e-3d0a-405b-a3be-6400642bde44@kernel.org>
Date: Tue, 12 May 2026 16:16:32 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] swap,fs: move swapfile operations to struct
 file_operations
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
 <20260512053625.2950900-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CDDE351BA22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21495-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

On 5/12/26 14:35, Christoph Hellwig wrote:
> The swap operations have nothing to do with the address_space, which is
> used for pagecache operations.  Move them to struct file_operations
> instead.  This will allow moving the block device special cases into
> block/fops.c subsequently.
> 
> Pass struct file first to ->swap_activate as file operations typically
> get the file or iocb as first argument and use swap_activate instead of
> swapfile_activate in all names to be consistent.
> 
> Note that while the trivial iomap wrappers are moved to a new file when
> applicable to keep them local to the file operation instances, complex
> implementation are kept in their existing place.  It might be worth to
> move them in follow-on patches if the maintainers desire so.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

