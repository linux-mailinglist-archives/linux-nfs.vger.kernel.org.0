Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1182E313B7A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhBHRtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 12:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235096AbhBHRsM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Feb 2021 12:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612806406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0VLa/avEsJlUrAIM8y6B8Q0ejBYNRyUbk+lcksoQ14=;
        b=fAnshSKIJwUvSZfBvAz09RTCNbr/ykRiPPWEkZa2mfts/jd3zcO6ES0kTwX55NbEqvY709
        CwHkzCc04SP9X3p02L1n+q/GyAKitFLTsW/6sZEICz02Uh8sBRTOtCcd8FHhuZIaIs2Csj
        noU+hLbWYXCjC/5fiC12DT55ANpj/vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-5C2G9pfnObWSwQUnsWdVyw-1; Mon, 08 Feb 2021 12:43:15 -0500
X-MC-Unique: 5C2G9pfnObWSwQUnsWdVyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27B5480196E;
        Mon,  8 Feb 2021 17:43:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-50.phx2.redhat.com [10.3.113.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C05605D9DC;
        Mon,  8 Feb 2021 17:43:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] mountd: Add debug processing from nfs.conf
To:     NeilBrown <neil@brown.name>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210201230147.45593-1-steved@redhat.com>
 <20210201230147.45593-2-steved@redhat.com>
 <87y2fzcsfc.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <66fbe743-aa9d-ca60-8955-c2859d9ab9df@RedHat.com>
Date:   Mon, 8 Feb 2021 12:44:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87y2fzcsfc.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/7/21 7:30 PM, NeilBrown wrote:
> On Mon, Feb 01 2021, Steve Dickson wrote:
> 
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>> ---
>>  nfs.conf              | 2 +-
>>  utils/mountd/mountd.c | 3 +++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/nfs.conf b/nfs.conf
>> index 186a5b19..9fcf1bf0 100644
>> --- a/nfs.conf
>> +++ b/nfs.conf
>> @@ -30,7 +30,7 @@
>>  # udp-port=0
>>  #
>>  [mountd]
>> -# debug=0
>> +# debug="all|auth|call|general|parse"
>>  # manage-gids=n
>>  # descriptors=0
>>  # port=0
>> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
>> index 988e51c5..a480265a 100644
>> --- a/utils/mountd/mountd.c
>> +++ b/utils/mountd/mountd.c
>> @@ -684,6 +684,9 @@ read_mount_conf(char **argv)
>>  	if (s && !state_setup_basedir(argv[0], s))
>>  		exit(1);
>>  
>> +	if ((s = conf_get_str("mountd", "debug")) != NULL)
>> +		xlog_sconfig(s, 1);
>> +
> 
> Why is this needed?
> A few lines higher up is
>   	xlog_from_conffile("mountd");
> which calls
>  	kinds = conf_get_list(service, "debug");
> and passes each word that it finds to xlog_sconfig()
> ??
> 
> I just tested setting "debug=all" in the mountd section of nfs.conf,
> and it seems to work without this patch.
No it is not... I didn't realize xlog_from_conffile() process
the debug config variable... maybe we should change the name
to something like xlog_debug_conffile()... something more
descriptive as to what it does.

I will clean it up... in a bit.

steved.
> 
> Thanks,
> NeilBrown
> 
> 
>>  	/* NOTE: following uses "nfsd" section of nfs.conf !!!! */
>>  	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(_rpcprotobits)))
>>  		NFSCTL_UDPSET(_rpcprotobits);
>> -- 
>> 2.29.2

