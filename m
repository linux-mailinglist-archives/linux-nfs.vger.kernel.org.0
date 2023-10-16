Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63F7CB499
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPUZM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUZM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 16:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96036B4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697487864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSycGW65jMbt+CQATVQkWTjQSQLfxqZmVK2cIwr2iuY=;
        b=IuK6iI6pdqvB+HxL3Y7IW0+UGjAri5eE4Lv1ntVP7NBe47f7WV7RQ5hQP0nJtSpvauMItz
        K2sbR/KKXKt7eVAkPUg7R+cUIREbwoVbtZKJgg2n0NWx0q/txwiy834z8XBZ6jdR01UwZn
        I18IWlUS/3/LXzHSUfZJ5DNFbU5Ultc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-nbMwG-KhNvqNS9cfmfR0cw-1; Mon, 16 Oct 2023 16:24:17 -0400
X-MC-Unique: nbMwG-KhNvqNS9cfmfR0cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F1DB3C17082;
        Mon, 16 Oct 2023 20:24:17 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2190140C6F79;
        Mon, 16 Oct 2023 20:24:16 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: bpftrace script to monitor tasks that are stuck in NFSv4
 exception loops
Date:   Mon, 16 Oct 2023 16:24:15 -0400
Message-ID: <6DD7E20A-1AD9-4654-B595-93A1E9585E8D@redhat.com>
In-Reply-To: <c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7.camel@hammerspace.com>
References: <c3e1e5ccc8ac88cee2c0f2b8414283038dc9b8f7.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Oct 2023, at 11:15, Trond Myklebust wrote:

> See attachment.

Cool.  Thanks for this - looks pretty similar to the systemtap stuff we u=
se, but compile times are faster here.

I wonder if bpftrace can do the "guru" things that systemtap can, like mo=
dify the stack and memory.

Seems it works with gcc too, just needed CONFIG_DEBUG_INFO_BTF=3Dy.  I wi=
ll play with it a bit.

Ben

