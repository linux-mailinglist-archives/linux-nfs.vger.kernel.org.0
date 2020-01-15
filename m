Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE213B8B7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 05:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgAOEti (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 23:49:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgAOEti (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 23:49:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so7912483pfb.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 20:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfdKnESFviVs3npGYhxM5GQYn0tzBty92mgk6HF1buU=;
        b=eVS4M3ptWJB5zCaTErK3amE7ne7qaEQrIVFgSg64S+nmTdJBItI5HCvrBuQfywjjAo
         sGd266LHmqOBA/Ov8Bg6GQefTF76MyNmBtAOBCl5Dwx1mhdjtatp/erFr/49Bd8UYbz+
         jFjmBMU5LbnSRvJeD/jxAVA7+LAvHzfxsILL0fGNzeXiMz3gMWY9iOj+a9Cqzmfom47h
         iBH76O0ThhV10acjnyw/BtV+E4NuOF/Q2Tu3ZSD8PRfrPkhwkpf+uWKD1EFWXVivgHFa
         SisPSgv2oBiZFxsVuYvOeu/G9jPUYQRktRZrqhrzsYJifFh7VmPw3q7/5nW5vEMlq4I1
         QgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfdKnESFviVs3npGYhxM5GQYn0tzBty92mgk6HF1buU=;
        b=PTmVJsNb0/q3b7YmnuHiCGw2LGrlZOtN6rFKrQJWhyFCrl8dXRvX1F0c9QOf5bz+gZ
         X/hv2aJOay+NdWcJsq8cjAjDxrTeDC6qq2+ZjaDNoALeqcU4RnRC3l0M0y526MDNkt8L
         gtH7/WaySwLMZdyEvQJFmpjI6fk+b1VKMgsSB2oLozKIvw1DFleaMTMHtoU+l0xiMnmO
         Zl0CTY/UpjWgaIc8nwoUNemTymDlHVsgtVcz0ARdeoM4OX/84/fKVhBeZdDbyjVTSb9w
         lPypB8V0Wg2rdoL7y/lK8snWMS7eI3DwCgzwIuqIzvOTlIZIpTHAQOiNpdaB/Q0EtUGx
         bPgA==
X-Gm-Message-State: APjAAAXAFuktbutaTB7yFfY7Pg+eHVnD5rG9SBD9FBDnzJMPVCkiscLy
        AYU1FO6GKX0L6LPLhpd8Vc10frYs
X-Google-Smtp-Source: APXvYqycm+Zj/6Ae4MXst8Cu/shk8yR3z6bdP+d1AEQdsHQhHl112zrIJ7nXszgBn6owkOAtv132UQ==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr29131890pfu.96.1579063777836;
        Tue, 14 Jan 2020 20:49:37 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 189sm20615693pfw.73.2020.01.14.20.49.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 20:49:37 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:49:30 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/nfs, swapon: check holes in swapfile
Message-ID: <20200115044930.mx4477ogjsbrn6hg@xzhoux.usersys.redhat.com>
References: <20200102080426.byzq4rrdilr2qxx6@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102080426.byzq4rrdilr2qxx6@xzhoux.usersys.redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 02, 2020 at 04:04:26PM +0800, Murphy Zhou wrote:
> swapon over NFS does not go through generic_swapfile_activate
> code path when setting up extents. This makes holes in NFS
> swapfiles possible which is not expected for swapon.

Any review?

> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  fs/nfs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 8eb731d..ccd9bc0 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -489,7 +489,19 @@ static int nfs_launder_page(struct page *page)
>  static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>  						sector_t *span)
>  {
> +	unsigned long blocks;
> +	long long isize;
>  	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
> +	struct inode *inode = file->f_mapping->host;
> +
> +	spin_lock(&inode->i_lock);
> +	blocks = inode->i_blocks;
> +	isize = inode->i_size;
> +	spin_unlock(&inode->i_lock);
> +	if (blocks*512 < isize) {
> +		pr_warn("swap activate: swapfile has holes\n");
> +		return -EINVAL;
> +	}
>  
>  	*span = sis->pages;
>  
> -- 
> 1.8.3.1
> 
