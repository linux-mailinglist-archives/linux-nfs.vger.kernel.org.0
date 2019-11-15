Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1FFE032
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKOOfz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 09:35:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727411AbfKOOfz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 09:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573828552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiQygCSwMU8hUwI8fAqbAOFYE6BUdiqYyI913Djk75M=;
        b=iCyQsIepRKDpkRclXtXpYHLBD19dHmiv9us5IfXK2jIeSJDu8YneN+4/BABqcViW7BDzwY
        zUQ2JwbPL+2AWJ/FPFiYkgIjSQvqSycGV1yFXo+9W7351RvJpJHs61tdr4cHtJdDnrCMii
        SKTw6qWG2KJ9EuEp/GcZRBV0SgLdvCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-HteGLJLlNB6plTlo_RutAg-1; Fri, 15 Nov 2019 09:35:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA320800A02;
        Fri, 15 Nov 2019 14:35:47 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AFE95DC1B;
        Fri, 15 Nov 2019 14:35:47 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
Date:   Fri, 15 Nov 2019 09:35:44 -0500
Message-ID: <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
In-Reply-To: <20191115133907.15900.51854.stgit@manet.1015granger.net>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HteGLJLlNB6plTlo_RutAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; format=flowed; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Nov 2019, at 8:39, Chuck Lever wrote:

> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
> This can happen when xdr_buf_read_mic() is given an xdr_buf with
> a small page array (like, only a few bytes).

Hi Chuck,

Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how this=20
can
happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf has=20
bug?

I'd prefer to keep the BUG_ON.  How can I reproduce it?

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 14ba9e72a204..71d754fc780e 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf, struct=20
xdr_netobj *mic, unsigned int o
         if (offset < boundary && (offset + mic->len) > boundary)
                 xdr_shift_buf(buf, boundary - offset);

+       trace_printk("boundary %d, offset %d, page_len %d\n", boundary,=20
offset, buf->page_len);
+
         /* Is the mic partially in the pages? */
         boundary +=3D buf->page_len;
         if (offset < boundary && (offset + mic->len) > boundary)

^^ that should be enough for me to try to figure out what's doing wrong.

Ben

