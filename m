Return-Path: <linux-nfs+bounces-12877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C61AF754B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 15:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B619A54043F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C302D3226;
	Thu,  3 Jul 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jC7+YzX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75481E;
	Thu,  3 Jul 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548721; cv=none; b=FYZgcXPd9lQLONHZGDPqpsKmUMTzSrFaxftkP4CIc6P9bMHGeLXo0nNjrFtToER9wlLaVaOZIhk769C86kTrGYKnVecdi9LO4KpgF9Fk+pqhYoxaqV87kFPR31EXOu0dhSzE9nL620qPWpNlI5QPDQI++Cg7hcGp0zCiYvtUIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548721; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbx6rVAbGlqYCEFTownk4UcvUwVHr3OgNMHrwsMSA3CGEclhivpZ1lMMTzfNwQRBjvlqPw/cn+wtDifbVpCxCiMVHB4M54GVChM5nuINO7eU51abiHVn69bXq7zhklCTLzeFnpzRVTFIE3cM9sx82HuBH7AEpANK5oFI6mZR9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jC7+YzX9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jC7+YzX9C9fQKrE5xi1RclyQ4i
	OdO44hmowcXZx0yR5yysN6833WmAtej/q9tX33ox6eqDJxKy1qc9rzV42BJuEH2UrK7r8qQ8YPmqQ
	pivbH2BhkE+WEXm3dj6loKYJ6XG7rRaaKbo8zwlFx/CldeVUw+97Y59eOPNy8oTWKCoQdxLR4MGkz
	PTKgd54UwMEa4goEOK8FlImhRngHZq3Ggw9A5q62DMgW3XDEZXk+vUFwnMKk3PLuHTq9mtETa4QzP
	YWVS+oZdMu1Qq/iBrPbYOTYqnOKANeT4CZSx2b2TPwU3og1uGF1Qel6mJo9828gKtashLfiIjxweE
	UH4YONLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJpm-0000000BSoH-3PIX;
	Thu, 03 Jul 2025 13:18:38 +0000
Date: Thu, 3 Jul 2025 06:18:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 4/4] pNFS: Handle RPC size limit for layoutcommits
Message-ID: <aGaDLpctEfaTzMv2@infradead.org>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
 <20250630183537.196479-5-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630183537.196479-5-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


