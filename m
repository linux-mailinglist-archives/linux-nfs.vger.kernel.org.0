Return-Path: <linux-nfs+bounces-21738-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEZOKm8RDmrw5wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21738-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 21:54:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05E598DDF
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E49319B0DD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654A356762;
	Wed, 20 May 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyArPpIu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84031F9BE;
	Wed, 20 May 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295738; cv=none; b=KU6lBsn3wm03ga3bsO3kxZ4zQ0qdLJoRJe5jT4TrtrxG8h24Z2ISPcShYDdQ+nPfI8KYsg6graJfvcOlQdjQbdTW6ntSN3DWLeH/GijKw0/qggt5lKp1AvBG0l/MjYk+niV1ES18GGalavdXmDEY9oWgjQbpudOEE4iM0toKWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295738; c=relaxed/simple;
	bh=/fgGRYoxg3Qgye4v6vNP6hIdMnpi6/nhdGW7rJtjaF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeHzl149bcsaMcLmMN17Kmh6lLTyP3COdsjozmF4JNkGsFYdqoYBnw7H4svbhfKxun8jqPmlASIFSkfyEAceuNKQ0oPHd2gxGNnUAMDcAQiCYHrPY4GJnIEQJNsxCmGDfYemKYfGAKBQVqSzDDYCF51oSKlK3kfBl/mxm24ckfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyArPpIu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C55D61F000E9;
	Wed, 20 May 2026 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779295736;
	bh=lMrxkkFvVguJGxvvxg0Yi6ys1DrdO0Sj8Repx7hlcas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XyArPpIupphNBc+Zbo4sd1n8smKCpsvCusnwx3BZee2Iu0SWkVWEHg8sBKtAeIOgs
	 5CpmD9ZHgvWWm60eZd7iZ/Rz8CI43gbQP0WeG77re1eVqwwfEtz39ep1kMDuOeSKq4
	 i0y4vouQKbQmHoPnLJcBUsiQri4bbIeUZyHxQLKKVvOIXSp54SLt3zCkLFFwa//10+
	 jbBcC4eTvDMTq2XnOdjSRT5J1j0Vy7REVDNPnVc/a3DiP56H2DvEU8SyXyHdLcmqpj
	 iB6m5N5VsqHAh5WE+I5KmNN+x1AvCE9jHxhOV71RGk+siUGwr977XoX6sG80YsVD+Y
	 wvR40GjqGv3rw==
Date: Wed, 20 May 2026 09:48:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <20260520164856.GI9555@frogsfrogsfrogs>
References: <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
 <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs>
 <ag1vwFHoYatausLK@infradead.org>
 <e55a29a9-ed18-4e3a-8378-f712bcbc940f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e55a29a9-ed18-4e3a-8378-f712bcbc940f@oracle.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21738-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B05E598DDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:09:29AM -0700, Dai Ngo wrote:
> 
> On 5/20/26 1:24 AM, Christoph Hellwig wrote:
> > [adding Sergey, who wrote the code to allow multiple mappings]
> > 
> > On Tue, May 19, 2026 at 07:59:49AM -0700, Darrick J. Wong wrote:
> > > 1) xfs_fs_map_blocks only takes i_rwsem and XFS_ILOCK; it doesn't take
> > > the mmap invalidation lock.  Does that mean that pagefaults could wander
> > > in and mess with the layout?
> > Looks like it.
> 
> I already described the scenario in which the file mapping can change
> between successive calls from nfsd—triggered by a single LAYOUTGET
> request—to xfs_fs_map_blocks().
> 
> I also don't see how page faults are relevant in the context of pNFS
> layouts. The server is not servicing actual data accesses through page
> faults when constructing a LAYOUTGET response

Some other process on the nfs server mmaps the file and generates
faults.

> > 
> > > 2) Now that NFS apparently can serve up multiple mappings at once,
> > > should ->map_blocks pass in an array element count so that we can do
> > > multiple iomaps in a single lock cycle?
> > I guess we need to do that, or revert the code to provide multiple maps
> > for now.
> 
> I think we should address the immediate problem first by replacing XFS_BMAPI_ENTIRE
> with 0, and handle support for returning multiple map entries from a single
> call to xfs_fs_map_blocks() in follow-up patches. That work is more involved,
> as it requires coordinated changes in both the nfsd and XFS code.

Agreed.

> > 
> > > 3) Do the reflink and realtime inode checks need to be re-assessed after
> > > grabbing the ilock since they can change?
> > Yes.
> 
> I can move the check for reflink and realtime inode inside the ilock in v2
> of this patch series.

Yeah, that probably needs to be made too. :)

--D

> -Dai
> 
> 

