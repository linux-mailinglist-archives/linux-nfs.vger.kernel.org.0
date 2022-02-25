Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF24C4FA7
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBYU2m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 15:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYU2m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 15:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59BCC9F3B9
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645820888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXRxgxBhd6NlwpFXTZ6nSwYYh9Wa+jyy3ygXbru8WYg=;
        b=Ser/y9vjPav4z4Ln+kIskI1j1PlUc5IzgxdgstxAZCO0g754JkED2AXmXMVL3xPd6k71ca
        S51BEJD7bClKcQGnkLzj7V+H8hBH2RPh2PPUqTbfNL2KKdjfnxni7HG0UeS+gzskLh20T7
        aXSBSkgQ0zlrNH8Wqt6PLmtU3uc5j7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-hTtUkDTqMR29e1sRiiqmcA-1; Fri, 25 Feb 2022 15:28:07 -0500
X-MC-Unique: hTtUkDTqMR29e1sRiiqmcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F0D8145FB;
        Fri, 25 Feb 2022 20:28:06 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3BC3108427B;
        Fri, 25 Feb 2022 20:28:05 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Date:   Fri, 25 Feb 2022 15:28:04 -0500
Message-ID: <CE4655AF-9820-45FD-B3AF-9E19760D8A18@redhat.com>
In-Reply-To: <FDB38E78-8980-46CA-B936-F82C7C104071@redhat.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
 <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
 <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
 <640B2705-35C6-4E9E-89D2-CC3D0E10EC3A@redhat.com>
 <eb2a551096bb3537a9de7091d203e0cbff8dc6be.camel@hammerspace.com>
 <11744FC6-5EFB-427A-ADB4-D211BA1C74F4@redhat.com>
 <f9ca09baa9e41000ab6286a27de567ca306f6991.camel@hammerspace.com>
 <6878D746-0A5E-4815-A520-5CE7CD98A1E2@redhat.com>
 <FDB38E78-8980-46CA-B936-F82C7C104071@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Feb 2022, at 15:23, Benjamin Coddington wrote:

> int main(int argc, char **argv)
> {
> 	int i, dir_fd, bpos, total = 0;
>     size_t nread;
> 	struct linux_dirent {

Ugh.. and sorry about the whitespace mess.

