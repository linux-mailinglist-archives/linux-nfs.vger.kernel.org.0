Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEA797672
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Sep 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjIGQJl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjIGQIt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 12:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC7D141
        for <linux-nfs@vger.kernel.org>; Thu,  7 Sep 2023 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694102413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WOmAueS9mqp0ZzoPfp6HN6djs5DvNfkjb4UeJLLDx04=;
        b=dnC4Aa9c3DzOvRm29f6XKv3HPA0aCH48lJSXX5kdG9w/E9JxCvEyttYbOOetdgc9xjM+sP
        V4psq2fr6Mb4SSmfagIYcB8C7cmwGfsp61W+sNOtd8vuenyfDvEvlQFdiA3zO8mQwzfqk+
        LjhbA/e6OFrjkMQfAuhy2+ru4NfinAE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-tzJbWiqJN8CGd3m3O91PYQ-1; Thu, 07 Sep 2023 08:43:43 -0400
X-MC-Unique: tzJbWiqJN8CGd3m3O91PYQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B04F03815F6A;
        Thu,  7 Sep 2023 12:43:42 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01ED0403171;
        Thu,  7 Sep 2023 12:43:41 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
Date:   Thu, 07 Sep 2023 08:43:40 -0400
Message-ID: <202D34A7-61AC-44DA-B2C1-CCE109EC2A76@redhat.com>
In-Reply-To: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond and Anna - two questions:

Any chance of this going this cycle upon its merits of simplicity outweig=
hing the lateness?

If no - can we expect it on 6.7, or should I continue to look for another=
 approach that doesn't potentially penalize some servers?

Ben

On 30 Aug 2023, at 15:42, Benjamin Coddington wrote:

> Again we have claimed regressions for walking a directory tree, this ti=
me
> with the "find" utility which always tries to optimize away asking for =
any
> attributes until it has a complete list of entries.  This behavior make=
s
> the readdir plus heuristic do the wrong thing, which causes a storm of
> GETATTRs to determine each entry's type in order to continue the walk.
>
> For v4 add the type attribute to each READDIR request to include it no
> matter the heuristic.  This allows a simple `find` command to proceed
> quickly through a directory tree.
>
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> --
> On v2: Don't add the type attribute twice
> ---
>  fs/nfs/nfs4xdr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index deec76cf5afe..7200d6f7cd7b 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1602,7 +1602,7 @@ static void encode_read(struct xdr_stream *xdr, c=
onst struct nfs_pgio_args *args
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_r=
eaddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
>  	uint32_t attrs[3] =3D {
> -		FATTR4_WORD0_RDATTR_ERROR,
> +		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
>  		FATTR4_WORD1_MOUNTED_ON_FILEID,
>  	};
>  	uint32_t dircount =3D readdir->count;
> @@ -1612,7 +1612,7 @@ static void encode_readdir(struct xdr_stream *xdr=
, const struct nfs4_readdir_arg
>  	unsigned int i;
>
>  	if (readdir->plus) {
> -		attrs[0] |=3D FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZ=
E|
> +		attrs[0] |=3D FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
>  		attrs[1] |=3D FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_O=
WNER|
>  			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
> -- =

> 2.

