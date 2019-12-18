Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE2125013
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLRSGK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 13:06:10 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:51967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRSGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 13:06:10 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mq1GE-1huoIk2XDO-00nBlt; Wed, 18 Dec 2019 19:06:08 +0100
Received: by mail-qt1-f181.google.com with SMTP id k40so2658117qtk.8;
        Wed, 18 Dec 2019 10:06:08 -0800 (PST)
X-Gm-Message-State: APjAAAUFD0JorfJqBh5u76jj/TweoNhBaYeDOzndejgno5MH2kV2uS01
        NXDwWT2pAOEtm1Y0d82nNpG0ff4aOPxFRWlA55c=
X-Google-Smtp-Source: APXvYqyYS9ehZnjGWLB8XrURveaG+pt+BsFv+SY3GhVRpWl0t13xyAzO2FScp4sAFWkSHHgRNiwiVCQ68tX0q6ep7IU=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr3349805qtm.18.1576692367377;
 Wed, 18 Dec 2019 10:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20191213141046.1770441-1-arnd@arndb.de> <CAK8P3a11e1OsP+KR5rYPyYo_nMz=y2_fqb6ZCmaQ_RUFcoEkrQ@mail.gmail.com>
 <20191218172458.GA24295@fieldses.org>
In-Reply-To: <20191218172458.GA24295@fieldses.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Dec 2019 19:05:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2GaLE8cEp_Dp+zonH7sTJ8F7B67S70kASzwctxevQ62w@mail.gmail.com>
Message-ID: <CAK8P3a2GaLE8cEp_Dp+zonH7sTJ8F7B67S70kASzwctxevQ62w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] nfsd: avoid 32-bit time_t
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Zv/9qxUKHkA+/d/3d9NHEturuf/+kfw1g0Xt0aguMkFTFbNK1rV
 qKSE57jkcKdcD0/+01vMxbdVtaf1FHWFwVWHmzJJd+XU8Ag7AEHLF9vtuRjL0iIz7Qos28z
 f9KaqHM4YIKOWdhGJ1yg8/gzGASw/chXFVKA8u9F1Df9ANVmHszuz4uuuw49NgBLFXnxdHT
 UdkgS+BobnsYZwP9Rjktg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zJaZYROf3ZA=:0m3KEzIv9mG/TBk17SGmLe
 6xS8taJuHoAeKaqbnU5VZZz8AN6k2bC0EF3w/WhkM/Agf1M+fN+7vtrn3KoBIMY4AhsGknssk
 97XNHY+yWgGP4YDvEzGLHeLPR5j7Jljs+QGSBNyZOmMtscswjcBm0A0Z0x5codT25DCRR8Vwz
 yJ4GUBFVQ2d8iDxBpptFOtos/2TS6H7e0p6qe7t/tum9KAJW7HdPHV4Yxi8nF54/eW9NgugLQ
 i1sYOApn8Eg5CNtsbdoLfrEn2Y28ku6EOPfMyOv5C6ZPH82wyRgAGOPVNlKkl0Uc7UtcsEwWX
 ySyVdzuUZeyDZgup6bZdTgiPlxJyMtudvKSPAWYNho+1JZ4d9mq9uwrrUo0P7U7xfcogY2nhl
 nynCBC0Gmp7qhQtM2Ui6iOfQupnk2iI0BHT6wtl9Do2lVn3X6JmDou2AP25G2V2AjcABa5Kn9
 H+DQBQnqYjQ6Dz0YtJOicMSQezJLKi39mCB4VxuDf46Rcjuau5iyrlj2EhPZGSOHgYq5zruKJ
 ObgdMoKcB+CsHnVtIv2srj55S3gtzlBDUcugBMBL5SwyNPZKpUwKN5PEOae1RhaOojjbFNa4v
 9rG3tp9i42RSh755bLCa8ASzPjvHXIBd9RuLUdR67H3S9eabAUdb+WoKOjtBOQSVPAreEdI0f
 kX1lKKXZQ+Lha5uK6wCWnxaVb7gAj5xTbGDNFsgnfHDVZivM7NJ4dFgAmvkeHV45xmGcfnHuo
 YYt5X5f62UFM2Llxl3WXEjeD2MbromYcBhKqtPLREvddhZQ+xtwHV/zyjHiu5FvQ0GqfjAwSP
 7jZLfQELpVQXkHRU/PNRMftQHgT1DuKbYJ5o1UkvujjnwJsPpZ2gFgTIJ1kxCKUBiAkNHrRNB
 sfv2q1eJg2o6Vo0s+Ezw==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 6:25 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> On Wed, Dec 18, 2019 at 06:21:06PM +0100, Arnd Bergmann wrote:
> > On Fri, Dec 13, 2019 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-nfsd-v2
> >
> > in my y2038 branch now, so it should be part of linux-next from the coming
> > snapshot. My plan is to send a linux-5.6 pull request to the nfsd
> > maintainers for
> > this branch unless we find bugs in linux-next or I get more review comments.
>
> Sorry for the silence.  The patches look fine to me, so I took them from
> your git branch and applied them to my local tree (after fixing up some
> minor conflicts with the copy patches) and then saw some
> delegation-related test failures, which I haven't had the chance to
> investigate yet.  Hopefully before the end of the week.

Ok, I've taken the nfsd changes out of my y2038 branch again then, to
make sure we don't get these regressions in linux-next.

Thanks for taking care of the patches. I will not be in the office from
Friday to the end of the year, so probably won't be able to respin the
series quickly once you find the bug(s), but I should be able to reply
to emails about this.

      Arnd
