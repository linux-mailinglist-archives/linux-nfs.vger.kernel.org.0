Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC73F60BAD1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 22:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiJXUlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiJXUkh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 16:40:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFFF8E7A9
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:50:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYSIh013482;
        Mon, 24 Oct 2022 17:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Fr8j8FglAo4ttGlOHXVmdXQbVcpHr2GevuC67w+aZl8=;
 b=sgG3Iw4kfHEnaJnsQTA2YCfmjInTnB2lHtu/tE+/iP+7tioWxxOkx2eVuJHWDvhePyH/
 WA+YdL7FXU0UrH3uW8niBG9xyV+x6q/miJyGjttHIphoBClGAE4R9j+RAc12HyExX3rS
 +srOcrwar6HnugQUxd2PDl8l1M22ZQ6mRGzXsvnUQI1xiR0dTulvJqnIR1JCKRWct+B/
 MUGG9m6tuwymyEINAgPKpd42X4dJGPKTRz9cf87s8+0U6O7DIhu3TBrmcYpOKvRveIf7
 WdWPI80CUx8dGXziAZbSpo3oKXac/e1qmjkMdeRI4WyLFY8npaodEMbdJ+b39Mnvwhmw nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84svb0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:29:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGMCMH034078;
        Mon, 24 Oct 2022 17:29:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9kenh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU5piDTwuAdoyMsETiyIbclsjnDT+GCiKWlNIYnJD5VQNVbI244fT1dCVDuK/zoKY97Vp4yk57KWx50OLzib1ySxr3RMnunHVoN3ScOwwpTJ/iGtvwANRAa5O2VqRvitOM2OHdyqJga8CCmKxlygvOK8/c8tUsd8eZceR2+RCdHUA0f60fEThR9Zbt7ym3Cjb/OKw92LnCwSiVHpiSANu7yWDXtad15k7z3kCC6Z7GA/ibbXXpajg15M8qybljKm3qZEm3eTRoU1d91/i+52lOKsaMX31HlMrAwxrbiXE9H+5NwgErSBMvb0CFl0VN5WapPnGpHYYsUoKNo2T1LADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr8j8FglAo4ttGlOHXVmdXQbVcpHr2GevuC67w+aZl8=;
 b=kMHcG/9I13c8QRDUuFcY8JpWBFn+f50T/7qdlY4THDRLnHnIe8gsMpIUfHi4ZkA7+TR94Xw+ARUqx6EFHIKJ3U95UINF4Ee5oGiUxO7hMchkm/3eG/wwBGQbu+w7aE4p0j/pOgHDZJnohxs2bdyygLi9PqZymzqTQKVBnhIVn5NC1+yvTz0XruFFQ8XzuRO/dopEkBtqe/KF7a4Ck1Ibg7IFmdIlVaORUL29FLB5i1iHVu8CxxWGNaWuvyc9NphrkeQnp7sx8EJblYITKxiQax4PoyUvC39XUjq5HR+Z5bWRtGpfxHQ8glbjxcZN+jXnnvztGUE6TelpkGuqCwFKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr8j8FglAo4ttGlOHXVmdXQbVcpHr2GevuC67w+aZl8=;
 b=Xk+022i6HA3Uu7sjPlGPlCkan2eHVeGi899PzwyiyLoV0aiuSmqhUKbYq6oUrymJBBeSgV0+NIzZT06yxszhgTPMWJ8UEO4eruJFRk/ACKaEyVOaIhZ4Ce6PVDFbZiMxiUFjdBPoyTMC3KcncDGCfa5gL7AxYXbeGVMs/fhR04A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 17:29:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:29:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
Thread-Topic: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Index: AQHY4ywL0+TmiIKEZUCtCfoSHjd9zq4c28YAgADxXACAAAjagA==
Date:   Mon, 24 Oct 2022 17:29:27 +0000
Message-ID: <07483E5C-D990-4D14-95C9-CE9CDF782CC5@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
 <166657883468.12462.7206160925496863213@noble.neil.brown.name>
 <3d86628c75009a4feb3d20804e6f190dee8b83a3.camel@kernel.org>
In-Reply-To: <3d86628c75009a4feb3d20804e6f190dee8b83a3.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5724:EE_
x-ms-office365-filtering-correlation-id: aac639ae-6d51-4258-cfdb-08dab5e54d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzTo9LFhLq4qplGW/Zl9ZK45yWCLq51/lx6C7BKeG2boCtDNp/eWC34NgK9+6WsnkBgm2HU9awcN+bPfaH97y6qw+5pagymSPZqRKjAW2O4z6jpys5H/UY4Y8TH6SUmGosvUP9bZ4TPG9RRYcf5g2Ig0SsQmSXM3TT8DB5MsyngGPy31y8t452V+9CNfh/1EXett13PH61MIDdEggk2fRPAPyXUfBhUpbYWvte30bCL3Qc8KzeutwqS6/s+I09/GzCtkRCDestwqpumywG/9rhgF+L/44ggOcR8lRF4WjSxzJsazBhBV3uZa0U8F08lId/qIQmMTTE2TuPz5WZj0hb+1JEEn78xKA9bqlrjysJbBzephQlycDX1cNSJ3h5r6BECunsCrqJFtvmGPMKETpDq0dalvk2MB0CN9+jECivzLNiK60UfaT98x+t7/6eBmXprHaka1LttAlHaB2na5iqE003Ztca5XLXcT9UYkpzXA8RnY4jJ8emOFzgdEfHBGaQrypNVkzwYWtY+EkS8sNw4fmwB9VOk3+kW+hBBS91JIpB/rBq5EAVO8HJuDBPUvZF247ggJEA77fp0MNHVMN3qGv+yanYpSEy1oSJ0Hy56UCJOfWXOXf+Nh81RLJ7FLoA0RRXF4BbKs9obVFmKS5x9YSc1yQ8uSf8EXIGa1qAbkXkeXp7Vm/ClT0QqpeTh3TQGKhfQODoFAdB71AjU6YcQlyp4HfP9NMUfBLuFETDZgH/gfoZysPC8sF4+8SJdTuR9LnDdSrg2gVVvePFaqUHKhJNqZrPaYRV6apbQabZ4rQTJrn2jUDQ+Iz2BpyJIbSJjlfjcvtFBd5mi3TGXKhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(8936002)(122000001)(5660300002)(83380400001)(2906002)(76116006)(54906003)(4001150100001)(86362001)(66556008)(91956017)(2616005)(66946007)(64756008)(4326008)(66446008)(66476007)(36756003)(38100700002)(41300700001)(186003)(8676002)(26005)(316002)(6916009)(6512007)(6506007)(53546011)(33656002)(478600001)(71200400001)(6486002)(966005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nk6JxzcUIvxdipCqVC44DxeO9Cmx5EGlHRoY10h9eDFB+enFc6rzdTEde6f4?=
 =?us-ascii?Q?MQLcotSqBbSK2VOT6KVPIGLvQjzWXHxfXBmB8HbiHilLTHXCklZXo8fc8J4Q?=
 =?us-ascii?Q?eVowo3rnLjxkGcPVqVxtMjzKAQxCnN510e+yFNRFHPtR5rfi2b/VF0k5Lkz1?=
 =?us-ascii?Q?5c7VbAvw3kZups/Lwz9lQCQZciEZ35PA1Q2r8tLSVxz9cVVwTkRW8buwLYap?=
 =?us-ascii?Q?Y02FwEP2LtxZ7LJclTEIW0j3Q7hOL5u3kTakg+jisTyDJZdSRduvk9SfiXJa?=
 =?us-ascii?Q?nCWNhRLvgHuqRu2M5445tWcuMN+YhagRXCzYbfVQ90Wat1phgusuXRKoutgq?=
 =?us-ascii?Q?l77sM8FB/1Mf16ipoZrLGc8URaUHgyWiA37+eqiwKcTDxthq2taifTotjwxd?=
 =?us-ascii?Q?P5S26F5U1RoOFVR+BaTA0rVzFSUgl9TJ1e/Cq3ByvnRixNAjKs+bgNgZMOI8?=
 =?us-ascii?Q?lBICWMIvhLuF4DR53CjFDir6voZnErD42uOJ2vpybWK4K6vP7Uw0rNZ3bZDD?=
 =?us-ascii?Q?IoFAtf2T1KPU8sxCiJCGRUO77KSE+mEmxvh0zNWMWCHt64jMVDceGvMPNiph?=
 =?us-ascii?Q?iLBkAA5Ibl6gSAoJjvGszURsG5gmfpGi/gksDTpAQ1/rt3VTvb0rHmd4LiNj?=
 =?us-ascii?Q?oHiw1lEM3sCi3xWOMsfluGnU5/YuGYUbWWmlHGaFf8gorYHuJltlTzZ6cEPM?=
 =?us-ascii?Q?h/0ODvktPcisdicffE4+ludi0iQPB90osh9HKK0W+JZXo68mWlEFNbobmLgf?=
 =?us-ascii?Q?PlghvFCmfgH2puadHABcESp8PFZFLjJmhwrM1E6gnQza/3LsKz375C368vEh?=
 =?us-ascii?Q?mC+gEiJmZ17hRyl3zhYVRDuDHkagYWCKAgSLf2yl4IK92r6KsIJcf4254HwE?=
 =?us-ascii?Q?tmCJAzZI+DxlszqyH8008+HOrI3HADdXUc1WUlJdLRjc78+zSNaIJkgTunsd?=
 =?us-ascii?Q?lteDgU+TJyKHjmxatTR2eAAvaiux70YV3pskR2I9i3IOOGBu7h/8s2oFRCYZ?=
 =?us-ascii?Q?vD13ZSfStemtSCThMiuUcPqm+wk722LwPVmuQhCJRDyAIJgV/6wFyiDEiQaq?=
 =?us-ascii?Q?1jGkXuGweV+TsBkSAr71J1anjo+3Z9FkSSMSZ+axoUraeag2O4Z++WDaNLuI?=
 =?us-ascii?Q?/0GCcRHboQBv8YHwLAoy9SycZj0Ijamhw/22fchyrzoa5XX+pPIxc3Ya0e0I?=
 =?us-ascii?Q?lOPqqonKfUZQlfz0etzmi40V90w4AkVGk0RuhQkZAg/F5kZ9qwKB5hqwsmor?=
 =?us-ascii?Q?ZTEYsldKXODtU9XJE2m/FtpNkFnWf8CjZSintz9b74EiMDPiQuV9mv57jv0n?=
 =?us-ascii?Q?q0W8YID9Xox3n/akhLXs6sjqpJZChuYBzv3V92KAkB/o4sgVuU523P9fBDX4?=
 =?us-ascii?Q?aKY3DWrYqNKrG22swpLBkAq0WnXf8jHmtx+gUV3CQyQ618xSiKus4meZcjeI?=
 =?us-ascii?Q?MnXtAXMKBXyciwgfjWJjn/wYIxl6kbd3sIbvnAv5Edvo2VIcFkqJBKqIBNU7?=
 =?us-ascii?Q?NDssTgzGdqiodG2uVTFhYV2M0xXHQZ/PSece2uPKqsT5cHIBEhbkTKGFGjAM?=
 =?us-ascii?Q?nTfQydKVcFz9R/vMRZYvIP3agDy8jbCHcDYYQK9tgBUKC0+IWilzhSS813e3?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14731EF4E840124B97AAE8E7FF0F154B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac639ae-6d51-4258-cfdb-08dab5e54d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:29:27.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LQg9w2v+I4fvZTY5KnqO8twQX4gCHHMg1paKsho5KGCP3wEV8Ukz8AsjfFG+sEyqGDGqbKYJ2/QPK7VYNsqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240106
X-Proofpoint-ORIG-GUID: KCUHsQY8jDdfUrYEi1-L0Ldy4YKLB6Qq
X-Proofpoint-GUID: KCUHsQY8jDdfUrYEi1-L0Ldy4YKLB6Qq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 12:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-24 at 13:33 +1100, NeilBrown wrote:
>> On Wed, 19 Oct 2022, Chuck Lever wrote:
>>> NFSv4 operations manage the lifetime of nfsd_file items they use by
>>> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
>>> garbage collected.
>>>=20
>>> Introduce a mechanism to enable garbage collection for nfsd_file
>>> items used only by NFSv2/3 callers.
>>>=20
>>> Note that the change in nfsd_file_put() ensures that both CLOSE and
>>> DELEGRETURN will actually close out and free an nfsd_file on last
>>> reference of a non-garbage-collected file.
>>>=20
>>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> Tested-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/filecache.c |   61 ++++++++++++++++++++++++++++++++++++++++++++=
+------
>>> fs/nfsd/filecache.h |    3 +++
>>> fs/nfsd/nfs3proc.c  |    4 ++-
>>> fs/nfsd/trace.h     |    3 ++-
>>> fs/nfsd/vfs.c       |    4 ++-
>>> 5 files changed, 63 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index b7aa523c2010..87fce5c95726 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>>> 	struct net			*net;
>>> 	const struct cred		*cred;
>>> 	unsigned char			need;
>>> +	unsigned char			gc:1;
>>> 	enum nfsd_file_lookup_type	type;
>>> };
>>>=20
>>> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
>>> 			return 1;
>>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>>> 			return 1;
>>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>>> +			return 1;
>>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>>> 			return 1;
>>> 		break;
>>> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
>>> 		nf->nf_flags =3D 0;
>>> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>>> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>>> +		if (key->gc)
>>> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>>> 		nf->nf_inode =3D key->inode;
>>> 		/* nf_ref is pre-incremented for hash table */
>>> 		refcount_set(&nf->nf_ref, 2);
>>> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>>> 	}
>>> }
>>>=20
>>> +static void
>>> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
>>> +{
>>> +	if (nfsd_file_unhash(nf))
>>> +		nfsd_file_put_noref(nf);
>>> +}
>>> +
>>> void
>>> nfsd_file_put(struct nfsd_file *nf)
>>> {
>>> 	might_sleep();
>>>=20
>>> -	nfsd_file_lru_add(nf);
>>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>>=20
>> Clearly this is a style choice on which sensible people might disagree,
>> but I much prefer to leave out the "=3D=3D 1" That is what most callers =
in
>> fs/nfsd/ do - only exceptions are here in filecache.c.
>> Even "!=3D 0" would be better than "=3D=3D 1".
>> I think test_bit() is declared as a bool, but it is hard to be certain.
>>=20
>>> +		nfsd_file_lru_add(nf);
>>> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>>> +		nfsd_file_unhash_and_put(nf);
>>=20
>> Tests on the value of a refcount are almost always racy.
>=20
> Agreed, and there's a clear race above, now that I look more closely. If
> nf_ref is 3 and two puts are racing then neither of them will call
> nfsd_file_unhash_and_put. We really should be letting the outcome of the
> decrement drive things (like you say below).
>=20
>> I suspect there is an implication that as NFSD_FILE_GC is not set, this
>> *must* be hashed which implies there is guaranteed to be a refcount from
>> the hashtable.  So this is really a test to see if the pre-biased
>> refcount is one.  The safe way to test if a refcount is 1 is dec_and_tes=
t.
>>=20
>> i.e. linkage from the hash table should not count as a reference (in the
>> not-GC case).  Lookup in the hash table should fail if the found entry
>> cannot achieve an inc_not_zero.  When dec_and_test says the refcount is
>> zero, we remove from the hash table (certain that no new references will
>> be taken).
>>=20
>=20
> This does seem a more sensible approach. That would go a long way toward
> simplifying nfsd_file_put.

So I cut-and-pasted the approach you used in the patch you sent a few
weeks ago. I don't object to replacing that... but I don't see exactly
where you guys are going with this.


>>> +
>>> 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>>> 		nfsd_file_flush(nf);
>>> 		nfsd_file_put_noref(nf);
>>=20
>> This seems weird.  If the file was unhashed above (because nf_ref was
>> 2), it would now not be flushed.  Why don't we want it to be flushed in
>> that case?
>>=20
>>> -	} else if (nf->nf_file) {
>>> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=
=3D 1) {
>>> 		nfsd_file_put_noref(nf);
>>> 		nfsd_file_schedule_laundrette();
>>> 	} else
>>> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
>>>=20
>>> static __be32
>>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
>>> +		     unsigned int may_flags, struct nfsd_file **pnf,
>>> +		     bool open, int want_gc)
>>=20
>> I too would prefer "bool" for all intstance of gc and want_gc.
>>=20
>> NeilBrown
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



