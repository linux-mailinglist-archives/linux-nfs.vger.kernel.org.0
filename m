Return-Path: <linux-nfs+bounces-19992-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2cNR45sGlbhQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19992-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 16:30:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF9F2538EB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 16:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB27031E9CB8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1663009ED;
	Tue, 10 Mar 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sEwafIiG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34492FC01B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154730; cv=none; b=PBH/CA1QUCNEZShKZlo900ZqgweVaO3dNNWedL8sVAKh1NA43k0YO+taZPD/iez7b/bckO/uKz4C0Ir4wRG9DU/URo0yz4+TgmvfkGhWMnwiCjCp6anYZOxqGvfX/GeTrWLiB5wJEAUHhnapSsVRPeWkkYSKMDSDsM8oSpV81Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154730; c=relaxed/simple;
	bh=lQgcdM3lCZBj/8K6q816AwuXHScG93RIDcas2CVQyuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbRc/uz7MfmYfd44yQue69rZN7MUDseetiXzu99PtaHQy+24B0fMnYaLschidVjkv8hISIBxcGW7Tlcja1yqB267sf/BPMUsYw8RoyzDZ+6u8Q7wjO4zrgpat8U/sbb6EpEdAdVyQx1q1AUhGn+O8hiy1xtCCgV17s63p0Wlicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sEwafIiG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lQgcdM3lCZBj/8K6q816AwuXHScG93RIDcas2CVQyuA=; b=sEwafIiGW6+GygWGv7bCq1/ZNl
	2xIt7SPBzbHMbAbsARxbQa8JHtKQQfF9+7XOscIybc/mEGC4eaowOvpJqdJ8HdAYRsWZvH8RlG+0D
	Nq1ZrliyMaBSuOP5o1JHm0feHNRWl1651PTq57wJxj4m2YxS6Br9ijlfnBFGj6vLA2QYecGnYWGNR
	FizJjAii8jYRJ9Ot0bZOf3AlQw7kj9Yjnjs0bJfSTL7OfAML19I6vvLWZ96jHzNw08s5WOCmdaNW0
	L3Ps8z9pm67psuIkyv4TRmIfsPePcYkNp5DD7WL+dDSoyazYS1BOx1vfLaFAJkFhULPr8QeuoOfNP
	TDa5F0aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzyXn-00000009kEZ-0rEg;
	Tue, 10 Mar 2026 14:58:47 +0000
Date: Tue, 10 Mar 2026 07:58:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4
 reexport
Message-ID: <abAxp5ulzweVS7sb@infradead.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
 <abAb8NYJECfXkRLg@infradead.org>
 <1c630798e0c931310f86f636abe84a72b86f7aae.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c630798e0c931310f86f636abe84a72b86f7aae.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 1FF9F2538EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19992-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:53:56AM -0400, Trond Myklebust wrote:
> If the upstream community is unwilling to take patches to address the
> issue, then we're quite happy to maintain the code separately. It will
> still be available to those who need it through our github site.

For something so special purpose I think that is the better way.
Having it publically available in this case would be very helpful
in the case someone ever needs it, so thanks for that.


