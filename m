Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1D5F5727
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJEPLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJEPLR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 11:11:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF646E8AB
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 08:11:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295EYwkJ021396
        for <linux-nfs@vger.kernel.org>; Wed, 5 Oct 2022 15:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y4RA9SHEbACk7xabV5p12PFfUqcKbLwn71KyWNDktqk=;
 b=BS8dGPSi3m5nnH+rGkS01L1ejPWO3SIwBmzQUdp1XtkF/IKifvpDXAZCb0HKzGVJ6vwx
 fMmx0iDQu3bc6JhOKq7E/bwJnuAEsEl3D1OMjWWprk4VPhmCgqya3yMFmsG/kWvyh7SR
 X4NaCq6sYCxGHrtqUQoNE7zBS+K3kfYA2CWbJT+zYZDayySEbMKDTcELIAZUjOZqAFTD
 NoGIbPZEkb7l0i+ErHjxt40m/b+L8EdBcL3ZJxkg5OahAlM47hkvyqUOp7SUGgB3VejE
 owlnynjqln3giomXhlC0BKWPd+PRjohsrqmb0tazzO56ccePATkPmDJIQrK6J5XAoIaR mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc521rxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 05 Oct 2022 15:11:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 295EYQMg010216
        for <linux-nfs@vger.kernel.org>; Wed, 5 Oct 2022 15:11:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0bfr0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 05 Oct 2022 15:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie2S5oXe+pVvwn2qgV5iySkY92+iN+QAvQj15j7uOFXBqLZluEnBcqCCA0lSQpxbKJziYaZ0SmTr7iSup9lis/dMShpcDrJRprpanuDVQDT8JvV1VJXPFmNfw1/jl418JiiQHY9JJeV1KZO5aImyENgrcGYcfbNnCprPsf4zcCbfErbfcBzc2OTWeMwuP9E1m/bDu1IuDP229HbpU4k9yaUyG/2q3ymvMb74+4rRUr9bRMQHZrCi3RRoQyxHxe+V/WsxbM9BOri4pgOPoaiJbAfAv6SKx/bqzl8GP5YJp7HkikP9aSygqX5FYof50Jdhg8WLjnYWHIPFb3B0/yIMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4RA9SHEbACk7xabV5p12PFfUqcKbLwn71KyWNDktqk=;
 b=K5s3SrGUVfD8dkIlGW1KUvx8d4UqUYjlC7tvub2fXU3DyQafFZxKxOrYed6/cFCQtWbgIceFPsO7whuCy+rf+1xW2Z4FrAT9eDdkzcc6i2OK7WkIX6rtG1JqZtklBUMhUiWtlJwhNFnSWamU8c/BZYF4RdJFc8CiaqLV3+9gmL4BdeNdl/tktdOCV1SqqrbOcjYvgoaXXrNHBxPEyrU9N0MVrU/0tbNBfUw1BT2PX2l4NWCQ1+JUc4QedOaaNeZky/h7YUILZ2YrmZCq76vZTzqbPGfRpVzQAjwYdzIXLKCq64ImCfSO75KpzNRNXncv+h7+THx+FgbLg5BhMvv+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4RA9SHEbACk7xabV5p12PFfUqcKbLwn71KyWNDktqk=;
 b=LM7Wgwvdt/rSsmp/ghMml+Oxh+0kCHmpaxk6IQP4oZitDjItCbTtl+Lvz+VwdtBIFUx9JPVXp6tHwCB+b/Rifmd8pmlMfMq3CmCxEgK4NgYgLpVtwAATVGuzM94W1fHVXYqDtQ18ZaTOzXX7UlTik0XUz4MXH2gHay3dB+cXE2Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6803.namprd10.prod.outlook.com (2603:10b6:930:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 15:11:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 15:11:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2MqolQJfc1v/akaCAaqBZylZFK3/59CA
Date:   Wed, 5 Oct 2022 15:11:09 +0000
Message-ID: <339F3E66-C90C-441A-916C-A41F3193E228@oracle.com>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
 <166498178061.1527.15489022568685172014.stgit@manet.1015granger.net>
In-Reply-To: <166498178061.1527.15489022568685172014.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6803:EE_
x-ms-office365-filtering-correlation-id: 6d318368-f483-4b70-1451-08daa6e3d5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ribzq6R8tHt7EMFJBsMqIN4CGNQkcxjemzz2bUqmZAlR/FxKFH5GLKS+SCyhR3tBWkNNRQ/JVU3U37TRIh+FYUx1+1R+rZIoz+cDRLUXXjtqg8iCuP1gqBCacZI7NyLWLs2m5Ym0Ja6iAb7alcYEtBsRWfWvOUEHZtEttuWwbtnQf3fjc0v6wevi+Wud81HFXQrYbc/YFn8dQ5jZYrqjWM8HenceRLtPCWK5jX3Iv21QyNx5hnAt/JhtCEbT4rEglM/o2mCW/WWIJ5XaKQqJimUROpuciQR9T37bbES7nqppd7SmyijUG5dw8B0T7Kl1LfAmC9IQVqUdIxmSRCLkwVC/uGAHdz0D0UP3XHT1vLcd0DK3czoR/6aH1JGBv4lpe0YhsFgBpQTQomwGwnsY2PB5/sl6BBMchQg+TtxtHOJlN1M5GfwPm15NXYZBawgah2sC5BEsMgLdpkQAuiGsHFDP22O6ffqsH6XooGC8T09fv4u8ebPS8SInPUvp7PQ25rQh1wTu9CcegtpXMEYmJuYa7Q7HBUwuiXR5T0TMugMHqIkhlnObPZAttU0JgOZcA1RvHdbKhU2I1nGhBS1tzJuWjhSkIEjUYmRWu6qkbj+czxsWTT4KdGwIw0VGVdi7AE7ewemW12v9djO091X9ofZrxdoBB7oElYbpuivKqavv7RAfqf7Z5HiRcVbUWGCe9eRLxGU25lmpAlaz7rbXf6rpYsXG+2jO0Cir1E4Q2lRfQRqGjzW9/FSOJ4sp2er3VIkJOU5HSF4/mvzbkj7FjiwRfqB2YF2fDEpOxPauARIf4nXLv0nwNLZVaDqnafjP/MwHB4oVUk27v2EXfRXFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(53546011)(26005)(478600001)(2616005)(6506007)(186003)(6512007)(30864003)(5660300002)(83380400001)(2906002)(6916009)(91956017)(71200400001)(6486002)(316002)(66446008)(8936002)(66556008)(64756008)(41300700001)(66476007)(8676002)(66946007)(76116006)(122000001)(86362001)(36756003)(33656002)(38070700005)(38100700002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E6C6Dx1iF0qduk/DjHZqbwSNN1pahnMH18P7WrfZLO377ftoZE97YhkBhjWR?=
 =?us-ascii?Q?zHh5YNW13TwuXrZily7Ylgx0IVDP+gjx0mBl4oZMmZHYFoXEu1xBxi/WJr/4?=
 =?us-ascii?Q?2gjaw+acNPV7oD+VL3pf3Tf72hxl61TImrK4y8cNLNSuJgNn4DBZtA6l2HnW?=
 =?us-ascii?Q?DYnIXFN9yIUU7O50W0bpQYdL3HejFamxYC6ZMoxJ0bUDqxyQnlbheY4l/J3r?=
 =?us-ascii?Q?eR1NfZ/BGRklcERowG/pXnU9NHjOOpQjhbnmlfwgBdo6nVHjG0LhEJ/1ZEMR?=
 =?us-ascii?Q?pCOFtcL86qEuorolFF/RGD3EqsbyRO4Ma+j1/Lg+6Vl526Xg/yqJv575FP6w?=
 =?us-ascii?Q?gea0teI8JKksQq1sdJSIncspjRew/gsc2jQagJ6kbuAIZ7j2feQzHl/xbRsl?=
 =?us-ascii?Q?QvN0b5bgCKNomcObD5vBte+i8NLTYZ5atqhTr5njbsZ5LCR0hV2HYHOnqOnT?=
 =?us-ascii?Q?+9Ei5DWiVwUFVpcvQeZzuHUzoZL1WG2cq1bvQXqvFJ91tXmHQiO5RhTXt2PK?=
 =?us-ascii?Q?HxalavDqYZ65QyJlRwFTCJI3umg4rJnX48XHRybhXks/TZnkq67/ytSyeega?=
 =?us-ascii?Q?BdSuiCltthlbkOcSidf/kV/We4Q0IgD79417ak2BqwyWAxF9GUH/vbg0mqo0?=
 =?us-ascii?Q?45Bj5NEUlh8GQTswkGonvzrS1UjRNvcbJZrFP4tpcepONEB0rfsB6Gbia5Ew?=
 =?us-ascii?Q?oE4u38ZSitXPsMkBRKN/nOoE4/rAt4NmgPMEuKKVi2LbdBXn9ULy+yyFetJV?=
 =?us-ascii?Q?f4LDaljIKUS8PzyYi/4+WR6Rl/nwjaii9ubinYgavdL6flBTSyevUlgm2SWZ?=
 =?us-ascii?Q?R+Xl8C0yzJsK7c0Zosx4uEHpvDl9XqZbnDrHtXqMjH8wpIvmVi6dMeFnI6i6?=
 =?us-ascii?Q?Vpk7wMvSoZXgaznVcYcRx7gO/6Yaxh9ayD6ZUeoDvOzb62Le9DpwbdXh1BKp?=
 =?us-ascii?Q?6tJp/nsAtQQEJIV9ShEyiAHK2RAWj0TpuDBL24ICf1lF2Rw4V12U9Yf37KKK?=
 =?us-ascii?Q?DdoQUuZPTOVP5nknPIU6+3+6ZrkmH06bj/WB+YWDsf7DbF/DtiZLpyHypKJb?=
 =?us-ascii?Q?sm4eoMy2l8IzQSKZ6Q6HW7aWmaFSEWbHllnTrfIaZEZ80JVDyonQzdVqxtER?=
 =?us-ascii?Q?c6TwENI+a3xiebesdnk0KbaIxBPHGZx1oNNtWaQ2sz7wYbiDtsbEtBqxwkyN?=
 =?us-ascii?Q?EFQRUX2kk+BZqn44y0ShVGri9+aRZYJSLUEUKJyF1u4J59IkjjDHzMQpzPiy?=
 =?us-ascii?Q?jK7ejX+zUHj4bYoXmSWhRi0vnVSvXeM1qe+JA5EeHQfYQt2E94MWnqj1lwDJ?=
 =?us-ascii?Q?8Ju8nxsr0dttUAUPx4IczbsKY2rnjFPQ9gozUc12lzDnURBM28wrs9ObiLwG?=
 =?us-ascii?Q?1ASh3q9G6n47RwaNrLDasNYR5M4dn0FqwskcQmhbxKCSvSlIOIekxS0L1RNk?=
 =?us-ascii?Q?pzy1HRUGZtsJVdycn02gJ8mMr1n3YEygySDYpsIuHlL71cLrcGqAgky/T3LW?=
 =?us-ascii?Q?NRe9B9HTG7GqHRqL9GIs7NTY2XROGMo7gSzpunzvsvPvL9uu1YuNM6+/YjKQ?=
 =?us-ascii?Q?dEaIIr2r7m97L2zuTLbCEXDlE1zwxDwrtV0/Evsufr3z7VtlR2G5jP+jZDw4?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <124E52456DAAE84B9405B0116F579D98@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wizKv5pyAA7qpxvrfHpEjtX+3ra/ezlbBIX1LKkbpIGhmv9UjOepTmWfA4OOwTYWMrk6h9nVuyX4/TiK8U/AsJI70MI2Bse/bgDQ08Ezp73XQXrg13jrRA6FzPmNkiYk22pa2KfDbn912THWZugZ7bi4auJAa2TolTkI7TSrRSQ3uHRD2n3ZGcRycYxPbL3Kn6CsuVC21ZiF0y7GsJDgXfkGZ1l1MrTkRNn6TGdTe5ytGMZUxP0hO+szmXVpwi5lcg2VkhQ9CK6vCKIUwprvZ7YkPZdR24QWXEU3ixpCbyVFK6wUX23OkzajgdPppMUX39T7BAUbijVIIUSKujPaSW11xcrRRGFz3OYKfWYXRFSaiGuJwgEvCfAOOgo/2P+TaBsvrChmnVw11WW9TKXplIx9vzT7kiP0C59TI1m2yYqzxFi9uaPrw5XnYP+djsuabHAqAoAsELgV2w0I5EYLb6Ejl9klyjIZwbJkK5bTCdKpuVNnvb+9tRlPmQR5k+JmYcY71UnqOIW7IvLlwmTWAVEYowm9mvVCQKVnAmvbsLJjcOtGcnL4iC6PCQObyweyHEanmcA9yQh/wOU+0gqOTYI04ZXvZ1ZXGK/1CKBS69eRqNWxxBQ41IDD2BQoqWIgJgGZW+W5J/tg1tAnV5cwwxvlud/ysBzdjuwtLEuXJhMBM9wMFmvTKeAiLiCUh//DpmGMWJhzOLBKTkCuLcQ/C2zW/DCFJx4vrtSRnlxT0z728Pm/iodIAcTvXyAZhN/TNNntLCDi+uabg2UXu3R9SA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d318368-f483-4b70-1451-08daa6e3d5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 15:11:09.9840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNWqS20fssPa/PNjrZSLrwurX77HRB4CUaadB6uosUfX5VICtkv54i5dJLa+BgyV5Av7Hg9dzDP+q6zTCsiVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050095
X-Proofpoint-GUID: YwvFwIukGeKabAm20zmgGc0oA02Tgv5e
X-Proofpoint-ORIG-GUID: YwvFwIukGeKabAm20zmgGc0oA02Tgv5e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 5, 2022, at 10:56 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> fh_match() is expensive to use for hash chains that contain more
> than a few objects. With common workloads, I see multiple thousands
> of objects stored in file_hashtbl[], which always has only 256
> buckets.
>=20
> Replace it with an rhashtable, which dynamically resizes its bucket
> array to keep hash chains short.
>=20
> This also enables the removal of the use of state_lock to serialize
> operations on the new rhashtable.
>=20
> The result is an improvement in the latency of NFSv4 operations
> and the reduction of nfsd CPU utilization due to the cache misses
> of walking long hash chains in file_hashtbl.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> fs/nfsd/nfs4state.c |  229 +++++++++++++++++++++++++++++++++++-----------=
-----
> fs/nfsd/state.h     |    5 -
> 2 files changed, 158 insertions(+), 76 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2b850de288cf..06499b9481a6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -44,7 +44,9 @@
> #include <linux/jhash.h>
> #include <linux/string_helpers.h>
> #include <linux/fsnotify.h>
> +#include <linux/rhashtable.h>
> #include <linux/nfs_ssc.h>
> +
> #include "xdr4.h"
> #include "xdr4cb.h"
> #include "vfs.h"
> @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, struc=
t nfs4_lockowner *lowner)
> static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> void nfsd4_end_grace(struct nfsd_net *nn);
> static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpn=
tf_state *cps);
> +static void unhash_nfs4_file(struct nfs4_file *fp);
>=20
> /* Locking: */
>=20
> @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rcu=
)
> void
> put_nfs4_file(struct nfs4_file *fi)
> {
> -	might_lock(&state_lock);
> -
> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> -		hlist_del_rcu(&fi->fi_hash);
> -		spin_unlock(&state_lock);
> +	if (refcount_dec_and_test(&fi->fi_ref)) {
> +		unhash_nfs4_file(fi);
> 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
> 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> @@ -695,19 +695,85 @@ static unsigned int ownerstr_hashval(struct xdr_net=
obj *ownername)
> 	return ret & OWNER_HASH_MASK;
> }
>=20
> -/* hash table for nfs4_file */
> -#define FILE_HASH_BITS                   8
> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
> +static struct rhashtable nfs4_file_rhashtbl ____cacheline_aligned_in_smp=
;
>=20
> -static unsigned int file_hashval(struct svc_fh *fh)
> +/*
> + * The returned hash value is based solely on the address of an in-code
> + * inode, a pointer to a slab-allocated object. The entropy in such a
> + * pointer is concentrated in its middle bits.
> + */
> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
> +{
> +	unsigned long ptr =3D (unsigned long)inode;
> +	u32 k;
> +
> +	k =3D ptr >> L1_CACHE_SHIFT;
> +	k &=3D 0x00ffffff;
> +	return jhash2(&k, 1, seed);
> +}
> +
> +/**
> + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
> + * @data: key on which to compute the hash value
> + * @len: rhash table's key_len parameter (unused)
> + * @seed: rhash table's random seed of the day
> + *
> + * Return value:
> + *   Computed 32-bit hash value
> + */
> +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
> {
> -	struct inode *inode =3D d_inode(fh->fh_dentry);
> +	const struct svc_fh *fhp =3D data;
>=20
> -	/* XXX: why not (here & in file cache) use inode? */
> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
> }
>=20
> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> +/**
> + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file object
> + * @data: object on which to compute the hash value
> + * @len: rhash table's key_len parameter (unused)
> + * @seed: rhash table's random seed of the day
> + *
> + * Return value:
> + *   Computed 32-bit hash value
> + */
> +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct nfs4_file *fi =3D data;
> +
> +	return nfs4_file_inode_hash(fi->fi_inode, seed);
> +}
> +
> +/**
> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
> + * @arg: search criteria
> + * @ptr: cache item to check
> + *
> + * Return values:
> + *   %0 - Item matches search criteria
> + *   %1 - Item does not match search criteria
> + */
> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
> +			       const void *ptr)
> +{
> +	const struct svc_fh *fhp =3D arg->key;
> +	const struct nfs4_file *fi =3D ptr;
> +
> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
> +}
> +
> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rhash),
> +	.hashfn			=3D nfs4_file_key_hashfn,
> +	.obj_hashfn		=3D nfs4_file_obj_hashfn,
> +	.obj_cmpfn		=3D nfs4_file_obj_cmpfn,
> +
> +	/* Reduce resizing churn on light workloads */
> +	.min_size		=3D 512,		/* buckets */
> +	.automatic_shrinking	=3D true,
> +};
>=20
> /*
>  * Check if courtesy clients have conflicting access and resolve it if po=
ssible
> @@ -4251,11 +4317,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
> }
>=20
> /* OPEN Share state helper functions */
> -static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
> -				struct nfs4_file *fp)
> +static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *fp=
)
> {
> -	lockdep_assert_held(&state_lock);
> -
> 	refcount_set(&fp->fi_ref, 1);
> 	spin_lock_init(&fp->fi_lock);
> 	INIT_LIST_HEAD(&fp->fi_stateids);
> @@ -4273,7 +4336,6 @@ static void nfsd4_init_file(struct svc_fh *fh, unsi=
gned int hashval,
> 	INIT_LIST_HEAD(&fp->fi_lo_states);
> 	atomic_set(&fp->fi_lo_recalls, 0);
> #endif
> -	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
> }
>=20
> void
> @@ -4626,71 +4688,84 @@ move_to_close_lru(struct nfs4_ol_stateid *s, stru=
ct net *net)
> 		nfs4_put_stid(&last->st_stid);
> }
>=20
> -/* search file_hashtbl[] for file */
> -static struct nfs4_file *
> -find_file_locked(struct svc_fh *fh, unsigned int hashval)
> +static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
> {
> -	struct nfs4_file *fp;
> +	struct nfs4_file *fi;
>=20
> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> -				lockdep_is_held(&state_lock)) {
> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> -			if (refcount_inc_not_zero(&fp->fi_ref))
> -				return fp;
> -		}
> -	}
> -	return NULL;
> +	rcu_read_lock();
> +	fi =3D rhashtable_lookup(&nfs4_file_rhashtbl, fhp,
> +			       nfs4_file_rhash_params);
> +	if (fi)
> +		if (!refcount_inc_not_zero(&fi->fi_ref))
> +			fi =3D NULL;
> +	rcu_read_unlock();
> +	return fi;
> }
>=20
> -static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_f=
h *fh,
> -				     unsigned int hashval)
> +static void check_nfs4_file_aliases_locked(struct nfs4_file *new,
> +					   const struct svc_fh *fhp)
> {
> -	struct nfs4_file *fp;
> -	struct nfs4_file *ret =3D NULL;
> -	bool alias_found =3D false;
> +	struct rhashtable *ht =3D &nfs4_file_rhashtbl;
> +	struct rhash_lock_head __rcu *const *bkt;
> +	struct rhashtable_compare_arg arg =3D {
> +		.ht	=3D ht,
> +		.key	=3D fhp,
> +	};
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +	unsigned int hash;
>=20
> -	spin_lock(&state_lock);
> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> -				 lockdep_is_held(&state_lock)) {
> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> -			if (refcount_inc_not_zero(&fp->fi_ref))
> -				ret =3D fp;
> -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
> -			fp->fi_aliased =3D alias_found =3D true;
> -	}
> -	if (likely(ret =3D=3D NULL)) {
> -		nfsd4_init_file(fh, hashval, new);
> -		new->fi_aliased =3D alias_found;
> -		ret =3D new;
> +	/*
> +	 * rhashtable guarantees small buckets, thus this loop stays
> +	 * efficient.
> +	 */
> +	rcu_read_lock();
> +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> +	hash =3D rht_key_hashfn(ht, tbl, fhp, nfs4_file_rhash_params);
> +	bkt =3D rht_bucket(tbl, hash);
> +	rht_for_each_rcu_from(he, rht_ptr_rcu(bkt), tbl, hash) {
> +		struct nfs4_file *fi;
> +
> +		fi =3D rht_obj(ht, he);
> +		if (nfs4_file_obj_cmpfn(&arg, fi) =3D=3D 0)
> +			continue;
> +		if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode) {
> +			fi->fi_aliased =3D true;
> +			new->fi_aliased =3D true;
> +		}
> 	}
> -	spin_unlock(&state_lock);
> -	return ret;
> +	rcu_read_unlock();
> }
>=20
> -static struct nfs4_file * find_file(struct svc_fh *fh)
> +static noinline struct nfs4_file *
> +find_or_hash_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
> {
> -	struct nfs4_file *fp;
> -	unsigned int hashval =3D file_hashval(fh);
> +	struct nfs4_file *fi;
>=20
> -	rcu_read_lock();
> -	fp =3D find_file_locked(fh, hashval);
> -	rcu_read_unlock();
> -	return fp;
> -}
> +	init_nfs4_file(fhp, new);
>=20
> -static struct nfs4_file *
> -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
> -{
> -	struct nfs4_file *fp;
> -	unsigned int hashval =3D file_hashval(fh);
> +	fi =3D rhashtable_lookup_get_insert_key(&nfs4_file_rhashtbl,
> +					      fhp, &new->fi_rhash,
> +					      nfs4_file_rhash_params);
> +	if (!fi) {
> +		fi =3D new;
> +		goto check_aliases;
> +	}
> +	if (IS_ERR(fi))		/* or BUG? */
> +		return NULL;
> +	if (!refcount_inc_not_zero(&fi->fi_ref))
> +		fi =3D new;

Ah, hrm. Given what we just had to do to nfsd_file_do_acquire(),
maybe this needs the same fix to hang onto the RCU read lock
while dicking with the nfs4_file object's reference count?


> -	rcu_read_lock();
> -	fp =3D find_file_locked(fh, hashval);
> -	rcu_read_unlock();
> -	if (fp)
> -		return fp;
> +check_aliases:
> +	check_nfs4_file_aliases_locked(fi, fhp);
> +
> +	return fi;
> +}
>=20
> -	return insert_file(new, fh, hashval);
> +static void unhash_nfs4_file(struct nfs4_file *fi)
> +{
> +	rhashtable_remove_fast(&nfs4_file_rhashtbl, &fi->fi_rhash,
> +			       nfs4_file_rhash_params);
> }
>=20
> /*
> @@ -4703,9 +4778,10 @@ nfs4_share_conflict(struct svc_fh *current_fh, uns=
igned int deny_type)
> 	struct nfs4_file *fp;
> 	__be32 ret =3D nfs_ok;
>=20
> -	fp =3D find_file(current_fh);
> +	fp =3D find_nfs4_file(current_fh);
> 	if (!fp)
> 		return ret;
> +
> 	/* Check for conflicting share reservations */
> 	spin_lock(&fp->fi_lock);
> 	if (fp->fi_share_deny & deny_type)
> @@ -5548,7 +5624,9 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 	 * and check for delegations in the process of being recalled.
> 	 * If not found, create the nfs4_file struct
> 	 */
> -	fp =3D find_or_add_file(open->op_file, current_fh);
> +	fp =3D find_or_hash_nfs4_file(open->op_file, current_fh);
> +	if (unlikely(!fp))
> +		return nfserr_jukebox;
> 	if (fp !=3D open->op_file) {
> 		status =3D nfs4_check_deleg(cl, open, &dp);
> 		if (status)
> @@ -7905,10 +7983,16 @@ nfs4_state_start(void)
> {
> 	int ret;
>=20
> -	ret =3D nfsd4_create_callback_queue();
> +	ret =3D rhashtable_init(&nfs4_file_rhashtbl, &nfs4_file_rhash_params);
> 	if (ret)
> 		return ret;
>=20
> +	ret =3D nfsd4_create_callback_queue();
> +	if (ret) {
> +		rhashtable_destroy(&nfs4_file_rhashtbl);
> +		return ret;
> +	}
> +
> 	set_max_delegations();
> 	return 0;
> }
> @@ -7939,6 +8023,7 @@ nfs4_state_shutdown_net(struct net *net)
>=20
> 	nfsd4_client_tracking_exit(net);
> 	nfs4_state_destroy_net(net);
> +	rhashtable_destroy(&nfs4_file_rhashtbl);
> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> 	nfsd4_ssc_shutdown_umount(nn);
> #endif
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ae596dbf8667..879f085bc39e 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
>  * inode can have multiple filehandles associated with it, so there is
>  * (potentially) a many to one relationship between this struct and struc=
t
>  * inode.
> - *
> - * These are hashed by filehandle in the file_hashtbl, which is protecte=
d by
> - * the global state_lock spinlock.
>  */
> struct nfs4_file {
> 	refcount_t		fi_ref;
> 	struct inode *		fi_inode;
> 	bool			fi_aliased;
> 	spinlock_t		fi_lock;
> -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
> +	struct rhash_head	fi_rhash;
> 	struct list_head        fi_stateids;
> 	union {
> 		struct list_head	fi_delegations;
>=20
>=20

--
Chuck Lever



