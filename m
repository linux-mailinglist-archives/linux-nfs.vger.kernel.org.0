Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A20611C5E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ1VXv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ1VXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 17:23:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44624B31F
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 14:23:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKxbdq025354;
        Fri, 28 Oct 2022 21:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RzgAcX0jA/dDFYFdrNdtCd1/KFH48IspyqME3Dh0lHk=;
 b=oRycqb67rr65Z/jvrOlsErdGl6dpn6qAcB3G48XWgyQDsLiPDeCDoOVPYIo3QUbnMa4H
 R3/1sqCEpQIfaYObhFYdSW3lXLnsDtOCU9KyLHx+wEsv5kPZfnFlXq/1r3c97TJnBf+q
 3QB8dRA3W4SWBzDy3Q8FcFVsZioDfLUJnctmGpbru2XTeQXknmj/dQB++iH3bGSDJEm0
 huS06V8uMa/7wrtAmY61l4gWmxaj45PlD0HqnGrELK/xl4XP0W7kE/Uq0upRfQl45Q81
 J6Ojhs3I/rfiJOk16OrTvL8yLaD9FjJ7eNbptnxuUQDoG/HSZjty9GiY7qB51ZjIlro4 rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ap620-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 21:23:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SL8E69009683;
        Fri, 28 Oct 2022 21:23:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggeuaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 21:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR2PzPG6Zwe/CrGKIw+k68n/RLwANcuxerGDtSsy6QYuoG5k2UO6pYyS6FEAg6iNq27OXIlLOUJW/6vtHh5LBpuWv1ko/SfkNerEN9yx71qBzDRH1I6Tu9JJTTXRlQ/AvTQQSZN7+ZciNKKYvBmLD1y5s845yDByCC3KCpF8jwJQ+j+RkIIyKJx6nMlODd4OWUTUUX6gh2wMGXk5PfKxHyY+DPWukSpncUUR/Ry3T7Ut4HcGuYx6364G2lBh7O+icCyXeSQBCBWC1TfQLcle1xw6C0yTh5twBgw7sPPGHdND660Hb9AhLotXDDiKc/GN5GwFslVwUMizqezyV9Z2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzgAcX0jA/dDFYFdrNdtCd1/KFH48IspyqME3Dh0lHk=;
 b=b1vrtf/vxtQLhFekR8tokcPX7xDRFCWhGt90WnYr7eQ/KtXJ7lzZ8Ua0OneWOCaB2kanQBvK38CYrgYDQm7TNqrVyNKUqIWg2pTz7E8/0KVWd/EKhL9v5dwSqbyVsFoXrcmiOP/KnkYRaZ71oZipS6rlEhVexn+ecanEbcdSWPcZ94/nx9tocU3Fy4CxJA7MpDbmdgVxyz7TTGJlrUZrHq6UhS03gnfCwMCO0dk3igRlQBeCo5WiNXX6AietvHpUw/7fzdFAeyRwaJzLtY958SI8X0VfEGvQI1oinKBpylQkHuf2CPcpj+yefhAKbvJbf9u3rLNxw+6SsPskYlQZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzgAcX0jA/dDFYFdrNdtCd1/KFH48IspyqME3Dh0lHk=;
 b=AlAg6+PHZnBsvG+hwEt0FYla8f3u3XPqWKpK7/31GW3TWPfYtH43JIFgPJgzwkkKkD9c1BNCBJgIDZQvd8wTLsEuXGBmiJY5NBcTEb/8NNu3ljWbNiw2WMm62dldNdsu1VsllOUV1FBm8bIeg/hXnuHopbkFCCAgTJnMWWTdSfU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6598.namprd10.prod.outlook.com (2603:10b6:510:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 28 Oct
 2022 21:23:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 21:23:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Index: AQHY6v8c+/AX0w4PQ0iPSe2aFwWbQK4kNtsAgAAGgQCAAAduAIAABsuAgAAFfgA=
Date:   Fri, 28 Oct 2022 21:23:35 +0000
Message-ID: <9C3A23A5-029E-44FC-9212-5A1D9C01C34A@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-3-jlayton@kernel.org>
 <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
 <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
 <3DD6D3B9-552C-470F-BF54-929497C58A4F@oracle.com>
 <2fbb55230b48c2e3b29b1fb16ebe7467b90e4052.camel@kernel.org>
In-Reply-To: <2fbb55230b48c2e3b29b1fb16ebe7467b90e4052.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6598:EE_
x-ms-office365-filtering-correlation-id: fa833ef8-a426-45b6-af73-08dab92aabee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENcHHz850nIB3+myEIsNWZD2fGr8WDZ3c5jg/5/eCWAjM4z+MP+Q3FXYjCv4JgwLt8tnfam172qaXBbCai2mrYprB5b9dW2dmh65KJVzHykCscXBOlMKKezTctw39gV+S6GX5pdp7GG8sMQU8T1ukl2DitV7pW8aOeympI1eZ2ZZezZycjJlNtwxMLpKcgD8A3T1cvJVHotaTeCq0jQFWRRoA3ZJxWrHri6CKDekkLHlgHgmSRzcM4Alo1ryBT/Bbd8qQdAr8eihB36oz2bunUA5Y0ZWN7H89AwZ04OxL8hbxsvxFHEwQM1o1q4qejM52q2LKgECu+LEFiMBdmhlHjWrTfw0UeAMqlk9Fe3rGF3c7RKPfm298QVsK8lWVKVAdp38qRskak4VRvMlRRi+rW8atpzfHT6z7EvTnNy4luib7DbYyJa6H7poi8Afmy/3cv87f5A8Z4KDawX+Ugc+g8awjtBpqC7s53+dInCcHQqV0vjaKnruYk78krPmGN18DMuVLjgs2TWd6/bNX3f5jpC9cmqZ9NFOv0TeGDqY3QXJmSUTfqNbdz1eIl6sDD5KxMbWPjNT5W9Jo+Jxqk5GPUK7JbZr1q3y/KuZvRZ5DaxnMI48r4TS6BJ0r8HO7289uMFlhDx/jUkHOfmNcycwn5+fj2nLHRCWfVhCCH95QB9D4GY8DhdEIXKcgmi+b7GvnTAKSRbJnPwvnqbOJHJ/9mrjbgNUzws5WPDe30bpaiByWqG+VeD/irc41NLEOVJZmCJFM13JSBbWC0apsPYubdMeJQHW3hBc11oL5cGpKnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(54906003)(4001150100001)(66946007)(66556008)(8676002)(66476007)(66446008)(316002)(478600001)(66899015)(71200400001)(64756008)(6916009)(5660300002)(4326008)(26005)(6512007)(76116006)(6506007)(8936002)(186003)(2616005)(2906002)(53546011)(41300700001)(6486002)(36756003)(38100700002)(86362001)(83380400001)(91956017)(33656002)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UjgiE0CtRIGOYpudwAI3B4mYDhCETfVsJFOCjh8Quh+ggqsTGyEMX/X/H7vD?=
 =?us-ascii?Q?w36y7pBBgr3c388CpdVSGQnpxUKzPug0X/yh8PKIjWmPPcb7oIijs3e7lum8?=
 =?us-ascii?Q?ev2NlJdD8wmRfOP+XxrxE8kyEktfzFM/h2ufVcQnpIfdNG5qX5TZRPxHJiVE?=
 =?us-ascii?Q?Ozd1BkaBHWmaLSeTTGE/OhTEHiXCMh7lhQ4tOuvR3TA9eiVZ8FKndILzr+Ux?=
 =?us-ascii?Q?cWpKACDJr5SbAPZisFBY4e7xnvRnf8D8q+RM90DkQ6eFYKx8+d0pNzV+GCiJ?=
 =?us-ascii?Q?Aq2e76lSTDqjokO/IPkG9mJ65lPoS28jfEPa+Pv/7uoVxf2OuIcDIxuhitTx?=
 =?us-ascii?Q?6LLsB6steK30w45OfAK2IfTY3pDpCQMsmt70iVT7o8RNpIgL3kHd3961ZPau?=
 =?us-ascii?Q?XP+LQe3u8v2Mo/wxet2Otrys3Jd0f6sCl0h6Cdn02e1tNbs393AZ5YHoAVkc?=
 =?us-ascii?Q?QfGH6M14XGInftnTCe6Ps67q3xim8mvATuDH2lJiOnUQYyaR+rpQuARlm465?=
 =?us-ascii?Q?DdwETDGnJOjmO3x+GZQdH/vf1Ql3JRZGQiHRcpVIZvQQYclnX6ZloYGbYQi6?=
 =?us-ascii?Q?lHGGPEqJxTvXd2JAHXGVLNHdLffNPJKNRDsc/lr8i1MtblU03kwp4AqeFY7B?=
 =?us-ascii?Q?Qn3m7u8HKLZGaj4Zekcrpb2B8TR67rXxjg7UIMi8UDvVV5VN/yimvdGURWBu?=
 =?us-ascii?Q?Hy7ut8o/m/aBXxAs83JKBrvSUwKE8jmh16ASR1r1D0fA1KtxOli0+97K7otf?=
 =?us-ascii?Q?EPESR4AqPafDjM6AS+zLRtxCQxg0LzvPSzgRxuQBGEsoL2yLyKKxzOr/gRYz?=
 =?us-ascii?Q?nPIbOyFze/XmiP4iBaz+KDaFEf1CNRG8aMmaV9LzG2OygLmNX4vs+vwW/1Js?=
 =?us-ascii?Q?trx+1ZzUqcbsB7gLobET1MHfkqwAZXSpeSZx8aGtMO0FDKinBzssntiKPCg6?=
 =?us-ascii?Q?rIMHueRCdp72X7RrUah1D356FHRzNpJmf2lggp6g7lkVG4/W8xmMV/dy17Q+?=
 =?us-ascii?Q?p7y2youl9rUkThNqRThcQOjpkXQwL3Ku89sDJ9qDVmttv7V3VnW5pbzIoTl5?=
 =?us-ascii?Q?V67ZJT6OB4ROrF2WZ8T1xy1QUlvTrHpExZRJKmVj700XgkkYHjzIZZK6Ow5z?=
 =?us-ascii?Q?fhwVrGo35kT5ZEiSSrFJ03BsvoDl+v0WClBeTLxA5WYszuaF6ROnBB8PJ8JL?=
 =?us-ascii?Q?DblQiUAdrs1uTQFJJ42Pr4qhgtKPco5ps8IDP+lAUxaljJl5aJNSiKBWUI1g?=
 =?us-ascii?Q?nx0FvNU6NxZSLKB7AlKxO1XvscEzibsR1gJ3NTjS9OG2rXfEyOYFJ9EtfZyD?=
 =?us-ascii?Q?iK2qkTWbfrpTxbxYCqzkRSPIg3fML79qb0Bp5D2Mmaxnmhr9fXDi+8/iJkDH?=
 =?us-ascii?Q?rguPAzsAj/nHO06B36MAnhHe834Qho7RhazlcZyC2EmpW60iJlXOMObxpjqx?=
 =?us-ascii?Q?5m8eqTxGcpSo71+/WrgeXpZAtbMQAl5TnY390Rtj8IowNTwJzJMCdKX+X0cD?=
 =?us-ascii?Q?Zn0PiqzsM3WegpBC6zvH6FMGdHkOa7CDIVLl15K8TDbqdrfE0udPSCsMWAHY?=
 =?us-ascii?Q?BgaUhNPffVgdf3dAAN+24o6tiYXJJhyjg/1n+Rw/V3uKQ6fWFlrBL8+5lXcu?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE6FF6CF2F89DD4DBD54E3AFB6F94C31@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa833ef8-a426-45b6-af73-08dab92aabee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 21:23:35.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsNNPO7IYp0RGN99Zht+5O7D39y0aj5dvP6l4gNVbbXICiqOxtwOpo9/5CCrDiif+QiYASVCK5+aOUJVRdvo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280135
X-Proofpoint-GUID: MnCJcThTKSBEDoJbnGwrPW6z3CaHWJA6
X-Proofpoint-ORIG-GUID: MnCJcThTKSBEDoJbnGwrPW6z3CaHWJA6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 5:03 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 20:39 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> The filecache refcounting is a bit non-standard for something searcha=
ble
>>>>> by RCU, in that we maintain a sentinel reference while it's hashed. T=
his
>>>>> in turn requires that we have to do things differently in the "put"
>>>>> depending on whether its hashed, which we believe to have led to race=
s.
>>>>>=20
>>>>> There are other problems in here too. nfsd_file_close_inode_sync can =
end
>>>>> up freeing an nfsd_file while there are still outstanding references =
to
>>>>> it, and there are a number of subtle ToC/ToU races.
>>>>>=20
>>>>> Rework the code so that the refcount is what drives the lifecycle. Wh=
en
>>>>> the refcount goes to zero, then unhash and rcu free the object.
>>>>>=20
>>>>> With this change, the LRU carries a reference. Take special care to
>>>>> deal with it when removing an entry from the list.
>>>>=20
>>>> I can see a way of making this patch a lot cleaner. It looks like ther=
e's
>>>> a fair bit of renaming and moving of functions -- that can go in clean
>>>> up patches before doing the heavy lifting.
>>>>=20
>>>=20
>>> Is this something that's really needed? I'm already basically rewriting
>>> this code. Reshuffling the old code around first will take a lot of tim=
e
>>> and we'll still end up with the same result.
>>=20
>> I did exactly this for the nfs4_file rhash changes. It took just a coupl=
e
>> of hours. The outcome is that you can see exactly, in the final patch in
>> that series, how the file_hashtbl -> rhltable substitution is done.
>>=20
>> Making sure each of the changes is more or less mechanical and obvious
>> is a good way to ensure no-one is doing something incorrect. That's why
>> folks like to use cocchinelle.
>>=20
>> Trust me, it will be much easier to figure out in a year when we have
>> new bugs in this code if we split up this commit just a little.
>>=20
>=20
> Sigh. It seems pointless to rearrange code that is going to be replaced,
> but I'll do it. It'll probably be next week though.
>=20
>>=20
>>>> I'm still not sold on the idea of a synchronous flush in nfsd_file_fre=
e().
>>>=20
>>> I think that we need to call this there to ensure that writeback errors
>>> are handled. I worry that if try to do this piecemeal, we could end up
>>> missing errors when they fall off the LRU.
>>>=20
>>>> That feels like a deadlock waiting to happen and quite difficult to
>>>> reproduce because I/O there is rarely needed. It could help to put a
>>>> might_sleep() in nfsd_file_fsync(), at least, but I would prefer not t=
o
>>>> drive I/O in that path at all.
>>>=20
>>> I don't quite grok the potential for a deadlock here. nfsd_file_free
>>> already has to deal with blocking activities due to it effective doing =
a
>>> close(). This is just another one. That's why nfsd_file_put has a
>>> might_sleep in it (to warn its callers).
>>=20
>> Currently nfsd_file_put() calls nfsd_file_flush(), which calls
>> vfs_fsync(). That can't be called while holding a spinlock.
>>=20
>>=20
>=20
> nfsd_file_free (and hence, nfsd_file_put) can never be called with a
> spinlock held. That's true even before this set. Both functions can
> block.

Dead horse: in the current code base, nfsd_file_free() can be called
via nfsd_file_close_inode_sync(), which is an API external to
filecache.c. But, I agree now that both functions can block.


>>> What's the deadlock scenario you envision?
>>=20
>> OK, filp_close() does call f_op->flush(). So we have this call
>> here and there aren't problems today. I still say this is a
>> problem waiting to occur, but I guess I can live with it.
>>=20
>> If filp_close() already calls f_op->flush(), why do we need an
>> explicit vfs_fsync() there?
>>=20
>>=20
>=20
> ->flush doesn't do anything on some filesystems, and while it does
> return an error code today, it should have been a void return function.
> The error from it can't be counted on.

OK. The goal is detecting writeback errors, and ->flush is not a
reliable way to do that.


> vfs_fsync is what ensures that everything gets written back and returns
> info about writeback errors. I don't see a way around calling it at
> least once before we close a file, if we want to keep up the "trick" of
> resetting the verifier when we see errors.

Fair enough, but maybe it's not worth a complexity and performance
impact. Writeback errors are supposed to be rare compared to I/O.

If we can find another way (especially, a more reliable way) to
monitor for writeback errors, that might be an improvement over
using vfs_fsync, which seems heavyweight no matter how you cut it.


> IMO, the goal ought to be to ensure that we don't end up having to do
> any writeback when we get to GC'ing it, and that's what patch 4/4 should
> do.

Understood. I don't disagree with the goal, since filp_close()
won't be able to avoid a potentially costly ->flush in some cases.

The issue is even a SYNC_NONE flush has appreciable cost.


--
Chuck Lever



