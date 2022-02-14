Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE704B54FB
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355909AbiBNPj1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 10:39:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiBNPj1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 10:39:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35445F273
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 07:39:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EDm3TI021228;
        Mon, 14 Feb 2022 15:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b1jbYtyXEzbLJjpnr6jD/QqMHcZZ+b6E7d1s0x7nP+8=;
 b=TevMPWJ7ybo1C+Ht3f9yYaa7kwqGUU7bW6shy2M6XkjfqKTjnN2TI2XD7pNWrTqhEJLL
 iMOC7y6iDh/gwKsIzlDBEw6a7qBuxbztkwVPiFll9egzcnsdQy61RugGvUeUW4l1UsvD
 Ynsck/+95sKqXAI/wxYSiBv1hEiFU4tSwpHVbGYgu6OwwRvuh+qPCMnnpfM/qsmMZ61J
 JuMMqIVnkfq8FgSjNMI7eWutIBRS+U3Dkw+H5MTeNWuXaFqY/b3hM0hgmN2l7Q7Gix6H
 YZ5kff19OqmJYcIO8P6Sxt+Z0nMDcIr9S5ka7SQhuz5k/UDsq9L/A/4tLpKvUCVaKG6x kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p24xxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:39:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EFS6bI089707;
        Mon, 14 Feb 2022 15:39:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3e6qkwvb6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 15:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njh34/RHffhkqaoklZ3ZTLTSnQ6xZGl67rA8xeFFraWGy57mFxpI5aKEw4pQJ2XPdOECNfARpPB3zTTPg3KNJL0bKWQsKg4Cl8SpW0SvV0AJR0BkeelFQUn5A1SkZUHkeNsSPkv6E4LwNN4uVSnSA4dPw+0o/ikRruLkCfHw+3B2Zuof8qNGbiFFTVOs6ks9aaK/dYDf1Hl9n2N/NeTev+hx2w2w8lcWl3VuAta84O9kZM6xYxEjjxh4v2ws2bV2WVwgX7FgsrN7/FZgpIZj2f0XgXQ7zyh9ObT2U+QkR1ZBDwcf6bGk0EptgOg0TQmxGNuvjH2Bqxi0KKPFvcq3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1jbYtyXEzbLJjpnr6jD/QqMHcZZ+b6E7d1s0x7nP+8=;
 b=UIKwlRrdr3w5AbzaPtkbPeBnK3JT1RpK1LlezhTiXiQT5sUZihR/p/ZCfRGYl7/crQVfdypW5x9C6VuSRyleze0NgzwoytEypcpAJrMYaYW9DdG6hqP23hSegQHdHQ/ulsT95jZPcZ/jK2ak6VkLkTjB90K11DuPrr1uWqXGvKXLNLZdJ3iS3Veh1Ckotyl3+c+c8L5efsYyUsfMc/ruXnQxNIh7i7rltmj/mgXa7/syppgIJij+sX87vAdNsW0c+dbVGTZOkMHd8uEM+aqrKcw5NILQrpOiCS4lW9s1wOinZqOTqNzAWjMv94NVZSm1qTAYwklvnwygDxrhEl6Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1jbYtyXEzbLJjpnr6jD/QqMHcZZ+b6E7d1s0x7nP+8=;
 b=b+tj1nqZcyIerVVHrTR3C2hIdqG6qIpHKvjbKgLOo/bFlDRgkqHbax7uenlr5rryn+6D36ZqD532GrDaTcJ8dBpbypnrsUuOXBbwzdwpYkpGWuOgPmfJ9ulACc7Vpv2PNiqzEcc5tyhRYuVGJz+snhyL0JkL5SePqQ+HoxIhcZQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 15:39:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 15:39:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Neil Brown <neilb@suse.de>
CC:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4CAAAdIAIAACC0AgAAEqYCAAAnVAIAABAgAgANWcoCAALuNgIAASZiA
Date:   Mon, 14 Feb 2022 15:39:11 +0000
Message-ID: <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
In-Reply-To: <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33b5d955-49f4-4d3f-a061-08d9efd02605
x-ms-traffictypediagnostic: BLAPR10MB5042:EE_
x-microsoft-antispam-prvs: <BLAPR10MB50427318B6BDA69BBDADE02A93339@BLAPR10MB5042.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzIJyKCG8dJID8cwPAwRh80mEBOXs0nGtjFkzJVcSTgLWGO9NaABgAFdQEYYplf59ujoRjUxXnCFmFhrbde1ENJHHZ5ujCxr4LrEtKJZmPeJMBtirXAUXsyfpNDYrBAyJGL1j/iPo3Ppi3ouqCn2YUBmgMRcTvBz6O450cpaMfw1izmx3guRRiY6M0igWzrsI+Et2X1QkZNYT+L9tuahVospGuWnCJgJXHJRuF6pIKCwHP8iQ7l1o8H1RRDfwsycnQqg+Dac7s75cwhClRXkilfzyl+4sxL7e1bOdwdHVLgfW6az2V0LylSpSsY5Gf4Y7TqROxDxsesFzxHMTVYacpzIPGEmaLMFOcmfrZuj63ruk4J4paTYGGz/vMDbWSpVxbBD0ORBeNlXEb/lwywPII/Qx80CS1yxrPAeW/PD1dJGO4Fkac223A9kDWfu53Kdd/8pz52XGA5FxTCcmDZsZ8VJ5LLeg9KFKAh5HfA88kFlffi6aGhobYorGUUX7SLq7ReWuZ9Mrwt4va1t5+zba8opAFUsRDygyM2bv17HG6fog67WMDi6+QAKgFl4mI+9Th2DQ7CLFLeil9T8pOxLnk/oOJzOt1ZUWp9c81JwtN7vjWhaOjf+8tJheTmSyT/GGOzpdG4bElFwqkADQWp+q5dO4ErnHuxMk1B9LeHMA+jNyN6WySRKzgAN/bBhnkUYYatc3fpwq0mKQLzHy7wv4c3hgQMz+BTMzKh2Co50Ex5Gi62EsKpabH/6TeHeualL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(5660300002)(2906002)(186003)(26005)(6506007)(36756003)(8936002)(86362001)(33656002)(38070700005)(316002)(122000001)(66446008)(76116006)(64756008)(66476007)(4326008)(91956017)(8676002)(66556008)(66946007)(110136005)(508600001)(6486002)(53546011)(54906003)(6512007)(38100700002)(83380400001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4ygxDR82EekqL4EyLcYstFYm/0AklHTrVhKM0VJhEWanroWh6GzeYugNyLL?=
 =?us-ascii?Q?D+9ZiNOSS4g2g2TqaZc3wuzt5YSwQQKKQLdekCw8Vz7jr2FjtzlCdubTcNaQ?=
 =?us-ascii?Q?3i9aPGJcJE4nyOZddsn3oE5p2bOW3QTE2tB+bkSY3h4/mPl266l4BPb44VVq?=
 =?us-ascii?Q?aAUFKc2kfFkmzLjAGQ5s0Ml1znAGlZLwgOaKnBK4mVqZffSvbWa7BqoFXSMS?=
 =?us-ascii?Q?GFdJplQRRqIJ+G7WMLmS0sOkEKjuw+zG9usLgkrul2Ts88HSjR0ZcK/78D9T?=
 =?us-ascii?Q?cJqHSgZlZRyU4abhxFysYA1iSxoPDK7psDKf74ltNBWyA0xDwGgwQNiJYlsY?=
 =?us-ascii?Q?YUIckd+7SyNF51pod2AalQ/Igqj2/5ZaiJItr0n89hmFdgE66SOzKqxOk2FK?=
 =?us-ascii?Q?mSYR8hYIivcabmBucQb9QIaYUwO524OPU18gzOlj1w0kfxDCHfcliWSWes9B?=
 =?us-ascii?Q?YN5zr/HvWL7H23LA/D1+05TRjy5mEVrQTLuX7JhAnuyRwQWADfzNOV9bSOXV?=
 =?us-ascii?Q?jP2BRiAafcvsdVSVelMH5lUNlBQlTcxUW0UIQ0HyTI+qet818uFM7CqTlD0v?=
 =?us-ascii?Q?xDkb6w4681H/EiZWcNcnW/QxeWbl0xYyI/4dDntusDb3aWemmj0OJdjrvRpz?=
 =?us-ascii?Q?qdVfn3SX2HkCS6t4qTnVsBeFYexpiEvuW68WC/jCtMPWiTTdt1e2wQa806vl?=
 =?us-ascii?Q?MNOeEEFqZ3zfd0QOqqrM8ikk5aJFRZ1duYaH9GRWJm6Da2ennxa7rGmIgGYr?=
 =?us-ascii?Q?12bml26aG8qJajWB1WQLkpIuoBdg5RWlEbwDlPPg280E7TNH39feEzK8xlEd?=
 =?us-ascii?Q?3Ti53tWwN6MBCjWuMrpUXHo2nNndIyGIbiPdwxBNbCq8c1lHkfINJtQit/UI?=
 =?us-ascii?Q?qiY1hmJ0UUpFfu8p2K1BLwoCtJ8yz3rwq2saUkGt0h0UszOLCk2YU0CkYhxw?=
 =?us-ascii?Q?XhXUe8Kp4Url6k5kwHoYYEZpVAUrdh+hLwIBR/tpZQ7egorOKWdCvJY6VoNS?=
 =?us-ascii?Q?T5icA+22uZiM5XOLY5HcYj3CrCRRXADTcASvGN4GM1TkMdcpr1rF8V6Hcto9?=
 =?us-ascii?Q?TXDgQOb/X5kPTxXi54s5jvscuXXfqTZFn6jJX3jvsXPLAunTcZxheyp/PMg3?=
 =?us-ascii?Q?5nJYoVkykShv7n5NiIp9kIJpyV5vB2q905LZduaYsxgjcBwLmMYhhYS9E3H4?=
 =?us-ascii?Q?lVa749r/2iRSgFiy9OYSc1lcu3PX+tNl+yQZ+hXfV2EJ4qXJjmeZeavYPI82?=
 =?us-ascii?Q?nam4Rbiv8hFNb5m6nZGs7X3BzLQfPjuuUwwQwRdWMxkHrzOw03f8B4qJexmr?=
 =?us-ascii?Q?PJca/5xv3TZgDJYkLNwhw9iVJIRAuy6gY2yFggBAxTLn7LiarsoerVD0e7tp?=
 =?us-ascii?Q?znsIM9PQz65uYWHp2zZ1E+GcEYP97yNiuJzH5dn1sVgXyQtw0yi9Jhl1mMJd?=
 =?us-ascii?Q?xIhe2gH4nTA2fobUYOWnXr57NUDDVvTywgc9YVY+py1vj3z62v1j2tniDAdz?=
 =?us-ascii?Q?sLQMn2PHVzi53OcDgS1296z4NpYF38ColOAJFsywRN/O6KMbGTseFX0gk1j2?=
 =?us-ascii?Q?rEndkczmpALCoEq7Vof0s/eh4jvSDuy6LMXIm2RrUhoB8njwh+T5Hz5G3df4?=
 =?us-ascii?Q?GQUxRooQtdiznEKpUsIbxnA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B00AB9962F79445B9501BE55C82D263@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b5d955-49f4-4d3f-a061-08d9efd02605
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 15:39:11.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0YZ/c4E25pIBF0XSYEeyp6NjDezoIzfdyuqSD+/kxS6th+j59WIjMq4xqj+zLKz6nmbhtw62FhuVxWv364wKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140094
X-Proofpoint-ORIG-GUID: 6wxS9wZN2Gl0GdSRPkCVrQTMjML3vn7M
X-Proofpoint-GUID: 6wxS9wZN2Gl0GdSRPkCVrQTMjML3vn7M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2022, at 6:15 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 13 Feb 2022, at 19:04, NeilBrown wrote:
>=20
>> On Sat, 12 Feb 2022, Benjamin Coddington wrote:
>>> On 11 Feb 2022, at 15:51, Chuck Lever III wrote:
>>>=20
>>>>> On Feb 11, 2022, at 3:16 PM, Benjamin Coddington
>>>>> <bcodding@redhat.com> wrote:
>>>>>=20
>>>>> On 11 Feb 2022, at 15:00, Chuck Lever III wrote:
>>>>>=20
>>>>>>> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington
>>>>>>> <bcodding@redhat.com> wrote:
>>>>>>>=20
>>>>>>> All the arguments for exacting tolerances on how it should be named
>>>>>>> apply
>>>>>>> equally well to anything that implies its output will be used for
>>>>>>> nfs client
>>>>>>> ids, or host ids.
>>>>>>=20
>>>>>> I completely disagree with this assessment.
>>>>>=20
>>>>> But how, and in what way?  The tool just generates uuids, and spits
>>>>> them
>>>>> out, or it spits out whatever's in the file you specify, up to 64
>>>>> chars.  If
>>>>> we can't have uuid in the name, how can we have NFS or machine-id or
>>>>> host-id?
>>>>=20
>>>> We don't have a tool called "string" to get and set the DNS name of
>>>> the local host. It's called "hostname".
>>>>=20
>>>> The purpose of the proposed tool is to persist a unique string to be
>>>> used as part of an NFS client ID. I would like to name the tool based
>>>> on that purpose, not based on the way the content of the persistent
>>>> file happens to be arranged some of the time.
>>>>=20
>>>> When the tool generates the string, it just happens to be a UUID. It
>>>> doesn't have to be. The tool could generate a digest of the boot time
>>>> or the current time. In fact, one of those is usually part of certain
>>>> types of a UUID anyway. The fact that it is a UUID is totally not
>>>> relevant. We happen to use a UUID because it has certain global
>>>> uniqueness properties. (By the way, perhaps the man page could mention
>>>> that global uniqueness is important for this identifier. Anything with
>>>> similar guaranteed global uniqueness could be used).
>>>>=20
>>>> You keep admitting that the tool can output something that isn't a
>>>> UUID. Doesn't that make my argument for me: that the tool doesn't
>>>> generate a UUID, it manages a persistent host identifier. Just like
>>>> "hostname." Therefore "nfshostid". I really don't see how nfshostid
>>>> is just as miserable as nfsuuid -- hence, I completely disagree
>>>> that "all arguments ... apply equally well".
>>>=20
>>> Yes - your arguement is a good one.   I wasn't clear enough admitting
>>> you
>>> were right two emails ago, sorry about that.
>>>=20
>>> However, I still feel the same argument applied to "nfshostid"
>>> disqualifies
>>> it as well.  It doesn't output the nfshostid.  That, if it even contain=
s
>>> the
>>> part outputted, is more than what's written out.
>>>=20
>>> In my experience with linux tools, nfshostid sounds like something I ca=
n
>>> use
>>> to set or retrieve the identifier for an NFS host, and this little tool
>>> does
>>> not do that.
>>>=20
>>=20
>> I agree.  This tool primarily does 1 thing - it sets a string which will
>> be the uniquifier using the the client_owner4.  So I think the word
>> "set" should appear in the name.  I also think the name should start "nf=
s".
>> I don't much care whether it is
>>  nfssetid
>>  nfs-set-uuid
>>  nfssetowner
>>  nfssetuniquifier
>>  nfssetidentity
>>  nfsidset
>> though perhaps I'd prefer
>>  nfs=3Dset=3Did
>>=20
>> If not given any args, it should probably print a usage message rather
>> than perform a default action, to reduce the number of holes in feet.
>>=20
>> .... Naming  - THE hard problem of computer engineering ....
>=20
> No, it does NOT set the uniquifier string.  It returns it on stdout.  If
> you run it without args it just prints the string.  Its completely harmle=
ss.

OK, my understanding was that if you run it as root, and the
string isn't already set, it does indeed set a value in the
persistence file.

That should be harmless, though. Once it is set, it is always
the same afterwards, and that's fine. Someone who just types
in the command to see what it does can't damage their
metatarsals; the worst that happens is the persistence file
is never used again.

I agree that's not very "set"-like.

 nfsgetuniquifier
 nfsguestuniquifier
 nfsnsuniquifier
 ns-uniquifier

Use with copious amounts of tab completion.

--
Chuck Lever



