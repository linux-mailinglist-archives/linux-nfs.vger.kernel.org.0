Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47356347ADA
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhCXOfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 10:35:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhCXOfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 10:35:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OEYJvu059086;
        Wed, 24 Mar 2021 14:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rDciaJWvg9FFnDADjuOX7LnTJoXC+TlSXdDDuCIlJkQ=;
 b=OFi+E30a+R7jLcqI/XrVUZswKqeXjcYuubiVq3QRfha5lZTxXnPx081xWNot+2h+mBQE
 /50W4xZNjm0t7rShaKAVyJRbJ19A4Wmk36xGK37gcbs5eyePlsuxxqffIoyG23CAv/FX
 rIahShslJquDoSkkbna/YidOnKc5UBEnRmg2liIuEoox+OflAMj2n0ipaKNEjL8vBq+b
 DAdrUPS29LhcAff3i6iaH/71ifBA5mVDAR+a6r0U9LFqBI8Shym6TSqRj0i1cmKqXI7a
 TJyH/t73U2yjgz5viStVa5rFoq2q2+i2ucoLgDm2frOSz1dajx4p8Ahtx2SY77GWh0+0 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mjwuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 14:34:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OEYsv6095480;
        Wed, 24 Mar 2021 14:34:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 37dtyywcpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 14:34:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEzTriHEmKvKKlqOxQjdTN9dni8ez4xIaH6aG0PyCmbQqa4+WphqdLYrsSp5RSfhjqD1UelVVPJu73UnWohnfbwAULxomKEv0tDehTLhO2qw0PQDuCQ1T8pPkB3LBuw5v7+mj8cYlOlL9zvHrTLBF557QoVC32R0LSdKfa3NoIA2epzmkNhN7+0szk25NFs6Wt34qD6jdMSRnFIhqr+ZzFEtrfRYnMGB/ZytSYH3FSfLevikqgDDNJnExtHv56JbuW4QjcO7tWve7zAobT20H8c3zrD0TkfJ18KRwCKIV6zJ05C9COmm0al5z+Bc60dLicNE92heVAiGlZ2KLtDpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDciaJWvg9FFnDADjuOX7LnTJoXC+TlSXdDDuCIlJkQ=;
 b=bQMR6k/2smULg5Emo6DWrw0FQwA8CZf5ZyUl5XIpYslMHaAkkVCfeuBO9L2tEu/6AbwzYuhT/wETdL49jTOWFMql7r1DhYMJ2+KQavrodD6J0OITLyJtywvOl0t8reZyr05K40n5N0b3qfVh6to4fi6JOF/tJgwFoP97ofKQRLLJf4/B55+PZqkWjywfCbyTmVpBEpOBe1R9V5uhuGpWAjaxGpf70sXm2j7WeIMbmtfFqO3ibDAlJbhigoy5VcBR+x1KkLJB1/QU1SQ3OFHp2eAyJ0Ul6bWMndLC9ky3un6/4mNB7yvCcA/OQW6BxSI5Szd9Fn2Fq8JTHT1Xm7sEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDciaJWvg9FFnDADjuOX7LnTJoXC+TlSXdDDuCIlJkQ=;
 b=MAkwrNVEBZqhnOsVORgXUF4g895AopqcoUf3K6E31+IAdIGnV6UmvuGYgUA9VP1ZgEP3mh9FBcWCU78nA3KpC5ipkWGD8kcFmWFX2wTppIF586CwDDr3X2pNFP8wAdnTVv5FmQPE9LcO78vVm8brkGuH5v/NYqPDfk4Zp8Ap7Ao=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3720.namprd10.prod.outlook.com (2603:10b6:a03:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 14:34:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 14:34:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQAAIhaYAAALhG4AABaUIAAAmMFWAAIKuVgA==
Date:   Wed, 24 Mar 2021 14:34:45 +0000
Message-ID: <A0D817BC-3F15-4A4C-BC9D-AD2238754F96@oracle.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
 <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
 <SG2P153MB0361455966B8436516A355729E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <D13EEDD3-522C-4AA3-9FC8-907A582EC57D@oracle.com>
 <SG2P153MB03616FAC8BFEAF305A10A71C9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB03616FAC8BFEAF305A10A71C9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 735fc0f9-1751-46fd-136c-08d8eed1f880
x-ms-traffictypediagnostic: BYAPR10MB3720:
x-microsoft-antispam-prvs: <BYAPR10MB3720456F50DCC804764460A693639@BYAPR10MB3720.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b8DWNCjIzQYFGQQNeR0ra8RBG67ME3xcBLfdy85DGH0H1UcFIcWf7fvkYpfcdexxM9nMOjMUR3TmW4uelw+GFjudP+NAyhgKTjjqnkLVjSngvqoPFrnG0ZfHgoLT1uiXHZsv5CFUEdF1GTIjvdF7/6hAwmmO5UGLYmpSalnZIRVqWAqtz3MnZ4jIvEj1pmqyFI3Kl29ESSeYwKDlOwQ5Fj1KykPQm757BiVg2gB0XKKJ8fgyygGnecRARdSxk2AFI998FYFfPYahHXXbepc7LFvAuR8ukcFsmWmuP5rbYCh0XDhrWgZqOEMMwFKVpxaISGoklDmiLl1/AyoXUWXT9cSx8uFcsgemIArG1/6Gn4yInJGbPQq3Ef49dVBoR2jmqeVjya2pZZbSulqkIWOtxb0AtX3B9Z9VxI3w8b6qVtPI5VJpK5YEwrzHvalxQdqBIlE8MrnPKf5sUdGyfDYZCOs6ezn/ZFNvI0WL7roGNFPL18kvu60zDqDAwT04B1+DBJ+YrRIL9zvUzUE02VXQekZVKO/fbk1Aw8mP4BxlUavG9KY9tEVo7PyJDO2TbM6/Zph2EauUPL4BRpVe/yhCZkcSYUADooHBC0xN+2ipsHsJJq8HQR6IqY8FtAYFpMk0R9uDQUTnAiadFlLV7llIIMz+n6Ga3GYN7uj1gTLIyPCPklltfTasXmyztCFZ4XQXfK8zRN9tAUEOZIN3/0xSOnscXyddU2igw+Gsj9Ho21Q1DgbzcpXdgoKDU5WqekVNMlK6y59hrPgu6RA6vpIZ9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(91956017)(76116006)(26005)(66946007)(186003)(38100700001)(4326008)(64756008)(71200400001)(966005)(66446008)(8936002)(83380400001)(53546011)(66556008)(6506007)(36756003)(2906002)(6486002)(66476007)(2616005)(316002)(6512007)(8676002)(54906003)(5660300002)(33656002)(478600001)(6916009)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sg7i9vh2TeuNEFFKbAbRjSfc/mQPyErkBeyTUs3jHZFAVokiHKJQDApMpdCa?=
 =?us-ascii?Q?Znv4vVF7Hpd9E1ChQeDg5tMGL/TYSzPdeJOyNimcqTE5kN6eGSU84+e+dzz+?=
 =?us-ascii?Q?yzXTm2lTdTH51a1QmFdKiEpPLcq0QdSOVadmK9UWqJz+Ojm0PySd9RMHLolv?=
 =?us-ascii?Q?+XyNLbIoQQ/RAHN7of3V5brZYY5PQfVShUjB3U6HWVYMCqXh4MO8thIlZgc3?=
 =?us-ascii?Q?INszXqurRyyKhBoRhfqI/sZwRFcIBcYlPZAD+uyQW1v86bvo7utg1G3jC68H?=
 =?us-ascii?Q?5B5nByUXwncSO7K/L76n8Sm7V2A3F27HYmgFbqoDpl01hHNaZWgfWDvOUY+M?=
 =?us-ascii?Q?9s0q+ZRyWzErW9yZ5lf252Z7hzLP5i+s6ClHxTSWGUbMCU938BvdVOTWifjJ?=
 =?us-ascii?Q?WK3yDs6nvhCbapOedMr120dPduTccB7451WLJj6j8+r3BTf7U5WmhB/uaqyb?=
 =?us-ascii?Q?jv370SMPraY0i4RavzWHE7WtMPIAhT1JDR0et2C2LaIc6IJu6KM8uaTmZjDk?=
 =?us-ascii?Q?n8CgYJ2VBk4ztZAW0OxzOZyTwElXtytl3R1hdDXhonZcbvETMC9lYFDTKLIs?=
 =?us-ascii?Q?b1zLfHjeL5y8Sa/GnOA3gTjtLx+z09HyKIfFDkxlbw7RJeL5z0Npq8g7GFg1?=
 =?us-ascii?Q?jE8Zh1wwx8Wyvdnnf4y/vsdTin6ohQks3pYC/VGKRRHYEcgsfaF+9Cw4vIBg?=
 =?us-ascii?Q?GlByn7iCSNWogRqMwfNhZnElmngat+e8y9/0hv5Hrwk6cH9dizIFBMcSvKvc?=
 =?us-ascii?Q?5Vwb2nHR+VJGpzkigkzB6QmPn3zlFQy0HNJDT8hVUf1iZCNF0/S0q+pkLSGs?=
 =?us-ascii?Q?S+Jok/sCJCvdspN6HWjVX81tw4/AFPnG4wRLXmoTz1NVJ0PuX5acHT6XcRkH?=
 =?us-ascii?Q?nkl0ucC4jGXdzgHggNjr3V448b89Dux1z2JZe91i/etGCd8ZjYfo96N59St3?=
 =?us-ascii?Q?RgZ/iyM2D7CHnMHs2inI28Vktbipfg6UQtyqOXO4BSDBXj+svftkInz1rSzX?=
 =?us-ascii?Q?j+36IczKcyWOHTqtILovE2FP0lQU3ojCwWPk4juXVlYJ6BW8x2cZCMpfzgyz?=
 =?us-ascii?Q?dx0Ma0pmin5+NBNYg7f/481CBR6pf2f5JG9zyGO62zovJ7j8FnVsoeXYq9Ab?=
 =?us-ascii?Q?MaO5MFiHewlCZNEcupuQr6a5jTfDRCtndhP2reV9tkz6iAqE7hflbeOmEJPZ?=
 =?us-ascii?Q?qoAyxsNLytQFVbsF+DklyG6EcE5Dl/A60WLuXpJMwYYDU3Er7ZaGLeudqgua?=
 =?us-ascii?Q?Watl4ULBZxILrphfXKr3lTkBhygDlsC5phCI11mtaJeoVbOjXjOUlK+a8Vvu?=
 =?us-ascii?Q?/2Nipv/NMvbVd1XohbGi3MYfXjcoPI1tS8/rwgfreCqW1g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F34AF355FA7C64C83D16E52FF91DE82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735fc0f9-1751-46fd-136c-08d8eed1f880
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 14:34:45.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zxqbdXUYQ8dQL6jqzOKJq2pfJFwvrUsSypPJ/PL9ziue0szBGnioVTcBWKwt5SGYJFWk25S4WfGWMlsECaYpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3720
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240112
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 7:31 PM, Nagendra Tomar <Nagendra.Tomar@microsoft.com=
> wrote:
>>=20
>>> I was hoping that such a client side change could be useful to possibly=
 more
>>> users with similar setups, after all file->connection affinity doesn't =
sound too
>>> arcane and one can think of benefits of one node processing one file. N=
o?
>>=20
>> That's where I'm getting hung up (outside the personal preference
>> that we not introduce yes another mount option). While I understand
>> what's going on now (thanks!) I'm not sure this is a common usage
>> scenario for NFSv3. Other opinions welcome here!
>>=20
>> Nor does it seem like one that we want to encourage over solutions
>> like pNFS. Generally the Linux community has taken the position
>> that server bugs should be addressed on the server, and this seems
>> like a problem that is introduced by your middlebox and server
>> combination.=20
>=20
> I would like to look at it not as a problem created by our server setup,
> but rather as "one more scenario" which the client can much easily and
> generically handle and hence the patch.
>=20
>> The client is working properly and is complying with spec.
>=20
> The nconnect roundrobin distribution is just one way of utilizing multipl=
e
> connections, which happens to be limiting for this specific usecase.=20
> My patch proposes another way of distributing RPCs over the connections,
> which is more suitable for this usecase and maybe others.

Indeed, the nconnect work isn't quite complete, and the client will
need some way to specify how to schedule RPCs over several connections
to the same server. There seems to be two somewhat orthogonal
components to your proposal:

A. The introduction of a mount option to specify an RPC connection
scheduling mechanism

B. The use of a file handle hash to do that scheduling


For A: Again, I'd rather avoid adding more mount options, for reasons
I've described most recently over in the d_type/READDIR thread. There
are other options here. Anna has proposed a sysfs API that exposes
each kernel RPC connection for fine-grained control. See this thread:

https://lore.kernel.org/linux-nfs/20210312211826.360959-1-Anna.Schumaker@Ne=
tapp.com/

Dan Aloni has proposed an additional mechanism that enables user space
to associate an NFS mount point to its underlying RPC connections.

These approaches might be suitable for your purpose, or they might
only be a little inspiration to get creative.


For B: I agree with Tom that leaving this up to client system
administrators is a punt and usually not a scalable or future-looking
solution.

And I maintain you will be better off with a centralized and easily
configurable mechanism for balancing load, not a fixed algorithm that
you have to introduce to your clients via code changes or repeated
distributed changes to mount options.


There are other ways to utilize your LB. Since this is NFSv3, you
might expose your back-end NFSv3 servers by destination port (aka,
a set of NAT rules).

MDS NFSv4 server: clients get to it at the VIP address, port 2049
DS NFSv3 server A: clients get to it at the VIP address, port i
DS NFSv3 server B: clients get to it at the VIP address, port j
DS NFSv3 server C: clients get to it at the VIP address, port k

The LB translates [VIP]:i into [server A]:2049, [VIP]:j into
[server B]:2049, and so on.

I'm not sure if the flexfiles layout carries universal addresses with
port information, though. If it did, that would enable you to expose
all your backend data servers directly to clients via a single VIP,
and yet the LB would still be just a Layer 3 forwarding service and
not application-aware.


--
Chuck Lever



