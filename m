Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3F37BB00
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhELKnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhELKnU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 06:43:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77101C061574
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 03:42:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q5so3646076wrs.4
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVvT8RTzkDnnAIo+4AvRe8g9Eh31pg8AaWx5GA46yNk=;
        b=iyB2xs4lYOyFFLp/49VViG1JMCUrECmhOukwy0V7g1O9fv8KOpE29yZ60hEbHSElnE
         PEeay8l2F2/8F6zateIOegTrAgC1g4K4+BfDKPICyBwiIbj58RD9gAnafQK2gGCBujAL
         sjHdPsmwYvY7bFmZUAztunW4eXSHQwakn06WNhsGfQuyXtYlS5svdc57ehaxwFLN9Ae5
         8uhzMKa0NB58brzFgSoEn5jgB+lTpXxoOIi2Y0/nLcNnk8oOK2yNUqShrJpQlvR7EX03
         +kuwjtE/LDK4nUBp5Ge7dKcuwqRM20OOK5hNHGuZ5BZWUWeZQ46YHcySAdTn5jnyguMz
         +2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVvT8RTzkDnnAIo+4AvRe8g9Eh31pg8AaWx5GA46yNk=;
        b=lMTAkG7eOGgqmHg4Nx7GJUH7j6AP8XCjQSrwgKJCOUDks8rAR13IC5/UKGO13fAvd/
         nEmC2JguPZbTSWmr2FCIRvhmvgbZjohvTtcjWvbO6O2c8NkHQ1YKCk3yjhUeE6fpEPpy
         PjDDj0YnRXAtGdtmaDbeTpFCFwKKYdD6FrwBfVhkxHtQE6DKAM18fC+MHUhCEjN99xbk
         28r7XAZToTY2k41bt+VvcMV0LTJrT+0W7dxzYyBSDCzpOjtfyFmMjR6hmetEioCdXE8s
         phncTEsGg9HN/unfOz9hPFadkohAzdeRUJs/znwIZNhMubQ/H4lhQi3hOFDsHLa7QNTo
         O3RQ==
X-Gm-Message-State: AOAM533B6j9f/foRzzq4aIl5W8jRjr/ktbwi98Q1sfqil1Z2VdBHgm/V
        KeutMNbOxoEoBcpjpZgXMpbQlQ==
X-Google-Smtp-Source: ABdhPJwQn+U9Zrzb1/9uyR2hV7okh1bQxQFFcd5XRcDD0pQdysotGNgRcs/wkncgtsnockfKIvYT7A==
X-Received: by 2002:adf:cd01:: with SMTP id w1mr44461826wrm.425.1620816129149;
        Wed, 12 May 2021 03:42:09 -0700 (PDT)
Received: from gmail.com ([77.124.118.36])
        by smtp.gmail.com with ESMTPSA id y5sm28578822wrm.61.2021.05.12.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:42:08 -0700 (PDT)
Date:   Wed, 12 May 2021 13:42:05 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Message-ID: <20210512104205.hblxgfiagbod6pis@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
 <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 27, 2021 at 08:12:53AM -0400, Olga Kornievskaia wrote:
> On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
> >
> > On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > An rpc client uses a transport switch and one ore more transports
> > > associated with that switch. Since transports are shared among
> > > rpc clients, create a symlink into the xprt_switch directory
> > > instead of duplicating entries under each rpc client.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > >
> > >..
> > > @@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
> > >       struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
> > >
> > >       if (rpc_client) {
> > > +             char name[23];
> > > +
> > > +             snprintf(name, sizeof(name), "switch-%d",
> > > +                      rpc_client->xprt_switch->xps_id);
> > > +             sysfs_remove_link(&rpc_client->kobject, name);
> >
> > Hi Olga,
> >
> > If a client can use a single switch, shouldn't the name of the symlink
> > be just "switch"? This is to be consistent with other symlinks in
> > `sysfs` such as the ones in block layer, for example in my
> > `/sys/block/sda`:
> >
> >     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
> >     device -> ../../../5:0:0:0
> 
> I think the client is written so that in the future it might have more
> than one switch?

I wonder what would be the use for that, as a switch is already collection of
xprts. Which would determine the switch to use per a new task IO?

-- 
Dan Aloni
