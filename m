Return-Path: <linux-nfs+bounces-21492-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wdwnO2/DAmq5wQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21492-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 08:06:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A395F51AA92
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 08:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47493305E606
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62606421F17;
	Tue, 12 May 2026 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3xahri7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC433410D08;
	Tue, 12 May 2026 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565674; cv=none; b=tlURcnKHQfuaayG9VZZRr+oLJI7ALb6IgbS3D1RJizmjD5H816nm5GGwYNms/98GrezYepfowrbeBVUa4K6fYYp6Vo+SYmikDTFX438U/fHtsYpbJoRW5WJOeNBPEAZBaes/BrooRvr93GRdL6umdt7wQrAyLdmSHAwvO9D8p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565674; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsj993CrObz8hc2NP7GiwECpEtZnZZH/vZioDaORLvhVnjhDnjt9pMhc632NmdqVyD4i5L78VLfDvHOkYZMTjrAr3/u0umZFDaMrBQDrV2UJOAsWXmmeOu8+8Q+j+vkRxiv+9LfXvNAPMRiDxvAteobHKN+AEXpyYEQIvBZ9FtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3xahri7a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3xahri7aP8cckPzeXUtnfXscIS
	xHlf8bKsqsRRlcmhVxpjCnTxlm2jANJLqyADk8qiQ/yZDZ9KnY4lVtbDv5Cfbx0sxJBNrlJMP+uoC
	CJTCfM5/ywoFgRBNh1hIpUQD/pVqBAqgbUsvaoEONfwPbrUszt2BUg/CxDmGeEgvtrdmki1TrdwlH
	JoQCkPJ3finjiU1+LYEGw0fI75+7e0D8mOOf4wSETw+VlUIDojGH+zLRBxVvgkvTsOnJzxrtJoZq6
	Efqnv6YcpOmJV+RGcUYA99AeNUlMjq5slu+/ctU1QO/MutNBWQTyBXhOQ9tTRl5vTRIcqtOWLw++l
	L6UJS8/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgAk-0000000FiIA-3im5;
	Tue, 12 May 2026 06:00:50 +0000
Date: Mon, 11 May 2026 23:00:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] xfs: fix use of uninitialized imap in
 xfs_fs_map_blocks error path
Message-ID: <agLCEknEBQFNfHI7@infradead.org>
References: <20260502202542.111830-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502202542.111830-1-dai.ngo@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: A395F51AA92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-21492-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,infradead.org:mid,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


