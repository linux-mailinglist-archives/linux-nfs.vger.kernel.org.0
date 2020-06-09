Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006B1F3D0A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2020 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFINra (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jun 2020 09:47:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729535AbgFINr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jun 2020 09:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591710447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHrV6LGpRruKFTu5Fpgts2Lp+AZdHSjEyIAgsjvHjD4=;
        b=WqLqvFa4sMNyLHKN5nC23TsGuqNoSr7YuY4r76W4J86WRm/hL820ARRNOZ3QjZQTjrsHLU
        1Wm9CViBm8maQlTSx3EQcevxXHNhD8+llzyWm92VR7Ox7z0vhKOdjmNksPNXHEuPreTSZC
        pOAj9qcD2uGDkiY8GXN5/mvI+61SAMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-RpOR7Dp8OZOZZMhZM7fbNA-1; Tue, 09 Jun 2020 09:47:23 -0400
X-MC-Unique: RpOR7Dp8OZOZZMhZM7fbNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED0691135;
        Tue,  9 Jun 2020 13:47:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7B775C1D6;
        Tue,  9 Jun 2020 13:47:20 +0000 (UTC)
Subject: Re: [rpcbind 1/1] man/rpcbind: Mention systemd socket in -h
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
References: <20200605075332.14564-1-pvorel@suse.cz>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e3ad7d14-0535-f7fe-1ebe-2fda423c0c02@RedHat.com>
Date:   Tue, 9 Jun 2020 09:47:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605075332.14564-1-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/5/20 3:53 AM, Petr Vorel wrote:
> and reformat doc a bit.
> 
> Based on Olaf Kirch's patch for openSUSE.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: rpcbind-1_2_6-rc6)

steved.

> ---
> Hi Steve,
> 
> original patch:
> https://build.opensuse.org/package/view_file/openSUSE:Factory/rpcbind/0031-rpcbind-manpage.patch?expand=1
> 
> Olaf removed note about multi-homed host and about adding 127.0.0.1 an
> ::1. I kept them, but maybe multi-homed is not relevant any more or not
> limited only to UDP. Feel free to modify the text to better accommodate
> to current usage.
> 
> Kind regards,
> Petr
> 
>  man/rpcbind.8 | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/man/rpcbind.8 b/man/rpcbind.8
> index af6200f..fbf0ace 100644
> --- a/man/rpcbind.8
> +++ b/man/rpcbind.8
> @@ -86,9 +86,16 @@ checks are shown in detail.
>  Do not fork and become a background process.
>  .It Fl h
>  Specify specific IP addresses to bind to for UDP requests.
> -This option
> -may be specified multiple times and is typically necessary when running
> -on a multi-homed host.
> +This option may be specified multiple times and can be used to
> +restrict the interfaces rpcbind will respond to.
> +When specifying IP addresses with
> +.Fl h ,
> +.Nm
> +will automatically add
> +.Li 127.0.0.1
> +and if IPv6 is enabled,
> +.Li ::1
> +to the list.
>  If no
>  .Fl h
>  option is specified,
> @@ -99,14 +106,19 @@ which could lead to problems on a multi-homed host due to
>  .Nm
>  returning a UDP packet from a different IP address than it was
>  sent to.
> -Note that when specifying IP addresses with
> -.Fl h ,
> +Note that when
>  .Nm
> -will automatically add
> -.Li 127.0.0.1
> -and if IPv6 is enabled,
> -.Li ::1
> -to the list.
> +is controlled via systemd's socket activation,
> +the
> +.Fl h
> +option is ignored. In this case, you need to edit
> +the
> +.Nm ListenStream
> +and
> +.Nm ListenDgram
> +definitions in
> +.Nm /usr/lib/systemd/system/rpcbind.socket
> +instead.
>  .It Fl i
>  .Dq Insecure
>  mode.
> 

