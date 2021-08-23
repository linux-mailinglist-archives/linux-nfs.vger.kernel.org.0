Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF93F52F0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhHWVm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 17:42:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD27C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 14:42:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cq23so28324159edb.12
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2OVqrTHlXRS556laKtMmIDL6Tj/QyUEK7tVtt6nHeeI=;
        b=BRy49zyQa0H9MU1bi/rgKMXuAtmmv69CgfcC5cLYzjCoH69RqAMS2aJoEpQqYobEpj
         bZQZgU2TuZrFqtnbyN83J/qbe6Hs8k2Ot01J5Mpmuw3IcLxgnDJN9RsmWPcyjkL5pBzu
         I5BnADo9Oq/GW+g2lVUT/OEucYaUsehD5JFwFj0UuvFk5ROWVBNG5s8lu4jcvyH6W9iX
         cZHdPkoGVEUqQJ9C88ewgR9K+mdtTYF8dgl8SdinlATtWmvttyFZHySS1Gh0jXuY+OZb
         3Z6eqhIrwJSHJezI07mn1wTDYCsL5jO4nUqgwy4fgRnvf2uxFvGuiUlfQmr8/Gg9X9J3
         HYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2OVqrTHlXRS556laKtMmIDL6Tj/QyUEK7tVtt6nHeeI=;
        b=EPIjp2ghHqrT5fb6WgcTcQf0A9AvpfCTB4QfRciX6BMf4sOGfzhYL/zADY3l/qPsHP
         vi559lYMgdy4DOJ9jpDcRfJcrUtFjB4qqkUkfF2uVNjzm1uSR8rLmBTnUtq5Kcdbairf
         I66gNAuhZ/YNXz5eljPexPq6dfeSa60gTCDo1lyaTIzy/fGKghZlIjuwPrAGN1nYVxXp
         XnwrVTn02LB2BE9hgLcTbs/IHfcB5BXNvSnQkvRcjFARFvb6ngIpAlot8EeNSWSmadYP
         MxCt/8qtDnIzRlQCUYZtS/84uu9PZgXjE0udrL/364FYRsjle1IjUEjaUkcF2M+X211n
         GKXg==
X-Gm-Message-State: AOAM533JJPrlNXKXrPqxo63JNLTw+snCYru6gIr0XWFtm4CPOXKkuzCI
        rGrRV1bbH0qOxVDu7MeiN956XpWhcT31PAaNhTc=
X-Google-Smtp-Source: ABdhPJzbUsBICcUBeih0eaSUtDHk8W9ief6QR8jnCPc7EKr6RqcdxmpUhq4a4u0VPK8pNp1953EfyV9TJ0OznYhgXxQ=
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr39350026edb.85.1629754931116;
 Mon, 23 Aug 2021 14:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
 <20210806201739.472806-2-Anna.Schumaker@Netapp.com> <279C2380-566E-4FBD-9C76-0E678A22A31F@netapp.com>
In-Reply-To: <279C2380-566E-4FBD-9C76-0E678A22A31F@netapp.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 23 Aug 2021 17:41:55 -0400
Message-ID: <CAFX2JfnjQmmGq8S_Um0pAr9OJsWLg51HfL=butm-1L7Roa+p6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] nfs-sysfs: Add an nfs-sysfs.py tool
To:     "Mora, Jorge" <Jorge.Mora@netapp.com>
Cc:     steved <steved@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jorge,

On Tue, Aug 17, 2021 at 12:57 PM Mora, Jorge <Jorge.Mora@netapp.com> wrote:
>
> Hello Anna,
>
> Comments are inline.
>
> --Jorge
>
> =EF=BB=BFOn 8/6/21, 2:17 PM, "Anna Schumaker on behalf of schumaker.anna@=
gmail.com" <schumakeranna@gmail.com on behalf of schumaker.anna@gmail.com> =
wrote:
>
>     NetApp Security WARNING: This is an external email. Do not click link=
s or open attachments unless you recognize the sender and know the content =
is safe.
>
>
>
>
>     From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
>     This will be used to print and manipulate the sunrpc sysfs directory
>     files. Running without arguments prints both usage information and th=
e
>     location of the sunrpc sysfs directory.
>
>     Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>     ---
>      .gitignore                   |  2 ++
>      tools/nfs-sysfs/nfs-sysfs.py | 13 +++++++++++++
>      tools/nfs-sysfs/sysfs.py     | 18 ++++++++++++++++++
>      3 files changed, 33 insertions(+)
>      create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
>      create mode 100644 tools/nfs-sysfs/sysfs.py
>
>     diff --git a/.gitignore b/.gitignore
>     index c89d1cd2583d..a476bd20bc3b 100644
>     --- a/.gitignore
>     +++ b/.gitignore
>     @@ -84,3 +84,5 @@ systemd/rpc-gssd.service
>      cscope.*
>      # generic editor backup et al
>      *~
>     +# python bytecode
>     +__pycache__
>     diff --git a/tools/nfs-sysfs/nfs-sysfs.py b/tools/nfs-sysfs/nfs-sysfs=
.py
>     new file mode 100755
>     index 000000000000..8ff59ea9e81b
>     --- /dev/null
>     +++ b/tools/nfs-sysfs/nfs-sysfs.py
>     @@ -0,0 +1,13 @@
>     +#!/usr/bin/python
>     +import argparse
>     +import sysfs
>     +
>     +parser =3D argparse.ArgumentParser()
>     +
>     +def show_small_help(args):
>     +    parser.print_usage()
>     +    print("sunrpc dir:", sysfs.SUNRPC)
>     +parser.set_defaults(func=3Dshow_small_help)
>     +
>     +args =3D parser.parse_args()
>     +args.func(args)
>     diff --git a/tools/nfs-sysfs/sysfs.py b/tools/nfs-sysfs/sysfs.py
>     new file mode 100644
>     index 000000000000..0b358f57bb28
>     --- /dev/null
>     +++ b/tools/nfs-sysfs/sysfs.py
>     @@ -0,0 +1,18 @@
>     +import pathlib
>     +import sys
>     +
>     +MOUNT =3D None
>     +with open("/proc/mounts", 'r') as f:
>     +    for line in f:
> JM: The following could select the wrong mount line.
>     +        if "sysfs" in line:
> JM: Match "sysfs" at the beginning of the line instead:
>               if re.search(r"^sysfs\s", line):

On my system, the beginning of the line is "sys" and not "sysfs". Is
it called "sysfs" on yours? That might be something I need to account
for if it's different.

Anna

>     +            MOUNT =3D line.split()[1]
>     +            break
>     +
> JM: The preferred way is to use "MOUNT is None", but this is just a guide=
line and it should work either way.
>     +if MOUNT =3D=3D None:
>     +    print("ERROR: sysfs is not mounted")
>     +    sys.exit(1)
>     +
>     +SUNRPC =3D pathlib.Path(MOUNT) / "kernel" / "sunrpc"
>     +if not SUNRPC.is_dir():
>     +    print("ERROR: sysfs does not have sunrpc directory")
>     +    sys.exit(1)
>     --
>     2.32.0
>
>
