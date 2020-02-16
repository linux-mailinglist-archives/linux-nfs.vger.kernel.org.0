Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A911602F1
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Feb 2020 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgBPI3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Feb 2020 03:29:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35755 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgBPI3A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Feb 2020 03:29:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so5511931plt.2;
        Sun, 16 Feb 2020 00:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BlKN0lbmeQWKOG1gIJO2s4beekRWPjVpLjSweEwD1wc=;
        b=AM/4LB0NCroGiIMoz6euoUaZtLFm3EkEG3Wp1XCjn/WWPVmWrLLAcif7jcsJIKiL+X
         EPlTSdVGDXnpcGP2DE6+U9102xKBBWkzzvxEn1FV33ks7S5p9NC5xsI2Q5zfO8cXCi6F
         iuAx01HNQjetwr5HS+uAcp20wjDxTTIAJFoqquHy3aqgI1PHZeJArgaJTKtTcfq/vTOP
         XnJHZqCPSSJx6CT8oTvr162aZZFc8hbi86N44lLJpUvs9oBWIKPu8vEIqWas5AEStI+4
         dc4ZRvvQSQUcxPEZ9LoNj3LvihS2VYqANEEkN9kRzDQKDotD4sbC+Jh7dUr4X1gqL1YA
         Fypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlKN0lbmeQWKOG1gIJO2s4beekRWPjVpLjSweEwD1wc=;
        b=mVPV4BizoJ4nvfV1fZN7HEQIi6JDtZkpNW4lYNC4il40VKGpGAxXc+1O6oZlj+/QJx
         qAwECEJzb57DN3nGbRmKqzn5qBnljtuDutjQ/Y1mMy/n0XXBNB+dFnm2ltJezvpUk173
         v92WwTFM5ugO04oOBHWxA/kF5eljfXEbhvaJ19JoIes59gmpWmjxvUmNPqudawCXdlGw
         jTtjZ5+yRIRYHb9iEUbdI6bppTMxfSBVvFFaKIbZVmV/iAijOOsj/T/un9JjDh9H09uZ
         YZFQdoVN8AY/AU6Iw0wqnxtvv5vJFXkcQhg6cguJSxnAb074HH2f2Q7UY9vxRfz6Wr2J
         1irg==
X-Gm-Message-State: APjAAAWHVi7e0Gj4qlj9yKIj22w+n8a5XoMsrc5tueiL5EJZyohKhCCa
        d4ub/CS+s+dTuQkWS8hp8nQ=
X-Google-Smtp-Source: APXvYqzrjL3Vs2u5crY/tpbI8HFpM8FrlxXaBaWkOcFjwICrR+01dmsDBGAzw01lz3H63G1RkJlHhw==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr11228684plo.282.1581841740113;
        Sun, 16 Feb 2020 00:29:00 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t11sm12373014pjo.21.2020.02.16.00.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 00:28:59 -0800 (PST)
Date:   Sun, 16 Feb 2020 16:28:51 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200216082851.h2y6bs3h4dvpqyvv@xzhoux.usersys.redhat.com>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
 <20200124011019.GA8247@magnolia>
 <20200127223631.GA28982@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127223631.GA28982@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Mon, Jan 27, 2020 at 05:36:31PM -0500, J. Bruce Fields wrote:
> On Thu, Jan 23, 2020 at 05:10:19PM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> > > Hi,
> > > 
> > > Deleting the files left by generic/175 costs too much time when testing
> > > on NFSv4.2 exporting xfs with rmapbt=1.
> > > 
> > > "./check -nfs generic/175 generic/176" should reproduce it.
> > > 
> > > My test bed is a 16c8G vm.
> > 
> > What kind of storage?
> > 
> > > NFSv4.2  rmapbt=1   24h+
> > 
> > <URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
> > transactions on the inactivation?  (speculates wildly at the end of the
> > workday)
> > 
> > I'll have a look in the morning.  It might take me a while to remember
> > how to set up NFS42 :)
> 
> It may just be the default on a recent enough distro.
> 
> Though I'd be a little surprised if this behavior is specific to the
> protocol version.

Can NFS client or server know the file has reflinked part ? Is there
any thing like a flag or a bit tracking this?

Thanks!
Murphy
> 
> nfsd_unlink() is basically just vfs_unlink() followed by
> commit_metadata().
> 
> --b.
> 
> > 
> > --D
> > 
> > > NFSv4.2  rmapbt=0   1h-2h
> > > xfs      rmapbt=1   10m+
> > > 
> > > At first I thought it hung, turns out it was just slow when deleting
> > > 2 massive reflined files.
> > > 
> > > It's reproducible using latest Linus tree, and Darrick's deferred-inactivation
> > > branch. Run latest for-next branch xfsprogs.
> > > 
> > > I'm not sure it's something wrong, just sharing with you guys. I don't
> > > remember I have identified this as a regression. It should be there for
> > > a long time.
> > > 
> > > Sending to xfs and nfs because it looks like all related. :)
> > > 
> > > This almost gets lost in my list. Not much information recorded, some
> > > trace-cmd outputs for your info. It's easy to reproduce. If it's
> > > interesting to you and need any info, feel free to ask.
> > > 
> > > Thanks,
> > > 
> > > 
> > > 7)   0.279 us    |  xfs_btree_get_block [xfs]();
> > > 7)   0.303 us    |  xfs_btree_rec_offset [xfs]();
> > > 7)   0.301 us    |  xfs_rmapbt_init_high_key_from_rec [xfs]();
> > > 7)   0.356 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > > 7)   0.305 us    |  xfs_rmapbt_init_key_from_rec [xfs]();
> > > 7)   0.306 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> > > 7)               |  xfs_rmap_query_range_helper [xfs]() {
> > > 7)   0.279 us    |    xfs_rmap_btrec_to_irec [xfs]();
> > > 7)               |    xfs_rmap_lookup_le_range_helper [xfs]() {
> > > 1)   0.786 us    |  _raw_spin_lock_irqsave();
> > > 7)               |      /* xfs_rmap_lookup_le_range_candidate: dev 8:34 agno 2 agbno 6416 len 256 owner 67160161 offset 99284480 flags 0x0 */
> > > 7)   0.506 us    |    }
> > > 7)   1.680 us    |  }
