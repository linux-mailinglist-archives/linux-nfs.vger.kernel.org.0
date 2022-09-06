Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10F5AF037
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiIFQT5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiIFQTb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 12:19:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF49A2ABF
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 08:48:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286FaV6J016170;
        Tue, 6 Sep 2022 15:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zLEf9WRrLE1xGvPsFhkh8ZpSK0LaVzeg2fx1yK0xkeA=;
 b=UZxKO4bjevwt46KWoadOtbYi0X4swyVbZ18FqiRnA9ZNAJIIf4Gsy4miBDQWIEIoY1HR
 gHcJR+202vFdLuMTuFBUhc/ZYVVLp0shW93yQmSNkJ3YRODxoA1rom5ylde3NbqCcggf
 RNVi6h6Y/TXH5jaL10yPOqTjt7yr6PfwDziqBNCL2pJ8ti1RP9U2UmxzGdGI7HxG6HPp
 b8APzlkJKgMPOFrokyoACV0HS/TJEGgkse+vtnOA0GbjVBOKPJaEZf/F+VG9Z1Tqdr7b
 WcM8HSII1MJ4I67BNRwYppdsvR0HPO9/PcgCBobwsUYyjJAef5q+MNlWkdsRzHol6miq aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1ea5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:48:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286EeMuV031383;
        Tue, 6 Sep 2022 15:48:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc329p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWKfie//jJ/EhUIua9wsfRN6Cp4n8e9cPrvvDzijImPCTmaKgURUlSJp6ET1pMCdUsKhbIvcs7UQxoiQQ35iaulJfkCo9Z3rhZkjdYq4uRHQgkVqoPJF89mUOLHEYSiy4mpPYD1GCo0DKQ42qASd0qmfltDHpu4d0QFt+vJ0zimi2Hd0lfBw/DdTKSl25mQiaAqo0SvW4oldzOccGH2rAqfJGZZ5VMzQE2Ufr5U+5N2dLwX1n5vLACO8yGfLHIzksTStaR8DleCmGrQGm6sZS92Bg+UhMN4yRiAkxCLyq2Acu/WnD9Y8CTjQpFUtlrAwONjByubNMK2wvZsXmJBBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLEf9WRrLE1xGvPsFhkh8ZpSK0LaVzeg2fx1yK0xkeA=;
 b=W4Xd073K9Eod+qliHXr3jReb701hf5oWd2/ZcXqajJ8573tlOCHgVqtUv/PJ+l+jSp+yXwWak+rpaOYJJc840uDwTy1i/xJPEAkWfVn7YWILpYYVHsrml/QBqzyKAB2FjcnXYVhXL7KaN914UZmzyRaiZYhQie6GanSYdgh6gtjG0dd1ewYAHNLOWhTbIY8wHHPj5eIxL46Hd717eWZRoI++0UmDc1Rhfp9nMQ3B968DM7WOEA6lMFXXBy+9s12PTx5y9a3vFS+D/QFBaZuvp11klS5EaeahEnyGjMsevaT5VsEXwoRdmlewGxfeKFNWzLVMMmdR4xB5gzBgcwbk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLEf9WRrLE1xGvPsFhkh8ZpSK0LaVzeg2fx1yK0xkeA=;
 b=OKoeVyajhIB5cf4HMa6pLPKW46yPhgSOPCEABFba9FgvZMjEcHmZMLrR3PxVpQbZ+HGe29AdgR5jC0JgfL+oip5Y/y1sz+eVvFDGFaTTRR4IqgLmUFLVmfkiWSknsFZxuyy/GhcrFqBIU7nwXNPs+XoyisqNOFDB2wgZiQbdbW4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4721.namprd10.prod.outlook.com (2603:10b6:303:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 15:48:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 15:48:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs/001 failing
Thread-Topic: nfs/001 failing
Thread-Index: AQHYwUSkLMMEn+4AHka5Hmq2SfLVB63SiIQAgAAFHIA=
Date:   Tue, 6 Sep 2022 15:48:18 +0000
Message-ID: <BCE0DFE2-A635-488C-80AC-64316DDA61D5@oracle.com>
References: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>
 <CAN-5tyGxxp-TD-zjjkMoS-snPYyfy+PuCV4BR6eofdmFt=-7Dw@mail.gmail.com>
In-Reply-To: <CAN-5tyGxxp-TD-zjjkMoS-snPYyfy+PuCV4BR6eofdmFt=-7Dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92375ccd-5503-4188-e924-08da901f37e8
x-ms-traffictypediagnostic: CO1PR10MB4721:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdbG40OXMXOX2xSurBoUIwJDkYuwEQ+2CaNC9fjSHjdum8aIEN7GT1FvG33laIXWj/gRymdN/QIzUTPZM9z5sAH/UopvEJYaIwx9DokwvST4ZyzbqJvXUvp4BlIxx1zi+icrpbVfGiFlzvpwD7dH0TiJjqqRf6lKhsVlCrHYq6cZXgnqZRlws+nVuqS+UCQ+EEcTSa0jPQtdujP1xY807B1VwCgoPw3itE8bhsX8BcmPr+EyZRJTNOqT+ceK3+Ar5czAZL6gFXnmza91f2RybSOzyoTT6PMtx+8TOvj+PPMLNzCR2QL86UT7OdnI/ZsDlGCRuhwt0lEcXoLYZEaXKbQ/oyWmuHVESEtpIorkLLDu7vy/L8lIfRifQ1Q+qMBiLrKB9x8rB8ZgjZ93sc1k/KAkn+q+ait6S8UE0Sj6H7Vsk6VhlrPbYE4Q2iYhUp+w7/usDhIO9soDwEd/NGZMB3S2ANx1fT7rSK4zXtGe0McsyErv9vFW3ZzvPjqfsg8Y+N41eXZN4hj3Rsn5RQ+myU23LEXcA638HtqY9w8UBK3Jn/LyfokmL9ByEmxLFO1C6yXfeLkq8KSGsg6VoW/gboRDPfwn4kRLrLebevL71IM8QELd2oUs+O8cnOWLtgWD/hN3w5i1G1MwGcgf8Ua24iNbmEYhxasouYlax7akxWr8dCmJ4iFZxcbpawV2NgUoJQHKSvHm2zsgsVsRO36vbMqE0AJCFG+Ypl2pg1fSuhcthIedAuYqhFLPD82tZzi5qE6haX6ghhPyjLIH8lyYvNLl+rAUwUPRNKqyI+/0xA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(8936002)(122000001)(5660300002)(4001150100001)(2906002)(33656002)(4744005)(83380400001)(91956017)(66476007)(36756003)(8676002)(66446008)(64756008)(38100700002)(66946007)(4326008)(66556008)(76116006)(316002)(6916009)(86362001)(2616005)(6506007)(26005)(186003)(38070700005)(71200400001)(6486002)(478600001)(41300700001)(53546011)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aiPArTqAkzfkZlNwE4h/PIfv1RhyAiWkudGLwQEJRbmzA/wUHbkXfFcB4I2A?=
 =?us-ascii?Q?OgSdNdTGJr1bn4lVxuxI9dS4Zs1SV4FzakEGadlRQFUYb9vJQuHN4C/0epCF?=
 =?us-ascii?Q?snVJqhPa42UislhVtYUb8hvRjDyt038QmG0gkPggzfRqhZLxUrHv3bZTWy4j?=
 =?us-ascii?Q?mMWunNlN6ZWNdZoKNRboXDP0lP+pvl60lhoC+GVBUxv6MmBtQtTBMjnl6tYF?=
 =?us-ascii?Q?p4X/Je229fmmiRJcxVfp1JgD1H07PcfxH7lVUHh7ekzd1VkjaqsPjWVokRv8?=
 =?us-ascii?Q?GbVsj/eKti0CpJdfsUfDUrb+gng9cEf7AbPgPYYRYxAS3owvpkCNpv7I2NfJ?=
 =?us-ascii?Q?j4OW60XYYsPgY6wmeM6A5mBHtLOHTKr3mCXBujMsOYAUape0iNhqThriEcTK?=
 =?us-ascii?Q?lxbIEeQwoe3c+8CcRe/x/xPKJD3XK+TJQbhXv2OzVnYMH2xTVWhN4LsXUapZ?=
 =?us-ascii?Q?WX4LB850qDsmZFwbydu0bJcKnusP2qACLmOMPfr0M3FSL+r6WezTVeF3wjn8?=
 =?us-ascii?Q?RlX0Qyj8/H/8p6whbYMvGsjGbZchJYTzWhMR+kf59uOKWs9UaFXs9Snul6mN?=
 =?us-ascii?Q?R4lvaQ55AxXwF20GR0kBJoJH5WRl7UQMjriWVtQsSm/6HGCHxjU8T+gJicnl?=
 =?us-ascii?Q?d5Nz1KslUx7qPzDWTqi8cn3N4ZQIrZiK2ZnrZcGOHuAadmmMV5/pzAhqxdrE?=
 =?us-ascii?Q?9tpHuAYog8ielfKma3c7khaVq0raVelnLa6JgrNookygdph0dihi9AqshDxx?=
 =?us-ascii?Q?KRexk0zZvSIGDuq1TEmVCCXiCPZTtPr0cTWGH8yRLudC6vKJQQSBfbXc5FSU?=
 =?us-ascii?Q?7s8uYR32Xntf/SDCftJT8Wwx7xhL5r8I9bGXcJ+5uZHXnxlFPQ4qPppI3clA?=
 =?us-ascii?Q?RGnsm1pzp8VoTvl2ug4xXZzln1uU8nDnBW2Veey7H6m08Ww4RA1EeDgUFXrx?=
 =?us-ascii?Q?ajb0fgE7qUKQ8uH4TRshh52LWyLlq/BKcqVqesSWYyXVppvGQk4KHI/DkdXO?=
 =?us-ascii?Q?LaBaox6Gj3tuwdogox1ylqfhdBzy7VW/8rvXWFNBD7PVD30XT4uhlSqavBos?=
 =?us-ascii?Q?ppnvLTUnjszccpGDcXwXvM9hewnnmic2KT28CTFdbKtlxy83H+Aqt3xbJUV3?=
 =?us-ascii?Q?C5J8VPNMmwKua9eX0okNXjQ0IDD+1vHkatmJZJf6p2OOaDH41T349JWCj3cH?=
 =?us-ascii?Q?5ProSZh7K9y1x87fubBcR/k1LiUEz4C9tfb15Muk9bL6Mw1ylra4oD8XhoHx?=
 =?us-ascii?Q?JwOVomVhd74wYpfERc/7xS4SIUq/+XbBjC1FwpGhqH6DYZGHsvLl/WIsqkkb?=
 =?us-ascii?Q?wpM/+7cTOGmkmqv8hn+FXSeH/TnUZ1Tmoyt9ivo2K/ZqTI9VqvCjmaEmT+r3?=
 =?us-ascii?Q?MYDMw/wJ4no7RCaKbhpi1BwmKdbWFzAL3R28CwVD9VgJKAvBr/LzPvVDqTYz?=
 =?us-ascii?Q?zLykqQ8SXjYh/r217YIaFsga6ydK/S4S6/H4MyfaBkE2a2nzDSmLDGMGXxPW?=
 =?us-ascii?Q?6vqiLpH0DWkteRwyHa/71P/ccLKMV0dOk6Aa4AaHlpliOKtZpnBgH4Vf1sJ1?=
 =?us-ascii?Q?xgGF9vnLoa9KYrQSoEfZUUtFaPD43kn3hfXRchkPqoGFA9DgD9bUsozsAino?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3C3223EE97BC044A6A731B0A8DD792A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92375ccd-5503-4188-e924-08da901f37e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:48:18.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKg5SiPVmEsReBhbMAK1SqZTPT8NXT90xloLmTrwe16PbvkcI3pjTkVbdjQXgvkPH3qMmtLlMpxhLmVW8Adwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060075
X-Proofpoint-GUID: G0mg-Z-WhtBdrkeEz5uGUesYVwDVYwnH
X-Proofpoint-ORIG-GUID: G0mg-Z-WhtBdrkeEz5uGUesYVwDVYwnH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2022, at 11:30 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Mon, Sep 5, 2022 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi-
>>=20
>> Bruce reminded me I'm not the only one seeing this failure
>> these days:
>>=20
>>> nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/0=
01.out.bad)
>>>   --- tests/nfs/001.out      2019-12-20 17:34:10.569343364 -0500
>>>   +++ /root/xfstests-dev/results//nfs/001.out.bad    2022-09-04 20:01:3=
5.502462323 -0400
>>>   @@ -1,2 +1,2 @@
>>>    QA output created by 001
>>>   -203
>>>   +3
>>>   ...
>>=20
>>=20
>> I'm looking at about 5 other priority bugs at the moment. Can
>> someone else do a little triage?
>>=20
>=20
> Is there any more info about this (like exported file system or
> something or a network trace)?

I see this failure on all filesystem types I test.


> I typically hit this issue when I get a
> client and it doesn't have nfs4_getfacl command installed.

I just checked, my client has nfs4_getfacl installed.


--
Chuck Lever



