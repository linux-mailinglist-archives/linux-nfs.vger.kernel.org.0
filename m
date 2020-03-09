Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9664117DDFB
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIKy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 06:54:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgCIKy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 06:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583751266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xlx6OFc71ZHqLarIifP9l9s+njvb0a9FmBhjKd9NKXg=;
        b=NcX0PM4C7xKNbaicRmKBa1xHl4zeDMCmZfkmYBZ5XlGg+NJWfjx7Bq1cJtkDl8yA1BbdXc
        1XLVxV5P3QtIYg8C6swUYew0hQXg5Dg81BP/xZJYqj3QsHteHKCkTFoN338RYvXWYNIlaf
        0Q0UrFr0OW18wctOE5F4pZviuWu0/Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-rv1vAsdtNFS8BvH_bT-yqQ-1; Mon, 09 Mar 2020 06:54:25 -0400
X-MC-Unique: rv1vAsdtNFS8BvH_bT-yqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C13801E53;
        Mon,  9 Mar 2020 10:54:24 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9CF87B2F;
        Mon,  9 Mar 2020 10:54:23 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/2] sunrpc: Fix gss_unwrap_integ_resp() again
Date:   Mon, 09 Mar 2020 06:54:57 -0400
Message-ID: <1F3702F4-9E70-4F18-93A8-2EF8AC96E958@redhat.com>
In-Reply-To: <20200308181503.14148.29579.stgit@manet.1015granger.net>
References: <20200308181503.14148.29579.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Mar 2020, at 14:15, Chuck Lever wrote:

> xdr_buf_read_mic() tries to find unused contiguous space in a
> received xdr_buf in order to linearize the checksum for the call
> to gss_verify_mic. However, the corner cases in this code are
> numerous and we seem to keep missing them. I've just hit yet
> another buffer overrun related to it.
>
> This overrun is at the end of xdr_buf_read_mic():
>
> 1284         if (buf->tail[0].iov_len != 0)
> 1285                 mic->data = buf->tail[0].iov_base + 
> buf->tail[0].iov_len;
> 1286         else
> 1287                 mic->data = buf->head[0].iov_base + 
> buf->head[0].iov_len;
> 1288         __read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
> 1289         return 0;
>
> This logic assumes the transport has set the length of the tail
> based on the size of the incoming message. base + len is then
> supposed to be off the end of the message.
>
> In fact, the length of the tail is set by the upper layer before
> the receive so that the end of the tail is actually the end of the
> allocated buffer itself. This causes the logic above to set
> mic->data to point past the end of the receive buffer.
>
> The "mic->data = head" arm of this if statement is no less fragile.
>
> Instead, let's use a more straightforward approach: kmalloc a
> separate buffer to linearize the checksum.
>
> As near as I can tell, this has been a problem forever. I'm not sure
> that minimizing au_rslack recently changed this pathology much.
>
> I had some trouble, coming back to this code, understanding what
> was going on. So I've cleaned up the variable naming and added
> a few comments that point back to the XDR definition in RFC 2203
> to help guide future spelunkers, including myself.
>
> As an added clean up, the functionality that was in
> xdr_buf_read_mic() is folded directly into gss_unwrap_integ_resp(),
> as that is its only caller, and now the code that sets rslack will
> be right next to the code that uses that extra space.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>


xdr_buf_read_mic() seemed simple, but I agree - it was assuming a lot 
and I
struggled with it.  Thanks for doing this.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

