Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276AC17D891
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 05:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIEWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 00:22:08 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39212 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIEWH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 00:22:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id d8so3824588pje.4
        for <linux-nfs@vger.kernel.org>; Sun, 08 Mar 2020 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmuIkQDkKkAgRCx8gH6JYqO0UfoPziSoM3VSgGCREac=;
        b=TEFlug7D9U4ssfNMaEnPiIfIXJd2Bu9tm/mZYg8GeJr9+oODh0uieFWpE8dzjCqvxp
         AClR6lnph1djqA0zr0WDytdloGz3kEY5DpD7w9+ywMArMmcCw9LxHvFSE76WNvDXPpfc
         s/UuTZvTwY8RJLFe/DGRG4k8oBDhM48mr/GgUAgVnBStZ0P/kP2QrDiWCpVqKSPaMVaj
         Xlh+L2o2/UKGUWHaWtbb0SVjid/hJsGE83zfyJfXCkcMy+wfm/c3MxIoxky33/48raw3
         WPDXTQ3Cnx1rXK1z3w+MmPFy29zfo11UJzsHqZOy7XFeHw+YIV02VUuCuevu3olXs7Ga
         3EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmuIkQDkKkAgRCx8gH6JYqO0UfoPziSoM3VSgGCREac=;
        b=bVK32OzF+2jCGY0i9zE517hzA6Bku5646eGN4LWhUrPbJ7FdAFNMzmgx/UQD/onNkB
         UqWFRQRwisZAE9dXGb9XvUkZSCCBH+EXht0YuhUJn45ds+R8193b2FB5g8GQ3ZGxgjop
         ebPsDwfGFmeTJi6z1RofZQMzaXJHcyWUZMedA1qTYtixlTEPAPlRaEvGPhSHlG4X3ma/
         CRpszp+amZjR7cnNzfS2fN+F0DpNYb5y3E0S/k9paopXK47MALgB+yML73ctorDgcT/w
         eRdY1p/JExiQFy1HHXmNK5WCQKs40BPVmTZgU7XB2TNjOguL9brmXHpM+EIX+BfXqTRV
         I9jA==
X-Gm-Message-State: ANhLgQ1nanErSAgtFrFSp6Rnyb2WgcDKm4gL2jtK0xAOzLrZVrSBU7vM
        BNRGN9W2dMZ0PYqoC+EAkHg=
X-Google-Smtp-Source: ADFU+vuIVkUgTcSlbgh8lLz9NDsopYgnjrKpCiwauVycCFGEQjxwp9VBpAzx+ckTCIw5DIDXq0yF5Q==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr13882949plb.202.1583727726800;
        Sun, 08 Mar 2020 21:22:06 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y18sm41834728pfe.19.2020.03.08.21.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 21:22:06 -0700 (PDT)
Date:   Mon, 9 Mar 2020 12:21:58 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4.2: error out when relink swapfile
Message-ID: <20200309042158.vyuo4ghkahevsvoa@xzhoux.usersys.redhat.com>
References: <20200214143409.27etgp3gpvv7vgsz@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214143409.27etgp3gpvv7vgsz@xzhoux.usersys.redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 14, 2020 at 10:34:09PM +0800, Murphy Zhou wrote:
> This fixes xfstests generic/356 failure on NFSv4.2.

Ping on this one?

> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  fs/nfs/nfs4file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index be4eb72..993a4f0 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -253,6 +253,9 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
>  	if (remap_flags & ~REMAP_FILE_ADVISORY)
>  		return -EINVAL;
>  
> +	if (IS_SWAPFILE(dst_inode) || IS_SWAPFILE(src_inode))
> +		return -ETXTBSY;
> +
>  	/* check alignment w.r.t. clone_blksize */
>  	ret = -EINVAL;
>  	if (bs) {
> -- 
> 1.8.3.1
> 

-- 
Murphy
