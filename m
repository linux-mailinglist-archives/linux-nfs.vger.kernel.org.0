Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7333A9A1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 03:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCOC2B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Mar 2021 22:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhCOC16 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Mar 2021 22:27:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C2C061574;
        Sun, 14 Mar 2021 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=QSmBSuV2NHVPiaRqNPiSvTfBdIPB2nqBxyfXmnbLyBo=; b=c5l1qG4BRqrkUPXShbTGjGR5Pd
        GmH+jvNK6oTooHxMEfcTzQSwcH1d03wahGDtJQeJv6et2meI+2Zmm0pCF7bpJljFxXKp9f4IEY8dS
        a7yc9rdMOTKP6HGyIDtt56G51Tb/9sZE6cF2wfvmugoOTWdslzlEaTQ5S8nkYqMroywc0rdxzg8tB
        wVfaJLeT8vsLLtFcsdXu7hlbyN7UN77Wuwq7jVx0zyNDpvyiDM7/4lIP/LXW0D1W7K8c1A0O/qAEF
        Nt0pnpv1oTw9IWNy6JumVzu81gTdOs3vdnuqN/O06Bt3dlBioAgdYFraDXO9oxLWv92pLyAqwLZ3F
        fU+dUWWA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLcxG-001FPG-5U; Mon, 15 Mar 2021 02:27:54 +0000
Subject: Re: [PATCH] nfs: Fix a typo in the file nfs42xattr.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210315012410.11725-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f87a9305-fe47-0127-b33c-1d24a699d350@infradead.org>
Date:   Sun, 14 Mar 2021 19:27:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315012410.11725-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/14/21 6:24 PM, Bhaskar Chowdhury wrote:
> 
> s/attribues/attributes/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  fs/nfs/nfs42xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index 6c2ce799150f..1c4d2a05b401 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -168,7 +168,7 @@ nfs4_xattr_entry_lru_del(struct nfs4_xattr_entry *entry)
>   *	   make it easier to copy the value after an RPC, even if
>   *	   the value will not be passed up to application (e.g.
>   *	   for a 'query' getxattr with NULL buffer).
> - * @len:   Length of the value. Can be 0 for zero-length attribues.
> + * @len:   Length of the value. Can be 0 for zero-length attributes.
>   *         @value and @pages will be NULL if @len is 0.
>   */
>  static struct nfs4_xattr_entry *
> --


-- 
~Randy

