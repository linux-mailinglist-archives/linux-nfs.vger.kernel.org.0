Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E06B0FA8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfILNN7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 09:13:59 -0400
Received: from fieldses.org ([173.255.197.46]:34772 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILNN7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:13:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4E3DB1C8C; Thu, 12 Sep 2019 09:13:59 -0400 (EDT)
Date:   Thu, 12 Sep 2019 09:13:59 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, chuck.lever@oracle.com,
        tibbs@math.uh.edu, linux@stwm.de, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, km@cm4all.com
Subject: Re: Regression in 5.1.20: Reading long directory fails
Message-ID: <20190912131359.GB31879@fieldses.org>
References: <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
 <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
 <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
 <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
 <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
 <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
 <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
 <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 12, 2019 at 09:08:51AM -0400, Benjamin Coddington wrote:
> 
> On 12 Sep 2019, at 8:53, Trond Myklebust wrote:
> > Let's please just scrap this function and rewrite it as a generic
> > function for reading the MIC. It clearly is not a generic function for
> > reading arbitrary netobjs, and modifications like the above just make
> > the misnomer painfully obvious.
> >
> > Let's rewrite it as xdr_buf_read_mic() so that we can simplify it where
> > possible.
> 
> Ok.  I want to assume the mic will not land in the head, but I am not sure..
> Is there a scenario where the mic might land in the head, or is that bit of
> the current function left over from other uses?

Any reply that doesn't have page data?

A reply that ends up shorter than expected due to failure of an early op
in the compound?

(Unless I'm missing something.  I haven't looked at this code in a
while.  Though it was problem me that wrote it originally--apologies for
that....)

--b.
