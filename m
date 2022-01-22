Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82F496D7E
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 20:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiAVTBK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 14:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAVTBK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 14:01:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DEC06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:01:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso21601917wmf.1
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kv1GYbPfslwQ7DVts7q2ccwIS1pvJJHon+EkoxyLYds=;
        b=PXZNHxTDR+5vNtMPFFWGibZZef0dOlMALVo9XpgchatMcYQPPXnUmdlj3Hl/h5H3lm
         APu4921x3+yjFZQOv21Jct++PiNtMMHnMM2/zNY6aSNK6Vao1wHhb36d43A2MhgbpLGQ
         5xEo5UUQbLUzpjQxYwAN6jq4Xhsc6cCJko+JywXCVVZz59XjkFcbNhYGQs4nxRw5yv93
         ur2dAIpgCB2hX1T0IadYU2PjAu9BTBGpZcIfEqJYzFOTKqGZXJg9fyS5vO7Ihs95aj8j
         hXVIwlJex+GN7rYzgMGDomoc4OBNY2ehHsB8ElqRwqWB2y+y1PLYazre5qhVqrmii1rq
         okAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kv1GYbPfslwQ7DVts7q2ccwIS1pvJJHon+EkoxyLYds=;
        b=NwOblk6hbJ7LgX5H3Ycc3CpP2ZCb9bW9VUettDeIeM54wSWapSkHvcnP+H1lzm1dJx
         gErlra8TbyjqUBKJ9Mi7+bLhV/MGggQc/SBnytMHee3O+AwO3zV4M3+CpbR2h6/e86ZV
         S9PwJ3ocFGYKDRQfXhe4kJKJxzFy8Z5FjSBEivyTLmntPWtNP8ma30s3zs9pxgtqmDSA
         qFNOuSWAvIJwDWRDD02vRFpMXqvRDLQ0eQzSDE34eyTwXCOxSZ0Lao1Tc1/7qI6c08/N
         xmWDl/Y2mNXJjD9PPbgYAXOacwiUI5/zI58iVB0BLtHSJ5wV5mA73CLI3AMonGE2hKnG
         GRBw==
X-Gm-Message-State: AOAM532/IX0h6cUJqP2nk4TJ3jQo1Lz3p1s0/B3xuiUkzklgEeZmMPqE
        y35yP+DFid3VD2ngdVd9LEH/wQ==
X-Google-Smtp-Source: ABdhPJyOIclVEbzhKKYS51nlcX+gSd2zPscygZ4U6zEaL79cISeoquMzeE7j8sU6eERtyNgmogD5Yg==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr5439324wmq.21.1642878068369;
        Sat, 22 Jan 2022 11:01:08 -0800 (PST)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id t5sm9509910wrw.92.2022.01.22.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 11:01:07 -0800 (PST)
Date:   Sat, 22 Jan 2022 21:01:05 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Message-ID: <20220122190105.hgl53kthxmxlanaa@gmail.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
 <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04E4C6DC-B78F-45DA-871A-296379B2D484@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jan 22, 2022 at 05:05:49PM +0000, Chuck Lever III wrote:
> >>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >>> index 738d564ca4ce..754f4e9ff4a2 100644
> >>> --- a/fs/nfsd/vfs.c
> >>> +++ b/fs/nfsd/vfs.c
> >>> @@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >>> 	__be32 err;
> >>> 
> >>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
> >>> +
> >>> +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
> >>> +		*count = NFS_OFFSET_MAX - offset;
> >> 
> >> Can @offset ever be larger than NFS_OFFSET_MAX?
> > 
> > We have this check in `nfsd4_read`, `(read->rd_offset >= OFFSET_MAX)`.
> > (should it have been `>` rather?).
> 
> Don't think so, a zero-byte READ should be valid.

Make sense. BTW, we have a `(argp->offset > NFS_OFFSET_MAX)` check
resulting in EINVAL under `nfsd3_proc_commit`. Does it apply to writes
as well?

> However it's rather interesting that it does not use
> NFS_OFFSET_MAX here. Does anyone know why NFSv3 uses
> NFS_OFFSET_MAX but NFSv4 and NLM use OFFSET_MAX?

NFS_OFFSET_MAX introduced in v2.3.31, which is before `OFFSET_MAX` was
moved to a header file, which explains the comment on top of it,
outdated for quite awhile:

    /*
     * This is really a general kernel constant, but since nothing like
     * this is defined in the kernel headers, I have to do it here.
     */
    #define NFS_OFFSET_MAX		((__s64)((~(__u64)0) >> 1))

And `OFFSET_MAX` in linux/fs.h was introduced in v2.3.99pre4. Seems
`OFFSET_MAX` always corresponds to 64-bit loff_t, so they seem
inter-changeable to me.

-- 
Dan Aloni
