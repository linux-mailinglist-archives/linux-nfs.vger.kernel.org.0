Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2745524F0AC
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 02:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHXAN4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Aug 2020 20:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgHXANz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Aug 2020 20:13:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89233C061573
        for <linux-nfs@vger.kernel.org>; Sun, 23 Aug 2020 17:13:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h5so887253plt.6
        for <linux-nfs@vger.kernel.org>; Sun, 23 Aug 2020 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgnFF71VJevhB92FITk3eLeQoUu9R02pym+MioPantY=;
        b=U+CrLwntgsOBbYgQTD+OMpiHMouZWJmvO/nWslNeeIBPEppj8mCaSO5qyocLVxVBBO
         QRWvOyeC3C0g4c3nOFpDccQC3jK/WA9zXJNnaGtELTPthp+1r9TIrS7qJX7cG8Mv/eGJ
         WHLvw4EwNm1h/Sv29kzacmGRO6B8hvnSmpqhPSW2q0jFQR+XLTTkzG1eXrGOE7WHyL8o
         H+9kq1IdZHEwr22c3ADRuIGHBP70nOtw2a0TxpYhZ+bd9WOYj2Mc0xn2UGjF29GC/2qw
         1EYlaA43pXjPJDQcxhL8cOj1sb1wqn/FYJbmBGAmbBHXIa6p8F+3+wujCyCDJrJ80NiT
         9eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tgnFF71VJevhB92FITk3eLeQoUu9R02pym+MioPantY=;
        b=L3H6Y4ZfK2Z20Jf8gujClQlOjCqHssAOaZIbrCRbcidH8r7Fqh37tb7rB74ZSfnZlC
         zh0mJNGD+aAFqIov+FEIg/yk17BhqSeumOIWcF9p5Nf8saLE0dnYvd495VusEGnUJsM2
         3DbXfPkPeWFa94czyfjBewq8P+EN3kiih8WKOG/ip7c42urpHehRxMWYKMPmyYZztdL4
         fCuCkmPmFqM442dU8Jyzq0gWP0qLD5ZeE3cBX/uwnr42ZMoyxW0v8nDiqIOu5OblEvaf
         hijgkyC59PBwSz5cxZpdOxcc/GL5SVg9jmOWzvpgMK3IzOUkN9LcBxFU7JlSoSM0XIyK
         2uOg==
X-Gm-Message-State: AOAM533zTbzb2abV7RPjsjVJDgNITBlGwpqf3N8Gdi81+TXieEFLo5mr
        CTRmE/bZzP1fDQ+FV1iZzag=
X-Google-Smtp-Source: ABdhPJyPAMYH618kZqi7SIUA+W/I9bybVBp6wYwOImhf2lnFsolegQ2D4xWeuFty6WSy2I8e+X2aiA==
X-Received: by 2002:a17:902:6b41:: with SMTP id g1mr2099211plt.108.1598228033943;
        Sun, 23 Aug 2020 17:13:53 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o192sm9933388pfg.81.2020.08.23.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 17:13:53 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:13:45 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute
 handlers
Message-ID: <20200824001345.nszimqfcsumd4xil@xzhoux.usersys.redhat.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
 <20200623223904.31643-13-fllinden@amazon.com>
 <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
 <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <62aa76de0ea316c029b7f9c22cf36c92b8cba2d9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62aa76de0ea316c029b7f9c22cf36c92b8cba2d9.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 21, 2020 at 04:41:04PM +0000, Trond Myklebust wrote:
> On Fri, 2020-08-21 at 16:03 +0000, Frank van der Linden wrote:
> > On Fri, Aug 21, 2020 at 02:50:59PM +0800, Murphy Zhou wrote:
> > > Hi,
> > > 
> > > On Wed, Jun 24, 2020 at 6:51 AM Frank van der Linden
> > > <fllinden@amazon.com> wrote:
> > [...]
> > > >  static const struct inode_operations nfs4_dir_inode_operations =
> > > > {
> > > > @@ -10146,10 +10254,21 @@ static const struct xattr_handler
> > > > nfs4_xattr_nfs4_acl_handler = {
> > > >         .set    = nfs4_xattr_set_nfs4_acl,
> > > >  };
> > > > 
> > > > +#ifdef CONFIG_NFS_V4_2
> > > > +static const struct xattr_handler nfs4_xattr_nfs4_user_handler =
> > > > {
> > > > +       .prefix = XATTR_USER_PREFIX,
> > > > +       .get    = nfs4_xattr_get_nfs4_user,
> > > > +       .set    = nfs4_xattr_set_nfs4_user,
> > > > +};
> > > > +#endif
> > > > +
> > > 
> > > Any plan to support XATTR_TRUSTED_PREFIX ?
> > > 
> > > Thanks.
> > 
> > This is an implementation of RFC 8276, which explicitly restricts
> > itself
> > to the "user" namespace.
> > 
> > There is currently no portable way to implement the "trusted"
> > namespace
> > within the boundaries of the NFS specification(s), so it's not
> > supported.
> > 
> 
> Correct. 'trusted' is just another way to implement private protocols.
> Those are unacceptable in a shared filesystem environment.

Thank you guys explanation!

I'm asking because after NFSv4.2 xattr update, there are some xfstests
new failures about 'trusted' xattr. Now they can be surely marked as
expected.

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

-- 
Murphy
