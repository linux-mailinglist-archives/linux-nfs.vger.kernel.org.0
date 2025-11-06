Return-Path: <linux-nfs+bounces-16127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B8C3B225
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 14:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F46E1AA23D7
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CB32D0D7;
	Thu,  6 Nov 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOXcvwb9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2632B98E;
	Thu,  6 Nov 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434358; cv=none; b=t+rNVmpkcmQ28qvlGvDRhY0FU9x+XpGtKhznv5lV/N+v51xz8gtAiLpmqC8NOqD6QK4i/7AcYqq1GkdVE2Fh7X4seQfmycfOpowt5Fcehzy7A4RMoXwZdHzccvOBWvSXeO15aTka5UTG3NQvP8P5y0GBKLpOHgVJDPlG0Dbya7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434358; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZir/wOf2V/dtQVRJAs0UMPNmNSHGLpGxX6cY223L8o2r7zmNkQPMA6sfzSbaynJNzZFNOFBwuL6IwoQ9NSF0PYNO0SqdDqMp7T30oG9i8Eez7Tjzs4a4ogvslSHeR+qv2R5vDWcav8FVuKDSfNHg2Z64ryG9gVlRavZhuSPMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOXcvwb9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pOXcvwb9uPUOEK4PkXs/ygjGP7
	WCT9hXIzdjScCxMIF5mCrJcmFMn3V2N5x0VtE3il8sMcySrbzxz8PMuPKj0BYFneamVY0oUMGknjm
	gjpBNGcrIsyxsq42RP7KNG/loMc9vmMTyoOZMIrDk1Omladsm8ry3/9OewCzBFPBawQuk2ViFHB0C
	Kk9/bNhae0WEf8PoTuVjiKMYaUM99KuOrvQbfb9nluWF/BWaptUkww0AJ11KE79SnT8RgXrPH0YwF
	6gEfDb0jfpjjvacEV//3OsmBTKp114g9ch2dlsGHiF+E5wl+o0MGZ94e3b9wPES+4M1tMQy+yp1eB
	aa58PhZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzgT-0000000FX7l-3irk;
	Thu, 06 Nov 2025 13:05:49 +0000
Date: Thu, 6 Nov 2025 05:05:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v10 2/5] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aQydLQXd8VaiIp3Z@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105192806.77093-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


