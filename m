Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377B54ADFDB
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384382AbiBHRpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 12:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiBHRpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 12:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14205C061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644342330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O1IXSyj0L+GkXb7ky4C9YVpjwRWp8nCNDif/13E+jQ=;
        b=CkUyOo2Iwa2oAREl6ITJtNxQeg5EloTQckaAaEi5fs2t9XparECkfgEW7TcEfcjfeWzih3
        crv2VSZS3sk24pgeaifELAYTaTGOI5jFjZoK+r7dhKA/6Yy1NDaaQoQjuUdZg4Xo63uKmG
        GsNDeYPlYE8wFFZLilnBfI+gPjYwK/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-AZOsrG7oMMuJyZbNiYN7NQ-1; Tue, 08 Feb 2022 12:45:27 -0500
X-MC-Unique: AZOsrG7oMMuJyZbNiYN7NQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA8A51082;
        Tue,  8 Feb 2022 17:45:25 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FA6838D2;
        Tue,  8 Feb 2022 17:45:25 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 12:45:23 -0500
Message-ID: <16BCC862-88A3-46EB-9E8C-8C27E8536D2C@redhat.com>
In-Reply-To: <573bd3329d0dc2f73986d4c2cf3060c0298ac970.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
 <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
 <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
 <573bd3329d0dc2f73986d4c2cf3060c0298ac970.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 11:47, Trond Myklebust wrote:

> On Tue, 2022-02-08 at 06:32 -0500, Benjamin Coddington wrote:
>>
>> There's a bit of a chicken and egg problem with 2, though.  If the
>> nfs
>> module is loaded, the kernel notification gets sent as soon as you
>> create
>> the namespace.  Its not going to wait for you to move or exec udev
>> into
>> that
>> network namespace, and the notification is lost.
>
>
> Wait a minute... I missed this comment earlier, but it definitely
> points to a misunderstanding.
>
> The notification is _not_ sent by the act of loading a module. It is
> sent by the call to kobject_uevent() in nfs_netns_sysfs_setup(). That
> again is called as part of nfs_net_init() when the net namespace gets
> created.

My communication was poor.  The first notification is sent to udev when the
nfs module is loaded.  That is the initial creation of the sysfs, the
notification in the init namespace.

After that, if a network namespace is created and "the nfs module is
[already] loaded", the notification is immediately sent.

I think we're both understanding it and our understanding matches how it
works.

Ben

