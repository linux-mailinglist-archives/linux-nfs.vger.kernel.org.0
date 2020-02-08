Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55E156556
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2020 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBHQFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Feb 2020 11:05:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55455 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHQFj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Feb 2020 11:05:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so5458363wmj.5
        for <linux-nfs@vger.kernel.org>; Sat, 08 Feb 2020 08:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMbQuRC87dSsinjTpXzSpwcV64vhF7QI4SXDjOL9vC0=;
        b=iPRmLDsembysXq5NFEP5wq8xBNaa3yoCakeCbSE00lvzpZ4Of0fBd0rhh6kYMhDQb3
         Zy9SKwZ+ltBq2nbkAqital0x0foAh0weugiLIaTQu5Dz8I/kcxj7DCuxVDk2LKuK2x+H
         3aN6SbIsDKhxeQb0Lm4ZZo3aWJZerjvmMwwiSbEnM5FOL6AFqkUfiOvTaA7/gxaAs8Di
         xWoNjkgAHzAXDThzOCvZoJ7UrYTRhQw2VCmZgYlEfypqtJH3qQrHPEFZ0WprE/CVKk0/
         FUNmAxnM60CrhofPK9OI9+pt3un7TbZA4jzi7iC+S66+ec6tsRkrtHQ25g6B+I3vaqvx
         HbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMbQuRC87dSsinjTpXzSpwcV64vhF7QI4SXDjOL9vC0=;
        b=QD2JTfVrEAsMmlUw3cAA0fVG78PASqnfh0a/FbUfX6s3KHvYqIn/eA7FmqEOTwcV3W
         p/l85cdpxsSvtj83Zyarv/KFlDnWYppiiplV4UpMnvV1xRBNUFHqdiUNMkaB0Z5k2iB/
         b7HYtAewcStCIa9jPWF/9pxc2FXDnuo3n6AZrFIrS/dOjIRAGt4UcJ8pI/RxRfP0ME1p
         74KZsQt6hoo/TKj42ksSGgG/HVtYZWfFl+AcxczS/d2bHyPx4YQj2TxwI28mngHbeEHM
         yDKYAqamBUWi707Fisjx2T8JrNURRCP63dbdJmjUaGoiyfeZsaI1fJ/PPs08Udd3+zBa
         NZAg==
X-Gm-Message-State: APjAAAVe2abF6Rzk+r1cF2NXxXK2IDiFC9L3OAq1mlSNBg/LEmlwbUqp
        eRlGLkrHQTewAVGC8c6T8SlIck6Q5UIU2+d5UmF++w==
X-Google-Smtp-Source: APXvYqyQCAZ9rbwf2/kaOrl5fY/gmUndIW4LfN0BsELedv9vBgS+8X34H+ReK9S2btOXJe8G4oykVjeJoRKL/u4DGB8=
X-Received: by 2002:a7b:c750:: with SMTP id w16mr4874681wmk.46.1581177938185;
 Sat, 08 Feb 2020 08:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20200207152109.20855-1-steved@redhat.com> <CAN-5tyHatMk_xsBW5MHpv7-HyiCMPS9qrz3_O6-XN5KpH_RWtA@mail.gmail.com>
 <17f9e558-ed00-c377-83b1-9769fd698cc9@RedHat.com>
In-Reply-To: <17f9e558-ed00-c377-83b1-9769fd698cc9@RedHat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sat, 8 Feb 2020 11:05:27 -0500
Message-ID: <CAN-5tyGa+u1CxiD3kwx9KS2-njckDsLxG-oe+zUzn24JevXjpA@mail.gmail.com>
Subject: Re: [PATCH] query_krb5_ccache: Removed dead code that was flagged by
 a covscan
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Feb 8, 2020 at 4:21 AM Steve Dickson <SteveD@redhat.com> wrote:
>
>
>
> On 2/7/20 12:25 PM, Olga Kornievskaia wrote:
> > On Fri, Feb 7, 2020 at 10:22 AM Steve Dickson <steved@redhat.com> wrote:
> >>
> >> Signed-off-by: Steve Dickson <steved@redhat.com>
> >> ---
> >>  utils/gssd/krb5_util.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> >> index bff759f..a1c43d2 100644
> >> --- a/utils/gssd/krb5_util.c
> >> +++ b/utils/gssd/krb5_util.c
> >> @@ -1066,8 +1066,6 @@ query_krb5_ccache(const char* cred_cache, char **ret_princname,
> >>                             *ret_realm = strdup(str+1);
> >>                     }
> >>                     k5_free_unparsed_name(context, princstring);
> >> -               } else {
> >> -                       found = 0;
> >>                 }
> >
> > Uhm, sorry wasn't fast enough for you commit decision but I don't see
> > that this a dead code? krb5_unparse_string() could return an error so
> > "else" is a valid condition. I mean it's probably unlikely that
> > check_for_tgt() returns found and they you can't parse the principal
> > name out of it. But things like memory errors could still be valid
> > error conditions?
> Sorry for being so quick with the commit...
>
> The covscan complained "warning: Value stored to 'found' is never read"
> which was true... after setting found = 0, found was never used.
>
> Yes, the "else" is a valid condition but not necessary since
> setting 'found' to zero does not do anything...

Got it. Thanks Steve for the explanation.

>
> steved.
>
> >
> >
> >>         }
> >>         krb5_free_principal(context, principal);
> >> --
> >> 2.24.1
> >>
> >
>
