Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEA4C714C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 17:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiB1QID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 11:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiB1QIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 11:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC7F723E
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646064441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaVoF/yWcJZN4NMZCU226Wrn2pLY5zXDe36omUBZ57s=;
        b=BxeTMWYrtyUR/7z18it2koYkZiNKtkwRgOO4T+/Sc6S2jhLF6dpIBp2uYm+4Irj6W5ZFjy
        vObKgmM8i1nkiNWa5dHKKMcxS0uHBBWn6/zsgBpglZNa2QyQobiZb8oOcxmFvpVcNGX5JD
        c5xG9xNhiw/jg1MZYAmjMzq9x4r568s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-XFVJFxBSNxen933ogJTezg-1; Mon, 28 Feb 2022 11:07:15 -0500
X-MC-Unique: XFVJFxBSNxen933ogJTezg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80DC9180A08C;
        Mon, 28 Feb 2022 16:07:12 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A1267DE32;
        Mon, 28 Feb 2022 16:07:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Date:   Mon, 28 Feb 2022 11:07:10 -0500
Message-ID: <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
In-Reply-To: <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
 <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 17 Feb 2022, at 7:48, Benjamin Coddington wrote:

> Trond and Anna, this patch makes obvious one problem with the udev 
> approach.
> We cannot depend fully on stable uniquifiers.  The conversation on the
> userspace side has come full circle to asserting we use a mount 
> option.
>
> Do you still want us to keep this approach, or will you accept a mount
> option as:
>  - first mount in a namespace sets the identifier
>  - subsequent mounts with conflicting identifiers return an error
>
> If we keep this udev approach, this patch isn't necessary but does 
> greatly
> reduce the chances of having clients with unstable identifiers.
>
> No one can be blamed for ignoring this, but it would be a relief to 
> get this
> problem solved so it can stop burning our time.
>
> Please advise,
> Ben

Attempts to work toward solutions in this area seem to be ignored, the
questions still stand.  Until we can sort out and agree on a direction,
self-NACK to this patch.

Ben

