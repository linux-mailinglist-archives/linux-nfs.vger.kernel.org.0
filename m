Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE79D6C8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfHZTau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 15:30:50 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41356 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbfHZTat (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 15:30:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id m62so11714602vsc.8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UYvaDsjOpBziMsZF8OnMZ6BK4tzp/kY/XaOCFw9sCtU=;
        b=CC8BPPkdICWDUORgHUeCHFq68IJGx68Vkma42zPun7/qLumzkfZW7KZv9tQMhHSKOp
         hoturaN0padhVTGC783TrCD68iLlWoy1TwQJEgbfKHnSGs/bdBaejNm0HHg69a6a/U43
         q58PEdol8/WzOS+h60+AXOK/kUEv8X6n+P7Xotunu0rrBaK+EJepcjsH689jxVfQgtPZ
         lP0BL1r89cvdSBq4vheLxq3MD4MQJkxc3Qgt37GgBK2VVWoTRReXfuQ2l9p00JFPgvIC
         x99lVSUDxebRFP9lrbwlmJcGh5tNX7TN0W9TqvffnPz27gZE+hqEcVW1CtqEUicm1XnQ
         tM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UYvaDsjOpBziMsZF8OnMZ6BK4tzp/kY/XaOCFw9sCtU=;
        b=EtXzhRUMGa4WzkWrgBlmoKcp2lfrrdYBHw1VSfeVelKdadjoCpB+T7y6LmndFsttPh
         ENBa8Aq8tvZrnY9+Q4DMbO+rW64NMTjqCFxBkWOeS/GVXW6unT27VA8WPJJ6TB3z/gEh
         DSHXXHsHS1BsLiClw8252DaK9JCdqpovTCMzmMGUX7o8ElckGSOVqw7lYiHsap51w78v
         vlXRavkwFNWkWouo+pspuMDt9uJPEanmbaBQjn07HErR3MkF1L/pd1AyFzuir66IKN4B
         tiy7Xnj1eCm2Lun1haEgE+SYii2tc1lH1Z1VuIgjHKpsSa0TOaG4UcnKo6akqUvs3Ghd
         ATYw==
X-Gm-Message-State: APjAAAUVjdTVIqfS+4B/hz3azdmKIQaqUs1lwU/Hayhqt7rgIaCFnJ5T
        bin37EICQ66fMKnk7kZ5S6JUM/ho9aCZzF1kjuE=
X-Google-Smtp-Source: APXvYqyVj7PaOD+sphjsoafV+eHLwnVBNGCBbnBMTZgsEZ5h/+k1m+Qo1/rP1rDgan/OB6xx3/SXLJPUrTkQLtJhzuE=
X-Received: by 2002:a67:e401:: with SMTP id d1mr11276693vsf.215.1566847848340;
 Mon, 26 Aug 2019 12:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu> <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270> <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
In-Reply-To: <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 26 Aug 2019 15:30:37 -0400
Message-ID: <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
Subject: Re: Maximum Number of ACL on NFSv4
To:     "de Vandiere, Louis" <louis.devandiere@atos.net>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From fs/nfsd/acl.h
/*
 * Maximum ACL we'll accept from a client; chosen (somewhat
 * arbitrarily) so that kmalloc'ing the ACL shouldn't require a
 * high-order allocation.  This allows 204 ACEs on x86_64:
 */
#define NFS4_ACL_MAX ((PAGE_SIZE - sizeof(struct nfs4_acl)) \
                        / sizeof(struct nfs4_ace))

I don't know how Bruce feels about increasing that limit. Perhaps he'd
be opened to a patch that increases that.

On Mon, Aug 26, 2019 at 2:30 PM de Vandiere, Louis
<louis.devandiere@atos.net> wrote:
>
> Thanks Niels, I tried your suggestion. According to the documentation (ht=
tps://linux.die.net/man/8/mkfs.xfs), the maximum size for the inode is 2048=
 byte. So I set it to this value, and faced the exact same limitation. On t=
he other hand, when I used setfacl -m on the XFS mounted disk, I did not fa=
ce any limitation and I was able to set thousands of ACLs on a single file.
>
> When I do a strace, I see two different types of ACL used when the system=
 calls setxattr: system.posix_acl_default and system.nfsv4_acl. I tried to =
look for hardcoded limits associated with system.nfsv4_acl but I don't have=
 much experience with C and linux kernel.
>
> Thank you for your help.
> Best,
> Louis de Vandi=C3=A8re
>
> -----Original Message-----
> From: Niels de Vos <ndevos@redhat.com>
> Sent: Monday, August 26, 2019 11:46 AM
> To: de Vandiere, Louis <louis.devandiere@atos.net>
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: Maximum Number of ACL on NFSv4
>
> On Mon, Aug 26, 2019 at 02:53:05PM +0000, de Vandiere, Louis wrote:
> > Yes, I assume it's not very frequent to have hundreds of NFSv4 ACLs. Fo=
r compliance and organizational issue, we cannot use groups efficiently to =
manage access to the shares, so it's user-based and case by case.
> >
> > My real goal is to be able to replicate some files to a new NFSv4 serve=
r while preserving the ACLs. By using "cp -R --preserve=3Dall acl-folder/",=
 I'm able to preserve the ACLs when their number does not exceed 200, above=
 it, I see the "File too large" error while rsync does not work at all (eve=
n in version 3.1.3). That's why I'm digging into this and checking what pos=
sibly could go wrong.
>
> You might be hitting a limit in the filesystem on the NFS server. The ACL=
s are stored in extended attributes. Depending on the filesystem, you may b=
e able to configure larger inode sizes (or other storage for xattrs). With =
XFS this can be done with 'mkfs -t xfs -i size=3D.. ...',
>
> HTH,
> Niels
>
>
> >
> > Thank you.
> > Best,
> > Louis de Vandi=C3=A8re
> >
> >
> > -----Original Message-----
> > From: Goetz, Patrick G <pgoetz@math.utexas.edu>
> > Sent: Monday, August 26, 2019 8:44 AM
> > To: de Vandiere, Louis <louis.devandiere@atos.net>;
> > linux-nfs@vger.kernel.org
> > Subject: Re: Maximum Number of ACL on NFSv4
> >
> > I'm dying to know what the use case is for this, and why you can't just=
 do this with group permissions (unless you're talking about hundreds of gr=
oup ACLs).
> >
> > On 8/23/19 5:31 PM, de Vandiere, Louis wrote:
> > > Hi,
> > >
> > > I'm currently trying to apply hundreds of ACLs on file hosted on a NF=
Sv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19.el7=
.x86_64). It appears that the limit I can apply is 207. After the limit is =
reached, the command "nfs4_setfacl -a" returned the error "Failed setxattr =
operation: File too large". The same problem happens if I use an ACL with m=
ore than 200 line in it. I did a little debugging session but I was not abl=
e to come up with an explanation on why I'm facing such an issue.
> > >
> > > On the other hand, I can apply hundreds of ACLs on XFS without issue.=
 Do you know if it could be a bug with the nfs4-acl-tools package?
> > > Thank you for your support.
> > > Best,
> > > Louis de Vandi=C3=A8re
> > >>> This message is from an external sender. Learn more about why this =
<<
> > >>> matters at https://eur01.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flinks.utexas.edu%2Frtyclf&amp;data=3D02%7C01%7Clouis.devandiere=
%40atos.net%7Ce3e196698745444ba59208d72a44ed69%7C33440fc6b7c7412cbb730e70b0=
198d5a%7C0%7C0%7C637024347858295832&amp;sdata=3DpeZa9vHRp77QbOX2yTj204oWk8i=
CO%2FxNbSMzkylf38M%3D&amp;reserved=3D0.                        <<
> > >
