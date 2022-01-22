Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4962496C66
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 13:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiAVMrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiAVMrQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 07:47:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F7C06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 04:47:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso24433728wms.4
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 04:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVbGjuJ+2Nv8WAgh42qAz07dja5TmMSrXhbDddUNiZ0=;
        b=Nb4qhPUXuY83vvHyJeBrkFboVFfEgOoolqKwCUCPSC51uMfEcB+N6klyhXMHsnKbeC
         JY65JhUEKYeaX43w6PNPsDGb0UyARV3MzEgHfKA9ikTM/Eqob/LZaho3+1MaWABOHVCm
         ISERsa5K+DkFg6asb5cHDam1zFKpXAPdgiEz4Ysxk6Vg3skEeqtxeI6T2wCwcRc510Z8
         TlDDOdFaV1q3P30Q0YFu2hCeySPiT7OPyPRbsG8Av5myFcwV9yUVQwNtysU/K432c6Pv
         XnvGHwGsVthgNMuV11/4gcgeFkcOKy360qgLN5ZOAFFYHes28SnMGzWWgi/P/tfnakJk
         UYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVbGjuJ+2Nv8WAgh42qAz07dja5TmMSrXhbDddUNiZ0=;
        b=3csE+RQHMn/i+z7+eQ78n7QUwUMz17/ZmGqMs/+e7XnRhjf7nZteRes7PJgh+2TEmZ
         LIKZzNwB5BtN6LhxdEDU4HtoBO1qVqxMdUWY9dautcKP0I8Oy5CBE+poQG4kXrUXxLZx
         FQ0Jm5u92CGx3Flk+lcga/TbsuImEJPiUixoF1X3EpWVUCdSULIjES7KgTjDpqafwN/B
         HY5lQtpLNDuVHPrffsMjYxqcOkwRWqRRk+a4xyCtkx8h+JSTdFxN3ccSg4DbzUFxAd4v
         HlyJTtvVF8nVT7Pgu1+iaeBBJIAOh7gcoorpeK5cNHM/EwnDCIt2+xC7gpQ9D77fMNe1
         V71Q==
X-Gm-Message-State: AOAM530aj+eLQaOUcVYK3Ut9x+YAA4T9NAFm8/4VhFD2OLIbowVrOHG8
        W4x6NUuaJIX1yVTuKpufguoqa67hDPrOqQ==
X-Google-Smtp-Source: ABdhPJwMQTn0ahO4kQGE0ENtgidPL8vMWMOvM0ly2WkH9vWkTpNlFCBD7nkF0XgWnz0XmMliVava4g==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr3588163wmj.189.1642855633897;
        Sat, 22 Jan 2022 04:47:13 -0800 (PST)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id ay29sm7817367wmb.38.2022.01.22.04.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 04:47:13 -0800 (PST)
Date:   Sat, 22 Jan 2022 14:47:10 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Message-ID: <20220122124710.4l5bzmfxhf2o2yee@gmail.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
 <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 21, 2022 at 10:32:28PM +0000, Chuck Lever III wrote:
> NFS server patches should be sent to me these days.

Thanks, will remember this next time.

> > On Jan 21, 2022, at 1:50 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
> > 
> > Due to change 8cfb9015280d ("NFS: Always provide aligned buffers to the
> > RPC read layers"), a read of 0xfff is aligned up to server rsize of
> > 0x1000.
> > 
> > As a result, in a test where the server has a file of size
> > 0x7fffffffffffffff, and the client tries to read from the offset
> > 0x7ffffffffffff000, the read causes loff_t overflow in the server and it
> > returns an NFS code of EINVAL to the client. The client as a result
> > indefinitely retries the request.
> 
> An infinite loop in this case is a client bug.
> 
> Section 3.3.6 of RFC 1813 permits the NFSv3 READ procedure
> to return NFS3ERR_INVAL. The READ entry in Table 6 of RFC
> 5661 permits the NFSv4 READ operation to return
> NFS4ERR_INVAL.
> 
> Was the client side fix for this issue rejected?
 
Yeah, see Trond's response in

   https://lore.kernel.org/linux-nfs/fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com/

So it is both a client and server bugs?

> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 738d564ca4ce..754f4e9ff4a2 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > 	__be32 err;
> > 
> > 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
> > +
> > +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
> > +		*count = NFS_OFFSET_MAX - offset;
> 
> Can @offset ever be larger than NFS_OFFSET_MAX?

We have this check in `nfsd4_read`, `(read->rd_offset >= OFFSET_MAX)`.
(should it have been `>` rather?).

Seems it is missing from NFSv3, should add.

> Does this check have any effect on NFSv4 READ operations?

Indeed it doesn't - my expanded testing shows it only fixed for NFSv3.
Will send an updated patch.

-- 
Dan Aloni
