Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764642D1832
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Dec 2020 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLGSIC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Dec 2020 13:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgLGSIB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Dec 2020 13:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607364395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAbtaZyYo6EGPfEgs6wGeUzhcQkRPp7sN1zV8pqRJ2g=;
        b=g74wilED6A+0D+5SIYKbW/Z72p0sFuifbesW1eY+NbGtxvZ8fWk/Gz1lXjXBXNLQEkK6mo
        8PzMKVqf7XO9HpV22igDq623JGB9e3Yw+SV/zyzNJxqf3/44R2gEMUPEu2915Y+P2t6OQm
        ITKjFFs8PWHF/dTfii0V0n5CamXj5J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-HNSV-dBwOvGik3Fe614LRQ-1; Mon, 07 Dec 2020 13:06:27 -0500
X-MC-Unique: HNSV-dBwOvGik3Fe614LRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB96107ACE4
        for <linux-nfs@vger.kernel.org>; Mon,  7 Dec 2020 18:06:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-30.phx2.redhat.com [10.3.113.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4493F19C59;
        Mon,  7 Dec 2020 18:06:26 +0000 (UTC)
Subject: Re: gssd: set $HOME to prevent recursion when home dirs are on
 kerberized NFS mount revisted
To:     Jacob Shivers <jshivers@redhat.com>, linux-nfs@vger.kernel.org
References: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <ff7d4adc-2d4a-d5cc-fa0a-1f808b571fad@RedHat.com>
Date:   Mon, 7 Dec 2020 13:06:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CALe0_74eB89Koni0i14aB=2CSitzg1WkRihe7KZGDJ5OoPSahw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Sorry for the delayed response... Trying to burn up some PTO.

On 11/23/20 1:17 PM, Jacob Shivers wrote:
> Commit 2f682f25c642fcfe7c511d04bc9d67e732282348 changed existing
> behavior to avoid a deadlock for users using Kerberized NFS home dirs.
> 
> However, this also prevents users leveraging their own k5identity
> files under their home directory and instead rpc.gssd uses a
> system-wide /.k5identity file. For users expecting to use their own
> k5identity file this is certainly unexpected.
So how is the deadlock not happening when ~/.k5identity is on a NFS
home directory? What am I missing?

> 
> Below is some pseudo code that was proposed and would just add a flag
> allowing for the behavior prior to
> 2f682f25c642fcfe7c511d04bc9d67e732282348:
> 
> /* psudo code snippet starts here */
>         /*
>          * Some krb5 routines try to scrape info out of files in the user's
>          * home directory. This can easily deadlock when that homedir is on a
> -        * kerberized NFS mount. By setting $HOME unconditionally to "/", we
> +        * kerberized NFS mount. Some users may not have $HOME on NFS.
> +        * By default setting $HOME unconditionally to "/", we
>          * prevent this behavior in routines that use $HOME in preference to
>          * the results of getpw*.
> +        * Users who have $HOME on krb5-NFS should set
> `--home-not-kerberized` in argv
> +        * Users who have $HOME on krb5-NFS but want to use their
> $HOME anyway should set NFS_HOME_ACCESSIBLE=TRUE
>          */
> +       if (argv == '--home-not-kerberized') ||
> (getenv("NFS_HOME_ACCESSIBLE") == 'TRUE') {
> +               log.debug('Not masking $HOME, this breaks on Kerberized $HOME');
> +       }
> +       else {
> +               log.debug('Assuming $HOME requires Kerberos, use
> `--home-not-kerberized` to change this behavior');
>         if (setenv("HOME", "/", 1)) {
>                 printerr(1, "Unable to set $HOME: %s\n", strerror(errn));
>                 exit(1);
>         }
> +       }
> /* psudo code snippet ends here */
In general I'm pretty reluctant to add flags but what is needed
to do so is a company single letter flag '-H' and a man page 
entry describing the flag. 
 
> 
> While acknowledging the use of this flag for Kerberized NFS home dirs
> is undesirable and would cause a deadlock, there should be no issue
> for users not using Kerberized NFS home dirs.
What apps are you using that is seeing this problem?

steved.

