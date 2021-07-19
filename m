Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4843CD443
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhGSLUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 07:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhGSLUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 07:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626696092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTWCi9YhzLnnmfJrR0EP+vfsFkGiDUxW+pcvIAIKvmM=;
        b=fX82iIqriu1OQUYQ9Ay6y6stYhEs9s4g0Yv1ixdfjZ0Gnf57dIc8agQkzdea3S3z73nWym
        XCL+ycwVQm9HFCdB8spEum9fUPmU/HAzQoSxbZK7YoehAhLApXBkfYPp4F/ban03kao0Ce
        tp/0GfeN5rzG+JlcvdjW7tbvTSLR3/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-4XYO02h3MW-hUYStaAwnXQ-1; Mon, 19 Jul 2021 08:01:28 -0400
X-MC-Unique: 4XYO02h3MW-hUYStaAwnXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7585C10B746C;
        Mon, 19 Jul 2021 12:01:27 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 999E55D9F0;
        Mon, 19 Jul 2021 12:01:26 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     "Xiyu Yang" <xiyuyang19@fudan.edu.cn>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Convert rpc_client refcount to use refcount_t
Date:   Mon, 19 Jul 2021 08:01:25 -0400
Message-ID: <6AF75462-495E-4B63-9A3E-C9639C45C1F2@redhat.com>
In-Reply-To: <20210717172052.232420-1-trondmy@kernel.org>
References: <20210717172052.232420-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On 17 Jul 2021, at 13:20, trondmy@kernel.org wrote:

> @@ -943,7 +941,7 @@ rpc_release_client(struct rpc_clnt *clnt)
>  	do {
>  		if (list_empty(&clnt->cl_tasks))
>  			wake_up(&destroy_wait);
> -		if (!atomic_dec_and_test(&clnt->cl_count))
> +		if (refcount_dec_not_one(&clnt->cl_count))

I guess we're not worried about extra calls racing into rpc_free_auth?

.. hmm, it looks like current code can do that already since we're bumping the
ref up again.  Seems like we could end up in rpcauth_release twice with
an underflow on au_count.

Ben

