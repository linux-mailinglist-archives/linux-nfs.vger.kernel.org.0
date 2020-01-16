Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E313FAC3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgAPUlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:41:09 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:40873 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgAPUlJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:41:09 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id r8h72100S2DhmGq018h7mN; Thu, 16 Jan 2020 21:41:08 +0100
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
Date:   Thu, 16 Jan 2020 21:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579207268; bh=aRsOXxpOsBYJlJp85E8OrjFaGlwIeos7jMzC8ZOkXvs=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=M+IJX48q/OWqrNyyqDbN4frVP1Qgl+SB6ONorgKKCfLtVh/1g3SDLXbDXueOER/9u
         hqavduz9vpndrC+gviMXgUefn94dDt1/S8kc7XF9+/A2TbU5aRL0JwlQCH1hNTGllv
         civlUNbm/8eqqk+hfNhK7c1xVCodJ00/4DqUfGwZ2ATKn2P7QOopvdSaLzToTvGEM8
         d6/sxfZX8A3VAVaTBxlN25B9vRMdqve54JpMHXkG7e2ORTireG8EeHFrGkMnCNcOR/
         D5wt58xcZ5whVSR9wB8q4wVWoF42v6ufBm+XtLKYQuThrERvrfR4iknaN08NRpnbwA
         mdgZslRBCM2gA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/16/20 9:37 PM, Steve Dickson wrote:
> 
> 
> On 1/13/20 11:29 AM, Giulio Benetti wrote:
>> Giulio Benetti (3):
>>    rpcgen: bump to latest version
>>    rpcgen: rpc_cout: silence format-nonliteral
>>    support: nfs: rpc_socket: silence unused parameter warning on salen
>>
>>   support/nfs/rpc_socket.c   |    2 +
>>   tools/rpcgen/Makefile.am   |   24 +-
>>   tools/rpcgen/proto.h       |   65 ++
>>   tools/rpcgen/rpc_clntout.c |  458 +++++---
>>   tools/rpcgen/rpc_cout.c    | 1269 ++++++++++++----------
>>   tools/rpcgen/rpc_hout.c    |  915 +++++++++-------
>>   tools/rpcgen/rpc_main.c    | 2083 +++++++++++++++++++++---------------
>>   tools/rpcgen/rpc_parse.c   | 1055 +++++++++---------
>>   tools/rpcgen/rpc_parse.h   |  103 +-
>>   tools/rpcgen/rpc_sample.c  |  465 ++++----
>>   tools/rpcgen/rpc_scan.c    |  812 +++++++-------
>>   tools/rpcgen/rpc_scan.h    |   91 +-
>>   tools/rpcgen/rpc_svcout.c  | 1647 +++++++++++++++-------------
>>   tools/rpcgen/rpc_tblout.c  |  265 ++---
>>   tools/rpcgen/rpc_util.c    |  656 ++++++------
>>   tools/rpcgen/rpc_util.h    |  170 ++-
>>   tools/rpcgen/rpcgen.1      |  442 ++++++++
>>   17 files changed, 6123 insertions(+), 4399 deletions(-)
>>   create mode 100644 tools/rpcgen/proto.h
>>   create mode 100644 tools/rpcgen/rpcgen.1
>>
> Committed... (tag nfs-utils-2-4-3-rc5)... Nice work!!!

Wooho! Thank you :-)

As soon as you release version 2.4.3 I'm going to bump version in 
Buildroot too, at the moment it's still 1.3.4.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas
