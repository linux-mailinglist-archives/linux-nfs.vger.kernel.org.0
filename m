Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABD752BE4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGMVKA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGMVJ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 17:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9862D43
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689282551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U711Z1uQz6tTIE8o//Y3xXXHuKVpTZrPHY+cKVNc4gM=;
        b=B3HMayDfGRhqX4a/1YtF8DhsDtJ2q2eJRLsAf1SASCqPXocpCKQJ8I9a4kNADQtEYBVHJH
        rTtO1lPyQeB0tC5xcTncNGHgLwoLHmDPQBH8Lu8HaQPIQIpygrHJEf1e4AK/1MDu0PBPR/
        RGRBerKxGHej+UVrW8zCyOqprTSJU6A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-l-ey2Na3NoGsksJwGsLojw-1; Thu, 13 Jul 2023 17:09:02 -0400
X-MC-Unique: l-ey2Na3NoGsksJwGsLojw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1EA92808E60;
        Thu, 13 Jul 2023 21:09:01 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32C24207B348;
        Thu, 13 Jul 2023 21:09:01 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open
 getattr
Date:   Thu, 13 Jul 2023 17:08:59 -0400
Message-ID: <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com>
In-Reply-To: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jul 2023, at 15:54, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, if the OPEN compound experiencing an error and needs to
> get the file attributes separately, it will send a stand alone
> GETATTR but it would use the filehandle from the results of
> the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
> is zero value. That generate a GETATTR that's sent with a zero
> value filehandle, and results in the server returning an error.
>
> Instead, for the CLAIM_FH OPEN, take the filehandle that was used
> in the PUTFH of the OPEN compound.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 8edc610dc1d3..0b1b49f01c5b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
>  			return status;
>  	}
>  	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> +		struct nfs_fh *fh = &o_res->fh;
> +
>  		nfs4_sequence_free_slot(&o_res->seq_res);
> -		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
> +		if (o_arg->claim == NFS4_OPEN_CLAIM_FH)
> +			fh = NFS_FH(d_inode(data->dentry));
> +		nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
>  	}
>  	return 0;
>  }

Looks good, but why not just use o_arg->fh?  Maybe also an opportunity
to fix the whitespace damage a few lines before this hunk too.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

