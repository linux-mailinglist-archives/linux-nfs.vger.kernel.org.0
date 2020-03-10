Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF371809EB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJVHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 17:07:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJVHk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 17:07:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so2986721wmc.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGU1kZslzS3eNgWvD98i8x5i+TM3isy1l91dMCQEfOo=;
        b=nFIorG6Y8A1Lg5FeG6HXirMKIwa+qeahk66afktsvHBwMwNbd4l0LSs8cQwnrJfw6I
         gQ0reVRwAJlL3+aSe5QqOAEweUMKhDwMypLjgNUqvFgBe07LP8qPNEzUa4A9RRr/iOnN
         F302fXwldFpAYO+KNEfsnbofBmCK6TrxMCQpQWYalsmBEq8scKCN2bGIYsw1+WESbRIc
         POksrFL3G2NIY+qUj/4NRbfcUNfk5EyiNhbJMpY0gOt+lUS6EcQnpcnzYBnTa4nHwMEF
         YHShW0o/eHBvSNYfkr1CeIZm1ND/MJDlPvbCnlnGBVXbO4mUh0LrSnJEUYH4f/tcH4g2
         K3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGU1kZslzS3eNgWvD98i8x5i+TM3isy1l91dMCQEfOo=;
        b=kOUqPZr9Q+DFrA9abK1uusjF4wBqgb0vQ3lhqxUZ7bzzB9cOR3+JjREYax/ri2dhQ8
         Dupos3TbE8X5OaQOaxBEM+Srj8fLwCTpKNgy4jHOtims7zGzNmj3uXwGh3+Ns3Ox00As
         dJX4bSip8nAuEHoGKofH7hMvYX779+JIZ7DlKNU1MK+UwwtXdNZR7Z+uVOo3napv3Qyr
         +X27zcExU7MXkc0t06t8w68iQbqS62hDImFRAr3gIU8eTyajaJlkAFBE5szJxoSkA3UK
         tg8i6CTii4OE1/5awz1RTeQw2kSFFlqRlULS+A1mewsilpO3xIMwUMVMtezEGz0UUChO
         /iPw==
X-Gm-Message-State: ANhLgQ0VX8QxyWavwX8j3riCwj8PR1aTLkOvf76qRep+KPwQevNaY76/
        oJ2SbvR3cFGQWy4s0uV+iXUkluLJ0CLn69lhaBo=
X-Google-Smtp-Source: ADFU+vt36KrYyBCNgRJ6/TqCBOnqLRGHN3MTy+APo+B1iJKJdsRw7vlBY0JFw5cwcjnbDpUgElkFQ18NaTcH0LDEAf8=
X-Received: by 2002:a1c:6608:: with SMTP id a8mr2710723wmc.113.1583874458548;
 Tue, 10 Mar 2020 14:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
 <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
In-Reply-To: <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Mar 2020 17:07:27 -0400
Message-ID: <CAN-5tyHQpS7AmPX1cDxKpD=5gyAM7+nmLX+iA29QV7sLwhoX9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in rq_rcvsize
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Tue, Mar 10, 2020 at 3:57 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when computing
> > reply buffer size". It changed how "req->rq_rcvsize" is calculated. It
> > used to use au_cslack value which was nice and large and changed it to
> > au_rslack value which turns out to be too small.
> >
> > Since 5.1, v3 mount with sec=krb5p fails against an Ontap server
> > because client's receive buffer it too small.
>
> Can you be more specific? For instance, why is 100 bytes adequate for
> Linux servers, but not OnTAP?

I don't know why Ontap sends more data than Linux server. The
opaque_len is just a lot larger. For the first message Linux
opaque_len is 120bytes and Ontap it's 206. So it could be for instance
for FSINFO that sends the file handle, for Netapp the file handle is
44bytes and for Linux it's only 28bytes.

> Is this explanation for the current value not correct?
>
>   51 /* length of a krb5 verifier (48), plus data added before arguments when
>   52  * using integrity (two 4-byte integers): */

I'm not sure what it is suppose to be. Isn't "data before arguments"
can vary in length and thus explain why linux and onto sizes are
different?
Looking at the network trace the krb5 verifier I see is 36bytes.

> > For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
> > currently 100. And it's not enough. Changing it to 104 works and then
> > au_rslack is recalculated based on actual received mic.len and not
> > just the default buffer size.
> >
> > I would like to propose to change it to something a little larger than
> > 104, like 120 to give room if some other server might reply with
> > something even larger.
>
> Why does it need to be larger than 104?

I don't know why 100 was chosen and given that I think arguments are
taken into the account and arguments can change. I think NetApp has
changed their file handle sizes (at some point, not in the near past
but i think so?). Perhaps they might want to do that again so the size
will change again.

Honestly, I would have like for 100 to be 200 to be safe.

>
>
> > Thoughts? Will send an actual patch if no objections to this one.
> >
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > index 24ca861..44ae6bc 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -50,7 +50,7 @@
> > #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
> > /* length of a krb5 verifier (48), plus data added before arguments when
> >  * using integrity (two 4-byte integers): */
> > -#define GSS_VERF_SLACK         100
> > +#define GSS_VERF_SLACK         120
> >
> > static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> > static DEFINE_SPINLOCK(gss_auth_hash_lock);
>
> --
> Chuck Lever
>
>
>
