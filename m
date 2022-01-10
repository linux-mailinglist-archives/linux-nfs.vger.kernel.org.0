Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F97489D0F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiAJQFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 11:05:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39894 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 11:05:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8048B8168C;
        Mon, 10 Jan 2022 16:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C84C36AE3;
        Mon, 10 Jan 2022 16:05:37 +0000 (UTC)
Date:   Mon, 10 Jan 2022 11:05:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix sockaddr handling in NFSD trace points
Message-ID: <20220110110535.25ca51bf@gandalf.local.home>
In-Reply-To: <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
References: <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 10 Jan 2022 10:56:49 -0500
Chuck Lever <chuck.lever@oracle.com> wrote:

> The patches in this series address a simple buffer over-read bug in
> the Linux NFS server.
> 
> However I was thinking it would be nice to have trace helpers to
> deal safely with generic socket addresses. I'd like to be able to
> treat them the same way we currently treat strings. So for example:
> 
> 
> #define field_sockaddr(field, len)  __dynamic_array(u8, field, len)
> #define assign_sockaddr(dest, src, len)  memcpy(__get_dynamic_array(dest), src, len)
> #define __get_sockaddr(field)  ((struct sockaddr *)__get_dynamic_array(field))
> 
> TRACE_EVENT(sockaddr_example,
>         TP_PROTO(
>                 const struct sockaddr *sap,
>                 size_t salen
>         ),  
>         TP_ARGS(sap, salen),
>         TP_STRUCT__entry(
>                 __field_sockaddr(addr, salen)
>         ),  
>         TP_fast_assign(
>                 __assign_sockaddr(addr, sap, salen);
>         ),  
>         TP_printk("addr=%pIS", __get_sockaddr(addr))
> );
> 
> 
> should be able to store any address family in a dynamically-sized
> array field (addr).
> 
> I haven't quite been able to figure out how to handle the 
> TP_printk() part of this equation. `trace-cmd report` displays
> something like "addr=ARG TYPE NOT FIELD BUT 7". 
> 
> Thoughts or advice appreciated.

I'll take a look into it.

Thanks,

-- Steve
