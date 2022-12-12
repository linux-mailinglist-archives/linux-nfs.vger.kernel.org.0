Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44B764A6CA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiLLSSU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 13:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiLLSR1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 13:17:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2BB65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 10:17:04 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwdNK020848;
        Mon, 12 Dec 2022 18:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FKRepqbjC0NBVS0fAB8D5+PBzG2FzUNgOh0y8sywN7M=;
 b=VhHOmeVvfhn60E8OfeKO94CtjkeJiK3oCcJVkrN9IcPkratmFPLw5nLPl6GPcP0miWq5
 9ySBKzkst6+HIPuFYh2TUZdcMC4bk93yui1AwhR73VtdiSVLwNlBrTKnmmMwU8U1Bkie
 ODp5iJIve1SvjKyUQ3hH3Ebtpw0GCrQtESuDbqDpK5d6kKnofaLT+4zs13Gv++MfC6Su
 UXVYngb+3yhvOrkleykeAWjOdMsrTHpQgtEF1klflq+6ZIABaxmEnM2Bdj149Lk5eatf
 wuzyT9AznPukK0Lz8XLKh9GVB6+0cUzR9eaJRiCruXRG5PvHMhdZKh2M2CBQcffD5UD/ 5Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqsugje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:16:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCHBS4F017604;
        Mon, 12 Dec 2022 18:16:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjaq2up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsAcuxwjMOys7Cj+Es6sjHSLlnUJEZr4BkGDPxqAZEznbQpNU0rzUtimhzUd6Ab8MOhX8sJIGrO1bcs8yeJGUIw/ZXkKvKMFtCM6VzlJVWCGrY1eheVKg09Cs+5Vz6nKVxoeILwZ9CmefnBe7gNAiibBfBEi/NCo9ueG7CDZdb6qDfG/gnjmvbVwwNXqeP0SL60QK2M3AUsfiamZl1aNO99WGGSz2xtZWsLZqQJdxNbCOPHBaFYr2kpg8Y1uKu+zSH4GBwdsJogt5GOcyu2NHkFSfqiZm5iS2DZNgDAX81sQSqKqCwqcPeiU9vkYlmTkoqIARyQj6/Xb99jVOWV8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKRepqbjC0NBVS0fAB8D5+PBzG2FzUNgOh0y8sywN7M=;
 b=kDQfNtpBkjU6fj8wObkZbMZnmvR41N3JOodOfnmU/lQPETctaqEeaGiZfxs4vRASjDFVaUlAe374wEmL6J5XZn2Ps67FyEaYVlg25feNNMNxV/ps2uy2UiIYufXar4Yu1YdJT0KIw+qGgmVq2Jd7/7tayEpFoWUremfTXrpJQb3UZfG2LsIZj5APplm/IfANhWyGlq9g6UPqEmYpyoVYvDAxHgRLGCZjttqhpzPvKfBKFZxp4BAYUVecvEPPyHG60ZYE/3xgYd/DTa3pMunI2r7cI3oahzHaCA7GCZ/ORerk/RE7/qU1knYRvHPMSJBPXUairE4/rTtqgEEkMKdDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKRepqbjC0NBVS0fAB8D5+PBzG2FzUNgOh0y8sywN7M=;
 b=YBe0P4f6pBCaQ4z6d1zqs9XiPNfu+D8YjuLx5Ue+3QvhkPpW/OV5AkUt577YibKKwWPd6z3Ph+w74Sf5sI1raA3zKnhLmrCiK2IN/76c1t+ykgZf0gTa6hfqJqsiI/wqsWS5gXTzdphTV4O/e2BYmK5xTiszvjZpMv2UJzDV4Yk=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by BN0PR10MB5334.namprd10.prod.outlook.com (2603:10b6:408:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:16:51 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:16:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Topic: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Index: AQHZDZX0xFKY8ZoZ9kagScnVZShYCK5qLYgAgAAUMoCAAAG1gIAABUyAgAAI5YCAAC2LgIAACFOAgAAJJAA=
Date:   Mon, 12 Dec 2022 18:16:51 +0000
Message-ID: <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
 <Y5czwRabTFiwah2b@kroah.com>
 <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
 <Y5dha1Hcgolctt0K@kroah.com>
 <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
In-Reply-To: <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|BN0PR10MB5334:EE_
x-ms-office365-filtering-correlation-id: 563b8d9d-a98c-4ea3-367d-08dadc6d0a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lm11Wi1ij9KcIl1OWreVdITuZ8GJGMHFOdkHpFZgGw95NS68pCwKgOtl3viTLgWrOirNueK2ZsJZS26pTc6xummgm7u1hHvPRxHznBFh96jc5Q9VrkLlTCG6qeC8zmad+d5F4zqYgSdyryqaIP8RoTZbo4H0g0tHjouNqtI6ag2zWrUfJo6vZ+zJWK1AUc5y6IJd5JlNTimnijZ0sCirSoJEweAxH8yoZ/KkOpdH5ITsW6R5zV3K39UzUK4TmW+xgj/RK3zDqRXMXFeW/sKEWQddT6l7gCeQhVpP8nHpWWx2TU6Yro18ixqjILp5lni2bFCCg3uUvwP4zMPIFPwuy1BcNaD8fZfKDhBqws9yjgg3IEyKIzkMWVSKNOYMOkaDruDWgP4POYf5dmjamgEJ8vLQjTrDdJ4iKoD5bSKBAhNw3EeS51hKxtdLW8MvKDLrk4DPkDeIWQGVwpjXESS+EfNDU3cwnda53wI3Y0jUrlmoWb6opse2ikmpVzT0fwm5z+3QHX99xvgZbMswzTwepm/aIqh7+VWQmnOzVTKCt4wdOPqPMi4Tcd3j7qfWJ7I/LfeuKiUQAWb2A06Tj4kn2o/mC59N0usBZRwQT7ifK86S9pcmKWQLo55lE9jWqEc9AvfIAUs5wTWjAGB5g6dwPmy1tOQrgsGKM3IlzqsiQunr6cx0fHE4AdTp9RX0oB2SX1BA+UjixwFAzq29NGT35pLnZolQV/fqfcB2x2pAkbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(66946007)(66446008)(8676002)(66556008)(76116006)(66476007)(64756008)(4326008)(71200400001)(5660300002)(36756003)(6512007)(6486002)(478600001)(186003)(41300700001)(26005)(6506007)(8936002)(53546011)(86362001)(6916009)(33656002)(316002)(54906003)(83380400001)(2616005)(38100700002)(38070700005)(122000001)(4001150100001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ltfqjUarVVRMxHOpYA/JEYNIA/0xR4SkNOrZgwXk1ioOAFT3lhca9ZWNqzMt?=
 =?us-ascii?Q?XgzdFKXp0MOO+YEORDjfuGuETr6N8+NxuO++bBBiZ9GpfvJWH7Dt4HsHLb0h?=
 =?us-ascii?Q?gTS0zUt0Z4qcqF4xv20NCJK5ltl9tsZoRAzNb8ams6Or1KEKq1ZDt0Uabk/Z?=
 =?us-ascii?Q?lda2P6BE9od+fs+QqmKMOWlcEAYwiD97+Tok7ejzU6DPCSoRJP7wsk+5fuNk?=
 =?us-ascii?Q?RbB5M3Xj4cE6hHmnnJ5qRGCBfLModtH7ZAU9EqLaknOpSmAwx4+DlWhQwvjE?=
 =?us-ascii?Q?Peg+LbMxj2n1p3fMLOfXs6BXyNqPMJum2qq1Dg2fwwFfdRtGxLBnBXMezHct?=
 =?us-ascii?Q?v5PvodCksXOMmkYoJMu5GHAiACsiIif53BTNj7ph1JuZa3GQQWNe5qKb4bIM?=
 =?us-ascii?Q?1UPgIXpRp54Cd7gF+q9aUeCfdMeZKfrsJlSCXnS7OiIcmLhPlI5FudAOwAf4?=
 =?us-ascii?Q?wn5UIyxBh8GPZfClBHNWaVZiLj3ZXnwSbGL+9ml7/RuYhVVbj/RJXU8B1LX2?=
 =?us-ascii?Q?ByObS/C1TRoK9m6AIce3KWfAtD8nfEtU0LXyKT+Jwk5H0lJ8HKUZTPm+DF7M?=
 =?us-ascii?Q?sjN9jOoACSj27w4LcH8tpXS0vDfix+6mqw+YkNKZkeA3n10J4kUR+p5jhzEb?=
 =?us-ascii?Q?HeVTnFmkGpe8Bde0N1O4N/+lwJpjRUqBtdezY7p+GSTup6wSN7N3V+oQF2Zv?=
 =?us-ascii?Q?yC2BpgT4iCOYLs9HPLFeqfA7v9lv+PlvfzUqP1LPMh05hT+j2poGl4N17gsW?=
 =?us-ascii?Q?MJj5tG48jDPMdfLta2lPdFvNMt5MnJjnLBfc2lZC+lw85vXu7v3mIOl3sw1c?=
 =?us-ascii?Q?REJfHFN9cn0SzZRbzSzPJxnzAEXG2Rq7xQBh7zzEmXfX/RfQGt93HHZByWsP?=
 =?us-ascii?Q?HFf52rdue1NCTsnThp26gjtNI5wnLiJc8e1F28FPQEFaqvNUxm3AMi0ETLDc?=
 =?us-ascii?Q?kLS6OlXa6ytKsnp1+sqXYUZmVqtVkp/vXNdJDc5BzwfVxjVITrOUqrnDL6qy?=
 =?us-ascii?Q?abOQ9r5w6xu9bnH3Ge0ukctmg/QW9Laj8WI1TZz3GEvDJVjdWV8/V3i5UZn/?=
 =?us-ascii?Q?M/9bKqsE16lF34R9YSrmJn4KHGXu9Xt+r1905dfCcEyGZwEjRZkdOmkFyumD?=
 =?us-ascii?Q?zi/R7NtpgExUH/lp5qzSZxoEkiDNYo+4OwwBZkf9pFpOgG2m3yF/zqfAmfiV?=
 =?us-ascii?Q?yRnCFawH2kgc5lxWm7+8o3SSVkyDHAHyG0/o2rf4fuOXXcXQI1O7OLnjgAD8?=
 =?us-ascii?Q?7AGAteQdMIYeBrMxL4IpZ8XC3GHQa129xAZJTFMlWDFpf/F4bKvEYiZB5ibQ?=
 =?us-ascii?Q?CiP2zh20ogml23uhLGpMYncfm6ipIOTuNWlfcp1dGNPvbUWOdmbWaNxKpwV7?=
 =?us-ascii?Q?pSxEMl2BH0xdQ7QnutHaj/giiZ/9M84T40WVgd5dBP3jBC8GyGDFgOXBUEQB?=
 =?us-ascii?Q?UFxJkSU+POD+KMPXMBlyT3p5cS3iBXEAvUN9oTuqfVjcWbOMyTcUzZwj6kRj?=
 =?us-ascii?Q?ET+G0zOcWcJARM6tsXOnzxi52UM9SWPrud0teYaa5sYTLgA5X2xqE+4iaC8S?=
 =?us-ascii?Q?Mj7wwlDqMBx1WP7yG2PRmVNMxIeCNn5HbBExcHCsHnxVMob8IPz7UdxqpsyT?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51460E4BF704084989C5AE8E06BA4C75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563b8d9d-a98c-4ea3-367d-08dadc6d0a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 18:16:51.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hHDc2tTYG5l4emyIlRzRUw6Hi7sA5C33IvWkK9+d4kziKvRrDJxua/NJUXyi//E0/PnZ6+qFyalLH2gHDIIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120165
X-Proofpoint-ORIG-GUID: Zx4daAkjLpFLeq2sTSqgjA4uN2ZpXjnc
X-Proofpoint-GUID: Zx4daAkjLpFLeq2sTSqgjA4uN2ZpXjnc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>> Problem caused by source's vfsmount being unmounted but remains
>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>>>>>> return errors.
>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>=20
>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>  fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *n=
ss, struct svc_rqst *rqstp,
>>>>>>>>  	return status;
>>>>>>>>  }
>>>>>>>>=20
>>>>>>>> -static void
>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>> -{
>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>> -	mntput(ss_mnt);
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>  /*
>>>>>>>>   * Verify COPY destination stateid.
>>>>>>>>   *
>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss=
_mnt, struct file *filp,
>>>>>>>>  {
>>>>>>>>  }
>>>>>>>>=20
>>>>>>>> -static void
>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>> -{
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>  static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>  				   struct nfs_fh *src_fh,
>>>>>>>>  				   nfs4_stateid *stateid)
>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>  		struct file *filp;
>>>>>>>>=20
>>>>>>>>  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>> -				      &copy->stateid);
>>>>>>>> +					&copy->stateid);
>>>>>>>> +
>>>>>>>>  		if (IS_ERR(filp)) {
>>>>>>>>  			switch (PTR_ERR(filp)) {
>>>>>>>>  			case -EBADF:
>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>  			default:
>>>>>>>>  				nfserr =3D nfserr_offload_denied;
>>>>>>>>  			}
>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>  			goto do_callback;
>>>>>>>>  		}
>>>>>>>>  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>>>>>>>>  	if (async_copy)
>>>>>>>>  		cleanup_async_copy(async_copy);
>>>>>>>>  	status =3D nfserrno(-ENOMEM);
>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>> +	/*
>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>> +	 * by the laundromat
>>>>>>>> +	 */
>>>>>>>>  	goto out;
>>>>>>>>  }
>>>>>>>>=20
>>>>>>> This looks reasonable at first glance, but I have some concerns wit=
h the
>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_d=
ul
>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt if i=
t
>>>>>>> finds one.
>>>>>>>=20
>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where=
 it
>>>>>>> just does a bare mntput:
>>>>>>>=20
>>>>>>>         if (!nn) {
>>>>>>>                 mntput(ss_mnt);
>>>>>>>                 return;
>>>>>>>         }
>>>>>>> ...
>>>>>>>         if (!found) {
>>>>>>>                 mntput(ss_mnt);
>>>>>>>                 return;
>>>>>>>         }
>>>>>>>=20
>>>>>>> The first one looks bogus. Can net_generic return NULL? If so how, =
and
>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>=20
>>>>>> it looks like net_generic can not fail, no where else check for NULL
>>>>>> so I will remove this check.
>>>>>>=20
>>>>>>>=20
>>>>>>> For the second case, if the ni is no longer on the list, where did =
the
>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
>>>>>>> BUG_ON?
>>>>>>=20
>>>>>> if ni is not found on the list then it's a bug somewhere so I will a=
dd
>>>>>> a BUG_ON on this.
>>>>>>=20
>>>>>=20
>>>>> Probably better to just WARN_ON and let any references leak in that
>>>>> case. A BUG_ON implies a panic in some environments, and it's best to
>>>>> avoid that unless there really is no choice.
>>>>=20
>>>> WARN_ON also causes machines to boot that have panic_on_warn enabled.
>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>=20
>>>=20
>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>=20
>> All cloud providers and anyone else that wants to "kill the system that
>> had a problem and have it reboot fast" in order to keep things working
>> overall.
>>=20
>=20
> If that's the case, then this situation would probably be one where a
> cloud provider would want to crash it and come back. NFS grace periods
> can suck though.
>=20
>>> I'm
>>> suggesting a WARN_ON because not finding an entry at this point
>>> represents a bug that we'd want reported.
>>=20
>> Your call, but we are generally discouraging adding new WARN_ON() for
>> anything that userspace could ever trigger.  And if userspace can't
>> trigger it, then it's a normal type of error that you need to handle
>> anyway, right?
>>=20
>> Anyway, your call, just letting you know.
>>=20
>=20
> Understood.
>=20
>>> The caller should hold a reference to the object that holds a vfsmount
>>> reference. It relies on that vfsmount to do a copy. If it's gone at thi=
s
>>> point where we're releasing that reference, then we're looking at a
>>> refcounting bug of some sort.
>>=20
>> refcounting in the nfsd code, or outside of that?
>>=20
>=20
> It'd be in the nfsd code, but might affect the vfsmount refcount. Inter-
> server copy is quite the tenuous house of cards. ;)
>=20
>>> I would expect anyone who sets panic_on_warn to _desire_ a panic in thi=
s
>>> situation. After all, they asked for it. Presumably they want it to do
>>> some coredump analysis or something?
>>>=20
>>> It is debatable whether the stack trace at this point would be helpful
>>> though, so you might consider a pr_warn or something less log-spammy.
>>=20
>> If you can recover from it, then yeah, pr_warn() is usually best.
>>=20
>=20
> It does look like Dai went with pr_warn on his v2 patch.
>=20
> We'd "recover" by leaking a vfsmount reference. The immediate crash
> would be avoided, but it might make for interesting "fun" later when you
> went to try and unmount the thing.

This is a red flag for me. If the leak prevents the system from
shutting down reliably, then we need to do something more than
a pr_warn(), I would think.


--
Chuck Lever



