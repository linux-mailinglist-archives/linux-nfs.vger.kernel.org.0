Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736A17B81BA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbjJDOFU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbjJDOFT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 10:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE50C0
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696428265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7pZEXGbcluSLqzFo6PmnGkojVQIfEFQeyk3xrlLkTJA=;
        b=HfiUomyDtfBsQyzx4Bs6BHccQB/v92NwX67i3LkzWdTiOvKyTNDJTuB15XSL+2Am81FThP
        YYa+GvnpcK0JRB1svSveCb65vjcSGVWmNt+DumUnGmeWqWN+wMIZCKXPn6V1lQqQAxy6+B
        ul4F2Frp2Y8Ao9OxRzfQl6k0rdJV+4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-9FqTLUeQOaKhlPSjRBiAgg-1; Wed, 04 Oct 2023 10:04:08 -0400
X-MC-Unique: 9FqTLUeQOaKhlPSjRBiAgg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-326f05ed8f9so1665777f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 07:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428246; x=1697033046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pZEXGbcluSLqzFo6PmnGkojVQIfEFQeyk3xrlLkTJA=;
        b=MSPtkJte5NYRR3iuizhgFHfoQM77utLjxSKo2k1MQZKmMMhOCW8aTxEiIj0LGYkZp9
         rma8uZlpqu8kP7ag9AOTx1K4FrQJN5IxNN5y+n26t+vNeozcT3jNTyssamAizjIMlNrU
         1DvX/0A/90Uo38lig92KsjKzj/iDpO/0bNuXAgREs0scOgGgb9fYgSsD3DwhaaT3CAvp
         wpipRzMrs+sMT9CKxAuSkuJpD9rYVJe59mAiYvkAsNforXJRYEHy8wcRT7l96rAkpgqm
         OkOZsMeKUSMoSnje4odBIRkt2Wj3CpYX9MCSVbnAjHffYVq3kkVikdxQIYIyAedgJLnP
         nnGw==
X-Gm-Message-State: AOJu0Yy2VkYAMNYtVBQI4SNquJ7gh86qDK+jRmZkPdEtBy7M2I1uDYG1
        XDP1lSIOlSSzEHLBRPsrflH3qjpZilod8zEXCJuUaMKbAWglKl50CnqxaC/Eff9RQWkFG9CbyiB
        8rsKtUalvqV9zin3ibc9z
X-Received: by 2002:a5d:56d0:0:b0:31c:5c77:48ec with SMTP id m16-20020a5d56d0000000b0031c5c7748ecmr2026015wrw.62.1696428246356;
        Wed, 04 Oct 2023 07:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE1M+7GeyXmeaGNZrXpsVT71x2daZCozpe3MsxCvwocq6wYYVq3AVRRrfUhKRME4pyBf6urw==
X-Received: by 2002:a5d:56d0:0:b0:31c:5c77:48ec with SMTP id m16-20020a5d56d0000000b0031c5c7748ecmr2025948wrw.62.1696428244699;
        Wed, 04 Oct 2023 07:04:04 -0700 (PDT)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d424c000000b00327cd5e5ac1sm4154775wrr.1.2023.10.04.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:04:02 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:04:00 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZR1w0GDC6hoKc5pp@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20231003110358.4a08b826@kernel.org>
 <ZR07CYtL8GwMQQPV@lore-desk>
 <6A47BDC7-FB73-4799-BC6A-9C0C020E424D@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UpQxkXKt6aynY9NM"
Content-Disposition: inline
In-Reply-To: <6A47BDC7-FB73-4799-BC6A-9C0C020E424D@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--UpQxkXKt6aynY9NM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > On Oct 4, 2023, at 6:14 AM, Lorenzo Bianconi <lorenzo.bianconi@redhat.c=
om> wrote:
> >=20
> >> On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> >>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> >>> +  &nfsd_server_nl_family, NLM_F_MULTI,
> >>> +  NFSD_CMD_RPC_STATUS_GET);
> >>> + if (!hdr)
> >>> + return -ENOBUFS;
> >>=20
> >> Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
> >> multiple messages". 99% of the time the right thing to do is change=20
> >> what we consider to be "an object" rather than do F_MULTI. In theory
> >> user space should re-constitute all the NLM_F_MULTI messages into as
> >> single object, which none of YNL does today :(
> >>=20
> > ack, fine. I think we can get rid of it.
> > @chuck: do you want me to send a patch or are you taking care of it?
>=20
> Send a (tested) patch and I can squash it into this one.

ack, I will do.

Regards,
Lorenzo

>=20
>=20
> --
> Chuck Lever
>=20
>=20

--UpQxkXKt6aynY9NM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR1w0AAKCRA6cBh0uS2t
rFGuAP9VNlDiCwRTl3OHCTw/BUl4C623JTX9cR0PzWjU4vIMcwD/ZIxSBwzQYjVd
SBjr94Fmtx2Sj0qsPMOdTchEZhLW1Qg=
=kwxV
-----END PGP SIGNATURE-----

--UpQxkXKt6aynY9NM--

