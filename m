Return-Path: <linux-nfs+bounces-16183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB6C40987
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE44E6088
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F92823DD;
	Fri,  7 Nov 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMSXvKHP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F92836A6
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529440; cv=none; b=ahBjFZaG3lfznV8l8+XB7JLsM2dnXBMTqVre8/9HATGh2lNK2ygjd6QM6232gdXgJbDfKIK/WqOgFk56mlcE5A6T2PB8Mo8q4fOnE23b1CoH0QMLjDcuchTgtjQu/bbLK0fSQrgbuBnTTBBXRCPe3LEujITko0QVDqaSw8ru+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529440; c=relaxed/simple;
	bh=7323CAQ5LNXU1wvkfe5vaB6E4M9NH4sWyPTfk6IdFac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBiJ75a3cIgFXU6hC7eLR7XfwSySGx91vrRYWqZS99xqUn1GCGA23iwj7LulQCyYB5PYCPYMmscPCchkXeg1lNuf8K/L1BjKGzCdMD6u6qJ2X141aWJ5GmDL4/w8UvsOaZhDes+k3wEd01mgfut32qpPMOjjBgyYl7hxzJ2CJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XMSXvKHP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lpmgTH2rBsKrtQmnfTZh5A8TGH33WiWqMCTEJ7QOo4M=; b=XMSXvKHPoCafNKS03lzYhRmrqI
	VidnRuFxplp9tLAbqQ0orRtJyLGgHZmhqK94ZKUUjNPF9b97+MXetzfTzPc1idDmJa7AV80TDsn30
	0IEIHfOa0wUsPaSkn4ubx+RN9e9dAOo7xKzrbFf7HDFOpu3gbWfrDyjEpmwTcmb+qYqRSwPELEITf
	ZraMPVuudp4ZD9Rk90dTicav3c4K8qk1kChc/yF2ua9QkXwzr6Peo/zihVGe2vuJEraAcLL9Z71Xo
	HliZWTq43ASuS/nE0ZFob/77Z0UAh4x7ERPDlrfFPqfNEziLUEMhb9aeIs+Z3MykafLuxz+/Sk6+Y
	/hotz9Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOQA-0000000HaU9-1H2c;
	Fri, 07 Nov 2025 15:30:38 +0000
Date: Fri, 7 Nov 2025 07:30:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
Message-ID: <aQ4Qng8l8QHyiyJa@infradead.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105174210.54023-3-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 05, 2025 at 12:42:09PM -0500, Mike Snitzer wrote:
> NFSD_IO_DIRECT_WRITE_FILE_SYNC is direct IO with stable_how=NFS_FILE_SYNC.
> NFSD_IO_DIRECT_WRITE_DATA_SYNC is direct IO with stable_how=NFS_DATA_SYNC.
> 
> The stable_how associated with each is a hint in the form of a "floor"
> value for stable_how.  Meaning if the client provided stable_how is
> already of higher value it will not be changed.
> 
> These permutations of NFSD_IO_DIRECT allow to experiment with also
> elevating stable_how and sending it back to the client.  Which for
> NFSD_IO_DIRECT_WRITE_FILE_SYNC will cause the client to elide its
> COMMIT.

What is your use case?  Do you have performance numbers for them?


