Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DC22139F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGORoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 13:44:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbgGORoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 13:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594835058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUoBst3HobTGjmtcjIBvJNaeodoW+LyrToqeDKQDL+w=;
        b=UadCoZx/CnLHPfuy5C0t6gzvZ/90fgO0ia/x1H/6U5Kg3ThfPsgR0nwBPs82r1sPOpQnU4
        MAXWr0MzeUIy8nvWvzizOJyeKB5jmHsSR4SaymmsgAbOu2RQPtMeA22khWejt4F6kgwzJA
        NAAjLC2FrclQhGsGsPyQ9shwVYVaUlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-GZXNmt5hOlG7SwmrmKCZ7A-1; Wed, 15 Jul 2020 13:44:14 -0400
X-MC-Unique: GZXNmt5hOlG7SwmrmKCZ7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D03E1800D42
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 17:44:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 261045D9C5;
        Wed, 15 Jul 2020 17:44:13 +0000 (UTC)
Subject: Re: [PATCH 4/4] nfs-utils: Update nfs4_unique_id module parameter
 from the nfs.conf value
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
 <115d8b45e84f3cecc9f5623e39f5078315d3ebbd.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a49c78c1-1419-409b-2386-25d94afb7ca7@RedHat.com>
Date:   Wed, 15 Jul 2020 13:44:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <115d8b45e84f3cecc9f5623e39f5078315d3ebbd.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/10/20 12:44 PM, Alice Mitchell wrote:
> systemd service to grab the config value and feed it to the kernel module
Again, I'm wondering if the systemd/README should be updated to explain 
this new script... 

steved.

> ---
>  nfs.conf                      |  1 +
>  systemd/Makefile.am           |  3 +++
>  systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
>  systemd/nfs-config.service.in | 17 +++++++++++++++++
>  4 files changed, 49 insertions(+)
>  create mode 100755 systemd/nfs-conf-export.sh
>  create mode 100644 systemd/nfs-config.service.in
> 
> diff --git a/nfs.conf b/nfs.conf
> index 186a5b19..8bb41227 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -4,6 +4,7 @@
>  #
>  [general]
>  # pipefs-directory=/var/lib/nfs/rpc_pipefs
> +# nfs4_unique_id = ${machine-id}
>  #
>  [exports]
>  # rootdir=/export
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index 75cdd9f5..51acdc3f 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -9,6 +9,7 @@ unit_files =  \
>      nfs-mountd.service \
>      nfs-server.service \
>      nfs-utils.service \
> +    nfs-config.service \
>      rpc-statd-notify.service \
>      rpc-statd.service \
>      \
> @@ -69,4 +70,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
>  install-data-hook: $(unit_files)
>  	mkdir -p $(DESTDIR)/$(unitdir)
>  	cp $(unit_files) $(DESTDIR)/$(unitdir)
> +	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
> +	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
>  endif
> diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-export.sh
> new file mode 100755
> index 00000000..486e8df9
> --- /dev/null
> +++ b/systemd/nfs-conf-export.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +#
> +# This script pulls values out of /etc/nfs.conf and configures
> +# the appropriate kernel modules which cannot read it directly
> +
> +NFSMOD=/sys/module/nfs/parameters/nfs4_unique_id
> +NFSPROBE=/etc/modprobe.d/nfs.conf
> +
> +# Now read the values from nfs.conf
> +MACHINEID=`nfsconf --get general nfs4_unique_id`
> +if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
> +then
> +# No config vaue found, assume blank
> +MACHINEID=""
> +fi
> +
> +# Kernel module is already loaded, update the live one
> +if [ -e $NFSMOD ]; then
> +echo -n "$MACHINEID" >> $NFSMOD
> +fi
> +
> +# Rewrite the modprobe file for next reboot
> +echo "# This file is overwritten by systemd nfs-config.service" > $NFSPROBE
> +echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
> +echo "# Do not hand modify" >> $NFSPROBE
> +echo "options nfs nfs4_unique_id=\"$MACHINEID\"" >> $NFSPROBE
> +
> +echo "Set to: $MACHINEID"
> diff --git a/systemd/nfs-config.service.in b/systemd/nfs-config.service.in
> new file mode 100644
> index 00000000..c5ef1024
> --- /dev/null
> +++ b/systemd/nfs-config.service.in
> @@ -0,0 +1,17 @@
> +[Unit]
> +Description=Preprocess NFS configuration
> +PartOf=nfs-client.target
> +After=nfs-client.target
> +DefaultDependencies=no
> +
> +[Service]
> +Type=oneshot
> +# This service needs to run any time any nfs service
> +# is started, so changes to local config files get
> +# incorporated.  Having "RemainAfterExit=no" (the default)
> +# ensures this happens.
> +RemainAfterExit=no
> +ExecStart=@_libexecdir@/nfs-utils/nfs-conf-export.sh
> +
> +[Install]
> +WantedBy=nfs-client.target
> 

