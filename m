Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C896938965F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhESTQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESTQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 15:16:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC1C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 12:15:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l1so21564349ejb.6
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kEdhJuw4yF0NLtZKwPahXHGndrW+9fUlIqg+Y+DlLf4=;
        b=N/BwlOB5NWdeQ/Xxsy0Pa8gHARdX2U5svU1AZLH4Z1gnxa2bJD3CEAS8Aa9WGu/BcV
         ttZtnD82zN4AgtR7/qUB6/KnYMwtu+vAfur7n2XXF891eCDNzMVYBLJDNHiqIP1ssMTZ
         YOI5qUU6rVVWb0kUQhQ/WFyEMAS38+CVK+/1Qrxl9557uJsnIqiTfphclOEEMLSKqV8Y
         N4C4Gj5E54ZtgsaT115uIveSCH8MahQk+MaWqfBSVQzzA5GRbQxnfBrKFNsqKE6cDMsd
         4HlMttNiRI2oL7euZfGVBxa9r6Sz6JaND2SnwpYroiv2X4G04GIaD/reBF6NLrcJTHH/
         2hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEdhJuw4yF0NLtZKwPahXHGndrW+9fUlIqg+Y+DlLf4=;
        b=dhz5ss4cwll2n0d/qn4tCy8IZzj+2ScJFPUzXUlS51RaEEMZv1WR0QRHJxZpCTxEE3
         Z6w8ms8JYvrBzcTFzAvtTvdxmKeU/jmXfTqZCchqKED4Ph6Ma68r7tknuXqsFlNgyuis
         S2au2JdHxiza+SHLT4cUy98i36/X3yPPRH/O34Zuy13nJ1VNk+eHPGvRgWlzrQv2aO1J
         ZK0mLth6EZo0KMyj/p5tdYt8dY6aN66WUV4PeN7ue1Ry5B9mKK1On2Uczj9nBHfxOH6v
         KtbU3FSpcc6tAiC95hzFwtZY0QlLl9VYnvj3TCqPU4xNu1R853P5CM21qnbq4GS5Me75
         BmKQ==
X-Gm-Message-State: AOAM531i/KWx653ViMGYWT3z1pYJY9CvTWQ0jea24F/m62/q0sgq3Wa0
        en4CwXKpazxhrvbET3z7NoCcSiBKJV8DTzCNNNsL5PBWA0QIxA==
X-Google-Smtp-Source: ABdhPJzUkQVVF6O/RFmPs442yAG0okxitjHe2bz0bVnqWeF/NK1qeju6vsgZF/uQJ7eimYYBuQjb2iZiCCQMer0qoqk=
X-Received: by 2002:a17:906:584e:: with SMTP id h14mr703839ejs.432.1621451724434;
 Wed, 19 May 2021 12:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 19 May 2021 15:15:12 -0400
Message-ID: <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> Hi,
>
> We're seeing what looks like an NFSv4 issue.
>
> Mounting an NFS server that is down (ping to this NFS server's IP address=
 does not respond) will block _all_ other NFS mount attempts even if the NF=
S servers are available and working properly (these subsequent mounts hang)=
.
>
> If I kill the NFS mount process that's trying to mount the dead NFS serve=
r, the NFS mounts that were blocked will immediately unblock and mount succ=
essfully, which suggests the first mount command is blocking the other moun=
t commands.
>
>
> I verified this behavior using a newly built mount.nfs command from the r=
ecent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cloud=
 Image 21.04:
> * https://sourceforge.net/projects/nfs/files/nfs-utils/2.5.3/
> * https://cloud-images.ubuntu.com/releases/hirsute/release-20210513/ubunt=
u-21.04-server-cloudimg-amd64.ova
>
>
> The reason this looks like it is specific to NFSv4 is from the following =
output showing "vers=3D4.2":
> > $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt
> > [ ... cut ... ]
> > mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=3D4=
.2,addr=3D<unreachable-IP-address>,clien"...^C^Z
>
> Also, if I try the same mount.nfs commands but specifying NFSv3, the moun=
t to the dead NFS server hangs, but the mounts to the operational NFS serve=
rs do not block and mount successfully; this bug doesn't happen when using =
NFSv3.
>
>
> We reported this issue under util-linux here:
> https://github.com/karelzak/util-linux/issues/1309
> [mounting nfs server which is down blocks all other nfs mounts on same ma=
chine #1309]
>
> I also found an older bug on this mailing list that had similar symptoms =
(but could not tell if it was the same problem or not):
> https://patchwork.kernel.org/project/linux-nfs/patch/87vaori26c.fsf@notab=
ene.neil.brown.name/
> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]
>
> Thanks, Mike

Hi Mike,

This is not a helpful reply but I was curious if I could reproduce
your issue but was not successful. I'm able to initiate a mount to an
unreachable-IP-address which hangs and then do another mount to an
existing server without issues. Ubuntu 21.04 seems to be 5.11 based so
I tried upstream 5.11 and I tried the latest upstream nfs-utils
(instead of what my distro has which was an older version).

To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.
Or also get output from dmesg after doing =E2=80=9Cecho t >
/proc/sysrq-trigger=E2=80=9D to see where the mounts are hanging.
