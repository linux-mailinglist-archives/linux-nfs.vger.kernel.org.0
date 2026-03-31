Return-Path: <linux-nfs+bounces-20549-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAL3KmUHzGn+NQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20549-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:41:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42F36F25C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53AD2300ACB7
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D691345CC0;
	Tue, 31 Mar 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXSOb8IS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E8330659;
	Tue, 31 Mar 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978224; cv=none; b=sa3k9VyHn7fS3ULOihYT4NvoiB7mPx7/vj3TKt9pcBJgNdiObHG3OQdc00bm6kXJV8RBFy29+6KEzJUyH84i6kKl5UsC1f2SNyaHFLae9VohGfHHqJlDszsflLI4FrhpB4/iZZwTJE6khfMKLOjXK8XsbyO2akd5BOuKeWNfV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978224; c=relaxed/simple;
	bh=a1q6P7XBrOBSNkUEMg2y3VIa+0R0tL6WwnvA+zXpUrU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K/wSAnVyLTOb9yCuTuzBGhZP+gSJhu1oYXsUK5bP13vKmQb7OT74lS+6Tzq48NLNaYMUh81mJOaqeVzGjwJH7Np8A3w7dktPaU2Lzwq3VvZxp7NHgbgllqGnohcFmnX77hJvw9x+2CTz43rdNcnFsfuWoJUYI+/E0EpDc7D+Oew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXSOb8IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE8C19424;
	Tue, 31 Mar 2026 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978223;
	bh=a1q6P7XBrOBSNkUEMg2y3VIa+0R0tL6WwnvA+zXpUrU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IXSOb8ISreR4UsryZS852mgHvZNTykoCmH5E2Ada1BLmC9tGOH+gS6GTi282wt9t2
	 9ry2dFmpB+X2TVPXgi09U0I+qE2bB2LREjs8nl4m11ymz0yYqQxUH9Fm4YoTtZAIy+
	 vlvYJznWZ2yu/oF32q4AvigmFc5rzzGq+kqUmDiDUALC5a2BEoOrKgZHL9bMaeRupu
	 dRpbI0WaZ0PaTGF3puP0fjbrnDd9sErwJ/rij51OlsN81zrrQMkslFnNT5Oc4wdSjg
	 yLo1OcFp17ChnUaS3Ql3H/yLdXlb7yFghuDGKNmWsz5bynrX/hzCIhTKChxFftxK0l
	 nbkwK7MPF2fYA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 10412F40068;
	Tue, 31 Mar 2026 13:30:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 13:30:22 -0400
X-ME-Sender: <xms:rQTMae_gPaB7bJw4qlczNBOhygas5OkkN2OWT12l05LZph_I4LXCTQ>
    <xme:rQTMaZhTUkxTjZnsgUvG_UVzSNj9iI_fsdn6DjPfLlJXhn1iXvRSPdqXrn8AS-DFh
    5-8ZNK3A2O9bNEg3oNVCFJqjMcRGI8DSwGwuw0NiKWKSxKPyjV4NJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegurghirdhnghhosehorh
    grtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rQTMaWKuEuwAdcWPb9kDaXF-rLzMHE_TyzMtR-uqhhCAoSB7srgCXQ>
    <xmx:rgTMaULD-uM3shuunIlvW7imULfCm5PDr_W0SKPFMP6ssaKQIUTMlQ>
    <xmx:rgTMaRjYyi0BBFUgHy_rOen134BSxok2U0oOMk7RhIEusJ89SThRDQ>
    <xmx:rgTMaeOiFYbKyt6jQpSmutc1e72Umy62rh2Jg0U2tEDrzcoZOii1vw>
    <xmx:rgTMacoOTRQa2zX4ZJnuqtDOqCbh0tYgNSiyI5DX3lFpbpjXDPL_rgiN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFF36780070; Tue, 31 Mar 2026 13:30:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfarAuXGhKkB
Date: Tue, 31 Mar 2026 13:30:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <13cf0349-b627-4324-aa0d-9d51a3429caa@app.fastmail.com>
In-Reply-To: <bce25daeba83f6454b0bdf49c221e76a6843f9b6.camel@kernel.org>
References: <20260331153406.4049290-1-hch@lst.de>
 <20260331153406.4049290-4-hch@lst.de>
 <bce25daeba83f6454b0bdf49c221e76a6843f9b6.camel@kernel.org>
Subject: Re: [PATCH 3/4] exportfs: don't pass struct iattr to ->commit_blocks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20549-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[kernel.org,lst.de,oracle.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.891];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F42F36F25C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Mar 31, 2026, at 1:26 PM, Jeff Layton wrote:
> On Tue, 2026-03-31 at 17:33 +0200, Christoph Hellwig wrote:
>> The only thing ->commit_blocks really needs is the new size, with a magic
>> -1 placeholder 0 for "do not change the size" because it only ever
>> extends the size.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/nfsd/blocklayout.c          | 12 ++----------
>>  fs/xfs/xfs_pnfs.c              | 19 ++++++++++---------
>>  include/linux/exportfs_block.h |  3 +--
>>  3 files changed, 13 insertions(+), 21 deletions(-)
>> 
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 3cc3b47361e2..23c0e4d0ff34 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -179,7 +179,6 @@ static __be32
>>  nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>>  		struct iomap *iomaps, int nr_iomaps)
>>  {
>> -	struct iattr iattr = { .ia_valid = 0 };
>>  	int error;
>>  
>>  	/*
>> @@ -191,16 +190,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>>  	 * timestamp is a "may" condition, and clients that want to force a
>>  	 * specific timestamp should send a separate SETATTR in the compound.
>>  	 */
>> -	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
>> -	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = current_time(inode);
>> -
>> -	if (lcp->lc_size_chg) {
>> -		iattr.ia_valid |= ATTR_SIZE;
>> -		iattr.ia_size = lcp->lc_newsize;
>> -	}
>> -
>>  	error = inode->i_sb->s_export_op->block_ops->commit_blocks(inode,
>> -			iomaps, nr_iomaps, &iattr);
>> +			iomaps, nr_iomaps,
>> +			lcp->lc_size_chg ? lcp->lc_newsize : 0); 
>>  	kfree(iomaps);
>>  	return nfserrno(error);
>>  }
>> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
>> index a52978f6fb76..fee782a3edbe 100644
>> --- a/fs/xfs/xfs_pnfs.c
>> +++ b/fs/xfs/xfs_pnfs.c
>> @@ -257,23 +257,22 @@ xfs_fs_commit_blocks(
>>  	struct inode		*inode,
>>  	struct iomap		*maps,
>>  	int			nr_maps,
>> -	struct iattr		*iattr)
>> +	loff_t			new_size)
>>  {
>>  	struct xfs_inode	*ip = XFS_I(inode);
>>  	struct xfs_mount	*mp = ip->i_mount;
>>  	struct xfs_trans	*tp;
>> +	struct timespec64	now;
>>  	bool			update_isize = false;
>>  	int			error, i;
>>  	loff_t			size;
>>  
>> -	ASSERT(iattr->ia_valid & (ATTR_ATIME|ATTR_CTIME|ATTR_MTIME));
>> -
>>  	xfs_ilock(ip, XFS_IOLOCK_EXCL);
>>  
>>  	size = i_size_read(inode);
>> -	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size > size) {
>> +	if (new_size > size) {
>>  		update_isize = true;
>> -		size = iattr->ia_size;
>> +		size = new_size;
>>  	}
>>  
>>  	for (i = 0; i < nr_maps; i++) {
>> @@ -318,11 +317,13 @@ xfs_fs_commit_blocks(
>>  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>>  
>> -	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
>> -	setattr_copy(&nop_mnt_idmap, inode, iattr);
>> +	now = inode_set_ctime_current(inode);
>> +	inode_set_atime_to_ts(inode, now);
>> +	inode_set_mtime_to_ts(inode, now);
>> +
>>  	if (update_isize) {
>> -		i_size_write(inode, iattr->ia_size);
>> -		ip->i_disk_size = iattr->ia_size;
>> +		i_size_write(inode, new_size);
>> +		ip->i_disk_size = new_size;
>>  	}
>>  
>>  	xfs_trans_set_sync(tp);
>> diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
>> index 1f52fea8e4dc..d1dec4689b14 100644
>> --- a/include/linux/exportfs_block.h
>> +++ b/include/linux/exportfs_block.h
>> @@ -9,7 +9,6 @@
>>  
>>  #include <linux/types.h>
>>  
>> -struct iattr;
>>  struct inode;
>>  struct iomap;
>>  struct super_block;
>> @@ -33,7 +32,7 @@ struct exportfs_block_ops {
>>  	 * the client.
>>  	 */
>>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>> -			int nr_iomaps, struct iattr *iattr);
>> +			int nr_iomaps, loff_t new_size);
>>  };
>>  
>>  #endif /* LINUX_EXPORTFS_BLOCK_H */
>
> I like this one. I think you can just fold the first patch in this
> series into this one

Disagree: I think the change in the first patch needs its own
patch description and motivation.

> since you're making that change moot (and the
> ia_* times don't matter much anyway).
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

