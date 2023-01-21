Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C519676905
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jan 2023 21:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAUUMW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUMV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 15:12:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE022DD4
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 12:12:19 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LJoGRP026526;
        Sat, 21 Jan 2023 20:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wk2W43o1BPpbf1uAwh/IWnfk9UirP7V6+H1j7cMGYqc=;
 b=r6XBFo/bnM7Oc38RBg17tdfOgcCTZZb1iQaFxDGL3PTSv7JOLHHq7wboYgVO92JVO2ar
 oUo3gjmp0YyONEO+MvNVENych48BpKeOclDOJNfLMwVM9FcvdFGQTvd853CO9n4rIzHJ
 sdo6QJ/QoQxsyKFBP/uak3YQpnbIVE3MRlMAVljirA9Ml83GHIgVXqtrYuZZu32p9Jwk
 IbewKAo6JnMZsHkAHx2612Gihs42agt7d08C5pq+l8Kj6UQaV2FYF/wlO6SX9b4rGows
 2uIU7gdamXBAUEfP/4FiOvX8K+yZUcFOMVyLItZuZZH2vR13a3SF6WGAaQDqkTbisJJU RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0rrgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 20:12:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30LH0m2X025763;
        Sat, 21 Jan 2023 20:12:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g2aw62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Jan 2023 20:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2lL9CAXOvOgOo61nXcjVQNfjZLv1zFb4MQgoeIPYb/UG0g19BFwqzDGEUxll8RASOLzG/Ellssgb1I9/OXKc1iwRCKVGBMgG1CazF2SEaL5zIzaD2GF7kABp3qD2L/0XmoU8sI8+3td/WWo328pO+FKTF/vqzryahapzN4iwtPfiVhuq4sva2jC05Pg6udXJcbxKXRT076KAuxyu9b05shX7zf+F7/H0yCfUdtJBtgy9BiyRAeETX3JCZ6+ehNdUg17chq0ltm5RlWAYw4CvQ0HzqlwodruUThjtcCHmG9N/fnWihsZoeSZropjN7GsxD76JgqNKwijZ8AurU/UyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk2W43o1BPpbf1uAwh/IWnfk9UirP7V6+H1j7cMGYqc=;
 b=kHfkzAKmEZ0YbxXS7K+GawrsTzTcLlebfR+khuELM9aPaFPpMnXcu5gbaQTeOyHnguN2fBNw08iKbddMGRcsAi5PuCQaeLnXB0jQfcRVdCy1P4FAHzdKiC33MRj4LViA+5ZcWPvGeJ2EOrfCfDaR8VZ5T79yA+93DllpizW26GYqKLA22imPBQkPIBPBoBNLiSQK5jsoLcwmlKXJKKLhdOoYoAxeTUCX0Vbz3jxzvakvRJDYLGg8Dt013UwN73O4OYyVQ5atSptGoqfBRbJ+8smVd7oqbFZn5eQqTKQrGIHTdQ+BoS0Gckd6qb5htqKZ8JFijSVINflJcaIaE+TgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk2W43o1BPpbf1uAwh/IWnfk9UirP7V6+H1j7cMGYqc=;
 b=yCQD6DUKl8V3riyWq5SF2mi5ytpmBqsS/rmUo+dVIj16FjZA8nzqHB9/zlYmmtW9ybbuMGIAkYNhUNqJ59l5dZqsoa4JR0BM7FgZc869ZMd7i6Hswe/BULgv1Iqp719ZkILkaR1gLRSrkBL4HQp0TtXcboC5yeYuCn4IXz5TH/0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Sat, 21 Jan
 2023 20:12:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.6043.009; Sat, 21 Jan 2023
 20:12:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Topic: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Index: AQHZKqtMKSgqI33qoEK/JPELcgPtS66lMfqAgABiFoCAAIEkAIABHkYAgAILXICAAA8igIAABC4AgAABxoA=
Date:   Sat, 21 Jan 2023 20:12:05 +0000
Message-ID: <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
 <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
 <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
In-Reply-To: <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6152:EE_
x-ms-office365-filtering-correlation-id: 30dcfb46-34a5-4a81-edd5-08dafbebc481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFHp1OTqu2JN+rbqZ0aY5Ue43Te0+5dbMSHOF85JLLH3dxU83+CfBbBNGKcSy9GrZF6HpwDZTqOxsjM7ihtBAOdo71EfAb8yqWX7LactTxty/mDe3DDdUARlL/p7+FwZm9UM5Q65aLJQF3WHDvCSVS/2nBU9UHsc44Geai4JsILBCv84BOoCmVGGKi5rqWfCM6/phi1X5rrpxTrS1fe9YQIxdveP/9uREo54oNyjYUw+1VHGCjSEBiV/sGqjoQFYHeD0iu8XfQmNJoSqhpfpYf8CoTfsI9ggkX3QyQ8gwvCrF7JTTgBxY16QDQxZz535oIIVMbK/+R10cp7JeUgBvMDREKE5ayYPF4F1uln26HvotPw9Pt0Gnefu4b0bgZ698aB4ooddPZpfc7crh8fe8Z73Kw0c3HS6nf+7mh8rOkllUASeWfXhDS0Z6BaZMLasteRBB10V3I35ELinDydP/mB2lcfr/iS3UNpYa+ctZ2Fn2ZLBLcnkSg/LsCjTddGfTIEgM/I0ylWlVwumbOEbToxUBSWSPO2qeXJwKRPjDXkw0KezfUoTJ7fUn92hMdHfLuPoZOt/lSy1mWyGyIEUSbU2BFsv/brwzqqbo+gRS4Tl7srdnQ8ZPdCFyi/zu2UIbu7JvdTHnze88KdyCh0eycdtdMM9tW2tQFkjl9FwDYd2TuayJIxpn8lZxegrWNdKyuC5352QGGoq8GxtIenlfnvMrNmOnkeg4R7zT7bKPOM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(6636002)(6486002)(36756003)(83380400001)(2906002)(478600001)(71200400001)(6512007)(186003)(26005)(6506007)(2616005)(53546011)(8936002)(91956017)(64756008)(66476007)(86362001)(8676002)(76116006)(66446008)(66946007)(66556008)(5660300002)(38070700005)(4326008)(122000001)(110136005)(38100700002)(316002)(41300700001)(54906003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G+UDTfCY3Y6Ca2O3jbCXRN+uAm8ZvKxClVWJhjr3eSXa4ynTl8KRzjm8KWvJ?=
 =?us-ascii?Q?LCInP4J9NK9tSGq6Oj/4cPRzDAJkebUUV196Yo7yQUst3NBG/Z816s5e3e6k?=
 =?us-ascii?Q?587KphM5BbpjE/h62zGKj7lUr55yE4iHYhxs+azUpeKAwiTQf/tAAmYiYXA0?=
 =?us-ascii?Q?9YqaMgqehRnvBBVX6oT3tGkhJr4JS8mPa/UBLb2BxZJBPaHUo7mWeHQuzFq0?=
 =?us-ascii?Q?mJFqPCChI1Vsprj/lPefZazZhQ5zhE/U8NCZHJR2ccG4SZUD7fCUwj6OP/ik?=
 =?us-ascii?Q?ZCwaS4/20dzV8g9Dh2CPhO7asJ7FO5BCxi1DjIy0Q0Ozjktwp6Y7nX5Bis4F?=
 =?us-ascii?Q?zd2BNifPib2Aqj/9Qu90yARoAbSspBsMH3KWTfovylItBxsCIvaxp5Mqc8Qc?=
 =?us-ascii?Q?UuvnI5aDE6FblRpgLgr9rSq8F/XECW1MFTY3/Ih81b0/r58u/PiGbFfPgDf7?=
 =?us-ascii?Q?0/6j5cjjdxXkijzFL7x/l3FUlaQN2gkCLvOGzTsXlCMFZBxgDpjLUGmrLZSZ?=
 =?us-ascii?Q?yHfPgWUElhZCjV/jP5feVlbZ+4av/QWkQghzNmNQqJBtyhn0/JJtDEnrvaUe?=
 =?us-ascii?Q?sKAFXYtpU+8SoAW++GODcNUzqRAVzROiv4GrHyO1hqYUqEM2pE0NcSKr+meG?=
 =?us-ascii?Q?XcFmfgm5K57J3K5bBKtBCdZprjzrySRnQcd1NBZT/oOYlA0dr3GVeDvC/A0L?=
 =?us-ascii?Q?r9LWD7EJ+04yusBNS3BTpk9L/bUP121sDmOtemBMzbRHvBPypjL+iDoOzyjP?=
 =?us-ascii?Q?E7avWVhXdhcqE6GoQwHsYOG67rHxCfGYy/nw/XJS0JVPJWVX0/BFi/vvI7Q7?=
 =?us-ascii?Q?TMpV9EZhokoZX+2q5yRfwwSQcG0g87QJyi8FzV5u94cmDTSaoL7RT4+bt7/E?=
 =?us-ascii?Q?MsmdnwZYl54jMa10Vnu73SABdUvX4hmncCtmSKw71p1ERhluGFD79otnHbLl?=
 =?us-ascii?Q?5/SAqUGn+XIhn27Qpk6/xoeFkABqGA8xRHwAL9zPrP67yb3H5cFBFaR/PTf0?=
 =?us-ascii?Q?P56cYGYSD7G2Cuc7b074zHzJvUYqr6C1VSwnCr+PlTIfL6T5o8d0kkG4vIeR?=
 =?us-ascii?Q?eUziKJOd/j/QGfkBqWduZ4UWr+gmzZ3mJMYPX6WUT0m9AlytnE6lhMjTRQ+B?=
 =?us-ascii?Q?2YJehoDPWyQs7EIQjrdgDSabUKzgc1vR+SwQKZbr3uS3jLgVSVOLnGwbnFri?=
 =?us-ascii?Q?NUW2IlxPL+2OaIwXaIOeBEWZkIUk4FQ/Z4PhuXsaF5VqqOyIOoEzffdn1FNY?=
 =?us-ascii?Q?6iQIJwLuPYxKXu+cS9JcqiQg+fJo0fzzZVRUce93wHU+Jr/FFtykDuXs5Ypj?=
 =?us-ascii?Q?oqfZM6KstK7MGWXbOy4Zi/HXVuQ34Pc5z50UDpn+zopt0aBd8Edz+8+Q6N5D?=
 =?us-ascii?Q?oVaZgmzXxpbPXSzmzbTj25XmCFU7o/EUxnvg/LVKz2tyqJuYcCXVe0u5OUM5?=
 =?us-ascii?Q?yC8hrBQot3FXhziDDKVwiJ+BnJ2P8FTZN4YKPJ1GzM2xukVBA+anoCfe/jtC?=
 =?us-ascii?Q?FbLO1Tywy33FgK4ikRTMuok/7eAaIveKg66t0bpCbpz8gESVv2DRGu2Ej1Zy?=
 =?us-ascii?Q?3ZqXmFvDFkiJd4GslfWs1yoLFF1GohYYnWb56dX64POEkjBZkGc3wieyDBnk?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <664EFEFCB8EF124E9985FCBDF1E60C07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FXASKJnOqqWJeEjjg/M1ETs9D0C+R2q4vhGiWeXVbv3Qlw5QoyDnZm9JqYZzWu8p5GfZXrR8Cp2kd7jp1aW7PtMSXnRdZYxUYVFa6XRUCqYCQQqDpeVWsDXlgx1jnbccozndXV6P6u5Yn0h09aDycwbRVNm7nzmJk7bCEXTKKJM5IUNzLuEGkZBG4ms0LigvouSCPz7aADH5Ul34bwwOjA6v/bNnOkDEOUbq1+bBX7ewut/l15tOi/ARqjf2KV3faPESiWti5G8nvloOVjGjNQroMvdA6pKjIb5Kg5+PPNZ/w68YT/vEhfyx3ole9VTBYk/tPq2MJlIBuImtyC8TtcWdJ8ozyvJtIv5xVsOxpSa6b0Xxj6NtWiCJKj2lYkJLq8dCg5K3xRepcamFL0p+ZVVx9dxSoybweELBkFgtHkKNogOg0Hsb8bjrQoWj66Ucg/+sw3Dra4J+Y1MNMSDDA16V33LqEKQEEtMcv5RL0eHAgX3shJ5t0uta8c8culZLkFGJ+JsMvGcu+bX12+T4J731PDalU2/JfJcHVlfpZQ7N08ZCcvpXTGSS/pBRZoz1dyhn+X4a/jm0y373xA/FL2SJqRu37F/vtjZvGxKRMC5Z4od33+d1gB7/V4rCNAiB8SAgnzuJ6y1lY37bEsxg38a42h1DTAYOeeB0tPTbNi7s65orew0fLdyRejst1KgBx/JP6+SCZK1H10N7xuDGvM8igF6zeQu83zBi2bbQrU4Je0CEhsOHER+MjD7iuMixSE/7pD0WHliSTjxwHyX8ek071RX14x04RufGsJuDwyT4OiqNOeBrArfGDo5/YEoh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dcfb46-34a5-4a81-edd5-08dafbebc481
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 20:12:05.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVq34E9WNLYzusp9lb/HAOJz9moky1cq3UrhoYmEMBNrLdwzVIfGvlUPrt9gQJdiuTYUg+qEwJXSfXgabBx4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301210196
X-Proofpoint-GUID: clIf4G_eikjoIndS8Nij2Q8y1nXM3pP9
X-Proofpoint-ORIG-GUID: clIf4G_eikjoIndS8Nij2Q8y1nXM3pP9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>>>=20
>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>>>> There are two different flavors of the nfsd4_copy struct. One is
>>>>>>>> embedded in the compound and is used directly in synchronous=20
>>>>>>>> copies. The
>>>>>>>> other is dynamically allocated, refcounted and tracked in the clie=
nt
>>>>>>>> struture. For the embedded one, the cleanup just involves=20
>>>>>>>> releasing any
>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is=20
>>>>>>>> a bit
>>>>>>>> more involved, and we need to dequeue it from lists, unhash it, et=
c.
>>>>>>>>=20
>>>>>>>> There is at least one potential refcount leak in this code now.=20
>>>>>>>> If the
>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files=20
>>>>>>>> in the
>>>>>>>> original nfsd4_copy object are leaked.
>>>>>>>>=20
>>>>>>>> The cleanup in this codepath is also sort of weird. In the async=20
>>>>>>>> copy
>>>>>>>> case, we'll have up to four nfsd_file references (src and dst for=
=20
>>>>>>>> both
>>>>>>>> flavors of copy structure). They are both put at the end of
>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the=20
>>>>>>>> embedded
>>>>>>>> one outlive that structure.
>>>>>>>>=20
>>>>>>>> Change it so that we always clean up the nfsd_file refs held by th=
e
>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminat=
e
>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>> ---
>>>>>>>>     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>>>     1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>>>=20
>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct=20
>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>         long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout=
);
>>>>>>>>             nfs42_ssc_close(filp);
>>>>>>>> -    nfsd_file_put(dst);
>>>>>>> I think we still need this, in addition to release_copy_files calle=
d
>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 referenc=
e
>>>>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put is=
=20
>>>>>>> for
>>>>>>> the count added by dup_copy_fields.
>>>>>>>=20
>>>>>> With this patch, the references held by the original copy structure=
=20
>>>>>> are
>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. That
>>>>>> means that the kthread task is only responsible for putting the
>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I thin=
k
>>>>>> this gets the nfsd_file refcounting right.
>>>>> Yes, I see. One refcount is decremented by release_copy_files at end
>>>>> of nfsd4_copy and another is decremented by release_copy_files in
>>>>> cleanup_async_copy.
>>>>>=20
>>>>>>=20
>>>>>>>>         fput(filp);
>>>>>>>>             spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqst=
p,
>>>>>>>>                      &copy->nf_dst);
>>>>>>>>     }
>>>>>>>>     -static void
>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file=20
>>>>>>>> *dst)
>>>>>>>> -{
>>>>>>>> -    nfsd_file_put(src);
>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>     static void nfsd4_cb_offload_release(struct nfsd4_callback *cb=
)
>>>>>>>>     {
>>>>>>>>         struct nfsd4_cb_offload *cbo =3D
>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct=20
>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>         dst->ss_nsui =3D src->ss_nsui;
>>>>>>>>     }
>>>>>>>>     +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>>>> +{
>>>>>>>> +    if (copy->nf_src)
>>>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>>>> +    if (copy->nf_dst)
>>>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>>     {
>>>>>>>>         nfs4_free_copy_state(copy);
>>>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>>>> +    release_copy_files(copy);
>>>>>>>>         spin_lock(&copy->cp_clp->async_lock);
>>>>>>>>         list_del(&copy->copies);
>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>         } else {
>>>>>>>>             nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>                            copy->nf_dst->nf_file, false);
>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>         }
>>>>>>>>         do_callback:
>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct=20
>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>         } else {
>>>>>>>>             status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>>>>>>                            copy->nf_dst->nf_file, true);
>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>         }
>>>>>>>>     out:
>>>>>>>> +    release_copy_files(copy);
>>>>>>>>         return status;
>>>>>>>>     out_err:
>>>>>>> This is unrelated to the reference count issue.
>>>>>>>=20
>>>>>>> Here if this is an inter-copy then we need to decrement the referen=
ce
>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be=20
>>>>>>> unmounted
>>>>>>> later.
>>>>>>>=20
>>>>>> Oh, I think I see what you mean. Maybe something like the (untested)
>>>>>> patch below on top of the original patch would fix that?
>>>>>>=20
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index c9057462b973..7475c593553c 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct=20
>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>           struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_net_=
id);
>>>>>>           long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout=
);
>>>>>>    -       nfs42_ssc_close(filp);
>>>>>> -       fput(filp);
>>>>>> +       if (filp) {
>>>>>> +               nfs42_ssc_close(filp);
>>>>>> +               fput(filp);
>>>>>> +       }
>>>>>>              spin_lock(&nn->nfsd_ssc_lo
>>>>>>           list_del(&nsui->nsui_list);
>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct=20
>>>>>> nfsd4_compound_state *cstate,
>>>>>>           release_copy_files(copy);
>>>>>>           return status;
>>>>>>    out_err:
>>>>>> -       if (async_copy)
>>>>>> +       if (async_copy) {
>>>>>>                   cleanup_async_copy(async_copy);
>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>>>> condition and only decrement the reference count.
>>>>>=20
>>>> Oh yeah, and this would break anyway since the nsui_list head is not
>>>> being initialized. Dai, would you mind spinning up a patch for this
>>>> since you're more familiar with the cleanup here?
>>>=20
>>> Will do. My patch will only fix the unmount issue. Your patch does
>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
>>=20
>> Or do you want me to merge your patch and mine into one?
>>=20
>=20
> It probably is best to merge them, since backporters will probably want
> both patches anyway.

Unless these two changes are somehow interdependent, I'd like to keep
them separate. They address two separate issues, yes?

And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
for nfsd-next. I'd rather not mix the two types of change.


> Just make yourself the patch author and keep my S-o-b line.
>=20
>> I think we need a bit more cleanup in addition to your patch. When
>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
>> fails, the async_copy is not initialized yet so calling cleanup_async_co=
py
>> can be a problem.
>>=20
>=20
> Yeah.
>=20
> It may even be best to ensure that the list_head and such are fully
> initialized for both allocated and embedded struct nfsd4_copy's. You
> might shave off a few cpu cycles by not doing that, but it makes things
> more fragile.
>=20
> Even better, we really ought to split a lot of the fields in nfsd4_copy
> into a different structure (maybe nfsd4_async_copy). Trimming down
> struct nfsd4_copy would cut down the size of nfsd4_compound as well
> since it has a union that contains it. I was planning on doing that
> eventually, but if you want to take that on, then that would be fine
> too.
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



