Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9328E18D4CD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2020 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCTQrl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Mar 2020 12:47:41 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55688 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCTQrl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Mar 2020 12:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584722861; x=1616258861;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=XtMDPpIarwf/crTWNE7mjozXIyPtNkdtp+PQxgObG64=;
  b=YXL9LWQ5QzL/DGXg8rALEYqm7Z/VNwJ+Z9AaPsfmq7rBncdB1l0YMGet
   mX8w35QtecWnYfa1qVrRiVsPo6c0NpVGfcRF5BiU2BiomB/O9atQqLyBP
   wREnTWLzanIHwvil+gVtCatdb8ikujfTiqiirqV0fC463xIRrDYXT5NjY
   E=;
IronPort-SDR: PUw4Fpjs8TpfwBL9gxTCkc+VlojwYQ6+8Yvw3lYmTwkAHhjfEbP1P296FAVVTFrjzy8c8SLfDK
 1L/MAX0eI6vw==
X-IronPort-AV: E=Sophos;i="5.72,285,1580774400"; 
   d="scan'208";a="33811913"
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding logic
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Mar 2020 16:47:39 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 7DAE4A1DC8;
        Fri, 20 Mar 2020 16:47:38 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Mar 2020 16:47:37 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 16:47:37 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 20 Mar 2020 16:47:37 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 80807CAD77; Fri, 20 Mar 2020 16:47:37 +0000 (UTC)
Date:   Fri, 20 Mar 2020 16:47:37 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20200320164737.GA19415@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <6955728A-CFCC-40FC-9E02-671255EDD45F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6955728A-CFCC-40FC-9E02-671255EDD45F@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Thu, Mar 12, 2020 at 03:16:37PM -0400, Chuck Lever wrote:
> > +static __be32
> > +nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
> > +                   struct nfsd4_setxattr *setxattr)
> > +{
> > +     DECODE_HEAD;
> > +     u32 flags, maxcount, size;
> > +     struct kvec head;
> > +     struct page **pagelist;
> > +
> > +     READ_BUF(4);
> > +     flags = be32_to_cpup(p++);
> > +
> > +     if (flags > SETXATTR4_REPLACE)
> > +             return nfserr_inval;
> > +     setxattr->setxa_flags = flags;
> > +
> > +     status = nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
> > +     if (status)
> > +             return status;
> > +
> > +     maxcount = svc_max_payload(argp->rqstp);
> > +     maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
> > +
> > +     READ_BUF(4);
> > +     size = be32_to_cpup(p++);
> > +     if (size > maxcount)
> > +             return nfserr_xattr2big;
> > +
> > +     setxattr->setxa_len = size;
> > +     if (size > 0) {
> > +             status = svcxdr_construct_vector(argp, &head, &pagelist, size);
> > +             if (status)
> > +                     return status;
> > +
> > +             status = nfsd4_vbuf_from_stream(argp, &head, pagelist,
> > +                 &setxattr->setxa_buf, size);
> > +     }
> 
> Now I'm wondering if read_bytes_from_xdr_buf() might be adequate
> for this purpose, so you can avoid open-coding all of this logic.

This took a little longer, I had to check my notes, but basically the
reasons for doing it this way are:

* The nfsd decode path uses nfsd4_compoundargs, which doesn't have an
  xdr_stream (it has a page array). So read_bytes_from_xdr_buf isn't
  a natural fit.
* READ_BUF/read_buf don't deal with > PAGE_SIZE chunks, but xattrs may
  be larger than that.

The other code that deals with > PAGE_SIZE chunks is the write code. So,
I factored out some code from the write code, used that, and added a function
to process the resulting kvec / pagelist (nfs4_vbuf_from_stream).

There definitely seem to be several copy functions in both the client
and server code that basically do the same, but in slightly different ways,
depending on whether they use an XDR buf or not, whether the pages are
mapped or not, etc. Seems like a good candidate for a cleanup, but I
considered it to be out of scope for these patches.

- Frank
