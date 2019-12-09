Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9B11712E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfLIQKC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 11:10:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfLIQKB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 11:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575907800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSiaGPAl1xFxzu+U33SqZLmOHJkEPJUb1vCByWlbbss=;
        b=heJ9mHOP8zRhMJNoBEc4nM7OwlDX/f0QGBjBtTfM8VLy4LtXJ8m1/FpqDL9TmkPjnhKOSR
        U3648v5SoVq4t3rlcB6NzMcDUWorlT1uWJH1YYLYqh4zH2LwIr3tiSSPFacEpJR3ihMcAC
        eKOeWntVL+TCxXZbASLiFNfhSkKcaJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-482q31L_OzCBcjnD0S9bYQ-1; Mon, 09 Dec 2019 11:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654FC107ACC5;
        Mon,  9 Dec 2019 16:09:58 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-120.phx2.redhat.com [10.3.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD535C21A;
        Mon,  9 Dec 2019 16:09:57 +0000 (UTC)
Subject: Re: gssd question/patch
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com>
Date:   Mon, 9 Dec 2019 11:09:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 482q31L_OzCBcjnD0S9bYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
> Hi Steve,
> 
> Question: Is this an interesting failure scenario (bug) that should be
> fixed: client did a mount which acquired gss creds and stored in the
> credential cache. Then say it umounts at some point. Then for some
> reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
> mounts again. This currently fails. Because gssd uses internal cache
> to store creds lifetimes and thinks that tgt is still valid but then
> trying to acquire a service ticket it fails (since there is no tgt).
I'm unable reproduce the scenario.... 

(as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
(as kuser) kinit kuser
(as kuser) touch /mnt/tmp/foobar
(as root) umount /mnt/tmp/
(as root) rm -f /tmp/krb5cc*
(as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
(as kuser) touch /mnt/tmp/foobar # which succeeds

Where am I going wrong?

steved.

> 
> Here's my proposed fix (I can send as a patch if this agreed upon).
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 0474783..3678524 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -121,6 +121,9 @@
>  #include <krb5.h>
>  #include <rpc/auth_gss.h>
> 
> +#include <sys/types.h>
> +#include <fcntl.h>
> +
>  #include "nfslib.h"
>  #include "gssd.h"
>  #include "err_util.h"
> @@ -314,6 +317,25 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
>         return err;
>  }
> 
> +/* check if the ticket cache exists, if not set nocache=1 so that new
> + * tgt is gotten
> + */
> +static int
> +gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
> +{
> +       int fd;
> +       char cc_name[BUFSIZ];
> +
> +       snprintf(cc_name, sizeof(cc_name), "%s/%s%s_%s",
> +               ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
> +               GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
> +       fd = open(cc_name, O_RDONLY);
> +       if (fd < 0)
> +               return 1;
> +       close(fd);
> +       return 0;
> +}
> +
>  /*
>   * Obtain credentials via a key in the keytab given
>   * a keytab handle and a gssd_k5_kt_princ structure.
> @@ -348,6 +370,8 @@ gssd_get_single_krb5_cred(krb5_context context,
> 
>         memset(&my_creds, 0, sizeof(my_creds));
> 
> +       if (!nocache && !use_memcache)
> +               nocache = gssd_check_if_cc_exists(ple);
>         /*
>          * Workaround for clock skew among NFS server, NFS client and KDC
>          * 300 because clock skew must be within 300sec for kerberos
> 

