Return-Path: <linux-nfs+bounces-18094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D16D3A0AD
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 08:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15A9B3001806
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1213382C6;
	Mon, 19 Jan 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjsSsclA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB072DC76D
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809243; cv=none; b=ELfGBQmwyO/FLKwdFdKbPgJUCVM3BSMBMeAYDBj2By8kCOSyuul58lw7enP4JovJJrP9NcoAqXCnnsDpVLvaUfPNlK+yqX/d8QRQCTv6N3sZOEAhe9yJfEM4f5v5+Xp8yitPVM4sJwR29nMiI6CsN1RjBUGgs6kDCpw/i7e7uC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809243; c=relaxed/simple;
	bh=JhskdO+eWKQSmIyLGN2zcNpF8aS6HOIeXuPdPgbay3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxPqPq/1l7xAlCpUmJGdOM5STVPO7sVBQ0FASissjVKTrl84J8rOnGYej2BAxmiCRJcM3qRT0qth+EOES3lmR7IKv5CTsiI004gHtYIezUJE7nVn2QjPKufjCGiDxNQv/pLsRAyjyQ2OYM6L+zxUZwR6N6kVWTOtnb+5CnZAgco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sjsSsclA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tLVOsJhR0Q8T6bkAWtUwT1B3+eZE5rSd/1TqF65SWL0=; b=sjsSsclAYOyxWds9TbsBxSCBaZ
	gwvHJo3S+wVU2f0GejHrTk0bK8SSnoXxQATrqVwT6zV0DtrwRDgJIsmeo7Ptkcuv/UGAymo295Pz9
	lWC7a6QX1MtOM+ZUx87mGFhneGHZcMqXRnvDvsrx4LH0BCUuI5xE+BjV7lsFM6kuwCj31Knmf1Ck1
	+XoYVSIOA/6oglGqQmKlb7TcwW84JdcNJL4UI/OlZ1Hab0R0MtDmGIrx+6Igsia9Wg1ZWV3cZHR7a
	wGAjwMonYxWueka9auOhRZcy+fEUTW43LTFXxCuNA8KD4T+7bR5u4XcgFh44Ai2aP8mr6fXK6RGIS
	fF35YlIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhk5J-00000001Wfs-1aVj;
	Mon, 19 Jan 2026 07:54:01 +0000
Date: Sun, 18 Jan 2026 23:54:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <cel@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Message-ID: <aW3jGVAHrEusJyBk@infradead.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
 <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 16, 2026 at 11:04:55PM -0800, Dai Ngo wrote:
>         ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
>                         XA_ZERO_ENTRY, GFP_KERNEL);
> -       if (ret < 0 && ret != -EBUSY)
> +       if (ret == -EBUSY)
> +               xa_clear_mark(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
> +                               XA_MARK_0);
> +       else if (ret < 0)
>                 goto out_free_dev;

This looks reasonable.  But looking at this, I think it would really help
to add a named constant for XA_MARK_0 to make it more clear what the
bit stands for, and maybe even add little inline helpers for
setting/clearing the mark.


