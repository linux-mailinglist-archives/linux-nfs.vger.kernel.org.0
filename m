Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F06281660
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBPSk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPSk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 11:18:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A174C0613D0
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 08:18:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so2245235wrt.3
        for <linux-nfs@vger.kernel.org>; Fri, 02 Oct 2020 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22N7xykZK+bCAVLn0Z1Rgevv6oK6S9H/f9kXPr151qU=;
        b=Q9OchJnHhnfJOkc6TBSEcPxpt6D62w9pjfyoAyycM9Dhwm/dboAk6CLe2Q6fqhH7ct
         kzfu+mQ+xXUyGroMCHBV361mKkSSzqZy9UcvKpfX1PGOxSTS5h58T57sLwygDWtTJDp6
         MJlYoSk1BHbR1+Mik4O9RxL7QcLRiy/LaLTwGmeSNtCifVfjEgEaJddnUa0TF68e8hpP
         9UCdtAY2qoq+/IcT/kpF3n+pm6xElZZWpNgyqW8TKpI4+WJFSSYO7mx4kzFPenKXF1q8
         z4QoMNVMjhjhTO1e4C+ao+HmF8oAr2UzEYdaDbFdwug93I7mb0uP+tC0Uomawc8DhW/d
         FTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22N7xykZK+bCAVLn0Z1Rgevv6oK6S9H/f9kXPr151qU=;
        b=MRS4ore4ifTX9rbBsiIpvrwfwmrN8yQukDbpTfKa3LwzhsqlXwznYO1v/AmQStpIM9
         8Z2UawvAJQqAo0vBs363SSAY8K+itf75qiry2O8k1Z0PtFRsdsyERH5lnj9LMJHAlidm
         pxbFgW/cJ2G5oTNpby2m770j1f271llG8yfGyxAASRSMCTkdY7aZD8/fCsLUpe/ppKOy
         UpIOUpznYLaUQ8NsWJ8nt8/bW9VgQLH+SNqJb24zXDdgi0W8mGdoW44plGm274kZk7Ea
         fGT/6UDDGVJVmMPRNgQyAQwe1hWbgE7XFeKlFgel9ckvutqseWlSTHCLO+RSnXo/ojHu
         p52Q==
X-Gm-Message-State: AOAM530lM1XDZlAA4rsYmNULNMim9yhdCqQEGCQP/1kDE28bp94epOE0
        KkFpNm2nsN7pGGbaFUfgguptkA==
X-Google-Smtp-Source: ABdhPJwFFPjZasb1Jp8vWqycZjOMTRFQORFwgiziEmSCjWQx9bUD2Q533A0rlphnewkCOn2Jxf4pDQ==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr3676795wrv.322.1601651917293;
        Fri, 02 Oct 2020 08:18:37 -0700 (PDT)
Received: from gmail.com ([77.126.105.230])
        by smtp.gmail.com with ESMTPSA id k22sm2293671wrd.29.2020.10.02.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 08:18:36 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:18:33 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] svcrdma: fix bounce buffers for non-zero page offsets
Message-ID: <20201002151833.GA988340@gmail.com>
References: <20201002144827.984306-1-dan@kernelim.com>
 <7DE1BF37-DF5E-47F2-A24C-A80ED20956CE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DE1BF37-DF5E-47F2-A24C-A80ED20956CE@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 02, 2020 at 10:54:28AM -0400, Chuck Lever wrote:
> Hi Dan-
> 
> > On Oct 2, 2020, at 10:48 AM, Dan Aloni <dan@kernelim.com> wrote:
> > 
> > This was discovered using O_DIRECT and small unaligned file offsets
> > at the client side.
> > 
> > Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
> > Signed-off-by: Dan Aloni <dan@kernelim.com>
> > ---
> > net/sunrpc/xprtrdma/svc_rdma_sendto.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> > index 7b94d971feb3..c991eb1fd4e3 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> > @@ -638,7 +638,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
> > 		while (remaining) {
> > 			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
> > 
> > -			memcpy(dst, page_address(*ppages), len);
> > +			memcpy(dst, page_address(*ppages) + pageoff, len);
> 
> I'm assuming the only relevant place that sets xdr->page_base
> is nfsd_splice_actor() ?

Yes, and traces at the server indeed indicate that splicing happened.
This works for both tmpfs and ext4 as host FSes.

-- 
Dan Aloni
