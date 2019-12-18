Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C155A124F02
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLRRVZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 12:21:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLRRVY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 12:21:24 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MAxPb-1iWsaA174T-00BPI1; Wed, 18 Dec 2019 18:21:23 +0100
Received: by mail-qt1-f177.google.com with SMTP id k40so2543612qtk.8;
        Wed, 18 Dec 2019 09:21:23 -0800 (PST)
X-Gm-Message-State: APjAAAX71HKNzIizOuvrXOxQNAbB5+bBUkh+oSzj9kc+tRFYid68Jsib
        wHtokhwhpJr8F4GkEQR8xtS5aPmXwvhH62somh8=
X-Google-Smtp-Source: APXvYqznHDIvsOsFi4e8w9aoxbL/RPtggV4tE5pA9VKKphGs791HZuLvv9iC58VLi9vjYFWdsRYK26eOQpCPgD46U/w=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr3096663qte.204.1576689682103;
 Wed, 18 Dec 2019 09:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20191213141046.1770441-1-arnd@arndb.de>
In-Reply-To: <20191213141046.1770441-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Dec 2019 18:21:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a11e1OsP+KR5rYPyYo_nMz=y2_fqb6ZCmaQ_RUFcoEkrQ@mail.gmail.com>
Message-ID: <CAK8P3a11e1OsP+KR5rYPyYo_nMz=y2_fqb6ZCmaQ_RUFcoEkrQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] nfsd: avoid 32-bit time_t
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3ejHaJCvJhrUxjTvdpSmPFwCIgHxmJ1AzDZM3xjfg5cCLVAl4DI
 mPorb03spSOhSn29YE3ndn0kxRJt1NS5Z7iZMMORBByPOEj+nyGC5ZGfXmzAxxaitVIYjDN
 C1YlhuQG3sE6+/l6g0lA75uVcOhOLSZofBhJoSQEBxMGXYarW7B23okIBGcmTtboXgYYE3M
 zwKaHPF489/2/uqtNU4kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:POvJ5XGNovA=:d0SD4nNOgoWRJtUu4T0v46
 KmXi34+a02pKGC+pi5dOhIxIizgVOqKKNrQ0rzaSROuqHhMmjIi4HzSQuUXSvXKGv0d4URStJ
 +nKmJh/YNTjdT1+6vQV28oJMnpYc3slb1u12+bESihh+L2iemGFlDv/XdOFyI3T3yrMiSlCFF
 g153WnPsrgTyioQJdh+p9KNasFAp6Y5tSfmwirlLVTEpYylr9/fYWmJpPmjYCZHQORKikbq7m
 hreEdj3HG45LSCuVfD/70vxUd/6FuDzFIJs2/+ui8sEllL0xcDLXYj+WEfG3fIPcqo7xrbzI9
 sFPm5HPJ0u4KQtenfwi1jI7kp72v9vDZUAteZxMaiGupb6oos6BQtB2KcROhmUSlFaMZG/7wv
 6UsACTwhyFkDEz9lyZKXHXFW/WYpuFOotVFLsv/vrB/Yw9kke9+ALznhMcXxExgLrEqtVQpxx
 AghdGXMS7OQmRTc3B43jX68wkUtJ/Xv8rdSmkwVqnkJNMKBl3RwiSZZY0E8tgfZBM4cubnLBU
 I1Mem1SQWEyy0DHdl18Rx3dgk7lS8L8RAuT5GFqoqyaSJlJ/EDqbE+pZbTBEgNcnmaXl0T0zl
 avRWuqTtJkZLsXV71jPNecu5wv/or5IXXspEkasE7naO7HvJm/YzwsgnMPKL5YBGb0l1YARsY
 7ff6WU6p+hMRaNst0ACcYXwiYJrzvU4f1vj4foHTzCxD01uTMZoMgfljkotkvlfv7AOSEWdEz
 6giClqb5go0JU7OtIsd1SVM0d1bp3m81iqwQeP20qrOttuGJzxh8eLtNIKxmSdoxNwOV0kRCF
 J3GVSas6VLQR0iJOXqFSgb2i0DakhBnbsu6/4VJYb8sjjMkCHmrE4TgWVIgnhsHWnyM5RJofM
 JtnMYhM6zaUDFN9vbteQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Bruce, Chuck,
>
> NFSd is one of the last areas of the kernel that is not y2038 safe
> yet, this series addresses the remaining issues here.
>
> I did not get any comments for the first version I posted [1], and
> I hope this just means that everything was fine and you plan to
> merge this soon ;-)
>
> I uploaded a git branch to [2] for testing.
>
> Please review and merge for linux-5.6 so we can remove the 32-bit
> time handling from that release.

I've included the update y2038 nfsd branch from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-nfsd-v2

in my y2038 branch now, so it should be part of linux-next from the coming
snapshot. My plan is to send a linux-5.6 pull request to the nfsd
maintainers for
this branch unless we find bugs in linux-next or I get more review comments.

        Arnd
