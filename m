Return-Path: <linux-nfs+bounces-15398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E082BEF91C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 09:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6801885E1D
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474C2253FC;
	Mon, 20 Oct 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLuE05fn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB7189F3B
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943766; cv=none; b=j17fqIzTirPLUzWzIp3hUpQ5hWTTfFjt0Z2HbESv/0Jq5Suk/GYXOPZ3FMxea/XaBU3WtMMEXkB1tGuqUhF3oewIEZdi9khh1yCPPLxvuy1LK4wKdT704DsPW4tWlFcHs19Cr3gWuYN1JNMk+wrO34oGKu4Hprid6MiXMT3lqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943766; c=relaxed/simple;
	bh=UtrbDyp1vqGy3lZh13XNOAwhqo0uBONDXGC9rnQp06U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB8M5qqJ1/Y76UzWx8gTD+nVrCM5tUq6MFjsDJ/18bT3RlS5CQJ30B8AwxOcWW+13HHm6ATP7Sq9AkbwoWNIA1rX6/wH4eVJgMPoMjUbVn52SPgZ8JE2Xc5jYNRiS2FPZDTIB3SyhVoaQTPlgdzfTWuO16F7N1qHIMxBlJcy1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WLuE05fn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OU3peJy/SqkfzoK9SdoFZVL3oUsCf/L4BUgSEewj4CQ=; b=WLuE05fn3oJcsJL3oYNrNN5Z2+
	gbBCiXcVViyJic9ualRlHmDXVdoaTLw45bq+BsljvBPbGM+kJWu3eDuNmXT5zl1ph8IMBzvW9KJMq
	FCBNbHZIdG4JnDuakOpxeDszrEA6Oe9yu354Tx6fiaOiyHocsf9aRyOqbVW9uHLuJp0EnNPAygza8
	6xKgxoGXpuvam4VwKNQVVw2KoKq/eQ4Q2Di1hmmYgIyF/KvqvQQu4MuXuV2DRMxJXU9GypOKFFLRh
	YwcRvLah1p7yGy1HF/cVQqOaSO52EcTM3OuHWLzSZtsa6VUgOj6r999cXZDbhp8MhSXMMu1kVOiy2
	VYo3NqKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjuk-0000000C89h-3015;
	Mon, 20 Oct 2025 07:02:42 +0000
Date: Mon, 20 Oct 2025 00:02:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 1/3] NFSD: Enable return of an updated stable_how to
 NFS clients
Message-ID: <aPXekhed5De_7UIv@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018005431.3403-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 17, 2025 at 08:54:29PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does

I'd much prefer you'd mention why that subsequen patch needs to update
it instead of being so vague.  That really helps when trying to
understand the change when finding it in a bisect or blame.


