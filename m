Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB12A2B28
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKBNDd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728487AbgKBNDb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604322209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KLKWWLQfK0+21B6MA+dxlADJ4aSOxxXLDfnC9/QtLwU=;
        b=aBdvz9b2Rkms9me/G/nijjlen9XiNKXWqH78OEHZdirjasrIjwD4zKub/qVOpquJa7wD8Z
        CUUaLbNBkFVg4oCulFBdOSRga/o5SXtx/avlzlYAZ0AQoJCn0nHEQXATbjlVJzi/ebitkc
        a3PzAFm+meFE+DEubi7WTDa2AWB2Rxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-DP5fGU_LM7ikNxTBbt3Yyg-1; Mon, 02 Nov 2020 08:03:26 -0500
X-MC-Unique: DP5fGU_LM7ikNxTBbt3Yyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECEADAB99C7
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 13:03:25 +0000 (UTC)
Received: from ovpn-112-10.ams2.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 443B81002C21;
        Mon,  2 Nov 2020 13:03:25 +0000 (UTC)
Message-ID: <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Mon, 02 Nov 2020 13:03:23 +0000
In-Reply-To: <20201029210401.446244-1-steved@redhat.com>
References: <20201029210401.446244-1-steved@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2020-10-29 at 17:04 -0400, Steve Dickson wrote:
> The following patch looks for config.d directories
> and configuration file in those directories will
> be loaded. 
> 
> For example if /etc/nfs.conf.d or /etc/nfsmount.conf.d 
> exists and there are config files in those directories 
> will be loaded, but not the actual /etc/nfs.conf or 
> the /etc/nfsmount.conf files will not be.
> 
> I do have a couple questions/concerns 
> 
> 1) Is calling conf_load_file() more than once
>    kosher... It appears variable will just be 
>    over written. That does appear to happen
>    with my testing. 
> 
> 2) If conf.d file(s) do exist, should the give
>    flat conf file also be loaded. At this point if 
>    the conf.d file(s) do exist, then the given
>    flat config file is not loaded. 
> 
> 3) How to document this new feature.
> 
> Steve Dickson (1):
>   conffile: process config.d directory config files.
> 
>  support/nfs/conffile.c | 78
> +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)

NAK.

Each call to conf_load_file() erases all existing config values from
memory via a call to conf_free_bindings() so this wont work as you
expect.

You would need to write an equivalent of conf_load_file() that created
a new transaction id and read in all the files before committing them
to do it this way.

I can't help but wonder if this would be better handled as an
improvement to the 'include' directive to support file globbing, we
could then retain the functionality of the master nfs.conf file but
tack on an 'include nfs.conf.d/*.conf' at the end which would go off
and load any files dropped in there by package management.

-Alice


