Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04C11ECBD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 22:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLMVTt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 16:19:49 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVTt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 16:19:49 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MkpjD-1hzzY438Zj-00mLph; Fri, 13 Dec 2019 22:19:47 +0100
Received: by mail-qt1-f180.google.com with SMTP id 38so202656qtb.13;
        Fri, 13 Dec 2019 13:19:47 -0800 (PST)
X-Gm-Message-State: APjAAAW0NoVylss35sFlxcdskVlkOogJY/m4KO8Xamz3TLcOUPLXB7TS
        WWJIVDnIrYsmI2IolfUiHHWDG9T4q7b+knC26PQ=
X-Google-Smtp-Source: APXvYqzRCmxSJ5M4TsF2GHTgNgs6xrFc14QenaNUrN3AwXjC24FO2Yu4D8N4fTZTe3LQsHdWTiNakaEj9qN7BIHzOuE=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr14136712qte.204.1576271986613;
 Fri, 13 Dec 2019 13:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20191213141046.1770441-1-arnd@arndb.de> <20191213141046.1770441-11-arnd@arndb.de>
 <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com> <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
 <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com> <20191213211311.GA12391@fieldses.org>
In-Reply-To: <20191213211311.GA12391@fieldses.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 22:19:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1E5pKJ2zbR8auBS5BUDg8LYbEEEJ7L1go7LC0djoxuKg@mail.gmail.com>
Message-ID: <CAK8P3a1E5pKJ2zbR8auBS5BUDg8LYbEEEJ7L1go7LC0djoxuKg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JZ7nF3P96OXpKiBUNNwd0xMUJxZuz+Fh2eeyX5X+ZSw+b1gf+ci
 aW9Q2fPirsgOcs+7gfg8REPBUAH17cYQIsyQ5y3Xgf+WKxQr4Xpn24GeWLRa2Z7tqmMhMEG
 sbmlus23/ftfiF7DrjZbNugNlP0vQS7JZo4nVjUKzOxn1pF+jJIN0jf3TpcBuuXKyR1ABEr
 MlPfTB9KQvNr8SDU6F4Lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Avq3HQGv51I=:KEnA+tswol0qWOKxKkWmyN
 VeMI8rB2wkA7+Iq4bNazJ1keOZ3uqvewIMW2uMz9rBrg+U6W5R6wE2xDI+z3Mn3gg7a6kfJzp
 DqPQThUX/PZpe3AOHbdkBriRQ32Y5I6dzhhy2wxW4vS/fUV0VDISd0PWuyArkDldePQfC+Dkv
 rrh2yjn78y4Bk61lQPW1YGt6mhA5QRsCBwopzSbFtvSWkLd5QDv1fkCccC5iX4DBesRzJvQnT
 2TrPm8O1b6Ji6d9CRGoBrlUVj+JAmbod9GspYrigARECxtlph44whcc4U5nU8qaWiVEFsjcNk
 9f8GxJkQmbATZZ8oMV8ZCpgLsXepJxkDrVFGOsrZuQ2wBpxUHruJtFj7R3QIGJjixuAJHvvN0
 lwx0nqBR8lg8a18LjF2o196l/CR9M3D+4/M9k89eqQsqJJzCSN7fiVUIQbmQYU/w3YYlZqGiz
 RbCDRZEs38/6tzseVc9/OEnKBRJUUw0YZFTZN3kuNAjcRdRPabB7/YaqBLuIl5vhp8As8T+t/
 Qycy0FegbMuk0gKWco/kKcwuHa4ivKuYXLgAWlq6kZtgRYdlaRboh8eDFyZOML3hrcZhAdiNG
 F/qyFKFXgszfg7URGx0ikO5r+GUT+ztyfCkgZvmJYUwl9X3UA6/EnCoYvbkpPrw56YSU4zOay
 rne3ieWbg0iZHYC8rpTqGAeBAmBRnOa70RXXXUKZQTzffRGf21zTsYo7+1y4eKZIQ/ApPxq12
 oUXtlf5MFhuTZ12EpiVx6kcZEvuIgCrPJ4WqYV8/QveMZv6FCnj4AsdIVgCOJaqfi0CNLCiGH
 5yH+LhzblIOXvODUoXcg+anfYl9l/K2Zqul7elRPXSu/GSJ6fZUPjQJKkRt9aLMRT/Cod+6ml
 VpZSBdIhWCkrct46JUPw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 10:13 PM Bruce Fields <bfields@fieldses.org> wrote:
> On Fri, Dec 13, 2019 at 01:23:08PM -0500, Chuck Lever wrote:
> > > On Dec 13, 2019, at 11:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Dec 13, 2019 at 5:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >>> +
> > >>> +     /* nfsd4_lease is set to at most one hour */
> > >>> +     if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
> > >>> +             return 360 * HZ;
> > >>
> > >> Why is the WARN_ON_ONCE added here? Is it really necessary?
> > >
> > > This is to ensure the kernel doesn't change to a larger limit that
> > > requires a 64-bit division on a 32-bit architecture.
> > >
> > > With the old code, dividing by 10 was always fast as
> > > nn->nfsd4_lease was the size of an integer register. Now it
> > > is 64 bit wide, and I check that truncating it to 32 bit again
> > > is safe.
> >
> > OK. That comment should state this reason rather than just repeating
> > what the code does. ;-)
>
> Note that __nfsd4_write_time() already limits nfsd4_lease to 3600.
>
> We could just use a smaller type for nfsd4_lease if that'd help.

I think it's generally clearer to have only one type to store the lease
time, and time64_t is the most sensible one, even if the range is a
bit excessive.

I've seen too many time related bugs from mixing integer types
incorrectly.

       Arnd
