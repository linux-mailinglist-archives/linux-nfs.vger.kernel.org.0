Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7237C8686
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjJMNOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:14:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966A91
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 06:14:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92DC433C7;
        Fri, 13 Oct 2023 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697202887;
        bh=7nX8WlV7M4S8nh/pp6XhvlBtmLKutdCanz3gBIHfNW0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=STGzYBfy2SaDsK0GWsWQY5MX7ctt5YuZzDtz5wsTeB38jSkQePlT+QhZ9QF8Dk5kG
         5iRSA/40lU6pEyGY4s5Ylsq28G0FmxxYjp9CU8s0gLaGkFqowQNqQwgtDMUEQJ4EgJ
         9fN68Wye5leQKUbY3PtLxOwEJ0Ml6hYfPLZXh0ySdZ1BdfuAOwzcAVTb8jIHta8poE
         bC2tIsvyYAS9BufKGrnIqxUI7dnyXOhQl9N7L0ik0LBkLnwmE9emvvs45xIS70rftt
         T57Djx6Bdct2ByA50wpux36wzPbUKo4IS7TNPzbiv5t+29lJ0c9CgHHQMR7jHlwbNI
         iuZk+LiUATBIw==
Message-ID: <eb2348e3bf7192ab39dabdb19e7901e5cace02d4.camel@kernel.org>
Subject: Re: [PATCH] svcrdma: Fix tracepoint printk format
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 13 Oct 2023 09:14:46 -0400
In-Reply-To: <169719969566.6999.18083178189502993580.stgit@oracle-102.nfsv4bat.org>
References: <169719969566.6999.18083178189502993580.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-10-13 at 08:22 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Other tracepoints use "cq.id=3D" rather than "cq_id=3D". Let's make it
> more reliable to grep for the CQ restracker ID.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/rpcrdma.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> One more trivial fix to svcrdma for 6.7.
>=20
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdm=
a.h
> index f8069ef2ee0f..718df1d9b834 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -1667,7 +1667,7 @@ TRACE_EVENT(svcrdma_encode_wseg,
>  		__entry->offset =3D offset;
>  	),
> =20
> -	TP_printk("cq_id=3D%u cid=3D%d segno=3D%u %u@0x%016llx:0x%08x",
> +	TP_printk("cq.id=3D%u cid=3D%d segno=3D%u %u@0x%016llx:0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1703,7 +1703,7 @@ TRACE_EVENT(svcrdma_decode_rseg,
>  		__entry->offset =3D segment->rs_offset;
>  	),
> =20
> -	TP_printk("cq_id=3D%u cid=3D%d segno=3D%u position=3D%u %u@0x%016llx:0x=
%08x",
> +	TP_printk("cq.id=3D%u cid=3D%d segno=3D%u position=3D%u %u@0x%016llx:0x=
%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->position, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1740,7 +1740,7 @@ TRACE_EVENT(svcrdma_decode_wseg,
>  		__entry->offset =3D segment->rs_offset;
>  	),
> =20
> -	TP_printk("cq_id=3D%u cid=3D%d segno=3D%u %u@0x%016llx:0x%08x",
> +	TP_printk("cq.id=3D%u cid=3D%d segno=3D%u %u@0x%016llx:0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->segno, __entry->length,
>  		(unsigned long long)__entry->offset, __entry->handle
> @@ -1959,7 +1959,7 @@ TRACE_EVENT(svcrdma_send_pullup,
>  		__entry->msglen =3D msglen;
>  	),
> =20
> -	TP_printk("cq_id=3D%u cid=3D%d hdr=3D%u msg=3D%u (total %u)",
> +	TP_printk("cq.id=3D%u cid=3D%d hdr=3D%u msg=3D%u (total %u)",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->hdrlen, __entry->msglen,
>  		__entry->hdrlen + __entry->msglen)
> @@ -2014,7 +2014,7 @@ TRACE_EVENT(svcrdma_post_send,
>  					wr->ex.invalidate_rkey : 0;
>  	),
> =20
> -	TP_printk("cq_id=3D%u cid=3D%d num_sge=3D%u inv_rkey=3D0x%08x",
> +	TP_printk("cq.id=3D%u cid=3D%d num_sge=3D%u inv_rkey=3D0x%08x",
>  		__entry->cq_id, __entry->completion_id,
>  		__entry->num_sge, __entry->inv_rkey
>  	)
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
