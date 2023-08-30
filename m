Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CF78E098
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjH3U1B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjH3U0s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 16:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731E172E
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2268637FA
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 20:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD75C433C7;
        Wed, 30 Aug 2023 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693426208;
        bh=VGc01mBXjPDfupC5zI1b1ww0RTDC4aJVRd66xOhAsI0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=arM7Uils9HA21n1MqrRiBUQK8uwYfegD/2AAnz+EpYwu4oqSWhynn+mfgevp1i7/T
         F7vflzHamYtgq1Ve9mSuw+huM8O1Keq/4UlMb7DIUjFl/qzYi4u/m4t0u6lVG9UKux
         5RC2SZKgzKAPmqt0+XLUK5jRzsfEcnESLVRng2YiQeXEf0gjaGQahAgZXcgNyBVgI/
         WjyCOIJRYz6U84u+skFBUF3YWtSyI57+yJpIYZCJv3YAW/6C8i11iS0GiYn36RoDMT
         DN/EJenBwqrDX54IK3vEXumoztTRyaW9SBUb2xDrnpR6YMolBwgBIoZ+J3smUkZbaK
         yBGGbc7xqLnLA==
Message-ID: <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 30 Aug 2023 16:10:06 -0400
In-Reply-To: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-08-30 at 15:42 -0400, Benjamin Coddington wrote:
> Again we have claimed regressions for walking a directory tree, this time
> with the "find" utility which always tries to optimize away asking for an=
y
> attributes until it has a complete list of entries.  This behavior makes
> the readdir plus heuristic do the wrong thing, which causes a storm of
> GETATTRs to determine each entry's type in order to continue the walk.
>=20
> For v4 add the type attribute to each READDIR request to include it no
> matter the heuristic.  This allows a simple `find` command to proceed
> quickly through a directory tree.
>=20

The important bit here is that with v4, we can fill out d_type even when
"plus" is false, at little cost. The downside is that non-plus READDIR
replies will now be a bit larger on the wire. I think it's a worthwhile
tradeoff though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>=20
> --
> On v2: Don't add the type attribute twice
> ---
>  fs/nfs/nfs4xdr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index deec76cf5afe..7200d6f7cd7b 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1602,7 +1602,7 @@ static void encode_read(struct xdr_stream *xdr, con=
st struct nfs_pgio_args *args
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_rea=
ddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
>  	uint32_t attrs[3] =3D {
> -		FATTR4_WORD0_RDATTR_ERROR,
> +		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
>  		FATTR4_WORD1_MOUNTED_ON_FILEID,
>  	};
>  	uint32_t dircount =3D readdir->count;
> @@ -1612,7 +1612,7 @@ static void encode_readdir(struct xdr_stream *xdr, =
const struct nfs4_readdir_arg
>  	unsigned int i;
> =20
>  	if (readdir->plus) {
> -		attrs[0] |=3D FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
> +		attrs[0] |=3D FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
>  		attrs[1] |=3D FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWN=
ER|
>  			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|

