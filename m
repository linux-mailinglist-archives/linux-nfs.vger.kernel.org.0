Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616E4B16E2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfIMA3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 20:29:47 -0400
Received: from fieldses.org ([173.255.197.46]:35374 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMA3r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 20:29:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B0B451B96; Thu, 12 Sep 2019 20:29:46 -0400 (EDT)
Date:   Thu, 12 Sep 2019 20:29:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 05/19] NFS: inter ssc open
Message-ID: <20190913002946.GC8069@fieldses.org>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
 <20190906194631.3216-6-olga.kornievskaia@gmail.com>
 <20190912202352.GB5054@fieldses.org>
 <CAN-5tyFsXNWxBi3m=32hiOLakjdV_w1tk15i6k_DrSqbLk5Kig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFsXNWxBi3m=32hiOLakjdV_w1tk15i6k_DrSqbLk5Kig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 12, 2019 at 06:51:58PM -0400, Olga Kornievskaia wrote:
> On Thu, Sep 12, 2019 at 4:23 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Fri, Sep 06, 2019 at 03:46:17PM -0400, Olga Kornievskaia wrote:
> > > +static int read_name_gen = 1;
> > > +#define SSC_READ_NAME_BODY "ssc_read_%d"
> > > +
> > ...
> > > +     res = ERR_PTR(-ENOMEM);
> > > +     len = strlen(SSC_READ_NAME_BODY) + 16;
> > > +     read_name = kzalloc(len, GFP_NOFS);
> > > +     if (read_name == NULL)
> > > +             goto out;
> > > +     snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
> > ...
> > > +     filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
> > > +                                  r_ino->i_fop);
> >
> > So, I"m curious: does this "name" ever get used anywhere?  Can you see
> > it from userspace somehow, for example?  Does it have some debugging
> > value?  Or could it just be the empty string?
> 
> Name isn't seen anywhere (nor is the mount visible to the use -- ie
> doing a mount command). It's needed to create a file structure to
> represent the file opened the source server (without the open).
> Honestly, I'm not sure what kind of weirdness can arise from having an
> empty name string.

I doubt the name matters.

> Is there a reason for not trying to generate unique
> names for this?

I doubt it's a problem, really, just a little unnecessary code.

--b.
