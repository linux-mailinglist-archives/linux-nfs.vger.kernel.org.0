Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF152636AA3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 21:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiKWUOz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 15:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiKWUOy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 15:14:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAFBF60;
        Wed, 23 Nov 2022 12:14:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANK6m5F003902;
        Wed, 23 Nov 2022 20:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8w87ml+5EsZLRf2JzLCzEXeWl2ZDaU4BLREnCjGW3h4=;
 b=oYzqlBlD/8cwuiqICYgUrKkek43+YGj5kI7kWPWJD0kgN14+4t7QMDfRy52NW+iIEyPy
 egYw6lYyGMeTdFP7a0H5eIdaAkeLvgYdsXuT1Ow6J3lYM+vbWFuoZ2D+2omt3CAioZhl
 4gpBaibWGqSzZDrsAsx1wG2E+/QQul8JB4yo6jR2NkpdbcaMwRMGf397BQtxTP9nIRh0
 gIMCJKVyaBf84NfCunaV/3fArKwL4JnPhsgfCRcelDaHfbGkA67FdgzTxSMZ/y1xZmx6
 0qkkH2aOuoeozHK0nQxcPWxPNcvS9diaQdx9vTBOzEtQ7QSvRXvmy8IJ2Pnqzf7DqvZ4 bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1svgg27t-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 20:14:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANIuNh4034855;
        Wed, 23 Nov 2022 20:05:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkd479c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 20:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9vZ7h5xF2pV8baaFVZCCE3Si2k2dn4sKxNi+grtBR6WKv7mmIfODcY7X7/i2k8Rw71wwbw3G8yiIx5u377Th1gyyf67CJGg+PhWz0Z6Ql6E3qd68SIvJ/zM/KZdDh+dshe4B7csZ/rlxx2ZUKdfIT3fY6Ea2o9FgK/5cE4cqgq8xtbClXOCl4xqPJ6F54b5WCe426rO1uOVmvc2Np79xRixXUj/gWJrELiP2+Iz+QYFUEu5RmyGne9Gd/qlGH7d9otOwRrsSdKxdTbr9CSak9FdxOmRk6LfNnS6+UC1MEHqjV+L/vFDUyJSDMjJkyzdgZPeb1AyqB80jR4XuDhbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w87ml+5EsZLRf2JzLCzEXeWl2ZDaU4BLREnCjGW3h4=;
 b=fxc7s6XYNMHqYdPiexLkm/fcPHrGw8oprYhUGPKxlYAvVz6IL/qCtylJJRMr15Y5dLfoIiWzrvJCTg4/fra79MiaBgy6vbw1FbfVyNnlV8ep40e2cHNYsDiB1PHpwPtOrad1mZOs3y88sDsvMlpQ08tefjPh0yzxZ1cwhpUJ9XCfXFpXwwlueYuONH8QPFTMWbTeRj9y71jKfRvElbe9ZPkhxFRzxROKmiOTgHnw7CJVkiYgFbQRGHTQ3MlpL8pt6wrZ3vQYRnaMLYn8oEKPCiQ/a0oAUmmiSYRstfb2ogr4WIMEF9I7jRBrFDSFmFt7UpJE99C6uyKIOweOI3tGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w87ml+5EsZLRf2JzLCzEXeWl2ZDaU4BLREnCjGW3h4=;
 b=GB+WlWzw8oFKxMkwpwmkC0uQOIu5CI0tU0SZ/ayAaGHvI4TBD3vWrYfbf1lqg8F8rkDSrnyhSnwPflxl312BFCO87Zo/54xSpuYeaoSvj4mU8zWWXbmfNR9U/nIAG5OYxmBeuzFZ6uXn03/m0bXkg/1V10MfbkZ3Yk9dr1ld8Zk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6403.namprd10.prod.outlook.com (2603:10b6:510:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 20:05:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 20:05:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] trace: Relocate event helper files
Thread-Topic: [PATCH v3] trace: Relocate event helper files
Thread-Index: AQHY+pDawo+ItAT0Q0Wa9gN3wMKjXa5JfgmAgAN6CQCAAAC/gA==
Date:   Wed, 23 Nov 2022 20:05:48 +0000
Message-ID: <A3FB5153-CAE3-40B9-9292-483F80048B93@oracle.com>
References: <166869513208.318836.8777065369440403777.stgit@klimt.1015granger.net>
 <8D18C977-79DB-4D03-B435-77B395A07ACE@oracle.com>
 <CAFX2Jf=RooMc9G9a2s0rnrzY9NW6Q+JXb7dvkeG9Vq9YOOzO3g@mail.gmail.com>
In-Reply-To: <CAFX2Jf=RooMc9G9a2s0rnrzY9NW6Q+JXb7dvkeG9Vq9YOOzO3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6403:EE_
x-ms-office365-filtering-correlation-id: 8e932e11-3b6a-468d-dc49-08dacd8e1d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMF0oFmSc4JGLkB8XTFN0ADQOxTSbZvnuRK9U46TZ6l97nsfNwkFJrimCSiEILY1FRn2WQR0GwIal3tj7UsHm/uoS9f4MYzgFCEfSfvq9yeFQkGxF3uF/DX4CDHYEJL4Pza1EXiEjVGL8/8KnM2npGFOd6EzcrSsjY9NLx9zoazeb3UL04YmwlYhrjL5U6gWA2V8DXJYfQ8DZ79bjGNymNmGWWjuKv/D2ssZnPvEZgxNPLnsrb2b3dA6fEfj+NggTMYqi3p6rRHssmV121XPkVSRUng9AJVF5Lg7lE8so7VV6X7ebDsI69107bRjxfLBVX/SVB4hDnHt/W0N3e31aux1/vwNPwDFILWt9hvpH4LKvSEZcZ8CxHjRRqHxi16NUDoBMVyZgrzG24uJcP+MVaWyL1O1yrByiDr005jcYfmCCYfmulJM2pK6kimttPnjNOg6tA0/Uo8wRS/WTQVU74q1YiNA3exrUu1amp9DJmmSGNwlOyv9jx8su8c7aUhm3WohohSy+5pKhS0MAJmNL3kAoAfCNlmTez+Huo8TmS+5ti2Due83PKiNtyOeoPjP6RJRbbO59zPsmRwONyur9dksb2cF9o7BaOw6uU5XmgDa1Dn6sqF2k86wAKi6TYxa/EtOLPYn5lrJypo7ePjlTmPl2sX33LsRS7ksqUEna50LO1oLER0FH58yDmOsH3NtErpPrvtYKGNqBn97nMRlOhLiWMKdofVJCi9GpOQ7ySI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(6506007)(71200400001)(478600001)(6486002)(53546011)(54906003)(6916009)(91956017)(2616005)(36756003)(41300700001)(64756008)(66946007)(66476007)(66556008)(8676002)(4326008)(76116006)(8936002)(5660300002)(66446008)(6512007)(186003)(83380400001)(2906002)(316002)(26005)(33656002)(38070700005)(122000001)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7U0gJdWK9Jsci/tLXWMFHGY3u/aFjBOL4hf+QrzXWpjL7ku2Om54ThgGCjMg?=
 =?us-ascii?Q?Qz1DJ3sk+kjYRCC/3SBy28kpkmjSkavfxmefqFLqmlBs4UixDj9lwCeUZHgq?=
 =?us-ascii?Q?qiRaOL986exSHGCU0946pfG7Q9cEUlDbyhTnVHgNKGxcoJph7SJMd/Gvq2cZ?=
 =?us-ascii?Q?UkBsGa3Z9P0HxKCM1f7hzRHxZj+uToJO9uWIjc7aD8lO6QBJ9oHdCz7MhCML?=
 =?us-ascii?Q?5j+j6Qi+RZvFKVKzjTlxI+W5gOUjDDWo9BUOYluV/VxJp7le1F8DluV3rVTZ?=
 =?us-ascii?Q?6g03ZN543Sc/qcUCzAKkQKh7jBfpOOTz0pzzsF/iprtd6eZmVidyccPHscZ4?=
 =?us-ascii?Q?hUOCGPAU3TpJgcbP1c68csq7480DLog3ibcEOCiQ1zL8LaL3Orm1cNRX83Cd?=
 =?us-ascii?Q?hRgvHmG/pVeyurCjVWTHZmB+D6Ff3yL7zLVYYIFyOSNewKojQH0//cjeVAi3?=
 =?us-ascii?Q?MPnMo0abKBdW196CVxj3eJjE6iog87z2rxJJWB5T5/WYeUlZ9Phy4R64jny7?=
 =?us-ascii?Q?JxckyvM3lN9ZSlV80UFuzpX8QyoeAwQSzl5K0Zo9YRpwv/Yra8oVb7fcJdZ9?=
 =?us-ascii?Q?ZXL/LI24eubyifPJC0oha5cWjcAZWW+raIrI69qdsIhCLBwl0lSEzjTRDOeY?=
 =?us-ascii?Q?oxvcS5JBFabzQBS+NhY0NgWrMhr8WzXkoN/vrygJzy7Mu1lx16N+lM+3Tysg?=
 =?us-ascii?Q?6gAYb59ewtBQh9SRNOHoB8ARohh5xERRC0A9T4m6TOhp20IYHLgEBaPIGNIV?=
 =?us-ascii?Q?K3zk0CB7cQ5LFZjsx0ECKEXgM6Tgc3a0T/lgQd8XD+w5MGd78vaeVsJKJg1L?=
 =?us-ascii?Q?n4nX/02Bp8hrD7BrcR0wma9F5IoCJlcoe+sP2mWjA2v5hjGWmGOxUj/cyuLt?=
 =?us-ascii?Q?4WiQv+aR0V6VEJ4guEX2Spsh1Ep6hSJ0BThpo3oNy9xGTipz4oVLBDwSIsaS?=
 =?us-ascii?Q?0aaMUQDIth0lahGB40sMkub5xw+ectEX3hDLBxeH1CTEt1MIilY3t4tzeRy2?=
 =?us-ascii?Q?Kt+74tYztfQk7bOhzXtMJgP/9Cvvh75u2MUxAEj2c54bSFij+cgDbJRkvgon?=
 =?us-ascii?Q?G1nw1/8ISy4a0wg64tPJJqaQ5m0TvTB+fzUPqSrYu78bzDq6wcIKnP6Q0Y6b?=
 =?us-ascii?Q?ZwH1kiwWVYVKUg8lSWMB9SZg99fVkGchABDPNJNobn9r6Jzflh3JezUkNjEf?=
 =?us-ascii?Q?zfak6WErjw2GOn01NloNee7mnullEYvQuMICRYStcuubojBYRHljVubgAdA2?=
 =?us-ascii?Q?VDekQbFMfFet8hkEOi+bflUjnhj6YwYcK0GkXC9YwH9aS1axHhKVWLk1/rd/?=
 =?us-ascii?Q?HggD2/dcge0F4V25uviG+21PRaFRkG7F1vLftsoSS3JXItaR9fRXGtDovrM8?=
 =?us-ascii?Q?/+GmPdxUXMT0n8R4Jbt4TXPeEJGSMQ/CsEnGZy4Gu2CR3AHmpqIQvYHQBHpM?=
 =?us-ascii?Q?PRoJghF2h/oUaJovDxN3q++p9/icgVNwgZIc8IvCD/ihAWUykMwRncHocOgq?=
 =?us-ascii?Q?LB0mCEl2nA9amMuVR3aWfdcugECr/YwY3xQE4HclmlwMkbSEVQN4Xo1BHaxG?=
 =?us-ascii?Q?4tuudF4Cdnk7XreMNDDkNF91n7+2uRz6oRWKqAe+gbEseoydH7oQZ89nksvv?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A930F5DDBA26264AA61126A0218A19B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qJ+gHCaxUSgz3LjQdp7p0CMNlFFdD5hWMR/+f8bBX9PvlOvphMGmok4tD8hO?=
 =?us-ascii?Q?y3OVweEZ1w/CpJRpnMcNaWeZbyK0ZuUtY+7ODtW7RPVygMoPDpgZsAM3Rgee?=
 =?us-ascii?Q?t8t/sSmRGqC7SS0JiJ1Z3qZn358Skl4W7h6hu6oZ/bOJRCPlwRBHzqMNn+vL?=
 =?us-ascii?Q?uGMRbALfdjCPI1kzyPc0PWZidqYfotDB4qMrF5Xi7I+8h1+/mrva/AP+gbt1?=
 =?us-ascii?Q?R38Ul7tblKGZ9idyHUvMGT6vHXQU/6ZyyTDilraseKDUPKffMyzAfMiid28K?=
 =?us-ascii?Q?VjRtv3ETe8eoXKvzUWl6dzJknw/l8MyfjHrRRyTbQePRwiajlo9qVpyniIxF?=
 =?us-ascii?Q?bFeBSFqnGXnPKYNIhizBbFZ4maf8cY82LafwbcGKkWFJxnDq1GEOjil+2nyE?=
 =?us-ascii?Q?ElVuxabJpzfXYshb497O6qB08Wfo6M811bccAEGEvAs+V8fkksSlmHAYVs6Y?=
 =?us-ascii?Q?dsF/i7SrX/hihGFyMy5qbK4L3qNllPLfl2OhVnfnb0+PzBslx9qVN8b+qe+N?=
 =?us-ascii?Q?e+/QDdWo9sJy7UmwYwOJghQu9pBzQLZiZ9P1n8WBlCGxPYn2aXlRMAnmECP7?=
 =?us-ascii?Q?AKxKEgWaWDTqSloWWAAcfOIfF/rSbxFn3CoxEUn5tByqgWlgErdEn8zGEtFH?=
 =?us-ascii?Q?SRRtCMUQ4kEIPBDhivMIkMuyn48B13VLLUPiA/XSSgFTodrCUv4lsaoN5j3H?=
 =?us-ascii?Q?HlmiuvtG+lHf/H8Yw6M7t1v26o3ljJGJs82yhTdMEbO55q/bR1wOxJa12z39?=
 =?us-ascii?Q?EFpDyJFMgy1ED3Wbqs7mSNBLf4ME+TCJnleIKTb52x3bEjvK40PqV9aGtjij?=
 =?us-ascii?Q?aRX8OdXlB3FXDOiMhobPy4WE2VFkQYvKQdVs5BYY6KHDeGG9aJySEDaLKWQm?=
 =?us-ascii?Q?4AEH8EmjSB19fHuKrNpykYp+YnhUjSr7kaUpEO8oUdHMiPkg9u7+UlVBBM++?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e932e11-3b6a-468d-dc49-08dacd8e1d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 20:05:48.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbNAvPUWiKKdgyM6kphJXFXeDSa+sit7hbDWyA/uYQUIyYv1xuwPbqX8z7bMJU4I7rRd4NODhwz9wCYTEiagTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230149
X-Proofpoint-GUID: 1R3wH4orYkmYL2belmiy9qylKOEOmPOb
X-Proofpoint-ORIG-GUID: 1R3wH4orYkmYL2belmiy9qylKOEOmPOb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 23, 2022, at 3:03 PM, Anna Schumaker <schumaker.anna@gmail.com> wr=
ote:
>=20
> On Mon, Nov 21, 2022 at 10:15 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>> On Nov 17, 2022, at 9:27 AM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>> Steven Rostedt says:
>>>> The include/trace/events/ directory should only hold files that
>>>> are to create events, not headers that hold helper functions.
>>>>=20
>>>> Can you please move them out of include/trace/events/ as that
>>>> directory is "special" in the creation of events.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> Acked-by: Leon Romanovsky <leonro@nvidia.com>
>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> ---
>>> MAINTAINERS                         |    7 +
>>> drivers/infiniband/core/cm_trace.h  |    2
>>> drivers/infiniband/core/cma_trace.h |    2
>>> fs/nfs/nfs4trace.h                  |    6 -
>>> fs/nfs/nfstrace.h                   |    6 -
>>> include/trace/events/fs.h           |  122 -----------
>>> include/trace/events/nfs.h          |  375 ----------------------------=
-------
>>> include/trace/events/rdma.h         |  168 ----------------
>>> include/trace/events/rpcgss.h       |    2
>>> include/trace/events/rpcrdma.h      |    4
>>> include/trace/events/sunrpc.h       |    2
>>> include/trace/events/sunrpc_base.h  |   18 --
>>> include/trace/misc/fs.h             |  122 +++++++++++
>>> include/trace/misc/nfs.h            |  375 ++++++++++++++++++++++++++++=
+++++++
>>> include/trace/misc/rdma.h           |  168 ++++++++++++++++
>>> include/trace/misc/sunrpc.h         |   18 ++
>>> 16 files changed, 702 insertions(+), 695 deletions(-)
>>> delete mode 100644 include/trace/events/fs.h
>>> delete mode 100644 include/trace/events/nfs.h
>>> delete mode 100644 include/trace/events/rdma.h
>>> delete mode 100644 include/trace/events/sunrpc_base.h
>>> create mode 100644 include/trace/misc/fs.h
>>> create mode 100644 include/trace/misc/nfs.h
>>> create mode 100644 include/trace/misc/rdma.h
>>> create mode 100644 include/trace/misc/sunrpc.h
>>>=20
>>> Note: with an Acked-by from both the NFS client and RDMA core
>>> maintainers I can take this through the nfsd for-next tree, unless
>>> someone has another suggestion.
>>>=20
>>> Still missing Acks from the NFS maintainers.
>>=20
>> Nudge.
>=20
> Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

Thanks!


--
Chuck Lever



