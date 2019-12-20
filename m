Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD37A128218
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLTSPp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Dec 2019 13:15:45 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41071 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfLTSPk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Dec 2019 13:15:40 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so3561475uaa.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2019 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgIqMPEGM8UUIDQTgd9Mrg/qfmjyp7/QdtMKvQudqsQ=;
        b=NZu+Jufvkm380kyHT1TY33ieG/HOmUU/jYW+/JPQneWe9Z1wIcZppI3fPr+ukyK2C1
         So+JxLFs/bKXS0gei/ETaVtFkiFldyyFPd37igA56OAhiZqePv8MYTSZ94E7PKM72FwS
         kP+fftP8F8+B9BqiIeRyl4ay13Hfd2BWhJPKm1oW93PbilAZuP+EjlV8AfYsQ7AP++AS
         Gfryurh83C7xedlZZHE4dHTBP6HTdIV2VAJFZrq57cUQRca+CMWYmhpsll+tDyPaV+pk
         oA19gm42Xf+V+1c2EbJ874C7Kxfdf7KCxbRKfTfu2RotDmxDaAFFXW/23f1EWV1O3+Hw
         rIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgIqMPEGM8UUIDQTgd9Mrg/qfmjyp7/QdtMKvQudqsQ=;
        b=uWUreciaNrohmqq4yP3LsYZmhc8PO6i1kBUPmJsv0p85bGEOXjwNnNeUq6lEyxIr9Q
         Q6pwE03l/8MTTB4Nt9fRk3HHaOLf3ghGDSRnLcjbeqxAg2U20nMo9qPLns/SV61BLKIx
         NCfW1c45knu4X+LpIzR5CaPLR+UWUkW/Id9/r5AnEa06oV6DuxzzTutP/0QI8EKVKvyC
         +Yk0ofPDkjm7Kd9z94xAI21G3GhApXM663aAHOcMyrSVzgoqnEpeThCBSjFQCwf5kChp
         U2LQ7bp0WOGqy8uUbqo+tuI4oXuFc9aVbSOU1uxRvA8T79f3JfO6fG6yKBWTrhtcnkn1
         YFGA==
X-Gm-Message-State: APjAAAVbAR97+ubToGnv5sd/n3duyLCAwHlzifxWpFfte+CNHeLHmJdv
        tK3fVZ9cSkioGuwaF6y6axrOzs6LYsXNKJRPajWtBDeT
X-Google-Smtp-Source: APXvYqzeeyfmNksORwWamk6CHHUk/a0knE5KjPEMKeeDMQUwaglQNaHvUqjLnRY2Or8CkQCJ4IDst9V3tvcoCxvBAUw=
X-Received: by 2002:ab0:710c:: with SMTP id x12mr7547536uan.81.1576865738734;
 Fri, 20 Dec 2019 10:15:38 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
 <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
 <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com> <C5067A0A-5FA4-4FC0-B5B6-828EB3E83373@oracle.com>
In-Reply-To: <C5067A0A-5FA4-4FC0-B5B6-828EB3E83373@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 20 Dec 2019 13:15:27 -0500
Message-ID: <CAN-5tyEv4UTfCmkkrYFnOB7nHAV8qX7opfSb=RJT_=PA5tih4g@mail.gmail.com>
Subject: Re: acls+kerberos (limitation)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 2:34 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 18, 2019, at 2:31 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Dec 18, 2019 at 2:05 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>
> >> On Wed, 2019-12-18 at 12:47 -0500, Olga Kornievskaia wrote:
> >>> Hi folks,
> >>>
> >>> Is this a well know but undocumented fact that you can't set large
> >>> amount of acls (over 4096bytes, ~90acls) while mounted using
> >>> krb5i/krb5p? That if you want to get/set large acls, it must be done
> >>> over auth_sys/krb5?
> >>>
> >>
> >> It's certainly not something that I was aware of. Do you see where that
> >> limitation is coming from?
> >
> > I haven't figure it exactly but gss_unwrap_resp_integ() is failing in
> > if (mic_offset > rcv_buf->len). I'm just not sure who sets up the
> > buffer (or why  rvc_buf->len is (4280) larger than a page can a
> > page-limit might make sense to for me but it's not). So you think it
> > should have been working.
>
> The buffer is set up in the XDR encoder. But pages can be added
> by the transport... I guess rcv_buf->len isn't updated when that
> happens.
>

Here's why the acl+krbi/krb5p is failing.

acl tool first calls into the kernel to find out how large of a buffer
it needs to supply and gets acl size then calls down again then code
in __nfs4_get_acl_uncached() allocates a number of pages (this what
set's the available buffer length later used by the sunrpc code). That
works for non-integrity because in call_decode() the call
rpc_unwrap_resp() doesn't try to calculate the checksum on the buffer
that was just read. However, when its krb5i/krb5p we have truncated
buffer and mic offset that's larger than the existing buffer.

I think something needs to be marked to skip doing gss for the initial
acl query?  I first try providing more space in
__nfs4_get_acl_uncached() for when authflavor=krb5i/krb5p and buflen=0
but no matter what the number is the received acl can be larger than
that thus I don't think that's a good approach.

> --
> Chuck Lever
>
>
>
