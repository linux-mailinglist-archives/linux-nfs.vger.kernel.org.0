Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059501A7FC6
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbgDNO2h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 10:28:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28363 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390869AbgDNO2K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 10:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xa62Y/WDyDDC66AYgc+UDLVgUHP5XNfVmH2OrZulGOs=;
        b=KXoGDmMTPad4jmfXhHP1nVDZexERTgbmjhZ2D+Ty7HnjvHFPqpoSWRWplTasVO1mz+5omL
        FyNjX2PUn9L6YtVb7v355g+ir9Zd/+O79o4ikifCagiVzdm72sDdBoq8bGTBPjbY9kJR8H
        FCsTohJCgYC7iGzp2cXM+lQsIHi/EAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-Gds0btveOYOEUHx65kqIxg-1; Tue, 14 Apr 2020 10:28:07 -0400
X-MC-Unique: Gds0btveOYOEUHx65kqIxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 126D98024CD
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2020 14:28:07 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-136.phx2.redhat.com [10.3.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7861116D7B;
        Tue, 14 Apr 2020 14:28:06 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] nfsdcld: fix possible buffer overrun in
 sqlite_iterate_recovery()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200413144435.1220985-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f29a9df3-24b0-147e-b77b-675d1b0e72c7@RedHat.com>
Date:   Tue, 14 Apr 2020 10:28:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413144435.1220985-1-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/13/20 10:44 AM, Scott Mayhew wrote:
> Prior to release, cp_data was originally intended to hold the gss
> principal string.  When it was changed to hold a hash of the principal
> instead, the size of the field was changed but the 'n' arg of the
> memcpy() in sqlite_iterate_recovery() was not.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc3)

steved.
> ---
>  utils/nfsdcld/sqlite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index 09518e2..6666c86 100644
> --- a/utils/nfsdcld/sqlite.c
> +++ b/utils/nfsdcld/sqlite.c
> @@ -1337,7 +1337,7 @@ sqlite_iterate_recovery(int (*cb)(struct cld_client *clnt), struct cld_client *c
>  		cmsg->cm_u.cm_clntinfo.cc_name.cn_len = sqlite3_column_bytes(stmt, 0);
>  		if (sqlite3_column_bytes(stmt, 1) > 0) {
>  			memcpy(&cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
> -				sqlite3_column_blob(stmt, 1), NFS4_OPAQUE_LIMIT);
> +				sqlite3_column_blob(stmt, 1), SHA256_DIGEST_SIZE);
>  			cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = sqlite3_column_bytes(stmt, 1);
>  		}
>  #else
> 

