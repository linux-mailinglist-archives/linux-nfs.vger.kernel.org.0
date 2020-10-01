Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE422809FB
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgJAW0m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgJAW0m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601591200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBavI7QrAmXrUDv3PWhGNtxE4Hf6qDRfQO3shK0cBMw=;
        b=Dvu9jgYC8yWceEfRSDaRqyFQYdd5Av+Zcc2uO2MdUDErlxB9YUOfdTEou5wt6+Z1wzfNeo
        LrgHEserMq9LJLj49+0HzmuLD0nRnSTeJ4T9ySdA8dOqZ+JGPH0592fWslXrTgqZauJsVR
        OTGFfS4GI3KTuL9e/6SVFSA1TdKknKM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Xb7LvHPrPDOLF6NK6yeikA-1; Thu, 01 Oct 2020 18:26:38 -0400
X-MC-Unique: Xb7LvHPrPDOLF6NK6yeikA-1
Received: by mail-ej1-f69.google.com with SMTP id c20so68766ejs.12
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBavI7QrAmXrUDv3PWhGNtxE4Hf6qDRfQO3shK0cBMw=;
        b=KNsjW6rIa0EnLVxfHGEcXkPQX8cIs0HWiykc9Gt4eAVEZFZqdbrK4mbpwlVOQzpukz
         Qwk+DnfdZpol0OT0jEFytKMNr0flbrvjw+fHoUH4KzRAhuDkRH7g3A3yKwH/6SWV3Dul
         4YhmRGTqCdVhUZTFr19l/Y1FdmxZDHRjCH02lRxpG30G/IpuvyoQXKSbG99emKZG8dDi
         4IeUj+nCXtTrDbJ/LQBuMrxiJW1GEYeK8VDKV2emlLCKwy2mJAPhUZxTkAm+jmDl7EvH
         ulQKzODUlMqjAiXTAI3aYZBuk993d/b4TYOop0LJ56YAtE7ttQgmolgDR6P0O6Y/lB3Y
         yi+w==
X-Gm-Message-State: AOAM530oTWRSIG27njOPw/gniix85Xkn0V4u1s/pRuzu1uhC/bXLUl56
        v/AZQn6OQ8HeOlHoAVuSevPO4oOvenUtt+H3dUpQM9GKokMViYdCcAomJol3F38BGmmBSnfLYYT
        vpDE3i4Cq0DeLY6qDMUo0SXrsE0RpxYhEnSR6
X-Received: by 2002:a50:b063:: with SMTP id i90mr10872444edd.187.1601591197116;
        Thu, 01 Oct 2020 15:26:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Olrt7P5e2vHF/iZQc2dJnlxZU2fZj+ONwTX/yiq+MYhQKeJH3xrceVAdx/taXoVUZHy5bZfKNIw5vSKraPM=
X-Received: by 2002:a50:b063:: with SMTP id i90mr10872431edd.187.1601591196911;
 Thu, 01 Oct 2020 15:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200608211945.GB30639@fieldses.org> <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org> <20201001214749.GK1496@fieldses.org>
In-Reply-To: <20201001214749.GK1496@fieldses.org>
From:   Matt Benjamin <mbenjami@redhat.com>
Date:   Thu, 1 Oct 2020 18:26:25 -0400
Message-ID: <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
Subject: Re: client caching and locks
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

I'm not sure.  My understanding has been that, NFSv4 does not mandate
a mechanism to update clients of changes outside of any locked range.
In AFS (and I think DCE DFS?) this role is played by DataVersion.  If
I recall correctly, David Noveck provided an errata that addresses
this, that servers could use in a similar manner to DV, but I don't
recall the details.

Matt

On Thu, Oct 1, 2020 at 5:48 PM bfields@fieldses.org
<bfields@fieldses.org> wrote:
>
> On Mon, Jun 22, 2020 at 09:52:22AM -0400, bfields@fieldses.org wrote:
> > On Thu, Jun 18, 2020 at 04:09:05PM -0400, bfields@fieldses.org wrote:
> > > I probably don't understand the algorithm (in particular, how it
> > > revalidates caches after a write).
> > >
> > > How does it avoid a race like this?:
> > >
> > > Start with a file whose data is all 0's and change attribute x:
> > >
> > >         client 0                        client 1
> > >         --------                        --------
> > >         take write lock on byte 0
> > >                                         take write lock on byte 1
> > >         write 1 to offset 0
> > >           change attribute now x+1
> > >                                         write 1 to offset 1
> > >                                           change attribute now x+2
> > >         getattr returns x+2
> > >                                         getattr returns x+2
> > >         unlock
> > >                                         unlock
> > >
> > >         take readlock on byte 1
> > >
> > > At this point a getattr will return change attribute x+2, the same as
> > > was returned after client 0's write.  Does that mean client 0 assumes
> > > the file data is unchanged since its last write?
> >
> > Basically: write-locking less than the whole range doesn't prevent
> > concurrent writes outside that range.  And the change attribute gives us
> > no way to identify whether concurrent writes have happened.  (At least,
> > not without NFS4_CHANGE_TYPE_IS_VERSION_COUNTER.)
> >
> > So as far as I can tell, a client implementation has no reliable way to
> > revalidate its cache outside the write-locked area--instead it needs to
> > just throw out that part of the cache.
>
> Does my description of that race make sense?
>
> --b.
>


-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309

