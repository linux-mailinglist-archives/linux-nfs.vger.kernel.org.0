Return-Path: <linux-nfs+bounces-12873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB9AF7508
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 15:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96D03ACF33
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FA2AF19;
	Thu,  3 Jul 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQyf3qlP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BE292B25;
	Thu,  3 Jul 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548027; cv=none; b=cXnNIEn2r+G3RY90AawWChKEMiBq7FPaaZSyih1AtlDo/duOCT12AJz8eYiipQykEhXzky6g7IQl1HD5I7Da1MVy9WMYjUzdNvgHIsmEv8FQy7CMlZ4joasVq5BUkgrbJSuy5ZYHkkPGr3iSuiKqs9r7aLD5jxqd1CC42xS9mkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548027; c=relaxed/simple;
	bh=S6VZWZsxOWf5MZdkOKW6fOo2sk39zw/JsQVyt9JxOVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7q2oV9W+EhhOuQwfTpIvb2Ou0J+rQbDJxtxmcK81fpBsC+oA0VDxZqAHy62rlKh+PtTDl4NoU8UEitXKA+6DKfbS3B5GX3Ba3ftuTMegUTDW7Zo7Nz9xnHCFMy7VzfryYB1zfWj8EcpWvGwRti6X+1erz5bLcs/ceCLlgb8PBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HQyf3qlP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S6VZWZsxOWf5MZdkOKW6fOo2sk39zw/JsQVyt9JxOVQ=; b=HQyf3qlPnIQCmv9qJpsw2x5k+c
	8904Db7UR40RFMN2nKwBSMjfXNb9KXy67cqhw5xQ5UCkwc0yt/K8rro4m77lw1xLlbOzYl+lM4W0T
	JgOHc7CqQQtvuZSmiXHuXjO7yBwIz1lZbcr3af5XZH76xcfx1Kg09lOqzJ0jnh7IkDnNo43ABr8lW
	+xXqfZ0zn71bGtd7Rc9apeLQmRj97WWTRjJFstDtdi5F2gR7kSEdNYKJEGZrGvV8D09dUbvTYbf0C
	GNXocVKFp4KXSczjGvKI6DWkEZFZdIOkT9v+xiURbcWsm76AOf3LiqbnKngvdTg2XYQD3TnqsMZQx
	v5Gt5mAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJeb-0000000BRH2-0cFZ;
	Thu, 03 Jul 2025 13:07:05 +0000
Date: Thu, 3 Jul 2025 06:07:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] pNFS: Fix disk addr range check in block/scsi layout
Message-ID: <aGaAeen6x-DjfDE2@infradead.org>
References: <20250702133226.212537-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702133226.212537-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 02, 2025 at 04:32:21PM +0300, Sergey Bashirov wrote:
> At the end of the isect translation, disc_addr represents the physical
> disk offset. Thus, end calculated from disk_addr is also a physical disk
> offset. Therefore, range checking should be done using map->disk_offset,
> not map->start.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


