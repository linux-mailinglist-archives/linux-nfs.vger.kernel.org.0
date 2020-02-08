Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443EF156396
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2020 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgBHJVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Feb 2020 04:21:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726714AbgBHJVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Feb 2020 04:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581153667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHkCBtQnwSeBIcCdE0wD8scfGUBmbO2Y5WNltDpFCY0=;
        b=Vnmk89LW395tplGy/RPGyv4ULKhzfM/YdAkSGOowpaR3wfB84xP27aYZw3MCwXvfoEGGc2
        PgfEidpwHtQAu08Mqe9xaT0i6i4DPGYCw/vOP4SZHXeeWBYW2w8/1B0KOphTPwZQv0aRoo
        WBcCsdn2saoVEUxBDGc4HWsZFbKEMxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-2k21jpzEMtGfWyj4B-6t4w-1; Sat, 08 Feb 2020 04:21:03 -0500
X-MC-Unique: 2k21jpzEMtGfWyj4B-6t4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA12800D5F;
        Sat,  8 Feb 2020 09:21:02 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06AF2811F8;
        Sat,  8 Feb 2020 09:21:01 +0000 (UTC)
Subject: Re: [PATCH] query_krb5_ccache: Removed dead code that was flagged by
 a covscan
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200207152109.20855-1-steved@redhat.com>
 <CAN-5tyHatMk_xsBW5MHpv7-HyiCMPS9qrz3_O6-XN5KpH_RWtA@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <17f9e558-ed00-c377-83b1-9769fd698cc9@RedHat.com>
Date:   Sat, 8 Feb 2020 04:21:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyHatMk_xsBW5MHpv7-HyiCMPS9qrz3_O6-XN5KpH_RWtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/7/20 12:25 PM, Olga Kornievskaia wrote:
> On Fri, Feb 7, 2020 at 10:22 AM Steve Dickson <steved@redhat.com> wrote:
>>
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>> ---
>>  utils/gssd/krb5_util.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
>> index bff759f..a1c43d2 100644
>> --- a/utils/gssd/krb5_util.c
>> +++ b/utils/gssd/krb5_util.c
>> @@ -1066,8 +1066,6 @@ query_krb5_ccache(const char* cred_cache, char **ret_princname,
>>                             *ret_realm = strdup(str+1);
>>                     }
>>                     k5_free_unparsed_name(context, princstring);
>> -               } else {
>> -                       found = 0;
>>                 }
> 
> Uhm, sorry wasn't fast enough for you commit decision but I don't see
> that this a dead code? krb5_unparse_string() could return an error so
> "else" is a valid condition. I mean it's probably unlikely that
> check_for_tgt() returns found and they you can't parse the principal
> name out of it. But things like memory errors could still be valid
> error conditions?
Sorry for being so quick with the commit... 

The covscan complained "warning: Value stored to 'found' is never read"
which was true... after setting found = 0, found was never used. 

Yes, the "else" is a valid condition but not necessary since
setting 'found' to zero does not do anything... 

steved.

> 
> 
>>         }
>>         krb5_free_principal(context, principal);
>> --
>> 2.24.1
>>
> 

