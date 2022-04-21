Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31550A385
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Apr 2022 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382268AbiDUPBS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Apr 2022 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389821AbiDUPBP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 11:01:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F744767
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 07:58:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LBw0Ga019231;
        Thu, 21 Apr 2022 14:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tOeauHhpAcXyr/oNkhsSQY0SOi/RfnkFAAzfDfQj8Ls=;
 b=efuzI6GHHViojvEz2py02Mg9E4HDd4RgTHtksBcxOX2lsJn4BrwRZFQDJanNpySTWRa9
 N3A2+gvw3ylcP38woc7RXAkBgGtUqWXARvXqp7HYowHF+NBNig0NcDpTS63ErhbVACgc
 8mETXhI3Ptqym+9/aCm/cDKG019asiK0MdAR3DodddyLyY314kdkCN6jxVBz8mMzuSv8
 Luw0oLa818NKKaZhwYULSWNTO4pgiUqzUJREwfIx5mJr/yWWOXfPCIsfspNmpgsniSbZ
 aTCv8IZ9GQ54KRmM8NM3N9/d0LgorjaYGP5KavbaNw5DYcwbo8fj3XLrag9xau/z167S yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2v8k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 14:58:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LEuuHA031674;
        Thu, 21 Apr 2022 14:58:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm89cm50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 14:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpPdzrjvng2yC2BUArwcYlV9lTNnWuBRK6mub+o8A/ikNCQQzdZy2VyYgZP/U4Gi8k2uLuTygaii8ZjmhhRc8B4uGc0Iwxa4TorDgHaSkrnes8O1vfakVjfvL0hFsN5Wb7IhToUJDIZ4533z03fwKmHQ3iG4t16csOOEsu0d/+vcbXp8cETtNr4sNmEBb1s3nd1a7nNJfDMhIn2JciNNwzXjwmufNNBwWz/FW81WaLifiOBI/nBvhP1fYjjLbCfzLw3eTYN5UubARKF2NVPuDBg8Y2xxhPlMyrv9WPg7NiYgIh3uq0HviHulZ2p2nSuFpp4zKX88j1Ku8Nu0PIQ9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOeauHhpAcXyr/oNkhsSQY0SOi/RfnkFAAzfDfQj8Ls=;
 b=FGy4Tz0EjO5xEKSD7+sVQ/SlPkBmvtmzx7cNd9dLXRdSFCykeF3WLEg9CAwOMX0sd2iVp0meX9V/RfuP0VgqwH0UEEd0sGO8O0nnzDFAqClf3yPaBoZqVk9ZVxtBpGfUe8NN1GTY4jBY5I0SLzqRPxj8DY/37p0ry5O+DPXgRRX4KyV6ZJlQ0PJFnjeR44zxEwMKJydV1cbrCLPwLiPnByfAzLkLp/NFl+Yee4HeLWFiO55NqGiCj2a8c+vYLA4OArzisaTG3c3d/F/FGbmjLhTS9694ApRrQ6idOs4qeCCxILMzHqGF7Ar73qIFsiYY5MZVRJZGUuDGNaeF+ewshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOeauHhpAcXyr/oNkhsSQY0SOi/RfnkFAAzfDfQj8Ls=;
 b=lkoGDKNo4qvugbAi67r1B3AY2HX+p94DZOtSCgBIh0n7hJPzVkwseSjGxDp6LH2bybVMtVOJ/zgxloreY57B/EVMAlZBbbK60wTlQVm66Y2fdGxXS/BLSXwqheYHZMUu33//KjFTFoUxVtVMFDkeBE9jn8S5OCpmGGrJrCza8pk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:58:15 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::b5fe:6488:b87d:3360]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::b5fe:6488:b87d:3360%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 14:58:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Andreas Nagy <crispyduck@outlook.at>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QA=
Date:   Thu, 21 Apr 2022 14:58:15 +0000
Message-ID: <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e53a9e-d1fd-4964-9fdf-08da23a75cef
x-ms-traffictypediagnostic: CO6PR10MB5618:EE_
x-microsoft-antispam-prvs: <CO6PR10MB5618705AFD39D69ECF0246FE93F49@CO6PR10MB5618.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WpxAWHOMc+A6vOuT7j5IUU0y1QqoDjj5IyQtkcJ1RlFbqOBqOh3+2nHolv29BAtf+rIZHnI5/53aJKIhDwSeNPwoa2XkH7MhKGshZOI9lJ1FNn30SLHJvxI6zE2W6oukUd+25B2izs4oxgZkJxoHi7m/M3LQKxj3YGytyBpQo5k+EBRmvH2ucu5xUTBZqKc+lDvQyAHpbtACvOi8AiVEyzrasYr5MeXZJgnm9uIKn5ZlE7umqlqRQu+oE6qb5iNwumdK5s+KrC1JHrXJ7+rJNEzHCinvp7MW5EhsN9secqWdzVWdmkYjhwyXUibMWVHpbzx7yc4FppE9FNokBBk/7gTv7BDGmgI9aQ5XKrnXBX1j59eE+wCG9e5U8IK96rGOiVzHqySMAH1KOVWsW+SydSOP+6P2APKWfs3s/1EJqx6pJ9uniNDrFr2nFOFDlSqgzUlSYznVvCX+ta9cHfZCpack4iOE+P2FyCUfls56B/1SjHfLctRRBRbufbQ+w7GJ23j5AZglrkLQP8b8T5BcGfDBX3BfZzxSFW5sfjkIdy0BsU5hinPOlG8nVc0Bm+f56LeMPSGIZZRv3w0UP0fvsIiSQney1lPzIxzuf/Q+DykZynu30k4sOj0ZLxHwEkD+I1aPndWEFs6IBW+wIz2KGyw6poLKD5PInIMKPSArHxb6VESChRMFJTAPAf9GAO7DckR1mhhxDrX/tAbWGWh6vLq89CDyImCZoibReTgV8CretBAKDqEyf++ga56wdSGLlIw6296iAZR2JapAwczguCr5lW+wCupw3mAgWC3Zvg5GDAc5Kk9WDkFT85MO3I2I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(2906002)(316002)(86362001)(5660300002)(66946007)(38100700002)(8936002)(66446008)(76116006)(66556008)(4326008)(66476007)(8676002)(38070700005)(64756008)(122000001)(83380400001)(6512007)(26005)(53546011)(6506007)(2616005)(4743002)(186003)(6916009)(71200400001)(19627235002)(508600001)(966005)(6486002)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9SyuiX+2lk7YersuJx58e4TnMKsZa3toDsj8sm4NmmwjhmhHLcG1/7rQMGY?=
 =?us-ascii?Q?8zYXATgvG6nwuQvFQ6GPI87y1Bkd3ZhYNRnUwSGWpU03b+N3N+ZTAxE+lnGz?=
 =?us-ascii?Q?Uni8iPi9z1vFcU37QrKytd4bhTv7waSSoYWsgHGzzisdYB3LEf5Plmprbcoq?=
 =?us-ascii?Q?iX05gBSmewe447ccob8BV78GIRc/PSCwlQER2TRAdC47zmGpcr8FqpyL08KZ?=
 =?us-ascii?Q?SS/xXI/gaWucy9wcVHBSsJX0oc29jqMBxRfAZl24RooPE1639iA18ZTaMtY3?=
 =?us-ascii?Q?pt8lAlx0Osq9/YdVbmNIEONITWbqIsdO0C81Uy2zzZAu/jfLrd3U4eVPuiqW?=
 =?us-ascii?Q?f3eYi2aa1eq3IJTN8cJjUqcw5/+T9ge5iG4sDrKvAGwu8gF9M21nbOaodEI5?=
 =?us-ascii?Q?VTm4i9LGAdGXosLUEpzKcTigU0JqUQri7isPu6+VP1CVCvtp0T4MSEGXno1y?=
 =?us-ascii?Q?3NbX+9CxVP0wYKMUnpd0TPyexGelJs621WNh2NKTdTI11XSgwla1jSQYvvQL?=
 =?us-ascii?Q?atOpsU4OdffrcP0/mvZXF9uYTysTflHPp/I5IrW4HtgZ9AkUxfk1YGuQILjP?=
 =?us-ascii?Q?dQECiXtWZu0o3yhkZ/Zm5P58XcSuKh2lqSIBXu/AokUaAkjCiPrgE4gWSt28?=
 =?us-ascii?Q?f1y71iiaNR2jQNM8pP01RqlUxpFS+Jx9Zdid6qdyz3sbHSSF6NoMScmeLTQi?=
 =?us-ascii?Q?vWih08DQgL24aaAtlC08KMVyrIT6bBJu3R3tKxcYKVCWs0EU6DdNnBXMUtGh?=
 =?us-ascii?Q?zpe1Ft/C5f3YK1AcQrpnTBNgACgh7KK+5D+olFfjM4t4g3Vfly+g67Wv+YK6?=
 =?us-ascii?Q?J/B8v6q5SMrKBN1sYzuT2N9jhOqMcmjgBHz/IqVnK9yRF7UC9CSn6clO7qfJ?=
 =?us-ascii?Q?WAU2cKFyfWHecy2awDocii2eCU7OVfedLcOWYSqf9PqgZiB4eb22RTiBZElg?=
 =?us-ascii?Q?cshPLzAb0gak5LWSolJJvcf8y7pPMC8XRySdfedwYnRAnxn3MUNfxK91Awyp?=
 =?us-ascii?Q?sBUo7oQ+Yjqy4TfkVARRfKkLP1vuf+EJHAARMG2+SZoID3oYtHIyfGE2panS?=
 =?us-ascii?Q?UZds+lV7hE9/hIMIjVMwisCAT6CFQ2GElFZyW8CEZmB8C3WT+0yu0xC7Z91B?=
 =?us-ascii?Q?v11WlQWRduxOB5ezMO9MwoP+2FSqI5Iu49PATU4ZhcMgGIcegz46pPrbZ//x?=
 =?us-ascii?Q?4q9DhcgjaPCh2Hzrtk57XxMWas/2kjofjkyOeiWdeBzBo1dagSm0I8Ezax/X?=
 =?us-ascii?Q?Q+GLfnASIZkmo/jyiPY8xEGAlnOTUeiUv7t+PdntszHTESHaINUR9hIQa4pi?=
 =?us-ascii?Q?M73PvcNaxr3X7qJbtAAFw3yQ4xJd0ucpXhinbrceIeltcP5JCzCQTXILnTI4?=
 =?us-ascii?Q?CQfgbbWkJasC2oOc8vD9a3rWZ8FF69MB6nRRrfNRU/hYhQWwmwH7b77rK07o?=
 =?us-ascii?Q?jdUft2y4v4f5SqD+nofMGjuz3pXvG0zaNsnxoFYIs3gWm+/SW6nBaVJaENez?=
 =?us-ascii?Q?NOjhCF+gE/ll3VudpXIvWyYqPXuAt03/D+UxrJVPLXxEgN/X4uqm/X/dM49y?=
 =?us-ascii?Q?qsNvDWDGV2tPMNcqCY6X/WgDdtJbdx7c9InC2XRCpNhGVCoA0sQVKlDpZgtL?=
 =?us-ascii?Q?ZhBPbZTQoSFDCZ2MTNDsow5mrv/xh07mx0Pd+Ve8F8qmqE+q+pCTewJDnHSC?=
 =?us-ascii?Q?0gTtrSslUUldTCCoyA6D/+xNzBn6RmlGszmyjj4ryGV6ba4MvQ0hZkZo43Kd?=
 =?us-ascii?Q?KJqeKbpUJU6mMet+l19iDxl2bzZoDqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF6B5CC411EDD342A96EC96C4871EE23@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e53a9e-d1fd-4964-9fdf-08da23a75cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:58:15.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5E93ln/o5YTgwPQK/S6J0DHx9SRJG58uINWp9xxRsDQfIwj4jefyhsKGWapeLXVVwiLgjnrfbBlOhKSIrVJRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_02:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210081
X-Proofpoint-GUID: hVAMs6ZvuqpwM63Sf3SsT9Bd5mwDAkHR
X-Proofpoint-ORIG-GUID: hVAMs6ZvuqpwM63Sf3SsT9Bd5mwDAkHR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Andreas-

> On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wrote:
>=20
> Hi,
>=20
> I hope this mailing list is the right place to discuss some problems with=
 nfs4.1.

Well, yes and no. This is an upstream developer mailing list,
not really for user support.

You seem to be asking about products that are currently supported,
and I'm not sure if the Debian kernel is stock upstream 5.13 or
something else. ZFS is not an upstream Linux filesystem and the
ESXi NFS client is something we have little to no experience with.

I recommend contacting the support desk for your products. If
they find a specific problem with the Linux NFS server's
implementation of the NFSv4.1 protocol, then come back here.


> Switching from FreeBSD host as NFS server to a Proxmox environment also s=
erving NFS I see some strange issues in combination with VMWare ESXi.
>=20
> After first thinking it works fine, I started to realize that there are p=
roblems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
>=20
> Importing ESXi OVF VM Templates fails nearly every time with a ESXi error=
 message "postNFCData failed: Not Found". With NFS3 it is working fine.
>=20
> NFS server is running on a Proxmox host:
>=20
>  root@sepp-sto-01:~# hostnamectl
>  Static hostname: sepp-sto-01
>  Icon name: computer-server
>  Chassis: server
>  Machine ID: 028da2386e514db19a3793d876fadf12
>  Boot ID: c5130c8524c64bc38994f6cdd170d9fd
>  Operating System: Debian GNU/Linux 11 (bullseye)
>  Kernel: Linux 5.13.19-4-pve
>  Architecture: x86-64
>=20
>=20
> File system is ZFS, but also tried it with others and it is the same beha=
ivour.
>=20
>=20
> ESXi version 7.2U3
>=20
> ESXi vmkernel.log:
> 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance=
:209: [nsx@6876 comp=3D"nsx-esx" subcomp=3D"vswitch"]client vmk1 requested =
promiscuous mode on port 0x4000010, disallowed by vswitch policy
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)World: 12075: VC op=
ID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41: NFS=
41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Sta=
le file handle
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41: NFS=
41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: NFS4=
1FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stal=
e file handle
> 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: NFS4=
1FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD pag=
e 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evalu=
ation for device mpx.vmhba32:C0:T0:L0
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)World: 12075: VC opI=
D esxui-6787-f694 maps to vmkernel opID 9529ace7
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 264565=
: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-00000000=
0000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: Crea=
ting crypto hash
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 264565=
: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed=
-0000-000000000000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 264565=
: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-00000000=
0000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: Crea=
ting crypto hash
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 264565=
: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed=
-0000-000000000000/test-ovf/test-ovf.vmx
>=20
> tcpdump taken on the esxi with filter on the nfs server ip is attached he=
re:
> https://easyupload.io/xvtpt1
>=20
> I tried to analyze, but have no idea what exactly the problem is. Maybe i=
t is some issue with the VMWare implementation?=20
> Would be nice if someone with better NFS knowledge could have a look on t=
he traces.
>=20
> Best regards,
> cd

--
Chuck Lever



