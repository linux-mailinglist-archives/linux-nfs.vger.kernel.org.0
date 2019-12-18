Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F411257F8
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 00:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLRXrr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 18:47:47 -0500
Received: from mail-eopbgr690101.outbound.protection.outlook.com ([40.107.69.101]:28336
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLRXrr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 18:47:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc/MnI4nHpzasMCZrrot1W7JFPwCld9bt5vxprc08LSke7cffx8jTFDcdQzVOUSkM/DsupPDszo5oTubEC3bmZYf9m+u1RUqmb1vDSm7mPROQzL9rFeu5ABkF4sbbj5A4rDrKcAPM6OgRbbeqXl4yEIYIQ4qOPXiIwzqP5F/m9gD8hJlsV6kNaVXrEsvMKeglHKy1rGqV49cBJzrFXT6RgU4GnwJNRoxcadBQC8uGr9pB9DWV1ZEEHf+CBhqzDPuJWAhD+MwQk9ps5HELUtPKHYtHv/FwLuMr8bPgGxCHtAbkmI3KrCIB5+OxBtmcwBU5h5iaI5JZE0ukC6X2Mf1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZSrhAAqSvUrpCm2UYg5BrDQpiKvPvbUskucZweALOk=;
 b=ADWVuhghEv9jLAzCkmlNEvw643vZlEG/tkzQn3bQweJL+7J457JKyfMa6UYEXoyTe3N/jKx4huSyI8pY0MDN09GwlhT47vYrmb+JjiMpJHsxu4AutXucFRy8gxdDxua2oU0wjOBIwuhJHHZdhROVSu013nTPHpLBAzYH2Z3Zv7LaLrrISn3i4Zyx+WKNfomDWOlcEfwq+/+feQl41pwnSrNADnC2LRtIVJDpYehUky75wb8qHjr4mERajO6QTekAnuLIumDMQ1XX1Aq/cOiUzqqq3fKB8eKBPmn/UbxDWnYLXwkrdqXWZGadbWBPMpq99Nfxmg8U+Ard4iyMPAYYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZSrhAAqSvUrpCm2UYg5BrDQpiKvPvbUskucZweALOk=;
 b=Dc5tQ/lqHZOaZ8Kqp3n7u3fx0fv2tFCTmC8aB+uCn15GXgCxL6Vd+4A5b6k3hcPx8vBwoivtLL1jBoil1hqXopACRMdtY5JvGR3cM66w2HXv5BF5lXX1YbUFIp3MUizyWAh9MhBNlcq+Wkd4hHRz23WbGwGbdh6BXD9iS1OZkxg=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1929.namprd13.prod.outlook.com (10.174.184.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.11; Wed, 18 Dec 2019 23:47:43 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 23:47:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Topic: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support
 NFS4_OPEN_CLAIM_DELEG_CUR_FH
Thread-Index: AQHVtfUj0Db4D3dPKk6JV7ObGp2xVqfAjyIA
Date:   Wed, 18 Dec 2019 23:47:43 +0000
Message-ID: <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name>
In-Reply-To: <87y2v9fdz8.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93f99644-cfce-4512-1415-08d78414ad21
x-ms-traffictypediagnostic: DM5PR1301MB1929:
x-microsoft-antispam-prvs: <DM5PR1301MB1929876625386C4A5F066DD0B8530@DM5PR1301MB1929.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(346002)(376002)(396003)(366004)(199004)(189003)(8936002)(91956017)(2616005)(2906002)(8676002)(66616009)(66446008)(86362001)(66556008)(76116006)(81156014)(81166006)(66946007)(66476007)(64756008)(316002)(4001150100001)(6486002)(186003)(110136005)(36756003)(6506007)(71200400001)(6512007)(4326008)(508600001)(5660300002)(26005)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1929;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbezmgLr5VgUv7b/OfKAtiA+QtGJqc2pESbC/IAJlqjbP4uOsb/tS1ptRgnhh0CFE6Zk5Va25bHkCONXaf970q02X5jbyGl+AXobIXXXr1PLIb7t2C1b4LhWChjtpse1mI1vmgUK8csg+wvgKkGlwvysIUg2XHGlDc81UaOkaaxqewFrlkA0/5q8BBFVL2Av6m0iuv4RVl7XabaeICR8mvo1Gm0Ke7eFDwMLzbEDM8nczPNFbSsxGubsYoh5dEwUXoY1QkKQ4HTQXu7pDwMY9D+GeE5mrXwASC3r71JAawbYlAsu6MoPMNjo063ycmSDqCcja87y4Q8pArXaElgpFBSUaQcr0rWlBOuTqoBdtN5KvLcU7f1zDcEHK7oCo3BZoWS4ELYak9lDpegMlcBugMoPLllHdWIeP1qWQDmmxoA2N6ZAG6NP7RpjzB0Fdj8F
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FyTE+QCSNs79Sxx6UWsa"
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f99644-cfce-4512-1415-08d78414ad21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 23:47:43.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 174x3vtZqThXKZ+U0joBKTukrf+IHchfrEziDY15t6sZvwHMKq4vsk25E6iTb8qp4FhSqfRlofGgQCFzSgPatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1929
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-FyTE+QCSNs79Sxx6UWsa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-19 at 09:47 +1100, NeilBrown wrote:
> If an NFSv4.1 server doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
> (e.g. Linux 3.0), and a newer NFS client tries to use it to claim
> an open before returning a delegation, the server might return
> NFS4ERR_BADXDR.
> That is what Linux 3.0 does, though the RFC doesn't seem to be
> explicit
> on which flags must be supported, and what error can be returned for
> unsupported flags.

NFS4ERR_BADXDR is defined in RFC5661, section 15.1.1.1 as meaning

"The arguments for this operation do not match those specified in the
XDR definition."

That's clearly not the case here, so I'd chalk this down to a fairly
blatant server bug, at which point it makes no sense to fix it in the
client.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



--=-FyTE+QCSNs79Sxx6UWsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEESQctxSBg8JpV8KqEZwvnipYKAPIFAl36upgACgkQZwvnipYK
APKt0A/5AaVLeXvi7ltKDZ+sKHsXZv2fno0Fk5DBf9FDLmIMdx9xnmRj3YX0E5Qa
Fy2uC6MNf0YwzxMVnAV/Dpyy4Nxl8yIgKh9upPsyf6ZufAP+aN3GAvdcogqzdFRY
X4odqR8EGIJ3Cw1EA2UaFNELjbJLM4x1ONDGxSw4lkmw/rVBX3giDwxjkHL7O2dr
v5AItIje2nb1ob65FU55daY8Eqhqmxhj4T8acGKKWHGZbseeTfAIpLTyw/pkIque
VAmdYTT7NZX70npQmgjc3fjMrpxlvsXZFZpKULPs3m5JOyl+KpAE6daB+SmUShY5
mGlEArAsPDP9EBIchMnTDNSSZSvmCqYpyOjzkQL/zf6+MqumJO6Wb6oWu8yKGN3x
5S+jCV2epls17gQCT3GYou6VoIWOm1MndCJlnHCaIDBQ8G8D3ajojk09qiOl6cIy
ny3/8ZhbdhTf7n0J0dVncqWxCoyWgs26MSa/xca0YCw5joORNwG74pHkR753jtsH
takwAYQ784Q4RFLZfw4H1YXXg6NElsOnoL1vY1b0EKkqh/MI0bNgg31awS4g5l3s
Sfw7UPj5z0jJdCwW3RVQ2tZ2AtzYKAx72OOHkbEALHjNAC/MKz1H1LJ1JCuCWTJq
sLgsmKD6wkCjGOB30NAnA/Hc83OtEK/vsResbdKukgINUzaRVwk=
=7YZU
-----END PGP SIGNATURE-----

--=-FyTE+QCSNs79Sxx6UWsa--
