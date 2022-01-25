Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9649BC73
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiAYTrJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiAYTrC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:47:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B3C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:47:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f17so21847867wrx.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdQ4OcdaFo1OdIRdPpuKmdGVl8dBaZyqXzidha8Uhts=;
        b=esYRwDBUDbt5EzIOZG2Ib4BDK40tKD/fuXAjpPCafF055kfeLO4OzZHL6jTWr2XCJg
         amt/PGK5mD+LQU+BXLx2ppevkjZ+5IajKW8WjPxudEWHk9k7SmDm56uOcXmrjtnLKawB
         74FHTu3VLJHYztrrzrNe2NLRXQoke3htDFU+5y+xGcbHyZTnCeCnpZKv1eqV5XGUM3yL
         lkplux0eGpSijbo+9t8ylVIwkWXSnPI16bZV3+IQpSwdj88eaHDM39il3ntOzkpTGXUS
         cKjyH9eR/H1+mVcmkPNmdXCyJ3bjKa6UqQBPJCdmD/AEtSy7GLZVsiQatyCgA/nST9Vo
         18Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdQ4OcdaFo1OdIRdPpuKmdGVl8dBaZyqXzidha8Uhts=;
        b=MpstRM6qiHheLYW/TUE+mModbOdibtp3Vy50EB0u//LS70CetrQUhpJJBGHPUYUru0
         QAoHdepWaYscHd0/q3U6XsDuEPdTYI5CxoeJaVU+5KavXjbwBM0xbVUeBMbXB04bSzyx
         +P9Eeg1DYhMGoPnVBkccaXB7DtwfHBQV+5Nd2xZNqTiZyCaAgCajNohq32CpSoVq37M3
         4YvPoKEnxFOvJfHcRSvluTkFFMc7euRO2np3EBzBohemdjGxKFhTN+w0pRARchNpkYZ7
         aROydxer2rMVHnpxN1UtqVLEWSSSqJ9bM20k2py7+ScRBoHCwbxJTCOJ4zhXz6Wu7PDl
         bZLg==
X-Gm-Message-State: AOAM531CbJxkpdC3eSBco5HY4/QgX3+0q+bpxho3VcSHFsw2WoWSz/Em
        C63ylz/3vLaVPygw62eb8CGAPc9iZeeoqA==
X-Google-Smtp-Source: ABdhPJx/9hJc1eP9ZeWMhsk5nx0E/VJIbymgaGALk6gd2CCRhEbf8fC001yN3lJlkVKJTqRUDh60Qw==
X-Received: by 2002:adf:f512:: with SMTP id q18mr16260690wro.216.1643140019171;
        Tue, 25 Jan 2022 11:46:59 -0800 (PST)
Received: from gmail.com ([77.125.69.23])
        by smtp.gmail.com with ESMTPSA id a14sm18975355wri.25.2022.01.25.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:46:58 -0800 (PST)
Date:   Tue, 25 Jan 2022 21:46:56 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xrpcrdma: add missing error checks in rpcrdma_ep_destroy
Message-ID: <20220125194656.njd7r22stkrtk6fk@gmail.com>
References: <20220125191717.2945308-1-dan.aloni@vastdata.com>
 <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 07:30:05PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 25, 2022, at 2:17 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
> > 
> > These pointers can be non-NULL and contain errors if initialization is
> > aborted early.  This is similar to how `__svc_rdma_free` takes care of
> > it.
> 
> IIUC the only place that can set these values to an
> ERR_PTR is rpcrdma_ep_create() ? I think I'd rather
> have rpcrdma_ep_create() set the fields to NULL in
> the error cases.

Actually that was my initialization draft but then I saw
`__svc_rdma_free`. Will send over.

> Good catch. I'm afraid to ask how you found this.

Just some adapter entering error state in firmware.

-- 
Dan Aloni
