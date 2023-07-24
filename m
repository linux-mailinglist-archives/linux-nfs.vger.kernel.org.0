Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843AC7602FA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGXXPy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 19:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXPx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 19:15:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530610FA;
        Mon, 24 Jul 2023 16:15:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1852221FFC;
        Mon, 24 Jul 2023 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690240551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaPsAZgv2K2/b+sXSYIrVCCFrSUdfQerUaqQeMt9zpI=;
        b=r2yyUIvKP01oICrwkvG1YvS1jMv1xiBCN8zfLXQD2Rb4xVKtdsK5GhRxqWOxVvY+Z4adW8
        XHIdxU67p8mt4j5GjfD36DOyx4oXz7silULhEsRkot1BrxlRR6BxuJJLfO5uaD0GHU0i4Q
        v4eMKlbCoqcw7euzythpr+W07dk7Dek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690240551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaPsAZgv2K2/b+sXSYIrVCCFrSUdfQerUaqQeMt9zpI=;
        b=+4zKogHUNn+m+usOQ87v74S8mb76kWqu1edZHMpJ0eH5R8Y0YxQQwiEPOKyhpzhVQcujIg
        XlKLXylm71aAX1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A4513476;
        Mon, 24 Jul 2023 23:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dubYDCQGv2RfTgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jul 2023 23:15:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: set missing after_change as before_change + 1
In-reply-to: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
References: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
Date:   Tue, 25 Jul 2023 09:15:43 +1000
Message-id: <169024054352.11078.14089484038867274825@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jul 2023, Jeff Layton wrote:
> In the event that we can't fetch post_op_attr attributes, we still need
> to set a value for the after_change. The operation has already happened,
> so we're not able to return an error at that point, but we do want to
> ensure that the client knows that its cache should be invalidated.
>=20
> If we weren't able to fetch post-op attrs, then just set the
> after_change to before_change + 1. The atomic flag should already be
> clear in this case.
>=20
> Suggested-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3f6710c9c5c9..f0f318e78630 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -411,7 +411,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct=
 svc_fh *fhp)
>  	if (WARN_ON_ONCE(!fhp->fh_pre_saved))
>  		cinfo->before_change =3D 0;
>  	if (!fhp->fh_post_saved)
> -		cinfo->after_change =3D 0;
> +		cinfo->after_change =3D cinfo->before_change + 1;
>  }

Thanks for this Jeff.
Only problem is that the comment above this code is now even more wrong
than it was before :-)

I cannot convincingly argue that having the "+1" is better than not (as
Chuck wondered about), but I think "0" is completely arbitrary, while
->before_change+1 is the sort of value we might reasonably expect.

Thanks,
NeilBrown


> =20
>  static __be32
>=20
> ---
> base-commit: 97a5d0146ef443df148805a4e9c3c44111f14ab1
> change-id: 20230724-bz2223560-5ed6bc3a5db7
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

