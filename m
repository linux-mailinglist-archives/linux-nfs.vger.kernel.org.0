Return-Path: <linux-nfs+bounces-20388-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNSEEmb+w2lXvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20388-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:25:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7D327E22
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DEE4344754A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3D3F8DE1;
	Wed, 25 Mar 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4ytdH04"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46D3F99E1;
	Wed, 25 Mar 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451377; cv=none; b=A/u6Dod8WGKjAEbs1tA8O7K2if6bfTlZLSxiTelp8r0PgnfkH477BTk4skCh4ujpuK5PBBW+SenL4NevQH5Y5+hgj8TrkmLMYji2FjltrdotED7ezoh0c3C4RcTeCdyt2/T/ce3a17DnzxvVQG4aQlpA/v6tw8H3YOa/ukHqwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451377; c=relaxed/simple;
	bh=pqb3PJuzB5DFy/kjGWTEYPqLMTtoozJqM6OF7+HH9Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmEQ+I0VxPutw9ctB0A6278HlvoCze803BpQRbLBajMlQwZ89UH9G1CYyGEl8xpBgdpUJ4x40DJv/ccfltAmhbyiCOg0b6tk/jjyh3ic/pXQAzejrJegv15vkOnDyARpNxmuAXoUQ59gKveiqa0gyhOUDA8qJPJebIPVlPsZJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4ytdH04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E9C4CEF7;
	Wed, 25 Mar 2026 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774451377;
	bh=pqb3PJuzB5DFy/kjGWTEYPqLMTtoozJqM6OF7+HH9Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4ytdH04FDid4KQ2aOODe/Mf5Uqo6wmRml9zGX4TibIkjXjcECV7jqZP7+i/+ujxW
	 /ToFD9rIr2iHggpRRL0kodDfOTFJbx/Oh8ttL2pEAt0S5tYLd70sJOKMYL69ySwm0J
	 iRfBk9jVnFryf3mLpFghUqfA7015Iml5fqY/DV28I6dbEJ9TNkxiaF38Ll+fxUSiVC
	 HCT5x77EaUBcHXyA/inb3B9AaylJ7PTy1r7om/7SOoiK8lU9EeDyk97nFSaX5QW+JB
	 ax8mbWjmC18pzVC3YvRPbxjQqsy2KM3P4N65lIcKs5+M58C21gmeZdz60oRMA5pw3r
	 NpgyU3CevbWJg==
Date: Wed, 25 Mar 2026 08:09:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yongcheng Yang <yoyang@redhat.com>, fstests@vger.kernel.org,
	smayhew@redhat.com, zlang@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] generic/551: prevent OOM on NFS on systems with no swap
 memory
Message-ID: <20260325150936.GE6212@frogsfrogsfrogs>
References: <20260325035854.2262636-1-yoyang@redhat.com>
 <acN4BV5QmtP2W_WK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN4BV5QmtP2W_WK@infradead.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20388-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F7D327E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:52:05PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 25, 2026 at 11:58:22AM +0800, Yongcheng Yang wrote:
> > From: Scott Mayhew <smayhew@redhat.com>
> > 
> > We have frequently observed the oom-killer killing aio-dio-write-verify
> > when generic/551 is run on NFS filesystems on virtual machines in AWS.
> > 
> > Virtual machines in AWS typically don't have a swap partition, so check
> > for that condition when testing NFS and only use 90% of available memory
> > when generating the list of write operations passed to
> > aio-dio-write-verify.
> 
> I don't think this is a good idea.  The proper fix is reduce whatever
> crazy large memory allocations this workloads causes in NFS.  I suspect
> it might be page lists or similar, and just breaking them into somewhat
> smaller chunks and/or using potentially failing allocations to
> dynamically adjust would help.

I run fstests on XFS every night on a fleets of VMs with no swap and
never hit OOM.

Or at least I didn't until IT mandated CrowdStrike last week and now
it's anyone's guess if the test results are valid. <grumble>

--D

