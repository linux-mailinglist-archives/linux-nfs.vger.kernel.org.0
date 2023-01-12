Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB34D66692F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 04:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjALDEl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 22:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjALDEk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 22:04:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCF48828
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 19:04:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C2jt6s019649;
        Thu, 12 Jan 2023 03:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S4JdtyouYBEjHaQofgPTchNbHE+OZTGN6QWrAFtMQ/k=;
 b=ytq5WJF2l/Z3sV0Vv4U1S67DPyj2skL2xmbxNyb3urRcO0LHQVNzH9tzTzI2GJYAur/M
 WU1iUCRjOlHrr99bcU067ZFBK5mOE9A7M2KyIla08GUim0HgI/UxakBd4wicvRWRNOgs
 itP2AnRntyfzzJUVEw6zdIX4CQwr1s8x5kYeRuMxhT3d5egewSatFiyfzx6SXUODFhk+
 5zjM97fd7kW0jvLDW+oPP2Ah4mzbziwmCcoyn7V9HldX4TLxls8sKDMQzWqoxOBkxf0l
 v8DzEq/OmqMknwjp3yK0YejpbOGqOe5uhUl75ZNxSFDduuFt6ZDqnYkjJnVY1C5CP5fD Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nr84ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 03:04:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C2ZYe0007488;
        Thu, 12 Jan 2023 03:04:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4bktx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 03:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5cDhAlQlTTelkieohR1wchwk0ZM30FgYqitWRh26fqtgP1/9yhLn7W6rlRMav5oSq5GOMLqL4j9w9GL7FeqHMX6Eknkplwf/mD3KRDavaZEz73HaouSWKZaf3MH85vZ3OUOLeJUZb75WluhxJjT/MOMkc69I9N/rm0Fsv/j+OSECFEtbyVvr19FnshC9ktLFzuWkDqGUSxSusoRk0dNWTnU7o9GwdfEKB4cPqYjmYFfd1SRMgK8QeIs9G1+L5JpuIRRJY5k4LS/zvoPVMS94MmCE5Pjk/JqgXgD7vqXagW1VCrXjTzF0GfdTbSQ2O9jg9C4tlKo5BkFYg9aoHfrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4JdtyouYBEjHaQofgPTchNbHE+OZTGN6QWrAFtMQ/k=;
 b=HiSpG4MCsBZGd9/PdT/xZBf8JS1L47WOphzO5EjDzZB6Wo3jLYm+ErE1EDEanQQTocz8tcfOI+j4fmMcmm+xK0VmMGiGRsIvcV5T7QjVqUaj6Pv78WjrYX89Ga3Ry0Qd/i+XRY7hUQL/fxXICzKk6yli2ZBY0KjEuiM83Y4iqtp5wn+T08fhxMjoAEZ2zV4dYgoyIr3TA65ykjLa23pR5MXqC5p0wcUh+QAA8HQ/5gnWGi1iUrHnMzX6g+pE4KvTUe8X/BcyxNq62+qDIQl5aTqb9vrOGXsFpWK96T2GZ09+5B+fgiXXI/88WY5rHgDCykbFyMLak4QOjy+XCzJZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4JdtyouYBEjHaQofgPTchNbHE+OZTGN6QWrAFtMQ/k=;
 b=WWes+mN3iTNEp0eThdoEk3xY1dsrni88cSGeIBFd1fSjBzDzi9qjBvZ3c1BbDL1YOSoQsf6mK2vQKt62bJGcaJ50P15AjIIs3dMzZfB6QMiNvWknVwAAuW/rrBX97XDz08uXR2S1NbuF4xF+UK6LwTDi39S/Qqc3q8lb9royeB8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 03:04:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 03:04:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] nfsd: filecache cleanups and optimizations
Thread-Topic: [PATCH 0/4] nfsd: filecache cleanups and optimizations
Thread-Index: AQHZIP9hPEqobn3Ri0O8LyGKP9NIjq6aIzGA
Date:   Thu, 12 Jan 2023 03:04:33 +0000
Message-ID: <47962242-1486-45D8-9179-BB57714F0517@oracle.com>
References: <20230105121512.21484-1-jlayton@kernel.org>
In-Reply-To: <20230105121512.21484-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4856:EE_
x-ms-office365-filtering-correlation-id: 5c43f996-cded-4b8e-8502-08daf449bb5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3ORzC7t5X+1h6Zw0iPdoxwjUaK5pcYg74WZrhiNMdHPO595nVucNmw2ajHshM3+2SGst2G4zGh29WQB98GLLyuw66s4onHgiJXiSrhfPixZ0dG5NI4i0t5ZabNJc3/Y0wHxz+w0jz2eUGqLw/xauHIRQ/LVnh+QqG1kQSpE8ja5i2xHviYa7519QSkJFLvRc/es7HENGELJTtKTVKGyGLb+jeduSQ10lwlQuTKDD0i8pAIqwVq2qCuW2XgwNnu3GI3FkPqqhVah+XbRCy2M0EVDCi+Z9bU0a+gCSr8kQb2XnN9q3cxKloKbhjCiV8v9lrnUIBBJ1u4gTp8MGRsvHFkMtga+n1q1C8/MCO8suNrVFH4hZLMLlgFCHHzaWb4RH48Rd5fCwj8jIxNCPlzewYFsNpSGMzFDt940pFygjv8X9aX8TZ2biMbro4F8x1O6HWlFB20TMj8IImMuf/idEuXJWTSvE2xkDQR/0JiA90m3BPNfdhLEm4uKV1wxTGvtNN4BVE1jXzxEo8E2a4MRD8kJRHnY+W663jwsYV/zC1F/eSGa8t+WOeHR11spZw0jpl+Jx2K/iXQnUGgckgRgrUhAUAoi37OhLv3Wdy6SKL8pcdX24xuL2YpahlcBWf2I8HY7zHPVK1Zv+dl04QZ9hTwlY/xmq5K08dfknqu/7RWDHlyMRXZi6pGysBktj9zORfpEL+84ezOo3Fypj0uZaJ/J3RrcNvKVcb+rOb2KuZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(478600001)(33656002)(6486002)(41300700001)(38070700005)(38100700002)(6512007)(71200400001)(86362001)(316002)(2616005)(66556008)(66946007)(26005)(66476007)(186003)(76116006)(64756008)(4326008)(36756003)(53546011)(5660300002)(6506007)(2906002)(83380400001)(4744005)(66446008)(91956017)(8676002)(6916009)(8936002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+94C5OOvqo81FYo/yz2mM+W8GQo2A1mG0NmFfLGgk3SRUGi/+FTE6n8NBlZO?=
 =?us-ascii?Q?PrlhSyB1WHKKcTQaMIcWrInYmPThLMiFst6Ov9X9inNVUiBPnYBUuSRdI8TT?=
 =?us-ascii?Q?1tcNCBFpKM3FQ51bVRopddVjk1EEqQIXXpKeQd1ccfXNKFr4s1/fbH+gJMcq?=
 =?us-ascii?Q?ONX57P46tuxRHdxsRCGmfrj/ZxvdPN/VWPGrKAqLuevys0iP+6lsj15Ioqkf?=
 =?us-ascii?Q?MjMQAQwzKTMWLHc4FfspZMur5Suzja5WMkRHB1uEnbbFEADuTJtQGTwkZ7MW?=
 =?us-ascii?Q?2bli05IP2vFsKTDh7mpvT0sN2ENp3UFc4+LBq2cCELqccSanff17UO6DQIBA?=
 =?us-ascii?Q?e2SYvymmfP8X47s0NZ0Zs22v2+1OHwdqNKviiHS1oysplNdBboK7j9tvLRQ3?=
 =?us-ascii?Q?MOwXN3qPU63xKiB0CZFZI+YznlocXJafiGUnqV0eOYdAgLQLQeJipbpMUxuv?=
 =?us-ascii?Q?UnuzoSSHUiIp1ww7Qnsbwr+qvxL0S40sznV12OKSi/JdXpuaLAGaeNSa/N0c?=
 =?us-ascii?Q?RLfDiEKWw4HA6EL2Ftd4MQOef57hThCD2GIktHpe7QIcdmYQkrtqIRFbawOG?=
 =?us-ascii?Q?eEudG0j45TZUSzKxjbhwN12SoVzrwIrdbetm/4Ag6fcDQbQnxbjfFYSSEKfv?=
 =?us-ascii?Q?AcbEru9kVORkh1JNuO4fhiWKsORwE7ZToAqV8rxLq+1XsP7Ux7fFI2RLA07n?=
 =?us-ascii?Q?mI5/5mjw877FsL5cCwvZSzCDe8ULEmj8MjCeA/5oGY3ENLUSphWqwiUw+afA?=
 =?us-ascii?Q?U1bjFHQQ7by3pb2pViqKFPYBCdtotIIaJ9ORHdodIVieXv5cXSoLesvAAoFl?=
 =?us-ascii?Q?6GJMmTfDDh1Caz1zKLbTgK6vtM8dp+FT2+rQjzgH70TX9wqM4tt/WHJt6b/5?=
 =?us-ascii?Q?XcztMp0m0oiGCNsig7/KgNxbinUz0Nt6Ox2GdVd8m3xFa7I1PrEIkTV9cDQM?=
 =?us-ascii?Q?iBC2MpimMT5RFomb7+d+GlFvI1mPID2DkXzqN1EoVt4c7whHM5nNYA9LFSyY?=
 =?us-ascii?Q?yT97lYKcKOpYebeNJe3Bu2rBxzn43rjYraYLxr2I9deYeRFSILJJ0/3+l/5Z?=
 =?us-ascii?Q?uGfthbECowm/OMrNTQNfMg7WB9oXnj0/OnX960cmuvabzzvwlD0I+5vDV/Ep?=
 =?us-ascii?Q?3yQ8lUN5rl4nx3I3Rm4Vo0/bnRvCf26lwF0091mUv2bF5yonU42b3WqFnsA8?=
 =?us-ascii?Q?WneeMb2lf2tfVdSB5rx1+5vmjPz0HC3Cv0+F+qAqrT7BNaHcF++sjZSzqxvD?=
 =?us-ascii?Q?DdAXCvNWN6PvKqsIrsLfeztGcYO+qgsMGKQlawDcdErafKZbf/urAgl3HRtH?=
 =?us-ascii?Q?aRlAqsBbDsHZ8QB7DkGAVUeitpIzQ4GLvgkXovzWJ8w5i+j2z0CMJDzRESCt?=
 =?us-ascii?Q?XXFKYeF7Pv9U9Zf7ZCdRj6PxrF5YUdTBB/ImMRaTFRDp84WkbjcKcnSMEOb/?=
 =?us-ascii?Q?ChRCGNgFjiZG8SmghGIbIM84iF0j2e0spHOBEuOr1cU8eKJW8/BJ4oMRJpUV?=
 =?us-ascii?Q?0vOlwqBoNk1PbwBCvoDA0EaiHXMrN8IOJA/FKEuWTCwGOLkUHlmgX9lfgN/B?=
 =?us-ascii?Q?VYgueaWp0gVIgixMACWpuEv5UDA3aSZtsAMgR4MKUlzSBBiEoxBDLDTIAduP?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8ED427F7F2617E48814A793294A16F46@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S8NFsB4SU7WIWGy6eZHfLFEu51qK+yo6T8FC8gvPPB7BpqsjFemn2mNNV2PhQIYV5HV/Dnm7/fUBlDD7c/hp2QLsyUNmZBxxQhwrf5VGJecBdvNzUTAH01s78oUdZ+gR2LtNzWgnJ31iWnB0ay6oNHtcwbtKUa7z4aYtCtpHMD9wq1/YvO6DxPdxt2OiRbNmaJkU23O0Umv6w+tCp5waqxutfW7U1li0DW+BulY5I4KhwbbIUtn5Hzf+7tNDjkRvy6FdE7rnw3fL1YCJdmSiRo/xeGzWJIcPLw2J/it225DeFLNEcAcNkxUP8akrMI9X1ylUWpLydTVHtB9AnScwSPG8zwgY0OuSKMDLlAMi05s30SG1/sujkFMi4zv8LtODJtU8HBFmcGwIFvZJQjY1bfWfwNLKQAnrz68a5f/vZGUn6VaaQrVEPMfh2EQrJMCaad/jpAkQZDk85Htt7qVd9j8EOgE6ZT8RT6Y/Id+CC7GC1Jwz0i8orr5uA6eokV0Bbhc56orHgTDVr23fdXKpx4GgBBd2qawtWOIHdB0Jaz0yLK+UpN9a2o/mtSTwcbhFBiuRaMByM5LRmx1clL0ky4fJvcVCeSyA7aydF2GCECy++j79yCSiNmsbnUMvQ2ohpXu2a38AYLjp/tbDxbAjAAexdakT7sVd7H9z3thac9Hn6gvukyDrevWF5P+OYeE/ByV7E/a4HPRqas9DIYL54GjnyDHA5Z1u9sDUOHC7Q47239bp0QS0QQCl17h4j5gKUuNG/DecatposLFjQHkqItjoncFRl2KBGPNwisd/QlE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c43f996-cded-4b8e-8502-08daf449bb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 03:04:33.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1cWeuSEC0eFcpXURh9uB0onDLtUE3vBdGW6u0kzH/uUHsVF4FYl47wYFKyXpaWteP20ZutSeB2WhMoOEdOXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=914 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120018
X-Proofpoint-GUID: gekCayApToSMJBkkOuszVkSKxbeQumD2
X-Proofpoint-ORIG-GUID: gekCayApToSMJBkkOuszVkSKxbeQumD2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> This is just a small set of filecache fixes and cleanups that I put
> together while going over this code. None of these fix critical
> problems, so these are probably v6.3 material.
>=20
> Jeff Layton (4):
>  nfsd: don't open-code clear_and_wake_up_bit
>  nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
>  nfsd: don't kill nfsd_files because of lease break error
>  nfsd: add some comments to nfsd_file_do_acquire
>=20
> fs/nfsd/filecache.c | 52 ++++++++++++++++++++++++++-------------------
> 1 file changed, 30 insertions(+), 22 deletions(-)
>=20
> --=20
> 2.39.0
>=20

These have been applied to nfsd's for-next. Thanks!


--
Chuck Lever



