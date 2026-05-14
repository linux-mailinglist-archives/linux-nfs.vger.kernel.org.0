Return-Path: <linux-nfs+bounces-21612-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO2uBOrfBWr4cwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21612-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 16:44:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8B543621
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19031305D9C5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B95413221;
	Thu, 14 May 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSzgITkm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70189425CDD;
	Thu, 14 May 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769463; cv=none; b=Kq22/IhIdrhgTmzJu/3O1ZPMOGhKDCZqhUQw9bO3YPwAz8vSiWYFl48yKOzGWwd1ISMn5CIUfIQ7Oe45x+34jmfmRzf6T5Az3RHla+KmE4pJfQas2kHnZNjX4v1LlEep9TvWRwZmvKgk7byM9K52dOE3Zy5jPQJIDKFJ8WjDArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769463; c=relaxed/simple;
	bh=rZgHzTbgnHHmJN6qZy+N8eVodksxfqXSK4VW1S+0K7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFkiBDDYbEp00R78eB9VgEmswgpkjN0qZMeB57XVM4El9vAXW8NMJYLkt813QCViQomfAnrdFLMTmguF4oIQN9NGy0afP+Jkbr0HTWv3eIiSsYNCnsR4aUEmggxtljGiUnvY6W3kf7HFwOhIgIjkZFkXO+DnY1TRNvXXTUmPmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSzgITkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451D6C2BCB3;
	Thu, 14 May 2026 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769463;
	bh=rZgHzTbgnHHmJN6qZy+N8eVodksxfqXSK4VW1S+0K7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSzgITkmGehUccFbXTWsPk0QgXndYmpZfV7daj62F/XhP97o2McXRouYZH6CLLFwV
	 gqggLlEnZ1PXfTjjROCChaOh3grRD106tHztsRAi1luciA9n5+Z6uR56rq/zS3XA3J
	 YnLMKpNKptZSqQ+7fG/Q9tObtVhW9ctnptKEFbI0pchM2CLBhnLGtH34yqCKRQvOGW
	 7tLS0IrpYKXpaGZv8TAHtOKGVHyfly3YPOjDQLKY9xULeUNIZ2PiNzkPf4rTYC4WT+
	 mEMhTAGHxkOSdsjXj9RG0qveXJ811sNv6MaeF7a5Pg1xBtEyPItjOhZC5D9DOj0U/p
	 Zv4alA42osiJw==
Date: Thu, 14 May 2026 07:37:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
Message-ID: <20260514143742.GB9531@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
 <20260512170846.GJ9555@frogsfrogsfrogs>
 <20260513055806.GC1236@lst.de>
 <acd6428b-a352-4f7b-a349-b2c9e341fd87@kernel.org>
 <20260513074608.GA3693@lst.de>
 <b37ca8a7-289e-45a0-8cbd-eb14d7453b97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37ca8a7-289e-45a0-8cbd-eb14d7453b97@kernel.org>
X-Rspamd-Queue-Id: 74A8B543621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21612-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lst.de,linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:58:37PM +0900, Damien Le Moal wrote:
> On 5/13/26 16:46, Christoph Hellwig wrote:
> > On Wed, May 13, 2026 at 04:44:53PM +0900, Damien Le Moal wrote:
> >> Hmmm... With zonefs, swap files can be created on top of conventional zone
> >> files. So enforcing "no swap on zoned device" here would break that.
> > 
> > We can check that none of the extents fall onto sequential zones instead
> > of just devices.
> > 
> > I still wonder why you bother with swap to zonefs at all, though.
> 
> Yeah. I do not think anyone actually use that... But since it is there from the
> start, kind of stuck with it now.

Ahh, right, I forgot that zoned devices can have conventional zones
where swap would actually work.  Question withdrawn.

--D

