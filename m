Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D932D21F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 13:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhCDL7N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 06:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbhCDL6u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 06:58:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6EC061756
        for <linux-nfs@vger.kernel.org>; Thu,  4 Mar 2021 03:58:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so28757632ejb.5
        for <linux-nfs@vger.kernel.org>; Thu, 04 Mar 2021 03:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wz8blI5X/mdLoe+6RR9OBaMVX3ZF+8PLlcTD3L8p2oI=;
        b=MqB6H8/lqDqw3jw1NfTT+JkONIVEOLSK09V9qxSOq7FQ5VIo7iK9FhnIYrKQEmZQdD
         zt0yjqJHmI87NYtoK3vWe0jVQ1fzlHNxDvWmeDFzGV0fLiuGphfPbCOKwmidevulMw6Y
         HZN0Icw+wbrqHjEoyma3uE07w0u+2LNMm4W2Kn6KX/Y8H/qoaEiZcB/KHgtwVXlcw1Z/
         CseL1lzTiuV8XbRezShVb3D5I46tYauxM4FNBL0kwBTStCf/T/zjMXZZvfzWvAcwMk/e
         IJO1SjzvrG1PAY8VXAVIQwLRM9olm7U8GXqwU5cdJM1yuwf+lVw7TJB8wLF5oJy0f5ok
         EY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wz8blI5X/mdLoe+6RR9OBaMVX3ZF+8PLlcTD3L8p2oI=;
        b=icAEpYzjcgp/8wNFOlK392TYY6T1a8LoEB3rh2m36jbIsU+ep8ylkSZMrzgL9B4Yeo
         tCHVFZ2b8RQXUUcVJWYeLskL3LwYtSuKgTpXKKjK+mC0TCVZ4LfZfPrGMuOhxwhqXrZB
         am903d+8ay2cBku3KO3klmPu/qMP6fX8XAr/IymRMZzTueBSSF+ShOoH23lZlZt+on3p
         JQtYCaB/UK8ob1yFeLCCqInxo0Joc6vrdKgaIf9h7Otgaqq5OLaouI29V/RAHx25idrg
         9zVhWFksAVpTnMNy0p8skF+eHCXY1K6GmPgnpf881yZL+MAIt+V6CrpIRj4hInDakqhp
         caqQ==
X-Gm-Message-State: AOAM530zzzL+ANijrtsPC9QxlEoqNLfbKUZSn8LjhSOfpqudC52Pquun
        gO7CrgSj+54hTwqOyJZvL+kDemaM0YtUZg==
X-Google-Smtp-Source: ABdhPJxrZRSG7GnKgdgXmUt0RNKDWCzs/dYOFFNEmfy5EtfUNC21hrXeKlKRsRjTdyW7X+8F5+HRJw==
X-Received: by 2002:a17:906:3685:: with SMTP id a5mr3962786ejc.352.1614859089242;
        Thu, 04 Mar 2021 03:58:09 -0800 (PST)
Received: from gmail.com ([77.126.34.224])
        by smtp.gmail.com with ESMTPSA id f21sm9831062ejw.124.2021.03.04.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 03:58:08 -0800 (PST)
Date:   Thu, 4 Mar 2021 13:58:06 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v1 0/8] sysfs files for multipath transport control
Message-ID: <20210304115806.rvoeju7gmqyd3v6i@gmail.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
 <CAN-5tyGw3D-+emeQhu31agom9yuZ9=PL6YUVyEKiR-n2q9uE3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGw3D-+emeQhu31agom9yuZ9=PL6YUVyEKiR-n2q9uE3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 01, 2021 at 10:56:22PM -0500, Olga Kornievskaia wrote:
> Hi Dan,
> 
> On Mon, Feb 15, 2021 at 12:43 PM Dan Aloni <dan@kernelim.com> wrote:
> >
> > Hi Anna,
> >
> > This patchset builds ontop v2 of your 'sysfs files for changing IP' changeset.
> >
> > - The patchset adds two more sysfs objects, for one for transport and another
> >   for multipath.
> > - Also, `net` renamed to `client`, and `client` now has symlink to its principal
> >   transport. A client also has a symlink to its `multipath` object.
> > - The transport interface lets you change `dstaddr` of individual transports,
> >   when `nconnect` is used (or if it wasn't used and these were added with the
> >   new interface).
> > - The interface to add a transport is using a single string written to 'add',
> >   for example:
> >
> >        echo 'dstaddr 192.168.40.8 kind rdma' \
> >                > /sys/kernel/sunrpc/client/0/multipath/add
> >
> > These changes are independent of the method used to obtain a sunrpc ID for a
> > mountpoint. For that I've sent a concept patch showing an fspick-based
> > implementation: https://marc.info/?l=linux-nfs&m=161332454821849&w=4
> 
> I'm confused: does this allow adding arbitrary connections between a
> client and some server IP to an existing RPC client? Given the above
> description, that's how it reads to me, can you clarify please. I
> thought it was something specifically for v3 (because it has no
> concept of trunking). As for NFSv4 there is a notion of getting server
> locations via FS_LOCATION and doing trunking (ie multipathing)? I
> don't see how this code restricts the addition of transports to v3.

Indeed, there's no restriction to NFSv3.

There can be potential uses for this for NFSv4 too. FS_LOCATIONS serving
as recommendation to which hosts the client can connect, while smart
load-balancing logic in userspace can determine to which subset of these
servers each client in a cluster should actually connect (a full mesh
is not always desired).

At any case, if this restriction is desired, we can add a new sunrpc
client flag for that and pass it only in NFSv3 client init.

-- 
Dan Aloni
