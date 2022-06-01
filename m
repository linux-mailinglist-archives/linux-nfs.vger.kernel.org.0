Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957BA539A60
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiFAAer (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFAAeq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 20:34:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2D68304
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 17:34:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNxPLj020753;
        Wed, 1 Jun 2022 00:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yaUEnxW8K/6wvb5G/FEtQYf2HPso8McRg4yF1I/fBkI=;
 b=IDl+ijI6Bh+h5XBjwt3yAp4vFpu+cgj4Eq3Ou7RLRzj30S3F982OKEgAOiM+Oq6Y87Ua
 Xej8WqJ1O8LWvmBOGcBf8dH7A5Co1vf89L5hjlblajf5lJCVks1O9o9KemI3ZuwZYhpi
 bEHPL1KazGZpmTmql7E2r2CXZyh4sAsdD/KJjcV8TPVCdnaLSnTethOs8fKxy7Jg2xzI
 7awnix5P760SfUQMkEaCtZWXcBiIh9oFe6RfXZ+parYxglhzFBNvPdRypa0t2AM3GN5i
 6aVO1h99WXP8Sxopq403sYrslQYSg6xuphUQCMTNa6AIuSCBYthXo21NarEpOxoSMFqy gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaupjre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:34:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2510ACS6035899;
        Wed, 1 Jun 2022 00:34:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hw8qaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 00:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NStv2dWpe8c09E9La5eXgqxOJo/6NwZAhxfuyv+LYNpet1KS80pMnmAaE2GpgM1vALl4yG/g1IbvBgzhvYO6xrqeQfe5sYPZtRwEtDfXcIlD9Q8MmqjGuYtI0b3d1ykHBLeER9HDK3wxMYVXK7TskLvx5rtiOVHnde0eoaofk7wScA1nnRqjhW117ZIe3mkh+Mw65baxiFTtU7kaZY/EXmR8T0brgxy0wKOA3YXCzwo1EvUej3toJ5WSDh8soJmo7VUAQhhEbIqBAiGiHLyPPwg0Y5JKgeXZO+UbzD8+qS2JrAdRhf6uTbs92807NBM3TXOr7znRO2V7rYl2pvOKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaUEnxW8K/6wvb5G/FEtQYf2HPso8McRg4yF1I/fBkI=;
 b=XAKMO3sSOCABAYYRuj1F0zjhd4+YSe+fslmhoVOz1DZFf3z56P7fTQpGhWCiLOk9vGp/YcBM7NdKxb7q0gef8NpFcqhhbDN7G4WtWvBFHzZD/txFvX64AKzHmv5TV0NzPUgQDSpCDPJaWyCb1gFcyUY18UCAMwqi5EKZ76QmK2BK6cjMFCN7zQ5vdhr6EwugrJo6V/BLfVsW+RA44di5rdSbeOw3r6XE+LE8AKUdZGMef89TmRMGZy6HJCZk/ZzOVHuQhrczLwfLVstyyY1ARCcdNqK8srvsV/lHfvpfcmyM2a6MTxleazR4dBIZsWfxHIitCYNOz5MoNxAXAxpsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaUEnxW8K/6wvb5G/FEtQYf2HPso8McRg4yF1I/fBkI=;
 b=Zie5DTTMissGmGUqfA6EcrzFkw7m1QxZEdQoDCu5Y0F5B0jyWvdasSCMuYOe8IXyhmD6fXDuoW+vNLksQFzoozsg+z5mIPgq+MYegsdVw5cCLDqSJOOR0wSVm8l6uPX6klqkaHaUxSb4Yz9RLYsP1qRQ01HOkaYyO+nKxMvTFAw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 00:34:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 00:34:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Frank van der Linden <fllinden@amazon.com>,
        Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gCABnuxAA==
Date:   Wed, 1 Jun 2022 00:34:34 +0000
Message-ID: <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
In-Reply-To: <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451ef4bb-8853-4724-f798-08da43668097
x-ms-traffictypediagnostic: BN0PR10MB5191:EE_
x-microsoft-antispam-prvs: <BN0PR10MB5191D2DA1D0CE8127FADFB4B93DF9@BN0PR10MB5191.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mLMuCA0Lf2m8wqNQRs1owd76jPyS+KmhsA2PNwMhAcefxANNpH/I3vPW/a9iXb/rB4zP2Y7rlYCkHhlOtJ71W7oh7Z1CNXvWOrcsINEg7XLhc0/po/K0IaiUKcpQQB0nvRNFwVW/NP1FPZw31ph2Aq1TziVfTfP8v6mcDRuYHTaH0NegMaXusiv4w3fedpIdv/Uk+MG6xmGXO6BLBosqfCjNptwNABjAXucr7gkPxZjchsHXlD5KQAywMvyULMumFAiR3SXQxXouU9bBykNrfEGrWi8G/oT2fl9IWlpSHprOWXkAhZunZ+JamN4UM6u85DCzbBx78iMC/0AsBCeZqaoSErtUgHODYUJCRO9FaDEBCHs33mEEtHMqcQzZrlvcUk7q5akTGyNKWpcIt5+HfkxALJpdgJxf80m1/xUHCy3EPukx1AF2o59VwZShvbS23xNdQYAnuG4J6yztdV8l95RHWAJC2Fn36+dpGQeENC3vwHwRGycvrPFTK7Nb2jciASsvKfbgpgupf0cgohieLNAlE4D9HQrQSw4KcqhBOwDErH1uAJZPK6gCfWqOXKq27GyMtNNNaJAewXOcH10MTtOiW+MdDKZBfNzaJCyVCy0AEcJqViDdXJR8kgU2myevmyg2m3myHP1WRGdO/RmQadjNy/s4aOV1mXqYSEHVNQZ8JpGtrnphElJNklfo2FXoMMCCTMzRjFsD4QEQZBQeGnxApC1O+vPjabGXJlIki8RzXAK9KfGbEJowu+8Yy4FEmyg1bVz7ni7ds1qiLpkY43oYsbGkx3Ds4dkQcoi9HA+2HTqhG6JkHvcTvLzMKK2vshUl9MD4JlvNovIHPxKHFyQtFh53huu52XwD/bzHy3E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66446008)(66476007)(33656002)(508600001)(110136005)(2906002)(66946007)(76116006)(66556008)(36756003)(186003)(966005)(91956017)(122000001)(83380400001)(4326008)(38070700005)(86362001)(38100700002)(2616005)(107886003)(3480700007)(26005)(6512007)(71200400001)(6506007)(53546011)(6486002)(8936002)(5660300002)(316002)(8676002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wWEs/1vgmaSAFe23WcTZXgWrr0qXw6ynPl9Y2gp5oLljmpslvBU+U92TrqsR?=
 =?us-ascii?Q?hdyft+s+dUiZn5ZTAk7lql7dvaLuLxInUIHX9Fl5Kpbe6fIhT8aVoxYCsZd4?=
 =?us-ascii?Q?cx0OQRjNmoOK4Y6eQFS1hbsYJlnpeheR3fomWDIEXDAmYCL9EucUeWb8sR2j?=
 =?us-ascii?Q?oFxxzijn29FOjIFxX4janpg3QH8hCkArd6sE/a0Yl2PDlL9xcGrGOOWsjajR?=
 =?us-ascii?Q?QlqsrhmyeQITqMjNbrzzTNpDp8kOawHhNyyrGeiMwTMle2lSElNpDEqVy+rA?=
 =?us-ascii?Q?w81pX//FzqnYBR7iMgTvRuS2xg0dXLH4V/lJKxb7Fp/Z8cM35yB8aSt5ViB9?=
 =?us-ascii?Q?ukeDK5oAtc8SzJlr492imzeqtwE60/PHsKlJJqzcci6jZa9W5YpaTNDTeZiZ?=
 =?us-ascii?Q?nvDD3o2O34ANakUWj8ZCQP7tap0OFyhJKprLUpRbJm59R5J3mXQvOr2mIAB+?=
 =?us-ascii?Q?k3ovvOgDXP2kbSEuzbwrbFn+z3x2j167S/LJOWn/Vn39wfeJeswnSa+z8sVh?=
 =?us-ascii?Q?x8iKvbCPR8n1DhmfX4xtiGMq5PfF3zophdYzl8C3sibJ/k6jW4Yhw3lNbPHz?=
 =?us-ascii?Q?Des9gPVOwaFEeSx9lvBogp03PKUfrWKomh9JS2WSwnGEAqzhUka255C5fsTj?=
 =?us-ascii?Q?mVY0qyPB59D8DaIXaagyoJ+mxnEv2aJEIVGhe/9wa2Fe978tk39AH5Sfhg92?=
 =?us-ascii?Q?FjIi/h89wnEc7JvDC8QVwuTjMFPghMuXMxPWZoSyRqg6GKq/XF7qZAaagOkf?=
 =?us-ascii?Q?EIOeBWwwjGsu3pZe3ORHuRpXs/2DlGur2iDYaURy26v+RcXbexv0Ge4m8ijo?=
 =?us-ascii?Q?OOxRBC4FNvbaK+Sar+kLWtiofKiFtlZJFBcYfNyuZKWKtJExbOlc7634HjaD?=
 =?us-ascii?Q?PxbsINzquMmOIZ3wQuMqwfNZ7rS3H21YZLdr3Y9GXvXglTVlebXCJZ6gGX+x?=
 =?us-ascii?Q?/3/ltSgGqm2cuoYs0utMCCXjlrjoJXCw3Z7HNx2N5Z3KOcsGZU1CpFDv8nhw?=
 =?us-ascii?Q?VoEg7wPLNHHf7CwBzBmX1fQZ0XJ6Ob/rA73MSgqR2VrnFUJ5b/d73B7upjln?=
 =?us-ascii?Q?7FbB9bIlCcW0RtJwbEz618yFxZvnmwmztYoJGJVHBMdfcJMKQBoVjbgxqKjT?=
 =?us-ascii?Q?E96xb5MmJjspLwb0ghUcDaQMejMeTGbAPle1YE4sgutPiYnp1pnS6LjQ/C0l?=
 =?us-ascii?Q?WIv7LSy0KeMuogBzWvFevRg4SbofbMPzGS2owlvHQI0U/mCA+AZqW3lHk+bP?=
 =?us-ascii?Q?gLwAx0BmnXfJ8kyAnuEuaq1MgJb2OAr1P6MYevT0IYqGZqjjDF/Xc1Dltati?=
 =?us-ascii?Q?57ZVBF/4NCfV97IjcIsuLZridM+dO6ZXaaniK5pzAvpCJIIe0it7RKPKSGVf?=
 =?us-ascii?Q?4sBl6C3jvcS11kZkPlpAiiuJ14WWVaNm4vbsTdtcb+617GBcyHKcRgPGgI+h?=
 =?us-ascii?Q?DTyvPqQ1DbaxcKF3mZN3DdeymzZ753zNmf3DMFcVdHT5b23VeXaJYIZshX77?=
 =?us-ascii?Q?D+oKr9ZtBsZXhtyvugBwHo2mj3q1chRRkyFY76D7JnS8E8VqEfzu3ppTRQUE?=
 =?us-ascii?Q?yxlBEA4bXXADPxTW2edCoJ0dWCdhwtiIaAGqt+k15MS7NQxUn5Uc0dFIwPOE?=
 =?us-ascii?Q?Nwm1a9NbzrWFqeca5LRD1X2EfKdAQTfUzLttxivivk5Rz7M56mAsnP7C1KD9?=
 =?us-ascii?Q?GuASw+WsMMSTmWPJ8r8sa9jvhRy5Ris4u3smxF1MrUu6kkbTxr4a1D6DcZD6?=
 =?us-ascii?Q?shTU/+CKsOv4+xbWrW6I9x8Nq9/W69s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E20BBAA58CDA7E469367AA163DEC1596@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451ef4bb-8853-4724-f798-08da43668097
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 00:34:34.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4A9LrCoHn0qRSgk7sI5KvahHy9PUzoiGWwG6Udo6lcHwIHSXi2qYS/9w2Js0vjEJOPFmtXLgvg6WzPDtKY0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310105
X-Proofpoint-ORIG-GUID: I1JLdGZaqYfmWeszScKdLm9_Vuiv3xtc
X-Proofpoint-GUID: I1JLdGZaqYfmWeszScKdLm9_Vuiv3xtc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 27, 2022, at 5:34 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com> =
wrote:
>>=20
>> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>> Hi Frank-
>>>=20
>>> Bruce recently reminded me about this issue. Is there a bugzilla somewh=
ere?
>>> Do you have a reproducer I can try?
>>=20
>> Hi Chuck,
>>=20
>> The easiest way to reproduce the issue is to run generic/531 over an
>> NFSv4 mount, using a system with a larger number of CPUs on the client
>> side (or just scaling the test up manually - it has a calculation based
>> on the number of CPUs).
>>=20
>> The test will take a long time to finish. I initially described the
>> details here:
>>=20
>> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinde=
n-2c-c1893d73.us-west-2.amazon.com/
>>=20
>> Since then, it was also reported here:
>>=20
>> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/=
#m8c3e4173696e17a9d5903d2a619550f352314d20
>=20
> Thanks for the summary. So, there isn't a bugzilla tracking this
> issue? If not, please create one here:
>=20
>  https://bugzilla.linux-nfs.org/
>=20
> Then we don't have to keep asking for a repeat summary ;-)

I can easily reproduce this scenario in my lab. I've opened:

  https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D386


--
Chuck Lever



