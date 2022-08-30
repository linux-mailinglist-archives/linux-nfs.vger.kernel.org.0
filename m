Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3900B5A6EEB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiH3VML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiH3VMJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 17:12:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3686FE7;
        Tue, 30 Aug 2022 14:12:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI461V016517;
        Tue, 30 Aug 2022 21:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SvrfEAkxjM+i58yFCl1BBu0Dtdcrj4iNZvuncj5yc30=;
 b=00r6jT6V6aotMPODFn3M1ItvPxZP/S2iUO0aRCZ2s1YFgkVqjAF91QiSBlHu+RTcK+B6
 Y1l8l72M9/+92w8UCP7JKbGkOBMOl87jivac7WB10nC7VCh8xE/OzWRU7XmCWNwljZoP
 2cybeO4YnsR30cXwaiC/qeIjdkNTLAoCOrJtFXXIZR7cFflrD3Sh13ogat2uH6hmtC2U
 aWb4nYegIhXvXJ79ikBZ0+ZY9BeoDA6QuAU5xBGgmz3RBhgCDTlwmbRI6eWGcwa2Gudh
 Qt6OU+gf88SRO4v3rGYvwIxvu0DTAGJrSzOsaMMs9nUi6UAFLHt+rIrTr/vdabLNg/hM Kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0qmh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:11:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXb07027354;
        Tue, 30 Aug 2022 21:11:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4csw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIVL+Iw80ELgHLg7aKqQ5hJUwaB0StRE4hOEI0DQ1SLD5hf3H/jyNBCiQdBSH+BjqEQk/nHucInFzeVLWLdDbiX8tObAfjTAQ6DQw0YqcIIs8KH+lLjEZu9kBoqzX1LDlHMAcrjGCh7e7vb7x5Tu9wloX0Vi+i1BkNndu3Yty55XmYyg9l1uF8/NqJn0y8Ei563ATgQMmHhrHe3l4LI53SL8iKIrqZEiDiyjTi69GdLOMeZDZ8/RXsItNYH54uTF4AW35u/rdAZ7YDq73bKybn+Y47GT5hsdwTbTC6tm65rt/wy54akFh7RdekmS2Y2Gr+BxZS/0tkaXyzb20jJHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvrfEAkxjM+i58yFCl1BBu0Dtdcrj4iNZvuncj5yc30=;
 b=MekVjzG99BGEEf+Rut1ib7wDCfplW08qtASoHVwajlvUOuuz31zddIQ1hs3BlN4C2ypMVy6j0omxAQ1KHMN2fhFJmCi9ghuoKMHyzGB8u9Xj+TPrkmNEiBGr2Lledx2DbA9f5VwSBQxaYzi2yRBbVXwdwh+jTIEL/suy9VIWjOm5Ydys99rHyrPOBPedspSxMGnex9ODt6/tk3dC2u+8kzK+GXlVjbpXt2iQmGIbD6gukYcbWFd/vJw+j4UBkjRr5t0Dh/7ZSXWmuHxpimsryzPMOKOg7lVK0g1wtsmIJZ5vLhcQuEpSUu7MY8MZ3CqRWpokiDg+t6qA3OvRcbSK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvrfEAkxjM+i58yFCl1BBu0Dtdcrj4iNZvuncj5yc30=;
 b=K6EogbBXghQwU7zwBuNQ4Hq1RSxv9ZJbrARriAxVPhQvIBCNq+YXEPbMLoPhDzw0GFJV2JRkmfjtCO5O97BN33EuWKiKFKrKIT+gr6VKZPwWhK64QQ9qvGHiY5t8JisV+TI+DAJ6qdGfhJYzl8rINy7t23hyUWr/xdG2Cjn0luY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 21:11:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 21:11:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix a memory leak in an error handling path
Thread-Topic: [PATCH] nfsd: Fix a memory leak in an error handling path
Thread-Index: AQHYuTYa4ohD5b5XPEGU215z45UTM63BBdIAgAbyBAA=
Date:   Tue, 30 Aug 2022 21:11:54 +0000
Message-ID: <5AAB19B0-0DAB-4313-AC9A-307E79CE4527@oracle.com>
References: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
 <20220826110808.GE2071@kadam>
In-Reply-To: <20220826110808.GE2071@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df293b7d-d70b-4f72-3f83-08da8acc4445
x-ms-traffictypediagnostic: CH0PR10MB5065:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSI7nTR2DygU7GtAziA1lXhX5IuJmwRF5hIo1DYuHW/Y3NVQ/r8StLxoN6sPPANwjhNK03XCcw80uSSj0yc29QTjVJdqL1aB4jZ4j2PXanuBvRkb3kkoeUujmciV9SFk22I5/k5h5PEXyJwIhDH1D6aBGpAXS3Kcu1r1iVchXRThOkYWjwJRDXuZIiRwBCRaTYKUsnzPPmN/xk9v6nLrWwtzeLTsY7xw/W9gYq3tFp6x2vaDHequsX9Y/YBc1cfDnXff/GPYPKzfdgRz0yZjyAdxaWmBXGDXAheNYSC1Ja5kAgPRzSrcO0hZzTrS0atazJY9ZJH40zh/PZWWnjh/iW8ERSZuoGbhLnTXwl9oR4KO5IO1rMarSI3qFfrBWprWMEe97E2+jWj+clQ8GWbPfIALce7r14a5mcjSRatpk5GIjsRLy5NSzoE5t0E7M2eTpa9jkKfSw9iOiYX6adxOSrCgRC4Q27nwDlO4vBuMQrUrUbUx7Xq9L6GJ3HnQWiW3OXaYa2r9xKrGRMHH97Bo9HERV56JypUNVhmnfziZWdEpAEclNZxu7vFFJuKTilrmlKvsUcJQpVIrYx9NLhimIyDaITH/jlpUye9Zb47jPSq8oSo67AqUm35ZQG4ZEbkP5xHsp40T8c55u02EANaXm4b0dlXpXMg+mdZu+jGDlpWia+jKA6i6avWGOdSVoxKjZqLbccFaiGrQY4k6eHjXhcGmi5MZNN3Nwcr2cvICCWUQ+LtdKzLaYEUHq1xlK3cyY0fwcUt09fhZJFBJbW3iCCnCBvJM8JP2XkavUs4RNZTNy53lmdwiE7ZmdKOyYv2Ice9nE2VrlN/XzMFQ1eJ+Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(136003)(39860400002)(396003)(41300700001)(53546011)(6506007)(6636002)(316002)(86362001)(54906003)(71200400001)(37006003)(478600001)(966005)(6486002)(38100700002)(83380400001)(122000001)(186003)(2616005)(6512007)(26005)(38070700005)(33656002)(36756003)(4326008)(2906002)(5660300002)(91956017)(8936002)(76116006)(66946007)(8676002)(6862004)(66446008)(66476007)(66556008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PRXdTDmNB0gZwWra81x92cTHQfafo36gwzOk4h+HF3GKiG4B71SJ99mtTS6g?=
 =?us-ascii?Q?9Ypt/qQhG8JdSn93UM8tj7Mag/QH3JSfOiRdbmX3dcqgwFqn0TeuK4NtfFxn?=
 =?us-ascii?Q?g/vuywuJ7nPRg70BsOyX7J5WIGtkIephGaxDbsWy6csmIjff431aO5KLyWUD?=
 =?us-ascii?Q?BqDPey1oEqeJr7u1LjrEzFML0QWXmPZMDl/qwUwJdIQIsudBN3DE1CMhRJ6j?=
 =?us-ascii?Q?4x0v2dC2PLRm4WBHsQD/jOMhhGtbeWO50sDy6MxPYVwLMAz/kQYbJGzOo+6s?=
 =?us-ascii?Q?SqWgypMbfE+saMfSy0gXqiVMnGnGHaDkAgjI3Rl0LXcP/dZj/HFeXdrKOw2N?=
 =?us-ascii?Q?NpoKqQSqo6KtvFtJ9rSSwwqag7keJ6X1Iv8BlWALu4SODnhBzidGx5n/690m?=
 =?us-ascii?Q?XgFxtg1gKR70udVOxcpQ32+vwu7EVuKHFHaDAjBPiSre2+e9AiknyLvKMTuV?=
 =?us-ascii?Q?lKTKjRowmy827aOE9ABqmZWY7tnMh9I2LxviPZ7tv1cjKLMWbKzz78XbApEB?=
 =?us-ascii?Q?IvqWaZkANaitdlB/UDJ+Kcg3mDp6TVcR6HH5E4AMRV93GjdQ+EHQTerUFA35?=
 =?us-ascii?Q?rMaPEK5Hw6Bt2Y8YGGA4aG9JNQsibnWWf4TEtxPwe1Ws2i2vlnwzJTzkMSvZ?=
 =?us-ascii?Q?YRt3evF2E7w9t3VKv0xdqlcoxyo0zG6ViNLd9TbVwjdXl8iovxTwsBPmzg+5?=
 =?us-ascii?Q?45vVWQBA03mQ4jhipc0JAhq/l/gDttZBbiCUrgvxOPtJWJQoMA9ZSHFQmyuZ?=
 =?us-ascii?Q?VGRW/Ga37Jl0CYeHYRAVUKHB2C4nPXkFWLJkyvc7lps6Pqm3THdOT3M89XqW?=
 =?us-ascii?Q?b3SDEogx+aBDeocLa6uJKkkj7sW3NDpke6LmAKcOSrWu3yLZ972Z9T5Aydw3?=
 =?us-ascii?Q?F1fyGt+f/K0jvwHSeE5Ig9SA3OeaHtGUA4QBdMr8BMmAZTPp0kQdQIvSB/z+?=
 =?us-ascii?Q?kLlcwO3BCSmOH9yTOVY5bX9hpH4yZ6qIbGbM2X7Zvz/g9NlLqnK39WgwN4nt?=
 =?us-ascii?Q?DtUzzokXI76EFvJofm1l+YLVS0aQHDGScVv4FA/UrCeuNtdCDf0gv6FG9wUU?=
 =?us-ascii?Q?pcHTewMDempI0PYf3wTYznygOxyfSSRLor84PGQ1zpR0fcjVIxygkbelPImR?=
 =?us-ascii?Q?kRrcyLo+YzsyF/z8j/2SgaaavqCTdSmfBBTFxwVQA7jVPv/qgVNUaAcWqAZA?=
 =?us-ascii?Q?ZAxBxn3t0oZ2yKeVJ97jmXT9a7WnaXTWQIOpLtIy/n/5eGY2zNnepezyHf/V?=
 =?us-ascii?Q?6BW2DUOZ8chMdLWfxxWzHNMLSMHoXU23EDKJHV/wZaG7ajXhKZ3DKiDQBamG?=
 =?us-ascii?Q?1hKRyU8XdrgX0McCbWdRfIXu3ZDI4N+uUarz6VXjOsqCbDJ8WWJbz9/sCxZ6?=
 =?us-ascii?Q?aM5k1U/JBpjKQ80FpTsTa2ga1FxOWAFKLzQJHFay/oFZpIM1wnM0HK197tLY?=
 =?us-ascii?Q?Eb/pE82OCisYMiezK3SPJ+dNXQ8xob1G3eUUJXRF9966Mr/D2nlmMNuF3kys?=
 =?us-ascii?Q?UzDHmqEZs9XnmlHY37pv9NpNd+aiB0hxL8H3/jT7NMhih4J3jP7In5Ok2Qj1?=
 =?us-ascii?Q?kQHyLJusB9Gq9mo/IGTE058g9EfyvgKKUbPzi0yKvfde7IW8IGzsxAOzBs67?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CEB03E9E5194E4386087E7E181778FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df293b7d-d70b-4f72-3f83-08da8acc4445
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 21:11:54.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSsdklzybuwUkeHxvx5UFT0oxcfSaJLYABwr6dH4HL7/A7msCEjw0g8V6+i9ZpRb0JztWHf7MrxSFAvjUpwUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300095
X-Proofpoint-GUID: E6aDWT9VpFh64A8Rjl66vx7gDNoO8dML
X-Proofpoint-ORIG-GUID: E6aDWT9VpFh64A8Rjl66vx7gDNoO8dML
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2022, at 7:08 AM, Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>=20
> On Fri, Aug 26, 2022 at 12:24:54PM +0200, Christophe JAILLET wrote:
>> If this memdup_user() call fails, the memory allocated in a previous cal=
l
>> a few lines above should be freed. Otherwise it leaks.
>>=20
>> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Speculative, untested.
>> ---
>> fs/nfsd/nfs4recover.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>> index b29d27eaa8a6..248ff9f4141c 100644
>> --- a/fs/nfsd/nfs4recover.c
>> +++ b/fs/nfsd/nfs4recover.c
>> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg=
_v2 __user *cmsg,
>> 				princhash.data =3D memdup_user(
>> 						&ci->cc_princhash.cp_data,
>> 						princhashlen);
>> -				if (IS_ERR_OR_NULL(princhash.data))
>> +				if (IS_ERR_OR_NULL(princhash.data)) {
>> +					kfree(name.data);
>> 					return -EFAULT;
>=20
> This comment is not directed at you and is not related to your patch.
> But memdup_user() never returns NULL, only error pointers.  I wrote a
> fifteen page blog entry about NULL vs error pointers the other week.
> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and=
-null/
> This should propagate the error code from memdup_user() instead of
> -EFAULT.

I take it then that Christophe should redrive this with your suggested
corrections? I haven't applied this yet because I was waiting for
follow-up.


--
Chuck Lever



