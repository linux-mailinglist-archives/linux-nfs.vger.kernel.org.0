Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16960B6AA
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiJXTHE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiJXTGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 15:06:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05D8B2CD
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:45:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYW5I001451;
        Mon, 24 Oct 2022 17:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L8zH/fpz0mjJXJmRYzv3dc+hJMcXbhYWCbx3Hr3nqhs=;
 b=v7rMzrv72HgsZuENJAzHT7XBtJf32+72LTjuab05HVPZFm9bCTUUohwmsL7ohzeTBZDP
 BD3BK067BkIiAtnIjiKGhs5GLNsWD6arEnr9hkyCSEw1fBV2lOQVf23i4/+F5VizPRxG
 iP6f7AKL57BJQIBiURboq5GqkmcPvHB2gFIeSB4GLlE7jZe8WYq5I6UbsXICdrvbzQf6
 C0ZnprFWL4pfHKNcwR2o5Q452JP0TJEu3Ll5SDIOH/eeuWUSu75w5DN9aChhHXSPYfRZ
 4TVBBqE2MdO/dmG3cCI46Wt1CodYL0MOdC7TlMVfRU+ecLkM8/DYbmaG/xmg7xDeAOtM Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdv92t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:28:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGmkZC012771;
        Mon, 24 Oct 2022 17:28:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3tcwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2nlPPuGK0/xBYaguL73FwAHX0bILnkt41SAQgS8UUjjQbYaw73+WAi66+8v+SrqGsLpF1sThc74mVpNqLEtHonONCJP5JUVzcUkKVcULbb5mQlG0MfEWEqVnodadIy54zC3BpxDEw9D3HvRfQRPqJPvGBLhwx3JNXN0EWIxEydJ47bDN1pM2dWVnomofj6JD3dNxoUo4ku9qmWwUf7Qyq0KdOxezAmLNIVRlz0VFX5ozEhja7r+Bb4LfWNLnx552HvOJjknA5obDp4aCiFKI6l/9upyTtKBJJQyQYE5ZhAhOsPMDWCb4l/wm+AuyQwNECibmm1thSosHg5rpQmXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8zH/fpz0mjJXJmRYzv3dc+hJMcXbhYWCbx3Hr3nqhs=;
 b=MI3K/Q+Bo+VPlyBfk79PfeJb2YZChPkWQYaWx3v/UdKLDL0DIcG4+X0goCWsMWPq/cZCwmRpeIEj0SmpcsI8vPOvs056n1bLR0xLdz3f6M9M0OD6HXLAJuKdOj9gDZxKlhLaEOz9DEsePfMvTczw1YLQcRXmmp8afjkuGOrQlMy4Dt2RkA8HfnsPW0t/NP+GqYoZO1GlmeMOs31RIa9sfbagsSaTRgPSA9RKhQI7k2yFXpDGu+MV3KOC0cW9789ihqnwYzAu/cNn7uyubMn9hMA783epYLU25NtPR+JkeHqB5vKFNICEdGNo7CM5qnwsfbPCZp92K3OvIaAVc6VL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8zH/fpz0mjJXJmRYzv3dc+hJMcXbhYWCbx3Hr3nqhs=;
 b=vJXsnkiYDInUUCfsyXmNUwfnR8r+dB3vGbREufoi5BIUEdZbMlt1volF0rvKUIufBsFTA8XOWkFADgEgItYV8BDihUo3VniGbnXZVGDsYTcCtu7Z2F1CLDjrq/LHnx0B2r3bKralvHUVsxmplti9K8EP3p640m+H0bq2yWEhgmo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 24 Oct
 2022 17:28:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:28:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4VmJcAgAAuS4CABw1rAIAAlEuAgABtAQA=
Date:   Mon, 24 Oct 2022 17:28:05 +0000
Message-ID: <1ACC29A8-B45F-4DF3-BA90-4791EE8A3A04@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>
 <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
 <166657723034.12462.8422170607830380805@noble.neil.brown.name>
 <6af5e6b60fcac271b4bb37dec2ffe25adfef80df.camel@kernel.org>
In-Reply-To: <6af5e6b60fcac271b4bb37dec2ffe25adfef80df.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6188:EE_
x-ms-office365-filtering-correlation-id: eab330a8-801d-4042-4703-08dab5e51c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOH7nHX25f/GPiwx44NXSzwlnWHo2DNcCqBDGkWEVQwfDIkGW1tBZ+FM72in1QWc5TsheUsbKxoUf6W4KRyodTNT0FIdwg5u1Yj0O6QK7lVctHlnmJ+zWAYG5d2V5vtGasJglU1ONMovsr+323ts1uy18KAV8wkdP77+xAxC/8PhDWilrZlDex324yY3SrCOe4UFy6FskOU7bGB94mW4lELOwuIJlpUxxRnW9AkvBlQABkjI2+TigipjzgR4yRsSlmeY/xMPesHHMEy2RgISgpEz67dBPMnRzSnVRVrDcb7tyf6kP/Z3ArYHMASVvSfRWaShMdOxn3FkORZGp2AZpm9sAazf7Ipcf3X6OUFtryAAoHXUSNjcsHq6kVzIUVse58NmrQjd0IxlivihqcWUS9iK+ytwUk7ebzxlWwrQOR7rKwhQVqSqezDDJlJHSXPK/T7lawnVtA/dUSMtZZYnfIMCRbgRBii8uwm9tJZSxXTDlLKkFU3meCtcGVUaYah43/Uzehx7Od2BWQFAdVGzuVy0s1yVXZ5bV2R1aZvdD06bJe0yHyq+d8CM9Xz73ITewM4yrU6U2HnBDibktQEGHddh1bxxzjSzKh0wQQ2aVuYEiak4rScpHnXXO8WRrwH+GnnP08Bep9O9+KW6LLYm4pjma6oeBTrxkgMwkqep6IxWuR1l1cEINHjXtr8dcsuetW7UwLo57SMwvxddb+ikksU4syrymBp7dF/vpzx6vK2lg7J+iz8ZNq/k2LAdXxzafYlXne9eqtpR29diw002KmCH7/HTVelzilJh8YgpLHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(36756003)(83380400001)(38070700005)(33656002)(4001150100001)(86362001)(91956017)(38100700002)(122000001)(76116006)(54906003)(6916009)(66556008)(2616005)(316002)(5660300002)(66476007)(6506007)(186003)(66946007)(8936002)(2906002)(478600001)(53546011)(26005)(64756008)(6512007)(8676002)(66446008)(4326008)(71200400001)(41300700001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uqdtvy0H7kg/FzqbMCMsYkBIi/6PF6zatOmz6VP5JII2sxGXdWsldLOxBn3T?=
 =?us-ascii?Q?LRPTLvMK60oy07jPhP0LYrlCg5bsM6+RUhBtN4jUiLgmOsaiHFdNKggTmhUv?=
 =?us-ascii?Q?HgXsPVMV2NixHLMp/v874+3ZBcqWRMTSrdmiIp+5gqCCMZdxMAUNEt0EC0KX?=
 =?us-ascii?Q?vcJWuxGpYncfcwnz1XPYQrPVtmUNq4Pi5uCreEq1MNy3eO8c4qqeE6ouuJEF?=
 =?us-ascii?Q?w+mtjzpo1WCHjRdOScn5ltRP8UYL+qcLS2UlewpAfsQD6Ws233Ew1PvwDu9P?=
 =?us-ascii?Q?2tUHVNlPXDJgSKxJOag5Ln7sFyYQ9UwXIi8FNtezQV2NY8+yrpw2kd8tzSbr?=
 =?us-ascii?Q?1YoaHMkWjEpnEOPTVPyJCQIacWwRuG+ip9O5WFfqaqondb1TzhZ+ouogU7kx?=
 =?us-ascii?Q?98FWWjYK07+G4k3PZ2Ud98M/HaEwTX7LBzepKf9fdfbqnryA5FxsMXBvQCT9?=
 =?us-ascii?Q?XByFF7V+oxjKrAX7FQJeDZCJ2lW/ZJEUsH7HgiKp0UE+NKry3fLkcqXy0k2l?=
 =?us-ascii?Q?t7DXUIj+S0bjxiDfwmVhGBVeCmY3gH02BfORvbR+UY8LEU+vthtTdRcoEI0H?=
 =?us-ascii?Q?4ff5dURiOdSDURM0W/O5ow8LoII2x5aE94bKRY6TtPBnKNIj9jlDE0j+TqZ4?=
 =?us-ascii?Q?2oVn4L9oWJufTcnxsslgJ/Z+t7QXevPCTqTVwhN/aC+bXf3tLCE69VWcOPpO?=
 =?us-ascii?Q?wTjAjmz9H0dxMmB+IcnkCutww60kQkig7xmblluoFHbC9IEe6r7XoS3H3Pbr?=
 =?us-ascii?Q?F837QTfSwxK/bkVkmDAYTtptyawdvGOJzsvkWweRf5X+uatSrElvhm6Cuarm?=
 =?us-ascii?Q?BACTLcWhxcOLqREZ5IyMp7MyEZRMQVvUSRokr0wu/fQ9vjHKeFH9C0PPOlGO?=
 =?us-ascii?Q?Z/6HDDfwZT0hDFBBVkYwjiJxqD/oQZ51kWk4o/uR/p8UQuQErvHiyxo5Ja92?=
 =?us-ascii?Q?72/soVqTn1XfsxGJX5uSWjxRsNFRWGRkVy7XpS3gMLYILOM36mpdtWz06fN+?=
 =?us-ascii?Q?VYjl4b0D/3hUlnBF4FhRMH2ytGV00hzjhPjz9vjMGlQAOSup+9ory6CFyJxl?=
 =?us-ascii?Q?L20yw/P3qAFZI2fLquZUtbZMTBclVziqkn0LCDL7gI2cF0nm5RK16P2WMgvE?=
 =?us-ascii?Q?2EBQMIdsEEcyPRXvkWBh2+bfY7npN0bMKed8zCMLjhQpIhJf78BDQXl6/UjI?=
 =?us-ascii?Q?B0DG5CTbdWwpVSf7T7OSQIhmLuccx+XE4FEL1tBakVaCVqlBMyi9BcXLXans?=
 =?us-ascii?Q?T+pzyXzxMohG//o1Oz/q2AcYlRsC4x8crHO1Y6xELXlnxbRhL1xQ5i4ciogj?=
 =?us-ascii?Q?tYvWT8fBj+QxdAnrscAuqRqofFhf034ccyROCIu0IS0oCEnuJj3auv7rqlg2?=
 =?us-ascii?Q?Qq/lVMg+cpXHDU3SG8L/uwWvSLcVzxE4ookaUURHmh/xWqZ39iU2tF7Hfwf5?=
 =?us-ascii?Q?nzOqbKtHVPIU69bMeTM85qQ83GNeamOchsicYKQ67XwqdNIIfrqd1nwPd2R2?=
 =?us-ascii?Q?u02vB1UZxNOZ0gdPQJEuNiiPsfKNOIpxNuVQOos3Z+cIEdDE05G4LUevAjz3?=
 =?us-ascii?Q?nffbwrKvg7yE3y/ywApD4fb+0mmnE72ctXVExkHDT8N3snX3BoHzk6Bxyk/l?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB2F7BEC0CF3D44D95B08B0CF8A1AF90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab330a8-801d-4042-4703-08dab5e51c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:28:05.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNMm1Hfi/ZCKT8uZ6awdQxPs7ckvpgZbwmSMghArfdFoswsIfMjUbqd7g2oA8zFbiwOQn3CA3aEzL7RuO4oIBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=373 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240106
X-Proofpoint-GUID: vsj8rulcL0j6-gY_K7vyBnNw73LA5xUN
X-Proofpoint-ORIG-GUID: vsj8rulcL0j6-gY_K7vyBnNw73LA5xUN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 6:57 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-24 at 13:07 +1100, NeilBrown wrote:
>> On Thu, 20 Oct 2022, Chuck Lever III wrote:
>>>=20
>>>> On Oct 19, 2022, at 7:39 AM, Jeff Layton <jlayton@poochiereds.net> wro=
te:
>>>>=20
>>>>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>>>>> +	rcu_read_lock();
>>>>> +	fp =3D insert_nfs4_file(open->op_file, current_fh);
>>>>> +	rcu_read_unlock();
>>>>=20
>>>> It'd probably be better to push this rcu_read_lock down into
>>>> insert_nfs4_file. You don't need to hold it over the actual insertion,
>>>> since that requires the state_lock.
>>>=20
>>> I used this arrangement because:
>>>=20
>>> insert_nfs4_file() invokes only find_nfs4_file() and the
>>> insert_file() helper. Both find_nfs4_file() and the
>>> insert_file() helper invoke rhltable_lookup(), which
>>> must be called with the RCU read lock held.
>>>=20
>>> And this is the reason why put_nfs4_file() no longer takes
>>> the state_lock: it would take the state_lock first and
>>> then the RCU read lock (which is implicitly taken in
>>> rhltable_remove()), which results in a lock inversion
>>> relative to insert_nfs4_file(), which takes the RCU read
>>> lock first, then the state_lock.
>>=20
>> It doesn't make any sense to talk about lock inversion with
>> rcu_read_lock().  It isn't really a lock in any traditional sense in
>> that it can never block (which is what cause lock-inversion problems).
>> I prefer to think for rcu_read_lock() as taking a reference on some
>> global state.
>>=20
>=20
> Right. To be clear, you can deadlock with synchronize_rcu if you use it
> improperly, but the rcu_read_lock itself never blocks.
>=20
>>>=20
>>>=20
>>> I'm certainly not an expert, so I'm willing to listen to
>>> alternative approaches. Can we rely on only the RCU read
>>> lock for exclusion on hash insertion?
>>=20
>> Probably we can.  I'll read through all the patches now and provide some
>> review.
>>=20
>=20
> The rcu_read_lock provides _no_ exclusion whatsoever, so it's not
> usually suitable for things that need exclusive access (like a hash
> insertion). If each rhl hash chain has its own lock though, then we may
> not require other locking to serialize insertions.

rhash does have per-bucket serialization using bit-spin-locks,
as far as I can tell.


--
Chuck Lever



