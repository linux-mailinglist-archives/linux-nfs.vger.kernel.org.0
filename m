Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEA7D834E
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjJZNJk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjJZNJk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345811A7
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698325731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeAeRgBTQ7Ssdj5ujtSikHLsYN0B8YubCdr8ZdyYSgY=;
        b=iJo9hpBkgJIp3H1HXIqrHcnlfBQJq9fugbtO51iHzq3GV7C+w6ARHxvPQnLD1qnIFDuwEE
        EY73u2rdJnzDNxT2kVkWInjhvM06y5Ac3id6KRXN3FZZ3LuhVrzQjtPcE8tZ3L1H7uqR/+
        4sDr0SYFfi9ibWhy/vfsQF3CAgTjkWA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-pjT9fk4IOMKXV6Kpo9hkMA-1; Thu,
 26 Oct 2023 09:08:48 -0400
X-MC-Unique: pjT9fk4IOMKXV6Kpo9hkMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0FAF1C382A3;
        Thu, 26 Oct 2023 13:08:45 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A56D1121314;
        Thu, 26 Oct 2023 13:08:43 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Zhuohao Bai <zhuohao_bai@foxmail.com>
Cc:     steved@redhat.com, falcon@tinylab.org, forrestniu@foxmail.com,
        baizhh21@lzu.edu.cn, tanyuan@tinylab.org,
        linux-nfs@vger.kernel.org, libtirpc-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] _rpc_dtablesize: Decrease the value of size.
Date:   Thu, 26 Oct 2023 09:08:41 -0400
Message-ID: <EAA0AA43-7CAA-4D74-9DD0-4CC738D71D47@redhat.com>
In-Reply-To: <tencent_E6816C9AF53E61BA5E0A313BBE5E1D19B00A@qq.com>
References: <tencent_E6816C9AF53E61BA5E0A313BBE5E1D19B00A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Oct 2023, at 12:27, Zhuohao Bai wrote:

> In the client code, the function _rpc_dtablesize() is used to determine=
 the memory allocation for the __svc_xports array.
>
> However, some operating systems (including the recent Manjaro OS) can h=
ave _SC_OPEN_MAX values as high as 1073741816, which can cause the __svc_=
xports array to become too large. This results in the process being kille=
d.

This is addressed by several users of rpc_dtablesize() already, which all=
 seem to do:

    setsize =3D _rpc_dtablesize();
    if (setsize > FD_SETSIZE)
        setsize =3D FD_SETSIZE;

Does it make sense to try to fix it for everyone, and should we clean up =
the users?

Ben

