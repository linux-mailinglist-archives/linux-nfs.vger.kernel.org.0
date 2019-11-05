Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FCF029B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 17:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbfKEQYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Nov 2019 11:24:14 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35510 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389934AbfKEQYN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Nov 2019 11:24:13 -0500
Received: by mail-ua1-f50.google.com with SMTP id n41so6339278uae.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2019 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brKyWuiRSBbfzJIeK8v2lrMOJcTG33kGw9sssUReCKA=;
        b=YDxIdLV1tYmRvwfwmmeVmwTI/+kx2wzydASeg+CyBHJ0/yH+zlodcW6R7mY4XgDUP1
         2KdQkuQqPWfhIxgguN1fcYEoK0h7RE5jbVFV4a4QvMvxrq4eqBs7G88V8AuNBfHcVnnt
         upm8gNvXY5O7ZDy51zL0Mbdxrp+MYvWkdYERi+bAG/5gp7EpmE1oDF2pZyX5GExKtOsA
         B3oWBxWn7mAfTP0CTlbYARiAV3zSIMRPwH1cea1N5hvd81q1FMvogKiss0JYDlPbgOSV
         5+g2sgiEmAay3xczkwpwOCiLresZBhKLd2IJZ+tp1kid+NCCp+z+yEHdO+6jtvTBMjhx
         lpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brKyWuiRSBbfzJIeK8v2lrMOJcTG33kGw9sssUReCKA=;
        b=Kp4p9wtBLFU8HlUVSH1vPvzAyHlPeLUv2MmqVY65HC8quXwvkgIS3RF/o7i9+BE4vq
         dQHGZFzuI++ia1tcgPj7bjfnnYliggvcCx5UQbyd7ZTg8d66Qe2UTKn90IjubKA+uu5E
         RH7vLV5141/PFFfuUeEHDizjwRQs5oHepDCGIVOTW9xaMM6NmM1e+EWcpv27gKqgV02T
         QF3x0Kf/x7f3utV1Xie3if5lKasRIw1OaycO/rIwvrOnMzvZWYagE3RjO0Ft/Tw0jysI
         mUe56Mee6lnT2b0j7fL4ymHQw2d1hL88VYyNP50BkbdfFX71r2aEbmyaGUTG/7pxUuzO
         BzHg==
X-Gm-Message-State: APjAAAVWDYmpP0s3dTL74WqvqyCkW8yN2MaRubT7xU1EqwBIjGD8Vk7S
        85Cdo8MWj7jjD8PS5mjxopYAl9M37ohgdHbrYjQC3A==
X-Google-Smtp-Source: APXvYqyV0ywNRVpowQpc8NpbO3A/B8gt6YsT2xi9Boy7+kslKT2y3LmHTyNccSpWanRc26L2iLOqoMrxt045Lbc7Rig=
X-Received: by 2002:ab0:6044:: with SMTP id o4mr12710700ual.119.1572971052187;
 Tue, 05 Nov 2019 08:24:12 -0800 (PST)
MIME-Version: 1.0
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org> <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
 <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
 <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu> <1079a074-7580-e257-8b52-6e48f8822176@genome.arizona.edu>
In-Reply-To: <1079a074-7580-e257-8b52-6e48f8822176@genome.arizona.edu>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 5 Nov 2019 11:24:01 -0500
Message-ID: <CAN-5tyExtO_HRGYrqq7UTObrHNsTp7UqwW=Kg4CFM3q-OnaUiQ@mail.gmail.com>
Subject: Re: NFS hangs on one interface
To:     Chandler <admin@genome.arizona.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It's too hard to read this tcpdump-style network trace with multiple
nfs streams (a full .cap file would be much better) (internals of the
packets are hidden).

Some things that stick out. If you are doing a v4.0 mount, it
typically would start with a SETCLIENTID. Yours starts with a
PUTROOTFH which means you already have a 4.0 mount going to this
server. "cat /proc/fs/nfsfs/server" would show you mounts to that
server. If you are not expecting that you already had an existing 4.0
mount (ie., your "mount" command doesn't show that server mounted),
then things have gone wrong already and you have a stuck mount which
might be interfering with further mounts.

Are you experiencing issues with a fresh boot ? do you have an
ability/luxury to reboot the client machine?

Your problem description is confusing. Your last network trace is
about a failing v4.0 mount. Your initial description is talking about
mounting with "vers=3" or "vers=2". So is the problem with a specific
nfs version or is the problem with mounting over 10GB interface with
any NFS versions?

You can also turn on rpcdebug messages (if your client machine isn't
getting a lot of NFS traffic) but given your trace I see multiple
streams so you'll have to dig thru lots of output to follow your own
NFS operations.

On Mon, Nov 4, 2019 at 7:29 PM Chandler <admin@genome.arizona.edu> wrote:
>
> Any ideas what's going on here?
> Thanks
