Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445652DC3D3
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLPQPO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 11:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgLPQPO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 11:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608135228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNyKtQgP+kz43S3hR5CEpBymw7yeW20lzObRfLuvUIM=;
        b=E+R8XenariFnMH06Zdw14kN++r+HEvQcdrak4K4jKPyPceA0+COgKJXyxenK+tF0iaXJXR
        E1LSC1ZkJQH9HWnG631e5Nr1oVmrwKu1iM4B2unOI2M9FhVqUn0dLubRQrud34a0K4wVqt
        lyus6X8Nc+aMT5MxeG/fZMsW6dwetiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-snBjNYxRM9Oo3pgOKVOpAw-1; Wed, 16 Dec 2020 11:13:46 -0500
X-MC-Unique: snBjNYxRM9Oo3pgOKVOpAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 906728143EF;
        Wed, 16 Dec 2020 16:13:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3977E1821A;
        Wed, 16 Dec 2020 16:13:45 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] nfsd: clean up option parsing
To:     =?UTF-8?Q?Ulrich_=c3=96lmann?= <u.oelmann@pengutronix.de>,
        linux-nfs@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>
References: <20201209120643.14427-1-u.oelmann@pengutronix.de>
 <6rbletbzbi.fsf@pengutronix.de>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <1c2a1cad-aa3f-906e-f846-108bccb1c710@RedHat.com>
Date:   Wed, 16 Dec 2020 11:14:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6rbletbzbi.fsf@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/16/20 9:28 AM, Ulrich Ölmann wrote:
> Gentle ping!
> (And putting Jeff & Steve on CC).
Sorry for the delay... Trying to burn some PTO before EOY... 
> 
> On Wed, Dec 09 2020 at 13:06 +0100, Ulrich Ölmann <u.oelmann@pengutronix.de> wrote:
>> Presumably by mistake in commit [1] the unknown option 'i' slipped in together
>> with a duplicated 't', so remove them from the optstring.
>>
>> [1] fbd7623dd8d5 ("nfsd: don't enable a UDP socket by default")
>>
>> Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
Committed!

steved.
>> ---
>>  utils/nfsd/nfsd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
>> index a412a026c6c5..c9f0385b5a00 100644
>> --- a/utils/nfsd/nfsd.c
>> +++ b/utils/nfsd/nfsd.c
>> @@ -162,7 +162,7 @@ main(int argc, char **argv)
>>  		}
>>  	}
>>  
>> -	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTituUrG:L:", longopts, NULL)) != EOF) {
>> +	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
>>  		switch(c) {
>>  		case 'd':
>>  			xlog_config(D_ALL, 1);

