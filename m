Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244872ADFE9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJTlA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 14:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJTlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 14:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605037259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3z++nptNm/MkmIgkzQPYravq8/unxr9V1HVRbHKhKy8=;
        b=cnW5PXCyLTlVrOPvBw1yewJQsgqqYPIKekdWGVeezy1wVvBA6JqTyKAR4YY11GjYP+YEOJ
        W9hDpWWQvir2i56eHn48xZ+/1qZZWv7O5OQNMPFiYJwXVBK2PPp/3moPRloAnzD0xXeRBX
        UXXrdRL7lE9kNTErr/o1w6KmlmKnc+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-EijZ3wOGMriehTN7xqtp4g-1; Tue, 10 Nov 2020 14:40:57 -0500
X-MC-Unique: EijZ3wOGMriehTN7xqtp4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF636D245
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 19:40:56 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C25D5D9D2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 19:40:56 +0000 (UTC)
Subject: Re: [PATCH 0/3 V2] Enable config.d directory to be processed.
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201105145634.98281-1-steved@redhat.com>
Message-ID: <f320cc20-4cf7-7be9-30a6-fe91250366d1@RedHat.com>
Date:   Tue, 10 Nov 2020 14:41:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105145634.98281-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/5/20 9:56 AM, Steve Dickson wrote:
> Here is the second attempt to use conf.d directories
> to set configuration variables. 
> 
> When a conf.d directory exists and files with the
> ".conf" extension exist they will be used to set
> configuration variables. 
> 
> Files not using that extension or files beginning 
> with a "." (ex .nfs.conf) will be ignored. 
> 
> The conf.d files will take priority over the main 
> config files. Meaning a variable set in both the
> main config and the conf.d file, the conf.d file
> will have priority over the variable in the main config.
> 
> The ordering of when the conf.d are processed
> can be set by alphabetical naming convention.
> Prefixing file name with a 001-nfs.conf, 
> 002-nfs.conf will control when the config is 
> process. Note the last config file process
> with have the highest priority.
> 
> Steve Dickson (3):
>   conffile: process config.d directory config files.
>   conffile: Only process files in the config.d dirs that end with ".conf"
>   manpage: Update nfs.conf and nfsmount.conf manpages
Committed... (tag: nfs-utils-2-5-3-rc1)

steved.
> 
>  support/nfs/conffile.c        | 139 +++++++++++++++++++++++++++++++++-
>  systemd/nfs.conf.man          |   8 ++
>  utils/mount/nfsmount.conf.man |   7 ++
>  3 files changed, 151 insertions(+), 3 deletions(-)
> 

