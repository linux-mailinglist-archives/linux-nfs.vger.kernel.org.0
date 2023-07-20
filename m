Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92CF75B142
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjGTObA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGTOa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:30:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A72703
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 07:30:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDd4mM023756;
        Thu, 20 Jul 2023 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=mnuBqy69BJoYa5HOyAnu2UyomX2tPldkW6Sj8aGxuqRU9XqhrN0n1o3zELx5fHvVOr4w
 boOp6yIFQV2NS8iwb3vfQLeKGJakjtjuXPxKMlvbE8Y8WXTkfz6bD0qqaheQv24eFlWf
 BVgFaXenpUcxedHY5wBox+cQCnA6vg5UMvK/5SDO2Jf6yuJRdlrCGPzDh4ciNMbZPtV4
 VI54DPjpaeE8YJcB3/JAtndBFPshDzObVpUE5BqsaFlTcdenty4vGs9SmLafJRv0CzHX
 kY1z2iO96MqyD+2IxlEzpyOwV6QO+JalH2qrwKgKI6bbhiaKO6uAd+9znSs6qzdLUFPJ lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ry1m4gmbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:30:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KEQPJ2019336;
        Thu, 20 Jul 2023 14:30:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw97r1w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWfDbtH0wJZAsug7vw5m2yClIA3JLeAWe0xEKa90DuIq4MT6+wnCGijQTbAKNae3Lu9xZOxItQMo9hcymU3Iy7y1+Zwyr6me0boU1Eyh9GDsHa7NePE8YJy+58VazkRGr4iibAvn10aoMJEiXLQoS8qlWGqFFWybkseGm/bnvUOavr2r0prVDmMpP7/i0eEYmd7NAoBhQywdbCEfAPbWtCIYtYfNl5BFGrjA3GHoJsTskNzz+M7ijunC9uh3kZcL/yCi8IEJ/l+cC0CNaYWrvNbyHGWLotGoicY8bC3dfCE9WWYQSh9Fsj/ryh/VmQP+T8uumYw+i0IQQVfq9O+IMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=BAW2zzbHY8HoKprZKNiaVVrkQiaHJnZnyxPIr2NMDxWI5MzZsV7JB3MJ/70lz/IBdrZ1MrRJLQFwdxiLUOJqSsIszA37u8NXf0vWg3w3puZUdzs803Oso5sD3Yw5kN5QNwwuFSAzlNUKMBWucAK14MFmzA1H7bHaRUh1V4T3hkvY4IKbdtAzJq8kESj4hpkYyWIPBUkHtumvBm/KETDVF8iyyrT1NIaQ+Mum8cAPbeuvoHiRrxDjOHqMy/OuuElSxssW8IIVVD9VVx+E6IleKn3ZH8Vg+2EL4NRnjbdJSv2StEvbaLHFk587+Q1nRmHe+PAHs/kXOpjXwHzwcLzBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=cheTDXkJkfJImAgwmj4I3eG5l5PernNw6vEl6FB1SV1AH0vlc3NHcteMRgs/B8HE9L6JLG6OKGeSiCGKBYsZueQBpjjpucIcPgNb3YUiWvsQrYpM0ir4Z6BjWXOZKUEpX0G7GB+b41dmZ85qG1PNkT9wcUoJPWsjzNu7wKxkl6w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 14:30:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 14:30:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: oops in nfsd-next branch
Thread-Topic: oops in nfsd-next branch
Thread-Index: AQHZuorXdNBxFgcDg0qLkVfZ1Dwbh6/BwUCAgAD3IIA=
Date:   Thu, 20 Jul 2023 14:30:41 +0000
Message-ID: <94EC14A7-F0E4-481F-8309-08BEF4A26075@oracle.com>
References: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
 <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
In-Reply-To: <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6290:EE_
x-ms-office365-filtering-correlation-id: 0464ad16-3436-4883-290a-08db892de53c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SQBQDWSNNlkQFcvb3Ymo8j4biHVXHgOzxB40P6qNMp0Ol50Zk5evV2tXXDqYcEgNaj9I8+15mtiyuFDglzOGfHz+k3vdVd3rjce6XgGL7ZQtYmE9mMGxz7HDoQed8Ztm8fFkLEXTvHRWCf4Vs83qBA7XDrhKNguJw8kr2Ein6pli4KGgsr6nxNeKZL4hzVENPMabd4Mm/mzoWEtxxLK4bqrseCKj/P62t0nLGXfZciqO6izsIMWml8P4XE+De5mAE81MAgcd86dC702pEHlgEdFtOKtlq6UNGshIm3A6NSL2cbSAKaIs63e63UcVSLOyKJKa5DfRUTDOm/5UbzNPcNqw82aTDUI2nFF0/PNgoyU+ibOGAqigbdYDC7AV4f3BqhYASdt3LatCOoK8O6qY11GUWng1+ETcCZh/Bh7NiE6d0D9zq0LyArQCtxNIIJgHnWmZ9R6MJOwosY/nWG9v4vqzR5miRoXzpp4xuRW71mDXgvshK2AEQZ4zA8iOUv737Omjq9SthKI+SN3aY5ki5rOqNYcHEfyXcjA1PM1eCjsoEns+kzkPI0DSpXOnX9sRQR7d75k+C9BoxkQJPLKf2NwFiJNuOxjNSxoGRZM0XPcI5LSWLsgsQd02aPKHmBp+pCpTtf9D1MjO54u50asWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(71200400001)(122000001)(6486002)(8676002)(6512007)(6916009)(45080400002)(5660300002)(41300700001)(66556008)(66946007)(8936002)(316002)(4326008)(91956017)(76116006)(66446008)(64756008)(66476007)(478600001)(2616005)(186003)(53546011)(3480700007)(38100700002)(6506007)(83380400001)(26005)(86362001)(38070700005)(36756003)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hYjc1JN6jr/D4vYVhhZeTANaX27k0e5+we++Z78oWBwS38oGUrdAeh21CEoC?=
 =?us-ascii?Q?qPjb5scW7AknPPpRHHszCCjnJs5mj/KO5QHBMkVIzDpoOxlPHq8o8pYpPeqk?=
 =?us-ascii?Q?dsCXbyH102HPYMYQiZOwUOy1jw8clUO4+hoKM2fVtLbbBLUz1f/sUMgWZnz0?=
 =?us-ascii?Q?WrCd9J6Ud62rG/x/MNGErHT9KDwKhyvc4MWw2CGOCsI1l3uVE/j6u6mjtWqh?=
 =?us-ascii?Q?30r0vJyuSxiTDwcAuFedE1q8re0wIcfXKIBUmdEE9fHR48kxW1PI+qQIqSlN?=
 =?us-ascii?Q?YKGIb8hStdbB+5nISFJG3N7OWbCziqJ6Lw9wY2ihXHRQAuZh2t6b0qev2M9n?=
 =?us-ascii?Q?atv/fDbwWycQGQ4OqPuwU6bcVlBdKTwibMFehSmkWgjFFbqmumzTj6Az5ufh?=
 =?us-ascii?Q?T2qGdHQARXMwnzj2/rAo5mONkJzIHB4UIU83FrHSWXhVHGAZdDCiHfPDjpib?=
 =?us-ascii?Q?WazY4R9sln2/KvN8g7min93s9zLHxS7oB7z9oPRlvCjJqwRdYFNv+HBL+xeo?=
 =?us-ascii?Q?GGRyEmmfqBZ/YgwRTIwlFRtRJleJVCTYvt0KXLdZLXX+jCK2v0qnS6Dn7rpa?=
 =?us-ascii?Q?ACkfFZAgQCPPrSXClnA4HBHT4o7ZpnvbzrFEjLxMXasATfzffxUBA73TfL2x?=
 =?us-ascii?Q?Zu3U2YOcIzhj8qX3Q0cunTkCtmlQgX8fHMwElgfuWA/pEvwpUqje0ojXI7g/?=
 =?us-ascii?Q?xw5JMwemm+wRhJOogVRCTlmsHHbqDhueTQlJZifMe3pume8v4vLXo1YEqlzK?=
 =?us-ascii?Q?xS3FAW35Bm6jkdT96MG3qqdOc0TKWVAoeiiAB0k55X4kTrxzNoTQDWMqOl87?=
 =?us-ascii?Q?zB/8i8mIfyBIElPOGBcK11TSBDl8gmTeZCn4GtO/JfeHb2egEh8RtlG+oYaD?=
 =?us-ascii?Q?5EYl5udGmoa5UktTbmMLInRXmCWAHqJNTLYDOidCWx/F6ws4vS3DVhebOTiE?=
 =?us-ascii?Q?pa7HJsA2HVZ+X52cuK/mfqXmbnD6KqGcAfxevW4I2QjsUDEeyyFQHvyYkoIj?=
 =?us-ascii?Q?KbxBKsnt45W6g67A3Z1WTC4Ga4hvke10vdq8BNkSHFYoHT4T7+5xFPlGAf5l?=
 =?us-ascii?Q?p8KG5NcheBxLMDarw4BTTCkn7SxW+Y+aWwqiDWpwVnF7JjAelsqevD7fYxoG?=
 =?us-ascii?Q?JiJbUj0OCvSmO6MvbtU0DCA/wUXz0QRdzvsXAs78ueyHEE8F8+FJT5W35F8u?=
 =?us-ascii?Q?WU6d5ZdkEonaW6zj81nYy4EIfWMV14D4eIMsIph8e3iholC+fD6Eq9XGYJ71?=
 =?us-ascii?Q?tPN1tRFFFpR7XNskbZWiAWEjghLKJqL9NLNT27JpuOayrUReTGaJps9Ji67j?=
 =?us-ascii?Q?LP9Zuid3rw3wnScIlqNlJGWOUiyQrUUb5pHXy0Sl0IWi+FW7njwYZ3leW2EY?=
 =?us-ascii?Q?hBZF4TBMLSomwINQ94ZH+ruK3I7o9KDG45GO2kyJGpnC1J3nKyHB83OXNmiw?=
 =?us-ascii?Q?h/r9lwTIpTrOFWO4DjLJFVjHZavc+VwL4tEg+0sCVo+NvwOarzlQktnv82/I?=
 =?us-ascii?Q?hP3Ox2TWgc1La0kGNOKiMrlE6avBYAydQVcRhFCQo0Vhr9SES0tjRf6bywlP?=
 =?us-ascii?Q?CzM8Wk4hmaS3inGqk5fRmMo5lI3YAEVMH3HNOaBXlk3I0rm7l3vg9y1JlR4z?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0281E7338F0D5F45B54D28F3A9AF6346@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: criZeT2xD87C0FBYbjcCiuP/2yk7gSgCuup7+8AJl9gqiU/C1d8PMAf6eBkNu6CMBenowqiIh23dRZrjzoA8reU60CfWGBCfqwW4Xfm2KXnP6w692D1i4WeSmBwkgLVfj3++uzolQnnxgqpIucRCSpFsIHMhn7vkG0GIbFKpzN0V8JF1Mtpr7obQqGdy87TJeihL1UyrppgktRqdDMYhDO0VZJn/aXXCgTy7I/fkC0GIX2vBM22EiPb2CKcOVmOlIiHUS/BXWqo8FQsmL4+ISzalWLfStIJYvhh8WntagHaIE/tA72ZhG6EN4qDWetwy7HvOjWk9v1mFzbcBLp2HugjBOhfh6GDIEFkyb6fJGVy/IrRWPe+rH6rCI2tN/wWJvT1uIOm8ioHDGKtdnPEMNiIrz9YgVg9a5GsEU+N+k8vyaEoXX9zUfr5DyqR3ZKozvnjFWmWVd/WCYNOWITuaOzsOiK/qpsLltY6WzC4UoJx5UoqkMnPkB6qI8kE8AOE/dSTQxWABgeUrQvHMSZlXhkmQdZObif1qln1CAlP2cNKR7o3KFm9KYmh7t4BFRQ5wnZdgiRS1pLt0AI9CcW9kF7uWCDLsQiL8DZa5l8aMDhbe11pmXU04TaLzqnZB2p0PyFsV7tLkQ+KZ4yzPjXoCB4/tXCecqHdH+D94nrPd2YSAczJlL45c5KmGX2l2jARQW4tml4CazRdx2W3R0riSXMG9icUKAddkTXloUE95XShzYXw8l2Zh609m7caJ+UD77MR7/TDsu+8inoijXTAobj3SADGAfD8whqJ8f7Lg+OU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464ad16-3436-4883-290a-08db892de53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:30:41.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXbbkmenKliR2FIER8alXbzA1Atpv/JbLPV9JouFOGlvVQiEJknKdSiEbanmlRQzPomhitU58W8YFJmtn1DtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200122
X-Proofpoint-GUID: 3P-d-i2wqt-xcA8yl-rySvZUFmsNeWcX
X-Proofpoint-ORIG-GUID: 3P-d-i2wqt-xcA8yl-rySvZUFmsNeWcX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2023, at 7:46 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 19, 2023, at 5:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> Hi Chuck,
>>=20
>> While doing some testing today with pynfs on a branch based on your
>> nfsd-next branch. I'm not sure which test triggers it, but it's one of
>> the v4.0 tests.
>=20
> I've just started running pynfs on nfsd-next, haven't seen any
> crashes so far. I'll take a dive in tomorrow.

I've reproduced this, and kbot also appears to have hit it.


>> It only takes a few mins before it crashes:
>>=20
>> Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault fo=
r address: ffffd8442d049108
>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in kern=
el mode
>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-prese=
nt page
>> Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
>> Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
>> Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not tain=
ted 6.5.0-rc2+ #19
>> Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q3=
5 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00=
 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06=
 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: =
00010286
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000=
81244052 RCX: ffff8a665e003008
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffff=
c0b13a45 RDI: 0000000081244052
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a66=
5e003008 R09: ffffffff8ebdc4ec
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000=
0000001b R12: ffff8a6656f20150
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a66=
56f20100 R15: ffff8a6656f20980
>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff=
8a67bfc00000(0000) knlGS:0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 00000002=
77e1a001 CR4: 0000000000060ef0
>> Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
>> Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [n=
fsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nfs=
d]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [su=
nrpc]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [n=
fsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode bytes=
 at 0xffffffffffffffd6.
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS: =
00000000 ORIG_RAX: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 00000000=
00000000 RCX: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 00000000=
00000000 RDI: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 00000000=
00000000 R09: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 00000000=
00000000 R12: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 00000000=
00000000 R15: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
>> Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_iso=
8859_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_hel=
per irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
>> Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]--=
-
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00=
 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06=
 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: =
00010286
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000=
81244052 RCX: ffff8a665e003008
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffff=
c0b13a45 RDI: 0000000081244052
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a66=
5e003008 R09: ffffffff8ebdc4ec
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000=
0000001b R12: ffff8a6656f20150
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a66=
56f20100 R15: ffff8a6656f20980
>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff=
8a67bfc00000(0000) knlGS:0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 00000002=
77e1a001 CR4: 0000000000060ef0
>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs di=
sabled
>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preempt=
_count 1
>>=20
>> faddr2line says:
>>=20
>> $ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0x=
770
>> nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.c=
:116
>> 111 }
>> 112=20
>> 113 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
>> 114 {
>> 115 kfree(rp->c_replvec.iov_base);
>>> 116< kmem_cache_free(drc_slab, rp);
>> 117 }
>> 118=20
>> 119 static unsigned long
>> 120 nfsd_cacherep_dispose(struct list_head *dispose)
>> 121 {
>>=20
>> (inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/l=
inux/fs/nfsd/nfscache.c:153
>> 148 static void
>> 149 nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_=
cacherep *rp,
>> 150 struct nfsd_net *nn)
>> 151 {
>> 152 nfsd_cacherep_unlink_locked(nn, b, rp);
>>> 153< nfsd_cacherep_free(rp);
>> 154 }
>> 155=20
>> 156 static void
>> 157 nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cachere=
p *rp,
>> 158 struct nfsd_net *nn)
>>=20
>> (inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nfs=
d/nfscache.c:527
>> 522 nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>> 523 goto out;
>> 524=20
>> 525 found_entry:
>> 526 /* We found a matching entry which is either in progress or done. */
>>> 527< nfsd_reply_cache_free_locked(NULL, rp, nn);
>> 528 nfsd_stats_rc_hits_inc();
>> 529 rtn =3D RC_DROPIT;
>> 530 rp =3D found;
>> 531=20
>> 532 /* Request being processed */
>>=20
>>=20
>> ...and a bisect landed here:
>>=20
>>=20
>> 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
>> commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
>> Author: Chuck Lever <chuck.lever@oracle.com>
>> Date:   Sun Jul 9 11:45:16 2023 -0400
>>=20
>>   NFSD: Refactor nfsd_reply_cache_free_locked()
>>=20
>>   To reduce contention on the bucket locks, we must avoid calling
>>   kfree() while each bucket lock is held.
>>=20
>>   Start by refactoring nfsd_reply_cache_free_locked() into a helper
>>   that removes an entry from the bucket (and must therefore run under
>>   the lock) and a second helper that frees the entry (which does not
>>   need to hold the lock).
>>=20
>>   For readability, rename the helpers nfsd_cacherep_<verb>.
>>=20
>>   Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
>> 1 file changed, 19 insertions(+), 7 deletions(-)
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever


--
Chuck Lever


