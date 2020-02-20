Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE2166514
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTRky (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 12:40:54 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44828 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRky (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 12:40:54 -0500
Received: by mail-yb1-f193.google.com with SMTP id b4so2530549ybk.11
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2020 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hv8Ep4KXhXL07ETD0vey2VPDxaKxokuLC+QtGrxeWts=;
        b=JAezG2gvvUD5CiX83vnR5QxHyX9K2GGFd75rXYw4z/zinsZNi8RUmZe7HvRj8Ph8wS
         hUjSH9vLGmTO4PYa9Sz0jtWVLgl7049FsGNsUXwXbtW9RGOOm6CYTzk4jogH+rvpl7bv
         +bDLSH4ShzyjRzDsR8812bMAqInfBipwUZ/jUPKIP2AXiIrp0J7I21kDgL1BhjRjphgY
         pDs8wFY4s1CQOV+tlRJfowD8wN7xUKxviBGHHNSD9iCtWLwZEecz8xPc+yM9O/t9ZQ8M
         VC40KZrYWOQbiM4KHtR07tyWYrBZDnGerau5GpaHgXydBYNnVpElgXh/DJoAOAJGNqP2
         2CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hv8Ep4KXhXL07ETD0vey2VPDxaKxokuLC+QtGrxeWts=;
        b=Bx18u3BgRc9cmpuskoMwm8GV0v2I5ho32bKayNY3cm+IBu4i+PF/abXlpje6bvXtXt
         ZukLrk1U2+FBHTeUNbgLBkpscrc0JbX/UfF1xFvJbmbrJWJq6w+ovhA+jFEU8KKHeosH
         TsCBBMG20c+hmPt7izPkyaane6M3/v6L9Rxg824XkVWERIGhhe4zLG+Iyvsnz4LQIVTW
         cSngRGOHihRnnYewYszFmmS/d9EVIYg8yRQztkcDMQ+k8GOT7bc4j0+ILJlbPemXeRrI
         bh9YiaEdH7nre9vMhfwnJs0ARtoF9YybmkBZNaZ9EYn+fK+w4TQZV7A152YELBDL0ne9
         4MXg==
X-Gm-Message-State: APjAAAWXAhFmfUj5O6hWWdXx99sM0KYfyOgsTtMVrFisW242c3IsMvLJ
        wkOe2G+OAQx23b+9RS6ugJs=
X-Google-Smtp-Source: APXvYqxwT17PSXgh0ADCZldSIQ6KUU2Osa4vLBgjb1qFGekOeOEu5EFVuXO3od+Qj1Ozws8h9n9Dew==
X-Received: by 2002:a25:cb41:: with SMTP id b62mr31779783ybg.445.1582220452865;
        Thu, 20 Feb 2020 09:40:52 -0800 (PST)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d137sm120282ywe.36.2020.02.20.09.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 09:40:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 0/6] NFS: Add support for the v4.2 READ_PLUS operation
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
Date:   Thu, 20 Feb 2020 12:40:51 -0500
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <34F6A8B4-3BC0-4C29-A6C1-176D3A866BFD@gmail.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> These patches add client support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client. I also add a "noreadplus" mount option to =
allow
> users to disable the new operation if it becomes a problem, similar to
> the "nordirplus" mount option that we already have.

Hrm, I went looking for the patch that adds "noreadplus", but I
don't see it in this series?

Wondering if, to start off, the default should be "noreadplus"
until our feet are under us. Just a thought.


> Here are the results of some performance tests I ran on Netapp lab
> machines. I tested by reading various 2G files from a few different
> undelying filesystems and across several NFS versions. I used the
> `vmtouch` utility to make sure files were only cached when we wanted
> them to be. In addition to 100% data and 100% hole cases, I also =
tested
> with files that alternate between data and hole segments. These files
> have either 4K, 8K, 16K, or 32K segment sizes and start with either =
data
> or hole segments. So the file mixed-4d has a 4K segment size beginning
> with a data segment, but mixed-32h hase 32K segments beginning with a
> hole. The units are in seconds, with the first number for each NFS
> version being the uncached read time and the second number is for when
> the file is cached on the server.
>=20
> ext4      |        v3       |       v4.0      |       v4.1      |      =
 v4.2      |
> =
----------|-----------------|-----------------|-----------------|---------=
--------|
> data      | 22.909 : 18.253 | 22.934 : 18.252 | 22.902 : 18.253 | =
23.485 : 18.253 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  =
0.708 :  0.709 |
> mixed-4d  | 28.261 : 18.253 | 29.616 : 18.252 | 28.341 : 18.252 | =
24.508 :  9.150 |
> mixed-8d  | 27.956 : 18.253 | 28.404 : 18.252 | 28.320 : 18.252 | =
23.967 :  9.140 |
> mixed-16d | 28.172 : 18.253 | 27.946 : 18.252 | 27.627 : 18.252 | =
23.043 :  9.134 |
> mixed-32d | 25.350 : 18.253 | 24.406 : 18.252 | 24.384 : 18.253 | =
20.698 :  9.132 |
> mixed-4h  | 28.913 : 18.253 | 28.564 : 18.252 | 27.996 : 18.252 | =
21.837 :  9.150 |
> mixed-8h  | 28.625 : 18.253 | 27.833 : 18.252 | 27.798 : 18.253 | =
21.710 :  9.140 |
> mixed-16h | 27.975 : 18.253 | 27.662 : 18.252 | 27.795 : 18.253 | =
20.585 :  9.134 |
> mixed-32h | 25.958 : 18.253 | 25.491 : 18.252 | 24.856 : 18.252 | =
21.018 :  9.132 |
>=20
> xfs       |        v3       |       v4.0      |       v4.1      |      =
 v4.2      |
> =
----------|-----------------|-----------------|-----------------|---------=
--------|
> data      | 22.041 : 18.253 | 22.618 : 18.252 | 23.067 : 18.253 | =
23.496 : 18.253 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  =
0.723 :  0.708 |
> mixed-4d  | 29.417 : 18.253 | 28.503 : 18.252 | 28.671 : 18.253 | =
24.957 :  9.150 |
> mixed-8d  | 29.080 : 18.253 | 29.401 : 18.252 | 29.251 : 18.252 | =
24.625 :  9.140 |
> mixed-16d | 27.638 : 18.253 | 28.606 : 18.252 | 27.871 : 18.253 | =
25.511 :  9.135 |
> mixed-32d | 24.967 : 18.253 | 25.239 : 18.252 | 25.434 : 18.252 | =
21.728 :  9.132 |
> mixed-4h  | 34.816 : 18.253 | 36.243 : 18.252 | 35.837 : 18.252 | =
32.332 :  9.150 |
> mixed-8h  | 43.469 : 18.253 | 44.009 : 18.252 | 43.810 : 18.253 | =
37.962 :  9.140 |
> mixed-16h | 29.280 : 18.253 | 28.563 : 18.252 | 28.241 : 18.252 | =
22.116 :  9.134 |
> mixed-32h | 29.428 : 18.253 | 29.378 : 18.252 | 28.808 : 18.253 | =
27.378 :  9.134 |
>=20
> btrfs     |        v3       |       v4.0      |       v4.1      |      =
 v4.2      |
> =
----------|-----------------|-----------------|-----------------|---------=
--------|
> data      | 25.547 : 18.253 | 25.053 : 18.252 | 24.209 : 18.253 | =
32.121 : 18.253 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.252 |  =
0.702 :  0.724 |
> mixed-4d  | 19.016 : 18.253 | 18.822 : 18.252 | 18.955 : 18.253 | =
18.697 :  9.150 |
> mixed-8d  | 19.186 : 18.253 | 19.444 : 18.252 | 18.841 : 18.253 | =
18.452 :  9.140 |
> mixed-16d | 18.480 : 18.253 | 19.010 : 18.252 | 19.167 : 18.252 | =
16.000 :  9.134 |
> mixed-32d | 18.635 : 18.253 | 18.565 : 18.252 | 18.550 : 18.252 | =
15.930 :  9.132 |
> mixed-4h  | 19.079 : 18.253 | 18.990 : 18.252 | 19.157 : 18.253 | =
27.834 :  9.150 |
> mixed-8h  | 18.613 : 18.253 | 19.234 : 18.252 | 18.616 : 18.253 | =
20.177 :  9.140 |
> mixed-16h | 18.590 : 18.253 | 19.221 : 18.252 | 19.654 : 18.253 | =
17.273 :  9.135 |
> mixed-32h | 18.768 : 18.253 | 19.122 : 18.252 | 18.535 : 18.252 | =
15.791 :  9.132 |
>=20
> ext3      |        v3       |       v4.0      |       v4.1      |      =
 v4.2      |
> =
----------|-----------------|-----------------|-----------------|---------=
--------|
> data      | 34.292 : 18.253 | 33.810 : 18.252 | 33.450 : 18.253 | =
33.390 : 18.254 |
> hole      | 18.256 : 18.253 | 18.255 : 18.252 | 18.256 : 18.253 |  =
0.718 :  0.728 |
> mixed-4d  | 46.818 : 18.253 | 47.140 : 18.252 | 48.385 : 18.253 | =
42.887 :  9.150 |
> mixed-8d  | 58.554 : 18.253 | 59.277 : 18.252 | 59.673 : 18.253 | =
56.760 :  9.140 |
> mixed-16d | 44.631 : 18.253 | 44.291 : 18.252 | 44.729 : 18.253 | =
40.237 :  9.135 |
> mixed-32d | 39.110 : 18.253 | 38.735 : 18.252 | 38.902 : 18.252 | =
35.270 :  9.132 |
> mixed-4h  | 56.396 : 18.253 | 56.387 : 18.252 | 56.573 : 18.253 | =
67.661 :  9.150 |
> mixed-8h  | 58.483 : 18.253 | 58.484 : 18.252 | 59.099 : 18.253 | =
77.958 :  9.140 |
> mixed-16h | 42.511 : 18.253 | 42.338 : 18.252 | 42.356 : 18.252 | =
51.805 :  9.135 |
> mixed-32h | 38.419 : 18.253 | 38.504 : 18.252 | 38.643 : 18.252 | =
40.411 :  9.132 |
>=20
>=20
> Changes since v1:
> - Rebase to 5.6-rc1
> - Drop the mount option patch for now
> - Fix fallback to READ when the server doesn't support READ_PLUS
>=20
> Any questions?
> Anna
>=20
>=20
> Anna Schumaker (6):
>  SUNRPC: Split out a function for setting current page
>  SUNRPC: Add the ability to expand holes in data pages
>  SUNRPC: Add the ability to shift data to a specific offset
>  NFS: Add READ_PLUS data segment support
>  NFS: Add READ_PLUS hole segment decoding
>  NFS: Decode multiple READ_PLUS segments
>=20
> fs/nfs/nfs42xdr.c          | 169 +++++++++++++++++++++++++
> fs/nfs/nfs4proc.c          |  43 ++++++-
> fs/nfs/nfs4xdr.c           |   1 +
> include/linux/nfs4.h       |   2 +-
> include/linux/nfs_fs_sb.h  |   1 +
> include/linux/nfs_xdr.h    |   2 +-
> include/linux/sunrpc/xdr.h |   2 +
> net/sunrpc/xdr.c           | 244 ++++++++++++++++++++++++++++++++++++-
> 8 files changed, 457 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.25.0
>=20

--
Chuck Lever
chucklever@gmail.com



