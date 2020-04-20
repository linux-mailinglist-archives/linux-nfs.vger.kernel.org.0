Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93EF1B1664
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 21:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTT6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgDTT6h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 15:58:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04673C061BD3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 12:58:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so12088823qke.13
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=DHwk8VKEaaVWe6umPwn75HeYPWa4/to4TPUyIyniHa8w0VjI4jbFRgfwiJbMPyVTBF
         XIxMCwftVuZ5LMDuVHb9gd/oo9bVOeOag3KnWsbyRKiBySEDw18VNG9po6wPOgaX+JV0
         U696lIpKGeSvPcCzw56gqM/agX1+2/QWVes4jWwOX1kSM0DMbVae9AqQEle3/5swq1WR
         3E0xc6MJg7TbdMO3xq2INKKP9cMKexf1GETBAnT4Wc/qvIJu4eZ79zfLThZbNisSrGcf
         uNvuImd6aWtDGh5xTm0hSIil3sDlm0TTj3TRSR1SEsiBL/e+4Ps6DP19SkF+CcVNT33D
         HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=e8NMyw/m2XhNSKbR7Sv4saJIklYgKUFni8fD9i1+c2rGN8MMjDmG9kbhtw/xRlXpLy
         OtSnUuRQDWnVoj56AsnmhCqMoxLyG4cf3T2Vm6KU8fzN7hdRK2ZTO63ATtYhjO+mfaQ5
         oA+lG5GUEXrHrwEc7Yq0c+my/qf+lvOdX4R63Y5G/fciRkvpNOk8pIxOUynTytiHb/lr
         v5V5LQO+Er1LMxu4RSaaJx9o5ovraG7JA5mE8cBOKe//SKBOfglmp3P3fYT5ns9SSILp
         /ivWpEGGa5w1NwCxMR//CxqeQ9F/zXgzEeyvtAZbXrHluIwNXMHa5Oq+XAtvcJZ7DHAa
         bmMA==
X-Gm-Message-State: AGi0PuY9Ny4yID7zwozm2/wvQq8h60kHFUYK6NO9UvOXeo4CVAkYCd1a
        TYbQHxsmot71S5KrsxWPqS+u5Q==
X-Google-Smtp-Source: APiQypLbKFRt3y7j9cRt5ohxKGUgZ2cg5IXsM72wAdwrD/eEvlPuY2BnSQ46fW3IHvQ9kSE9m6xMag==
X-Received: by 2002:a37:5284:: with SMTP id g126mr18284316qkb.51.1587412716060;
        Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id j2sm241058qtp.5.2020.04.20.12.58.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:58:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/9] fix empty-body warning in posix_acl.c
From:   Zzy Wysm <zzy@zzywysm.com>
In-Reply-To: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Date:   Mon, 20 Apr 2020 14:58:31 -0500
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8B969BE-A2B1-4E6D-8746-BBFBE6399328@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-3-rdunlap@infradead.org>
 <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Apr 18, 2020, at 1:53 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> Thirdly, there's a *reason* why "-Wextra" isn't used.
>=20
> The warnings enabled by -Wextra are usually complete garbage, and
> trying to fix them often makes the code worse. Exactly like here.
>=20

As the instigator of this warning cleanup activity, even _I_ don=E2=80=99t=
 recommend
building with all of -Wextra.  Doing so on an allmodconfig build =
generates=20
500 megabytes of warning text (not exaggerating), primarily due to=20
-Wunused-parameter and Wmissing-field-initializers.

I strongly recommend disabling them with -Wno-unused-parameter=20
-Wno-missing-field-initializers since the spew is completely =
unactionable.

On the other hand, -Woverride-init found a legit bug that was breaking =
DVD
drives, fixed in commit 03264ddde2453f6877a7d637d84068079632a3c5.

I believe finding a good set of compiler warning settings can lead to =
lots of=20
good bugs being spotted and (hopefully) fixed.  Why let syzbot do all =
the work?

zzy

