Return-Path: <linux-nfs+bounces-15321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91EBE650A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C05884A2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167924BBF4;
	Fri, 17 Oct 2025 04:32:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F48334689;
	Fri, 17 Oct 2025 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675524; cv=none; b=Ng0Il+aijghfcAHdlO72mu9EYh+VorzY3QPFEI4EsbCjx9DXW22+TS4zxmGUkqjidxSag6zpBtsh48vRZvL01dccHGPMqphEKrY/WPNsIAp8ypcpEi1odYy3SE7zlVMdZYGH00dw5P+slGikv11P46axohQoa+nQZQbHZvSlfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675524; c=relaxed/simple;
	bh=DETdEaVgrhd43bNfBsExdkueGna+/SVmUJ9TlSppIAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2rmsZ93SW1ectedewsCcA8ZyA7KUYEDr/hqJ/h2QNxMHa4eA00I1UOTjJhl9jEEoP0SvK/Mcuzcryu6ckb4B7zqncfA2I99ermAj1jMi5w2urLTAjVS3VOu3YiTYnaeNiMAHQt5zKXdkwEj1sqVDwsNIybUnK2TucYZWjJawDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88013227A87; Fri, 17 Oct 2025 06:31:57 +0200 (CEST)
Date: Fri, 17 Oct 2025 06:31:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a
 KeyUpdate with debugfs
Message-ID: <20251017043157.GB30271@lst.de>
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <20251017042312.1271322-7-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017042312.1271322-7-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 17, 2025 at 02:23:11PM +1000, alistair23@gmail.com wrote:
> +#ifdef CONFIG_NVME_TCP_TLS
> +#define NVME_DEBUGFS_RW_ATTR(field) \
> +	static int field##_open(struct inode *inode, struct file *file) \
> +	{ return single_open(file, field##_show, inode->i_private); } \

Please use normal indentation in the macro, but do not add an extra
level of indentation just for being inside a macro.

Then again the macro is only used once anyway, so why add it at all?

> +static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,

Please avoid the overly long line.

> +					  size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nvme_ctrl *nctrl = m->private;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	char kbuf[16] = {0};
> +	int queue_nr, rc;
> +	struct nvme_tcp_queue *queue;
> +
> +	if (count > sizeof(kbuf) - 1)
> +		return -EINVAL;
> +	if (copy_from_user(kbuf, buf, count))
> +		return -EFAULT;
> +	kbuf[count] = 0;
> +
> +	rc = kstrtouint(kbuf, 10, &queue_nr);
> +	if (rc)
> +		return rc;

kstrtoint_from_user?


