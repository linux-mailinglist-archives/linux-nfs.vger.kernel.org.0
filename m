Return-Path: <linux-nfs+bounces-5148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CB93F913
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E531F22C72
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04C157A59;
	Mon, 29 Jul 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRk/yDs9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205C156883
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265616; cv=none; b=mFI3qcu/Xbu8C3MIJpmDyzBjVtOiA6LYFuo7ckInYkrQalHVLDS8kMfFGuCUCkEmOE3iaPDqi2l0TmMGfOyuJoTi+qBfoEvSfHPPWlc2V/OKij57qbe3zgp8KSUIQNXh7+9t6cUVvyK7FHEywXYJYPHDIYqhWtTkP6q7PsTABlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265616; c=relaxed/simple;
	bh=X8VNlC7zvGhSCkbQ8ApMoOSu/J+Pz5jbhD5Id6CUlCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn67LCCM5qc1KYbX2/1svFZYa23P/Iw2txF9cNYbyOH8y7af87N+bWTySjdzhpgzruY/lgu1rRdS0PK6+UrBaGFldU7ISBJeKbMQIAenVbCWFd9HfqY0Rt28fN3d+G6ZG6zBxHXgRxW+zUa0rNpnm8SAAqqjlhJcQdyehrYuVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRk/yDs9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X8VNlC7zvGhSCkbQ8ApMoOSu/J+Pz5jbhD5Id6CUlCE=; b=ZRk/yDs9c6zHsDPyioszobTbO+
	kkZwblyqsEUt6Z0Ivniozv5lODvcrCTbwd9bNlbmKbwOO5JnKredtJfVEmc5tdZrSmJXP6I1/d6R6
	hFwj0b/gFDKa6ENRBgw46WrkeLoyH4nH66Db5QvZXJtTo0HnNsZe8q58Hky81hAF5vkX46QqxAccn
	F5qdGBmvOzf9AOrvZeOj02h91Bjciv06lenAZnSHEt0QW/pRd6vtOcd+r9hMIP/W9uI3E1ToxfwR6
	S5fMLuLZIBBM+GG7F/i6YOWHMYlM4HJbWooMRVWtwYqkHTs3QkDptIKyufDRCZsA6SE+8+njfcvPy
	x2n0DBJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRxe-0000000BoE6-0TWR;
	Mon, 29 Jul 2024 15:06:54 +0000
Date: Mon, 29 Jul 2024 08:06:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/3] nfsd: move error choice for incorrect object types
 to version-specific code.
Message-ID: <ZqewDtQbNwQlkfTp@infradead.org>
References: <20240729014940.23053-1-neilb@suse.de>
 <20240729014940.23053-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729014940.23053-4-neilb@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Beside the comment style nit noted in the last patch this looks good
and is a nice cleanup indeed:

Reviewed-by: Christoph Hellwig <hch@lst.de>

