Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7189513FB14
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 22:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgAPVIg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 16:08:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46725 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726527AbgAPVIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 16:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579208914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ck2fMW4AXvCLBhjacPUp/E3gyVo4dBCVG/ydoZPZeY=;
        b=DrHHHprWnK+C5lM/QcWk0sanaIJYg8wtWj/AmLbhn8l3+5zxDolgctKG1oc3DSarvgN0ki
        q/H0rCMrPiN7CO6nC0yI2uv+uxVPGF1mAI5R4JPbBk/4i7uLHV/6DuqsvbgjVyroVEJiiU
        nOYAwAbuSheKmtSnwmHz+MrP4omRnKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-iNyBlyLHPD6BiNosQhePKw-1; Thu, 16 Jan 2020 16:08:32 -0500
X-MC-Unique: iNyBlyLHPD6BiNosQhePKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D09800D48;
        Thu, 16 Jan 2020 21:08:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4E85D9C9;
        Thu, 16 Jan 2020 21:08:30 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
 <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
 <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c1e96762-0f3a-b465-da1b-f7bc7a687948@RedHat.com>
Date:   Thu, 16 Jan 2020 16:08:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/16/20 3:44 PM, Giulio Benetti wrote:
> On 1/16/20 9:41 PM, Giulio Benetti wrote:
>> On 1/16/20 9:37 PM, Steve Dickson wrote:
>>>
>>>
>>> On 1/13/20 11:29 AM, Giulio Benetti wrote:
>>>> Giulio Benetti (3):
>>>> =A0=A0=A0 rpcgen: bump to latest version
>>>> =A0=A0=A0 rpcgen: rpc_cout: silence format-nonliteral
>>>> =A0=A0=A0 support: nfs: rpc_socket: silence unused parameter warning=
 on salen
>>>>
>>>> =A0=A0 support/nfs/rpc_socket.c=A0=A0 |=A0=A0=A0 2 +
>>>> =A0=A0 tools/rpcgen/Makefile.am=A0=A0 |=A0=A0 24 +-
>>>> =A0=A0 tools/rpcgen/proto.h=A0=A0=A0=A0=A0=A0 |=A0=A0 65 ++
>>>> =A0=A0 tools/rpcgen/rpc_clntout.c |=A0 458 +++++---
>>>> =A0=A0 tools/rpcgen/rpc_cout.c=A0=A0=A0 | 1269 ++++++++++++---------=
-
>>>> =A0=A0 tools/rpcgen/rpc_hout.c=A0=A0=A0 |=A0 915 +++++++++-------
>>>> =A0=A0 tools/rpcgen/rpc_main.c=A0=A0=A0 | 2083 +++++++++++++++++++++=
---------------
>>>> =A0=A0 tools/rpcgen/rpc_parse.c=A0=A0 | 1055 +++++++++---------
>>>> =A0=A0 tools/rpcgen/rpc_parse.h=A0=A0 |=A0 103 +-
>>>> =A0=A0 tools/rpcgen/rpc_sample.c=A0 |=A0 465 ++++----
>>>> =A0=A0 tools/rpcgen/rpc_scan.c=A0=A0=A0 |=A0 812 +++++++-------
>>>> =A0=A0 tools/rpcgen/rpc_scan.h=A0=A0=A0 |=A0=A0 91 +-
>>>> =A0=A0 tools/rpcgen/rpc_svcout.c=A0 | 1647 +++++++++++++++----------=
---
>>>> =A0=A0 tools/rpcgen/rpc_tblout.c=A0 |=A0 265 ++---
>>>> =A0=A0 tools/rpcgen/rpc_util.c=A0=A0=A0 |=A0 656 ++++++------
>>>> =A0=A0 tools/rpcgen/rpc_util.h=A0=A0=A0 |=A0 170 ++-
>>>> =A0=A0 tools/rpcgen/rpcgen.1=A0=A0=A0=A0=A0 |=A0 442 ++++++++
>>>> =A0=A0 17 files changed, 6123 insertions(+), 4399 deletions(-)
>>>> =A0=A0 create mode 100644 tools/rpcgen/proto.h
>>>> =A0=A0 create mode 100644 tools/rpcgen/rpcgen.1
>>>>
>>> Committed... (tag nfs-utils-2-4-3-rc5)... Nice work!!!
>>
>> Wooho! Thank you :-)
>>
>> As soon as you release version 2.4.3 I'm going to bump version in
>> Buildroot too, at the moment it's still 1.3.4.
>=20
> Ah, I've forgot that on xtensa it fails building and need this patch to=
 be applied to:
> https://patchwork.kernel.org/patch/11335261/
>=20
> If you have the chance to commit before releasing version it would be g=
reat!
Your patch on my radar... but... conflicts  with Petr's cross-compilation=
 patch
https://lore.kernel.org/linux-nfs/20200114183603.GA24556@dell5510/T/#t

That patch causes an automake warnings which is something I'm trying to a=
void.

No worries... I will not do a release w/out your patch.... or something c=
lose to it.=20

steved.

