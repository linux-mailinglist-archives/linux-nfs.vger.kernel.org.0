Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475F7B7CEA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbjJDKPg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbjJDKPf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 06:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760683
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696414484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCGNMhLhtxoCMrWMD8suopdcDwmtDizUXoNxQu9mGP8=;
        b=R2sRz7Es8hFODkOlo9Tn1qg7GZ4oLNjYv5XysUuOFki1kJk+WwWZ5Hux1o/5pnxRzSTarh
        NIPuwKEnmt1+NcVQUK54KUh1KNNGDWnAKXDVvMo/AWYH+/swHw88clG2Odequ5FynWMO6B
        aF3kx1lQmhb2UqG22z1sDKJKQ6owjRU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-4hzkDitBOqOcSDiJE_5lPw-1; Wed, 04 Oct 2023 06:14:37 -0400
X-MC-Unique: 4hzkDitBOqOcSDiJE_5lPw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-321f75cf2bdso1377456f8f.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 03:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696414476; x=1697019276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCGNMhLhtxoCMrWMD8suopdcDwmtDizUXoNxQu9mGP8=;
        b=YdBrI1lE7QEqng4gpJxuUxZrsTY7oOrxCfi0sz2fkyf/r8sQkga75Ej0S9BSX9MXVe
         +8TXOBVeExYItQI0fop86NMMFgqCUOUgfa6GB/tje2M9gkPqdNd/O9Sa4p4rKHdprU5J
         afC7ll3BrWADPDCYa/RFawoKiPZ/AieerDllSX0IGN88+DBNVYcX3Tyufd8IZjHb0jYS
         AlbElZRpLxPs66ngMeKzVe9i5ZGMWfDeJ3DRDmrUuo0HPBbwg6VJQgx7362QZhQfTmLn
         ooHtvsbXF1EnoKubvzfjYlY8mePPdZdeRv3TZmUeuUnDVvgjNMWy9pBR4kJIkn3x3t+K
         kv7w==
X-Gm-Message-State: AOJu0YzEdBiC0AXgpOxayzV0pH85DgKmj5jlds6ob/IBHa7Vc3G14qt4
        9kbWtKS0r1jex5NkxsKsw3xrrMVPb4QlPTNichwpKk2tQTam+11oSuA6JbBGWBB7RbKhPgiCl08
        QwRSIzPeTniVdVDcjON1B
X-Received: by 2002:adf:fdc7:0:b0:320:c9c8:5f14 with SMTP id i7-20020adffdc7000000b00320c9c85f14mr1766425wrs.29.1696414476552;
        Wed, 04 Oct 2023 03:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgqCfzcp7lgnQ4mRrXU8GGUEl4a/20nuQHjlAGldYtxr1PFow9zvPoCUS2lnd2/W1QIwX6hw==
X-Received: by 2002:adf:fdc7:0:b0:320:c9c8:5f14 with SMTP id i7-20020adffdc7000000b00320c9c85f14mr1766407wrs.29.1696414476209;
        Wed, 04 Oct 2023 03:14:36 -0700 (PDT)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5307000000b003217c096c1esm3637595wrv.73.2023.10.04.03.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:14:35 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:14:33 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZR07CYtL8GwMQQPV@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20231003110358.4a08b826@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bviZ5Xg+0CkFD4tl"
Content-Disposition: inline
In-Reply-To: <20231003110358.4a08b826@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--bviZ5Xg+0CkFD4tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
> > +			  &nfsd_server_nl_family, NLM_F_MULTI,
> > +			  NFSD_CMD_RPC_STATUS_GET);
> > +	if (!hdr)
> > +		return -ENOBUFS;
>=20
> Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
> multiple messages". 99% of the time the right thing to do is change=20
> what we consider to be "an object" rather than do F_MULTI. In theory
> user space should re-constitute all the NLM_F_MULTI messages into as
> single object, which none of YNL does today :(
>=20
ack, fine. I think we can get rid of it.
@chuck: do you want me to send a patch or are you taking care of it?

Regards,
Lorenzo

--bviZ5Xg+0CkFD4tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR07CQAKCRA6cBh0uS2t
rMbyAQDdl3098e/PoDusNCKv71zSKsaMiEZt/jv+k9NY/c6YhQEAnu8agwVUV6CY
OTlChJGKZzOxcbzaEX/D4YdQ6v/Gqgc=
=kW31
-----END PGP SIGNATURE-----

--bviZ5Xg+0CkFD4tl--

