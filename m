Return-Path: <linux-nfs+bounces-20367-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMIcHQp4w2ktrAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20367-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 06:52:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230F31FF9A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E78243078F85
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 05:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51032A3E5;
	Wed, 25 Mar 2026 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oquUPVnc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48F218E91;
	Wed, 25 Mar 2026 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417926; cv=none; b=k8t8pEj2a2pHalb0Baw38Nragiw1U7s8fC/s7J0aQ6XrTB/8SFY6cLvfi9iLJcMD2aJ9ldEaqW033kCv2IckuLRQBoZWo4jg13529pubjarhINoODEA96hwMSz6fKmdTc1gnCcgWYgH7nwZyDmATBipbyC6H8wKHo+Z983KXPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417926; c=relaxed/simple;
	bh=fShTfN2nvjdpgvMXwtlYRic++8SmiJeNde7p859dwWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmdaUKbmaGO98tTbTLzm02VS9U1jTwj3K3Nid1bQyKPvAH+/xf7i7pmOxN8sgmvg8c7lppp4AMyj7vJRdZFCOi7+eA+aq1+32IoUTDaZkO8yJizdGl0knFPHMwTuGOD6d9F0Nc8HXiQp5NkwBULYdkGEqKudYo+ywopSi7JVnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oquUPVnc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svgP6BHiTNao/RmGuWcoVCP5nY+eMKIV4ahBKXb8a58=; b=oquUPVncP9vM/El9/dUmQn+Z5N
	AB03fYj6jFx3td1KrtdZDHqjOXCJPpsNgfC1lO/ET4kUUvBUH9T8vxk8my1XtLhT3rkLjX5j0o382
	4VHj7LspmpJ98g6n5VvGvtgXwvwa+peOiy0gavYZb5qbYtj4HYgqZwFW1IzfRD/VRShKrNvo4QhML
	KRpRrpxVluGMHQZJYiA2n9galV4xNNvFNfSu7aRqJYzY9u3XzhYqHVQdhvUGQKki4oZSQXXlRdi7S
	o8eecHSYjcOF98EmazWN0J9B5xCs63rpnK9E4boUoZlBFS9A9/VOK3dntgY0fkped853ZjxkwjiO2
	9HDXWwTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5H9x-00000002kkB-0enI;
	Wed, 25 Mar 2026 05:52:05 +0000
Date: Tue, 24 Mar 2026 22:52:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yongcheng Yang <yoyang@redhat.com>
Cc: fstests@vger.kernel.org, smayhew@redhat.com, zlang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] generic/551: prevent OOM on NFS on systems with no swap
 memory
Message-ID: <acN4BV5QmtP2W_WK@infradead.org>
References: <20260325035854.2262636-1-yoyang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325035854.2262636-1-yoyang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20367-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 0230F31FF9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:58:22AM +0800, Yongcheng Yang wrote:
> From: Scott Mayhew <smayhew@redhat.com>
> 
> We have frequently observed the oom-killer killing aio-dio-write-verify
> when generic/551 is run on NFS filesystems on virtual machines in AWS.
> 
> Virtual machines in AWS typically don't have a swap partition, so check
> for that condition when testing NFS and only use 90% of available memory
> when generating the list of write operations passed to
> aio-dio-write-verify.

I don't think this is a good idea.  The proper fix is reduce whatever
crazy large memory allocations this workloads causes in NFS.  I suspect
it might be page lists or similar, and just breaking them into somewhat
smaller chunks and/or using potentially failing allocations to
dynamically adjust would help.


