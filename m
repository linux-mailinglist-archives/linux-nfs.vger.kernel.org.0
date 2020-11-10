Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B12ADFED
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKJTld (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 14:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgKJTld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 14:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605037292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hCUImjDOOXKN1u9wxNS212OKB6/8JLHDW36RDTvW+k=;
        b=QnI+f7HuEdI66sL6atXqkRvaNO3fVG1wBXg2scdKfv8ZIhSVc0wd8TOPQ8ch8gBx5ttiDz
        mfdhNTOCIeUw64FhrJdUax2AIIGyadzwgo6IF1vuXdzQmicu1JxVWBmOuW3tp+pteJDTHX
        B/AStA+VhkSwX6JU0tq75zJHaAWYQgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-XW_mbj8pNz6T9b-C2ne-Xw-1; Tue, 10 Nov 2020 14:41:30 -0500
X-MC-Unique: XW_mbj8pNz6T9b-C2ne-Xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790D48049DB
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 19:41:29 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B5A775121
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 19:41:29 +0000 (UTC)
Subject: Re: [PATCH] nfs-v4client.target: NFSv4 only client target.
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201109194700.255314-1-steved@redhat.com>
Message-ID: <7229402f-99b9-57a1-643e-d26aaa33dba6@RedHat.com>
Date:   Tue, 10 Nov 2020 14:41:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109194700.255314-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/9/20 2:47 PM, Steve Dickson wrote:
> To allow v4 only clients, create an systemd
> nfs-client target that does not "Wants" a
> rpc-statd notify
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1886634
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  systemd/nfs-v4client.target | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 systemd/nfs-v4client.target
Committed... (tag: nfs-utils-2-5-3-rc1)

steved.
> 
> diff --git a/systemd/nfs-v4client.target b/systemd/nfs-v4client.target
> new file mode 100644
> index 0000000..3d1064e
> --- /dev/null
> +++ b/systemd/nfs-v4client.target
> @@ -0,0 +1,12 @@
> +[Unit]
> +Description=NFS client services
> +Before=remote-fs-pre.target
> +Wants=remote-fs-pre.target
> +
> +# GSS services dependencies and ordering
> +Wants=auth-rpcgss-module.service
> +After=rpc-gssd.service rpc-svcgssd.service gssproxy.service
> +
> +[Install]
> +WantedBy=multi-user.target
> +WantedBy=remote-fs.target
> 

