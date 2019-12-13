Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94B11ECA7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfLMVKH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 16:10:07 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 16:10:07 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mnq4Q-1huvWZ2uao-00pJD5; Fri, 13 Dec 2019 22:10:05 +0100
Received: by mail-qk1-f175.google.com with SMTP id z14so360747qkg.9;
        Fri, 13 Dec 2019 13:10:05 -0800 (PST)
X-Gm-Message-State: APjAAAWQQByzRJl+FRsh8mWKGC+1rCfdZACj1Xt9Dax7lDMM5PGgvkTp
        BRbPDqVVHLAzeXZFoIRpgFIJvJIrjqQJUvrTVY0=
X-Google-Smtp-Source: APXvYqyzAwR27KFKi5TkucxKpQNzOtGX0NSY+WgXrxpmwySh3tOt3BeOLfaBKAthCSioGeE7zaSTXD2qo8rhZRMFjvA=
X-Received: by 2002:a37:84a:: with SMTP id 71mr15047213qki.138.1576271404501;
 Fri, 13 Dec 2019 13:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20191213141046.1770441-1-arnd@arndb.de> <20191213141046.1770441-11-arnd@arndb.de>
 <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com> <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
 <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com>
In-Reply-To: <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 22:09:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3W3o6K_BGPaDre29Y1v=ZUMVv4+_mJr68vNkppKuuZrA@mail.gmail.com>
Message-ID: <CAK8P3a3W3o6K_BGPaDre29Y1v=ZUMVv4+_mJr68vNkppKuuZrA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u4OHeFUmz3H/zb1xub1jtQBskNNTwVgzesEymRCHoYLFvufnxM2
 gPTbFFhWO6l7/m0gG6WMPqIm9Z9V10keWMTyI6kUspm7+2laK9JwkeAI+77p9PmOh5PVAvE
 SjD0G/WeGITJ0cB3fSA1tTcSqKNaTBd9dqbJCjmecycb9lknHSEJ3VN6S7a4NRAkd3TpVjZ
 SQmLDHMDGqj6uAoMmemOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dG+P425Wcyo=:9IxV4PrNZPQAgqwpS+PNZK
 Dv8uaSwx1wV8UXsB+/+Ji6Ha6jRNM4GpbiZG/xZX0k3KOf8mwSBMwupJOEC3+urHrPFO2HLGG
 iJjGkQLn2cEjNM7svNXGmSNSkIt+7VhYCDG8aBIZSD9v2GnqEj/Js7C10q6Zb5KTFuFAmJxF5
 j8yNBODZWmWyXTct8O+E8aH4ek7IqcjrwEDNfuy14S6WUT7t6+R1iiIkf811fq5FLbO5ZjCdO
 GsssljDOsst+X8AAcMjcDUVbXBcvA66QsUYWZ5mmzbjeh/lO64tNOAfCwP4WClWD831Qp6uqs
 OB827wfffVJvYEQMgElECNP+3XpSEkXrlqp4bSs5ch1mXHvICOWSBw6q+09VVpVx+dsbTMOeL
 GrOTRYMeSOMv/o5C3Og8F/SQZUoIdxUWZWVKGAX4hv8Fo8shXJaN3j1KgyTta4tEkrdOQmdfJ
 l2bCKld3WBfAIbq1EDw3uHi2goLIQ8J0RLC6EQJh+JA6yKJlW/TD19E/+LVCBUJ5MjFWNJC80
 myCU7OeIr+Ee8G47BFOcf9kQ8XDxf2GPE+LXZco9yH3IuPXFFVmbuY8Um7sYwvZZR/2d2/Bdf
 vFrFZs0t4qBlNZfep5ZyWdnuK4WWMOEXLgMOM2ILA50fbEKivENBUfZRnaZhcSeeIrXr0hInF
 QsOzSQXVG3QV4iEfvMx/6dol7rP5dHFAQuIBZUT/JqWVKhySbj7Il1+U+0wGnP7uvpcc9UnrZ
 gAHRnlDpyB9U7IzpD15ZZBLuf+JyYIpFUS2xyPnSw40EBif6ynyMAwpBNJg2kund90RExMUwA
 +ck2qANEIYRQeKZkYSOdc0bA0sn8HgLOY8TmeWld/7febOKTwkJM/Jj2xnv+g5HDtFS490tFd
 liEA1OCLh7z1cjhtWriw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 7:23 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > On Dec 13, 2019, at 11:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Dec 13, 2019 at 5:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>> On Dec 13, 2019, at 9:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> >>> index 24534db87e86..508d7c6c00b5 100644
> >
> > With the old code, dividing by 10 was always fast as
> > nn->nfsd4_lease was the size of an integer register. Now it
> > is 64 bit wide, and I check that truncating it to 32 bit again
> > is safe.
>
> OK. That comment should state this reason rather than just repeating
> what the code does. ;-)

I changed the comment now to:

+       /*
+        * nfsd4_lease is set to at most one hour in __nfsd4_write_time,
+        * so we can use 32-bit math on it. Warn if that assumption
+        * ever stops being true.
+        */

Modified branch pushed to
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-nfsd-v2

        Arnd
