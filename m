Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D586447897
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 03:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhKHCa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Nov 2021 21:30:27 -0500
Received: from mail-eopbgr660056.outbound.protection.outlook.com ([40.107.66.56]:14256
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhKHCa1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Nov 2021 21:30:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI/Ml84ZbBB2qQdhBpoNEEmJZplhVKxiaKMvr3HZrB1nyXCBl3b5rfwbyaLopD8ub4oRetk83AnI3ztKTVo7Fqljr/OC1g4BA/WRCW7VzyXwOX9JUucV0GOQIQKVp9iNsnMK/pHmSmfNCCka8DxmMtnDSNau2UpbMY0AiCS53UiDmdkjmfMZY4OugG4+3aFrZrJzbk2DaUmgNj2nz2y0lDHuU89Gi2W3unHPRzOXE/vmhNpZTk0M09CjOaKrSNfnEPyYvSSA4iuWNFGw09nnHGXW4nXvh5rx2wEY+z4YLAXNrSjxwnnfS1QHYpFVR5Ac6pWQafhx659PjKAw9CcrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNTvEH2arHpg5W3WTamR4yMRnEB+OYkzeKZFI8ug4R8=;
 b=da2z2I7Lg2DpnP1+FKIvtCpg/m6vYZu6fgrxRSw0LGQKQLfaJO5aAvz5yB3ZZJ0BuuiARGTZ+ZK1f4qhWxyCdlwsNw2on59/HKJW6wHmL7xthg+fSpGxyIvTr7V4KldmhyKorRSzsN2zf/v3wKP1iP6fUebWquni2wnj26uB1MsaP4ftgEYXqjtdTz38ESbEPj2kSHLySf5dctJb9H26ocF/48Sh7KZtaHMxKEbiBTUKVbnLwMvzCAtCZhsdNCTdw51GTaiKIP287XzJIci9xBT68bp2h0vx13JP3ybMNRAVVKqG8Xh/gdgxueRpF17WRiNuMrZCAV68XTc9ajEyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNTvEH2arHpg5W3WTamR4yMRnEB+OYkzeKZFI8ug4R8=;
 b=M9HS8LSdtfL+25jHj7mUem7HsWin5ikvAHMUTBKRlHQhZSUfC/ajR/8nhUQ79fpPEaJuK9m6X/10XIcu1P3QG9A9k4UgEMUScJmluQ2OhwEiV8RGTiu9yQTnujt9nJi4ZedE3OTY5FD2op2Fux7VlvXwtXcCF21wqIWUf015R8XezqkpALo7Gy7/zMIpeRfimqVo0BauYy6iSWLdWLKBTDNWrKR2nvFqsdxq+iQcv7RWNmW5O9/ui/h5vGHQxCrrRVFw9SqMrNOo3GGTkl317e7EDn4tp70IDV/w1z1j6V1vSYslL3l4+Wk7SEVr3EcgeU9LgRshFl2XWi1RoBzSOw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB6638.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 02:27:42 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 02:27:41 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7Kv3MpsAgAG1Hlw=
Date:   Mon, 8 Nov 2021 02:27:41 +0000
Message-ID: <YQXPR0101MB096808F771834883F48894DEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
In-Reply-To: <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: dc8b49ec-3a54-a34f-968b-9b05d59b1122
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b644ae3-8f1c-4d43-92f9-08d9a25f5751
x-ms-traffictypediagnostic: YQXPR01MB6638:
x-microsoft-antispam-prvs: <YQXPR01MB66387787DE8BE5A231930219DD919@YQXPR01MB6638.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDE80C57Gjsj4SDWMRBiEQ06faxGh5cGwwnmgeWq1bxazmIeXo1+czKMTFMJ8Cl4FiwuD3XoA3h4Db0H3vUhtK1kdlsoT6FVc/FSe0t+EDN9Dsip8wPO6ngdxx0yXh70J08CpEkJA3MVZ8yh/ICnbu0EFvD7L/8Wn31YMpNdNEbhP2hfyGkyd53rx1PIQqzGzKe/pB2CUigDlVbmZnE2nqv4kQMh3jO0NzdsK83302pZHrEabJYZsXgmXr1Z0+YKSVsivHpx5evNNdETK9CRLBI5h0UY5YfVwOjULcSsP1TGtJSt7jYAcyq8zcSvx2hVsxniKo72F55bRvCTY7QoETCwqiXUCE5zYuZRQp+hsSsqQQmjMa4U3EJfezk+KIRwUyxbdBkZ5K1NQTqOxML5Z+sT6Euj17cEPGdiElKjyE7KZbW2wKvdYXhOp/8UOP8JT9yefwI/Qk8IPl+ENXHacBAWZ5uRYesRPI5FE7hxC397tZPWjBDohBMufDeJGjUURPwEvneG66nZ5xhbwdh36xS8fycsbWiI4BuIRkvWuOFrTBhHsU1Ria3NeGZM0euj31yu9J//24kev0039ZuUb4HXjozmFl4fqeDvVeiKDRortKUrTmWmHIZN/vkRoVhCboUbM9cbK2vdwLcBRC3kEJp0hxgrUZvNjfOcswk7+OeVcKh2GwvpM0lfaFBLJJmw256pgLEO6JvlBrdjhRaS2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(38070700005)(8936002)(33656002)(122000001)(38100700002)(66946007)(2906002)(316002)(66556008)(6506007)(8676002)(110136005)(66446008)(64756008)(66476007)(786003)(91956017)(186003)(5660300002)(52536014)(76116006)(86362001)(55016002)(508600001)(7696005)(71200400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4qo7UmRG2LLJ+3zu4Nej6sSafTpvhUJze0uonsAAtg+sYGdLH36/ArdlaK?=
 =?iso-8859-1?Q?TTW7v2w2XKmmOMG1S0PeH1/7gS9s0tqrXcgvX0abfYxwY3hyArFiArXCOy?=
 =?iso-8859-1?Q?Wej829J6ZCs9jjoPn2rGBmIUytI4EOwxgvtuoSTZOOzwijS27j0CvYfo9Q?=
 =?iso-8859-1?Q?DxkhqNMxxiH+N1Jdk1Z2TjLjcosyTaXUOZ+0pNoEpawttKRZe3wO92jEJI?=
 =?iso-8859-1?Q?hHUTiwNW6cU3iLZaSJ1REJifap2DNxnIHhXKVC/triSnvJgvzOatXSwN0W?=
 =?iso-8859-1?Q?dkkwN7acNIoL3rbYkLDWK093zvtT2T4iroCUDQR59pNNDtu+wOqEOWBtGt?=
 =?iso-8859-1?Q?MAPEOhw3H8tSicKvKgupOtRuTbjlaZ6+N8XJyVD6+BsTadArYmPyoEPHQF?=
 =?iso-8859-1?Q?VYRrrWDCPEeN6geImz483Uchz8LhRUn0Ptbfob1GwHVslwoXUes6vxP1R5?=
 =?iso-8859-1?Q?YZ8eE1/tRa77FIEwrgoUrrVfFu3YE781YMTer8SJeDLaU7eDi9hJQTPF8E?=
 =?iso-8859-1?Q?2U4HetGwlTHqpNwfW0791gwrexfiaq7IiMIxiO7kBLEY77HBbiDXEo60Lb?=
 =?iso-8859-1?Q?WSaRKQkzXVbuNbX99WVP1pZ8+Ha0mQ+HOyR8hV3ou5dGrzYD30RUyPFXIG?=
 =?iso-8859-1?Q?YFDorWvyytgxH2Ta/VWVg7LXLatBDMlm+fTkcqRYYfT+457bLjBFwvM7ix?=
 =?iso-8859-1?Q?jjA6X/1KdkKSSG0Pb7QRXFBIe8Rknz8aVBEsE5zjzrCmdaoPZfxUv/zFrR?=
 =?iso-8859-1?Q?jlrzc7tF6UigwXZplucfxCBtKV7jo3o701HKJaUPvFmv5XkkzrBu7Cobtx?=
 =?iso-8859-1?Q?8fYD83jSQbMTgbWwJSIvI0F+Uz+sNXuhjNBl7MObUPart8ESLV8+n4lwMS?=
 =?iso-8859-1?Q?parto1GTIMdUVmOUc2kzqFUXdbSw+9D1Wjbhb2NHeNS1+4PH5zeCuFlGDn?=
 =?iso-8859-1?Q?cUk/Xyoy9LWbD29upiwtGxBKBoxweLdGqWBuygO6sUQhWhgESmImMY8cJW?=
 =?iso-8859-1?Q?XdQuKJhJcuAtUdqxU26elHsLFB5Gm1M37rCYIeMr5LCQXlDFhGjvOCfBX0?=
 =?iso-8859-1?Q?pC+YBJ3DErwRM++iO+/NthTIeBj70voFe5Ae0fjPfKkHbsn0owEAQq8Dep?=
 =?iso-8859-1?Q?3Dxex5EzVieGl9iEV97+x+NcWv9sNO3fM1UcTMK9CFMm6S280Cetum7PMT?=
 =?iso-8859-1?Q?qd743dxzgEez+w4aJrq3ep6DHPwO9DsqnmCEdBoByiVM/LYgSh5h+CAqzp?=
 =?iso-8859-1?Q?tbvBhkDR2pdPzttuZJZOSoGxhrMWZaejD4Bjsvd1VUvENzKKyusjGAZGh1?=
 =?iso-8859-1?Q?h2rYRS0r/zCxqRnLSaDj+xw5PP2f0Y6iUmFN/6uSSswo/KaXfqjAvZcq88?=
 =?iso-8859-1?Q?iWme25ksTux1yX5PPSzSvIyhy5Y68TcqaIE9ykXV3opgKlK/f/XSXQYg6O?=
 =?iso-8859-1?Q?O5a/sW++aJ+9yyKm10+wZG5Jxc8IYSkbTO4uf4uxQlMFpdS5X9Pr8Qkymz?=
 =?iso-8859-1?Q?dKXik6ZQJFGDNmgyMORhT/dg6L7NY0PbnR2NMBR9ZetPigTSZ/ViLgbmXI?=
 =?iso-8859-1?Q?3Xg7ZVTO35ws1lhEkpupm30ZgB08tjCCrGRj/BHf29Sof8xHKVj0qwBgln?=
 =?iso-8859-1?Q?WZi5Q/KgJjo+TBOcpkdS574cbKgxw6sSszJQltOx9G7PtDbRVdMs/rO8ZC?=
 =?iso-8859-1?Q?0rTBMgxXdb26gbeeYjo9wcJs/pRCsCylMiVEZXmdrPLolp4S7AejevjwQO?=
 =?iso-8859-1?Q?T6vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b644ae3-8f1c-4d43-92f9-08d9a25f5751
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 02:27:41.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSbDfhcjEhFbJx7tY3ptdOOQvOHSQpG25S79PLOJzJB7Egjh8kO45izluPlCvhH0JuHA7Gf/vqpN5akPOUulVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6638
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust wrote:=0A=
> On Sun, 2021-11-07 at 00:03 +0000, Rick Macklem wrote:=0A=
> > Hi,=0A=
> >=0A=
> > I ran a simple test using a Linux 5.12 client NFSv4.2 mount=0A=
> > against a FreeBSD pNFS server, where the DS is out of space=0A=
> > (intentionally, by creating a large file on it).=0A=
> >=0A=
> > I tried to write a file on the Linux NFS client mount and the=0A=
> > mount point gets "stuck" (will not <ctrl>C nor "umount -f").=0A=
> > --> The client is attempting writes against the DS repeatedly,=0A=
> >        with the DS replying NFS4ERR_NOSPC. (Same byte offsets,=0A=
> >        over and over and over again.)=0A=
> > --> The client is repeatedly sending RPCs with LayoutError in=0A=
> >        them to the MDS, reporting the NFS4ERR_NOSPC.=0A=
> >=0A=
> > I'll leave it up to others, but failing the program trying to=0A=
> > write the file with ENOSPC would seem preferable to the=0A=
> > "stuck" mount?=0A=
> > --> Removing the large file from the DS so that the Writes=0A=
> >       can succeed does cause the client to recover.=0A=
> >=0A=
> =0A=
> The client expectation is that the MDS will either remedy the=0A=
> situation, or it will return an appropriate application-level error to=0A=
> the LAYOUTGET.=0A=
Thanks Trond, that worked fine for NFSv4.2. I tweaked the pNFS server=0A=
to reply NFS4ERR_NOSPC to LayoutGet and that worked fine.=0A=
(This is triggered by the LayoutError.)=0A=
=0A=
For NFSv4.1, things don't work as well, since there is no LayoutError=0A=
operation. The LayoutReturn has the NFS4ERR_NOSPC error in it,=0A=
but that doesn't happen until it finishes (which doesn't happen until=0A=
I free up space on the DS).=0A=
But I can live with only 4.2 working well. I can't be bothered endlessly=0A=
probing the DSs to see if they are out of space.=0A=
=0A=
rick=0A=
=0A=
=0A=
What we do not expect is for the client to have to handle DS level=0A=
errors.=0A=
=0A=
--=0A=
Trond Myklebust=0A=
Linux NFS client maintainer, Hammerspace=0A=
trond.myklebust@hammerspace.com=0A=
=0A=
=0A=
