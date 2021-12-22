Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0047CCC7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Dec 2021 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbhLVGGM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Dec 2021 01:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhLVGGL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Dec 2021 01:06:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F704C061574;
        Tue, 21 Dec 2021 22:06:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 8C0121F43FE1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1640153170; bh=8gJhbItaHWtXAGQBnNApUCpJbX0QfBZk1NdEBMMiaik=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g8UEvBERjahtMGC3pDLI+wlsQwnkaJPI+1zQIEnxTYb1ibOFzwqy385ChCPeJ2RDr
         qhlpp5sLkNZGyOPascmRqqzF7EDo/rNlkNjXVaPLblhWgTMJI7Wf2+djHeXasUntqE
         aoMn8YqGrWDd6/nxjHBd9FQI5eeuiwHyeMv7ZKlQRtSHQIDLJkRUKhV95/NmVnv65O
         TxPxYtVaaLQmQ9H7KmRyiX3UQcHZPGmre4/0boPmgEzyRKtiejf4BfZ0a11OwA6fSN
         +iAfO9OLBFBqSCxftdesQ2jKFBIMlYZiIK/+SsqRi14W8Bw8yHFhRrx7xhR0o0qEjC
         AQv9foLpE7lLw==
Subject: Re: [PATCH] nfs: check nf pointer for validity before use
To:     Konstantin Ryabitsev <konstantin.ryabitsev@linux.dev>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
References: <05877B02-900A-4B22-9460-D2F0D20931DC@oracle.com>
 <YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64>
 <f8459dd30802e4da915c63f6b70263e6@linux.dev>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <68222978-eb24-cf94-9fb5-4421cbb2b2c8@collabora.com>
Date:   Wed, 22 Dec 2021 07:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f8459dd30802e4da915c63f6b70263e6@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12/21/21 11:18 PM, Konstantin Ryabitsev wrote:
> December 21, 2021 3:00 PM, "Chuck Lever III" <chuck.lever@oracle.com> wrote:
>> Btw, b4 complained about collabora.com's DKIM:
>>
>> [cel@bazille linux]$ b4 am
>> https://lore.kernel.org/linux-nfs/YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64/raw
>> Grabbing thread from
>> lore.kernel.org/linux-nfs/YcIjJ4jN3ax1rqaE%40debian-BULLSEYE-live-builder-AMD64/t.mbox.gz
>> Analyzing 1 messages in the thread
>> Checking attestation on all messages, may take a moment...
>> ---
>> ✗ [PATCH] nfs: check nf pointer for validity before use
>> ---
>> ✗ BADSIG: DKIM/collabora.com
> 
> This is because collabora.com has DKIM canonicalization configured as "c=simple/simple". See my previous message to intel.com for why this should be changed to c=relaxed/simple:
> 
> https://lore.kernel.org/lkml/20211214150032.nioelgvmase7yyus@meerkat.local/

Thank you both, Chuck and Konstantin,

I have forwarded this conversation to our sysadmin team.

Best regards,

Tomeu
