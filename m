Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4A4EDCB1
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiCaPX3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiCaPX2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 11:23:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D10220FD9
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 08:21:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEx5JI007047;
        Thu, 31 Mar 2022 15:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LU4d+sb4ES5s7l/2j/LvOqr+rNe15jT6tqF3oJtfxCc=;
 b=ohtFyFeXys8/VWF8wuLOrBFBHm+E93/OMj61cmzD9ccJ5nq4H0sTqWmd2YE3j1gIhsS1
 dpcsqXaN+HlSM5qHVz9dz7VEv4o/d8KCLm9+Ca7ZKocT1Md6Ce93t2tMW5cPIJzBVNGS
 oQ//Dbtf05W7M3jgk7ZS+8/JiYSEwBzNIgHkWt3ntveBfYY6WhilmHD2zGLS0J4x5ID9
 5r5wKsxo+iQU++R486ooVLtnhhEbd/TKTf19Xv49SiqcSoTudepPsOTSO4Ld2pdKPqDN
 mdEbWEIl6O8ng/vzOqboUm1XtS9hDVp0B+ZCwVBIri/KM2RdivPKcIawO259aP0KpJQK /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes4mrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:21:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFAZ60023789;
        Thu, 31 Mar 2022 15:21:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95gxab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb90X927QLG9vjLytuWnnBzGMDrzMcy64ojkFAjF0fXk2xBYYJV5SRNkrZPAMdgciv8825aLz55DwGOcT8Z+cbLaRzld0+131a5WjY83wUiwtbUkN7EzJCw8IgzRj9PVzUlX912qyafAcNUSYmoc14O3AKCMI0YmJp9Uen4cz7PfKD6qf6Gz+ujOMrj67xcseyEqCAkuDVgv6btpIrr1zwEOhFfVeA9cnY5A4aCymxVq3oE7U8uYVw80m790zGFVwOQIrG8GtnHAdIBAHiu5uAj30wQvJrYCfW1sYbsWYj9ttWocjxqBtxVBTNyYje8PH23NB38XUDsJmxC1qQKshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU4d+sb4ES5s7l/2j/LvOqr+rNe15jT6tqF3oJtfxCc=;
 b=ScQcoOEr67H+CHR2JIPRXxJfdyOWv4gdrzsyep6+rTrJ3XqR6C68DAlWZP+vfHyaGrDOC4pJ9nw6GvsW1EcdxaGp5POyvdwoOir5v4ekz0BiUDRuCue5dKUZBHq7ixOq5x6rtQPwnDjU2eQCq+uyTRybP9+1u+GN6d8xYwkY5ODQk+NAgtGn7oFKt7Tv643eZkR7vRWVwx/x/BbRKjyFSog2v+XYZXDEIKrBQanH+k3C7RPIL9zik25UZ3J9Rlzyf1tYfwdIuVkigCG55WWGSJFSgB8jBu1VhbJ5sU5KTNaDJN280qKtM2kGk3wzJXUTBXp3euJYMOubj+mXLlplzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU4d+sb4ES5s7l/2j/LvOqr+rNe15jT6tqF3oJtfxCc=;
 b=Iwe1EflApCDMJ5SxWLMOxUlhqZgHZvZiCy11fvlNbwWon47//hIQLMUw5Idhtfwt1/BcEWMYcGC6+g4yRenhI5511bC+l1zs86OBjV846CAX48Cd20fX3BU5oWgbKgJJm2t+ng19iiujw02zvB57fVBR8MDDGTGkAO85XdOgf64=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2457.namprd10.prod.outlook.com (2603:10b6:5:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 15:21:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 15:21:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94A
Date:   Thu, 31 Mar 2022 15:21:36 +0000
Message-ID: <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
In-Reply-To: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ec0274-8953-4607-4794-08da132a254d
x-ms-traffictypediagnostic: DM6PR10MB2457:EE_
x-microsoft-antispam-prvs: <DM6PR10MB24574267E64782D727248C8F93E19@DM6PR10MB2457.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/BKf20o0/yOp0YiUPImNSiiGOr9FEnyXWs6Dkflmrrjzxd/jjRerBxCcvi7eKp8l7cjsqCYDPJpdvO86QuacIwy5j/es7n+m8cRv6BM8SLQ9sxclzjUXVJ4lVk/hbWfBqr1oYqRZuGl5/pY7dD3K7CcKmsaiPQbxYaisiyMDVOjz82RwGvqZ5y6ETKNqjf7TZPzipOPoP4v1S++nA9Tv05NqFbquxVdFmfDuQaecURgS4oE54jNWbb+M7kOjlr5YPNNf6tPwdM7prnDk+825hsLr3/MQPo249m7hvDzvZ/AvZcZzmvinvw4UuO4X3qANmVk52i7ndUAzJvooR6ETcDHa3HUStgsSU7MRtYT1H4Pxz7MmpT+OtlYtLW7o9gEIDAAf24I+Bge/cqqx2gebsk2dFlLVBD7F3ooYSEVwWKzKw2qRiA1ItVtsZ9IQ8UT7lmdlz690QzZYI625CQbf5zRFDcnIpkcEjRxlRHCYUtq31vSuykBCTMZiU6WLfuvKNMH5UIZsgcGy8OIQYCefxXIxvfWtshxRG/W2L25pGSraezbpjn47TVLrfkr2WMzn92a7nYW4a8+4mkjeuvGPxlm7T02+3D11Qsk+PSopx5FfDGrs9YG0kMnjsanCSfGQXE0KynD8fQdm+CYXEWnwpzAR97xK7lCRRJDkW09NCfokq9lv8eU09+2TkzmMpQFRrgLL/sczjGTS8eyw2tvxJQk2PeM8kVSysrkgH4eM9TT4veDUyTVbkezR45IchQV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(122000001)(45080400002)(76116006)(66946007)(66476007)(66556008)(38070700005)(3480700007)(64756008)(66446008)(38100700002)(8936002)(316002)(91956017)(5660300002)(6916009)(508600001)(2906002)(71200400001)(53546011)(6486002)(86362001)(26005)(186003)(36756003)(83380400001)(6512007)(6506007)(2616005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nLfvrxuM9KgL+DbuQiyvoTBB5Hdt1MhEOAZ/+h4ePmAQgQ9a6uU3CD+/6XvZ?=
 =?us-ascii?Q?TZ8UGzl32jTVOvGnEnPQ6n2p94waJAOhcjbePC+DMb24sSpJaF7GeG/NXjJr?=
 =?us-ascii?Q?SIt3KFwr5KQhdgzDVNfbA/Ti5KIw3nHEtuOdC/Ytgz2KwfnkkyKAaa7xxB9N?=
 =?us-ascii?Q?3+gefYn5Sp0J6NdbubdXz35l2EI6v/iVmXCjqgYpHcagDFQgSKV0qFZ0hqTq?=
 =?us-ascii?Q?uggeZ+SLHpsPNkXIU65OKgs4Al9V+H0NsyikwM42hdtgQPwEhvT06hTR1nzv?=
 =?us-ascii?Q?DOsxfhdlMuI4QHPSFcVUqroiOfhwbn1zfez5K8vVDg7vWk9FDxuYFptdCvQt?=
 =?us-ascii?Q?H0t3iQU2SDcfYL1o1TXQWI3aXCrvOY44x43282msl2yO/f6OkmyXZ//DXZBw?=
 =?us-ascii?Q?4B5M8wgcjRJy8LxvoISAYtSSvGLnUNxE9hNmYGCg0cDLcaRzBlgLdBoNY7Dm?=
 =?us-ascii?Q?9IcJvJ/D0rbFPDgyuZ70xj+AezMgGoEBT1SzniqtpvPZ67i6cppV22VdnO70?=
 =?us-ascii?Q?ppN5cpcCrnCMz6O6PLHQGcVQzXudKKitRdYheFG4UA67IbC77p2ncNBfW2OU?=
 =?us-ascii?Q?+o/hV37MNsFouYrulauyuluRQUVB3ifcJ5JmQaPaWxVUFcrMcrYXZ9MbTUDS?=
 =?us-ascii?Q?OGDYoYnaOr6F+Qs/Zo+EuYdgXtYgtoOCmx/qRKLrEFU3uEfHtSfTDuXTisTt?=
 =?us-ascii?Q?Cz/Q6vAWp6bmLr8RfqpEZfvK7BytUEV4e8xHC+ZpupVzGcte37+Xho3U7UYU?=
 =?us-ascii?Q?9wXu0jsdqCW1yGclqpp2MANSmd19vGgKMF+xCG//EuCHf7tLvPWlDgz3S0W/?=
 =?us-ascii?Q?uYHf1P1gIQQpMv9pNMuU/YIRfbSvZn5ezFBk8bk5E5ywphv8GEL0Jmf49SIm?=
 =?us-ascii?Q?j0+BvZBothiCn77gAM519TsZB8FlYiagkZA6xG1cWsImwCnVeZCbRmQcdCLJ?=
 =?us-ascii?Q?nP+/ZCTggcaL0gWt2wMqI5tJbPSO5NEIvMd9q+jiOlBlwpYJ3MGysyX3k21k?=
 =?us-ascii?Q?KabpfcuTBhHCkdyWKb3w1iZj+R377t9wv/1pcEjUhQUTKD8ydz+3TY2rjvJh?=
 =?us-ascii?Q?NLGi0+++vPeyETTftoEjWx8AsqnZ5213IrIP/t7X3zr/XkXx3pTmgVcazJ+e?=
 =?us-ascii?Q?4gORWeLpbjDm7452dA41tszgYmSh6Bd8V3oUfstDQobYYJmRw9Qk0glM2eiz?=
 =?us-ascii?Q?qwITAZL+NbgGOB7yY08PtO1ULHKslsRgMemK/fjxURo4YJHUfJvnbSYLY49D?=
 =?us-ascii?Q?xLcp8i5UAz+rjtVax/5I0J9ziULsB0VPN+HNdWdlMN5DEsJmOJYNcujNouuA?=
 =?us-ascii?Q?SwJCR/mAhD2oohpxtZiInz1UY1bByCAmzbxn1OmKyTiqG2AkMN0ZNm0b2L6x?=
 =?us-ascii?Q?ALZx0cyg1wWGBXQIH88AWO36dWZqM6cRCgffSnxd2VNVYrngIXKk6T0yYNYF?=
 =?us-ascii?Q?FfipAyuSVfEKDROvJ9EdybIJOGULiiJyoUxoT2DVqRJFoge/7r7Xb4kXDYvV?=
 =?us-ascii?Q?F5nFG4GpHWl6PSmCn+MSHuJNW46ssI7iYbwaM+Jv7/ZvPaCmH6oX2O1j1+7R?=
 =?us-ascii?Q?MiROIglwqSkBzSkhaAVHTP3krtQz84FdYOIKPT8xRlN0DSYDHOosG9Nfjjff?=
 =?us-ascii?Q?p7aQJhT9JBcgGp0g4TIcoEzkWpdhAtIggn23lGxS8GJ9gj0n8603S2o6YLb3?=
 =?us-ascii?Q?7rcDWS38QJcf9cnMCGpqvf/p3yd3Ss5USNG4ZVpj7GQmd6wZ9woSUf2SHCQw?=
 =?us-ascii?Q?3Tn2iewNKwfABJJtqOKsVTEDB19A16U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DCA21E1AA76A04E9DF55569566E0421@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ec0274-8953-4607-4794-08da132a254d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 15:21:36.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vF0cGP43tDlYtGfW+wkhdbSaRJi/0M4Esd8I5swdX462yISke4pyUPlSUvgh56bn6UV5+4QQUmrPLuFo4XQLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2457
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310085
X-Proofpoint-GUID: bS7dDbxUo-Y0calNaSb5nTb3JjvT_--R
X-Proofpoint-ORIG-GUID: bS7dDbxUo-Y0calNaSb5nTb3JjvT_--R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 11:16 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> Hi Chuck,
>=20
>=20
> I'm seeing a very weird stack trace on one of our systems:
>=20
> [88463.974603] BUG: kernel NULL pointer dereference, address: 00000000000=
00058
> [88463.974778] #PF: supervisor read access in kernel mode
> [88463.974916] #PF: error_code(0x0000) - not-present page
> [88463.975037] PGD 0 P4D 0
> [88463.975164] Oops: 0000 [#1] SMP NOPTI
> [88463.975296] CPU: 4 PID: 12597 Comm: nfsd Kdump: loaded Not tainted 5.1=
5.31-200.pd.17802.el7.x86_64 #1
> [88463.975452] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 12/12/2018
> [88463.975630] RIP: 0010:svc_rdma_sendto+0x26/0x330 [rpcrdma]
> [88463.975831] Code: 1f 44 00 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 5=
5 53 48 83 ec 28 4c 8b 6f 20 4c 8b a7 90 01 00 00 48 89 3c 24 49 8b 45 38 <=
49> 8b 5c 24 58 a8 40 0f 85 f8 01 00 00 49 8b 45 38 a8 04 0f 85 ec
> [88463.976247] RSP: 0018:ffffad54c20b3e80 EFLAGS: 00010282
> [88463.976469] RAX: 0000000000004119 RBX: ffff94557ccd8400 RCX: ffff9455d=
af0c000
> [88463.976705] RDX: ffff9455daf0c000 RSI: ffff9455da8601a8 RDI: ffff9455d=
a860000
> [88463.976946] RBP: ffff9455da860000 R08: ffff945586b6b388 R09: ffff94558=
6b6b388
> [88463.977196] R10: 7f0f1dac00000002 R11: 0000000000000000 R12: 000000000=
0000000
> [88463.977449] R13: ffff945663080800 R14: ffff9455da860000 R15: ffff9455d=
abb8000
> [88463.977709] FS:  0000000000000000(0000) GS:ffff94586fd00000(0000) knlG=
S:0000000000000000
> [88463.977982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [88463.978254] CR2: 0000000000000058 CR3: 00000001f9282006 CR4: 000000000=
03706e0
> [88463.978583] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [88463.978865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [88463.979141] Call Trace:
> [88463.979419]  <TASK>
> [88463.979693]  ? svc_process_common+0xfa/0x6a0 [sunrpc]
> [88463.980021]  ? svc_rdma_cma_handler+0x30/0x30 [rpcrdma]
> [88463.980320]  ? svc_recv+0x48a/0x8c0 [sunrpc]
> [88463.980662]  svc_send+0x49/0x120 [sunrpc]
> [88463.981009]  nfsd+0xe8/0x140 [nfsd]
> [88463.981346]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
> [88463.981675]  kthread+0x127/0x150
> [88463.981981]  ? set_kthread_struct+0x40/0x40
> [88463.982284]  ret_from_fork+0x22/0x30
> [88463.982586]  </TASK>
> [88463.982886] Modules linked in: nfsv3 bpf_preload xt_nat veth nfs_layou=
t_flexfiles auth_name rpcsec_gss_krb5 nfsv4 dns_resolver nfsidmap nfs nfsd =
auth_rpcgss nfs_acl lockd grace xt_MASQUERADE nf_conntrack_netlink xt_addrt=
ype br_netfilter bridge stp llc overlay nf_nat_ftp nf_conntrack_netbios_ns =
nf_conntrack_broadcast nf_conntrack_ftp xt_CT xt_sctp ip6t_rpfilter ip6t_RE=
JECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip6=
table_mangle ip6table_security ip6table_raw iptable_nat nf_nat iptable_mang=
le iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ip_set nfnetlink ip6table_filter ip6_tables iptable_filter vsock_loopback v=
mw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock bonding ipm=
i_msghandler vfat fat rpcrdma sunrpc rdma_ucm ib_iser libiscsi scsi_transpo=
rt_iscsi ib_umad rdma_cm iw_cm ib_ipoib ib_cm intel_rapl_msr intel_rapl_com=
mon crct10dif_pclmul mlx5_ib crc32_pclmul ghash_clmulni_intel rapl ib_uverb=
s ib_core vmw_vmci i2c_piix4
> [88463.982930]  dm_multipath ip_tables xfs mlx5_core crc32c_intel ttm vmx=
net3 vmw_pvscsi drm_kms_helper mlxfw cec pci_hyperv_intf tls ata_generic dr=
m pata_acpi psample
>=20
> Decoding the address svc_rdma_sendto+0x26 resolves to line 927 in
> net/sunrpc/xprtrdma/svc_rdma_sendto.c
>=20
> i.e.
>=20
> 927		__be32 *rdma_argp =3D rctxt->rc_recv_buf;
>=20
> which shows that somehow, we're getting to svc_rdma_sendto() with a
> request that has rqstp->rq_xprt_ctxt =3D=3D NULL.
>=20
> I'm having trouble seeing how that can happen, but thought I'd ask in
> case you've seen something similar. AFAICS, the code in that area has
> not changed since early 2021.
>=20
> As I understand it, knfsd was in the process of shutting down at the
> time, so it is possible there is a connection to that...

My immediate response is "that's not supposed to happen". I'll give
it some thought, but yeah, I bet the transport sendto code is not
dealing with connection shutdown properly.

And btw, Hammerspace's testing of NFS/RDMA is very much appreciated.

--
Chuck Lever



