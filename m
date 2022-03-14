Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489D4D8EE3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 22:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiCNVhB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiCNVhA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 17:37:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65C3E0D6
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 14:35:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EKs8K9000802;
        Mon, 14 Mar 2022 21:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CP0umLIw25cCM57hLWX06/HRylHs0l5cE4GUl6wZhhs=;
 b=HsfB5HMXiYauZEcBUnmccFALk/iRdDIp/MfZKjrPmgXPy/X1L63D6M2z448uM+TfwnQY
 +xKcDZMBGus0PG8XfSUzsSNTL44q13X4o5aU5KUrbBUFW9SQfH3Kn9UCI6Tv4E2VSp1H
 wc7Yi8HHcDMR2psi88bAy57EtDkAFVP4gCcCSyszpj/aRa3ggOcrqvsjuHjmprBuBVmR
 T8ggeQdXytGQ4eiF8v7gDymi1S00EPBYaQd9AM9EdItxCuQXZr2qXQ5o9UTyIMaQj12f
 HMz5DUS+Eioz0OyzEwMNPkxttKMNfhnnDcRQM0b/RPvA49EZIPozwJ2waK9XeCzK/dSs xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pskwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 21:35:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ELVchp003277;
        Mon, 14 Mar 2022 21:35:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3et64jg5es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 21:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSfi5pMZO5lAj7kLo2MP1ahdegAtNHvoX0TnVNEdovMdklAZrXEwXA7rTDMX04+VTDFQ6P4i/1GXJzSYjfz7IMRTZbGFJgIx1XWR1/Wmipm2ov+puaNzw8qOmPNSoxP71sNMJGPznjRol7GkcyRLOO0x7KJeeAvrfZjG2+A1ErurTigDrHzIcH0RTElQ1l7ypYF3EpgYxAUwbuQKAYs4fEP5alQGGQBDgJVIREh+G8CDO+uSu2xej74+KUXsoxdD31EL6KE6KlAFxm0EGm43VkixeNSoU/z5gp5bLtfKs8CALShKei2jwpoUzxDPlFAKkEmraiiLTNLgDgE8yY835A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP0umLIw25cCM57hLWX06/HRylHs0l5cE4GUl6wZhhs=;
 b=Q0zQeWktv8g2K4EVQr7kmNKQoTAwST5A1u1YWldfxg2twv6GQxVO06ZtaL11lwAU7EFzWtWacH+b4ziXZDvtCee6ksMwR/iX7Rh1Qx4Ic0Vtx6V3iOTSI8iPyZa7uOP56Nq00uEQV7SwWgBoihl3w7QKIPqv4NG8v6dtdDugN3E6FKHq9exYfrbd9cWQcAJZY53Pc0QTkz303APIizo16w2KRikkX5OXEsOzS/cDYSDVlxVGr6GuSB4az6npJMPWtQG7j9kZm8OAOB12e94pTtUUXKPOfY1J3Zs1c0XZNVhK4DjAGV1gg6PJewRqjSti4aW/8bJ2UdsAHWe+n9SivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP0umLIw25cCM57hLWX06/HRylHs0l5cE4GUl6wZhhs=;
 b=DDvIcsB1HFoaHNBP/eYNJq83oX7Es6E1+TkcaAaX0J10ukLfyi+0s3IQemMR5c41gF02zSA0Lfhhwto17EhDCvZKNlb4qgTMMxJlO/5iHg/178b1yVshI5PHxmNUSsCfxPNtHsO0Y+uwkFeJMBY/gsJISwGPVag5WtNozRMeuQ0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2187.namprd10.prod.outlook.com (2603:10b6:4:2d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 21:35:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 21:35:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: write_space and software kTLS
Thread-Topic: write_space and software kTLS
Thread-Index: AQHYN+t1B+vqcaPqcEao3l2OCHLB2Q==
Date:   Mon, 14 Mar 2022 21:35:44 +0000
Message-ID: <B7F08FCD-0EC1-4D7E-A560-6ADA281605AE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6aeef0d-8a72-4c75-622b-08da0602986e
x-ms-traffictypediagnostic: DM5PR1001MB2187:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2187FAF4AB49A1464CC52F9C930F9@DM5PR1001MB2187.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLAtU7RwblRvOkM2ccZ+SUo42TAuooREOBGhZAmqMilXYsahro67NERxg8HaTZfHoAuOf2mNFuGgIPdJr5KZPzF/BhsIBRTJBiYC25xFM7YB2avhFtcTuXeG6ypERNi+7ro4AfbCD6P4hhr+LDtby3241WEuG87Ahiy9ZtORXuHt2G9R+/MWad+xIgIs/LMf55gyLkHESFi3tOA/gw4qJVpzB07LlXs3I1ToZvypgaGoFMkHZCXYBJ8ju4O8w3drwH8fUNs1acS0Ow1RuBLI0E8fZ/SOFoqbtzVBY/Rg7WnYe4jxrFkJgnBOBbk8FLOvZqONnXF4rTrVBHuaqCO7cUx6cKG4ykOKXJpTQgugEAA4rKvqyulcYFaAVuBfxNA1rZvaGYnVn7tgBM0/rOlZkEL7Iu1/Eno6O2R5EOZIXy3QQnR8mMlM4eH+eNN0z5hSG3s9ch7A7J7kRyxRv3HIWBe6Y4Ua+60mYd7Q+rnvQrFMIBn6R261ECG3Hy4/KOQ9iyNeizk9zDkvqmmFG772fyuThz5jsH0uZ9wPaVwvslJof75ntz/HE1ZVpcBWGZLQ1UlZAbqJS7YJQevM15Z1SfooyChvVPx4wpWtf58cr1s7AvL6MkDvvJMsU32hA0OSbnZ1nR3LqBksNFxY/sSxGRsYeOQf6gVytRm7jhkEdWVMYgHYTwQAx2gLqaXTLzCO17VOD/f5lgcfJ6NlX7Tiu0amakwUDrOBr1A4qhmF102PYjpbGb3/10I9eg64FHy/R2rvhgALFuEfhif2gD8oLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(83380400001)(26005)(2616005)(91956017)(38070700005)(36756003)(122000001)(186003)(86362001)(38100700002)(2906002)(6512007)(6506007)(4744005)(8936002)(71200400001)(5660300002)(4326008)(316002)(64756008)(508600001)(66446008)(8676002)(6486002)(66476007)(76116006)(66556008)(66946007)(6916009)(486264002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xIXBbt5bYgQFFZhhtLnYoyvUzC2WIAYkpyyXE3Er4ZllDy+Jvs1WVaRIK5P?=
 =?us-ascii?Q?fQ1MOYICl9Ydk3OkazhDuPtI/2GnUtuTUrHXeoKh1JgOUjp7rPZmIpd6cnw4?=
 =?us-ascii?Q?F372XZr635a3nPv/U20HdQ8YdPdCsg7JnZ3Nv51thGFjE1PPTLOItk+mGgJn?=
 =?us-ascii?Q?SlpaI2dah7JucFAKX02Vps3AiW+5jTk2uktgJ454P0y6R2qRLdnq+Afh+ovg?=
 =?us-ascii?Q?6UH5IC2qIeWLEbVL1D32SPdvAy7ijUSvRXwJL2P0D2CwdIkzdk/UVsRRtnO8?=
 =?us-ascii?Q?zsayCBQC6G3nL/NxKBXIOZndWJm28wxEyUfJdU7EchZtTUb8SrVpz7HuUUTZ?=
 =?us-ascii?Q?KC8T7mNqK8cUbSEFHiMCkXyax8VyZiZ4JAI2DN1xS9gL8tAk8/Svy41BpdXK?=
 =?us-ascii?Q?tZQvccs9M4uEh9xsaEkSsVyT7pu6YZWqOiOph0i5dfK5l1MXR7WegQumA9mb?=
 =?us-ascii?Q?qF2KqeHqSmFAbmX6e3Qn8ENErADbFOohp6V0j3sHFPANtLTrfaQPSdJ5toXO?=
 =?us-ascii?Q?SAa4mtrth79Qx7PYIVlVFCq3AtV/V+eBVND0Uwl7zlUQikP3BChu9c7aikGf?=
 =?us-ascii?Q?VOteeyPHBTIqwzwLcBQ0aX6MnsM+tlwCznVqTxmvsZGeg23T3DvSmNfeOvGm?=
 =?us-ascii?Q?R3Tm99jMcJXheifTnwzqFCufp4t+jf6Hh+8af4TvhnA3c2hnyzTrIeKBXagN?=
 =?us-ascii?Q?4J6VaMtlND0LsoHZXxz9u8bxPaL5ddjayO7jqm2bZ/t7r3LdmW6xnKnfjN+A?=
 =?us-ascii?Q?0ve9YCtQ25FmJqPdCGJ1YKb9vT3OHVJ/T01FTLcEnSF4MgVSVpvpXSYQeg+S?=
 =?us-ascii?Q?i3SkG4HkuAfjw5tC+m9kjelXYog53K8R4HiiqfhVUg8PTfY/Fv5p7zgU+XWn?=
 =?us-ascii?Q?u3FS3rswlhDYfNfaGzEyZYG32wFZS3b8h7WclNoBnjPZ4lRc0pXkYBWJeb7U?=
 =?us-ascii?Q?+4fB5d0pgW4cqlOuU81KNJVzzowekS+ltoGYJ/YPys/m/k36fwMvn1K8zKEX?=
 =?us-ascii?Q?16yqh5RK9ZKK2GH9WM4NCbaacGxcwHUu6kIZsAzQFF/jmoZZIYaKXSXQ3dDp?=
 =?us-ascii?Q?xFR0t259t+IUF2jffibVj2EsuBKd5lIxx5W7+jNqpbBNubWT+KVEsmpY1AUO?=
 =?us-ascii?Q?hu3GylAezocyvcQh0YbYZ2uLrG2nNXXImNZJGt/28D2sFn+bPrTNYjAVe9Es?=
 =?us-ascii?Q?7NO1StmOesyQvIbaHjF9gdyZ/8VSoaDvOxBObALpnHGdR8xxC2VQywKW1Ela?=
 =?us-ascii?Q?20aZJpO7fJnZ+8E1IJKI3t3MDHUAHkw+l+WAD9iir/CycSU4LukBJoK9NCRC?=
 =?us-ascii?Q?x46GdmUo5wkDWlLSuk1NNyzkNy4DU4DjQ4VlxYOnmHkePVJQbvHEEogeWOAX?=
 =?us-ascii?Q?mkZXjrWGalKFeuvOAy14wEI/mDG8KPr4/yZz67WiTG/kFqdx1OcN0eqWTK36?=
 =?us-ascii?Q?9pxMG73KIX1DDP6/c2AP89fXiaB/CWfomcmmZAefD5DkuFLhQrP6IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08342B650155AB4D88DA86263B3CA657@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aeef0d-8a72-4c75-622b-08da0602986e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 21:35:44.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPWj4lYqv5niIBqBWV/BiOI0eDa8ggjPkD/1Nr4fEdu2anZs4YMP/8szKu5N+JKAwB+eMiuSTEgozcOMnS4jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2187
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=798 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140124
X-Proofpoint-GUID: VISWr-1FXfON4WlKnDtS454fR3WkDWnR
X-Proofpoint-ORIG-GUID: VISWr-1FXfON4WlKnDtS454fR3WkDWnR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Trond-

I've made some progress getting RPC-with-TLS working in
the Linux NFS client, but I recently hit an interesting
snag and could use a little advice.

The software kTLS infrastructure uses do_tcp_sendpages()
under the covers, and that function is clearing
SOCKWQ_ASYNC_NOSPACE from under xs_nospace(). That
prevents xs_run_error_worker() from waking up xprt->sending,
stalling an RPC transport waiting for more socket write
space. I'm not sure how to address this, and I'm interested
in your opinion.

For example, why check that flag rather than just waking
up xprt->sending unconditionally?

Also just for my own understanding of how the write_space
mechanism is supposed to work for RPC, I instrumented the
code that bumps and decrements sk_write_pending, and found
that under normal workloads, the value of that field goes
negative and stays there. I'm not sure that's intended...?


--
Chuck Lever



