Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37291F1D08
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgFHQPZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 12:15:25 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:36573 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 12:15:25 -0400
Received: by mail-ej1-f67.google.com with SMTP id n21so4544971ejg.3
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jun 2020 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dwbdf9xhZeSDjW8PP0hFq6IWoGVDbX6xkDn7XpyolQ=;
        b=TwC+gLQhohnMAt8XmQwcMT1PeqrFLW/VWJEZQCNFwC8BJuprwGXAu+Q60DaZHqW2b2
         rHWAIIkFx4cG3V6lWWNWaqRgjdePmzNPLHd98dqWLS5HM+Didp0zN6noUcy0OHyNIQNl
         2SUWz8Drf7NBTINOHsRyGtxET4yW2DjYRts91fRD5LnaTq/5eqNjMg2y8eO4vHuVe10r
         tHZQI1gTWqasv4k2ADUUnSsZiBH2vAA9I3YE1Slws3AknlRIy3b1mR++6hrqOdz7bNA5
         H8EN9/rH3RbHeHv3bWONQwpfK5eXuLeZJEabtCV9I+gstFHJARUPYSwjvU7q0SobBD68
         vxhA==
X-Gm-Message-State: AOAM533NMunu7c5YQrXhHIhoHDcCHxxfEF+L2i2SxZrqODjYU6sekHcH
        2qlupHq4Kv5E4o8CmHJuLKDKq2h87S98sW6G01PNuUKj
X-Google-Smtp-Source: ABdhPJwg7Na4PovGqHbqJPyqKFAoy5KXpPV12jfXqXLFEvDamZEhzTNsiQx+KgW8QoEhw155RfHmE3i9vyTkyKPNZMw=
X-Received: by 2002:a17:906:b207:: with SMTP id p7mr20969257ejz.23.1591632922848;
 Mon, 08 Jun 2020 09:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200325231051.31652-1-fllinden@amazon.com> <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de>
 <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <2042449942.8269597.1585295495366.JavaMail.zimbra@desy.de>
 <v2aze7-yqvuvfuc4i30-1xxisr-dr39sbpkxym7-2nbcltx37gs3ezoql-qoc5f45hvih45iurdv-lqtdu9ppbm6i-upakk-2awl3v-em4ktl4ip5gchvuicg-vgnve1-wbqe5p-fw96bj-ct2sjj-wlbpk7.1586002736523@email.android.com>
 <1684380491.969626.1591631520724.JavaMail.zimbra@desy.de>
In-Reply-To: <1684380491.969626.1591631520724.JavaMail.zimbra@desy.de>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 8 Jun 2020 12:15:06 -0400
Message-ID: <CAFX2JfkeJ=rqLkt6ce2GsLqmEx2H738skH9GUwVtRPCEyTfo9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Frank van der Linden <fllinden@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tigran,


On Mon, Jun 8, 2020 at 11:59 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
>
> Dear maintainers,
>
> are those changes considered for 5.8?

My understanding is that these patches will be targeting 5.9.

Anna
>
> Thanks,
>    Tigran.
>
> ----- Original Message -----
> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> > To: "Frank van der Linden" <fllinden@amazon.com>
> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker" <anna.schumaker@netapp.com>, "Trond Myklebust"
> > <trond.myklebust@hammerspace.com>
> > Sent: Saturday, April 4, 2020 2:18:54 PM
> > Subject: Re:[PATCH v2 00/13] NFS client user xattr (RFC8276) support
>
> > After adding 'minimal' 4.2 implementation to our server, the patchset works as
> > expected.
> > Thanks, Tigran.
> >
> > -------- Original message --------
> > From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
> > Date: Fri, Mar 27, 2020, 08:51
> > To: Frank van der Linden <fllinden@amazon.com>
> > Cc: linux-nfs <linux-nfs@vger.kernel.org>, Anna Schumaker
> > <anna.schumaker@netapp.com>, Trond Myklebust <trond.myklebust@hammerspace.com>
> > Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
> >
> >
> > ----- Original Message -----
> >> From: "Frank van der Linden" <fllinden@amazon.com>
> >> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> >> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker"
> >> <anna.schumaker@netapp.com>, "Trond Myklebust"
> >> <trond.myklebust@hammerspace.com>
> >> Sent: Friday, March 27, 2020 12:16:02 AM
> >> Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
> >
> >> On Thu, Mar 26, 2020 at 08:03:13PM +0100, Mkrtchyan, Tigran wrote:
> >>> The new patchset looks broken to me.
> >>>
> >>> Client quiryes for supported attributes and gets xattr_support bit set:
> >>>
> >>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_supported:
> >>> bitmask=fcffbfff:40fdbe3e:00040800
> >>>
> >>> However, the attribute never queries, but client makes is decision:
> >>>
> >>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_xattrsupport: XATTR
> >>> support=false
> >>>
> >>> The packets can be found here: https://sas.desy.de/index.php/s/GEPiBxPg3eR4aGA
> >>>
> >>> Can you provide packets of your mount/umount round.
> >>
> >> Hi Tigran,
> >>
> >> I looked at your packet dump. It seems like your server only supports 4.1,
> >> not 4.2. xattr support builds on 4.2 (within the rules laid out in
> >> RFC 8178).
> >
> > That's right, this is what rfc8276 says:
> >
> >   Note that the XDR code contained in this document depends on types
> >   from the NFSv4.2 nfs4_prot.x file [RFC7863].  This includes both nfs
> >   types that end with a 4, such as nfs_cookie4, count4, etc., as well
> >   as more-generic types, such as opaque and bool.
> >
> > However, xattr support doesn't relays on any functionality provided by v4.2.
> > Moreover,
> > all used data structures (nfs_cookie4, component4, change_info4) defined in
> > nfsv4.0.
> > Thus there are no reasons why even v4.0 server can't support xattrs.
> >
> >>
> >> So, the fsinfo client call, which is just a GETATTR, masks out the 4.2
> >> fattr bits from server->attr_mask, and just uses the 4.1 bits. Meaning that
> >> xattr_support is not included, and defaults to false.
> >
> > I was expecting something like this, but was unable to find the place where this
> > masking is happening.
> >
> > Tigran.
> >
> >>
> >> The packet dump also indicates that your server advertises the xattr_support
> >> fattr as supported, even though it's in a 4.1 session, which would not
> >> be correct.
> >>
> > > - Frank
