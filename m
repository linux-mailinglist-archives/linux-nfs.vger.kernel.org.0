Return-Path: <linux-nfs+bounces-12874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDBAF753E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 15:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5876A3BF3A0
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8634CF9;
	Thu,  3 Jul 2025 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipz9jo4E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74E81E;
	Thu,  3 Jul 2025 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548660; cv=none; b=C0xbMBf/bLb/24kXdEDmyK80/f394xUqwvl/C97k/ylfGXphJQsjqmnUwxTIQ8rKQQuLLQl+BX6rjBtMddcCRmUvOR4gp4rrodqjjWkZS62cSXujETar7fe/yLoYEMg7qJxfCdmOzrA2Nh1TbtxwIj8klYy4P+LjskgqH93jVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548660; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbk8If3pvbdF+/4D1hZRt5c+/QohTOSOGoLuGwxMvZHxxcT1PBDcwy9qr0ppA/VHkRY1zqiKGZgf7AemqggXcx2nmyiff2pgD9QkeateimkzSPBQJQmr8nK8G2bMsEZlCe0xc7NiQG334Vbu7IZdNsb6J/RperuGZtgySTcXY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipz9jo4E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ipz9jo4EB38gVFtvxfO3Qo0r5X
	gH1INxc4t8+hZ+4B19GY1bSfEFm9TJGIDfypK3trn3fGyh0R5MMczvpYi9A4eL0UwUycf3DavKPMW
	GSjbCz/dRG9EDzYE/Ar5nl/BU3e2LXdy0tvHzToh6/FZnw8tYNXltohZpI4bwokqJpL/SqcosUO3m
	qug+Rbx6xdWlN/rGyMZh+Lb9ccroXucYG9MRKrg77MQ88f6E/v6llZIO2b7rPFCQ7O8wuOLf9rwSY
	D5n9OaexY4Kng6PVWAOGhAuc8GsJ918kb7HIzLh0Z+xtjZzNj+Y0JJ4pWx/7BgQmgbc2EFJ+Qgzei
	RhIiV/8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJoo-0000000BSf3-14gv;
	Thu, 03 Jul 2025 13:17:38 +0000
Date: Thu, 3 Jul 2025 06:17:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 1/4] pNFS: Fix uninited ptr deref in block/scsi layout
Message-ID: <aGaC8gWH1Ivt7Z-8@infradead.org>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
 <20250630183537.196479-2-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630183537.196479-2-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


