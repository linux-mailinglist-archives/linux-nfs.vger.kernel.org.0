Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3B523A4B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiEKQ1p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbiEKQ1o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 12:27:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC4666A2
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 09:27:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BGKD2n032663;
        Wed, 11 May 2022 16:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n/VhmoHZfrc5OOMaMCMNKTygTmhpQlr339VO+JMoWj4=;
 b=vXoqqdy7Locq16eGK68dmqLrIyAdCMS6n8zovz3517f4xiKE56TOn9BuSQQUlND2oLdw
 t++ZvzNiAcg6ACe9ASLDoPCifKgJFbjbtQD5Hh2wesl5gtyTAFf7CiYV2E0iWr7OZQUk
 jLeXvPcZbrhaB9+sByaOLPK9wuGZ7rTVB/CwFSA/0IiJ8jk3dkK8Zf8yyTBlUtt3bT8/
 cyJ+IEsQYHKucrqm3PV6zNkujbIGZYp/ECMms78y1jkFBvqVKnjjRHOve0LId19sPWWX
 mLpSvhOj4REZgKu1QmpjwVmjaFUvHeGzGOQvf8ARjO2caH1x42OKQeAi84g4BabHaR3+ cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatjdpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 16:27:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BG5UUM027290;
        Wed, 11 May 2022 16:27:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73ttm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 16:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkUuhTLDW94UJd8tVlP+ijWm0i98e3CSB/E9/5G0DCJ0ORra8L6KEVFgPicHPkistl/AMR3gg+B6UZ3edTaM4tapGVPOn9FgOl+Fs60Fp8zo7mOZqWrVZlH8QNeywXQsWJjBlosHoujVaXcYEeV2voFzeaF72nFIR1mDmYfmzbd0tiMmfsRfQPwXdMwHNzHPGO7fLwL/W6KjVAivgX0MvOXp7p8juuYALbcza/R10RvSf709FbRGdVT6v96xpo79ydUiAGufR7lCvb+6wT3yHv7yESm+FNFDvdmH7Cv9YE6Ty4Tb31Ybi7rzK5xwN7rSDBxdveYeAPotFMMyVvk7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/VhmoHZfrc5OOMaMCMNKTygTmhpQlr339VO+JMoWj4=;
 b=aC0i59qz6E6w5hmFx6MNLH21Qfq2qHLcQ1yksPZzfOgsML2NqgFz7ocNYpbbm2r5pOhqEjLM18X9BbrJSzW/18+DGHGEV2Ll/j6J4f+NgBDRTwN6jYxUi1A9nZmH6P5vo0tEbvtgaqgxHx+OWAT6mUCXAqoQMC6qECHmevaBKN26kWrT1VzWFctcO1qDm5xGftATwsczfqy5K17gQbKrjPDWhGVd9aOYHHdQKUGQYW5Vcj3lnNoY5ocwMuMFB70YGAcEWUxkUCkTymUzXRcLz6L2u2Dq8xMnTRlCBLE9EOkDb88GzCowgiE2IEthIexuHSaz04xmc5+5i9OsN1Hfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/VhmoHZfrc5OOMaMCMNKTygTmhpQlr339VO+JMoWj4=;
 b=YEQmZYGXX41XbN5GZW77fcyWPp7iO2YBBPdFRlysahJ2OWYSJITQJ7TyvbM2nV0YpqH0RGzo5i+NSA6Cdqk6ZhJZk/rmeGPgKGZgAcrCj0Rma857k6/X09Dskit5nDiLx9rSSg6UfJecJNsSf3bHsqqk+iJQLKrS3nurlCTP5b0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 16:27:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 16:27:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0YNS4AgAGbVYCAABRRAIAABPOA
Date:   Wed, 11 May 2022 16:27:37 +0000
Message-ID: <342BDD54-5EF0-47BC-8691-E89148B085C1@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
 <2BC5058C-FFEE-4741-9E51-4CC66E7F6306@oracle.com>
 <6942e1963dd3548cb9ba5d8586bd3913beb1ad45.camel@hammerspace.com>
In-Reply-To: <6942e1963dd3548cb9ba5d8586bd3913beb1ad45.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1120920a-822a-44cb-5022-08da336b291f
x-ms-traffictypediagnostic: SA2PR10MB4761:EE_
x-microsoft-antispam-prvs: <SA2PR10MB47612C94060DA007F1A5993593C89@SA2PR10MB4761.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9lssPoz80gAIKbSjfi2VZwE3KO+C7Xv/rLPo0V3xxdcGMQ1Z5o0Wr6eMtyqbhDnWhU/MMgD8ib9lCrcCjbSB+ch3JM5+zL1NxvV6L1T3/OHQVkiTA+DubnG0m8Zh2jlk30/g81iUCrCbxkxf1R1ZbQgcPd3TYmCegyLLkx5YygRJKmuDZSBx5j5zkysXDJTIGZ5vSA1eSNUmTSKeVg8nuREQDr7Bs5ZGd4BSOOh7oSSr+argua+7F2FxrPxji6C+GYQK7ZfSZrzZMK75jFzutnKnZ3Lzs6rVBxHGlRivtNNqHQqkfyUTKosfBWRf67hqQeX5l5c0v4+Tbm0kuAzWYA4dhw+Y4149W+Xy2FZUayffWdTkgNvS74VCYyPTROD/Ogh2uZ0sFM1l28xn8qp/NS7O1ig8O1+cGR31RhlRqj8fnps5glU4VxjpxEleP0lyMDZv6ULCvGLycazPFazJlL4WQDxt9WSehGEUIPEldhaO64ePO1K0WIxKDyYsJqAkB3BVqyf7B7fG2NTaIw65nrG3VrVVhzysJepILrTuwbPwoWpgb2Le/Rsf+WI9mhuf0Y1sJ0vza+P5PW1n9tPhkjStKzd0JGOZStOYAkdUfQPI+Qv/+YxPuF3QpfcKPOzJDO4apzOnPKekowSKZ8O4bdwqEtNtWxe9HCCQ6O5YSbrXyrEga0ZVslULoz1ZaxaAeFAgsqZDS00YpWRGGl70gVKPwoL76wZrhGQsK7ToV7HpluQ7O4XBRwCQ7jqqBgU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(508600001)(33656002)(76116006)(66476007)(2616005)(45080400002)(8676002)(64756008)(66446008)(91956017)(186003)(66946007)(66556008)(107886003)(6486002)(86362001)(71200400001)(6512007)(26005)(316002)(54906003)(6916009)(53546011)(6506007)(8936002)(122000001)(2906002)(36756003)(5660300002)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4dMUL/gtRuW7WPs6mNBSdFIAFyZKJIzwYTevBpWzbdz0GGNNgRcF9aAgdojK?=
 =?us-ascii?Q?6c031CI4PPrQsikuIloynp38lYWzNJxKezs8j/ZRA85TUTcE1fddNeJjKL2n?=
 =?us-ascii?Q?Jq+HznMSQJbz57yUstSMFOuPdVYtpHwCQLsqnUV9dql5MNu505nsP4PfULbl?=
 =?us-ascii?Q?ta0MTSQ6PcpMPu7MI0ihik2gg/DnbP6G/c8/LT8rNRQHFRuJ4n9EsPJaTEug?=
 =?us-ascii?Q?Xsr2bssw/P0qOJ1BUE+dk2Z00FUDaGP1o9YASByw+rPV5os5EfUJ25TFOE3A?=
 =?us-ascii?Q?iGVLPdRtL4N4bh4lzEkTAeM6MWjpSkCGq5G4hApbsh5NvCp1XxSXMZWbMhGD?=
 =?us-ascii?Q?5mf5fKGnnCjkXOUefwTbXD76kGZWydmLH4J06fY+dntvkFVVhoLJm/ZtiN12?=
 =?us-ascii?Q?jDLOI2AOtdGE++YVohoNQbpwdvDC5Nr79BRfK0+xFJxki0K0chkVxj1ePzp/?=
 =?us-ascii?Q?ldjawLMHvkzZwuKsFkO9RAWhQAP+OlW8mkQNkNOKbEhUSuayK7FzNENoaYjt?=
 =?us-ascii?Q?gQhmXGjZ1Gd4ecSsd9C0tAxmWWlv6eszQYoPw8kQ6oXzjm/TwKQdcJyu8OrO?=
 =?us-ascii?Q?VmcfVcA++eAQmKgYJsgPH75GzE9r93coGIMIBRHBPCbQ34ZuqrtgZxQ28F3N?=
 =?us-ascii?Q?FtvtoITqJrqehDsOqaZTm9SXo09gNODrnn7cwjC/tZMcrMlK4CbFDdkyDvNs?=
 =?us-ascii?Q?bXpaA7sVGZRrlleeURYlKSl4qiLiVeNDBHSJaEdDzH98iSfRIr6C0Rr8E/5E?=
 =?us-ascii?Q?tIhnSMXV7gihzSH5NnJpbQaQYVfBLp62BunZ2kdB4goHM6kdtHAr/Ny3Acwz?=
 =?us-ascii?Q?Efz2m8NUzOc/2ZWk4HF4M7Lc+ggashuMoPAY/+CbbqflertOIVs5nEZhIvPa?=
 =?us-ascii?Q?6AVD2q+paSrMuw7mnekwliOtug/3uYPzcbMUAdy1+eCU8Ujye2m0lo2448JT?=
 =?us-ascii?Q?5SXY0k+QwOTt5L5xwkiPr1bdjful/kDXLrCQL6VVhqxGqerdb6PaVsMjo6gz?=
 =?us-ascii?Q?V8AjiIZqpkmH4CieJ3vPU2ZbVDlrXyFpiBAAJluWSb0GYVDOjuBOXZb7inlk?=
 =?us-ascii?Q?5i+8oeDClGkq6dN8XR/L+23AHrpiGCkjTCDUShUN1VI104AzUyDbqpUuSCLF?=
 =?us-ascii?Q?nZGGmNYujYipKvEVh+az8uUQqkwTPm053S1+56EcTz4V/mzdZLE6zDqSCD3p?=
 =?us-ascii?Q?q8Rbjp00wzMMP5mT7TiRidHEFWWQCofUjx4YoDQvZy+GXKp7wnbCGY0zlaha?=
 =?us-ascii?Q?xTrfbDtW8v2RNVIWos/PSCEwu83Q+fQM0KCvYVAgBoP3DV8PS/Te9d/AKYvV?=
 =?us-ascii?Q?4yN7wnCriWAN0TFWBIb+aLVgwfEo+PSHJ30s9rHNTIYiCM52+eB+kGmBoCQA?=
 =?us-ascii?Q?q6W9TEueo4DyBaIGQ5ifeHGJ+GWiILiN/MgpmICe12dUG5Nv4/ielqi1jGy8?=
 =?us-ascii?Q?TO6K5EjB8YvzEe//aLIbwwL6LuLpVnYOjJgPIJxcKCWOMJJ+LK3kXGPiIWRn?=
 =?us-ascii?Q?0NEAlzTHlZwofnnXQ9Tl6JixQ7ZMSSlz1lTzIWSTrFr60JZQECqb8RYyFaGy?=
 =?us-ascii?Q?7zPJvj6slFMKa4Nyigy2v7hjgudl4t0eJ8fEfpeZnO5tyQtLSIPA/pMTRgc6?=
 =?us-ascii?Q?TVrXhxvI3fhqe0UARZDWqL3SvxbMdytJeDdh/L02PnyPI4CbHLDAtSXjhqSg?=
 =?us-ascii?Q?5OZuTzQzlNRilOPV9ZQidP6Q1ClraaNoVSiVqa/inMfOa20arZUQVexu0ZIF?=
 =?us-ascii?Q?ADOVNelBb4hrzW9WIl+4YGohaSJkFo8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A885B93491A8AE49927DB9B5A6AE8FC7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1120920a-822a-44cb-5022-08da336b291f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 16:27:37.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jF77TY6yGP7u7FgP01BHiNqiVIDjS5MYtQe5GrHk+RQKGdUuaDt7hSmDqk/uSwrkFqUOI+cioAbpCj399zbiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110075
X-Proofpoint-GUID: CpdeI26jKglFX37hrFSFdjpCQeBX0Z4E
X-Proofpoint-ORIG-GUID: CpdeI26jKglFX37hrFSFdjpCQeBX0Z4E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2022, at 12:09 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Wed, 2022-05-11 at 14:57 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On May 10, 2022, at 10:24 AM, Chuck Lever III
>>> <chuck.lever@oracle.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> I just noticed there were couple of oops in my Oracle6 in
>>>> nfs4.dev network.
>>>> I'm not sure who ran which tests (be useful to know) that caused
>>>> these oops.
>>>>=20
>>>> Here is the stack traces:
>>>>=20
>>>> [286123.154006] BUG: sleeping function called from invalid
>>>> context at kernel/locking/rwsem.c:1585
>>>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0, non_block: 0,
>>>> pid: 3983, name: nfsd
>>>> [286123.155872] preempt_count: 1, expected: 0
>>>> [286123.156443] RCU nest depth: 0, expected: 0
>>>> [286123.156771] 1 lock held by nfsd/3983:
>>>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-
>>>> {2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
>>>> [286123.156949] Preemption disabled at:
>>>> [286123.156961] [<0000000000000000>] 0x0
>>>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not
>>>> tainted 5.18.0-rc4+ #1
>>>> [286123.157539] Hardware name: innotek GmbH
>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>> [286123.157552] Call Trace:
>>>> [286123.157565]  <TASK>
>>>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>>>> [286123.157609]  __might_resched.cold+0x222/0x26b
>>>> [286123.157644]  down_read_nested+0x68/0x420
>>>> [286123.157671]  ? down_write_nested+0x130/0x130
>>>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>>>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>>>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>>>> [286123.157776]  ? lock_downgrade+0x680/0x680
>>>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>>>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>>>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>>>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>>>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>>>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>>>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>>>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>> [286123.159043]  kthread+0x29f/0x340
>>>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>>>> [286123.159043]  ret_from_fork+0x22/0x30
>>>> [286123.159043]  </TASK>
>>>> [286123.187052] BUG: scheduling while atomic:
>>>> nfsd/3983/0x00000002
>>>> [286123.187551] INFO: lockdep is turned off.
>>>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl lockd
>>>> grace sunrpc
>>>> [286123.188527] Preemption disabled at:
>>>> [286123.188535] [<0000000000000000>] 0x0
>>>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded
>>>> Tainted: G        W         5.18.0-rc4+ #1
>>>> [286123.190233] Hardware name: innotek GmbH
>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>> [286123.190910] Call Trace:
>>>> [286123.190910]  <TASK>
>>>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>>>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>>>> [286123.190910]  __schedule+0x16c9/0x20a0
>>>> [286123.190910]  ? schedule_timeout+0x314/0x510
>>>> [286123.190910]  ? __sched_text_start+0x8/0x8
>>>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>>>> [286123.190910]  schedule+0xd7/0x1f0
>>>> [286123.190910]  schedule_timeout+0x319/0x510
>>>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>>>> [286123.190910]  ? usleep_range_state+0x150/0x150
>>>> [286123.190910]  ? lock_acquire+0x331/0x490
>>>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>>>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>>>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>>>> [286123.190910]  io_schedule_timeout+0x26/0x80
>>>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>> [286123.190910]  ? wait_for_completion+0x330/0x330
>>>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>>>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>>>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>>>> [286123.190910]  ? bio_init+0x295/0x470
>>>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>>>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>>>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>>>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>>>> [286123.190910]  xfs_file_fsync+0x354/0x820
>>>> [286123.190910]  ? lock_downgrade+0x680/0x680
>>>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>>>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>>>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>>>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>>>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>>>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>> [286123.190910]  kthread+0x29f/0x340
>>>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>>>> [286123.190910]  ret_from_fork+0x22/0x30
>>>> [286123.190910]  </TASK>
>>>>=20
>>>> The problem is the process tries to sleep while holding the
>>>> cl_lock by nfsd4_release_lockowner. I think the problem was
>>>> introduced with the filemap_flush in nfsd_file_put since
>>>> 'b6669305d35a nfsd: Reduce the number of calls to
>>>> nfsd_file_gc()'.
>>>> The filemap_flush is later replaced by nfsd_file_flush by
>>>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
>>>=20
>>> That seems plausible, given the traces above.
>>>=20
>>> But it begs the question: why was a vfs_fsync() needed by
>>> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
>>> problem, and even added a might_sleep() call in nfsd_file_flush()
>>> but haven't been able to reproduce.
>>=20
>> Trond, I'm assuming you switched to a synchronous flush here to
>> capture writeback errors. There's no other requirement for
>> waiting for the flush to complete, right?
>=20
> It's because the file is unhashed, so it is about to be closed and
> garbage collected as soon as the refcount goes to zero.
>=20
>>=20
>> To enable nfsd_file_put() to be invoked in atomic contexts again,
>> would the following be a reasonable short term fix:
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 2c1b027774d4..96c8d07788f4 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -304,7 +304,7 @@ nfsd_file_put(struct nfsd_file *nf)
>>  {
>>         set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>         if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>> -               nfsd_file_flush(nf);
>> +               filemap_flush(nf->nf_file->f_mapping);
>>                 nfsd_file_put_noref(nf);
>>         } else {
>>                 nfsd_file_put_noref(nf);
>>=20
>>=20
>=20
> filemap_flush() sleeps, and so does nfsd_file_put_noref() (it can call
> filp_close() + fput()), so this kind of change isn't going to work no
> matter how you massage it.

Er. Wouldn't that mean we would have seen "sleep while spinlock is
held" BUGs since nfsd4_release_lockowner() was added? It's done
at least an fput() while holding clp->cl_lock since it was added,
I think.


> Is there any reason why you need a reference to the nfs_file there?
> Wouldn't holding the fp->fi_lock be sufficient, since you're already in
> an atomic context? As long as one of the entries in fp->fi_fds[] is
> non-zero then you should be safe.

Sure, check_for_locks() seems to be the only problematic caller.
Other callers appear to be careful to call nfsd_file_put() only
after releasing spinlocks.

I would like a fix that can be backported without fuss. I was
thinking changing check_for_locks() might get a little too
hairy for that, but I'll check it out.


--
Chuck Lever



