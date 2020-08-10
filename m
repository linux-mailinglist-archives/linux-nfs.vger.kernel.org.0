Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23CD240B98
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHJRGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 13:06:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728053AbgHJRGc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 13:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597079190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG1UX7UvzyL+s17qjFjJT/RaH5grYgUy2tkao7iejMk=;
        b=gXSEszn4R5yaE8Xi18eY28IJzTmzzo+mu7WpxUaGkNAcwTPdRIbitQGScLWhfbEY+yBVh8
        bF/b235hZWziI0RSayhRF9QqQM6/tu7Y1gqh5JpjOC1BeeW4HGjuXfZqZqJt2U1yafpQu7
        Dm/9XYxnG7S3ERO+V4v73q3rGs3QOic=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-hw8n6PypMZWCrY5hB-H1jw-1; Mon, 10 Aug 2020 13:06:28 -0400
X-MC-Unique: hw8n6PypMZWCrY5hB-H1jw-1
Received: by mail-qv1-f72.google.com with SMTP id y30so7691810qvy.9
        for <linux-nfs@vger.kernel.org>; Mon, 10 Aug 2020 10:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bG1UX7UvzyL+s17qjFjJT/RaH5grYgUy2tkao7iejMk=;
        b=hFhwOrXkzGz1Cp/ze2xeoE30qu3h+CAW0NFB5IuX+80D2h6EN2UrImBiX5G93ILvnK
         De0mfVj4iNp+0TIzgvxY3A3XntlnmDHq1F7CKJcOGpdo8/ij/q6tBu4QtM98lZp9S6Bp
         +BQznSJ9mpxn3MooxICYVPN9igRstmX42KXAuNu5mg5jdSVLPUc77eKAV983MB4lSWwY
         wIkhlB/BNhRwjrww2yRqwX2sYCPNJozZJTr+NhliKYX9gPRyEFx9fvJBWWFdajmjrxjX
         BjfyBElft6YuXPHYLq4p3OUbqkizN3BEQmw1rtGF/Oc+JzTzsSoFUVjC6ej+4lU0XIRK
         CWCw==
X-Gm-Message-State: AOAM531jc8wbQYud8ab8M5vJZMOO2VL7JNcwrjmq425OMgyk7FWi1FYj
        sU2hTrexzzyv8B0ko/a2rbnERoM7MzIL2uLRm2ig3EoQie2DrFvvluCynHo4NpHQFyWVaBVPe/X
        ZEhDwTZ8ju3QDpeIxJIZR
X-Received: by 2002:ac8:4117:: with SMTP id q23mr29005611qtl.186.1597079188355;
        Mon, 10 Aug 2020 10:06:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlWfqS29REyKPSWZucycGqedyBlydewM4zc1ic5w6qlLsuinsxlRcAI6mVIAmH2h++AmLqgw==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr29005574qtl.186.1597079188107;
        Mon, 10 Aug 2020 10:06:28 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id l1sm15922877qtp.96.2020.08.10.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:06:27 -0700 (PDT)
Message-ID: <fecc577d696f9cd58bbb2fae437c8acea170f7bf.camel@redhat.com>
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
From:   Jeff Layton <jlayton@redhat.com>
To:     David Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Aug 2020 13:06:26 -0400
In-Reply-To: <CALF+zO=DkGmNDrrr-WxU6L1Xw8MA4+NrqVbvNMctwSKjy0Yh_w@mail.gmail.com>
References: <447452.1596109876@warthog.procyon.org.uk>
         <1851200.1596472222@warthog.procyon.org.uk>
         <667820.1597072619@warthog.procyon.org.uk>
         <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
         <672169.1597074488@warthog.procyon.org.uk>
         <CALF+zO=DkGmNDrrr-WxU6L1Xw8MA4+NrqVbvNMctwSKjy0Yh_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-08-10 at 12:35 -0400, David Wysochanski wrote:
> On Mon, Aug 10, 2020 at 11:48 AM David Howells <dhowells@redhat.com> wrote:
> > Steve French <smfrench@gmail.com> wrote:
> > 
> > > cifs.ko also can set rsize quite small (even 1K for example, although
> > > that will be more than 10x slower than the default 4MB so hopefully no
> > > one is crazy enough to do that).
> > 
> > You can set rsize < PAGE_SIZE?
> > 
> > > I can't imagine an SMB3 server negotiating an rsize or wsize smaller than
> > > 64K in today's world (and typical is 1MB to 8MB) but the user can specify a
> > > much smaller rsize on mount.  If 64K is an adequate minimum, we could change
> > > the cifs mount option parsing to require a certain minimum rsize if fscache
> > > is selected.
> > 
> > I've borrowed the 256K granule size used by various AFS implementations for
> > the moment.  A 512-byte xattr can thus hold a bitmap covering 1G of file
> > space.
> > 
> > 
> 
> Is it possible to make the granule size configurable, then reject a
> registration if the size is too small or not a power of 2?  Then a
> netfs using the API could try to set equal to rsize, and then error
> out with a message if the registration was rejected.
> 

...or maybe we should just make fscache incompatible with an
rsize that isn't an even multiple of 256k? You need to set mount options
for both, typically, so it would be fairly trivial to check this at
mount time, I'd think.

-- 
Jeff Layton <jlayton@redhat.com>

