Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB534108EF
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Sep 2021 01:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbhIRXsn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Sep 2021 19:48:43 -0400
Received: from mail-eopbgr660084.outbound.protection.outlook.com ([40.107.66.84]:32640
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240331AbhIRXsm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 18 Sep 2021 19:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOPkaA3k0qFxaf+ambgTu52dTqJ5if87E4gX4nzV+aCJB/FPgQaX3+lzPIS/agxRhwjw+L8HgxDsxwy67KRn5iPvmemHEzcDSKvmEsZVwXU8lrtGEXsCNLFq8v5b7hzlb6jdan5/1wJV7iDb4wrGCsm8ISMITpe+CeTdphOpAAdObsymtRhj8P/t2DrhvNSsDg5ImYvQ+VdM+LS2D6qLIZfiJOEI8kEnaVn+G5qzGXPg/iKG1GYTqRT6gQwmlTJ32G/dx85bcLDc2gEk2T/X2RHUMyQO+fagINv1KcY0euToUogud34tdj2W6VBoYXJyomniV/sd9K/FPL5d0KdOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+7lcgXf6plzEqa0jqB2K3hsb+ljkDga/JcDzWusAs7c=;
 b=EZG4glkB3SY0UuaM6SUDHN0lQsRKb1VvfYClL1iOXzy0ewDzSmnhX6d56I4HKBHu6GnkvEscdX8P0hLcG1CDcskGUSTdMba/3c3pAa9PQiLjTnf3CPB9gSaTOiGxZwnLnFtQY68fb27bCJo7lpQd3EOfGrs6sxTLfbb5Y1hE2h9tSNuI4UHhVASSKHer7OqGAR+UZghb1bgt+QZyqg5IgTqvlwWdE8OC639FmDx5GbhN4ELnZGV/9KYJL0/p5SGP8cxc3sl9pE7GngTlASNhonU/BUAY9wrbiE5bYA/x8ftclA/0c30LlLriWQ58KI58TBjh4HH79gMMH0p0/UtfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7lcgXf6plzEqa0jqB2K3hsb+ljkDga/JcDzWusAs7c=;
 b=QiLnhEIGzXVD73qt9mPnpHouBGzoQivwZdpe/ARYqCPEe0Ool+H1hHPMPpndDM8KAAS5SgiEPwWgbuuEKA7JTypH3oVnhXA/Ie2/nmyyqHKsyKC5BInpfnP3b1GzRbb55AJSQEmxxWzOkQVmi+f8npvsz07Hb6jK9BTBUGzMMaK+g6W7LbkjYxFKpItFdULVJ79EVYodtSI24VRQ8xRNjcO7JiMik2O7jPglAPtGOfjOHSVqBfkgmFu2zGuNZsc6dVS3/bDmL6rNIyjTqzQMtiMZNQ0nfRzi0NEYzwEWRV5yAvZjPrTBU1Ftm0E03lXG8BiOe6WNpzCN/TkgCP2YEQ==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by QB1PR01MB3761.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sat, 18 Sep
 2021 23:47:16 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::55aa:8e71:343f:dc14]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::55aa:8e71:343f:dc14%7]) with mapi id 15.20.4523.018; Sat, 18 Sep 2021
 23:47:16 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Bill Baker <Bill.Baker@Oracle.com>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "winter-2021-bakeathon@googlegroups.com" 
        <winter-2021-bakeathon@googlegroups.com>
Subject: Re: Announcing Fall 2021 NFS Bake-a-thon
Thread-Topic: Announcing Fall 2021 NFS Bake-a-thon
Thread-Index: AQHXiHd9uy8ScPvzgkuoOyioI2eadKuqvHvh
Date:   Sat, 18 Sep 2021 23:47:16 +0000
Message-ID: <YQXPR0101MB096816D00D69A4ED1A5739C5DDDE9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <7fa9bd9e-61e3-d9ad-413a-65f326048fbb@Oracle.com>
In-Reply-To: <7fa9bd9e-61e3-d9ad-413a-65f326048fbb@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 17018629-6d8a-9cec-0d92-bd6638dda00d
authentication-results: Oracle.com; dkim=none (message not signed)
 header.d=none;Oracle.com; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c90aad1-fd88-437a-98d6-08d97afea5a2
x-ms-traffictypediagnostic: QB1PR01MB3761:
x-microsoft-antispam-prvs: <QB1PR01MB3761C065756D8560FA66A779DDDE9@QB1PR01MB3761.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m16rBxa3P9+9RSv55B868w5GxuqBM9t8rpoomu7SeKW69MBUL8WmblbqcVd/My+KrqpE+2g9v+94NgT0t/YbDGjmpZc1ylECveNJZAblUdc2re8vOuFiXiz6AXfOcvhtDKm07Q9TU+esAc0EciJ2mYB/n82Aw/wAkNNRUgTSRVVj1fL5FBBOCFMTjJyudSh3iHljESiEk32a7q0KgJmmKDSabvE5a/61vjSHsUTYB5sCKwwoBvQ3/EjRR39k9zawJpwymYFiJxfJDA4VEyDWWgM99jxrR3DAmyJ0bxJ4YdRRye46TrIUeBT/QBcY/LmUe5NoGf81ST5j0XIUgzxeJEkXFMUvW6mWu8vyIQ43nYgVRn1l9DgyJVzOT4iFvMCIMmC2hlCRllG8v8ZLjozwIaUCwN+sqz7S81EtueNJxiGE7ShZv65bO8RvEy8JeDYKrTT2HSjd2tzHYqElPMuxuA6SnRU/BKiEUFRmhqQhmeE+Fg5ADd2JH9yecG24yLtTR6ZISmBR4VQNGugDV6FbJ92zpc1qbY2tdAO7YADNCHWgELdTGhAJy5sIIQ4IrF63lX9r1F7g69HA58TJYT2Uw+k63f/zE7obqB3QlLeTHaFivOPIDsAXFh2FeVK3Y4cmdTOBPZz8NomfHeuM2s0pJe90sZrino+M2d+qE79lXzC0dzlV8k1HNt2eExl6w7Vxc31mYS2U/11e284iCo4vtprTvis//xJrmB9ynVws2kZiwzyxbX40GUe73PQdh884jGviZeo1lbCSrwn6xBVfSozN3oqrQBcYnE/MpOe7Htrmhz+tMGO8q0JeO3zqOxUCqnmq6IBiPDcJ8zrrnDEqtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(83380400001)(5660300002)(33656002)(55016002)(508600001)(122000001)(8676002)(38070700005)(110136005)(316002)(2906002)(71200400001)(52536014)(38100700002)(7696005)(186003)(66556008)(8936002)(966005)(6506007)(76116006)(66446008)(66946007)(66476007)(86362001)(45080400002)(64756008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i3QJ25kNxa3fpAtBdjoS2x6O5iRa4bHK5npXPJYPttDTIuRRV/emqd8f1r?=
 =?iso-8859-1?Q?+vsIGoDpNbxNOR5QXjUwbW+kQbDh8xs+LISWef7WAH+5MF54Z9PWPStyYQ?=
 =?iso-8859-1?Q?iDpSwIQLkUkrr4ZQgPPPGFzDtZWwcKEh/KuHle/U2VhVjPdAFe0Xk89Bzb?=
 =?iso-8859-1?Q?PtQ3w7bHaH3nBygSu8QLocH18K/Z/xLndL9CLN2w/g3/6I00hOLk5Wr4gy?=
 =?iso-8859-1?Q?tson9XH3QxHSB5yEDTwySvi/dfr8B5R3M3qK+HQRP9cIz5Nq/kcSbT3GsM?=
 =?iso-8859-1?Q?r0n+fQn1/t67uU1Y9V4ZFqMcxisqxG3NVAQUKvn6hb172H5Q+pPb69YsPa?=
 =?iso-8859-1?Q?ph/IXNXdtpMs2RiVhbZL9XNN91bDotD/uSm676On+U0MGomZ5GJsMfl/UX?=
 =?iso-8859-1?Q?/FODSJDGckz0VDIfvLZiyawxvVvM2c7jHkOlx1vvjAPmnNo6qsgMYdkbZx?=
 =?iso-8859-1?Q?2yg01ZYGB64nhIkWhrHmSB9va8nExl2x0ovchfLgv0cJ02AOaQR9ZdrJd+?=
 =?iso-8859-1?Q?pRbb+gL1shr0VpMmbiOuhepy4dDse0irXSOPcAhDKmxiO+/yCUrz5eTJwy?=
 =?iso-8859-1?Q?29Nf09PwzAYJyx9OnXmwCPZfxYZE5Rj25ui6Lyee7A8HyCtbDFYpBJTVxz?=
 =?iso-8859-1?Q?kC5exN4bqe3/hdSbAVg2OeuTTW24c1Y3ZWaeKh71iLmDhX79+doRAq1J+y?=
 =?iso-8859-1?Q?Z9ASOUzniCfxFCCDSiwpFygENLfD7oieyWevWP7yAXKdVkOG2dgDRrBgjI?=
 =?iso-8859-1?Q?vgSm6Jx1cmjtuoTL8Z1LDRpKHqV2pTl8X9WyqK2cTSxGnZCWs/eILWyFzd?=
 =?iso-8859-1?Q?gF68tmTNRbz36VWoa0rhOPJovG8lpO+Nl3qJbkIooh9z9yY3aAdU7rb4Bd?=
 =?iso-8859-1?Q?SG6rn7XHtXW0d+izbtQr7QkmX8sfU7Wq9O9tgDfk0180woRfnwH17bCe1C?=
 =?iso-8859-1?Q?EZeYJehi8ZbpUXrP0DHB4o6QxmwT8PhOQwsT5ygLKekq+6Kkwd3Fdz/Wwk?=
 =?iso-8859-1?Q?8xNyJtzqQZeuXsfvnafS+qaJTaSfh2YkeOSMRY3PmTSwpZuYg9WWLFbx3O?=
 =?iso-8859-1?Q?UNvH4b40HqFwaSFNWjahk94yO2gx1LhmRdaRkiGJLIuXY9CZu0073U3X+b?=
 =?iso-8859-1?Q?j4NgUV6HwsPg3NN522EFVvVwq241S2GaAbjTGJeoQEkQZ1wMvvoXPFxNkv?=
 =?iso-8859-1?Q?0XeVmz24+DD3zFiGOSs70B+WX4NxuJbK9PFm+UrPM0xjYeBsYRduwvWpaS?=
 =?iso-8859-1?Q?cxjkKP2BxvEwZxGKkqu/EDFivUi82YLcVKmTZ0BspbuQ4DtvYe5z9BamtR?=
 =?iso-8859-1?Q?wlsoXTwHksC4rN00TVpEaI2GKvwSS4dJ9cHY1/LmhQcql42Duer/+7zB0X?=
 =?iso-8859-1?Q?Xk6eiMOu5IZq201Wv+tKycWwCl/NRE4ljZPhhyFQSEWU5QAlXunuUxkPIW?=
 =?iso-8859-1?Q?Eim/kmx1vqlIvh8N?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c90aad1-fd88-437a-98d6-08d97afea5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2021 23:47:16.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCdySwSqywIMvFGHrhKYjkV0f2jXTb6uvRB6lbOR5P/pSI4h8GsdWdUohFJl2jlcCWR1xnHY6YrpnaiYLHN5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3761
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bill Baker wrote:=0A=
>Greetings,=0A=
>=0A=
>I am pleased to announce the Fall 2021 NFS bake-a-thon, October=0A=
>4th-8th.  As before, we will be running this event in virtual=0A=
>space.  There is no formal registration process, but please let=0A=
>me know if you plan to attend.=0A=
>=0A=
>For first time attendees, please note the VPN setup instructions=0A=
>so that you can punch into the BAT network.  You can find information=0A=
>on the website: http://nfsv4bat.org/Events/2021/Oct/BAT/index.html=0A=
The recent post related to advisory vs mandatory locking reminded me=0A=
that it would be really nice to have the non-POSIX clients involved=0A=
in testing.=0A=
=0A=
I am aware of two non-POSIX NFSv4 clients:=0A=
- Microsoft/Windows=0A=
- VMware ESXi=0A=
If anyone knows how to contact the developers for either of the above=0A=
(or any other NFSv4 implementations), please encourage them to join=0A=
in with testing.=0A=
=0A=
rick=0A=
=0A=
If you are interested in giving a presentation (via discord), please=0A=
let me know.=0A=
=0A=
Look forward to seeing you (virtually) at the next BAT.=0A=
=0A=
--=0A=
Bill Baker - Oracle NFS development=0A=
=0A=
--=0A=
You received this message because you are subscribed to the Google Groups "=
winter-2021-bakeathon" group.=0A=
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to winter-2021-bakeathon+unsubscribe@googlegroups.com.=0A=
To view this discussion on the web visit https://groups.google.com/d/msgid/=
winter-2021-bakeathon/7fa9bd9e-61e3-d9ad-413a-65f326048fbb%40Oracle.com.=0A=
For more options, visit https://groups.google.com/d/optout.=0A=
