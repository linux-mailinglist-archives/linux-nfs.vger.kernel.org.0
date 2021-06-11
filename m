Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5462E3A3B52
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 07:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFKF2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Jun 2021 01:28:49 -0400
Received: from mail-dm6nam08on2068.outbound.protection.outlook.com ([40.107.102.68]:15553
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhFKF2s (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Jun 2021 01:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMnRRXgr45UgD0wiBQyHWBsQRRNqlCifUKi8I7htTs8tslMu7IrwxEHX1tRlIPTLfxn5a+/Irmy7q8ZYIIkojpeNDuYUO75FOuwSyi6bsPckyZbHhqL3lsQmLGBD2mRhs2fAghKy14UrXz39l7VOE+lj5+M4eaBi++CvpIIEk/FjWsZO/f98ibzWJwnk8vTrlpVvwxwRRM92RXG3bp6L7COSrclUGT6ZREnjMjsXPVrerDdaNXJXPKhUYazN98RpBVefyoJeUNEcf5sEqfPfzH4wcM8e2k9Xs8fIxPi7r9OihgWH9WzYNaN90b35TNdL7vY2qnxEvqOwt0fwmscpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhgf6KgirJzS7VLw3cC8duWYhUjHUyo2LAqubsdY/c4=;
 b=kiWqmXUb8mvxlui4F2YGoWL4u9IEVX89y3ziQTxpMI+OJHfekEmgolFwx7sT6YOhBoF/IczhxNPUvOFZf2pEu8Po6r/RZ04NbxUgbA0xeBHSnubq8FPNwB+B6TmRwv6rVMFHKZTuwdgnxArMUhhHCmPOK3LTmFrH9b/VNQBr7w++erVCtGrxTgV5X+7EjxEsJTvmFqlmZGU48FJzaDvTVKfzIP0V5RamDXQwL7tVDOBvTnzQRuw023h6Rve2xIMSUxFJm7a3glvpvZe+wDlUPpODkHgvPHNCcLFTqVacJm41M4pxMlESuVsTRRr7Zg0RRS48vj1oWJa1RMQsLmW9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhgf6KgirJzS7VLw3cC8duWYhUjHUyo2LAqubsdY/c4=;
 b=u1IuXRKfsJHhtyghlfa+iBrvulBLZLJt9URjWcZrI9dM+BgHIxfh12pSxmnYR/YklTIYTp+xLEqMH1L38bfl8+LLfWnd6S5hZk7cpZZ/GG8XF5gNAZtRDgeusWPcTZan2L+5VH/FEy0JuHubt+NgdQZ7eAwyKYqdIirrekddM6I=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by CO1PR05MB7879.namprd05.prod.outlook.com (2603:10b6:303:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9; Fri, 11 Jun
 2021 05:26:49 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::9906:9cba:edea:d7b3]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::9906:9cba:edea:d7b3%5]) with mapi id 15.20.4242.012; Fri, 11 Jun 2021
 05:26:49 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Alex Romanenko <alex@vmware.com>,
        Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/4AAkD6AgADZOSOAAJIEAIAAVdBggAI8kas=
Date:   Fri, 11 Jun 2021 05:26:49 +0000
Message-ID: <CO1PR05MB8101D9EAA34FEB50180CF917B7349@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
 <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFZNzyr0FBUeuOc92xiaq+52G1uyfuP3mAZbGxR+v1Rfg@mail.gmail.com>,<CO1PR05MB7925DC61979C2611A3E23721BF369@CO1PR05MB7925.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB7925DC61979C2611A3E23721BF369@CO1PR05MB7925.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3e1807b-edcc-486a-f63f-08d92c998328
x-ms-traffictypediagnostic: CO1PR05MB7879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR05MB78794837F3197FA369A40BCDB7349@CO1PR05MB7879.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZoN6YqrDnJKvRvNv2WAzGejDciueE5h6iLcKz9yjlvEAWHpGUpfnZ1kX250iOfMDBAlBfPczqdj27ok2nym3WK5OTvHuhkRtKBbKmtkxqQj6/puXuIbspd9WWlMMVqWChQ41ptnrm1Bn8xAgpMDtBJ8+N1kCRDO1CGf+HI8RnzAzD9hXDtBWR4yDAJq2b3xU41ccndEC4yH/ufMTyzJfRrf2aJzUsJD2n96L515K5T3NBIyGLvm/3bNq1GQhsOfr/VPtVOAlw/YlRixLA92sMBgj/+XeDM5bRZr8suLnM4frb8YHhtg7rBEQMAp6kHn5KPlkUxWMQgJgOgkeuAstX4WD7wgiXA72k1I6/MHKvFJprFVkL5CpI+fLzdV+RYeXNeICVKbsltXqOYnsi0F0Y3gWLbggklnm70Ox7EFGyzyQEx5SEntFziKWiLmq/fwDy2KHIUH66f2jUAyPvr2isjJQ3IUuM0Tk7Fi962iyOOfVXRiLzYTq8xLZBag+nReTx7NjMMACcXOEeLIRLjRR0w5UzjsdZOeEEYFIjLJthaKE4tQ5OLiLoCbmDuhrLhRo2VhU+F/rzWOweQledY0HAboIBuu365sIkvitrDO7HzHCMC7QSRyNHarcCe3c8nudEdjSJK41pZWucMvhELUrPZ7Vg3wU7XK76lnk6NUm8yxXxZzpbhPNWMid7J/ykOgFCiPLw/okUnfSGGvb58cqFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(110136005)(186003)(83380400001)(54906003)(86362001)(26005)(2906002)(71200400001)(6506007)(316002)(64756008)(66556008)(66446008)(66476007)(8676002)(966005)(5660300002)(52536014)(66946007)(33656002)(4744005)(8936002)(91956017)(122000001)(4326008)(55016002)(478600001)(9686003)(38100700002)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TMWddYkpRMxOtZsCd4uCTkRzSRAVVpGinGWLpUKRtGXOslsn+KtMUVq9yV?=
 =?iso-8859-1?Q?BFfTyFAXc5KPBGaejDD5pPn20E2rCuuI43XygSYzolnTPFcVwveV9pFbVc?=
 =?iso-8859-1?Q?k2dlgTyhjlr9mtnLyS/ctvvxRrBfLMVDicrA1Tm2bAwsrLK1ffZWTd3qt4?=
 =?iso-8859-1?Q?iorOwpuYbNxZpQuGxxcGajoXWLy9IMJVN95WseNaCXUxD9nb0BrU674Xya?=
 =?iso-8859-1?Q?GiG1N6/EKJ+aS+FiM1BEhS3bqCf0lZJjUUH31+lnYWVwHAECwDrsRHSiNP?=
 =?iso-8859-1?Q?7NxDay4VDSKwpZ//5u8qPmWieIBAwcDrppbt/i6R5fOin10UdXnBrGNuLQ?=
 =?iso-8859-1?Q?F/r37XHq5DFiFai1cZw0XQt/RWR6RSq8apvV2iMvyRPYGz6g4RBMxqPzG1?=
 =?iso-8859-1?Q?ADuCnJJ9PtIO3M4kCT/Ks1Cxpbu0ZHDduBRaD0aO84EcB2MbHYbc0tj6ll?=
 =?iso-8859-1?Q?fONZxJ1pBljsWeKhJnCAdzC/8sFDULmR1b7+7zBDhASYBzU7jtjDqCJMfJ?=
 =?iso-8859-1?Q?cZV05UGNnh93YvPR7N4t8/ZQ5RJ2Nn+Ev+4f7dsBH2aBMO1NxQAtg5mUHZ?=
 =?iso-8859-1?Q?brO2FeQxbKu8r37+T4wLGiyASIlc/1IaPYC/izPbqj47wxDmPpixcJJbe0?=
 =?iso-8859-1?Q?eO1V/5PeFMeg8XOwNdhIOiKlMXWNC+6f8tORGZQzn+1nk6MAzCzsR9U9n2?=
 =?iso-8859-1?Q?0j1ZItBcY62rPLU5Z5QZBbF5Oo3Ri2HEHWri4PaebwHGb7xUzKgdseMeVn?=
 =?iso-8859-1?Q?VstmPnmqEPFVTKq+KGjR6wa6cfdaMA63a8wIG3oeQANKD6StxGU5dhHyv3?=
 =?iso-8859-1?Q?eYr7MaLf4Vhg7xqu+FR+iqRrzkDciwCXNaVuWCtPmjuPLlScp2tocQzl3l?=
 =?iso-8859-1?Q?njq65/tXVvuIZ032py4yD+D0e35P6I460vRS/yN7knOV9QMddSSafbhVUa?=
 =?iso-8859-1?Q?v+rHYaKV9s9at+XwFuZsEUOcz8RB2sdVxcOiIA+yHNL6w0YMZSc8VvwjkG?=
 =?iso-8859-1?Q?3DkG0A41db8u6cwSgDeIW7aHOhEn+fw6dIXjMGkHjs0qoXMmUl5dI5WR2Z?=
 =?iso-8859-1?Q?p+XQP6DXVad6M0IqEZ+o9dN4ZQR57sIBo0L/kCFc9+qpiuzqtgMk5U00t0?=
 =?iso-8859-1?Q?hT0P4KJvvbcQCvC+ovTIEBNa8xUBT2UoScx8oyOQnd8W9jR3HbgHNnRGtH?=
 =?iso-8859-1?Q?Wq8IlRDexYGk4PuyKjciLe+Cy6auZKvyP7NnGC5MtRs9W31K2e2dHRPQIc?=
 =?iso-8859-1?Q?5CjQ1tbMht8mkW5LcEapZWCdTqvF/hBdJn0j+4uingnHL2ncA074t1ygtG?=
 =?iso-8859-1?Q?9cWcXbb2ZeDoQIGYS4XYlxquJSwIA2uQe21pNwYTabbDUaI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e1807b-edcc-486a-f63f-08d92c998328
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 05:26:49.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8RLGhh31ybHC8+lXE5Hpy8DfQo2Owe4v1+La/3ZdHNxBKZ5yDFBT65qrITS2NwVPFqo8QWls6b1AKzPYkFoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB7879
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everyone,=0A=
=0A=
I took the patch created by Trond:=0A=
    https://marc.info/?l=3Dlinux-nfs&m=3D162326359818467&w=3D2=0A=
    [Subject: [PATCH] NFSv4: Initialise connection to the server in nfs4_al=
loc_client()]=0A=
Then rebuilt the NFSv4 kernel module and installed it on my Ubuntu virtual =
machine.=0A=
=0A=
The valid NFS mounts are no longer being blocked!=0A=
=0A=
We've had several=A0fairly significant outages for almost a year now=0A=
(when we migrated to NFSv4) due to this issue and this patch will=0A=
eliminate these types of incidents.=0A=
=0A=
We greatly appreciate all the work that was done (especially knowing=0A=
everyone has a busy schedule).=0A=
Thanks so much to everyone that helped!=0A=
=0A=
Mike=
