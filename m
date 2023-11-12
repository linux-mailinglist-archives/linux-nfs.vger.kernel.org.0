Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086107E935F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 00:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjKLXkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 18:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKLXkA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 18:40:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F31BFF
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 15:39:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso5888223a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 15:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699832394; x=1700437194; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCXRv18NBna+djkGF1OU+wQNe8EUd5ljspRa4weyE6g=;
        b=ZKtMf27qes19Fxy0iuGbkofFIcmidlP6terP+EWV6SKXgWkRgNcTntvISKhjDSMZNS
         irkKISX0uW778XAiUonHpqW/ggeF8yYsdnXOxYMhaEuC6z+VIvZhdKmVRBAWCcTu6w5k
         EuYvNbVtf6S90Em3C94r+8mQa9LVXPsp9x3zGJJrYdpwcwByDrhCHAOSnPpPykF31kzh
         9FSFmuAUmXmRibiO9ES7C591W5O2JSsQi/7MX/joXeX9oH6Rd00cGMrE3Z91JMwxU1rx
         jAKsWZgxZJk/rvgGBA9wapHVQiiPU4HsgT2QIKCtcEiLA8wLVMbC2ZKW/IHcKwTzclbv
         pZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699832394; x=1700437194;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCXRv18NBna+djkGF1OU+wQNe8EUd5ljspRa4weyE6g=;
        b=Pp7uXYJFXGZAuG51LMruZM66IENJvpwGlBDzrt3yH/0sH7VZCDYilNEgYRq1mH/tUc
         aJjzLg7xKmfmTLO136ChZF32IoLTK9NZ/RYqhFuZSc1Wz5ygQ0aXg5JiuOGgKx916wK1
         PkvMK98+XsAqW/ocaz9mSm+psHPTdBiXCo8cRV6z6mbKQH+ot/rwnORG//qzj85Nd398
         NdTVTDdXJM0COSj2BPtPQ9iwIz3k7wNovuqgaT2xOU/rvYVRoKlfD9AC1fF8niwKQ3u1
         XRN1F9tH11gMIStertu/jGTpbXEjq8zGPNGeXFCr5KXHcpi71DifCVsv2+ukRlSIvsyy
         ukZw==
X-Gm-Message-State: AOJu0Yxx8eynsBOocrOkpthCKqV1X2nt0w3Whinwpp0x9DRruAWwHvxC
        yd0bbQJjw42MxZR8nqwt9+brCN9D1CaSRVKFz9Mq5XWO
X-Google-Smtp-Source: AGHT+IHk9SfeewLsd96y8HUZw8Xia92NQTIsVzVBD34GDMuKuWzPkBvCtbHNs3KZZNDK6NvtJUeozZhb1D5MbFRJ6io=
X-Received: by 2002:a05:6402:430e:b0:544:51a4:6c9 with SMTP id
 m14-20020a056402430e00b0054451a406c9mr4460625edc.32.1699832394488; Sun, 12
 Nov 2023 15:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com> <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <2EA6162E-1CF9-49E8-8A05-9E5246606F89@redhat.com> <DFBBA6DD-7F22-4A38-BAA2-DBD40EB81BB9@oracle.com>
In-Reply-To: <DFBBA6DD-7F22-4A38-BAA2-DBD40EB81BB9@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Mon, 13 Nov 2023 00:39:11 +0100
Message-ID: <CALXu0Uc8exDxbi=uzWHmKDTV8ZvY_RMYgehGA1ThiJSBFPHw5A@mail.gmail.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 10 Nov 2023 at 19:14, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
> > On Nov 10, 2023, at 8:49 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
> >
> > On 10 Nov 2023, at 2:54, Martin Wege wrote:
> >
> >> On Wed, Nov 1, 2023 at 3:42=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>>
> >>> On 1 Nov 2023, at 5:06, Martin Wege wrote:
> >>>
> >>>> Good morning!
> >>>>
> >>>> We have questions about NFSv4 referrals:
> >>>> 1. Is there a way to test them in Debian Linux?
> >>>>
> >>>> 2. How does a fs_locations attribute look like when a nonstandard po=
rt
> >>>> like 6666 is used?
> >>>> RFC5661 says this:
> >>>>
> >>>> * http://tools.ietf.org/html/rfc5661#section-11.9
> >>>> * 11.9. The Attribute fs_locations
> >>>> * An entry in the server array is a UTF-8 string and represents one =
of a
> >>>> * traditional DNS host name, IPv4 address, IPv6 address, or a zero-l=
ength
> >>>> * string.  An IPv4 or IPv6 address is represented as a universal add=
ress
> >>>> * (see Section 3.3.9 and [15]), minus the netid, and either with or =
without
> >>>> * the trailing ".p1.p2" suffix that represents the port number.  If =
the
> >>>> * suffix is omitted, then the default port, 2049, SHOULD be assumed.=
  A
> >>>> * zero-length string SHOULD be used to indicate the current address =
being
> >>>> * used for the RPC call.
> >>>>
> >>>> Does anyone have an example of how the content of fs_locations shoul=
d
> >>>> look like with a custom port number?
> >>>
> >>> If you keep following the references, you end up with the example in
> >>> rfc5665, which gives an example for IPv4:
> >>>
> >>> https://datatracker.ietf.org/doc/html/rfc5665#section-5.2.3.3
> >>
> >> So just <address>.<upper-byte-of-port-number>.<lower-byte-of-port-numb=
er>?
> >>
> >> How can I test that with the refer=3D option in /etc/exports? nfsref
> >> does not seem to have a ports option...
> >
> > Just test it!
> >
> > I thought the nfsref program actually populates the "trusted.junction.n=
fs"
> > xattr, which is part of the "fedfs" project's metadata to link filesyst=
ems
> > together.  I don't think that's what you want here.
>
> No, nfsref is what Martin wants.
>
>
> > Chuck - am I right to say that the nfsref program does not populate
> > nfsd4_fs_locations on knfsd?
>
> nfsref is the proper tool to use.

nfsref is not being packaged. And likely will not be available for a
couple of years, even if nfs-utils builds it by default.

So what do I have to set in /usr/setfattr to define a junction?

>
> nfsref turns a directory into a junction by doing two things:
>
> 1. It adds a trusted.junction.nfs xattr containing the information
>    that the server returns when a client does a GETATTR(fs_locations)
>    on that directory
>
> 2. It updates the directory's mode bits to mark it as a junction

Which directory mode bits are that?

And maybe that is the reason that having a junction redirect to /home
when /home is controlled by the automounter makes it fail?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
