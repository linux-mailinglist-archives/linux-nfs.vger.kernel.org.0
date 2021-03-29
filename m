Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E147434D9CE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC2V4z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 17:56:55 -0400
Received: from mail-eopbgr660087.outbound.protection.outlook.com ([40.107.66.87]:44448
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230381AbhC2V4X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 17:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWCd9ggwVGiHzigRkYE/cqFV9/Kw0y3eq7ojtRFXwY7we46Fv7Oq9LLmyLew0DiAvxrrS7YiCR3SIJVyBlRZID/DZKIr/6/g8lbgtE3tpw007zUmRpXqdnootteHhGvF2EtAbxW5YdR6k6qGB1VYOcH6ecgOnaKlWcSBwh5+BAQlT+jl3mzHxKrvhMTt2g7fUjfO1lNWQIMaBoiTQpXDwp60zp4GZQMYif9u5RZua1hnKoWWNyRfow7HguTFvQRtKrbn8QvJ6+O+hAz4v7U4yJiVTgzrXbWX8E+GERAtfk2AApc1lgYi4csZ9HBbAcI7NB/ZDfuziwDyvVu0IdvhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu4wpXw2IUvl2ATeLJ+3O2B4lWxSpj0lgLdz32/Lmq4=;
 b=izTh3mWrhOY/qnUbEx6IQFLtF/F6QlI4mY+jAKUJ89G/9ZKMWqfmOy1cRhyQqhDKlJQXXbJB16pYpcvAKQvi6YDPnN4gISZ0ee0YD7bNi7tnvWL8/aOnbe4MP7w4o3XkR4kRdpuG+rHtVzB/PNHMje9J6eSYxpNTAKDxyTD3+qbdvWyo4UQf52xpQsuDnsokeRSCLnQgXMiDfdcyCnjSPcDerUE6gz/3g118QpfzB/Emee1+FO/CdJoeqiXCKFAfoHOKB6ZK0PiUz+gRHU22wQXaTFl2J1jKafK9n44oz4RY6eF3yQ2VgQNZSE1t1jrbO5tmUFDpO3W+MkksTy9HcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu4wpXw2IUvl2ATeLJ+3O2B4lWxSpj0lgLdz32/Lmq4=;
 b=Y/cd1LwvV3dLHUYa+tuwv+ZFc/UiEPdtMMP4faY2p1MawAS6C+72cU145OTovyYBb1/53iadm5vgu3uOY2Aijw39KcJrOO/9iEF5tCrhNia5PEGwtT3P7tjrKbMt219JZQ3aBRgOOTHVyyU4Z3jvAMavNH0ujfPXd38sKjif7ISlnl86MJRZ6GccJFuM0JWoFzEMZrX/DW0MKQT90gGEp2aJDprlDfFeGRkCmDqRU8hJXYvfCuEHxLCEdk/DgyEdwkazHsFpF8GvdOdbNC8GGwXUYfEtI8HQOUN4Ar/a4dxRrE+VGBXF1KTmB3Re84QD6skqJPVZ+93LreXQtFSOEQ==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by QB1PR01MB2450.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:3d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Mon, 29 Mar
 2021 21:56:21 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 21:56:21 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: FreeBSD server is broken when "nconnects" is used on mounts on it
Thread-Topic: FreeBSD server is broken when "nconnects" is used on mounts on
 it
Thread-Index: AQHXJOXpouQrmeqKrUKSwdxGbK+BMg==
Date:   Mon, 29 Mar 2021 21:56:21 +0000
Message-ID: <YQXPR0101MB0968CFCAB22755FC1358D7F5DD7E9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f0a1b0c-bad2-4eff-d55d-08d8f2fd7d7e
x-ms-traffictypediagnostic: QB1PR01MB2450:
x-microsoft-antispam-prvs: <QB1PR01MB245093E00748A0E958BDC0DEDD7E9@QB1PR01MB2450.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01IaQt4VNLUJSR+f1e0CTOf8fGz7ZRlrSMo214egn/c64qx/gIhv2m2nlyUxO8rz6eog5LmSf5ek8RhLqVoUx5/F3J7FBbK2EbT1f95u51Di13RwLFV8Pw6z79O+gwlJ0IU7zbCk+TWlE0FMvkiFfupqNeasn1pTFqcwjcJUwKLMrtbtwO0CpRkcvPrvqrOzXgs4XGSdEsILr+w8xzXyw0OpJW6pdh6jh5yNq0UPBauMTu2cgnD4ROAB7ZlnqzKvFQiZq2GFQEKAjB3Z5hV2Hb49EODeTaRE9ha5lXScfZMjK5MRHYXEl4w1KXrropr/HLeXJfTz1bABUwocPGpn8uSQlPB6tkPB5dQaPVq/yGtxcNMOc+bX6CrPKaVJj+ngNNwF0B/m+6xlgJuXpMyQhqP0VfA9w6ZRGkBXcJbRednZYxLrQDZ4LVVB1w4gjfCMXRC357H8KjIWJHv5DaZ9pRu+K9AXEXZ/y/75cvmzR2XQ4jwhoHUqfN+PcjcyDkZCbyQyEKYlPEmgqakHDLyeMcPAZv3YVw4iKOvrOQOAHMyUlEit5fSUTaAJBy/nHJ1VEfCiHarVoHEd10/rbeJ+cuHqNFRb3gY+QLW3ArFoy3Yv7UZsll/OReZHdqEraa3wKqBr66eMTGhFeme/rIC8NUOPefiUmcetVNS4hhIPw2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(33656002)(9686003)(8936002)(91956017)(5660300002)(38100700001)(86362001)(786003)(316002)(66946007)(76116006)(2906002)(55016002)(4744005)(64756008)(6506007)(71200400001)(6916009)(186003)(66556008)(7696005)(66476007)(66446008)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?umV541c9krWY/mLLgBc57IB6mLhkq0X68PaPT6F6z7d2yjwZqHGAClVWMt?=
 =?iso-8859-1?Q?eq/HPnoJdS+C05YH+Lwo1emCBhgJIHm9dhAw7OGiPLRHN1C/imW8g2TvAn?=
 =?iso-8859-1?Q?OfqnXD/sEJyDdlruxtXyl1tY12PDXbJwepLRkuOoK1rApEGPX4M1wWfgV5?=
 =?iso-8859-1?Q?2RZLVH60vsdAdnvcXCOzHOkVf7NBVZTRCGlx6PZUxrDb1KqaP332HOsaHH?=
 =?iso-8859-1?Q?5ISbmdArgJ2KO0KlvXLfNSecKgF3+np1iYQh2fMy2stoCF3CJg0KUUTCbO?=
 =?iso-8859-1?Q?pwTTPrh8h+COL01Q5+noYpnHB/MVSwmltI6mEVAVMLKw8oWJ7n06cMsook?=
 =?iso-8859-1?Q?PxsCq+LUu9p+hGhRN4y7DbxXHNu3t26+rwN10TCLhQjFEwYC8um3BATocy?=
 =?iso-8859-1?Q?ZrS2l/eTcHLpxcSx975OSTxPQMxwYxRFz/B5PwzE/m/koygu5YL/jO98dY?=
 =?iso-8859-1?Q?LV7vrCzFDuIQ+8mG9SMtTVrbA7W9Y/V9zb2htTxuK6Cu+mqh1Cs+2SZO4x?=
 =?iso-8859-1?Q?LIswNk+Qf/DHbv6B/ZElDcfOaUiXHGm2AgxnkX2kI7NOUD9KDP4j4laFqD?=
 =?iso-8859-1?Q?k+feygAMq2DeNZ0B0e118+7GtmbtWVMcd/81jAlkdc0q48eBnt3NNRhspi?=
 =?iso-8859-1?Q?bOUadHHknAgabuGXty3azuQ250YrP51A822MHDn7/XIGXyPfQW3Z3SjDhh?=
 =?iso-8859-1?Q?1DnjCf3fxUGCMdyrqwYp1qY2d3H+BPlF1ZTIu0mhJWLzVYriFZnNgf4l8n?=
 =?iso-8859-1?Q?SYSQqOLhPiU656NmLhMf8CRK1Jqgh96qcJMEJjmoPsyU9EzwU0ob3Hfjoy?=
 =?iso-8859-1?Q?P0TKAtnpCuxf6On/w/jGdO4N5BP7miAFQ6PPZJt2vNqizkZQmR7+1ShNvm?=
 =?iso-8859-1?Q?f/NyjWxhF96fKLO5Q34UXFpy2wvZohl2SJ+Q+DBwFP9fAAaPHuoAYWdL+V?=
 =?iso-8859-1?Q?f+9DWELI2pAeqvhsgl5zNg9y/kl1nDqb+biwyAEXSIekQJSKwY7GEtRH76?=
 =?iso-8859-1?Q?e1lZORsfRF70RPieVUSIxrG9PpYS52yUBxndXZxR1nPzCn1BnQyvzI+iUY?=
 =?iso-8859-1?Q?YZXnnIO7qtWKYF4O5aED2JsMLhUwR8ci8RYtxPU8kjbTS5cPeom6wqDENF?=
 =?iso-8859-1?Q?4Ei96L+FMZqA3FFvR/B7BZiPq6EYq/9DzMBLiQKtfkWRGOo0NY0nO2pcy5?=
 =?iso-8859-1?Q?cCaM1lYrpraXxv+06o4rWvqk1s2BCOALeiI+0Ku+DCCHTw9HHqFCV5tahw?=
 =?iso-8859-1?Q?UYVLOIlbWzLfPJP2fpB3UZiWiNHZXNZgyNdRIkg7dNc24Xti1fbEJ9dczt?=
 =?iso-8859-1?Q?xP9Hdq+11WHnpU6bTF1CHBPn8mZ1rt6s0sQ8XbPUt1eMkcO3RnJioDu7GM?=
 =?iso-8859-1?Q?W98F++g+m+Wdzp9GUs2ANM01CcEvLutmLGpZWCA0xxthNm65RGSYo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0a1b0c-bad2-4eff-d55d-08d8f2fd7d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 21:56:21.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ItGVS1K1FzD51bOB/Z4Ks2nyzuMBKlvQ7sti/2BFfuCwPXu/P7QA+u7vpVCMN5bhgWp1zll4Lpqjr09OPO0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB2450
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
The FreeBSD NFS server is broken when handling multiple=0A=
connections for NFSv4.1/4.2.=0A=
It incorrectly binds the back channel to a new connection=0A=
when is sees an RPC with Sequence in it (almost all RPCs)=0A=
and might send a callback on the wrong connection.=0A=
=0A=
I have a fix, but it won't be in a release until 12.3/13.1 (months away)=0A=
It can be found in FreeBSD Bugzilla PR#254560.=0A=
=0A=
In the meantime, avoiding use of the "nconnects" option=0A=
on Linux client mounts to FreeBSD servers should avoid=0A=
the problem.=0A=
=0A=
Thanks go to Ben Coddington @redhat for diagnosing=0A=
this and testing the patch.=0A=
=0A=
rick=0A=
