Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECF25BD4A0
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISSPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISSPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 14:15:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590F46201
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 11:15:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JGO499002811;
        Mon, 19 Sep 2022 18:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1T2ewM8FG/daO4Mt8IAP6jg1xhOBhk3EdIGz3cSPu3c=;
 b=sTAUdHMr8ULy8QHfPmRU4DMZKNHZbSlPIm8z6EYRzgdAWkPcNS3gO++e/QruijQbmNZj
 klYBhw9o+JqbTzFNDZ9SZKk/8mMCmyB5JzRhd9ZN8Lf92BAhdQwUXLMkOwDj4ZJ9M/0z
 gxfh2R6Pgh9AAPX4LqGu8z5AlCBLyqGH5Drsw+Nw++uyF7BzbDU9lluWCniS3wH2s4hM
 lWShwqL6SbT0+CpSEgv0UW0R4cyvTOIMsVCKx7oj/bkBneppV+3Div1UfGkPvTai9Xhw
 xBLrcqXVzQ20NWn8LLp0AvQNGQMIc01pNyAAF9B7wgHGMAhoj9YL6a3N8Z6arOAwWA+9 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688cgr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 18:15:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JGbWrL016766;
        Mon, 19 Sep 2022 18:15:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cmc33j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 18:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAM9BsGfXyLCodYZSMjNSHBla4NydwGz+3/kF963qH1ydw1rZNELmky2lWdxKPj9zE/zSpJfUFQvvqZkE9509K4Ay7Dp3gj4iA+BhZ9KjhBm55bg3dGWdoSoPELBOiQFiTiu9jtU7+n1j172OzfeBQVOpF59jUq9Eipcsh44Gpa+pEZXygKyy36TzelB+pygLiXtRTlN9tVEqFyElPPSpuvHaMpX6lRsOCkaWDoYKv6PsLoP1IRsIs5f6chX/+ZrQLeoXZ5aVnSO+uA0rsdo6pA1qB3g6sSyyQS8ioB+MKpPPZ67NpHU5DFrJQhc7UWF+Kj9CtCqPDMXpnCBcYpvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T2ewM8FG/daO4Mt8IAP6jg1xhOBhk3EdIGz3cSPu3c=;
 b=MIbS6AweU2P39yhCO2ZWlErB9VKyaElyNufHN6vQQ7RS0Er+GFFF/Mmk9RRh0Em+bvwpAoRBkgzGMG9GIMcE/+uMLeMpL4p9DmW2gz/Twjki9NUDgmmH94hDlvjTNxARN6u1HTRuqyqIYJUCx2DX2Wvu0guDSCAtpBRpGrko3AYzy/CervgHKhWXA3FMz1VCncJED4jP/mAD5kloRTErT27JpSi2zpi0XPZjMPu1K4ehW3KbM453k04ZUhcX+QNFa8G+JJ3phOUvrlRtD1nVJGT7S11f3O+Isciy79FFop38zg1TuBOpOJKJBNyiCRDQeErgjzVmN2EINTMA/DIaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T2ewM8FG/daO4Mt8IAP6jg1xhOBhk3EdIGz3cSPu3c=;
 b=dAIIjSb9Y2YrRBk8D5UeTQpm7mCbXlxtu341AVg0aFmJ5Z1KZmHT2jPQ01gwNCEm9Hc0Q3JeZkb7HQhr/vwVwZF2YACYui8Xcp79u6zJ2b3LGNwWaS+jxph/NpfTn7AmI+IuW/2tSzsUwDfZTUQFT4wwRrVInUgJmRWWF/PSRi4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 18:15:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 18:15:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Subject: Re: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDztMjvFTe1YQk+Xo2ZaIaryZK3nCq2AgAAEdwA=
Date:   Mon, 19 Sep 2022 18:15:35 +0000
Message-ID: <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
 <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com>
In-Reply-To: <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4308:EE_
x-ms-office365-filtering-correlation-id: 5a215573-90b3-45f2-b17e-08da9a6af29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRrAHiV15eQh9txvdGblMXl1bIsXKaYIyqpSOTeOm46ZUODXZVsnjb8NFPxYaNvV++jLl8eFSECvqECoFNuWE7oe4kDR4gNCMieGu6EArY3bWrbaSlD+SvVVFmLhKm7eJ8huJ7cte8Mtpm83pJ0z1jupzw6qTDZ+LhK6z85Phw4/kWK54PtH9voPhpeFizlxHwQYU7gwmc9frWw6mL6bgqq9zQdxywYFd6dx9xba5Uln/hWKz9B9h8TgmGk9n4uoC3b/1AZVD3IPoVqN7GPnDzCKZKyX7a2V56a3eVvjPdMPndtdqTjOHoEfAH0lokJKW6o5oTnA73T55aNLLUpMyC6G3cH5zHo1hNeXAYfzv9tCFAPBdhcB59WBoCgrsNK48sK8gbhEwplVlQuQm2mdjNd+AZyEsaMZUTBXRRlj/MGVtW+BESFIfPMkmXOVEsFUqzK/VoP1/sryaePkpr8FfmkLdNVR5wnmCctbA92wl6DBbErUZrm++jGU73hyYA6aZCyrA5ZWVgMka6s+uoZwxruHHu4hvJrstHCtZNZ1R402hg3fVNMh/ZfPWT0UDzEDotepuWQuxEQItL5JAitoeallwAuBxuDKLqwTwk3aWtjBfQFKljf1ijjSQbVttQ+lUu1KEfyqGKKScJtoIIm14orbNpjO7bZetP5F3LRy9CSAzqBS34hQE1mmvLzKZeiWYkGM2paSoLFwlRyzLhAtDe5huCjKVWh46KBBhge2C8P4S4EwApgqbE9+2lzblPi65k76iE1ZYkOGvQzLAdQ8Nd7WVFtjTMYtekHSrhUV9VQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(66556008)(64756008)(76116006)(66946007)(4326008)(5660300002)(8676002)(66476007)(66446008)(6916009)(91956017)(86362001)(8936002)(54906003)(316002)(33656002)(122000001)(38100700002)(83380400001)(53546011)(41300700001)(6486002)(6506007)(71200400001)(478600001)(2616005)(186003)(26005)(6512007)(38070700005)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9d16VNx6zxhL3gUsR6jlFKidxW4pss/JjGtyV2Gtk1WLCanL1Rfa4Qq+kNV1?=
 =?us-ascii?Q?62xuEemT2mEoXYBw5zTLTZQCEXlPARLuBmmH+UpKf3j1MCbVy+0mRB2i6kQ1?=
 =?us-ascii?Q?p9WR4VxrkFY3bXTJ3fm0IeAjf3P3u6jprMB1j+GfnoK/gXKKCSlmEvcj1kUg?=
 =?us-ascii?Q?eo2iQjM0EchiJm3I0E+w66SDmZK3ERnGJ22wppE9W2Rv0GSNvYv5c+nSXPJh?=
 =?us-ascii?Q?uEj2uwSq7jmenRF/LN48JiBZJLFGlkt4MFXaW6JjGSHRD1UlWpEuV+csAtu2?=
 =?us-ascii?Q?QNm8HJ36f4NKvKjWDfFy3eLg9keMYDpGf2qdvdzhw9aAOggW29zoQGh17MJl?=
 =?us-ascii?Q?7BRaCpbkLqcegSOBpq16YdRfi6gDvMxeQdfj82nNrSMZxYzNcZk1RbixZSBl?=
 =?us-ascii?Q?SGypGCu1WsuXyuZPmsJM5IURndcwoPGjX3Ok7sz3dZt2oEVcy8MC8qRPbzo/?=
 =?us-ascii?Q?l+p2H7PTYErQtaE0YM5r9PY/pGWWKlokcY/Wj5JtN/kltVvbePjsWMyvk8Gl?=
 =?us-ascii?Q?Hv2j85AQDe5EwjqU12qebDgbO0wur2QH674UHufR0KmYGCgJR/0P2gOPGL18?=
 =?us-ascii?Q?MLWl62QbSNDG6w8zBRH5EoGPvf4ARPuPe8L8fZ3QzD13RIbrTTryGfLhsFcR?=
 =?us-ascii?Q?5obeNfsDwAxYuJg9oZCMet2ilRunExeQ45UfJgvhNdnItcoKwBg6oMSnduVz?=
 =?us-ascii?Q?RfbMNx6izpJNfjWOhIYAMgXYBjA0cTo/5eYG77XIoULDmvC/6/5o8kJVRCsv?=
 =?us-ascii?Q?b/Lz1OF6XlXP3qNQVZS6Ke7fMbIx/HzZvMygySCQH8062TXoaI6QoijiKcMX?=
 =?us-ascii?Q?QYc02fRHzP3aplkH5Mxk1ZPoYUYT+wsdenVzLfAPUKdZINKJLE9fzKtmliMH?=
 =?us-ascii?Q?7GO50eCmbkgULawEptPofNcNSGGVL+6dOOXV7yq5f5wqjlwyQhVqwsIihSze?=
 =?us-ascii?Q?qWbGn3/pgek0FxPU9QhTvBhFYnYjS6uzJYe+9T4OumavCcmEBRoEqqozifpP?=
 =?us-ascii?Q?r70Zu1XN0M4cEbHXueUtuTmPQH/T9ThIcWQllhQR09voH21F23E2ei5v+9RY?=
 =?us-ascii?Q?7p4fU/bHMgFFbWZdKFo7Rthdoki65jCLa9d9yHKzmEclGuVGMGEgXm3RAH1l?=
 =?us-ascii?Q?tzhlwo0916BQHWRi/aLx5wYAKbzW0GxeVWNBSXPD3uQX5r6CUib0L7vYUZPU?=
 =?us-ascii?Q?3u1e/oHUJnxLUCTiEUqdOrK/4G4bqshf6pyfio9RrtkxnImFMmhUlJSgxa2Q?=
 =?us-ascii?Q?nKYQOyubQWwiQia5+BQLbzQtp3bYWGGtZu8j4BdpEg7zec8tMOjSOHZtlgBJ?=
 =?us-ascii?Q?oRTmKpaD7RU3fp4FRvy+nolOfJkQWuzbzGPD1haHoxOWfIrEYlM5Eg+gpAim?=
 =?us-ascii?Q?LQYS2cH+P3cOYcRwLDGZQHmn8/1urzF4w1RAXy0qkBVo1bt+Zf2B6EwXwP16?=
 =?us-ascii?Q?Xh2BPUzm/OXXs7CKiEmpwrsZLr+0j58JG5IelsmcVYbJLzpMsvusDuRqrMca?=
 =?us-ascii?Q?NFYMxD3djPNOsz7dN39aIdx06uFRnzHkfadMok/si1qjgti/Du/L+g3IzBmY?=
 =?us-ascii?Q?bHRgS04fx5Md5SCfJiVWd+uRbs1YPUgStI7XTSp1z6LCNmGnt5mCR6w68Ruf?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <008F9E1D13E6AF45B3A1133CAD2BA24E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a215573-90b3-45f2-b17e-08da9a6af29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 18:15:35.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHazLg3mE4zMf65z/KnxBAio4hhWGR4qMZR9LBFOVTFouyky4tGegk3/IVyYU2UWZg4bEjZViWeMNBQJRhctjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190122
X-Proofpoint-GUID: V6NItoDS_AwaXWIKjcZjwuabFeL7anVQ
X-Proofpoint-ORIG-GUID: V6NItoDS_AwaXWIKjcZjwuabFeL7anVQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 19, 2022, at 1:59 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-09-19 at 15:31 +0000, Chuck Lever III wrote:
>> Hi-
>>=20
>> I rediscovered recently that NFSv4.0 with Kerberos does not work on
>> multi-homed hosts. This is true even with sec=3Dsys because the client
>> attempts to establish a GSS context when there is a keytab present.
>>=20
>> Basically my test environment has to work for sec=3Dsys and sec=3Dkrb*
>> and for all NFS versions and minor versions. Thus I keep a keytab
>> on it.
>>=20
>> Now, I have three network interfaces on my client: one RoCE, one
>> IB, and one GbE. They are each on their own subnet and each has
>> a unique hostname (that varies in the domain part).
>>=20
>> But mounting one of my IB or RoCE test servers with NFSv4.0 results
>> in the infamous "NFSv4: Invalid callback credential" message. The
>> client always uses the principal for GbE interface.
>>=20
>> This was working at one point, but seems to have devolved over time.
>>=20
>>=20
>> Here are some of the problems I found:
>>=20
>> 1. The kernel always asks for service=3D* .
>>=20
>> If your system's keytab has only "nfs" service principals in it,
>> that should be OK. If it has a "host" principal in it, that's
>> going to be the first one that gssd picks up.
>>=20
>> NFSv4.0 callback does not work with a host@ acceptor -- it wants
>> nfs@.
>>=20
>> There are two possible workarounds:
>>=20
>> a. Remove all but the nfs@ keys from your system's keytab.
>>=20
>> b. Modify the kernel to use "service=3Dnfs" in the upcall.
>>=20
>=20
> There's also
>=20
> c. Put the nfs service principal in its own keytab and use the '-k'
> option to tell rpc.gssd where to find it.
>=20
> However note that 'host/<hostname@REALM>' is normally the expected
> principal name for authenticating as a specific hostname. So I'd expect
> clients to want to authenticate using that credential so that it is
> matched to the hostname entry in /etc/exports on the server.
>=20
> The 'nfs/<hostname@REALM>' would normally be considered a NFS service
> principal name, so should really be used by the NFSv4 server to
> identify its service (see RFC5661 Section 2.2.1.1.1.3.) rather than
> being used by the NFS client.

Fair enough, we can leave the client's service name alone.


> The same principal is also used by the NFSv4 server to identify itself
> when acting as a client to the NFS callback service according to
> RFC7530 section 3.3.3.
> So what I'm saying is that for the standard NFS client, then '*' is
> probably the right thing to use (with a slight preference for 'host/'),
> but for the NFS server use case of connecting to the callback service,
> it should specify the 'nfs/' prefix. It can do that right now by
> setting the clnt->cl_principal. As far as I can tell, the current
> behaviour in knfsd is to set it to the same prefix as the server
> svc_cred, and to default to 'nfs/' if the server svc_cred doesn't have
> such a prefix.

The server uses the client-provided service name in this case.
If the client authenticates as "host@" then the server will
authenticate to the "host@" service on the backchannel.

Maybe the only mismatch is that my server is using
"host@client.ib.example.net" on the backchannel, and it should
be using "host@client.example.net" instead?


--
Chuck Lever



