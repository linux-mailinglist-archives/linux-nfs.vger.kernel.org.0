Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8532C12E0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbgKWSFf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388704AbgKWSFf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:05:35 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B43C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 10:05:35 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so18038090edq.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cckI8TzzI9h0pCxlvdtQ9ZkM+PSEdfqZ2zz4bNJ07Kc=;
        b=qzeVD8DpCvVo6qZK3u6vfQ6LORjyzPJxLmvg0q0Og7+63Cq2z4THMzkYBz1vPxLXmG
         pRPi60TWkjhyU9N6cIBQY2Y3FXb+cGzfj7GkQcEHN0h8+OzIo/IBIe7XnQzimPrBf+9C
         qAgOiiAR52JrR3y+Y7BK7IXyL/+53KKZNphVFhdJCOpKZc++yqSfS9/UOIzHRFQMtvxa
         MO2fsRq3j8IU0RyB8veWC5SChpShUf1M9YPmFEnwjg1q6gLc3VtMxVfjpAPnp5aJBbby
         t0RhzC0rj+fhI1xPuKRULLUJ99YFR4fL5YS3UlGrUx1diPDYwoAHEEtcHEhBNWHMURtH
         Eg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cckI8TzzI9h0pCxlvdtQ9ZkM+PSEdfqZ2zz4bNJ07Kc=;
        b=DaS0F0Mkcl629XiEKHE66mrhw0NT11oIbpkwfi0Fpy4U5/2D65upiSBrL0SCX9i2US
         y0HQ4OpCa6Ov31Mg4RS6PyH7CrxaWUAHalJ9XbwZAseM3doRbO3EzqBSj8p/uIsgC6cA
         yGeeU1I4GFoXRaLbt3DdjQEzWwOCTrUQbd3ZFtHs7BGCFVxmMeFmx7FZx7GwNbDVJ0bs
         57XBfKdITR5wjC2hRX/YUiXbMTkloDSj8ruZyz+f5bRRyZXbEoLBTRcjSvLMJ+YoXQmo
         QckNr/szU2dHe/N4GfBRksQgawau6kUZnX3n8fE3x8BqxKiDiLq03D+7W7l/BftP47r5
         W2oQ==
X-Gm-Message-State: AOAM531cHsJc2yxqRAOtrFdkqMH/Y7BLNTDV9WdGSFA2mpGd+eaP+BEM
        nvElx+RT64ejiPOq8UWIVCGWlwKkZPRBSs5Yb/E=
X-Google-Smtp-Source: ABdhPJylj7191J0un8QnDWW0Roa9Id4LaadTSaAA/bgSG9C32zJ657qJo04ntH0R+DJbrGX5RcS0SlCwBSzcF0+FGeI=
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr340943edb.267.1606154734055;
 Mon, 23 Nov 2020 10:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com> <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com> <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com> <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 23 Nov 2020 13:05:22 -0500
Message-ID: <CAN-5tyGBRiNoGV29_4u2-rNNoJ45D2EOArfEvdaOtMg32ScsTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 12:42 PM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> On Mon, Nov 23, 2020 at 11:42:46AM -0500, Olga Kornievskaia wrote:
> > Hi Frank, Chuck,
> >
> > I would like your option on how LISTXATTR is supposed to work over
> > RDMA. Here's my current understanding of why the listxattr is not
> > working over the RDMA.
> >
> > This happens when the listxattr is called with a very small buffer
> > size which RDMA wants to send an inline request. I really dont
> > understand why, Chuck, you are not seeing any problems with hardware
> > as far as I can tell it would have the same problem because the inline
> > threshold size would still make this size inline.
> > rcprdma_inline_fixup() is trying to write to pages that don't exist.
> >
> > When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> > will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> > TCP. RDMA doesn't have anything like that.
> >
> > Question: Should there be code added to RDMA that will do something
> > similar when it sees that flag set? Or, should LISTXATTR be re-written
> > to be like READDIR which allocates pages before calling the code.
>
> Hm.. so if the flag never worked for RDMA, was NFS_V3_ACL ever tested
> over RDMA? That's the only other user.

It could have worked depending on whether or not ACL ever were sent
inline.  As I said LISTXATTR works when userspace provides a large
buffer because that triggers the RDMA code to setup a reply chunk
which allocated memory. So it's very specific case.

It might have worked for ACL because the way ACL works (at least now)
is that it's called first with a large buffer size, then client code
actually caches the reply so when teh user space calls it again with
appropriate buffer size, the code doesn't do another request.
LISTXATTR doesn't have that optimization and it does another call.
This way it uses a inline RDMA message which doesnt not work for when
pages are not allocated as far as I can tell.

> If the flag simply doesn't work, I agree that it should either be fixed
> or just removed.
>
> It wouldn't be the end of the world to change LISTXATTRS (and GETXATTR)
> to use preallocated pages. But, I didn't do that because I didn't want to
> waste the max size (64k) every time, even though you usually just get
> a few hundred bytes at most. So it seems like fixing XDRBUF_SPARSE_PAGES
> is cleaner.
>
> - Frank
