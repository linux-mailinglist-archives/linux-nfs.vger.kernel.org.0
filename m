Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7435ABFD9
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiICQmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICQmG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 12:42:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA158DCA
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 09:42:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 283CBxYG007403;
        Sat, 3 Sep 2022 16:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gvSEBATVvvnVP2AIfrM0I015H/YIhQ4hkeY8xIdqOb8=;
 b=d6UX89SKIn8zMWgiga8DHkZXRGqtOy81djC7yHFnPm4IRNRKLrOYEbXijVIwuqzxJDH3
 b7W/cS5HPSXJMpMJ003JD1zWmG1VZnEsqDwZtjjHpmbe71ueEwF48f8lqnp00hUWqV/M
 bue0XI35EPPjvsNK2OTTOp/D4wTYwPs9KYvor3XoPmbUHaIXwF19o2lm2XYx98Y3qUiL
 4CgMrbzh2+8ji9vK0/rn1gu4MwVcyCghYNggvF/9VJf1wT4M/mhsLrbR/y58sED6+WQB
 9VWIIuGYgb4RSUw471A1AiRWWtrJ96BLfQWKMTD6oTSdXOlCDkQnUhurzm1xOFYXznyO 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftgrkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 16:41:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2839Dl4h017505;
        Sat, 3 Sep 2022 16:41:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6thyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 16:41:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpMfoEeZWxVypnRhzDdskUn9mYsfDgKNLVGdgW9YuXzw5GdmwYOnkmeJe+b2kSWZOzaJkh6Us3tPgSM1a3GJYpXblgbLVEFPOJTZ1VMRNwWOGjTpZ6IzMc3n4nih3G0CHnyhsto6Dn47obe7lyKeCojrTHpayj5YxjwY8UlcG0ZiYcOvqFCXuNSqpxN4p+Qg+1hc9vOPqOu08B4G9buekFuZLqJvhPQCcQCnPj7B5ukiiLoFy29Xr/V/aBy/uqNVSnpy/51/DGyiD1r2hbh7s9NN5pwRsTt2SwnUi9Q+OrILBNbMC168p6eswBIFaBgxBeI7y2OAht8cUtm1WEHlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvSEBATVvvnVP2AIfrM0I015H/YIhQ4hkeY8xIdqOb8=;
 b=TYhe81GBj7XhEiyVaBc6mklALR2thDlhNDBkrUUhpunHfzrZjbPzJ0GKRk3j5mjZzrosDxAtZ+4uAbbYbiOJ+2mqVNTXQWLjAr7ZYpnlRbNpS5hAg/CPrpd4sD1gWTAHJ4PyS1IeJ1zqnsYfJ/QILU9rK6rDrGc2eEFYVqvrdY0wZkfnEZ+iYgsLC7CD0G7tA1IVPgq+0Tfk5MbLfeyEWpZRy5yA2ZDW1INGOn+xynQVBmhiD22CuXk3PdQL1KDpoTRwKCJSe+1hmF03lTHP5MXapcbzXGlHKVvAildynN2Orn69XpyvM/sPGx+XfktzHOoq81A7/cxH9YM2/VzPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvSEBATVvvnVP2AIfrM0I015H/YIhQ4hkeY8xIdqOb8=;
 b=uSXocB1maKCyYjmiRzuSIbCWiAnxFNeAPw1B0gpbGpCfIXlnAqr96hff0wNOTQ7C+CZsQ0+TvZvNSj+w9GxNII/19YaW5FWCRVTvDj/l+VU60uSggOrWK/se2rAGDMkYrdtDMdU7aTgmzMDC3d7+Asw/4/6qVxpESnUsU+1b/kg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Sat, 3 Sep
 2022 16:41:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 16:41:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAFHCwCAAAQygIAAOVOAgAAxWwCAANvUAA==
Date:   Sat, 3 Sep 2022 16:41:42 +0000
Message-ID: <B7AA8016-0CBE-4F5B-BF08-4E521269A2CB@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com>
 <2E6F8E3F-C14C-44C7-8B72-744A5F6E8F7F@oracle.com>
 <1D65FB47-EC61-45FB-972D-D68832B54C47@redhat.com>
 <CAN-5tyHCuKcUEhBZUmA9VsckaA-Ogr0jsEPriQL8xhXJpc6OUw@mail.gmail.com>
In-Reply-To: <CAN-5tyHCuKcUEhBZUmA9VsckaA-Ogr0jsEPriQL8xhXJpc6OUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79f9b96d-d934-473c-20df-08da8dcb2ed6
x-ms-traffictypediagnostic: CH2PR10MB4183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnqgf6N9fBmKHLVQfIMPp36g5SR6QhQDshyoTGUHitebq8BZ2jsK7JRKffVU8kh69yGLFPDxlVIJiQbAawermchhrWdynwfAed6nugVFp2q2RG2atzuoR6zJnOiTO39NksxWkMKhwhDi2rqXsjPXCx/kFZEYZXcJvFiKNBL7IrYD9Pco4oOdn6c3xD+3qFsZBcCElQuJHwSVCUEwMyXdUEYcAcrbBzNTvKHhQXgnf4R0Xl0AMjx1excu8qEpyVK7JjwbkbrgJAD06JrXqxmcY/jHdoN56+Hm7qinUgJsI4PomCnAC2zwEWmiERUWXDxJT9KLl0T6+hJiumtQ/uLwxOncL7HOQIfBgIRG3S0wJteFcJFA2ZxSigVSR+XJn8NMj5ZJ0vQpXpHY4WjezVgU676TDMHS0FfUz6ZB1dXk8mIdzwNWLJty4XGk3kMxdFYUxZSt/NWdZbDvqXJkJMn5RAikc8OLb2Scb/UcPyM4ZOXdsBbA2iqRmpZ83V2uQ2W/Ttk/1zYNr6rzbcIjUwoveMXmcYg1nz5jAoXLlXVvqw7qE2aPxUNp+aJDpq6bMqxKukyDxG97ZJRDlcQ52jzFiMREz8RfgMOy+KN2PTL71RFwGqqjZbcB4xJ8Vj0oo2DDJGC3+3ogVxfIXQYcxdXUqbWmHpH0cNEWpwX+mlpF2WVV/UiR4ITugYmY9NWCMO6VRw4Q8Gu5cwGRRoyacr0FuJeKsWBqgEgDMCicF/LVT1WbkYwJRi2QC2PMkk5Rd55FifVGRJ1xV55TtTcBSaSqwk6lQZEqQUsvT1MjviKe3tg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(83380400001)(478600001)(186003)(2616005)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(6506007)(36756003)(41300700001)(26005)(53546011)(71200400001)(33656002)(6486002)(6512007)(38070700005)(122000001)(86362001)(6916009)(54906003)(2906002)(5660300002)(8936002)(91956017)(38100700002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nl2LjA9tba3y8HO9Yppkk4Tw7D5XdmS9bDVolEIWnw2TFnmLxNDxnRszHMMB?=
 =?us-ascii?Q?1pv+KvggB3GnJteaIeicHKfJUA9FkdRGoh2bMkl5G3mzUZTb+5kCI8YlRe6v?=
 =?us-ascii?Q?3bdyml4DG2Gd1GvUUvkc9OHwDDXVnI5hD0lr8fLOlXla3YPpZPZETtDzs2UL?=
 =?us-ascii?Q?FHcHwdtMd5wJbp6ahcb2B/v86bZf1NsaS+cfq97x97dZiCAm7ofNhAK89n7s?=
 =?us-ascii?Q?h9h/sBOPwU3A68sNSthBoBNCFE9oR4knCCe8EaA6ButTjk19NpIM5xAYDSoG?=
 =?us-ascii?Q?GoHbbfO++nZB76Epm82moGjtJNCTameIZ5Uue36as42pt+kciJb2eNhaZo3G?=
 =?us-ascii?Q?tjgeSBm0Bull9fM3PUO2FBiqvVgAs5MQMhhIAtxenLQqzklig98dSePhdgyv?=
 =?us-ascii?Q?rzZn1YZ/mMTS/b2kwaCx+/4sgf8A2S/esVcQqJwQsOHvGmKuWlyicqsN5Kit?=
 =?us-ascii?Q?OtM0f8nT7dA3g0kbpEjMXxOqX1D7rmS9pleOE5pQTV86hC2c78pNH5flcvQz?=
 =?us-ascii?Q?0GTJF7d586GnJNYQkeeVfJwr8wfh3nz7YnsFD8BsvShsuv+OJnqq8YboYqSA?=
 =?us-ascii?Q?dkplyH5LUZsVE4sOhrQtATirmUH40D+ErgT4RElH3G5j0wfMvQKrNzKHffhd?=
 =?us-ascii?Q?IE3csLUjOXeyz/XhTBQr/S/rLQ1L3HbFKqwuT7AJ8CroLNdzuoLHzuplKeNN?=
 =?us-ascii?Q?iK4Qi0lDYKaNvGhmFE8DQq9CZXFtILO77zEmdidCn7SKZMgMu7xkmZnlwNB3?=
 =?us-ascii?Q?Y45Fxzhpdle/YQGdXjrRrG+CmZ5PESKNqFexPnubUoasIVld+6+6a+x2FsCN?=
 =?us-ascii?Q?521oCd4fZTDun1ndT4U4oDpeIQLJB8r8B8ox+jWf9JVuCSJwzeVcNmpihsTe?=
 =?us-ascii?Q?ONue3KYRI+WONgMHzwbzTC/f7Yb0zWHn694nFjBcbrlTLxzXxz6lY4SR1qJJ?=
 =?us-ascii?Q?qwfU/U4kGdqIZcaltNx2jr8icvFXAggFbCY4bVcKWYtqWpFaXi8IG3NTv/XX?=
 =?us-ascii?Q?OZazKMpFUiNnbjEvjXGChyCbEkLrGh2ajNztIV68R7OrQq1KVtPL6k6erPsO?=
 =?us-ascii?Q?USvAzKdPUcz+wNp3a4xva08SYglpCAeKhP0/DKa03o74Bqax3bT3/d88NxR0?=
 =?us-ascii?Q?xQH2ds1vHdj00Rjpy3VigmOJTGftSefG/ra5HEBZgFR07rQE1sgnNmFAKIYg?=
 =?us-ascii?Q?Ukn4BrO3/TJXAchSn2sgiUJUOhfXh1X3vtJW67oO6sdjRs/5SztqyO/pj81E?=
 =?us-ascii?Q?E56pCwBUwK86VJNN7X0q6xBEXkcC0EigqgjHE0zMRKdczdCub4hl26kpIpi+?=
 =?us-ascii?Q?tqRveEXALV7cHsF0ljyh4pufp3k3xPgw9TZVhkIwv3eZeFLGc9+FVO55rns9?=
 =?us-ascii?Q?ZwVWKjZpwiFlmmO+Yt/VBN9Uw7RuA0hVC0YKpdnG/w9jvF26jiIMq7GvY+3x?=
 =?us-ascii?Q?ynuNueLTk+/t8WJ3U36BQZFUC7pjYpfU2PxLhR1So8d3dPdvcZfR4Nv54UE7?=
 =?us-ascii?Q?YMpZG2ClEg0p4+WxXEoQJ9C/ro/vLoviaZsk902nMUc4sFiig2Ink/1VlKiM?=
 =?us-ascii?Q?5bS2HVGkbekWJ9IjErbm54L2CMCQSJ9ZfIH4O+QRYbzlaCDSaoDeBlkhWb6F?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D97EDBB55CDFD64881D088ACA6E3BC99@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f9b96d-d934-473c-20df-08da8dcb2ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 16:41:42.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11HJldSDHtmhwo+PTNRZWM6RQMFMH+B4ELVTkjJRT5P7NQub3NhFjrM3NHI4LxT1VK1DIcLklns5LkkgwKRK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_07,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030085
X-Proofpoint-ORIG-GUID: hYDljtM5fYUFsz_Av-13PQotnzxd9Vb8
X-Proofpoint-GUID: hYDljtM5fYUFsz_Av-13PQotnzxd9Vb8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 2, 2022, at 11:34 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi folks,
>=20
> Ok so I won't be trying Ben's idea but I'm sort of confused is the
> thought that NFS is somehow at fault in incorrectly using the "new"
> code introduced by the new patches. Isn't it possible that the new
> patches are wrong?

Since the bisect result indicates one of Al's commits, that commit
should be at the top of the suspect list. I believe the intent is
that, generally speaking, both the folio and the iov_iter work are
not supposed to require changes to API consumers like NFSD.


> I haven't had time to try and revert the patch(es)
> to see if that makes the oops go away.

A test revert would be a good step to confirm the bisect result
before asking for Al's opinion. Always dot your p's and cross your
q's!


> I won't get around to it until about tuesday with the holidays.

Try it out when you can. Or if someone else has a chance before
then, they can report back here.


> On Fri, Sep 2, 2022 at 8:38 PM Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>=20
>> On 2 Sep 2022, at 17:13, Chuck Lever III wrote:
>>=20
>>>> On Sep 2, 2022, at 4:58 PM, Benjamin Coddington <bcodding@redhat.com>
>>>> wrote:
>>>>=20
>>>> Olga, does this fix it up for you?  I'm testing now, but I think it
>>>> might be
>>>> a little harder for me to hit.
>>>>=20
>>>> Ben
>>>>=20
>>>> 8<------------------------------------------------
>>>> From 6bea39a887495b1748ff3b179d6e2f3d7e552b61 Mon Sep 17 00:00:00
>>>> 2001
>>>> From: Benjamin Coddington <bcodding@redhat.com>
>>>> Date: Fri, 2 Sep 2022 16:49:17 -0400
>>>> Subject: [PATCH] SUNRPC: Fix svc_tcp_sendmsg bvec offset calculation
>>>>=20
>>>> The xdr_buf's bvec member points to an array of struct bio_vec, let's
>>>> fixup the calculation to the start of the bio_vec for non-zero
>>>> page_base.
>>>>=20
>>>> Fixes: bad4c6eb5eaa ("SUNRPC: Fix NFS READs that start at
>>>> non-page-aligned offsets")
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>> ---
>>>> net/sunrpc/svcsock.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>>>> index 2fc98fea59b4..ecafc9c4bc5c 100644
>>>> --- a/net/sunrpc/svcsock.c
>>>> +++ b/net/sunrpc/svcsock.c
>>>> @@ -1110,7 +1110,7 @@ static int svc_tcp_sendmsg(struct socket *sock,
>>>> struct xdr_buf *xdr,
>>>>               unsigned int offset, len, remaining;
>>>>               struct bio_vec *bvec;
>>>>=20
>>>> -               bvec =3D xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
>>>> +               bvec =3D &xdr->bvec[xdr->page_base >> PAGE_SHIFT];
>>>=20
>>> Color me skeptical.
>>>=20
>>> I'm not sure these two expressions are different. This variety
>>> of pointer arithmetic is used throughout the XDR layer:
>>=20
>> Yeah, you know what - it did crash in the same place with this change.
>>=20
>> My thinking was that if you have (for example) page_base =3D 8192, and
>> xdr->bvec of, say 0xffff4500, then what you want is to set the local
>> bvec var
>> to 0xfff4500 + sizeof(struct bio_vec)*2, but the code looks like it
>> would
>> set the local bvec to 0xffff4502, which is not the same thing..
>>=20
>> There must be a hole in my head,  I guess I need to dig out my K&R,
>> sorry
>> for the noise.  I will figure it out.
>>=20
>>> net/sunrpc/xdr.c:       pgto =3D pages + (pgto_base >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       pgfrom =3D pages + (pgfrom_base >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       pgto =3D pages + (pgto_base >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       pgfrom =3D pages + (pgfrom_base >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       pgto =3D pages + (pgbase >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       pgfrom =3D pages + (pgbase >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       page =3D pages + (pgbase >> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:       xdr->page_ptr =3D buf->pages + (new >>
>>> PAGE_SHIFT);
>>> net/sunrpc/xdr.c:               ppages =3D buf->pages + (base >>
>>> PAGE_SHIFT);
>>> net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D buf->pages + (buf->page_base
>>>>> PAGE_SHIFT);
>>> net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdrbuf->pages +
>>> (xdrbuf->page_base >> PAGE_SHIFT);
>>> net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdr->pages + (xdr->page_base
>>>>> PAGE_SHIFT);
>>> net/sunrpc/xprtrdma/rpc_rdma.c: ppages =3D xdr->pages + (xdr->page_base
>>>>> PAGE_SHIFT);
>>=20
>> Hmm.. there's clearly something wrong with me.
>>=20
>>> Commit bad4c6eb5eaa is from v5.11. Wouldn't this issue have
>>> shown up in earlier kernels? At the very least, the patch
>>> description needs to explain why this computation is not a
>>> problem for kernels 5.11 through 5.19.
>>=20
>> I totally agree.  I figured it was rare to have a non-zero page_base,
>> and
>> maybe a client change is now creating that.
>>=20
>> Ben
>>=20

--
Chuck Lever



