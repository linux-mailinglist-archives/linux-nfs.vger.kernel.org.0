Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383835BEB61
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiITQxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiITQxT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 12:53:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386D696C8
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 09:53:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KGIxj9017942;
        Tue, 20 Sep 2022 16:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B8WjFbkW1j57MDOohC9zRE9qbkQzSJJqFPQOttWgAsw=;
 b=QJ1y/6zcE7ZzXySHMqGqSFn9/Zf8UnWdWLw94LmFmMV+dvCHZKULPSK10p1MBoQJloza
 T4Yx41PQbN9qYTIFFN/yMMOoRbKoVyAcudab1n1+X8dEH+xveIp/K4E0Iy+jfh7/CDoI
 WGhheh7DX/jdpM+2O0nKVZWbq021Ed0dcVAOnOIxx1x+HtMHBmWZsD8GFRsjm0M6iRE5
 JnthIZaJSTW6CJ0VXXPw0Ndohz2EoKBtvZ9vaI4yeJC5YZad3bA9V4nufSzIitVMkFcH
 gjHIb4LTpU+ehE1gU3d1qzuvASeURye6nUPDaUkEmcj86TQRP5Bsxxr67eTTvxdDN8iQ 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kqn33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 16:53:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28KFt4bO022917;
        Tue, 20 Sep 2022 16:53:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39qrjb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 16:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvUvUqWM0Wa9w1uL0BFIt1cK+yILEkPLUyR1arY3eI0zpe8c9swwHGnCIXSltnONOOOay1c/N13iodkmtzCZFnA5dCaSzGP6l161ce8OU22iRSVldjbG0rx6gvpso8utIIbut/dxOWH2RWtomuyjs1xIFPi1s6wzzsdbfqWtLteKJDsX8jvY4+niW5yCGUWChP4kTqcd0RVb3I89q4kch+6VI7sh9cmU1mAdwyNX56JD8HtvhUDQQtaZJYmZ7pnUqcRgMc6sM3wpMV3ZoKnzD1gbtGQOB/fbT2odaoCbOctO46nLdH+PSEVdFWWlfNeN40ZzrcuIFeb/QwcN4Uo+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8WjFbkW1j57MDOohC9zRE9qbkQzSJJqFPQOttWgAsw=;
 b=IQ6git71KZQgshOQIoMOV++StEMLlx+criQjRDnObtiD3yjfpK8vzkizqoLClj0FbaQP9FXHTvhljrowA9Jn2Vb28YHTgxuzbbLHb11VTuOjdYDkERKKujLD5Ev7q/eBeBFE0bR/gNanAw7h+c/12rIPRJGkbGTkSvs5IgOhpHpXvFVO4zAZ/z0wKScYcTrpfuBp9LPokhAAcF9634Ho53ZT3Pq+CUqKokbhp9QgIOe873e2GNhVJ6XtETdc3k4QBzPqDpPxKCN658dlZfDkO/jGN5YYMitvgU/A7yvNkn/HvhdwpwvzHfZPk0e/wCYQsFOREf00w4lvTcFdeux3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8WjFbkW1j57MDOohC9zRE9qbkQzSJJqFPQOttWgAsw=;
 b=qxAK303yjg6f82OOtzwbSGRAQhCev3sba4vbH3HTZ7WwbbITWAKlz36US+/o97T2plQl47hEDs14gmei5Q2e+29EEHOETFxNoupqQDJOhVJcxKHDnwikP/IRy1kA+EFc0Dd5PVU8uQKPCO1vqkcA0crEwn+kzgYPihlaYg+Xzyo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5331.namprd10.prod.outlook.com (2603:10b6:208:334::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 16:53:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 16:53:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDztMjvFTe1YQk+Xo2ZaIaryZK3nCq2AgAAEdwCAAXtRgA==
Date:   Tue, 20 Sep 2022 16:53:12 +0000
Message-ID: <64CAE713-4853-40F6-9DE7-09730C87E145@oracle.com>
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
 <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com>
 <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
In-Reply-To: <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5331:EE_
x-ms-office365-filtering-correlation-id: 95e73f99-ae56-4a9d-e4a3-08da9b289acc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9asOrP+xcCDW0SfRzxtDQbTEhkdv6fSzFAUW2zjtlT/kEjzto8+7C1tiDBEZzeegzWzHgpEZ8V8+CV5Z+sialmqNTRjPxDVmACVMn/rky9iLYCh/zK0U8XbUQ+8tleXcbgXK4FiXF+43VaQBiYA1QwqZzjoWTtHCZqAuFXp2Y4O+8LGQ1jwhi6KWzVe7vW4Xc3R+B72Hri0gruMRVwVO6v1uyFHK9tKsHF2jQPYIWxvvvVL6oL2ou4z7XEY/WltYwgdmHGsbdCwchgSD656lr+VmhJvf5onXFyGvZRbQ7WmltaCNCW0gFISNprFu/RZ/cphx06YqA6Vw9yDRoZPnFRb0csG9AzxGYeNtSbxJyTNZaIXEVjrA6Oi0J7JR9NmF0YQBZ5A7oK5v5ofAZIpMalnBgNesI4lv8VD392cBDDRtPF0D0UXZ8OXBA+E/M7/VWzzfHXj5o3S/3+tB9Fp8l4yclv0UKOG5Immmpm9JXk0BjacFUJ4vPcI+ZY/OGQnZOfOet6qb84jrJEchN/f50sadPJpJndojaV5bblif6ruZr7pElnZIgF49An+GEXMhMTggRCduU+sz0kGGuWrP5YoqS5DjqoPvqgHxxmTCB7VRX1DQy7G+4RfkiBHoHJJgZ9Dy29DDEk6CEP9zXwa8b7DyQYOo674N91SmjLhKoMeJSCw9PLHiRkYvrG0GeEylPuQGylmnOQsRY576fQhkXw/SkBB3KNQdmH6/puc4UzxqOifeIkyiNGVULtdnDcqG5pc22tMjGO6khhcXrXs2zcMClLlvWVis9xCbTH5P/Eh2scgHeQuAMzK7noycs5nq/KcCjD+UJfPKk2oXNr+3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(4326008)(66446008)(5660300002)(966005)(91956017)(36756003)(478600001)(41300700001)(66476007)(8936002)(64756008)(66556008)(66946007)(76116006)(8676002)(6916009)(316002)(38070700005)(2906002)(38100700002)(86362001)(122000001)(33656002)(2616005)(6486002)(71200400001)(186003)(26005)(6512007)(83380400001)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ry4jZVUzMy08e7nurnwIUvjC15BnGVPf6yQq8q3im1B4OeNPxFEjafgImFRW?=
 =?us-ascii?Q?DvcLCuZ/a/p7cPbJFT6LLQRZYo0uhuDBz5y24HKqsl2T11jTZB+9fv7yhWRY?=
 =?us-ascii?Q?vOTN6XRNECdtOkKAv1Q3dkhJbDqIWyDKuu/xpMpIrOJg6oObyQIHdarB4vyp?=
 =?us-ascii?Q?9Vl1hWtFPKk+uUnnjjgB/Rpq8HVUPTfCC5fGpGGZUTWOuGcKUjo28auxsH60?=
 =?us-ascii?Q?LHnywJ0qHnupboQWkKH23GQkLknmjOqGx7dUARiZDYH85TaUHGOaalegBKWq?=
 =?us-ascii?Q?SNjuNZ12j8reqVZKdEIxYTvYW4RvZ5vTNSe8+88kvg4liKBGkmhjzpwfj5Le?=
 =?us-ascii?Q?BlK0/Hu5FP6Xq0LpyRJEB2g09067pSOJhw9bhos3as1ZlZS+rPxS1/ftEIsk?=
 =?us-ascii?Q?cxdpWx27VEPFyVCW6TUBjPtjON3thsCXQkMV+B12aHUfJ4SwuX9jRM8pV05M?=
 =?us-ascii?Q?Al4x5mPPWleJZJKX1HoyzcIWW5XSi4F16smBToVcD1Lh3sNPDQH7cxxliYAD?=
 =?us-ascii?Q?nmP4PP1H31KnAvuRoMiKEqbS3YyN7IzUSQaKb8sLxRoXmH5kHXyK6vHcFid1?=
 =?us-ascii?Q?ga8w0Up511x+zvI5LEU+XVMVmc/XmaPWA5Oc5HP0rd9//7r2Dn4+ex+hRw6m?=
 =?us-ascii?Q?NV+XXEpBm8dWqblDlTnSvy2F2W9dQslJ3btankb0XVpbKSY8qsbyHnVs8HQ9?=
 =?us-ascii?Q?VpcxcjfNL0OdJ/S9W7qwOeuj9gafT7PFWzKs5B6mDBAcazKFLBp9BjJhFm6p?=
 =?us-ascii?Q?LxKviwl+MEG2hoTqXJ1k1/lc/H/qmOuWMYPDfCOtBf80Z3y2VKxQi5s5v0U1?=
 =?us-ascii?Q?xr7fLWt+Eq7p0rSguHFVJQw4CRd8c0OUbLAQoP3amP7bG/mxziC3J39jAmc2?=
 =?us-ascii?Q?uSD9ZVAgYOGOF/sZeAe9tFeNNrJPN3WWwXFX4gKkvJ2n1+Xsv2/NHBoRug11?=
 =?us-ascii?Q?6ldye6SdASot36T8lT9CdI1yJRKb8EtY8MEg0WG9W18WPJLUko86cYEGeMoa?=
 =?us-ascii?Q?ZjxlRZqrlSJRYEGVo05gec0Gb6Lgh1ipfccf3GtA4LR6FTWzxto8CgnJrnf6?=
 =?us-ascii?Q?8V0kJ8w0ykXTE92S7K4hL6HQ4V+F24OzW2crLEYPsP8DvhmhMorxfaxrNIBb?=
 =?us-ascii?Q?uGT3P+mNDJb8lS/HLJAQ1MIZGb093wKh3x9t6wmAVi5xnpaSYykk1phkyUy2?=
 =?us-ascii?Q?ZaQfmEgukE+9ETw/lAXBxgAtks8DAEn81Ui6Mqud8tR9M24b+cJ56R35ozr4?=
 =?us-ascii?Q?uNcKdZNBY3buqY8LsZg1itgfnLs08xONXH/M+JdwpcPV47gd5OZGWs2D/Xzp?=
 =?us-ascii?Q?tIAPXDaSntVAZ/8YOFWIOZNxyg4HHl5Avraaa/0omxmRoadjnxjhnQkZlPj8?=
 =?us-ascii?Q?NuiYqc9oNAIZeSOsgrxlvb7So13sByhbZlrEXk/Cl8M7/GVtmC0OSHC6Cpc0?=
 =?us-ascii?Q?seYJuJlsFFZuB/8dGi1LD0/BwdIvC0El1fKylb9iqi32TyYNnNyPVBQMqOe8?=
 =?us-ascii?Q?j1MnFX9UiiCWvSmagnt/0FRAe6wPrmySbEe+VkPUt/RdhDcSzDjuASV+8BO/?=
 =?us-ascii?Q?79cmZsiBg/QV2hnj/6c7yOLzKugI00isEIj2BsvDOWwwsdJHMowP1x24pQk8?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37A04EAD6B57284BA718AA55EEF4EC54@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e73f99-ae56-4a9d-e4a3-08da9b289acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 16:53:12.3994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIhhCYYl/ZZmMhFqalZKunwPTJ8smQDi72cdLBDwiqtE8LfwLCYisy/2FbQxIb3m/NrEqcopyJUuyQLAcPtgAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_07,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=946 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200100
X-Proofpoint-ORIG-GUID: T99vaRRGdXpa5pjVCorp3m0MFwfIAzD-
X-Proofpoint-GUID: T99vaRRGdXpa5pjVCorp3m0MFwfIAzD-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 19, 2022, at 2:15 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Sep 19, 2022, at 1:59 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
>> The same principal is also used by the NFSv4 server to identify itself
>> when acting as a client to the NFS callback service according to
>> RFC7530 section 3.3.3.
>> So what I'm saying is that for the standard NFS client, then '*' is
>> probably the right thing to use (with a slight preference for 'host/'),
>> but for the NFS server use case of connecting to the callback service,
>> it should specify the 'nfs/' prefix. It can do that right now by
>> setting the clnt->cl_principal. As far as I can tell, the current
>> behaviour in knfsd is to set it to the same prefix as the server
>> svc_cred, and to default to 'nfs/' if the server svc_cred doesn't have
>> such a prefix.
>=20
> The server uses the client-provided service name in this case.
> If the client authenticates as "host@" then the server will
> authenticate to the "host@" service on the backchannel.
>=20
> Maybe the only mismatch is that my server is using
> "host@client.ib.example.net" on the backchannel, and it should
> be using "host@client.example.net" instead?

The Linux NFS server uses gssproxy to acquire a credential for
the NFS4_CB context. It appears to be using "uname -n" instead
of the hostname bound to its InfiniBand network interface --
the latter is what matches the acceptor in the context
established by SETCLIENTID, and the former does not.

I've filed an issue against gssproxy to get help understanding
what's going wrong:

https://github.com/gssapi/gssproxy/issues/65


--
Chuck Lever



