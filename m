Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD8155B67
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGQIC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 11:08:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGQIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Feb 2020 11:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581091681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgtY9J1Hxc5fBC5K2WSghemEB/HTyx0QAO/oasolErw=;
        b=Zdfvjbgww/eqSpfCnZNaZLDw6c8w9RTGJulrGzkmsHl71vSHRddkzp1xBOf9bEd8zD05ZS
        V9zmhyi1S+13yeT+cR9BGfPa7BcdVIfP3haohNMPPmtWBJtxU9qRUzskPxBD/0dqS4rtq4
        hM3SrFIau43s17nl/aUbcpQMLIA0VDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-qmNGOP3xPZKrzGvMin2Vog-1; Fri, 07 Feb 2020 11:07:59 -0500
X-MC-Unique: qmNGOP3xPZKrzGvMin2Vog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734618010F0;
        Fri,  7 Feb 2020 16:07:58 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B14E60BEC;
        Fri,  7 Feb 2020 16:07:58 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] Allow compilation to succeed with -fno-common
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <87ftfo8zdp.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3ce4b86e-475b-a05a-d512-5cd04547c004@RedHat.com>
Date:   Fri, 7 Feb 2020 11:07:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87ftfo8zdp.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/5/20 5:04 PM, NeilBrown wrote:
> 
> When compiled with -fno-common, global variables that are declared
> multple times cause an error.  With -fcommon (the default), they are
> merged.
> 
> Declaring such variable multiple times is probably not a good idea, and
> is definitely not necessary.
> 
> This patch changes all the global variables defined in include files to
> be explicitly "extern", and where necessary, adds the variable
> declaration to a suitable .c file.
> 
> To test, run
>   CFLAGS=-fno-common ./configure
>   make
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-4-3-rc7)

> ---
>  utils/mountd/v4root.c        |  2 --
>  utils/nfsdcld/cld-internal.h | 10 +++++-----
>  utils/nfsdcld/nfsdcld.c      |  6 ++++++
>  utils/statd/statd.c          |  1 +
>  utils/statd/statd.h          |  2 +-
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
> index d735dbfe192d..dd9828eb0c11 100644
> --- a/utils/mountd/v4root.c
> +++ b/utils/mountd/v4root.c
> @@ -28,8 +28,6 @@
>  #include "v4root.h"
>  #include "pseudoflavors.h"
>  
> -int v4root_needed;
> -
>  static nfs_export pseudo_root = {
>  	.m_next = NULL,
>  	.m_client = NULL,
> diff --git a/utils/nfsdcld/cld-internal.h b/utils/nfsdcld/cld-internal.h
> index 05f01be2105a..cc283dae9dbf 100644
> --- a/utils/nfsdcld/cld-internal.h
> +++ b/utils/nfsdcld/cld-internal.h
> @@ -35,10 +35,10 @@ struct cld_client {
>  	} cl_u;
>  };
>  
> -uint64_t current_epoch;
> -uint64_t recovery_epoch;
> -int first_time;
> -int num_cltrack_records;
> -int num_legacy_records;
> +extern uint64_t current_epoch;
> +extern uint64_t recovery_epoch;
> +extern int first_time;
> +extern int num_cltrack_records;
> +extern int num_legacy_records;
>  
>  #endif /* _CLD_INTERNAL_H_ */
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index 2ad1001988d2..be6556262504 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -69,6 +69,12 @@ static int 		inotify_fd = -1;
>  static struct event	pipedir_event;
>  static bool old_kernel = false;
>  
> +uint64_t current_epoch;
> +uint64_t recovery_epoch;
> +int first_time;
> +int num_cltrack_records;
> +int num_legacy_records;
> +
>  static struct option longopts[] =
>  {
>  	{ "help", 0, NULL, 'h' },
> diff --git a/utils/statd/statd.c b/utils/statd/statd.c
> index 8eef2ff24fe8..e4a1df43b73f 100644
> --- a/utils/statd/statd.c
> +++ b/utils/statd/statd.c
> @@ -67,6 +67,7 @@ static struct option longopts[] =
>  };
>  
>  extern void sm_prog_1 (struct svc_req *, register SVCXPRT *);
> +stat_chge	SM_stat_chge;
>  
>  #ifdef SIMULATIONS
>  extern void simulator (int, char **);
> diff --git a/utils/statd/statd.h b/utils/statd/statd.h
> index 231ac7e0764b..bb1fecbb6a51 100644
> --- a/utils/statd/statd.h
> +++ b/utils/statd/statd.h
> @@ -41,7 +41,7 @@ extern void	load_state(void);
>  /*
>   * Host status structure and macros.
>   */
> -stat_chge		SM_stat_chge;
> +extern stat_chge	SM_stat_chge;
>  #define MY_NAME		SM_stat_chge.mon_name
>  #define MY_STATE	SM_stat_chge.state
>  
> 

