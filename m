Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD57A22FD
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjIOPzY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjIOPzU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 11:55:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E927E6D;
        Fri, 15 Sep 2023 08:55:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFhwVn001808;
        Fri, 15 Sep 2023 15:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UtR8PD/ivoa0uNrgabaEDDEGm5u4yhEPijucRE9Dcs4=;
 b=d2eCLZqBjpUiCya5ef63A3BQd+2Z8tvir7Fy5fuYSRr+ArN8wdYEDDFrrRDrFvf0M7wT
 90NkxGQqw7FGD37ti3fp7g/wTd6hAMBnk7baoH4fyG99iuwizRdBnGEg/kU6yCyjS2VP
 eF6evYLX4Sbw0eHQJHWaMt/q8CQ2v98LphA3qtS/jAH0+xAkVQPNG7VmZhJuAiH0vpV1
 UxWfPaeLaV6n9pcqSJ/OYuFu5xislr/9/dtRq0vm2x68yUhuL1guolA/5G1i3ZSsOkc3
 zbhOM2R2Ar+eabFntG7UQHGIPdGFCEWz0YaBe7QgjjybSUaSqpinTslGBJSLZq2amzxm 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7myvsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:55:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FF9Xik007361;
        Fri, 15 Sep 2023 15:55:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5b0pk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI5rmasS+n8gZ4WlVmvxJk2NaukkaXeq/5dxeAyxHZJC6kMvOKDGw6IVYJoSFiHGhBC0Zto4z66ZhOf/aB1rl491Zy4FtuKpxcNM9jINByalj3ZA975o+k56f5bJfFqgAIgz/qjqlhPRLsRaGWmtXow/rnynSSZpYEKj8ihSd2fAxj13JJiXd2/VNFmxwIw0uTE6jNL6rKtQODHwbK7+Caw2Y3bkdnXjQxaxWWGAfrvB7jdBYBGkcnsS6W7gIhX5F+WtQyf7wIg04lGHgJo1WKWap2N+GjKnLMW4FDDPn4wj23M4bvk832SufvGai7qx1PMUPU9B1j7oWlQ1ivXQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtR8PD/ivoa0uNrgabaEDDEGm5u4yhEPijucRE9Dcs4=;
 b=Lk5eR1+mTIUcwvtrRjU0/wiV60oAsN09N/amj/sl0vZMD6ut9iL6IpvtsSiNAKocQ8I8SqXkpD4TAMPUSaz1oJaB1IYsmt8xykS+vSMLEzQ+V8VxYF2QdnRFhpOFnRk+HdBsWaNq6KZFi9cUAM5IIHJu1miWmAvOBi2/TAwcibVgfxBX25j6f8eu8bzaUaRNVlwDxL8XRYdNPQU0C/gjtlsIZYVEnSI2oip5/ydB8f2xYuJP9ILlXcSFHLBkFOJ3mdGOqocsKegLsg2B2OXWLCLxRDF+FBVp/I8EO9tHr4bwG/GRsy6JBDebwAPb1h7O3gvPI4ex5IHzrpK8oi1n1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtR8PD/ivoa0uNrgabaEDDEGm5u4yhEPijucRE9Dcs4=;
 b=mooXV7xiVRv+tuAjphCRliAHjXtC3jjQERqzGq9ijbwGfpCeV9srM0/pjRkkTo9uwwKOxpUNStND6ZMyGzn8U61hPTwUfs/i/Jzbt/O5lg1+icI+nGewtT+7+qEddggtnEnFVpZEU78kh0oC2ohwIEyXlgyD7fYlBpfeJTnVSfo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 15:54:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 15:54:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17 SQUASH and replace commit message] lib: add
 light-weight queuing mechanism.
Thread-Topic: [PATCH 11/17 SQUASH and replace commit message] lib: add
 light-weight queuing mechanism.
Thread-Index: AQHZ53u2saYwvGYnq0S8AyLmhacLGrAcCvEA
Date:   Fri, 15 Sep 2023 15:54:58 +0000
Message-ID: <C399E393-DECE-4B64-A9C0-943AE7100F52@oracle.com>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
 <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>
 <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
 <169447439989.19905.9386812394578844629@noble.neil.brown.name>
 <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
 <169474455669.8274.9157028681960361538@noble.neil.brown.name>
In-Reply-To: <169474455669.8274.9157028681960361538@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4599:EE_
x-ms-office365-filtering-correlation-id: e4162242-3abc-4cf8-1fd7-08dbb6041d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcFOFhyNRdm8mBtYo0TDIWY3aPPkRDvvb/O2G2LIIrEljnGZEewhWVWqFckXALCMmG7GfzQe7u99AB/JZHyP3X5z7aMesGUzoD1DhH9pSeLAZoTBz7Rb8kcadLjsZQFdLzXT7r6Nw0QQ91180pBvVC+gf4cFsjSu8Q3cyJCnpnNXIRnmSZrrXRweqBEh5vfYPJAXuMvKqv7R3vbIfk9LSWg7vUmnTlMZ72MsgP5NtQNI8o1XavMWZEKro6eVwFVMDEeC+4OseZTY4ml6s++knSrHdEFD+WFdTlkGxYkRHwdpgX2dwUAEnjOVBNM+fRHktaKoYLua0VRuSIUqG3zFuYty/A3eqWA7Mvh1qUmufySi3hVTVVNsaJi5IiR8ea0MJlLAOMUQMNJoqDazFGv+q9TRXiVr7pMwq+Wry2c3vSue3e17IBAnf8I5maR3mq4LLVrK4RTBTDznLm70VlibxsVaU7Xv4KZ7v1LXTjRvweZnol901Gl0gAJQal+cVuaiyFOA8Feq7pcdTSH+xlgciHNNB9e+aadhiyp9Dp0jiyN4sN2W3/EezDG0EA4G6Q1Z+zPtxL4pF1dIlduayM3J/rCBKvnkZ+rNK3RyK6cnvtTUYVdermIyyfm84hQQQ5lko/0+2mci9F2SvQtv/8PLib7CYomaSr5qWMXQ3wT0sz7MW7EfPtUDS0D3xYEzB1ep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199024)(186009)(1800799009)(8936002)(91956017)(76116006)(8676002)(5660300002)(41300700001)(6486002)(6506007)(6512007)(66476007)(53546011)(66946007)(66446008)(66556008)(64756008)(54906003)(4326008)(316002)(2906002)(6916009)(38070700005)(38100700002)(122000001)(36756003)(2616005)(86362001)(26005)(71200400001)(33656002)(478600001)(83380400001)(16393002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCPapPyTvuEz1Hyqn7A8SxZvgVHDgXU7eaiS8TPx9nbhaOb6ybTEl8/DQfCh?=
 =?us-ascii?Q?y2XhyfNkdAT1bazfMy1lROIu5rq3vENytZyU/4msJBH+8OqvvvQAr43lTmaw?=
 =?us-ascii?Q?9+bZf9Y6aDW3MIFF1HEBFnaipiXQJN8jEVlvxRQA+o9NhRXMpvfAQDz/51p0?=
 =?us-ascii?Q?7V/nkqCPVB9ilBi7V6sr3fT++HoCi9i8ZrlHtk5uj3EFfbZX4fo/Jn0Wta6o?=
 =?us-ascii?Q?aXc3iPBLzl40/IeAy6qUWSZxjVUwzgYF/qReSYInZ8QTVKJ1CQ0GLAV/Bmvs?=
 =?us-ascii?Q?uCgo9xUgpyoxQ+WGBZplU/OVExpda0Wn0Y9SUAIMgpEQAjELv6cH/2wuaaME?=
 =?us-ascii?Q?fD4l5SPshVHGyEwQY7hOLnhJfGq+Lnf6wAIWMYfMZJh6sYupz8MsSqGiEbS6?=
 =?us-ascii?Q?UTaMAef4taBAT8ryKCfMCJwalFvIyX81yupoM8T2HjUCaBKpAHZjnU96zl2X?=
 =?us-ascii?Q?xtWbwjlc99vwgj9qNnUK4LgaY93k2Cd+dNGV3oiCrz36H9ROl9Jjn/xOom1R?=
 =?us-ascii?Q?wkIQONXufD5mAehaxw/jdj9rpuc7D/ahbaaLI840lZ5xOz1rTn6IA7/jmG25?=
 =?us-ascii?Q?nurTfDrHe1dBH58F6Tv2p9KJ4aL+qogix6e90Cyoe9rQV8t3ckzShl326N/l?=
 =?us-ascii?Q?87HTLEGZVgijXyqb4AiDwqdWb5f+WDsrHjfhZSZSfKvKFkqav26kWXIjZo7F?=
 =?us-ascii?Q?7zZ2ZiNJ4CgggerbBBvJ5BOg/C0dLNVucHITzxIiPwfoMkdWRoSh29RyZGoI?=
 =?us-ascii?Q?Qnti57GsAVs3OfTJhZ22PbAx/nvyvHAi+zhv0viU0dtPNfKM5GS5gchlUp7M?=
 =?us-ascii?Q?ZveaRpOWLEvc39hpUp3VD0l6Oe+jP/QVi01A4VMoV7bBdIMexcZg/ZmInZnd?=
 =?us-ascii?Q?A+KXeUHyycBVxwoDRKAiFMCN6cpi99VBM4YwnSAUxKqa8IR0u5r7lEBcdh5e?=
 =?us-ascii?Q?QDb77OGcJIzTrvtUG4g17Y+5OCf0bP+2eg9Fi/hmmWHoW59L9mZ1I+ehPUxw?=
 =?us-ascii?Q?OZYz1ggwR90qfN1I3kKd3n9EtYcyxPcYBY78JISy4inl7hu6xQz3Vk2HZkjd?=
 =?us-ascii?Q?QoiUiDbMfPfnF7J2ip01KkpLlZ8TpyVYMVnr4b26hSAdlxmNF0BhL38QMud3?=
 =?us-ascii?Q?c7vGlFb905ZW6moEM0XFv7TybA3GtaqTcUcnOixxbOk5yQX57WhojFj9vR5F?=
 =?us-ascii?Q?2MZwZL5YPRHouqRYBOWx+GMTacWRmey6r7s715Dd2B72eutbj9/5IFvNrS79?=
 =?us-ascii?Q?eefvqzYl9bVc0cal0KWAP9XKMOwtrzRAztKXln5PWlxccVoQJoEjIQPoREGo?=
 =?us-ascii?Q?tlIHFTp+fd30Q3DfNSUBnbNNnHww/tScKOPNv7DWcKnFsIc80X8MRbfOMNX2?=
 =?us-ascii?Q?NMuqNRnDvl+8NvjLkTFgQbsbDmu8gHLsecX4g22kanePxaEG3S9Qs734lnZV?=
 =?us-ascii?Q?2fGEIJ3UCMfcmnnutMyP7WJVQl9zpXqsCREEmodZq4AIL9dRcWdy/aDhshiO?=
 =?us-ascii?Q?KOAJIjigMTQHsX2HK1eKo8EtlomYnk3VSRpngwTnjfhVmhwCDa78K4ctPdYV?=
 =?us-ascii?Q?H0wjvBUpRoLyF6wnvzbPreus96LUB9Rec7Tn8VNkeusSkSVV0ZEGoeAfZ7vx?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D2D037807488E45AB01FB7593C41441@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6hqnSUNkIoIwX4BC2bvmugpdMu7cMKHd5Udb7pzVFwFhWwRdoLhcu+vmNst0?=
 =?us-ascii?Q?oIrfVYH62yODAS6Q/3UJ13xEAjs816zkApY8MO8NsQRuTgiKjUyc/wqL9Hjd?=
 =?us-ascii?Q?WGbaaQt1K/kiZcOGeWg785JszFHcOzUMfRwFIS3TH+XSMvbPif3nyx7vcHwI?=
 =?us-ascii?Q?u6RlmHO59Xf36+5/ji37c1t8QGWQ8j1RIlTzAyYELvHmwQDhJEiP0DRIo3wH?=
 =?us-ascii?Q?tn1aHydhGpmGgogWyZ2M2uMfhyRsech1MPn//Z8u++NSr2Zy0VadkM7Yucqt?=
 =?us-ascii?Q?YKfTgKqws3d56hCz4A542PUuC77WHhNi66b0j4d64s7W67Qdyg56qoLH4hPw?=
 =?us-ascii?Q?yM1pePR5ofM3a6EJSEGVR/5fpSAbjM0Er+X4amGtTGVntRCyaa/KB50fCUhB?=
 =?us-ascii?Q?XB0I/ujHqS+GBiTb/en/HgljLfjiKlIui1pvsqNQHCBFMXypgAtYUkLogY+M?=
 =?us-ascii?Q?ODrCUzcIGRrtzkROS5o0BuKu0SIwOvq6SRzQZq8yEMLZef9RKXzXvQ4UfQEE?=
 =?us-ascii?Q?ys654rzqVdIL1/ZbUEksqGPPeOUfYXu909uT7CUrjqO0Fhqvw8GosGJowVGC?=
 =?us-ascii?Q?YN/EKSncYXljDWINomD3VQbWbEV30hI99lyHLZKbanBi0i7Zobl+6kI4sHNe?=
 =?us-ascii?Q?MRmIqSeNfEMczdcTTNWkKv+XAwiQJi8m+vBffz/0+BMi8Bt6QBvbyAC6rLt/?=
 =?us-ascii?Q?7VEtKnloRDrSdPCg/O+PoGAhlX/thi53D+Oo7iYFg4vDBHR53+hU3ZbZrJKC?=
 =?us-ascii?Q?Gyr5B+QyECuwa/Y4juJuL031FkZvd2Q34BauBRH5m5N/Yn7hg2pk/+n39ZnQ?=
 =?us-ascii?Q?MO+7bUEqBzjleDowuU+OkH5JKgqZQ0ThjNfjYZsu7VEGgBxq2ikBBk9oLNGq?=
 =?us-ascii?Q?7raz3/NslWvLSkvIfZhm1Fcw73DHE3XczfVTyheQoEtAfKlsBEhhDxfNkGje?=
 =?us-ascii?Q?6ju+tBZU1uuDxdKEyfFXvA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4162242-3abc-4cf8-1fd7-08dbb6041d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 15:54:58.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFRCFSQjiJqQWBU3s2fBoiVggL+KxOaDrVSFLXbAA+5E2CFdwfinqQtCazfz3Wf+7IavNns+8YSM8+F9+v6Tug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=488 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150142
X-Proofpoint-ORIG-GUID: vD2Z5GLeQn5tMa04CS339H0LVUtChz6D
X-Proofpoint-GUID: vD2Z5GLeQn5tMa04CS339H0LVUtChz6D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2023, at 10:22 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> lwq is a FIFO single-linked queue that only requires a spinlock
> for dequeueing, which happens in process context.  Enqueueing is atomic
> with no spinlock and can happen in any context.
>=20
> This is particularly useful when work items are queued from BH or IRQ
> context, and when they are handled one at a time by dedicated threads.
>=20
> Avoiding any locking when enqueueing means there is no need to disable
> BH or interrupts, which is generally best avoided (particularly when
> there are any RT tasks on the machine).
>=20
> This solution is superior to using "list_head" links because we need
> half as many pointers in the data structures, and because list_head
> lists would need locking to add items to the queue.
>=20
> This solution is superior to a bespoke solution as all locking and
> container_of casting is integrated, so the interface is simple.
>=20
> Despite the similar name, this solution meets a distinctly different
> need to kfifo.  kfifo provides a fixed sized circular buffer to which
> data can be added at one end and removed at the other, and does not
> provide any locking.  lwq does not have any size limit and works with
> data structures (objects?) rather than data (bytes).
>=20
> A unit test for basic functionality, which runs at boot time, is included=
.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Thank you for all of this work, Neil. The metrics in the
cover letter speak for themselves. I've applied the series
to nfsd-next and squashed this patch in.


> ---
> include/linux/lwq.h | 4 ++++
> lib/lwq.c           | 4 ++++
> 2 files changed, 8 insertions(+)
>=20
> diff --git a/include/linux/lwq.h b/include/linux/lwq.h
> index 52b9c81b493a..c4148fe1cf72 100644
> --- a/include/linux/lwq.h
> +++ b/include/linux/lwq.h
> @@ -7,6 +7,10 @@
>  *
>  * Entries can be enqueued from any context with no locking.
>  * Entries can be dequeued from process context with integrated locking.
> + *
> + * This is particularly suitable when work items are queued in
> + * BH or IRQ context, and where work items are handled one at a time
> + * by dedicated threads.
>  */
> #include <linux/container_of.h>
> #include <linux/spinlock.h>
> diff --git a/lib/lwq.c b/lib/lwq.c
> index 7fe6c7125357..eb8324225309 100644
> --- a/lib/lwq.c
> +++ b/lib/lwq.c
> @@ -8,6 +8,10 @@
>  * Entries are dequeued using a spinlock to protect against
>  * multiple access.  The llist is staged in reverse order, and refreshed
>  * from the llist when it exhausts.
> + *=20
> + * This is particularly suitable when work items are queued in
> + * BH or IRQ context, and where work items are handled one at a time
> + * by dedicated threads.
>  */
> #include <linux/rcupdate.h>
> #include <linux/lwq.h>
> --=20
> 2.42.0
>=20

--
Chuck Lever


