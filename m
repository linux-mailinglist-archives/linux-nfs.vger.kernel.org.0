Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF05700ED
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGKLnC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiGKLmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 07:42:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824B5F46;
        Mon, 11 Jul 2022 04:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB4ADB80ECA;
        Mon, 11 Jul 2022 11:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9DCC34115;
        Mon, 11 Jul 2022 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657539414;
        bh=kF3naYkn9TsKaZxpNPMS3m1oJCrlOfY++NFPSnWbcjk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P8a5F9r5XUQTZxeQBnSEB9XXLYdHMVXuux1hN/ka+MQ6Xe67ra0vQHidEgJ+AMn/E
         xdLwveOcrMKOFHhvp6QTopbVM9KW7qBIUgQhupCxdHy8/i+DQWtu48uPgjCeIZOhHZ
         //TbAEQWhLJxYrvTcCNyNwkS1l2cQGifpBWPTHnIFd5RtlWc5WknQ80Bz23saRPht2
         AMUKOEkSx8YvcPI1WqRa0P5RDJnWVL6vuYDnVqsH7UKCdER1N0OgKGCDX3m/WpnnOQ
         IQcIX7DcBdbNInCTC4ksfs72e2jz/zbzWOrfPDjiMY/kX3B+HbIhk2t6JS6eef1Kys
         7I3kGpTh0dMCg==
Message-ID: <531053e36e291fc5d99bb766e76d52b0333ecc94.camel@kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, imammedo@redhat.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jul 2022 07:36:52 -0400
In-Reply-To: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-07-10 at 14:46 -0400, Chuck Lever wrote:
> NFSD has advertised support for the NFSv4 time_create attribute
> since commit e377a3e698fb ("nfsd: Add support for the birth time
> attribute").
>=20
> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
> birth time attribute via OPEN(CREATE) and SETATTR if the server
> indicates that it supports it, but since the above commit was
> merged, those attempts now fail.
>=20
> Table 5 in RFC 8881 lists the time_create attribute as one that can
> be both set and retrieved, but the above commit did not add server
> support for clients to provide a time_create attribute. IMO that's
> a bug in our implementation of the NFSv4 protocol, which this commit
> addresses.
>=20
> Whether NFSD silently ignores the new birth time or actually sets it
> is another matter. I haven't found another filesystem service in the
> Linux kernel that enables users or clients to modify a file's birth
> time attribute.
>=20
> This commit reflects my (perhaps incorrect) understanding of whether
> Linux users can set a file's birth time. NFSD will now recognize a
> time_create attribute but it ignores its value. It clears the
> time_create bit in the returned attribute bitmask to indicate that
> the value was not used.
>=20
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c |    9 +++++++++
>  fs/nfsd/nfsd.h    |    3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 61b2aae81abb..2acea7792bb2 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp,=
 u32 *bmval, u32 bmlen,
>  			return nfserr_bad_xdr;
>  		}
>  	}
> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
> +		struct timespec64 ts;
> +
> +		/* No Linux filesystem supports setting this attribute. */
> +		bmval[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> +		status =3D nfsd4_decode_nfstime4(argp, &ts);
> +		if (status)
> +			return status;
> +	}
>  	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
>  		u32 set_it;
> =20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 847b482155ae..9a8b09afc173 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorvers=
ion, const u32 *bmval)
>  	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
>  #define NFSD_WRITEABLE_ATTRS_WORD1 \
>  	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
> +	| FATTR4_WORD1_TIME_MODIFY_SET)
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>  	FATTR4_WORD2_SECURITY_LABEL
>=20
>=20

RFC5661 lists time_create as being writeable, so silently ignoring it
seems wrong. It seems like we ought to have nfsd attempt to set the
btime and then just return an error if it doesn't work...but, I don't
see a mechanism in the kernel for setting it. ATTR_BTIME doesn't exist,
for instance.

Still, since we can't set it, returning an error there seems more
correct. NFS4ERR_INVAL is probably the wrong one -- maybe
NFS4ERR_NOTSUPP ? It's a bit weird since we do support querying it, but
not setting it. Maybe we need to propose a new NFS4ERR_ATTR_RO ?

--=20
Jeff Layton <jlayton@kernel.org>
