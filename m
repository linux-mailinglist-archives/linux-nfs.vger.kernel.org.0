Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE994EDE17
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiCaQBC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaQBB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 12:01:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E560CF2
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 08:59:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEa0kx032355;
        Thu, 31 Mar 2022 15:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A9TrE7HFFyVtEpIesS3HL1gRz/D1Fk3xem6tWhrAYVY=;
 b=EewqeXBDF7XkmgyXVKI0b7N4/v4wO8hQ0QhQQQRug5lgi0gtPlXnkS7PLqF+iDj9VjA4
 RdePL5GN7LYvBdSuUNgy1cxN8OQd42cr90JBsXguFUw74vXeAdiry+0Ad2+FdGNYzCuO
 i0aKOj3eM3gnZTfBzIiX7FXr+vfiSWZzwjjxopXfVe1Cj/kwmNoohRIMTbcLjN6cFIu+
 cCYYgbRWIVLffcUtNtx8cu6YdPh+96l2MwyxfSinajFpXdiJe3iovzb61ZDpeb8Fzz2z
 AyMuQwgnDSHa9qeo7KOL5y25KQP5flmYp5vALRUX65IY3mGMnyaKRSX65dV2l6PEBPRT Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctw153-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:59:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFuZUU003870;
        Thu, 31 Mar 2022 15:59:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94t087-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G82XdVoRX99BXVZMlO5KJChl0V7BImEarH7jbOohvp3l6gugqdUVnknzbGhJgll+z2k1cp+w5meg1G256jKp7IhTAF3ERKIKCCpcjOY6hBsPkQdjTE+JoOSFhALk8HW6ZosxFzuo1oFZVYfMB1sUIQQJVhkTFOY/pjoqFEG9DeBBtbwrj0lLo33OcWNSNItWhpnvCphEfL1RSERvVkw8GX8OtGNjuNhj4h0ky1M+YtsVZYzBXF5JUQVB8nMHFmJSDYxqROZItU430Z2y+RfdHcXH+ZezM0rxf8/bv0K4XCo6e+cOymJpKB0WZqWi7kldUCIcIW9RlUVyofz/byreQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9TrE7HFFyVtEpIesS3HL1gRz/D1Fk3xem6tWhrAYVY=;
 b=B/ARQI7XWvrl2McQ3M7zXz37nikJRpPuIlnnY+uC9D/2FtfhZBKWFhnun8csInKzawZvJ3f+zB+2FjHMsrSV/8qWnV1/wGmCLKWa3kJKT14vBek3fdGdj7nKWRFhS6bWTKA5oVpSVbw3teYJx5Vo1z9KOYPQYeXV31AsA2nCqLnO+nj8pazH3Lk1OMLSwQdgK8pEz0kPn03DyulXAzdTFaqv7FxZEigOEv0HG/SUzkI3QA0xFUOI+CkcPPdfpm3wtbdyP0c/F+O04vWjnjgL4QgXgKa9JU1iJw8A2M4C9vC3+awmjj8BmfUH9Gfs+EavXI61LxnaF/kuvbquv9u/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9TrE7HFFyVtEpIesS3HL1gRz/D1Fk3xem6tWhrAYVY=;
 b=rI0XMEudw/Wvo+BMDJO1BZVYVt4Qeoxy88FlIQti0Ol3phy5tkPBAyX0iXR30eST2dmew/VC9m0nF6TWGocdaoLM3qYmc+DRi3cRMfNgzP7Ha2Vv8KxeO0mquNAuLm+5cuoHBgK2rC2+6o4DQJ5uL/kYRgfm/rs3r3DFWjc3AkE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1520.namprd10.prod.outlook.com (2603:10b6:300:26::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 15:59:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 15:59:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQA=
Date:   Thu, 31 Mar 2022 15:59:06 +0000
Message-ID: <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
In-Reply-To: <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f45d0a-6477-4594-f339-08da132f62da
x-ms-traffictypediagnostic: MWHPR10MB1520:EE_
x-microsoft-antispam-prvs: <MWHPR10MB15203A224094EE3DE30C164693E19@MWHPR10MB1520.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSZZSEw02qUji0NjrtsK/n+WBpFJTdi2H5ynI0M4rHPfkjfzNXkjY8HYKo2mFiNZzUf3kxn1LjnROTWtNcFUxE5Vn5eJwIx07Mo8gKyY5DQzWZyZQuunxwyYIHy0qln24DWrrewKGzsnf6z6nVTNLv+MGU8d8JHFTUl1NyBMEadO+V+Kuh4meXJVcLaC7Fpd6joLLpZktKDkcg4Hgsa3WBT3Q65Py0mpyx3H5tqF4uzNj/+zbndOjjrr7yy1nrcifj6rn8d37/EfzUHUWDiUy267+41f4nGnrfoujMUfZa2WBDvUpo8AiLPBNextN3IRlY2BDGWmS5ebkUO4SdwWXHMBzlyHDypAWUbnsXpx7oVG6rYAfRJFaVrMARuJfe4EO5r6LDQLerpQOLxNed8pbQSCDsvuLNbHoCbUyk+t/lzIMg3giWCx+LIVn2u7hHBOMBYXw0FOuzQ5knY8IFzIj842vcSHvyN7I8QQTNAdDAmu+0cVwTzZbpvQ5K7s8unrtue5FXj4RsGtREmBIv/HJOOh4KMRAtYs55uuPfHCnUaS4LbneA5V3CjPQn8Nm0fidt8o4N3dsnAUoxPgxISqnSqkVUhwbwMCmJqZRcxCpnvvb5iHaKjhyRnMAIRs9aZULD5HQ7Y5i5di7s3HdcCK8OvgULU4N7VUMrAE97hxfoApvSujqubZBzwXhQ8XWtuWzVCe8AL4R2Lh5rbEw9JNFHxHd3QbY5lUbb1CbYJsEqdSR4KLktbmbxkWt6NQ+O0Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(4326008)(8676002)(2906002)(26005)(6486002)(38100700002)(508600001)(45080400002)(36756003)(71200400001)(2616005)(186003)(3480700007)(86362001)(53546011)(6506007)(316002)(6916009)(6512007)(38070700005)(66446008)(66476007)(66556008)(66946007)(64756008)(91956017)(5660300002)(76116006)(33656002)(8936002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEepmdD6oYvStayVY9TtwJayxxUs/dWGbVCZzZ++l8/EMGhme6EVYU+8MZ/x?=
 =?us-ascii?Q?ydMd7KLINflCq4EpGz5axtFX29mMEazk2LqoYGKF7FnCtc7YOH/2o2ZCtCE3?=
 =?us-ascii?Q?NORLn8i7/7aWS4ZVrpg8WYw4/Ga1dyCCwG5q6+Y+7rbZ0ing6L56cGTnBIvJ?=
 =?us-ascii?Q?bzF3s1KTHh95GxAZSY6ZN4NZR9odpif3z2ZDqDGRmVtrA7Fyzrn4NZT7FUUo?=
 =?us-ascii?Q?tku+zatPWUfsd6is9e/h9cfd153aUrGi/aKJDWL1GFCshb+fNTL1mKc2aG6o?=
 =?us-ascii?Q?rMjwCNLOl0ad88yVPPyAuMq7DSUfAPcqz0sMCh4XZM9RshEoF5OlbKuLoqk4?=
 =?us-ascii?Q?ROQLJMK4mKWGqxACnY2fW1FYUShxmJTyQVZspv/CMjEGJULrIFbde9DUvnHR?=
 =?us-ascii?Q?QgrQJPqU2gELWd4rHnXWCa02R+zmdVgR1DLDPPOQOr1qN5txB3CD3YZcadzJ?=
 =?us-ascii?Q?Qq4fkbRTsN8Lk5AxaZO7tSFmUSFiBySkqR0IGuhwjedUBhk4FAw+B9Hq/ELU?=
 =?us-ascii?Q?MkzFT+xvE+InueIrJ4QkkRkP1DFix1KRi1K9jRsT0R7ZyHaEY+avrZ16u4I7?=
 =?us-ascii?Q?MPiJDUHB5G/CW1unwu3ZWLFX2iGMUEkchwwZebRfkPpGrg3p2Qz+2yUvVYHG?=
 =?us-ascii?Q?6BDGRtHmefS/q6QhPCrl2599VE49UYo+sHzPwizmx9IbWlzFvNP5CEoBI1KP?=
 =?us-ascii?Q?y4C3YbfPSLjWHxI+LeTCWXMa295QiXb7pbnBD6Ueaw/CpXPRJv2Bnx2eaDjx?=
 =?us-ascii?Q?3OaCoFpfcqrONB4dhSlqt39e1RknLfxZtjTA+Q9ux/qJJ4ZMRu40E1CYDXSF?=
 =?us-ascii?Q?ka9dJsWEjdfMyWUr67yobRj5ZRMAzO6RfvOJFQ1QxEmfxFruZqqViwnYZbJ9?=
 =?us-ascii?Q?4f9umP3qT+UAWgtjjDmMdiyaIYzA7mGmzX7A1gB1FxO5Odjy2HtPvPpAa9MI?=
 =?us-ascii?Q?5BAniieOMG3ZxSd+aHTeHPUllRqYLGaYwkNUyIHN3vqI3UW2FLwp98FNwaXS?=
 =?us-ascii?Q?8d5V9pCdz7ogYpTAM+IlURv0eJh/zahT3vhKtHb9QwQMAXw7Pod/uSCYdFc2?=
 =?us-ascii?Q?UVCWK+toGQQz2m1aClYl9zfbUijDcVarJO7smfiETRnqCcrgqdOq+oV2H1Wm?=
 =?us-ascii?Q?rucYdSVimit3TyQn+tEY6pcVldkJph43xGL7o+liGNvu9fJN7YdWmMu4noa+?=
 =?us-ascii?Q?3E4qyBd84A05TZn2PcG2BrdibguWFMGTWSpjv3HssVayVC0yzqhzqqBrXIKf?=
 =?us-ascii?Q?46LB9R+nx77/cMUO35xIHVnqb0FGrrjpHKrHrJjHMDLedwzDb2xTeiXHDIr8?=
 =?us-ascii?Q?tYGKY3Rsbrs2qMj/RwB/gBP1AJZHXSn2Y1HUB23V0z5/AJ07dOK6HPhmvJ8I?=
 =?us-ascii?Q?lgG1LdaxMZd9urKNIwaTgeAFyEz0747gxfS5JxL2YyXbDL2IXi1+Vj9jZDwH?=
 =?us-ascii?Q?X7HhAshTqnJYLnlCwpvvRURcPJraubs5iaK7Rs5BwiWJIhpkDDa3aIy5vB8X?=
 =?us-ascii?Q?MHGmriLMq8hzxwycDb375ebSlRlpNGGFPcVi00PFZzphZp6qXI6YV6outX0q?=
 =?us-ascii?Q?Fmd8qSXfBozT1VPEVCHbGfI6B/ueglxo159IvOrTlEGgJuvdM0D3s8TgbwP6?=
 =?us-ascii?Q?KgPM8VywWWBWoxtp3VCOYib36Rt3yZRa6RbpK4SEZbm6ozLEhiL7e7iiTfbI?=
 =?us-ascii?Q?7JJf43mHDPpAUjMTFaUwXXal8UtkitH9JIRVpPI+4C55x7qZiC04gzg0rart?=
 =?us-ascii?Q?MFzyNY/CMBaSy9woPKpg820D1TL2mY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <209F2D0CBBAABE49AB11105F0FD670D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f45d0a-6477-4594-f339-08da132f62da
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 15:59:06.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdmTspLKIisUP9GDUZhPd9Le7ZvdDL2jhQF0uTvRLBcv9K+4IrGxBLgtV7NmJTL5eiAeJg5SKTUNj6hkavfgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1520
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310089
X-Proofpoint-ORIG-GUID: 7AO_Py84rvZANaOhCkBb4s1Kbc9TLq3j
X-Proofpoint-GUID: 7AO_Py84rvZANaOhCkBb4s1Kbc9TLq3j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 11:21 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Mar 31, 2022, at 11:16 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>=20
>> Hi Chuck,
>>=20
>>=20
>> I'm seeing a very weird stack trace on one of our systems:
>>=20
>> [88463.974603] BUG: kernel NULL pointer dereference, address: 0000000000=
000058
>> [88463.974778] #PF: supervisor read access in kernel mode
>> [88463.974916] #PF: error_code(0x0000) - not-present page
>> [88463.975037] PGD 0 P4D 0
>> [88463.975164] Oops: 0000 [#1] SMP NOPTI
>> [88463.975296] CPU: 4 PID: 12597 Comm: nfsd Kdump: loaded Not tainted 5.=
15.31-200.pd.17802.el7.x86_64 #1
>> [88463.975452] Hardware name: VMware, Inc. VMware Virtual Platform/440BX=
 Desktop Reference Platform, BIOS 6.00 12/12/2018
>> [88463.975630] RIP: 0010:svc_rdma_sendto+0x26/0x330 [rpcrdma]
>> [88463.975831] Code: 1f 44 00 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 =
55 53 48 83 ec 28 4c 8b 6f 20 4c 8b a7 90 01 00 00 48 89 3c 24 49 8b 45 38 =
<49> 8b 5c 24 58 a8 40 0f 85 f8 01 00 00 49 8b 45 38 a8 04 0f 85 ec
>> [88463.976247] RSP: 0018:ffffad54c20b3e80 EFLAGS: 00010282
>> [88463.976469] RAX: 0000000000004119 RBX: ffff94557ccd8400 RCX: ffff9455=
daf0c000
>> [88463.976705] RDX: ffff9455daf0c000 RSI: ffff9455da8601a8 RDI: ffff9455=
da860000
>> [88463.976946] RBP: ffff9455da860000 R08: ffff945586b6b388 R09: ffff9455=
86b6b388
>> [88463.977196] R10: 7f0f1dac00000002 R11: 0000000000000000 R12: 00000000=
00000000
>> [88463.977449] R13: ffff945663080800 R14: ffff9455da860000 R15: ffff9455=
dabb8000
>> [88463.977709] FS:  0000000000000000(0000) GS:ffff94586fd00000(0000) knl=
GS:0000000000000000
>> [88463.977982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [88463.978254] CR2: 0000000000000058 CR3: 00000001f9282006 CR4: 00000000=
003706e0
>> [88463.978583] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>> [88463.978865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>> [88463.979141] Call Trace:
>> [88463.979419]  <TASK>
>> [88463.979693]  ? svc_process_common+0xfa/0x6a0 [sunrpc]
>> [88463.980021]  ? svc_rdma_cma_handler+0x30/0x30 [rpcrdma]
>> [88463.980320]  ? svc_recv+0x48a/0x8c0 [sunrpc]
>> [88463.980662]  svc_send+0x49/0x120 [sunrpc]
>> [88463.981009]  nfsd+0xe8/0x140 [nfsd]
>> [88463.981346]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
>> [88463.981675]  kthread+0x127/0x150
>> [88463.981981]  ? set_kthread_struct+0x40/0x40
>> [88463.982284]  ret_from_fork+0x22/0x30
>> [88463.982586]  </TASK>
>> [88463.982886] Modules linked in: nfsv3 bpf_preload xt_nat veth nfs_layo=
ut_flexfiles auth_name rpcsec_gss_krb5 nfsv4 dns_resolver nfsidmap nfs nfsd=
 auth_rpcgss nfs_acl lockd grace xt_MASQUERADE nf_conntrack_netlink xt_addr=
type br_netfilter bridge stp llc overlay nf_nat_ftp nf_conntrack_netbios_ns=
 nf_conntrack_broadcast nf_conntrack_ftp xt_CT xt_sctp ip6t_rpfilter ip6t_R=
EJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip=
6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat iptable_man=
gle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter vsock_loopback =
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock bonding ip=
mi_msghandler vfat fat rpcrdma sunrpc rdma_ucm ib_iser libiscsi scsi_transp=
ort_iscsi ib_umad rdma_cm iw_cm ib_ipoib ib_cm intel_rapl_msr intel_rapl_co=
mmon crct10dif_pclmul mlx5_ib crc32_pclmul ghash_clmulni_intel rapl ib_uver=
bs ib_core vmw_vmci i2c_piix4
>> [88463.982930]  dm_multipath ip_tables xfs mlx5_core crc32c_intel ttm vm=
xnet3 vmw_pvscsi drm_kms_helper mlxfw cec pci_hyperv_intf tls ata_generic d=
rm pata_acpi psample
>>=20
>> Decoding the address svc_rdma_sendto+0x26 resolves to line 927 in
>> net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>=20
>> i.e.
>>=20
>> 927		__be32 *rdma_argp =3D rctxt->rc_recv_buf;
>>=20
>> which shows that somehow, we're getting to svc_rdma_sendto() with a
>> request that has rqstp->rq_xprt_ctxt =3D=3D NULL.
>>=20
>> I'm having trouble seeing how that can happen, but thought I'd ask in
>> case you've seen something similar. AFAICS, the code in that area has
>> not changed since early 2021.
>>=20
>> As I understand it, knfsd was in the process of shutting down at the
>> time, so it is possible there is a connection to that...
>=20
> My immediate response is "that's not supposed to happen". I'll give
> it some thought, but yeah, I bet the transport sendto code is not
> dealing with connection shutdown properly.

I still don't see exactly how @rctxt could be NULL here, but
it might be enough to move the deref of @rctxt down past the
svc_xprt_is_dead() test, say just before "*p++ =3D *rdma_argp;".

In any event, it could be that recent reorganization of generic
transport code might be responsible, or maybe that this is just
a hard race to hit.


--
Chuck Lever



