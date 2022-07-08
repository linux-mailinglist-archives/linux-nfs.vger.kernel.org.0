Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572056C284
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Jul 2022 01:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiGHThK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jul 2022 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiGHThK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jul 2022 15:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ADF165D50
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jul 2022 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657309028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZZbYOOcXAtwVe1yHJ9sPLjzHsng5usdRE+DGZNGrHI=;
        b=PsEnEq7G7pWUat500Cfpxr8X+Nj4UYgWqyJmIuSOOXk72phVM4khw005PURadQU6HvPCut
        xaFD7blxUIZsoTt8s19GD+77r6T3ZCClNCF1Ubpq5E8K7s4E+CCe/fHyX4+BJcwXJRrEfJ
        QGPhJ0Iy8AmTQwXWS6n+VVPH1GZvYVQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-dmTeRHKMOJanrW4DmtxUng-1; Fri, 08 Jul 2022 15:37:07 -0400
X-MC-Unique: dmTeRHKMOJanrW4DmtxUng-1
Received: by mail-qk1-f198.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so21640076qkb.9
        for <linux-nfs@vger.kernel.org>; Fri, 08 Jul 2022 12:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=LZZbYOOcXAtwVe1yHJ9sPLjzHsng5usdRE+DGZNGrHI=;
        b=RCdDxb6eO5e9tbi4BAssDm1HlaXAaFQm3ZB8moIYP1Eqrpok4QffONOdCwY9fqiT4i
         IgxiiO9MYaZXDkyfYDndl8DbKL7WZ7uKlwAPrIbIjEVIxaYzQ//f3ro4DudeQv84JvnQ
         Zl04t5rlWLJPoCa1GGm08DE8MBB+/pukUfp6ctPJASpOw0HzASbnBwy3r8z/X8r9p8wi
         tevTszVSRngsJoLCw+AsdEyBDjWiGefH/lr2FapA5yixz/MieLpKswPQGBbpgjnR/LFc
         nZoblsuRE0b5HiiNer6rbMWQyWZDxMp3baugdRMsYkntf0PlE6vF8khYhzG+nUubgJGU
         WzGw==
X-Gm-Message-State: AJIora8DaVXzxYrChcGS5lPKL/on2QhN3MFD/K5LEk0lsDXkHNwHtKqN
        Bvg3M2HUGDU9tAxIW3NxcxxebdP32l03BoJXcD75GQO6HVttJXk6dd/NIJChoFC4zmm9XQ0caZu
        qa6Xi2PxO3wlkbO2Rulsf
X-Received: by 2002:a05:620a:4402:b0:6af:1b92:f064 with SMTP id v2-20020a05620a440200b006af1b92f064mr3671145qkp.410.1657309026801;
        Fri, 08 Jul 2022 12:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vm0R0WcqiPbdS2g7+1beiF05cDJd+5zcwDWnJmUMZWlh25pEEb0YUh5CgUKtnc5FKaEq7Hxg==
X-Received: by 2002:a05:620a:4402:b0:6af:1b92:f064 with SMTP id v2-20020a05620a440200b006af1b92f064mr3671133qkp.410.1657309026590;
        Fri, 08 Jul 2022 12:37:06 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n20-20020a05620a223400b006a6b564e9b8sm32843176qkh.4.2022.07.08.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:37:06 -0700 (PDT)
Message-ID: <22b89cf06b59cf6d39da2e7c7bf86c6872e5edd1.camel@redhat.com>
Subject: Re: [PATCH v3 16/32] NFSD: Fix the filecache LRU shrinker
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     david@fromorbit.com, tgraf@suug.ch
Date:   Fri, 08 Jul 2022 15:37:05 -0400
In-Reply-To: <165730472428.28142.17571886266553271473.stgit@klimt.1015granger.net>
References: <165730437087.28142.6731645688073512500.stgit@klimt.1015granger.net>
         <165730472428.28142.17571886266553271473.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-08 at 14:25 -0400, Chuck Lever wrote:
> Without LRU item rotation, the shrinker visits only a few items on
> the end of the LRU list, and those would always be long-term OPEN
> files for NFSv4 workloads. That makes the filecache shrinker
> completely ineffective.
>=20
> Adopt the same strategy as the inode LRU by using LRU_ROTATE.
>=20
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 6e9e186334ab..bd6ba63f69ae 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -452,6 +452,7 @@ nfsd_file_dispose_list_delayed(struct list_head *disp=
ose)
>   *
>   * Return values:
>   *   %LRU_REMOVED: @item was removed from the LRU
> + *   %LRU_ROTATED: @item is to be moved to the LRU tail

%LRU_ROTATE

>   *   %LRU_SKIP: @item cannot be evicted
>   */
>  static enum lru_status
> @@ -490,7 +491,7 @@ nfsd_file_lru_cb(struct list_head *item, struct list_=
lru_one *lru,
> =20
>  	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>  		trace_nfsd_file_gc_referenced(nf);
> -		return LRU_SKIP;
> +		return LRU_ROTATE;
>  	}
> =20
>  	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> @@ -532,7 +533,7 @@ nfsd_file_gc(void)
>  	unsigned long ret;
> =20
>  	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> -			    &dispose, LONG_MAX);
> +			    &dispose, list_lru_count(&nfsd_file_lru));
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>  	nfsd_file_gc_dispose_list(&dispose);
>  }
>=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

