Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13B15F8DD
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgBNVl0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47112 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387782AbgBNVl0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581716485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BomfLYK/UZESkoUrjqiyh58X5ye6kxP4uTsu1duDtQw=;
        b=f1znGFl1avb1g4MbGXMp3y+g0+dM6Lkb69O0Ck8qKiJYW8UqtVd4NOly8NYOF0An053/zP
        o00sNjaTgQDmPL0MnX4Ox/w/fKJGKtgn/0Wz5zKBn3ZXM7x9oaVBDAIHGF90eY6zspekGu
        wf8i77DcsEfWEsTW7H0X1okwYjPU1R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-_ZVgo22fNg23w2LZt8IYmg-1; Fri, 14 Feb 2020 16:41:19 -0500
X-MC-Unique: _ZVgo22fNg23w2LZt8IYmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DBB1005512
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 21:41:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-182.phx2.redhat.com [10.3.117.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11B115C1C3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 21:41:16 +0000 (UTC)
Subject: Re: [PATCH] gssd: Closed a memory leak in find_keytab_entry()
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200212190515.7443-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a256db55-1d40-bf4a-a131-4bdac4bf37f7@RedHat.com>
Date:   Fri, 14 Feb 2020 16:41:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212190515.7443-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/12/20 2:05 PM, Steve Dickson wrote:
> When 'adhostoverride' is "not set", which
> is most of the time, adhostoverride is not freed.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... 

stesved
> ---
>  utils/gssd/krb5_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index a1c43d2..85f60ae 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -799,7 +799,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  	int tried_all = 0, tried_default = 0, tried_upper = 0;
>  	krb5_principal princ;
>  	const char *notsetstr = "not set";
> -	char *adhostoverride;
> +	char *adhostoverride = NULL;
>  
>  
>  	/* Get full target hostname */
> @@ -827,7 +827,6 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				adhostoverride);
>  	        /* No overflow: Windows cannot handle strings longer than 19 chars */
>  	        strcpy(myhostad, adhostoverride);
> -		free(adhostoverride);
>  	} else {
>  	        strcpy(myhostad, myhostname);
>  	        for (i = 0; myhostad[i] != 0; ++i) {
> @@ -836,6 +835,8 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  	        myhostad[i] = '$';
>  	        myhostad[i+1] = 0;
>  	}
> +	if (adhostoverride)
> +		krb5_free_string(context, adhostoverride);
>  
>  	if (!srchost) {
>  		retval = get_full_hostname(myhostname, myhostname, sizeof(myhostname));
> 

