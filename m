Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2899E2CC004
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgLBOp6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 09:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgLBOp5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 09:45:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98DC0613D4
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 06:45:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g14so4207864wrm.13
        for <linux-nfs@vger.kernel.org>; Wed, 02 Dec 2020 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0e8mIaw8PP4OAFlKU2TGhgKOibkFX5m/XDWAUd2cnhg=;
        b=Oht9092vZ1yIeffr3695hxLANHpnWl/ikU4Xy5MY9bukIIaIZ9vDDMaaxuQHP456Hw
         5AaR25FRUrfJJ/jUR2zfOLkIAw9OmvHGpZ3oioPMov/t3e67stc05B7b5Ikglsz0FHTG
         U7XihAeqtXJtxTY0GysQk6XyMeZOGLLVJ7OKewOCyhJARXAfwP2+jbzrXzgOI7kRItwS
         aas3MOo//W2Vvt4hE18Zz7H3AH6XuZdBJaZlq6Na1QD11ineCSo3esDcmiG8LGWhoo4q
         7SErn/41JdUnLtRqBzs+eg+RKMuVTVTnxq5kvwtJg97J5ANPprykd8yoPFJBUtVV9si0
         fDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0e8mIaw8PP4OAFlKU2TGhgKOibkFX5m/XDWAUd2cnhg=;
        b=nFoImWklHz+hdUSWT1Eldsy+BqwV63GjZ0OOP31alRdqoWd0uwrLrqGjIR9fn6c9Tn
         10MmEabqoN+F3Wi5uvVuBYD3RQhCOLaDVJ7gean4Ol+Gngs0N8dotZwr+9fcdmAVm7D3
         JPDWVl80Urlm3Eo2exc1kWSFd5bGYBqSAXR95ENDk5xHyimEbBL+TsV1yFq898qYuJjF
         hUbd2NqEmg/LE9KX7V/FYa8WRGvQ3kkNODJ/M5AtInyK67KEyoWj2wljWAoSygBODSNf
         lghHwpTztbyT09mFReLKLGtiladpZCgiRYNb0hkF5Inv564f/EyED4fl0BVE4YOLGQga
         nXAw==
X-Gm-Message-State: AOAM532gn0dKLTPx1GSdGQ0tv3oHLoyDbROaEFH/cCCamIh2If71ZwCf
        YNLPqyLhMBuvrNM2zAU5JJXxXEVCHKW2QCd/
X-Google-Smtp-Source: ABdhPJwea1bZ70br5UDxrk7LUZR/8aNoY+03AaLjcP3OcqI4cOnOtily3vLVpOhVnEDd512FfH4h2Q==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr3918767wrv.368.1606920310101;
        Wed, 02 Dec 2020 06:45:10 -0800 (PST)
Received: from gmail.com ([77.125.107.115])
        by smtp.gmail.com with ESMTPSA id f7sm2275412wmc.1.2020.12.02.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:45:09 -0800 (PST)
Date:   Wed, 2 Dec 2020 16:45:06 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS v3 soft mount semantics affected by commit ce368536d
Message-ID: <20201202144506.GA1257606@gmail.com>
References: <20201126104712.GA4023536@gmail.com>
 <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 26, 2020 at 01:48:23PM +0000, Trond Myklebust wrote:
> On Thu, 2020-11-26 at 12:47 +0200, Dan Aloni wrote:
> > Hi Scott, Trond,
> > 
> > Commit ce368536dd614452407dc31e2449eb84681a06af ("nfs:
> > nfs_file_write()
> > should check for writeback errors") seems to have affected NFS v3
> > soft
> > mount behavior, causing applications to fail on a slow band
> > connection
> > with a properly functioning server. I checked this with recent Linux
> > 5.10-rc5, and on 5.8.18 to where this commit is backported.
> > 
> > Question: while the NFS v4 protocol talks about a soft mount timeout
> > behavior at "RFC7530 section 3.1.1" (see reference and patchset
> > addressing it in [1]), is it valid to assume that a similar guarantee
> > for NFS v3 soft mounts is expected?
> > 
> > The reason why it is important, is because the fulfilment of this
> > guarantee seemed to have changed with this recent patch.
> > 
> > Details on reproduction - using the following mount option:
> > 
> >    
> > vers=3,rsize=1048576,wsize=1048576,soft,proto=tcp,timeo=50,retrans=16
> 
> Sorry, but those are completely silly timeo and retrans values for a
> TCP connection. I see no reason why we should try to support them.

The same issue is reproducible with a similar majortimeo effect, for
example timeo=400,retrans=1.

Now looking under `/sys/kernel/debug`, what I see is an accumulation of
RPC tasks that are ready to transmit, by the thousands, and so if the
outgoing throughput constraint is such that the amount of WRITE backlog
is bigger than what is possible to transmit in the time frame of the
majortimeo, the tasks end with EIO.  This may sound contrived, but it is
achievable with network interfaces of regular throughput, given enough
writers.

This was not the case prior to Linux v5.1, according to my observation -
with the older sunrpc implementation, these tasks would have waited
under 'reserved' state, not incurring a timeout calculation on them at
all, and the behavior was that tasks move to the transmit stage and
start counting down to a timeout only when there's write space on the
socket that allows to transmit them.

I looked around and saw that many vendors are recommending to change the
`sunrpc.tcp_max_slot_table_entries` sysctl to 128 down from 65536. This
has the effect that the transmit queue would be small instead of growing
to the tens of thousands of tasks, keeping the remaining tasks in the
backlog without failure. With the older SunRPC, the 65536 maximum did
not matter due to write space restriction, which 'naturally' did that.

And indeed, the lower setting is able to fix the issue I originally
addressed and help to retain the old behavior, where soft mount's goal
(at least in my case) is to detect EIOs that are stuck at the server
rather than at the client.

-- 
Dan Aloni
