Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD45BB581
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Sep 2022 04:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIQCOj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Sep 2022 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIQCOh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Sep 2022 22:14:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714BC4E;
        Fri, 16 Sep 2022 19:14:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GMOHVX029967;
        Sat, 17 Sep 2022 02:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z5FVhfrKA4UKF2cEeJxqg5MrUspL3gryKE3NEEX565U=;
 b=YzXS+2A0uiz1ngYdET4s08CsRyw0pybGu32ph6lCcv0amhbCTRjCE+zcRKD9jJQut9s4
 tUDTjXZebR0mk5I11zv6IgPAASYiBBGmBaGJjyin4isuKZtGyy3mgbSePzzMS9mqoEMQ
 LiwQ/+ak5EZTIM0IZFh/iLp9KhN2TyDfizsJh/QuuJiAUsppir+1Nb59zFHTQ2n/0l2O
 Ck4sWPJsrmQYyfwyLrh9klQqVUu8M5jx8gyntwd/B0+YJIA3Yo+svkiAZXx+KB8uCU07
 rGVTyrZ/TRpAjCvj4sf/iBvxrT7AXRDp89B5iQqvSB0lBi0sO3MUVp8Gc2yqvIoeeH7n 6w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xcbvy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Sep 2022 02:14:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28H1Xcpw013203;
        Sat, 17 Sep 2022 02:14:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jn4p78fx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Sep 2022 02:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGicG9N0OJNN1on5LuuPJHPNbCYQSnUET3iNhF70wSoRCFBMB2OmrnpewtVXUZdfiqHfyEtdGFja1PgYsUF2y7VnlFtyyCReJjwUfY7gp9dgpGmTIiXiZLaihmZevh7vgFsBu0thtGX0helQtnXPnW4vpkbA0jgMox3sWjwnhfT1twjtMucbZCSp6DgPOI1RD2j2YVRFUSby7TlLp+XnrgZ/lTCz0yWYM5Axmqn3LNdDMa1kx/VrQ7vNNF5NtOXe4e1FYEKwMvbkBRo7K9n0vfPeVAxGtgcdPqo0/1RF6t3oAuYiy0hySJPw6JQfjdcVeoo0032/cufs1FOB6mMfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5FVhfrKA4UKF2cEeJxqg5MrUspL3gryKE3NEEX565U=;
 b=GrBplxILTUIYMmRBN6VgsslekoUUe2WWgLkD0REgOoGsvnZZfmz3wpse7f2JjRcya2llNf8UtKkw+OOozb/iwNUeKFGZlmmb8VfYBjVxXZtPEw60/KvnxQmMOwzTTmQuj/T+dfwQsf3DdGh86Nu8vxqzIfv7qmCrEUwCEaw98dRdGVhGujgaPs0RuNDsSOfQm40SkdEK4fjwDe2TEgjK/xGFfW0hqgLUegSkvSIdayTHHJhhGCb5SfZJuPBIh77egHXchcGQW1SkUJdTUwF2exzuydTdwiM2FYluaDj7wcSXEvnfPXYWbzlnvzIFMMy666hlnrEAq4z2J7N4cTYoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5FVhfrKA4UKF2cEeJxqg5MrUspL3gryKE3NEEX565U=;
 b=NYrHh8KioYeY6hCqpnC2K4MBHlKYbJAbh9Z0XdvDkR0swW4/hKG72sYM0qY8uRZeqjwJb42etIPKtu2DumkbLtnxDL8y8A6b2Nz7U/erjXZS7NvXWzgZJETE+ezQ2kOp4SSArzWwwVhJY/MjqQuG1Tb65sto2oKL+iid6R/yZ34=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Sat, 17 Sep
 2022 02:14:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.017; Sat, 17 Sep 2022
 02:14:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Replace the use of the xprtiod WQ in rpcrdma
Thread-Topic: [PATCH v1] SUNRPC: Replace the use of the xprtiod WQ in rpcrdma
Thread-Index: AQHYwg1HM+JR8GAooUCN3m7DZl2omq3gs2kAgAG8xoCAAEZygIAAO6WA
Date:   Sat, 17 Sep 2022 02:14:17 +0000
Message-ID: <367FDAB3-BED7-4A1B-AD71-F32B9CFAB91E@oracle.com>
References: <166247968798.587726.7092426682689468087.stgit@morisot.1015granger.net>
 <CAN-5tyEtr0f6o=0j_kMpf-tY7vvzfzaCd__P6taXhmq+e3TM-g@mail.gmail.com>
 <CAN-5tyGwvwKZCttNu4W+Rxmq5OV1rJBsMnMVC3yufhqsCmyC=Q@mail.gmail.com>
 <133bb5a93b91d78a46cb6faefaec429d4b030e10.camel@hammerspace.com>
In-Reply-To: <133bb5a93b91d78a46cb6faefaec429d4b030e10.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4578:EE_
x-ms-office365-filtering-correlation-id: 84c19e4b-675a-4b57-00eb-08da98525337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01JQnc27FLzwHE21JJBqZycKx0s14+WxitHewESLfNoBSlCNk5qlKv3ka49vGD+xhD75KMiTJXBga67M7Tp+ZUe1agEyjknKiH3Y8ExtXC/tZdoUg8XG/6x97uMk0ZCy+0awsV1Y9YxSz5euCoNUp3/2K3Cde92wzMx7h+eyy3jMnfY0TQmOsYsnMs6ZE4q5pu6KTtg6RK8YATI+dSv+Yd6xB/qvTM4kt8MPH3DOYdwF18NPSTTlDl8u5EUsSoCaFAuMe7FXN5oxW7Pg7A8i+E7fAREte4KU23Ka5SI/C/FaDIIGgGuHmzgVrXefZhyV00VU+RQTOVUVZQbGg4Sb6RqEnTbaNDviZuX7Rvi7zppgSSaOo7efUcLqehlEaPyjA2+05TzYEK9rkBeXBAE4dy9fT754fJnimjRK49Z0fimOtwX4aAWDFzI6Qm1d62B5gvhWp3g2ZeWCYMh0MihtwLYB4JxaNTd/2FoosYkt8VVyrL1mq2i5ufa7d+Gy3cFjEQz0LqlPw9sZ6EcnUCWGafF2L12Q47RYLnvmJ7sDihmgXwk128Jc0aldBR/ghsb9phTePgs3aX/89DJThRJpV4ROv/Xe5PGMuXTduc0zeL3+YCBBG3ZrSSU31ie2e3NnVPjrI5MdEB7YjQ6k0UNJRD9zWL5mS4G6tozEdEOfAGqkx6BJsvzicFlw6ZwFypkmvr0rdGYMloSjpcYW8UOshX/y/5X057DtXa6BIvt38txY7gHTEWdAA6n/u6jAT6lqKGaq3vNP48wuyKJYCb7s87mhfvuIH43PP+S9Yd+cJxUcmnYx3dsFjrZMzA09DYqJrpiNcn1OK2eCwZ5kHfmZrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(38100700002)(6486002)(478600001)(6506007)(2906002)(53546011)(122000001)(41300700001)(33656002)(6916009)(54906003)(5660300002)(8936002)(38070700005)(66446008)(4326008)(76116006)(66556008)(66476007)(66946007)(64756008)(71200400001)(86362001)(8676002)(45080400002)(36756003)(316002)(91956017)(83380400001)(2616005)(66899012)(26005)(6512007)(186003)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O4uxDPkbWeYaNgYQLJ9mfJ2ln5UCdEMOzvX2tvB1qGbetFAeninRzrz2NCtH?=
 =?us-ascii?Q?dYxymNkntLWP5vIAMD35sgTjLj+OhqoI0U8U5QMt+t0Th83sgSd9IgziqhAd?=
 =?us-ascii?Q?ayUamZunl1LEwr4UiR3u7GnsiEj32K7DsiSthbY3VxlqFwHiJDmLU6Zc0fbf?=
 =?us-ascii?Q?lc/KkiQv3+eiPLAxb8Gv+u93vcNYuGFFn2Roox5m5+9dhBzpHwEIzgdGqMfl?=
 =?us-ascii?Q?MYoSI/sTwZW2TZkWJ5fl/CU3c0+ci5uuO4Hbu1MXwT2/hhcNSuekYoG6f8x8?=
 =?us-ascii?Q?PloQZBEh8T68VjhBAEDMv2/za1Aq8eJEWxj/E6w2/Iv16fYdOGcAmZyW/lGO?=
 =?us-ascii?Q?kol23UIMJiYcdDguFZzE3ZqwF0VERX+pyFk3oAoxB4vg8O1Dh9lDNwHvUjAB?=
 =?us-ascii?Q?Vj5NVJ+SvMNZOXOpfuwynTkxqjyi5Tgk2DcdNn3mnHMgUvZRyAPVxI4Gyp83?=
 =?us-ascii?Q?9KVCHpAzp71wDO7lj2aLUCMDQG6c051hftvHjDvXA6pfIGHGaB04Y5hikIWO?=
 =?us-ascii?Q?5WGSv134gt3GBAxNzmXWXOILNjv+hANQYWlFyCSgeGQBH9kfgWNEqIsvFlWF?=
 =?us-ascii?Q?KeDZ8nQZDFgXjzUAKO6I9Da0LNTCYIhtuLblbbN5I0B844yrlNqr3jli2wGa?=
 =?us-ascii?Q?pDdm2/Tu3UIZ+7/eae2a2ln15V4Sg3x/OhsoAOAU31csnboJ7u/MfheMyva6?=
 =?us-ascii?Q?mcP+0syVq6OaSAxadCBkAU2mNvnygatOpvP/MxBx2dKoHD0xUiA6D5izt/zm?=
 =?us-ascii?Q?3RxGzz3k/vAMni/z8JLr4zTF2VaVaQUOhkcwYCs+m62sO1uMiO8oj3kTG6Pm?=
 =?us-ascii?Q?Bha6dUX2XCHKXfJqLtG6rWxElMmIKIrK+niQcuGmvBkqpMNMEnApNcgcMj6j?=
 =?us-ascii?Q?CYRvIMjjjJGCdE5yCEWJX7xcvXLAi2ZkKFbNPx6awzEGwvMETzV10x4zmgUn?=
 =?us-ascii?Q?OAEgsgYePAG3swx0fTrCF1VjQKuJlpvVxFBuY8CXd1JZsfiH+dvOPmIBK9ht?=
 =?us-ascii?Q?ewvThfAQYb+KtQ9+zq8bhXsHDJH2pATiAMQOK6qF7o32/eKESFYf9zrW3u2z?=
 =?us-ascii?Q?kC8J89tEJ9iFiIYoE2itsg4N5198muAxgyuWbWQ86jc664xWOGbJpS7duuKG?=
 =?us-ascii?Q?jepbyOz2Wc9IIClUwUQ1+QyLX2O/u9k73TaRzetrpzNHucvFILmD/Aue72QE?=
 =?us-ascii?Q?S936nh0Zparku896nKQ1MlkMyS72CTj4LSgizIfGo+BU2IPnNO6RybVtmUtK?=
 =?us-ascii?Q?OZNpYFEtS5HruPwIVdsoDUbMIYxZes2KPgOGSjCKJcrUML3xvs/+Hj9GxHsR?=
 =?us-ascii?Q?/gYiFjY4Sq5HY1xngf2kxB1cVFk5AF181mkXhpGTCGvpybAMNfp29mHGFosl?=
 =?us-ascii?Q?kYqzi8scqGUfZZmTcPcUhAko9mzMFK7lfMa+7/uzkUXjts/FLd7DvEHRoYmL?=
 =?us-ascii?Q?b5RnTVGFxN3zGvt9mROG5p64Wtwv/Y/azkIBaW2C3lXroYox1OSaOM4SJXJp?=
 =?us-ascii?Q?qmVUFvCg04i7piYHlMzvlJPXwBn0pCteaWvMKW/V2iSe3A7kCX3u3V+NsDOK?=
 =?us-ascii?Q?iBNRpjYHUUBrv/iGyepl6ZIh/tH9Mgz2AR9lY2AZpnmAJUJ2Xo+Jr5y26kq4?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DF5633B44C92C44BD9B321257451BB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c19e4b-675a-4b57-00eb-08da98525337
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2022 02:14:17.7044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJwcn+iwICIl6l/pgdJe9/kyEnyrdhaEqPY/ljkjQjWriBVeK+e9Hfhk475vYZAWwGkMU4F25+x3zj8Lnk4teA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_14,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209170014
X-Proofpoint-ORIG-GUID: ea2ugCW-3PGIW1qtytuoYXcs0K8siQ4E
X-Proofpoint-GUID: ea2ugCW-3PGIW1qtytuoYXcs0K8siQ4E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 16, 2022, at 6:40 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-09-16 at 14:28 -0400, Olga Kornievskaia wrote:
>> On Thu, Sep 15, 2022 at 11:56 AM Olga Kornievskaia <aglo@umich.edu>
>> wrote:
>>>=20
>>> On Tue, Sep 6, 2022 at 12:25 PM Chuck Lever
>>> <chuck.lever@oracle.com> wrote:
>>>>=20
>>>> While setting up a new lab, I accidentally misconfigured the
>>>> Ethernet port for a system that tried an NFS mount using RoCE.
>>>> This made the NFS server unreachable. The following WARNING
>>>> popped on the NFS client while waiting for the mount attempt to
>>>> time out:
>>>=20
>>> I also hit this today (on the 5.18 kernel) while running xfstest
>>> generic/460 using soft iWarp. In my case the port was properly
>>> configured. The test was going. I'm not sure exactly what happened.
>>> I
>>> know I also crashed the server that I was running against. But the
>>> point I would like to make is that this condition is possible to
>>> get
>>> to on a properly configured system.
>>=20
>> But I think with this patch. I'm hitting this instead (of course
>> could
>> be something else):
>>=20
>> [ 3222.712335] BUG: using smp_processor_id() in preemptible
>> [00000000]
>> code: 192.168.1.124-m/3814
>> [ 3222.714428] caller is xprt_rdma_connect+0x6a/0x120 [rpcrdma]
>> [ 3222.716047] CPU: 0 PID: 3814 Comm: 192.168.1.124-m Not tainted
>> 6.0.0-rc5+ #123
>> [ 3222.717706] Hardware name: VMware, Inc. VMware Virtual
>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>> [ 3222.720310] Call Trace:
>> [ 3222.721032]  <TASK>
>> [ 3222.721587]  dump_stack_lvl+0x33/0x46
>> [ 3222.722501]  check_preemption_disabled+0xc3/0xf0
>> [ 3222.723754]  xprt_rdma_connect+0x6a/0x120 [rpcrdma]
>> [ 3222.725594]  xprt_connect+0x300/0x370 [sunrpc]
>> [ 3222.727369]  ? call_reserveresult+0xa0/0xa0 [sunrpc]
>> [ 3222.729272]  __rpc_execute+0x162/0x870 [sunrpc]
>> [ 3222.731101]  ? rpc_exit+0x40/0x40 [sunrpc]
>> [ 3222.732841]  ? __wake_up+0x10/0x10
>> [ 3222.733657]  rpc_execute+0x148/0x1b0 [sunrpc]
>> [ 3222.735326]  rpc_run_task+0x270/0x2d0 [sunrpc]
>> [ 3222.737182]  nfs4_proc_bind_one_conn_to_session+0x1cc/0x3a0
>> [nfsv4]
>> [ 3222.740472]  ? _nfs4_do_set_security_label+0x2d0/0x2d0 [nfsv4]
>> [ 3222.745034]  ? xprt_get+0xa0/0x120 [sunrpc]
>> [ 3222.747150]  ? nfs4_proc_bind_one_conn_to_session+0x3a0/0x3a0
>> [nfsv4]
>> [ 3222.749299]  ? __rcu_read_unlock+0x4e/0x250
>> [ 3222.750429]  ? nfs4_proc_bind_one_conn_to_session+0x3a0/0x3a0
>> [nfsv4]
>> [ 3222.752586]  rpc_clnt_iterate_for_each_xprt+0xc6/0x140 [sunrpc]
>> [ 3222.754900]  ? rpc_clnt_xprt_switch_add_xprt+0xa0/0xa0 [sunrpc]
>> [ 3222.757041]  ? preempt_count_sub+0x14/0xc0
>> [ 3222.758097]  nfs4_proc_bind_conn_to_session+0x87/0xb0 [nfsv4]
>> [ 3222.760341]  ? nfs4_proc_secinfo+0x250/0x250 [nfsv4]
>> [ 3222.762257]  nfs4_state_manager+0x34e/0xf60 [nfsv4]
>> [ 3222.764095]  nfs4_run_state_manager+0x1a6/0x2e0 [nfsv4]
>> [ 3222.766778]  ? nfs4_state_manager+0xf60/0xf60 [nfsv4]
>> [ 3222.768811]  ? _raw_spin_lock_irqsave+0x8d/0xf0
>> [ 3222.770029]  ? _raw_spin_unlock_irqrestore+0x40/0x40
>> [ 3222.771740]  ? __list_del_entry_valid+0x77/0xa0
>> [ 3222.773400]  ? nfs4_state_manager+0xf60/0xf60 [nfsv4]
>> [ 3222.775653]  kthread+0x160/0x190
>> [ 3222.776729]  ? kthread_complete_and_exit+0x20/0x20
>> [ 3222.777865]  ret_from_fork+0x1f/0x30
>> [ 3222.778972]  </TASK>
>>=20
>>=20
>>>=20
>>>> kernel: workqueue: WQ_MEM_RECLAIM
>>>> xprtiod:xprt_rdma_connect_worker [rpcrdma] is flushing
>>>> !WQ_MEM_RECLAI>
>>>> kernel: WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:2628
>>>> check_flush_dependency+0xbf/0xca
>>>> kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs
>>>> 8021q garp stp mrp llc rfkill rpcrdma>
>>>> kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not tainted 6.0.0-rc1-
>>>> 00002-g6229f8c054e5 #13
>>>> kernel: Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b
>>>> 06/12/2017
>>>> kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
>>>> kernel: RIP: 0010:check_flush_dependency+0xbf/0xca
>>>> kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 00 00 4d 89 e0 48
>>>> 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
>>>> kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010092
>>>> kernel: RAX: 0000000000000082 RBX: ffff97894f8c3c00 RCX:
>>>> 0000000000000027
>>>> kernel: RDX: 0000000000000002 RSI: ffffffffbe3447d1 RDI:
>>>> 00000000ffffffff
>>>> kernel: RBP: ffff978941315840 R08: 0000000000000000 R09:
>>>> 0000000000000000
>>>> kernel: R10: 00000000000008b0 R11: 0000000000000001 R12:
>>>> ffffffffc0ce3731
>>>> kernel: R13: ffff978950c00500 R14: ffff97894341f0c0 R15:
>>>> ffff978951112eb0
>>>> kernel: FS:  0000000000000000(0000) GS:ffff97987fc00000(0000)
>>>> knlGS:0000000000000000
>>>> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4002 CR4:
>>>> 00000000003706f0
>>>> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> kernel: Call Trace:
>>>> kernel:  <TASK>
>>>> kernel:  __flush_work.isra.0+0xaf/0x188
>>>> kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
>>>> kernel:  ? lock_timer_base+0x38/0x5f
>>>> kernel:  __cancel_work_timer+0xea/0x13d
>>>> kernel:  ? preempt_latency_start+0x2b/0x46
>>>> kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
>>>> kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
>>>> kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrdma]
>>>> kernel:  ? _raw_spin_unlock+0x14/0x29
>>>> kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
>>>> kernel:  ? finish_task_switch.isra.0+0x171/0x249
>>>> kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpcrdma]
>>>> kernel:  process_one_work+0x1d8/0x2d4
>>>> kernel:  worker_thread+0x18b/0x24f
>>>> kernel:  ? rescuer_thread+0x280/0x280
>>>> kernel:  kthread+0xf4/0xfc
>>>> kernel:  ? kthread_complete_and_exit+0x1b/0x1b
>>>> kernel:  ret_from_fork+0x22/0x30
>>>> kernel:  </TASK>
>>>>=20
>>>> SUNRPC's xprtiod workqueue is WQ_MEM_RECLAIM, so any workqueue
>>>> that
>>>> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
>>>> prevent a priority inversion. The internal workqueues in the
>>>> RDMA/core are currently non-MEM_RECLAIM.
>>>>=20
>>>> Jason Gunthorpe says this about the current state of RDMA/core:
>>>>> If you attempt to do a reconnection/etc from within a RECLAIM
>>>>> context it will deadlock on one of the many allocations that
>>>>> are
>>>>> made to support opening the connection.
>>>>>=20
>>>>> The general idea of reclaim is that the entire task context
>>>>> working under the reclaim is marked with an override of the gfp
>>>>> flags to make all allocations under that call chain reclaim
>>>>> safe.
>>>>>=20
>>>>> But rdmacm does allocations outside this, eg in the WQs
>>>>> processing
>>>>> the CM packets. So this doesn't work and we will deadlock.
>>>>>=20
>>>>> Fixing it is a big deal and needs more than poking
>>>>> WQ_MEM_RECLAIM
>>>>> here and there.
>>>>=20
>>>> So we will change the ULP in this case to avoid the use of
>>>> WQ_MEM_RECLAIM where possible. Deadlocks that were possible
>>>> before
>>>> are not fixed, but at least we no longer have a false sense of
>>>> confidence that the stack won't allocate memory during memory
>>>> reclaim.
>>>>=20
>>>> While we're adjusting these queue_* call sites, ensure the work
>>>> requests always run on the local CPU so the worker allocates RDMA
>>>> resources that are local to the CPU that queued the work request.
>>>>=20
>>>> Suggested-by: Leon Romanovsky <leon@kernel.org>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  net/sunrpc/xprtrdma/transport.c |    4 ++--
>>>>  net/sunrpc/xprtrdma/verbs.c     |   11 ++++-------
>>>>  2 files changed, 6 insertions(+), 9 deletions(-)
>>>>=20
>>>> Hi Anna-
>>>>=20
>>>> I've had this applied to my test client for a while. I think it's
>>>> ready to apply.
>>>>=20
>>>>=20
>>>> diff --git a/net/sunrpc/xprtrdma/transport.c
>>>> b/net/sunrpc/xprtrdma/transport.c
>>>> index bcb37b51adf6..9581641bb8cb 100644
>>>> --- a/net/sunrpc/xprtrdma/transport.c
>>>> +++ b/net/sunrpc/xprtrdma/transport.c
>>>> @@ -494,8 +494,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt,
>>>> struct rpc_task *task)
>>>>                 xprt_reconnect_backoff(xprt,
>>>> RPCRDMA_INIT_REEST_TO);
>>>>         }
>>>>         trace_xprtrdma_op_connect(r_xprt, delay);
>>>> -       queue_delayed_work(xprtiod_workqueue, &r_xprt-
>>>>> rx_connect_worker,
>>>> -                          delay);
>>>> +       queue_delayed_work_on(smp_processor_id(), system_long_wq,
>>>> +                             &r_xprt->rx_connect_worker, delay);
>>>>  }
>>>>=20
>>>>  /**
>>>> diff --git a/net/sunrpc/xprtrdma/verbs.c
>>>> b/net/sunrpc/xprtrdma/verbs.c
>>>> index 2fbe9aaeec34..691afc96bcbc 100644
>>>> --- a/net/sunrpc/xprtrdma/verbs.c
>>>> +++ b/net/sunrpc/xprtrdma/verbs.c
>>>> @@ -791,13 +791,10 @@ void rpcrdma_mrs_refresh(struct
>>>> rpcrdma_xprt *r_xprt)
>>>>         /* If there is no underlying connection, it's no use
>>>>          * to wake the refresh worker.
>>>>          */
>>>> -       if (ep->re_connect_status =3D=3D 1) {
>>>> -               /* The work is scheduled on a WQ_MEM_RECLAIM
>>>> -                * workqueue in order to prevent MR allocation
>>>> -                * from recursing into NFS during direct reclaim.
>>>> -                */
>>>> -               queue_work(xprtiod_workqueue, &buf-
>>>>> rb_refresh_worker);
>>>> -       }
>>>> +       if (ep->re_connect_status !=3D 1)
>>>> +               return;
>>>> +       queue_work_on(smp_processor_id(), system_highpri_wq,
>>>> +                     &buf->rb_refresh_worker);
>>>>  }
>>>>=20
>>>>  /**
>>>>=20
>>>>=20
>=20
> Right. smp_processor_id() is only allowed to be called when preemption
> has been disabled. See Documentation/kernel-hacking/hacking.rst and
> Documentation/locking/preempt-locking.rst.
>=20
> Why not just use queue_work(), Chuck? That achieves the exact same
> thing without requiring any extra locking.

The intent was to allocate resources on the NUMA node that owns
the device. The code doesn't do that, I can see now.

I will send you a v2 that does the obvious thing.


--
Chuck Lever



