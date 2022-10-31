Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94612613DA8
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 19:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJaSrm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJaSrk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 14:47:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE913E9A
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:47:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGwqsh010794;
        Mon, 31 Oct 2022 18:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kIrMee93Lr+qOdVHAmshhG6F7y8QOpGUXEIYSyNAzmw=;
 b=byZJkNDYXi6zgPhl4wTM8FJhXznipBIRIpITNl0iVEX9BHDSPjdpPOzz70LGkovyjuVU
 Ya/qpOhGeqb6qcxHYvX5qmAt9fuFDwJeVaK43wDj+Ej17I+UpAhtxcDKnlfkoJ1bftug
 01kZVNR5Ib507y2sTj/CBB2nN+8P1WzUAcYcEeyGC+WRnekpB/l54cQh6Jw4Nx5xJuc3
 xFDvNaOnrGhi8nnH90e/XENUe9oSiOWeE3asiJUR10L15rMwZZWXd0iicyGraP8bQ/lK
 EYHM5Z4PIosFeVip8Vj1jVvzIJI1IKExNUrtowLSatOtrIGCZt5SH7/WYJneAyO0siem Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussmph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 18:47:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTi33032935;
        Mon, 31 Oct 2022 18:47:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3kbhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 18:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr1Dz//LRqlcZm+7G4IjjrLF77GBy1OuN/ECwOJM8Y2uf2vzijTLSrUdRMLR4+7mu56CFc0cRmLn7xhFi9JPZcIoqQb7AyUBEP6LdyF0S53zNWNcDswgtccxi0Yqqnx8eRXc/89I3tKTPIMU4qcD2svjhPwc/xhfjVufJ3mf00O3Hkba576F+epgrCg9fxGjnjG3q0CTs2VgaTOnQLIrend94U/eXNHR7581lWKIeo0EUQ0qEDprxE0qEouQAnabgisjYGauqUiXxbfbK7euTz25isp4PadK9MOxsSEHvxOPAZWRtaV7N9lSkc+gTGSUXnMGzSkR4r1dsadGL4/sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIrMee93Lr+qOdVHAmshhG6F7y8QOpGUXEIYSyNAzmw=;
 b=Iiw5wE6zliS97Lw7jmgJMcV4BKfO5d3hiAY0OMm7Wjy/sNhywXP1OSIbkyjEz5FiFJepDPo609elopsryOJleCfCRazic0q+HGymJ+HsiAAufeeLm/QOhVBY6NF+t6vBdPuHUz0mywdHNTOPwSqji+y91W3kAvs5CJG0IkvbzacBe4ZsWVgzysz5xQeY1KR7+N61KaIejozfh57erZ8BjWnoBeHtZna762Gmx1zAjDf2spxtPOdjQptgITrkKm9gMYyAWaq20rBaQbHTc3oPpwLX3VNAy6Df/V0EJ/0SgYMThIMJ/HcYnI/mkTDDgy7OTyVSoLCjzX4NkTXRJhK3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIrMee93Lr+qOdVHAmshhG6F7y8QOpGUXEIYSyNAzmw=;
 b=Yg0GIJVvcdZI2CvX65GpgFdaLHLQQMI9fKExlymTmUjokaXY/GjRPMLzyRt3hKngrgjY4HJYEM8PglTDC5VhVNRMlyNJtVzku/YlhjE1dbMeoml2OqxG/u6cSqf7Jix1fRj00zaCLq6u0JDInP4hBygcEAgpSnfNo13kvVhPHYI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 18:47:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 18:47:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Thread-Index: AQHY7UBdjy7EMWQZjE+yKRdZMx04Ya4ovM+AgAAacgCAAACFgIAAACwA
Date:   Mon, 31 Oct 2022 18:47:28 +0000
Message-ID: <1E40B5C0-1E8A-4FBD-80FB-3432037F101D@oracle.com>
References: <20221031154921.500620-1-jlayton@kernel.org>
 <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com> <Y2AXrMEim07Y0LLY@pevik>
 <433f431a3684eb296a62f8f3cdbf34e185a5a84d.camel@kernel.org>
In-Reply-To: <433f431a3684eb296a62f8f3cdbf34e185a5a84d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5957:EE_
x-ms-office365-filtering-correlation-id: 515e3ede-dd63-458d-e855-08dabb705c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/eqCm/KFeygAWuaE7JKs9ig3Y/F/kiaukKzRJyVibT2EpO5xSqE98n0ubFOs1b+L/pLpotN84JHkw7+8OJMREwR/3luShOU2+6nL+7RklIO25pHbRliC6XkWU/qlqB93gZw5+9mEzM240frS+iXg3/jD4vjQbSaXQjXCqHPnva23OpzWQKjytTyi1KnYEE+rbKYQogHFYMzXFIvKRmptawR1Oj/+RTUmt1lSAd4zeQ8tx7BPDRk8puLVKDVW+CkcTPjtNEAD+Rpaz8Y+iXieju2Bcih0gqdT04u8F5a+D6LK+QJRQufFYNM2hS7VZnjzO5awftyTlqq0kj+YtSVy2hkpaPb3femqXZfDWmT/28YDgU976Jvk8LFripjyO8USsA2TGQHQQZsMhP+ljclF2FEiaOyCaNkVz6SjmUz/KwPvLqSDi9jAnu2B82XT0yla2v51gHwDZr9Qgzr9j/tZAvFsW0KW0eXUm3lZ5ocCXkDRpOLi2UDmcyWMMZaDPzxQzQwThURvvxU8HQcn+wSiH9gwo8hjyzaeyGSfe7D8a1uAMT0Vl3CxiWrAHJXLNdmtp5wMmt1ibNlfgGuNTY8WL+NJVqWZyfbIfyGKN8Yelwu7jC1nwdgO1SNpX/hzI62MpqznlLuMg5ymkfObC2MP6ntXDFWrp2mtuoCQp7NHUa5wjdJ7iaMZGbJf1RLw5kJjY3m3KokaZs1GbAQBBgM2vV/e9fEHTESrz1ACnvGlZWiJdkMIMMi7ajo8FJPXKZm1kLPNUrSLqDXRvQNhtKuLDb5mdeXxLB2HRk8dk2WW7XFQiv5fX1LoOJEcZfBgMxZG1W7eW4nUQIK0OLIz76r/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(6506007)(66556008)(122000001)(38100700002)(2616005)(66946007)(38070700005)(66476007)(86362001)(83380400001)(2906002)(4001150100001)(186003)(53546011)(76116006)(966005)(5660300002)(8936002)(4326008)(41300700001)(71200400001)(478600001)(66446008)(54906003)(91956017)(6486002)(64756008)(6916009)(8676002)(26005)(316002)(36756003)(6512007)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NcVn4aRQE67wCoknd11ADRbIUf+fa/eHz51XHK+CFCcsAgSqPFReOIUYSGr8?=
 =?us-ascii?Q?WwJ0fxCKyeODxC43kgDS4rHQjukiKdG4k4dWVIRERDuUvmlsjTdNuX3NDG+U?=
 =?us-ascii?Q?2O910N7IO+DQhxPV8z+/exY6K9f0St6X5wNYdKAB4QwjL0hgmurNCZq9L9BF?=
 =?us-ascii?Q?6Xq7S6pg8HcSAo6e0182bPE0oJUPwPgP4ewkiTYLHFjBlL0nzn0hjgfqTmbd?=
 =?us-ascii?Q?1EA2Z9EjtWOiAvmF1xi0iSjz5MicB4BzsCDGigBnKrrla0MuMIwWrXIuaylc?=
 =?us-ascii?Q?cyq5G1ZO5jQNks/9RTwjafuo81hy9LdRYMZUMCyMxpMiaektQiMKhrA5ORna?=
 =?us-ascii?Q?PHniJ3DSBN+qM5gAZWJNpGvSNBlAN079yuSYWBWJ1Q/LSOlLlB6OYBm9g3Z2?=
 =?us-ascii?Q?BedMN1DN0tV86+jdtHmoK3i6POfMfi+U6Bdpy0XVoLdtfoP17vbvJuDci7FN?=
 =?us-ascii?Q?kjogKP2uTU1efIeaXr0tVqErjhVGxOHqr0NI9r1kPgjZJR84cEqUaG0z0OGg?=
 =?us-ascii?Q?HZBl+wE5fR0Tog1e8ndGSTXp5SPWhhe0dEHtks2cW1J9gqHqieWkxsB9pVLm?=
 =?us-ascii?Q?fIcJJAo5rw+u6hIjIjn2sFAS6h5LyR5spvFl06wht002s/J9MnkhNeUgZKKJ?=
 =?us-ascii?Q?kGQbByd0VXxt6QLRgDb1aVtJzDErHJtw008a2Ni/HRiqOoiMQLIf2t64g3ZE?=
 =?us-ascii?Q?xSPdOvHPlHY7B7YNlswczj9RNoljXsOmmskC1eaZ8F7glL2NcHqBauvr8+j4?=
 =?us-ascii?Q?HOM0t3LaDhEMBP2solOE4clwphxm4pfut/87wn7NcMH/eKwnhM/tfOh/DEYY?=
 =?us-ascii?Q?msZ+rSvtuFojWjbG9C5UvFT+iMlhm9zE/O0jvMQpKYU0WTgSqXyt3V6D3A7J?=
 =?us-ascii?Q?8Z7rXxIYvx3Cpq+0EgP7Gd68VHkue4F0OR7QlBt9tM7NaUjGhF3FBMRPBLnb?=
 =?us-ascii?Q?X3giHyWb7PEzvmUClhIDdY/nthzKXb9S6n9U460X+QrrnsRuc4EFIq7IiGzI?=
 =?us-ascii?Q?bGCsZPq89+AGwwAWymxeND0jCsmpNKl6hKWmdZOwzfWlJe+rJoDPLLI5VGms?=
 =?us-ascii?Q?hdBRntJ8niNKL6kT4SECEvyD/JCxAHOn9xsLzNxk4oBpMyJE4O2B1LvJxCro?=
 =?us-ascii?Q?20OoYypml4IbJQvAZZbvYGX+S0jt4g7FKYHkLO4F9M20ijZb3F9aBFkLKDdY?=
 =?us-ascii?Q?D5lAlanCS0zkCQuxegP52BYCwo8cHrD+uTGouLTVW57rh8CmDrv86eiY+R/q?=
 =?us-ascii?Q?CQcLyiOow5iSJTq4kwZq2ifD43zYKIB5z6W/KR5YS/tbkYJn8M9KF/arOzJZ?=
 =?us-ascii?Q?8ve7a/FiUlaZPFTg+3x8gAyvEu+I/KSXCTQINf4o7jcw6yUP52lVmHmJ6fbV?=
 =?us-ascii?Q?RZDUfZdNJv5WsnK49egBaJGdX2wXomiqHbrISrf+CXDzDhhFLEJWvp/n6aGD?=
 =?us-ascii?Q?XwFR80wrxA/IuXBphWjta3xMBSE9VvJYiqlDMIkzZYi0pl2xraHyvlH0ojp4?=
 =?us-ascii?Q?HnEqY0UzCjX0Lr6deGIpBX9E66YPlv74mvJSieJlPDzXw7FWhZyb+nAHa/dI?=
 =?us-ascii?Q?qQQnp6MUDUCwmwY3yLVXKGsWuOZez9+atO491OeceNvxGu8UCj4sLl3VU5kk?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01D44EB1384F764C8ECCDFD6255E96B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e3ede-dd63-458d-e855-08dabb705c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 18:47:28.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkEz4Xt3MqdwcTZspYe2lTSVXowDCsPyaVfnqX8QbgIrrHrCDRmmd7XLUzG0Jp4KYpG/g3VnyuGJP6b2sUvZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310116
X-Proofpoint-ORIG-GUID: RdrG1x8fBrAVpI5wYl-C6GoILlqmq0gK
X-Proofpoint-GUID: RdrG1x8fBrAVpI5wYl-C6GoILlqmq0gK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 2:46 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-31 at 19:45 +0100, Petr Vorel wrote:
>>=20
>>>> On Oct 31, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>>>> If the namespace doesn't match the one in "net", then we'll continue,
>>>> but that doesn't cause another rhashtable_walk_next call, so it will
>>>> loop infinitely.
>>=20
>>>> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
>>>> Reported-by: Petr Vorel <pvorel@suse.cz>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> fs/nfsd/filecache.c | 5 ++---
>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>=20
>>> Thank you! Applied and pushed to for-rc. I'll send a PR in a few days.
>>=20
>> Thanks for a quick action!
>>=20
>=20
> No problem.=20
>=20
>> What a shame you didn't put link to the report, which contains reproduce=
r.
>> https://lore.kernel.org/ltp/Y1%2FP8gDAcWC%2F+VR3@pevik/
>>=20
>> Kind regards,
>> Petr
>>=20
>=20
> Chuck, could you add that link to the changelog when you merge it?

In progress, I'll push the update in a moment.


>=20
> Thanks,
> Jeff
>=20
>>>> The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
>>>> branch. This one should be suitable there.
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 98c6b5f51bc8..4a8aa7cd8354 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)
>>=20
>>>> 		nf =3D rhashtable_walk_next(&iter);
>>>> 		while (!IS_ERR_OR_NULL(nf)) {
>>>> -			if (net && nf->nf_net !=3D net)
>>>> -				continue;
>>>> -			nfsd_file_unhash_and_dispose(nf, &dispose);
>>>> +			if (!net || nf->nf_net =3D=3D net)
>>>> +				nfsd_file_unhash_and_dispose(nf, &dispose);
>>>> 			nf =3D rhashtable_walk_next(&iter);
>>>> 		}
>>=20
>>>> --=20
>>>> 2.38.1
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



