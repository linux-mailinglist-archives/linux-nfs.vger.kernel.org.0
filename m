Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4123E107751
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 19:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVS1l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 13:27:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32999 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbfKVS1l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 13:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574447260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=311k9Gn3B56DvZ6pMIyoRpfRz4fiBmnOoSpDwheuaRo=;
        b=VGvHVt//Bkk5ikKXec67GVAj8Wq8yGjEyZfKAr5GAq2Vwfw5JA8J4whaGww7k+EfDqZHbD
        Ee2Ckb13j3H+tSCEz9YLaz65TJz4HLFISWbTRd7eNzf+plY4S4l/zNQbmM/Ko++OOsi/ba
        uVHL1065zg4AhIZXqHY1tJ3RPSzfwhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-GKBT49_7NeO3wK0o2g76wA-1; Fri, 22 Nov 2019 13:27:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F22C10CE7B2;
        Fri, 22 Nov 2019 18:27:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-36.phx2.redhat.com [10.3.117.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFA7166844;
        Fri, 22 Nov 2019 18:27:35 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] Switch legacy index() in favour of strchr()
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Frederik Pasch <fpasch@googlemail.com>,
        Gustavo Zacarias <gustavo@zacarias.com.ar>
References: <20191122163155.6971-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <4813e3b8-ee75-d4e2-774e-84734b6b6718@RedHat.com>
Date:   Fri, 22 Nov 2019 13:27:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122163155.6971-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GKBT49_7NeO3wK0o2g76wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/22/19 11:31 AM, Petr Vorel wrote:
> From: Frederik Pasch <fpasch@googlemail.com>
> 
> [ gustavo: rebased to 1.2.6 ]
> Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
> [ pvorel: taken from Buildroot distribution, rebased ]
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Frederik Pasch <fpasch@googlemail.com>
> ---
>  support/nfs/nfs_mntent.c | 6 +++---
>  utils/mount/error.c      | 2 +-
>  utils/mountd/fsloc.c     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
Committed... (tag: nfs-utils-2-4-3-rc2)

steved.
> 
> diff --git a/support/nfs/nfs_mntent.c b/support/nfs/nfs_mntent.c
> index 05a4c687..25e5944a 100644
> --- a/support/nfs/nfs_mntent.c
> +++ b/support/nfs/nfs_mntent.c
> @@ -9,7 +9,7 @@
>   */
>  
>  #include <stdio.h>
> -#include <string.h>		/* for index */
> +#include <string.h>		/* for strchr */
>  #include <ctype.h>		/* for isdigit */
>  #include <sys/stat.h>		/* for umask */
>  #include <unistd.h>		/* for ftruncate */
> @@ -176,7 +176,7 @@ nfs_getmntent (mntFILE *mfp) {
>  			return NULL;
>  
>  		mfp->mntent_lineno++;
> -		s = index (buf, '\n');
> +		s = strchr (buf, '\n');
>  		if (s == NULL) {
>  			/* Missing final newline?  Otherwise extremely */
>  			/* long line - assume file was corrupted */
> @@ -184,7 +184,7 @@ nfs_getmntent (mntFILE *mfp) {
>  				fprintf(stderr, _("[mntent]: warning: no final "
>  					"newline at the end of %s\n"),
>  					mfp->mntent_file);
> -				s = index (buf, 0);
> +				s = strchr (buf, 0);
>  			} else {
>  				mfp->mntent_errs = 1;
>  				goto err;
> diff --git a/utils/mount/error.c b/utils/mount/error.c
> index 562f312e..986f0660 100644
> --- a/utils/mount/error.c
> +++ b/utils/mount/error.c
> @@ -62,7 +62,7 @@ static int rpc_strerror(int spos)
>  	char *tmp;
>  
>  	if (estr) {
> -		if ((ptr = index(estr, ':')))
> +		if ((ptr = strchr(estr, ':')))
>  			estr = ++ptr;
>  
>  		tmp = &errbuf[spos];
> diff --git a/utils/mountd/fsloc.c b/utils/mountd/fsloc.c
> index cf42944f..1b869b60 100644
> --- a/utils/mountd/fsloc.c
> +++ b/utils/mountd/fsloc.c
> @@ -128,7 +128,7 @@ static struct servers *method_list(char *data)
>  	bool v6esc = false;
>  
>  	xlog(L_NOTICE, "method_list(%s)", data);
> -	for (ptr--, listsize=1; ptr; ptr=index(ptr, ':'), listsize++)
> +	for (ptr--, listsize=1; ptr; ptr=strchr(ptr, ':'), listsize++)
>  		ptr++;
>  	list = malloc(listsize * sizeof(char *));
>  	copy = strdup(data);
> 

