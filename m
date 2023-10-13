Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB887C86B5
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJMNWD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjJMNWC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF22BE
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697203276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QQQE31zFpo8QatpPTAvUD2SVRPdN5cNZGFnMJG0fc5U=;
        b=WhHD85KeUJ7d2LjzJWrU0kcC6O48N8XyLNg+dtcVjiaJjA5PFxF0Bs/VPicaJom7ggpaYw
        kbzJuvw4rou8K/jtoNbvMfOjm20HyoAr/S4ShUwBYL4MMkLB7H7T4+0pyKcxyTv2dyrQew
        kZadvU0olZ4ERyEcvthRf9gLRmgRaXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-BZaXNoJEPxq5fxXbi_-ttQ-1; Fri, 13 Oct 2023 09:21:05 -0400
X-MC-Unique: BZaXNoJEPxq5fxXbi_-ttQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E20193C170B3;
        Fri, 13 Oct 2023 13:21:04 +0000 (UTC)
Received: from [10.22.32.24] (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E0620296DB;
        Fri, 13 Oct 2023 13:21:04 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] svcrdma: Fix tracepoint printk format
Date:   Fri, 13 Oct 2023 09:21:04 -0400
Message-ID: <26C93D24-5CC6-44CD-9825-17D7D46A64FC@redhat.com>
In-Reply-To: <169719969566.6999.18083178189502993580.stgit@oracle-102.nfsv4bat.org>
References: <169719969566.6999.18083178189502993580.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Oct 2023, at 8:22, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> Other tracepoints use "cq.id=" rather than "cq_id=". Let's make it
> more reliable to grep for the CQ restracker ID.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/rpcrdma.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> One more trivial fix to svcrdma for 6.7.
>
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index f8069ef2ee0f..718df1d9b834 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -1667,7 +1667,7 @@ TRACE_EVENT(svcrdma_encode_wseg,
>  		__entry->offset = offset;
>  	),
>
> -	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
> +	TP_printk("cq.id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1703,7 +1703,7 @@ TRACE_EVENT(svcrdma_decode_rseg,
>  		__entry->offset = segment->rs_offset;
>  	),
>
> -	TP_printk("cq_id=%u cid=%d segno=%u position=%u %u@0x%016llx:0x%08x",
> +	TP_printk("cq.id=%u cid=%d segno=%u position=%u %u@0x%016llx:0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->position, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1740,7 +1740,7 @@ TRACE_EVENT(svcrdma_decode_wseg,
>  		__entry->offset = segment->rs_offset;
>  	),
>
> -	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
> +	TP_printk("cq.id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1959,7 +1959,7 @@ TRACE_EVENT(svcrdma_send_pullup,
>  		__entry->msglen = msglen;
>  	),
>
> -	TP_printk("cq_id=%u cid=%d hdr=%u msg=%u (total %u)",
> +	TP_printk("cq.id=%u cid=%d hdr=%u msg=%u (total %u)",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->hdrlen, __entry->msglen,
>  		__entry->hdrlen + __entry->msglen)
> @@ -2014,7 +2014,7 @@ TRACE_EVENT(svcrdma_post_send,
>  					wr->ex.invalidate_rkey : 0;
>  	),
>
> -	TP_printk("cq_id=%u cid=%d num_sge=%u inv_rkey=0x%08x",
> +	TP_printk("cq.id=%u cid=%d num_sge=%u inv_rkey=0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->num_sge, __entry->inv_rkey
>  	)

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

