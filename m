Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE551140402
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 07:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgAQGag (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 01:30:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAQGag (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 01:30:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so6249943wmc.2
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2020 22:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HChZvpIqJbRkMbQ2FqysU1ayM2qnJmEE0K3w5QEYfLI=;
        b=NWGXH9YP0e8aN7Jsi5C5RLABEU2OV7BIBBzZvkoBGCXWNWWQsTQQ9c1KsN4LuIlg4W
         mBEw8zZ2H9jVCLYWq/oitV2wtguAAemwodQuIf+TLV8xp6wbsmHIdZEvrLT76e6dd9Qk
         o+fEWAZ2l6tLEpwLpN2rXjubBFrnZvyOPsYx49q+vlio+ONG0wNzYlX/HKOMTFFwOnKc
         48f9/5NJHPiXUHjw5EWiAmZ8dHqzGWuqKbk2OXJWJgMwfO8NBvwws0MhOvhy0YtTlgAh
         YMSyxyau/0PiLP9YjOABJFUug3EvtSDkNBZGCAZ7DF5uyElIuW+v+THMksUYJg9rUJGM
         PPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HChZvpIqJbRkMbQ2FqysU1ayM2qnJmEE0K3w5QEYfLI=;
        b=qDL1mE2k1sLhHd1tjHo3frJ40f9j7FrC7ua9L5FPkUFaUf63d+6B+aFVDQ68229a3O
         Zw8VI8nlRSDf1nRPHhreukHLBCMA75hOuvF+gxoqSGsfw9qlG3Aajq3ojGv6MYsypusZ
         DZJj8jENWx7GGlB9KmrOeSY490NI+BsMnprNBBOoNoF3kXv4MGOgqm8Hg1yaz+e8LZQg
         RJn9bFZntjQoAHCHkgnnFc5eVxXZTkjOSedV6K8F8ZAd7cZSlbaNA9TBhdxKGQLbudrE
         tVa1Ruv3jQgd/49JsDn0/z6Bv2cGjlg1YVGzPcdWwywP9BPenrbX6Lut77JdbakpcVmp
         hQTQ==
X-Gm-Message-State: APjAAAWccryRYpglgMj3R9FmuPHcvDpg/Cy0fD/ebKDrxVisnU5ue65f
        Rue2V18bQPyFvNiWiMoPPC0=
X-Google-Smtp-Source: APXvYqw9KZtZa/6hZzwsOUzHceUrVAjf5CkEMWN0FNus7kkUZJYSycJnE242sp0mgeMjJ8WxQSi9uQ==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr2812486wml.18.1579242635159;
        Thu, 16 Jan 2020 22:30:35 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id k82sm8344621wmf.10.2020.01.16.22.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 22:30:34 -0800 (PST)
Date:   Fri, 17 Jan 2020 07:30:32 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
Message-ID: <20200117063032.GA6351@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
 <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
 <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
 <c1e96762-0f3a-b465-da1b-f7bc7a687948@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1e96762-0f3a-b465-da1b-f7bc7a687948@RedHat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Giulio,

[Cc: Mike]

> On 1/16/20 3:44 PM, Giulio Benetti wrote:
> > On 1/16/20 9:41 PM, Giulio Benetti wrote:
> >> On 1/16/20 9:37 PM, Steve Dickson wrote:


> >>> On 1/13/20 11:29 AM, Giulio Benetti wrote:
> >>>> Giulio Benetti (3):
> >>>>     rpcgen: bump to latest version
> >>>>     rpcgen: rpc_cout: silence format-nonliteral
> >>>>     support: nfs: rpc_socket: silence unused parameter warning on salen

> >>>>    support/nfs/rpc_socket.c   |    2 +
> >>>>    tools/rpcgen/Makefile.am   |   24 +-
> >>>>    tools/rpcgen/proto.h       |   65 ++
> >>>>    tools/rpcgen/rpc_clntout.c |  458 +++++---
> >>>>    tools/rpcgen/rpc_cout.c    | 1269 ++++++++++++----------
> >>>>    tools/rpcgen/rpc_hout.c    |  915 +++++++++-------
> >>>>    tools/rpcgen/rpc_main.c    | 2083 +++++++++++++++++++++---------------
> >>>>    tools/rpcgen/rpc_parse.c   | 1055 +++++++++---------
> >>>>    tools/rpcgen/rpc_parse.h   |  103 +-
> >>>>    tools/rpcgen/rpc_sample.c  |  465 ++++----
> >>>>    tools/rpcgen/rpc_scan.c    |  812 +++++++-------
> >>>>    tools/rpcgen/rpc_scan.h    |   91 +-
> >>>>    tools/rpcgen/rpc_svcout.c  | 1647 +++++++++++++++-------------
> >>>>    tools/rpcgen/rpc_tblout.c  |  265 ++---
> >>>>    tools/rpcgen/rpc_util.c    |  656 ++++++------
> >>>>    tools/rpcgen/rpc_util.h    |  170 ++-
> >>>>    tools/rpcgen/rpcgen.1      |  442 ++++++++
> >>>>    17 files changed, 6123 insertions(+), 4399 deletions(-)
> >>>>    create mode 100644 tools/rpcgen/proto.h
> >>>>    create mode 100644 tools/rpcgen/rpcgen.1

> >>> Committed... (tag nfs-utils-2-4-3-rc5)... Nice work!!!

> >> Wooho! Thank you :-)

> >> As soon as you release version 2.4.3 I'm going to bump version in
> >> Buildroot too, at the moment it's still 1.3.4.

> > Ah, I've forgot that on xtensa it fails building and need this patch to be applied to:
> > https://patchwork.kernel.org/patch/11335261/

> > If you have the chance to commit before releasing version it would be great!
> Your patch on my radar... but... conflicts  with Petr's cross-compilation patch
> https://lore.kernel.org/linux-nfs/20200114183603.GA24556@dell5510/T/#t

> That patch causes an automake warnings which is something I'm trying to avoid.

> No worries... I will not do a release w/out your patch.... or something close to it. 

Giulio, thanks for your patch. I'll have a look on it over a weekend.
Maybe Mike's cross-compilation patch is really not needed.

> steved.

Kind regards,
Petr
