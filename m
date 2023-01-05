Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70865EE5D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjAEOHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAEOHR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:07:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93315D40F
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:05:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3rc7008656;
        Thu, 5 Jan 2023 14:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JaYBi7Gf2rJW3DaxM2WMFZtEl9km3CSlIh1dNyisGZ8=;
 b=VTHBG+9HJznFrDJ2t7JMP/KEsUMN9ENRNmcA8hPV6iTk0pZGgbldnBUzrOz7fj0Oeql0
 pipz7h0ZW4g+ye11MESM63Zm03hUY950CCGBgIUXytXUQ6GUvb6C2kczr8++y4n4Ch0h
 LREY2u7bFEQZK4Gk5ZhJY9/2Vq8kYvTI2pIEkapipRgLACaI+SMVe16S08Ep0Kem+iCO
 sYEMD7oou9/WDJ7rDgRD5/WsfSK6JzqD50FKNDHl1r12XjyNDlueo6oCVHiMCIGwD5jJ
 S6lgxXCd9onPcLrTX8YaM5KR4KgzYVVMCK8qgXN7MOjSqm8tPafJrJRnlf2Lo8tiQgQu +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt8v3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:05:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305CSnVW017745;
        Thu, 5 Jan 2023 14:05:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkeujrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaPUZ8pLj+HyVQRTXWNjkX8cf4HtpuU9gKpWQQI+t7rj5k0LvBWPeq3po0Cem4QDDMewAlCaQuyKn2m/KU1Rs6WnMORj1EAzEDn5Ohvysoum00iV5iipPE0HzYPCk7/NgUZH5QdBH9a/c+Rq+1SRgXbHRHtal9t6yqk3wK8C4KxB3Dc4vQP9zOHxtb38iaS7es0CGyVK7bZZDuC6rgYw1wRBZquMdU11MsoQrCn/wMCBStwwjhaiZFKVul/dRjdhdoZFx+qTZSQm+rlkVbvNdZy9VMgTV9uutL63TTYt0u6twVMmeO+o1U99e2hC+LBgWRwdy/WUShK3Jt7Vm4DClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaYBi7Gf2rJW3DaxM2WMFZtEl9km3CSlIh1dNyisGZ8=;
 b=KNKQfBIA7RM9BuwNCKQWZLsgTX8qzWt+6jeXGbYYg5b1Gx2JTs008OedTwquGPBD0UilvbSEQJib0/vd76TnOSpGZSb9eQP2qi+BsNShWxjISuSUn4mExlsepw/8QyzNrpeXDsRaq/ITcyHpq0vojlSNiAAj+CkR3PUiN0KV+jPWt1s89pOa0YA9cgHxsgJa7tIrIjthWW2xwsngqz8QYgyYALQlnKcdsQL+FAM7bfPrT8UNutxrNSe5LsXIL1ORyl+B9cvk+hj9SYaBXhVirTDTW3klHQul8OAd+twozVabbDU0unZ6rIQrl5NzyJlNvqkMYpytdhXdFKFxxMN7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaYBi7Gf2rJW3DaxM2WMFZtEl9km3CSlIh1dNyisGZ8=;
 b=xbdcz1qndwfMvmJl9I8jLKt08Nt3LryNhkXSnF18ifsK0RsZ3vUbKAUAwbFTJEYm4u/8Y0edKcSOjdZuTPHdJ+bw/aVMHuJr8LvGUWZG/DQqWLFx9MJApQUF1p4MpRPXq+FbyBG8timPoGYTcUpRL/W67kKoqcL8mPJZ1ojFkCI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:05:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:05:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>
Subject: Re: [PATCH v2] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Topic: [PATCH v2] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Index: AQHZIPghp2I3vD8/IkKK0oxcK2gg4q6P2siAgAAAzYA=
Date:   Thu, 5 Jan 2023 14:05:28 +0000
Message-ID: <243B93D6-BC4A-46DD-B686-3C553716A2CA@oracle.com>
References: <20230105112318.14496-1-jlayton@kernel.org>
 <EC37F3C6-6CBB-4FA0-8C22-45220D4732FC@oracle.com>
In-Reply-To: <EC37F3C6-6CBB-4FA0-8C22-45220D4732FC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7385:EE_
x-ms-office365-filtering-correlation-id: 525fa053-7407-40d1-6af4-08daef25e66b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3whWsHbA4xl3gNwiSMV9zJyh4TfZ5pJjN3FyRFOwEdVF48vcLmXiDFIByFzryw4MPoHCFcS+LMcOK6O8vl6X/i1JEA5eUoRlXMi4O4bnMOv61JPK+ed3ljHbQntZN2H+dua6FmPrVWyg42QZD71fc1BhWXGo/JYM/Xdm3Kfe2UfhRpmybYgi3tcXGpqNFwNArLxCp5Mp9GedahxkevC4FJeXlm+tdkLfjs4fnnUCu/qB/gg6scufglk0MYWXH66JMrzU0CTgeHGL2FbGsZe0xiV4mXZozikkLopOY/xEnoVHpykhDkZ6jgNh4ziVjn+4pOm8fMNX+9WvUoNDeXnSPbz3YWw2k+bfIPMaosZPgxI+lUR+9JNJee6PhRLe4UkC+4gyRZgNj680mWx5wFe5BAGvSIJt0E4D9RNWv8Co9faaVgO0EVpnhVU+dAa4844RCk4qjHyg2EZw1A6S7vYZucVlwmbFpqffIZKr6aFFpEceoKE84YSxeCsGY6GXMuOkczeE1DAAWfRLVGf1VTCjDHbZnoHMaM2quOJc5qFYDtzEHUiiaERO1kyaE66Gqh/TdyQdZ2juyaienT0OnDHWrWqI+4MdDB4wySe+fa9eZ/wOqX62UR5E2SMZzJosORYKrvcaDe/959KMGgUmTbH1plcDLI2coZJ5JCh5Brg/3lw/Nu67kWytDpeuAxI4cawlq8Wu9V2uamwFRlcBdziWvmQHgJqwI3XtWzt1aOd4PTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(38070700005)(122000001)(38100700002)(33656002)(36756003)(86362001)(6916009)(4326008)(66476007)(2616005)(66446008)(64756008)(6506007)(53546011)(478600001)(76116006)(71200400001)(186003)(26005)(316002)(54906003)(6486002)(91956017)(8676002)(66946007)(2906002)(66556008)(6512007)(41300700001)(8936002)(83380400001)(5660300002)(30864003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?liAcYNzeGqLT1NYNeFCA5FFRhT6kKFsGHceOomkMBqsc7Q8igsPJiI8/xgrO?=
 =?us-ascii?Q?OXXRJ7N9ooOdUA05A8HF/fWvA+m5DhEJXSyxQEL8Vz60Vs/N7waUwq1+dNYl?=
 =?us-ascii?Q?fW1qPwiQcgv+tvsnZxMbuRzNKg05AH77tN6KCdYqarZ3XoZXZhsZeZ0grkPo?=
 =?us-ascii?Q?dhCrD4gPaPZ0uggCVLaFwLRJksZipShl/NJVIXoczYTmNl5wV/vKmZI1g2Ze?=
 =?us-ascii?Q?Wzx/4d9OdTnBrxywsgaM3tSZs45hP5HubqAALjoYkjtv0LZGmJBNLADM/MEI?=
 =?us-ascii?Q?Um5Y8KxT0XQytJz+wkaIL2XCrKAPhd98ADt2oVyoIsdCvIxa0BQFjfC3Nr8+?=
 =?us-ascii?Q?YFMj9VeRBf3TJGKlEf0+A1wYP31wEoLBg1D1X/nat/bYx2EOj5jGl481esRm?=
 =?us-ascii?Q?RHxALCw6ocYO1ZEwsvxY/t9qxuKtslMBdBMx762AsNa9wOTX4tPGrQS9iXyF?=
 =?us-ascii?Q?AQPvWXPAUzlyADZipjV8Xl9LJLv34is9q/4yihnWAAdy+o4cOwMJhmM/i7gc?=
 =?us-ascii?Q?uFC9TIKzJJAV/JVlUvF1PKeBbc4YrqpGYAVBtfUTadro4HPmiDrTxjAH7rLV?=
 =?us-ascii?Q?Nd1+jYxFWYiuyBlRLWKLfjsj72tmyvExGP15fdeMTuJxpWWtOSzMTn8aZy9+?=
 =?us-ascii?Q?WL/HrlyfeNnsiGmD74TQGXF4iyzqBomyQSQghJ6YOHqiCosiFWQRAztYE6ur?=
 =?us-ascii?Q?Ds6hgfyF/7SC91ryk5rtCimu0HAbDZJWYGJDYmB273xd7nYhksNXcf9jR7Po?=
 =?us-ascii?Q?WQschCCsqALP7OYhvVSKhwrFOsNcoRPKy+57wbXEoh4Ybd08UQrlGQcosoMK?=
 =?us-ascii?Q?X5ZoeiyCKCNHLz2ZixDMH0MgQqnM2cyIWUt6uYaEJGJNw2ODfrgFvcgWTDFX?=
 =?us-ascii?Q?384Cv9X4VkQrGhuGwXvEmeoCKHpQv4h6SfCfi1ACL0alM2RbUOJlz1V9If0o?=
 =?us-ascii?Q?topPr+49djXTcD3I6QlCqmvTzSx+bwuyefNWwOJhHdmjzZQAWFsRLxExLYaX?=
 =?us-ascii?Q?D+ijCV/BAHrsBQnv48hxiOsPV3Sh3iUWOE6VoJu0ctTHkAUlpQJXOIl509ku?=
 =?us-ascii?Q?2AAwS8xT0D9FdmNJNz5k+jqlTiGS8r+VxWsXQdW049J+NLQ63F6qIXwxfKQk?=
 =?us-ascii?Q?nyNch6WR+c42neIUNyg3rKr58BXnxWZ9PiVWb4vwIv852/R+7E84TLZK6mpO?=
 =?us-ascii?Q?n/QRAxtZ+RcSU4R7KZxKg3UwCeBTUKdiTyTvFgdqpSu+X6z4BqzujPl+qDrZ?=
 =?us-ascii?Q?26rFUCX42kdXQpVhZ4syNYh1fUKw2yh4onrC8GSU09SUuGVDninZ9HS80UVv?=
 =?us-ascii?Q?ZX7qPB0TH3kBg75EfgrPsYlGYP72SbmZEq94GgJXI8c83dh2ec4RrcMpJ+u7?=
 =?us-ascii?Q?MexMz0yU/B0lCUH5CiRGBEF3pjhk38q6bFWGoFwFPxJA2279+dv2plnmOhdA?=
 =?us-ascii?Q?VsCNU43sbq0TL85N4Bn1wFIdLRQnNGFXXMJ7DHukC7KBN7qWfQH2Kg5KFRih?=
 =?us-ascii?Q?AEIU/feZVBBgk7fXR55ODLpWltALpTeKcCqi85o2nbjv77SEav4SE5BmMSer?=
 =?us-ascii?Q?o4QUMO33pcdT6PNxbevvpE5J1SAaXNlBKU02qIIb1BDEPWtNaQe4nBMGqNf+?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7148DEBA338104DA73A324F798A1A6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i36B+TzhIxy3Q50J4Ki//Keyqbgm9xaeJXbZmW2FLpEDLix21l3P3QWVTIRuUGFpi+Z0qSfDYprVwLDeTmxJijlXsHJ0NGgwxhdG7pX1xkpqWAPRa4b5OdpGs9s6km+zXsuakHgCaIWzbii1P6k6Rxjo7LhcBZofOystx1iLnWkigvZDOKe9+Ai+JbXMWpDf7lZZkog7FbpoUWa3/8VaZ3HBrtGwOjXN5E7t83uN+0URQhjbbTKNmXFF2gmI4Cc0bjwBLwvytyZjS1QjtroOZTvLfi3iDRrgSoVjHo6bQsxmypxq5pyKlIB5TnbBAz/wVXgWLI8i/PF1+vE5sygdbtUV3+7k/E7/Q7ctUMV5rLILdPv6L8qrCIjTrZLEwny5qc6qnnwoXFFLwueU/AKzRDs5jhMjJbVS+mJzT2p1JufsG4A57gvx6Wc7zoFncVZ/ybMPl+7kbshsftf17ZpqUJ4CcocKjF/3MIvtesz6CReT5C2TazhTCefgdAfGv+oYMekPtlWGql1L02DWF8tdrCDigOsmxJNc0uxdASLYdJd0uEf+ossB4L7rt7M0+TYGCWqk2QFaFyQkQM2fPUfS9xnXk2rQaus5a9ChC3LcpkWtm0ywGFXFAodvOCuIKoIor8dCG8fKc0inco+lpqjJQ2PCLzhTYM0fMZyLGOru4X/TZReDd0ZbOhCsRo/SlBc9w1waPc3WnXB0oqcial3oegPSkG2/kgxivZcRD4DMFSiGQp9zBTVNmZsL6cuDzrwEdz0NlFhj2HAA5eySmNEeRF7LfWEYCVr9hdAUenJ5P/xtxcpeZlNLomQ48ORSXXOiIhgvICVAzsBfKWGdPP1ke/wO6Uyhr6hDRz5ltaBvYFmCN7Mp+8v8+byHMcahRmkkkONi0bIxewOJe27oEZMf3fBPOjCSEz0MjgdMv/bD7IY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525fa053-7407-40d1-6af4-08daef25e66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:05:28.4505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fojB/CTP51bLiB6fLlb5/MnhzArGLGu5AK4u2bCFl7D8aad1wBSW68RfRAG+T6rm3pmRNgB9oYEzBzCYBAmUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050111
X-Proofpoint-ORIG-GUID: D-NYZ7RQ8oFbZyyCJ19pi6a_0tJbyGh1
X-Proofpoint-GUID: D-NYZ7RQ8oFbZyyCJ19pi6a_0tJbyGh1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 9:02 AM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Jan 5, 2023, at 6:23 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
>> regular NFSv4 file") added the ability to cache an open fd over a
>> compound. There are a couple of problems with the way this currently
>> works:
>>=20
>> It's racy, as a newly-created nfsd_file can end up with its PENDING bit
>> cleared while the nf is hashed, and the nf_file pointer is still zeroed
>> out. Other tasks can find it in this state and they expect to see a
>> valid nf_file, and can oops if nf_file is NULL.
>>=20
>> Also, there is no guarantee that we'll end up creating a new nfsd_file
>> if one is already in the hash. If an extant entry is in the hash with a
>> valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
>> the value of op_file and the old nf_file will leak.
>>=20
>> Fix both issues by changing nfsd_file_acquire to take an optional file
>> pointer. If one is present when this is called, we'll take a new
>> reference to it instead of trying to open the file. If the nfsd_file
>> already has a valid nf_file, we'll just ignore the optional file and
>> pass the nfsd_file back as-is.
>>=20
>> Also rework the tracepoints a bit to allow for a cached open variant,
>> and don't try to avoid counting acquisitions in the case where we
>> already have a cached open file.
>>=20
>> Cc: Trond Myklebust <trondmy@hammerspace.com>
>> Reported-by: Stanislav Saner <ssaner@redhat.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/filecache.c | 49 ++++++++++++++----------------------------
>> fs/nfsd/filecache.h |  5 ++---
>> fs/nfsd/nfs4proc.c  |  2 +-
>> fs/nfsd/nfs4state.c | 20 ++++++-----------
>> fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
>> 5 files changed, 38 insertions(+), 90 deletions(-)
>>=20
>> v2: rebased directly onto current master branch to fix up some
>>   contextual conflicts
>=20
> Hi Jeff-
>=20
> The basic race is that nf_file must be filled in before the PENDING
> bit is cleared. Got it.
>=20
> Seems like -rc fodder, and needs a Fixes: tag.

In other words, maybe it should be rebased on for-rc, not for-next ?


> However, I'd prefer to keep the synopses of nfsd_file_acquire() and
> nfsd_file_acquire_gc() identical. nfs4_get_vfs_file() is the one
> spot that needs this special behavior, so it should continue to
> call nfsd_file_create(), or something like it. How about one of:
>=20
> nfsd_file_acquire2
> nfsd_file_acquire_create
> nfsd_file_acquire_cached
>=20
>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 45b2c9e3f636..6674a86e1917 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -1071,8 +1071,8 @@ nfsd_file_is_cached(struct inode *inode)
>>=20
>> static __be32
>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		     unsigned int may_flags, struct nfsd_file **pnf,
>> -		     bool open, bool want_gc)
>> +		     unsigned int may_flags, struct file *file,
>> +		     struct nfsd_file **pnf, bool want_gc)
>> {
>> 	struct nfsd_file_lookup_key key =3D {
>> 		.type	=3D NFSD_FILE_KEY_FULL,
>> @@ -1147,8 +1147,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_=
flags));
>> out:
>> 	if (status =3D=3D nfs_ok) {
>> -		if (open)
>> -			this_cpu_inc(nfsd_file_acquisitions);
>> +		this_cpu_inc(nfsd_file_acquisitions);
>> 		*pnf =3D nf;
>> 	} else {
>> 		if (refcount_dec_and_test(&nf->nf_ref))
>> @@ -1158,20 +1157,23 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>=20
>> out_status:
>> 	put_cred(key.cred);
>> -	if (open)
>> -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>> +	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>> 	return status;
>>=20
>> open_file:
>> 	trace_nfsd_file_alloc(nf);
>> 	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
>> 	if (nf->nf_mark) {
>> -		if (open) {
>> +		if (file) {
>> +			get_file(file);
>> +			nf->nf_file =3D file;
>> +			status =3D nfs_ok;
>> +			trace_nfsd_file_open_cached(nf, status);
>> +		} else {
>> 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
>> 						    &nf->nf_file);
>> 			trace_nfsd_file_open(nf, status);
>> -		} else
>> -			status =3D nfs_ok;
>> +		}
>> 	} else
>> 		status =3D nfserr_jukebox;
>> 	/*
>> @@ -1207,7 +1209,7 @@ __be32
>> nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		     unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
>> }
>>=20
>> /**
>> @@ -1215,6 +1217,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> * @rqstp: the RPC transaction being executed
>> * @fhp: the NFS filehandle of the file to be opened
>> * @may_flags: NFSD_MAY_ settings for the file
>> + * @file: cached, already-open file (may be NULL)
>> * @pnf: OUT: new or found "struct nfsd_file" object
>> *
>> * The nfsd_file_object returned by this API is reference-counted
>> @@ -1226,30 +1229,10 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> */
>> __be32
>> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		  unsigned int may_flags, struct nfsd_file **pnf)
>> -{
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
>> -}
>> -
>> -/**
>> - * nfsd_file_create - Get a struct nfsd_file, do not open
>> - * @rqstp: the RPC transaction being executed
>> - * @fhp: the NFS filehandle of the file just created
>> - * @may_flags: NFSD_MAY_ settings for the file
>> - * @pnf: OUT: new or found "struct nfsd_file" object
>> - *
>> - * The nfsd_file_object returned by this API is reference-counted
>> - * but not garbage-collected. The object is released immediately
>> - * one RCU grace period after the final nfsd_file_put().
>> - *
>> - * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>> - * network byte order is returned.
>> - */
>> -__be32
>> -nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		 unsigned int may_flags, struct nfsd_file **pnf)
>> +		  unsigned int may_flags, struct file *file,
>> +		  struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
>> }
>>=20
>> /*
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index b7efb2c3ddb1..ef0083cd4ea9 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -59,8 +59,7 @@ bool nfsd_file_is_cached(struct inode *inode);
>> __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		  unsigned int may_flags, struct nfsd_file **nfp);
>> -__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		  unsigned int may_flags, struct nfsd_file **nfp);
>> +		  unsigned int may_flags, struct file *file,
>> +		  struct nfsd_file **nfp);
>> int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>> #endif /* _FS_NFSD_FILECACHE_H */
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index bd880d55f565..6b09cdd4b067 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -735,7 +735,7 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>> 	__be32 status;
>>=20
>> 	status =3D nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRITE=
 |
>> -				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> +				   NFSD_MAY_NOT_BREAK_LEASE, NULL, &nf);
>> 	if (status !=3D nfs_ok)
>> 		return status;
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 7b2ee535ade8..b68238024e49 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5262,18 +5262,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst =
*rqstp, struct nfs4_file *fp,
>> 	if (!fp->fi_fds[oflag]) {
>> 		spin_unlock(&fp->fi_lock);
>>=20
>> -		if (!open->op_filp) {
>> -			status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
>> -			if (status !=3D nfs_ok)
>> -				goto out_put_access;
>> -		} else {
>> -			status =3D nfsd_file_create(rqstp, cur_fh, access, &nf);
>> -			if (status !=3D nfs_ok)
>> -				goto out_put_access;
>> -			nf->nf_file =3D open->op_filp;
>> -			open->op_filp =3D NULL;
>> -			trace_nfsd_file_create(rqstp, access, nf);
>> -		}
>> +		status =3D nfsd_file_acquire(rqstp, cur_fh, access,
>> +					   open->op_filp, &nf);
>> +		if (status !=3D nfs_ok)
>> +			goto out_put_access;
>>=20
>> 		spin_lock(&fp->fi_lock);
>> 		if (!fp->fi_fds[oflag]) {
>> @@ -6472,7 +6464,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp, struct nfs4_stid *s,
>> 			goto out;
>> 		}
>> 	} else {
>> -		status =3D nfsd_file_acquire(rqstp, fhp, acc, &nf);
>> +		status =3D nfsd_file_acquire(rqstp, fhp, acc, NULL, &nf);
>> 		if (status)
>> 			return status;
>> 	}
>> @@ -7644,7 +7636,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqst=
p, struct svc_fh *fhp, struct
>> 	struct inode *inode;
>> 	__be32 err;
>>=20
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>> +	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, NULL, &nf);
>> 	if (err)
>> 		return err;
>> 	inode =3D fhp->fh_dentry->d_inode;
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index c852ae8eaf37..7c6cbc37c8c9 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -981,43 +981,6 @@ TRACE_EVENT(nfsd_file_acquire,
>> 	)
>> );
>>=20
>> -TRACE_EVENT(nfsd_file_create,
>> -	TP_PROTO(
>> -		const struct svc_rqst *rqstp,
>> -		unsigned int may_flags,
>> -		const struct nfsd_file *nf
>> -	),
>> -
>> -	TP_ARGS(rqstp, may_flags, nf),
>> -
>> -	TP_STRUCT__entry(
>> -		__field(const void *, nf_inode)
>> -		__field(const void *, nf_file)
>> -		__field(unsigned long, may_flags)
>> -		__field(unsigned long, nf_flags)
>> -		__field(unsigned long, nf_may)
>> -		__field(unsigned int, nf_ref)
>> -		__field(u32, xid)
>> -	),
>> -
>> -	TP_fast_assign(
>> -		__entry->nf_inode =3D nf->nf_inode;
>> -		__entry->nf_file =3D nf->nf_file;
>> -		__entry->may_flags =3D may_flags;
>> -		__entry->nf_flags =3D nf->nf_flags;
>> -		__entry->nf_may =3D nf->nf_may;
>> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
>> -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>> -	),
>> -
>> -	TP_printk("xid=3D0x%x inode=3D%p may_flags=3D%s ref=3D%u nf_flags=3D%s=
 nf_may=3D%s nf_file=3D%p",
>> -		__entry->xid, __entry->nf_inode,
>> -		show_nfsd_may_flags(__entry->may_flags),
>> -		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
>> -		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
>> -	)
>> -);
>> -
>> TRACE_EVENT(nfsd_file_insert_err,
>> 	TP_PROTO(
>> 		const struct svc_rqst *rqstp,
>> @@ -1079,8 +1042,8 @@ TRACE_EVENT(nfsd_file_cons_err,
>> 	)
>> );
>>=20
>> -TRACE_EVENT(nfsd_file_open,
>> -	TP_PROTO(struct nfsd_file *nf, __be32 status),
>> +DECLARE_EVENT_CLASS(nfsd_file_open_class,
>> +	TP_PROTO(const struct nfsd_file *nf, __be32 status),
>> 	TP_ARGS(nf, status),
>> 	TP_STRUCT__entry(
>> 		__field(void *, nf_inode)	/* cannot be dereferenced */
>> @@ -1104,6 +1067,17 @@ TRACE_EVENT(nfsd_file_open,
>> 		__entry->nf_file)
>> )
>>=20
>> +#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
>> +DEFINE_EVENT(nfsd_file_open_class, name,					\
>> +	TP_PROTO(							\
>> +		const struct nfsd_file *nf,				\
>> +		__be32 status						\
>> +	),								\
>> +	TP_ARGS(nf, status))
>> +
>> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
>> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open_cached);
>> +
>> TRACE_EVENT(nfsd_file_is_cached,
>> 	TP_PROTO(
>> 		const struct inode *inode,
>> --=20
>> 2.39.0
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



