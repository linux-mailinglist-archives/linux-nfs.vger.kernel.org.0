Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8415851A0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiG2OfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiG2OfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 10:35:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20456A4B6
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 07:34:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TETLBT018077;
        Fri, 29 Jul 2022 14:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oN2G6etRvd7m2nK2tJptsWKLHpIkSvNOk8V11GiDf+w=;
 b=hYYq9qyea675xwQkYQrNNVuGd5rOpOi52Aa19S6wkBuYFyK2kINP+ofUWw1j+biU5RkF
 DP5+xa1FdNuFBlzckq9h2h1bW+gHIvZ33KMhPvItLO3PhE95T0YNmW2OYOKtJuQdFdTM
 uAIEI7zeg7ehhGvK8MNxFfei8QarHvieAHLE3hLeJ0YwCCEBE0LsBtWbS4hB7KwxO2Ky
 j4dfAqWj8aGxDr3jiXDxzBBkg+jkgwlgLnB/lPTNDf79MAQ2l2zme7fxuFN17cd/kk4g
 o5qrOz3Bcx+YrBqWCs2Y+vM5AamZ8/yjZdjs1FiT0jxV7IZWxSMU9SWgqKVEfRDtj6z7 Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ht01b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:34:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TE4dNS017671;
        Fri, 29 Jul 2022 14:34:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh654at9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUdndzwu9M4NB992TboamM9C/gq5KIUDmpOM0QtFMZzYL+ZDfy5OZ0G4uXsqSpKUoOyP1KR10hPd8Vnkhv2DHVb1712Ip8rTfOfknTPpV5RcnysYGDi3wsoQs8Qo94zA9Qgn61I5QVqq8jtw2/Xfp1reBebHyq7ZBPjBAPsujjUxxqkdrBxk8WTnPgXb/JSeEBM/hwPUlcIA4s8svdNm6VjdDOH3PQmQ7atoX9xupa/agPn0KCUaEY+zwhm3kwo8UhYveGl0r92p2TC/PjWrIamGDkeUwNlrsGprQlm5vSD62xtv1GXz3YXKA9lRHfIwPiwvPk/Cjwh0C0ZmDGc4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN2G6etRvd7m2nK2tJptsWKLHpIkSvNOk8V11GiDf+w=;
 b=M1dxapU91eZNt+tFVVmjE2dh95okK8sKZfzM+s9kKzchIjW4Q7Na0Gpk2GdjkEa2UE2NJV1GNZeYEa0WlNOG9WfKjfJ4hha+0DVoO3PqRHzWbLAVyJztHnNLwxesLenEqvdRFN+Gr2isTqfFyp4vXuvURsxsBgXYXwMTu0it3rMzvdiga0DwTJ1klL03sueZ6Kj3O2RvDsyAJB18RN1R5dtRZl5kwRqsnae0Ey3ducNnQlC05Jc/0WeQVCJnnGSL34507XS4hg/J/+j9kB22NAFcoPvcp4BwESKZR0D5nIoJqcamSYKB1nJwZMIPld2BLMq/a3M8QsxZTBK2e5up7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN2G6etRvd7m2nK2tJptsWKLHpIkSvNOk8V11GiDf+w=;
 b=jVI8Xhb4hjkBRnwGHC41cuM35tgWMm1T9Y94MUl7DwyFmhoWRRfy14MsrNLXg7g5lVt6MBqvz1A8Q1CVJXnzdETgarO782+No5JJ/5NoOhHc85axvXKEyHHmOJWDx4rutoqU7AexYgFfKiFdMmLe5Ft2EleQVcnTP5F2ttvQhBQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3390.namprd10.prod.outlook.com (2603:10b6:208:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 14:34:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 14:34:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Topic: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Index: AQHYohNX7cvCckGh/kqPxDxsXdi4Iq2T38yAgACwrQCAANtGAIAAANCA
Date:   Fri, 29 Jul 2022 14:34:49 +0000
Message-ID: <88D5EE6A-FBB0-4A35-9180-1F732E9F937D@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793059.21666.9611699223923887416.stgit@noble.brown>
 <6221A20D-6623-41EB-AC9F-BEFB1F4ED925@oracle.com>
 <165905802651.4359.17617640232417036364@noble.neil.brown.name>
 <B445DD2E-D356-47BC-8FD6-852565A867E4@oracle.com>
In-Reply-To: <B445DD2E-D356-47BC-8FD6-852565A867E4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c9cd917-dc1d-443c-7087-08da716f7def
x-ms-traffictypediagnostic: MN2PR10MB3390:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L65L106+tDiwPGWIwAK5BdnDdl2sDkdfMyExbUXV9XmdLrEb3/+KmA8tGQtM5AMzlLH0VgxvOcnBulb3/ClbqkCwSZvBvK4kqPSqnM5Zgip8HRABgpSMopJBXSNXTDFNIskreRxa5xy+IHwvRCwS17Pu14TBXSCeTWrs/4AnE9SOf5mPVzT4X3s8nxerhGN7x8bF1HSg6QpBBeH8QNukeUhMseOjb/OREOl0AO4YqDSXDGuJQgdzzrRXw43SG/zV/VVKlAKSEB7YWXY3nU7+wrDY1sUQ+GdCfcX69tZ73Hfdj+t+YzKVx3ZVOI/U76ebsjvzhO5Ds6rQXEykPiKzD+cNQ/vCI84YdzD5SamfLadsqC2sFL1WlVSfuiRNW9tpkgBAbmBlkxqqujLI+k2qiwj2L6+0ScBdl2N0/J6V4bCV0kuudDCbRMNDwdQL4Ep0rfpXmGLBdXPB3Hr4fvD86wVZqLsiT474kCIKPXfq4nw2+KXUMl6fcdNIIHSR75xuiMJFRrrQUiX/rErMxROkoj0pe4ewcCRDlHmLiIyh6cLRFMvDebWK8PeJZjDiVVVIDOACH2Vz3ZlTdmAYk+39Qzw3xYRbKA6Igutu54uER3eFlcudFxzMjWERPaOeZrmQbbmuoCrIggN8o06O3I+1mwFlO6mruWNu++v5ke9ofrt9qmb9tSRc4k+z1UlNVHeBAKnTsz7268RpKKkhqwNBjjPHrLzwioxQDXKu1OmcEFvCjV0lyYTEBrkmauo9Cq0sTGYfcLC/4klCtbm3tjtxiMoP8J7CDpC82uh47hEgRiktt1KdRqInJE4LO0rEB8rxIiSUh43ac6Up3ZPs/mnWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(346002)(136003)(478600001)(41300700001)(6512007)(2906002)(8936002)(5660300002)(86362001)(36756003)(33656002)(6506007)(53546011)(71200400001)(26005)(6486002)(6916009)(54906003)(38070700005)(38100700002)(2616005)(186003)(83380400001)(91956017)(8676002)(4326008)(64756008)(66446008)(316002)(66476007)(66556008)(66946007)(76116006)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YVuhkaAlHS8hzjA6ejdyuA+RI4GwVRbvEfBuDhwCPLwj0qFfesIBV3uDqhQC?=
 =?us-ascii?Q?F8DxsS9jNA2MsXPxIhf59gd4WZrsRIM+RBDeQJQxyXtF0u6QleSg24VJ8Ti+?=
 =?us-ascii?Q?O10jlfrB0oe1UkX8NnK9h8RJf8aIUc8y97D2PWsB0k/Hga40Y/7JmA4h9U+F?=
 =?us-ascii?Q?i+t+cVMD4dIXJQ3jKit98Dh7GRmxwQWb0TLBjPl5QNw+CcFXahG0/NtXAjN4?=
 =?us-ascii?Q?Bu7DgI0rJ8ZCOka386qPbSjXm85Wt3A80Fh7lb1i7QY5XnwnUnFu4yRoDZue?=
 =?us-ascii?Q?eSmmCmNFKMbC+c2eufnWGRW7yis4Y8E5JinB7d8EBXNvhZCr26pyeIWrl9+d?=
 =?us-ascii?Q?EXBMD4gef9MX9Kq90HhOei5ebe0QRGMF+wSsWTnR/aGjmSSwA72sFdDK6v1U?=
 =?us-ascii?Q?Ges0jg661lQH8++fZ6OUhCQlikHB5dNJ6A+hpc1MDTA5ZbzjzZnA9McBZlus?=
 =?us-ascii?Q?ul8m3pSzs6fIlO59fLNm57adkGuy4EpptvpZzvKsnhcMtJRnsKvqIATjmwTF?=
 =?us-ascii?Q?9ac3L/OQt7GYEHL/RHsRxBHevLsmeLtj0zUQr031RK7WVM8/w8t+Hmws+we4?=
 =?us-ascii?Q?W9WtF8mPRGnXVS/wo+YvURv/WD6dx4MyMgxfNpz16aMqjOQuvN9+PVcjy909?=
 =?us-ascii?Q?iekJ4KjWVZPr5iiBik12YdvD9yqN6Z+ndef/pyrfLDav9SsOCIKFbJbwoy2l?=
 =?us-ascii?Q?kk9J3iroywy1d2PI6w3wrFquDr/P6K7Dh32fLEmLACEMMgHsLk21MgWXJzPZ?=
 =?us-ascii?Q?9nvbJIEte2DTxZeJz7LWoO+T1mABqlfWX2hJf17+Bqwm85evZaO7fjdExy4U?=
 =?us-ascii?Q?PMjsBkjf5j7VoZFuQZaaL71v9BBIOMa7cDBXuAjHq1eKuBL6aoiRHrxZy0Q3?=
 =?us-ascii?Q?WenQptn2tOWl9KY2nlOzGTlpy648wSyTahqBS9FtUYFvkN9oOaSS/4RYEUgM?=
 =?us-ascii?Q?RfIUL6Um93ITNHZX2qS8n6r/gKbdWegKxVVdX0lwLBA1pQb4/jbUpATrIj9V?=
 =?us-ascii?Q?LeTGwg0h1G0Rxz0vtHMlbeWEsNufABnmfvrnGsUdTPx6bznA2V7VEZ0gXPs0?=
 =?us-ascii?Q?uwQJBqR62Oe+FsmY3op4abxeES+tF+zwphJCbxwY0tC44owilPJy87Oj6LOw?=
 =?us-ascii?Q?G796v8HLIGa0+7+U8PTBHVl+vW3Jg12Ljm83+z9r6oP+CmNPCBfrXDOHAi3c?=
 =?us-ascii?Q?KGCq5Hbo+crRAObHfzCgG4ytvypuwoyN/wKIP4vx25MunFZzjOru+qMe/LpY?=
 =?us-ascii?Q?w0AUJ833edn0plwRFMxGw4kx+Q7ooc/mx4D39gOjDD75QefkFjuTmG0lCOn+?=
 =?us-ascii?Q?2R6kkvtGuhvl8KBtN/yvv5ISOVeBIX07xHDalSBqY9BtO9NNl4+v/GVUCgNf?=
 =?us-ascii?Q?8TW41YvjNtW7zKUzB+qONixJAPeQwjNjp4nvvRpeG+fTsuveNlP7VnOYuAQz?=
 =?us-ascii?Q?0z1PYXMetBeuH54IK58wfFS8Q59kWdjLntpdpUIf3qmRFrGQ3ymbCNOh7jZK?=
 =?us-ascii?Q?KzD1zCxP4rssVqYhBzqoMdUhXjgREt8o7NzsrntquGPywGDAnTs354ML53QK?=
 =?us-ascii?Q?DlepBKca2BOJD5bWLEKiavEuLYpizgLZTPn6FsBt+3H/Rz0TV9S/ukItj/Tn?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E320713D84F04541BD18E0ACFE94EF33@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9cd917-dc1d-443c-7087-08da716f7def
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 14:34:49.4186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmXiiixYBW8jn0B8htskNr5Bsz7WQGvXk8/04kU0vjYhZMT89F2x9IJz6MNBt1jl/POmWrXtJn3bpWo00K5nVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_16,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=727 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290065
X-Proofpoint-ORIG-GUID: jiuOoa4oat63ojRno_B63yh0qvJ-MjGL
X-Proofpoint-GUID: jiuOoa4oat63ojRno_B63yh0qvJ-MjGL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 29, 2022, at 10:31 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>> On Jul 28, 2022, at 9:27 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>> On Fri, 29 Jul 2022, Chuck Lever III wrote:
>>>=20
>>>> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>>>>=20
>>>> Also move the 'fill' calls closer to the operation that might change t=
he
>>>> attributes.  This way they are avoided on some error paths.
>>>>=20
>>>> For the v2-only code in nfsproc.c, drop the fill calls as they aren't
>>>> needed.
>>>=20
>>> This feels like 3 independent changes to me. At least the v2 change
>>> should be moved to a separate patch. Relocating the "fill attrs" calls
>>> seems like it could cause noticeable behavior changes, so maybe it
>>> belongs also in a separate patch?
>>=20
>> Three intimately related changes that could be applied in sequence.
>> What would be gained by having separate patches?
>> To my mind, the primary issue is review effort.  Mixing unrelated
>> changes make review of each change harder, so keep them separate.
>> Mixing related changes is less of a problem as the abstraction that you
>> need to keep front-of-mind are fewer.
>> On the flip side, every patch added increases the review burden.  If I
>> wanted to move all calls to foo(), I wouldn't have one patch for each
>> call.
>> I think that patch is easy to review as it stands, but if you think not
>> I guess it could be split.
>>=20
>> Allowing bisect to isolate the problem precisely is another reason for
>> keeping patches small.  If a bug were found to be caused by this patch I
>> doubt it would be at all hard to localise which part of the patch caused
>> it.
>=20
> I adjusted the patch description and left the content as a single
> patch. I was initially confused by "drop the fill calls"... the
> patch is not physically removing code.

I should say that the issue for me was bisectability, it was easy
enough to review the patch.


--
Chuck Lever



