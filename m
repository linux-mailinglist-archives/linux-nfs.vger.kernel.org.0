Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D964763605
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjGZMPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGZMPV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 08:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D219A7
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690373674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9y3yg5KgefYDIN9bSf2g3F3ifzh5J50cmp3vp0NbN6I=;
        b=U9Hho0QLpuLnYUHDQUMeHKiTBrlev/VSRxb5m4L8EPrIFLp3CDXMt+LV4hSHf1QSWpPN6E
        4yYvMr5cjBy0P/olkLME5BOMexS+/m9NIFeK3kbykh68RaIhNIoCXiwAMnZzAUWCrJLU3u
        zburqXOza8Ou1VM7BTRSfEpwuaT8pgc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-VAR8qLzmMzq89RhDCSTq8g-1; Wed, 26 Jul 2023 08:14:32 -0400
X-MC-Unique: VAR8qLzmMzq89RhDCSTq8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 520162815E2A;
        Wed, 26 Jul 2023 12:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE5D0492CA6;
        Wed, 26 Jul 2023 12:14:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <168979148257.1905271.8311839188162164611.stgit@morisot.1015granger.net>
References: <168979148257.1905271.8311839188162164611.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To:     Chuck Lever <cel@kernel.org>
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 4/5] SUNRPC: Revert e0a912e8ddba
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6617.1690373671.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 13:14:31 +0100
Message-ID: <6618.1690373671@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever <cel@kernel.org> wrote:

> Flamegraph analysis showed that the cork/uncork calls consume
> nearly a third of the CPU time spent in svc_tcp_sendto(). The
> other two consumers are mutex lock/unlock and svc_tcp_sendmsg().
> 
> Now that svc_tcp_sendto() coalesces RPC messages properly, there
> is no need to introduce artificial delays to prevent sending
> partial messages.
> 
> After applying this change, I measured a 1.2K read IOPS increase
> for 8KB random I/O (several percent) on 56Gb IP over IB.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

