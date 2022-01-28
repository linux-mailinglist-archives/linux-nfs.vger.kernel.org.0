Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04A049FB2C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 15:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiA1ODC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 09:03:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37578 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244828AbiA1ODC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 09:03:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCwvJw031190;
        Fri, 28 Jan 2022 14:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lc+hyLckV3NHm66qwIoLGmbtD17+yM8KYQBjLfuDIYg=;
 b=ogGFxzOGAOI9q9Gd1ohI1F83jbz5w75k5xHaQ734k8So85zpXGhu4x9bxagmxl2PB+gW
 mhAnP9R3N9FQIa6q1UNYkxymRHvMnCs4uxXMG7gttJIYj7l4zY2CIBuzrM997NLw8tA/
 ESq/kQVIDPUkq7SDE/lMlmxgZyH2jMcLXftI03JZFR8FpzAPXzvr/coKPaMxsPBAysGQ
 P8/GEZr0cfRUVcuoMY/kwFamKhUcLc4qdqqwplM0qQ0ZzzTbJ1gxfkUGKnhBYn+Ookn5
 DTedWibZpq70EUdKQuHsKUtFGRqsURYUkQGjM5mUErym2HKSfSOKIVlgnsMWoNesDR2W gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj38kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:03:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SDtYLg119542;
        Fri, 28 Jan 2022 14:02:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3dr7ynttp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is8LE3Iy6lFswA58nyMUOuSQZczMondWEq20GNdp/rGAFTC31/UYGGyiOpyj1DC4a+WxCGU6XLaj/dPqItqP87j0H/dPAzraOazTwQJ4vla4XDZF3VSU5FFkc7Dgy1CPJZaUV0Z0+SWJSnDQ9bzYY57E7WI2v16rLjHMAl/5JEpyByBhJJL1S/ExMopdQI4Ze4DFe0W311YTu/bQYpS6xi4/B1WOfnzDLWJaFmmboakqbhaSdK/R3jFxHAT3BfZ+lFVW9E2uQhhK8T+HWwZSMZzB+GfxSDaGiuT9Cm5RSkn8S0ei4ZdgJzZsgkcxydXrmAEavBje75kLEZuggzR5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc+hyLckV3NHm66qwIoLGmbtD17+yM8KYQBjLfuDIYg=;
 b=Q6rw0DykUK5kqsi9F3AHSGVQi418epcbdwIc+llDqYbVRR7RrnanODdlrmlgKn6VzWL5hXsmtM2o2m9efEoRmhq+qKBiCkA5NkrUGO/HGF3rGeCW3fvVkOFjLGfKb7TkXFovUQ37PizpEjhh7yfuJlSTgEJGDKY7G9eyl0ivIW9UTVL//eclDAAdiZJ/hKeZOLz4+VoppFJaTYgKuvGZUWHWEJI3FZGBSmcdMIZ5siDyQ1jbeG3k/7jcwYv3/WD0UEF6cqZQzwFhntZEsIfkYlASQoXuFoTODsHcsR3JE+pzZCLIQdeBjCxUpzEkgVRZZfoQ5eX6MnrA4duKWIZvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc+hyLckV3NHm66qwIoLGmbtD17+yM8KYQBjLfuDIYg=;
 b=ckwo9x7Kvf5n6RyBE/1uVftSUPMEXLfaMHCn8wxSOdX+iSHyWP5RFJoaQbiFZh9Nutm4eiF+K9C8dU+zIOvVpL0fGkzkk8r4PF4ON2181V5Ivg9ZOvsWCRs9B+2dLaz6SQGXVBaEqsovE3SVUkaCIpUQ2R4iFMAUMlPFWazm0MY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 28 Jan
 2022 14:02:57 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 14:02:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Thread-Topic: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Thread-Index: AQHYEvmbADEY/zrdTE+MH1u87Jmysax3BaiAgABAU4CAATOSgA==
Date:   Fri, 28 Jan 2022 14:02:57 +0000
Message-ID: <B5EB68E1-E930-4EE0-8994-04674F7C8C30@oracle.com>
References: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
 <5D07AA4C-D6ED-4E53-AFFE-D0B91B11622C@oracle.com>
 <20220127194207.GA3459@fieldses.org>
In-Reply-To: <20220127194207.GA3459@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 145d0b90-3d35-4331-d9c6-08d9e266e365
x-ms-traffictypediagnostic: SA2PR10MB4793:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4793D78E71A7CC44ECF9129B93229@SA2PR10MB4793.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deLrrs81obf8eWT1CnWk6F6iTPfNwE3i823wSr+TRCXXi/ShgP6UKUMrpVXyQJ+9SQCk10856I2cVUjhHLe9renyN9sW9u6B9EMdCUqSA5KYHpVlWHhtCc1AC61rLU9eoCtQEgTaXAUAIyqYG7wtH3df4d3VsyXIe/CbrHouVHGUlgVzs1N6pfvrQK2Ibgx48Vx5+830zl+VHGm7RHmv9M5KWAfeobOITnd6LWixEvjMXc4SO1CNjgJO2/CR+U78eTQz9cmM+Iqb8kKUV8Yghq3CA5JOPdb9hDVvlnGT+DCHBe3MpPruO2E4mC++g67wgTgqS5CfylfPTxYxQBEoFTGrF3wJZvdoEsgDjWI8TNT1eNz9y/r3AUsdENbdpqZW+aVjMQAJDHLx9M+p5RgpLfsPyttg0ON0tcekK/cfabnnAa8RQq0uXaQsTVcGAKmGF1hppaCn2n1jGcwZ9rJCnxV1U4dSN1bGhjdY60ssihy4sk2DRiFuqlBbc6YIF/qlStDXAe96yg5kiSYEbTH7X02VAeG/3GD8dS58dfAomivJu1/tVSUTSYRcKNfImhKDFo1VsjGphrJHrgKfOLsCP9iUGvcbwpcslbv5MqIinsFxqgPdzcNKZIkaesAd2G00NhZRWQx8WSieypIrk7pktqh00y6xvC6BBl7nRTvTctPmDl47K7ZgzVIzfXbCmEPmS8r3r0SvWjPO344f9PJ2xYyJ6GyZ7haudMhn3P2a79hclygl8ImL+WiyRfJiqj21
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6486002)(86362001)(2906002)(186003)(122000001)(53546011)(316002)(6512007)(54906003)(33656002)(76116006)(8676002)(26005)(38100700002)(71200400001)(38070700005)(6916009)(2616005)(5660300002)(4326008)(8936002)(64756008)(66946007)(66556008)(66446008)(6506007)(36756003)(508600001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gkxWBlxT/Welx2cIGoeDFLPBZ2nrjJWt6ex+lR7FEdoK1Mel6/frJJ0qhYuL?=
 =?us-ascii?Q?7KIyBPHuqnaJ4q8XAuFyLdB9erpICgcwAFp2cXkaheK2LzvhJmG2PGttLGEv?=
 =?us-ascii?Q?8ePQg23Cs9TQcc7GWKYlrk1qGua7VqUoCMCF8i0/1u9jkv3mvxbj/JOBO7/e?=
 =?us-ascii?Q?kntwg0YwPAivDIhyzrFFnqiwVGZj2uXLKXcEAC7XZ7QaZImfrz7470ndrrOU?=
 =?us-ascii?Q?HfjfJnW7/BfMDyy2NbthrpEwFrePcoJXpe3tN8/2E6kIa45leeFhREL/ZGaY?=
 =?us-ascii?Q?nlxlSwP8ZJJPtsE3bHualky3ReyXpt25hBTBF2Ux35aCJDPMwaNqblF/iUjS?=
 =?us-ascii?Q?eO43WBFH1JmUIrSFm+AUKRNnCuNyVjEjdMEgFKD/s+EdMdc3NSHDat/oScsC?=
 =?us-ascii?Q?eHO3PQE21CDLW0YHKq7IEBHriZVTxBaAoUJEd53i+1PLicNtzJvVUXdbdMMU?=
 =?us-ascii?Q?gaAhJheQch5IKTEi+CSIlSlLVs/moNIuXxkqpgbNkItds2owsTlpWVI+E31Z?=
 =?us-ascii?Q?Spvw+MyP7lWl09k7HuqCvTHGUFfXRKeQVDLKxDN0GAiyCUtiRgmEyJ9wzQpU?=
 =?us-ascii?Q?1XLokeFtC8z5ssjIFCeYu1SASFI4Of/pLdCRhybHeqdk2UTOX1iKpaoufms8?=
 =?us-ascii?Q?aVWa/Esu8FD5KwMg7Zb9bz7AcK5IDcHc248to+28rPbrZy7+d5i0BfL6Qf6a?=
 =?us-ascii?Q?BA+aXdiqn6frRuiMvs2VD4bXxyCHjmM2qZYn/jCAh07ewzkuiCmmefZ/OsoQ?=
 =?us-ascii?Q?1ey9bet0yFZkZVkKv0Lw9QTUxuMtkPtM1b87dLOJno0hBDUdWG0K4qDxZpaC?=
 =?us-ascii?Q?xJX67wLkn2o962ljosz5iM5ST/YAo4KavPJ/iixAi+d0bD54QCarnADKowN2?=
 =?us-ascii?Q?VyhmhoA9a8lHj71huPP0kS0Vv92QzFiX2GWltEscpf3Zbdd8pUKhIVoiI7xC?=
 =?us-ascii?Q?sHxIKXULFn0uE5KNbw2nZ1S8OSlOVV0dUSv3uRjFtRFyXtD3aabTboO/r/mh?=
 =?us-ascii?Q?SYzDZQYQnbHvo4Lp3+FHwlpVdG6d/e2H5dqwITEcMmm6H9N0VBNFoH9Bav4g?=
 =?us-ascii?Q?EO6DTCJ/PtNGbZAT4TtoTXI0+l5lF51CQQo9Yob/dgPLVpDrIhxm4XPctNla?=
 =?us-ascii?Q?BTe6U9ZJr5y11Zd3kyMYEpk3+BGteO1tLuKhVi6vJzirXIgu70phPa+3SV2a?=
 =?us-ascii?Q?YC5tdF7qbk1dWJyUn2Mi9e/XFG1fXXqu2gcS1GanLS6c99nThMFvBfIt32Qd?=
 =?us-ascii?Q?N0eOOTqHma937T6YnYlbv2plU9Tvd6Rbl4p1qeGw1ZMN4P2LCqZOXpIcZP7Q?=
 =?us-ascii?Q?C0/u/wy/tiWMHnwhKuewbfBxhtkl14tfoc/MVuxBamfuD0AGnB7bG6eZXdfA?=
 =?us-ascii?Q?SBUddI+crLX+MYH5B62w3APLE0DiZnC/v+4UbG/TYL8vFyizFIL1OIs8Ubn/?=
 =?us-ascii?Q?9BuLjW13CysXlHZ9L4n/Uc8NvgTbMOhQ5Cl4rQUGINH6r7q6XE9j3k7NU9dx?=
 =?us-ascii?Q?+29Z/n7J4CeWAn54KvS/QaSkCk3CXCoRpra/u1kSSHAmEPLeEf5WYlLdF8fw?=
 =?us-ascii?Q?D2JcssiHhZcjXfm2ss4KZyYy9yPvatGaN+INP30W+zjCreADrtiDEFJUfSGp?=
 =?us-ascii?Q?IYh1nhw17eA8bE4jIGVZ7Hk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1E930C376E9BF44A8E21B95C20F5D2F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d0b90-3d35-4331-d9c6-08d9e266e365
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:02:57.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlTFKxeB4saTj9G4BJylS4iF6I/M3NFTkWv92wBe8fRkzM3rVp9k+cvur2UBVVpkM6kwnEu72Kl0XjjKFLGD6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280089
X-Proofpoint-ORIG-GUID: BrS42H05JGL9gzfRZuY8zY3fYkr_jTqT
X-Proofpoint-GUID: BrS42H05JGL9gzfRZuY8zY3fYkr_jTqT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2022, at 2:42 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Thu, Jan 27, 2022 at 03:51:54PM +0000, Chuck Lever III wrote:
>> Hi Dai-
>>=20
>>> On Jan 26, 2022, at 4:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> From RFC 7530 Section 16.34.5:
>>>=20
>>> o  The server has not recorded an unconfirmed { v, x, c, *, * } and
>>>  has recorded a confirmed { v, x, c, *, s }.  If the principals of
>>>  the record and of SETCLIENTID_CONFIRM do not match, the server
>>>  returns NFS4ERR_CLID_INUSE without removing any relevant leased
>>>  client state, and without changing recorded callback and
>>>  callback_ident values for client { x }.
>>>=20
>>> The current code intents to do what the spec describes above but
>>> it forgot to set 'old' to NULL resulting to the confirmed client
>>> to be expired.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>=20
>> On it's face, this seems like the correct thing to do.
>>=20
>> I believe the issue was introduced in commit 2b63482185e6 ("nfsd:
>> fix clid_inuse on mount with security change") in 2015. I can
>> add a Fixes: tag and apply this for 5.17-rc.
>=20
> Looks right to me too--thanks, Dai.

May I add a Reviewed-by: Bruce ?


>=20
> --b.
>=20
>>> ---
>>> fs/nfsd/nfs4state.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 72900b89cf84..32063733443d 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -4130,8 +4130,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp=
,
>>> 			status =3D nfserr_clid_inuse;
>>> 			if (client_has_state(old)
>>> 					&& !same_creds(&unconf->cl_cred,
>>> -							&old->cl_cred))
>>> +							&old->cl_cred)) {
>>> +				old =3D NULL;
>>> 				goto out;
>>> +			}
>>> 			status =3D mark_client_expired_locked(old);
>>> 			if (status) {
>>> 				old =3D NULL;
>>> --=20
>>> 2.9.5
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



