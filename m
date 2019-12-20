Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7C128306
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTUEq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Dec 2019 15:04:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34460 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTUEq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Dec 2019 15:04:46 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so6822332vsf.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2019 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGrs2LQzkYSuRGzc37Ok8hs742a7PgydYBQSCS5cXuA=;
        b=SChyTdjONomFJZcLWkw20ssAo4KxeF0P/N7Oa6XubstmA0jLPTHxt7FcEIT3jrPF+C
         geAML/ApEcGyxKPxvSpbqRypJEgLZMtOOjECbUu3K2xKfypAWsDsiWfKO2D0Q/wJfXMD
         jdup+3X49Adjqcjguq7H9ATKToKImusqdwyvfPdoNd8Oaa+4HTWLQzPgWK/7juvJvk2p
         ErNIsg1G0GEt4oKUG1kTpQRNmE5nXHqYXme8v5HHh5GfAMr5x0cSRnPuR/abQUKM9Mm/
         vRyoGl73pmSSIG8rmxWnoNJk9MPQXbApD3Z+2YK6PNE7Ww0t16Oy9LRD9xjX0sAh+OuW
         QoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGrs2LQzkYSuRGzc37Ok8hs742a7PgydYBQSCS5cXuA=;
        b=I+U0dTK00kXkSXLjG71gCYk0rHnmozeKvfaSiNYDbBSSoOsBAIYKeEvH6ih64KuY+R
         C5YKMXJkMHMcCaRKPU6w6Sn55bP6xAqGOo+JqXAjTe8WfvliHrJ+ZyOHbM2hj4lM0H9I
         J4FbxnxLgk/hzMJWSDRdv5wkvUnwrDyBDgUdvzxsZ6wMoB91NW5xNKbfHKgwoVdI5Jw6
         3Mdxoj59XMQAD0nrROed6prFzw7bNGhp/iHoiv0ShcfZQaIspDqXkLWvpQWr0joDdGfk
         t4VPbAApI/QivVs3/kWp+g34pX8vnJerF/416wnO5mHbk7jvA+jGwnQyP2wYX2oTEM4R
         v0ug==
X-Gm-Message-State: APjAAAX62vumVjfC7vMDoGbQy1SQH6xm0iEI0fwJpDDMcBdUtm9AbmUt
        AeCVSZP4AnsrHysQex3FhpAs+FEQtvCvdFVWjUc=
X-Google-Smtp-Source: APXvYqzIa1h6X9BLi4rDeCx3QwVz6r1r0nBPbHup1ya+RLKf6je56sy3QBGXzFaBR3JoZBrgb1QpDHZa0OmzS11kxvU=
X-Received: by 2002:a67:f81a:: with SMTP id l26mr9464812vso.194.1576872284689;
 Fri, 20 Dec 2019 12:04:44 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
 <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
 <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com>
 <C5067A0A-5FA4-4FC0-B5B6-828EB3E83373@oracle.com> <CAN-5tyEv4UTfCmkkrYFnOB7nHAV8qX7opfSb=RJT_=PA5tih4g@mail.gmail.com>
 <E086E39A-E140-420F-87CA-A6959F301AD8@oracle.com>
In-Reply-To: <E086E39A-E140-420F-87CA-A6959F301AD8@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 20 Dec 2019 15:04:33 -0500
Message-ID: <CAN-5tyF1iJsm6CSezZ4HGaWSU-5w4Q1W3_e8f6V6v9Uk+B6+Ag@mail.gmail.com>
Subject: Re: acls+kerberos (limitation)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 20, 2019 at 1:28 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 20, 2019, at 1:15 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Dec 18, 2019 at 2:34 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Dec 18, 2019, at 2:31 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> On Wed, Dec 18, 2019 at 2:05 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>>>
> >>>> On Wed, 2019-12-18 at 12:47 -0500, Olga Kornievskaia wrote:
> >>>>> Hi folks,
> >>>>>
> >>>>> Is this a well know but undocumented fact that you can't set large
> >>>>> amount of acls (over 4096bytes, ~90acls) while mounted using
> >>>>> krb5i/krb5p? That if you want to get/set large acls, it must be done
> >>>>> over auth_sys/krb5?
> >>>>>
> >>>>
> >>>> It's certainly not something that I was aware of. Do you see where that
> >>>> limitation is coming from?
> >>>
> >>> I haven't figure it exactly but gss_unwrap_resp_integ() is failing in
> >>> if (mic_offset > rcv_buf->len). I'm just not sure who sets up the
> >>> buffer (or why  rvc_buf->len is (4280) larger than a page can a
> >>> page-limit might make sense to for me but it's not). So you think it
> >>> should have been working.
> >>
> >> The buffer is set up in the XDR encoder. But pages can be added
> >> by the transport... I guess rcv_buf->len isn't updated when that
> >> happens.
> >>
> >
> > Here's why the acl+krbi/krb5p is failing.
> >
> > acl tool first calls into the kernel to find out how large of a buffer
> > it needs to supply and gets acl size then calls down again then code
> > in __nfs4_get_acl_uncached() allocates a number of pages (this what
> > set's the available buffer length later used by the sunrpc code). That
> > works for non-integrity because in call_decode() the call
> > rpc_unwrap_resp() doesn't try to calculate the checksum on the buffer
> > that was just read. However, when its krb5i/krb5p we have truncated
> > buffer and mic offset that's larger than the existing buffer.
> >
> > I think something needs to be marked to skip doing gss for the initial
> > acl query?  I first try providing more space in
> > __nfs4_get_acl_uncached() for when authflavor=krb5i/krb5p and buflen=0
> > but no matter what the number is the received acl can be larger than
> > that thus I don't think that's a good approach.
>
> It's not strictly true that the received ACL can be always be larger.
> There is an upper bound on request sizes.
>
> My preference has always been to allocate a receive buffer of the maximum
> size before the call, just like every other request works. I can't think
> of any reason why retrieving an ACL has to be different. Then we can get
> rid of the hack in the transports to fill in those pages behind the back
> of the upper layers.
>
> The issue here has always been that there's no way for the client to
> discover the number of bytes it needs to retrieve before it sets up the
> GETACL.
>
> For NFSv4.1+ you can probably assume that the ACL will never be larger
> than the session's maximum reply size.
>
> For NFSv4.0 you'll have to make something up.
>
> But allocating a large receive buffer for this request is the only way to
> make the receive reliable. You should be able to do that by stuffing the
> recv XDR buffer with individual pages, just like nfsd does, in GETACL's
> encoding function.
>
> Others might have a different opinion. Or I might have completely
> misunderstood the issue.
>

Putting a limit would be easier. I thought of using rsize (wsize) as
we can't get anything larger than in the payload that but that's not
possible. Because the code sets limits based on XATTR_MAX_SIZE which
is a linux server side limitation and it doesn't seem to be
appropriate to be applied as a generic implementation. Would it be ok
to change the static memory allocation to be dynamic and based on the
rsize? Thoughts?

>
> --
> Chuck Lever
>
>
>
