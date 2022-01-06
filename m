Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6109486627
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiAFOgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 09:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAFOgG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 09:36:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB6C061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 06:36:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EBC2872FB; Thu,  6 Jan 2022 09:36:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EBC2872FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641479765;
        bh=8+dtRoLMR7ycE+qMb9FPg24Lo8toPGGsRym1mryWjNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpdD9hSrvcaMd69kco1w30wtqGmjm385SPfFbQimBlrUPTemWaXZTuNti/LF+HZOv
         jA1919phbSJ/lh6gjit5YOKuemmLXHfwm5RWAs0PeGC/E0lJn04HNYsTNUc3DNxVrb
         86/HKBwLn4dab6dhTz94g/L9slohTK083eUHJsms=
Date:   Thu, 6 Jan 2022 09:36:05 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Message-ID: <20220106143605.GD7105@fieldses.org>
References: <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105151008.GB24685@fieldses.org>
 <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220105155451.GA25384@fieldses.org>
 <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
 <DU2PR10MB50969D4D096DB99EEC6D1C45E14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
 <20220106142812.GC7105@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106142812.GC7105@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 06, 2022 at 09:28:12AM -0500, bfields@fieldses.org wrote:
> On Thu, Jan 06, 2022 at 02:19:22PM +0000, Ondrej Valousek wrote:
> > > You also need to update the value of NFSD4_SUPPORTED_ATTRS_WORD1 to reflect the new support for FATTR4_WORD1_TIME_CREATE.
> > 
> > Yes, I realized that one shortly after I sent the mail.
> > Just going to try this patch:
> 
> Thanks!
> 
> Don't we want to vary support depending on the filesystem, though?  Is
> there a way to query that?

Poking around a bit...  looks like we need to check stat->result_mask &
STATX_BTIME.  And use that to adjust the value of bmval0 at the top of
encode_fattr, and make the below encoding conditional on it.

?

--b.

> 
> --b.
> 
> > 
> > [ondrejv@skynet19 /opt/kernel/linux-git/fs/nfsd]$ git diff
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 5a93a5db4fb0..be47e1dd6da5 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3265,6 +3265,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
> >                 p = xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
> >                 *p++ = cpu_to_be32(stat.mtime.tv_nsec);
> >         }
> > +       /* support for btime here */
> > +        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
> > +                p = xdr_reserve_space(xdr, 12);
> > +                if (!p)
> > +                        goto out_resource;
> > +                p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
> > +                *p++ = cpu_to_be32(stat.btime.tv_nsec);
> > +        }
> >         if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
> >                 struct kstat parent_stat;
> >                 u64 ino = stat.ino;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 498e5a489826..5ef056ce7591 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -364,7 +364,7 @@ void                nfsd_lockd_shutdown(void);
> >   | FATTR4_WORD1_OWNER          | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_RAWDEV           \
> >   | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
> >   | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
> > - | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
> > + | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1_TIME_CREATE      \
> >   | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
> > 
> >  #define NFSD4_SUPPORTED_ATTRS_WORD2 0
> > 
> > 
> > ... will see
> > 
> > Legal Disclaimer: This e-mail communication (and any attachment/s) is confidential and contains proprietary information, some or all of which may be legally privileged. It is intended solely for the use of the individual or entity to which it is addressed. Access to this email by anyone else is unauthorized. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited and may be unlawful.
