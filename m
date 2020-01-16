Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5613FACC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgAPUoy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:44:54 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:40873 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAPUoy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:44:54 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id r8kr2100N2DhmGq018ksQf; Thu, 16 Jan 2020 21:44:52 +0100
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
 <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
Message-ID: <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
Date:   Thu, 16 Jan 2020 21:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579207492; bh=+J9tx5wNgsnM1r9UZZ+lblLw0mtjstJGQKn3p9G6YAc=;
        h=Subject:From:To:Date:MIME-Version:Content-Type;
        b=ldIa8/ycUlbek1UkdQ/toAXNR0BzPrnUfiG4hLbhOwzScspup04T4RnGx1J+H2ndf
         cqOZHMHRFu9LRUk6X33wSe/SISKg+9E1XnQUC6HCx1ZKdGmy6FqDBbMSOkvoARsIoY
         0tEgivJ8HGpH2JG2ueXaC5mD6zbLET9k+g+DH2dUOrqHWv1YIgDojqwA0bpTakU2oI
         yXatE3KagwaOjSatP/L5AR6VKAO8tLKdp5KftNZnRKmKACuKJpJBgkJCcHHu+9PuFT
         +IoCHumaDfuHLRgfV4VDq3oXYdu6h/s6ZlBRqRzbDxO5947dXT7jW5z2CQOUXzkGLe
         3l8B/v5/dKAsg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/16/20 9:41 PM, Giulio Benetti wrote:
> On 1/16/20 9:37 PM, Steve Dickson wrote:
>>
>>
>> On 1/13/20 11:29 AM, Giulio Benetti wrote:
>>> Giulio Benetti (3):
>>>     rpcgen: bump to latest version
>>>     rpcgen: rpc_cout: silence format-nonliteral
>>>     support: nfs: rpc_socket: silence unused parameter warning on salen
>>>
>>>    support/nfs/rpc_socket.c   |    2 +
>>>    tools/rpcgen/Makefile.am   |   24 +-
>>>    tools/rpcgen/proto.h       |   65 ++
>>>    tools/rpcgen/rpc_clntout.c |  458 +++++---
>>>    tools/rpcgen/rpc_cout.c    | 1269 ++++++++++++----------
>>>    tools/rpcgen/rpc_hout.c    |  915 +++++++++-------
>>>    tools/rpcgen/rpc_main.c    | 2083 +++++++++++++++++++++---------------
>>>    tools/rpcgen/rpc_parse.c   | 1055 +++++++++---------
>>>    tools/rpcgen/rpc_parse.h   |  103 +-
>>>    tools/rpcgen/rpc_sample.c  |  465 ++++----
>>>    tools/rpcgen/rpc_scan.c    |  812 +++++++-------
>>>    tools/rpcgen/rpc_scan.h    |   91 +-
>>>    tools/rpcgen/rpc_svcout.c  | 1647 +++++++++++++++-------------
>>>    tools/rpcgen/rpc_tblout.c  |  265 ++---
>>>    tools/rpcgen/rpc_util.c    |  656 ++++++------
>>>    tools/rpcgen/rpc_util.h    |  170 ++-
>>>    tools/rpcgen/rpcgen.1      |  442 ++++++++
>>>    17 files changed, 6123 insertions(+), 4399 deletions(-)
>>>    create mode 100644 tools/rpcgen/proto.h
>>>    create mode 100644 tools/rpcgen/rpcgen.1
>>>
>> Committed... (tag nfs-utils-2-4-3-rc5)... Nice work!!!
> 
> Wooho! Thank you :-)
> 
> As soon as you release version 2.4.3 I'm going to bump version in
> Buildroot too, at the moment it's still 1.3.4.

Ah, I've forgot that on xtensa it fails building and need this patch to 
be applied to:
https://patchwork.kernel.org/patch/11335261/

If you have the chance to commit before releasing version it would be great!

Kind regards
-- 
Giulio Benetti
Benetti Engineering sas
