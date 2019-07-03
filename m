Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6830A5E02E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCIso (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 04:48:44 -0400
Received: from mout.web.de ([212.227.17.12]:57429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCIso (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 04:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562143714;
        bh=oSogCEvLBhE8Pwcc3O2A1tkH4tmzHlmq2o/v4pZFOwY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g43XbkzY95r2Gt9R+/EaZi9dynCgk7VL60b7RtYLM5Nkx59CIFPQ/t4Jk69KbAhoK
         cWrDzq0Jkd/XmYtHQ6T4xEbOblDbg5M5XcWY2Gr3OZNMqOx8uv/eek8yPXdjw0o2UH
         v8z3d9MP6yKUzQMAX/OUR8eD1IDSQrqSTzkzqozY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lba35-1iPJ8r1d0N-00lEkv; Wed, 03
 Jul 2019 10:48:34 +0200
Subject: Re: [PATCH] NFS: Less function calls in show_pnfs()
To:     Julia Lawall <julia.lawall@lip6.fr>, linux-nfs@vger.kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <d2f73c3e-a55f-5fb7-a8f8-0dc3ce8ff8a5@web.de>
 <alpine.DEB.2.20.1907031018000.4456@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ed599239-a6a2-1cc6-14ce-d5bb41e9170f@web.de>
Date:   Wed, 3 Jul 2019 10:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1907031018000.4456@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wS97GMtf02Qb0OoQ7G5lnJGGwZoRd4bCVUkYYE+vMesqRrZL00C
 u9IydzvHCLjA6QxM5hDINuis3aMtY3a91tXACZOpCRjSOxH5nb66L7EzVlTVmJlVtwgUp3y
 GqjoXhcWKycrxYj2Kk7pD3r1JlFsxNPeposjbJ8oGQqCSgc/bGRY0MZygA0xphjERdJfo/R
 ulV2LMGlz15AqK542algQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BGAG3bulBqc=:cXiraffRQTRn+xr/6rwpJ4
 StO0x5srenSubqzKuJSg0tpP4HBsv/VvM7YbQrerN5mciYAFklXs+DFzQgXNG8IjT3Pulr3uQ
 XdqYksK4lI00MfLy8WXcs1It3icXDNB6WgkMhcJ+G4dJOVSu/47wS3MVbzXv49mapRbsLpzuH
 EwapU7vgnkdqb5PWz4dxmo+sxvjzxsXNVpg3ZkhsbQR8OuJIvr8d0R12KAFL6qBAedtGYAgf2
 aRi621CZt9wYm7qpk9IZ/KeEWw598UDNNrliFvieljxIL5goV+u7BjeNdGRB2aEha9LW7kcSR
 YLebWxmIUUf3gQC3l3usVbzkScgV+JvKJPqHXmhbjbegESPTZc0zjYncH9VQ3/AR/CkncWUmz
 1jSLRHGd6o2UsF50yY26ARIkchkPrCWu09qqcmnAjZR/qI0I2GzENinNosIslHdFC99VI/ctr
 oPVdYQ9EXGVAqS/kDrdSC9BfwYMAEgwK+FZHdcmQXyJteD7HZ7vCteOJlwyNkWDk7tqe8qYwQ
 IEvfMkE73Ji9BvtprbPZ57aV/qwYLhWnbNGA8+r+tCTNbhpmSYHuLB9Ail05e5x/I6lYLL3nG
 jg/yWI6Tt/uHlAPFdvRsWRXd5MHkKjzm4z4IdoAy+z5Cvkiu/l9cEu5+htsgYOeFRhpVcV9ON
 hO/mGpy8NJAGDe0/F98utQ8oyoKCzlqk8EhENTrI1M7nSg//cse/8VC0iZIPzMKY9Qo23cTGM
 mCd3KEDb4s1R3RhfYPmtwWp4n4vmAmnbvE3EPOPpVmkZBOwib/6XIQF9iog0mDiMIaL6aFIoK
 JkMZ55jGmccFapIqTYg2t7gODFcmLkfxq3qzqaIvyWamK/CVI9VKFhnawfa3e6V9yZZ0yNNZD
 yK6Gm/wTyWu7uBjwlCnuRwZoVcIe+iUARQjfFQkt3dR/4XDo3Ngr4fKU8eURvgnU+zrq/nCGA
 Evf92ylJecbM9IMJ6yBriv50VafmPWNZUPpzVI1jXEaU7/AtR2YMnxDCig+WBkxmTE5W/mLnu
 Nu5g1NI9k/PMi6wrs48WUpDB8snO6jt/muCyo9mJXGsa0dUiXoo1UDeoFr5RNHdFauHb8kZjm
 aZPgbZv01/vvceorAiXaXSAgVoYxUSAH19P
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>> +++ b/fs/nfs/super.c
>> @@ -749,11 +749,10 @@ static void show_sessions(struct seq_file *m, str=
uct nfs_server *server) {}
>>  #ifdef CONFIG_NFS_V4_1
>>  static void show_pnfs(struct seq_file *m, struct nfs_server *server)
>>  {
>> -	seq_printf(m, ",pnfs=3D");
>> -	if (server->pnfs_curr_ld)
>> -		seq_printf(m, "%s", server->pnfs_curr_ld->name);
>> -	else
>> -		seq_printf(m, "not configured");
>> +	seq_printf(m, ",pnfs=3D%s",
>> +		   server->pnfs_curr_ld
>> +		   ? server->pnfs_curr_ld->name
>> +		   : "not configured");
>
> Unreadable.

* Do you find any other source code formatting more readable
  for the usage of the ternary operator?

* How do you think about the general software transformation possibility
  (at this place)?

Regards,
Markus
