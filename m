Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A467E994
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 16:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjA0Pf2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 10:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjA0PfX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 10:35:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFB83949
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 07:35:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RETBwc006225;
        Fri, 27 Jan 2023 15:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JS0vDisaGa+a5uySwl2nWSIaKUhvZmS5GZQ9JiEbNKk=;
 b=AzMvulyuiv7Gk12LJAgilQwRZ+tkOSzWJhW59W1NP+5n37zVkfsqH09M7XIDbC7c1zas
 x5PEnSqlK8OWirz3F03ie/Z9T823vDbo4my+uwlNrl+8FzzmgF5/SgZKX7G2SlQuwwP9
 z152rEt55hMVEtJ/qJmG/xOIKaAt/kufibBFdjaWKN92z4kLCPxLNQBcwdZxSH55Mgv+
 HFood6cQTc5gyD6jGJJ0cJ+Dv0TD/4WeU0PMXzfcqt+LdT84IPUv5jEIXz3y7VDcmho0
 iWaNRjmMTBShRYJwZXbaZldNdJukdXaI2/kI2rHhdVJirM9HjN3M07gVsUgVFHB1CRy5 Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xad0px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 15:35:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RF2ZHG010761;
        Fri, 27 Jan 2023 15:35:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g9be1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 15:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB+FxDhtDDwVGMEP0syw5n1y9A56BL/lv2ILxUR16+/Az6sh20vaqnO8hJDrJy+oVuG87phQUK55h1upHYAo2V6pZg5xi3EQJOZh0LzVrJmIW6ZFj20JOotxFNL2a7LmOFAXiNDb0+oWpVC1fpH3pZVFEwSeCcVLk7fH6O+8bt0XcDWylVc2/qj3FB/jBXX+xZx1kzpaqB+6CQZhuBToL+E+jOtNyzC10AL3eFFhc6bAxVU8eoz9gzLbbOZVHitG1GFVzcP8h2DasR9z+HFzzPcbBPvzUqP6tsLeWEyGZnqzuPOeSsAfxwY6BYp3wcThyeT9mTv/QuC5dx23yhM0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS0vDisaGa+a5uySwl2nWSIaKUhvZmS5GZQ9JiEbNKk=;
 b=nXY7I1pAjsk/IYBuuhyeW0mwzit2XB+lJ2waJonyB7jFKfRbyqmnYhkjhlFIdmepifx3hRt7wsVDBqpoQMIKKIy58EQhMYeiBVaSNpRXJrWw3RqqLvWAQfC4lksDNuyBZGgkOg3YRMi0KRzrS+G+YnlaNi/rrty4kz5YB6wHzUHQEEbExi1oiBowEtumeRciKurfsiIuiMAM09a00gW3Rh6T+wyeVewMTqr5Lxr+OAmsPZNsGfftBIyEDbK1khY8c803tLt8jXvrQhYd42onqCgMP/iTLbVWXipAe10fvGZ/yO+tRSM9tCS7bwuOfWT2jrStRdJkzwaZ3tKQU91mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS0vDisaGa+a5uySwl2nWSIaKUhvZmS5GZQ9JiEbNKk=;
 b=SZwvG+Mr5qtycPGFzjFc3ifKMC8UtdpgqdAOQJX7ZBmD2Dqj7fHulcEawSfzS3S4rCBZPNhrpP6iwU+Lw9OueqJpwTQDSyZzQlme6vIgfkkyaxI5M0k7JpmWefXIVNfaYqTq/S6P/Rc5u/L/fbT1raCY/qiQeZLN7M5eydILJ9g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5246.namprd10.prod.outlook.com (2603:10b6:5:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 15:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.013; Fri, 27 Jan 2023
 15:35:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Topic: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Index: AQHZMkg9QowbIAXTEkyy+4RjwAMvNa6yYYqAgAAChoCAAAE/gA==
Date:   Fri, 27 Jan 2023 15:35:09 +0000
Message-ID: <78E46DCB-AAAD-4996-98B2-B85087226DFE@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
 <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
 <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
In-Reply-To: <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5246:EE_
x-ms-office365-filtering-correlation-id: 067e238a-b260-4a3b-ef1d-08db007c130f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMx8hr6ChfUKQxLMvz4OSD39hLC6YahOWxSN9M8i/F60W8GgPjzubhdaUmazktigPk7wNUE+zKLgeEyW7olVT7eI8T33yj2jIiHHBeFx4Do3DwZsGcUNbkvD+or4Ti0IWyKFl+5O8FzUGRHLwpMq30hGuyVOa6WgV1ew0BNR9+9LyiMl3OIb9INFk2r+0iVz4GSc8SVfNI5p7F4fBvLiO+dznbpg2ca0rpb+MNi0RxUBcI2ZfVJGFcT1hbccs1dbLyyrOQ7opY74tC5rsX3fD/1SJRXORciTc0yDQOn0avGUjfonZj7BV0GXqFmtBkfEPLigg1hd2G2lp4DgcDVIUQaZs2g5arq33/mK8FL0ZH/kpweRRThJ5wSvXg1GIpEpNcG0vNsLpOKX/HBFSy1cs4Fk592ZUeoKvPzE3lDwt6jAAy3cY3Bcz6UEBo7aO6MwsyW28EZQOiqDO5emGfR+uUQzQXSvF5hP/gwHhXlo9mDM6y1ChmqtuqYiJxkBjGZrMnUj82inzR/XHF/SUMXqY59UwjBoS9DVAMD7B4Yl60NPV8JPA8l4ThKvxw+10ogdIptHu1wZ5LjHREcQpVBnKwrWRXtF2gEnL2sAB9HwbnuwS2R61WqK/grT4fUzlSAHIF0h2Jn4CJfUS3G0drc85HdI7OgDsoAgRcslVzym9h4CUlXAzf+k9CKTdB+baBc3LXY4BvGC6zQy+Rg8i5Nm3baDIPDVV2kSSoTHtSmigSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199018)(83380400001)(66476007)(4326008)(64756008)(66446008)(8676002)(6916009)(66556008)(66946007)(41300700001)(76116006)(122000001)(38100700002)(2616005)(91956017)(53546011)(6512007)(6506007)(38070700005)(186003)(8936002)(26005)(478600001)(6486002)(316002)(5660300002)(2906002)(36756003)(54906003)(71200400001)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?POLJ8bdjBEjTs7+ftToDtsyMsP/Pk4cVgm3zvQkXKVF5INUC8v1ht1EptmfB?=
 =?us-ascii?Q?ImrO0fJRsAg7juCHnZxT0VkNMIr8N0ta5gI4lKgpqtYeQFa0SmewdDdigg9f?=
 =?us-ascii?Q?Ntbl+rbh9sMwU6jlXgVowKOclOX0OkeEtuVzQQ45li1Hr+IDb+HVBf6BbvSx?=
 =?us-ascii?Q?3W3GpxfZkcW6q7sHEn3Jk3V9amZUyNZP0Gux1gRjSg+ACaWbEeoAbvQyWGAA?=
 =?us-ascii?Q?IT3I9zkZtvsuH1IoIH47Q2UUH6MiUB4X/rBg+xPcV60FHsPDcd2oeY8jKjEq?=
 =?us-ascii?Q?rVHk1+tkUQ/Eok1rsC5Am3pVM4z5wRiJNLvkB5vbdfTdRdh4HiYWdXkSWA8L?=
 =?us-ascii?Q?6v3wrNrKua0dyBef50h82rd3PQ0jTtIQbS70suswKMB8VwTvyXlA7jGYuftn?=
 =?us-ascii?Q?jeraVAPtFFTVhj7kj0+0ZQl7iuS8+QXaD6/cC8kvM1WeiBwC+hYkyaYUbJ5R?=
 =?us-ascii?Q?iRbTHc4wRS77tio4SkheTxdfsZBLf9K8PrQRbAYaOsDu6P/yCSIsL4+m28Ox?=
 =?us-ascii?Q?Q7Iol8vdYySYM68db5QwHqMRuSZCen3CzAiROWPTpcDSGOfHEecSYWP9Tt77?=
 =?us-ascii?Q?5VspHXerYU1aQTvcL0Mh1+8zU9r+CvecnjDhuurBY6s531NpPzjWl0Pdwte1?=
 =?us-ascii?Q?nyYLFn9GlmU4yS4ewbV7ou8TjRU5QWnR2xPTm1aC5fT17asaL01Q9Yy8PMes?=
 =?us-ascii?Q?AaxM09eqp+8vJFzsEXgZzrkOJUkD0S0y0PsoXV8x0ELsDcFVg6zjFgRY0hsB?=
 =?us-ascii?Q?CuvjLzvrF6LwvpgCR3s26Gz2qjtnPRL1SCSrhjjSSsQUR87TDDw3tOoeWWIJ?=
 =?us-ascii?Q?y3eNOxGFQvbcTz3PzSmMwAKSfCJ535+L19Rk7Wolr/ln2thj7f231kM9heAF?=
 =?us-ascii?Q?agauX2M/4Msdb6QaGESRWB+fGpr8Kb8Ps6XH7Nw7JqFVs4w6kPNzuspX03Ss?=
 =?us-ascii?Q?N78Uj7nVVbHYowT4P9SxYF3mecPW9iGTeOREe+EZNCOFj5rYT4+QgWEsHAb9?=
 =?us-ascii?Q?+XGSKj1ALgK5lYofizRQReOP+5qlu98UzKqXcxg3BO7UxbvKzs9679wQxxkE?=
 =?us-ascii?Q?qAWUUrP4hxvTj5if5DJWCUC8JyaVekFIi0fWFijo8Ww1rw7uSdTPHYaqmTUz?=
 =?us-ascii?Q?kLTMCXRaqKPhb37qF3xH8O3crzfNsRWmTMw9qKvRxIkyJujoLvmNJkITXDxU?=
 =?us-ascii?Q?cM1qVO8LlKibJfNLV/GZcbJmEaqTRrFk0xbrv9swIYoXdwGwf1HljRqrq8aQ?=
 =?us-ascii?Q?2vXzBlNHCbIyW63afIOlZ0MaU5no+Ixjd2SSf2H/67pioxBIxFbE9h1LWE9X?=
 =?us-ascii?Q?m4voYve45jXx/XMCbAFVvlJKsq9IeDiSFYT6CnXjKMTKr4QWLU0HHox0ys29?=
 =?us-ascii?Q?Ie3GXr+Guzf7u3wHLjyr4+NgV1mqQGYwLBFRvx5Og9X2RxwTRxWyvuFRpaWA?=
 =?us-ascii?Q?9YDfrikfM5tJWlx3kYYuJZIV8NJ58j0rBS+mkNERCEE5IjiRnA7ylQkhNQTt?=
 =?us-ascii?Q?0v+Wk/dk0B0Bg3CNxJpoHZ59NroeDG0GnfIvx9WdWhr1bovIwY+axr+8Bncc?=
 =?us-ascii?Q?H85931v7jZLk3Ll4bWmpoakxmrd20CREuPzGzdxGSQ00aoQjtrERTeX8NUJp?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94B7FC1F271F734CAF137EAD93AED8C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLw07u27AsX7EGCA+GwQbejfSx4cbneS4ZikHPbP3yE8jLHdw191sPwXYfDqbOftJf7kzORcre5bsHKUGGehOZO8awPgu+9iik7nrPEHM31qDsWNj1PEdIkMZvRv7BsPS/+djZkgqjP3DKLPSebvKx1EWlWJPkyxbemoHxzqEPYO43BniAoaLg8lP047vUmYJy3zCbu45S/IJHw7BxUdJ1/XO9DGGcjzceBmhQvnLGXJ/g7rI7jMrsfQbJTdVSpR50TuUF+mgZuD+juzHEKObbgLFKIWIr2xgOJ7yx0xFtjwxWrOIWoXb3g8SJpTE2A3+wmIM6tTVydy+OBRwVM7501ETR2ldgdqIE/YNFQZ0ZefuLb7vn8OUNORKbCmkYzrPWiNB6TXcnOP75vRfOIgS2v7odw5fTm8F7bCvNEYkTnMBv5sAoy5zKLsqw1BEiKYm1iQPKFRpUqMFbYtIV3Eze/OAvh4EKMoQQ3FK0mq57P6kn0LToAKyZxfFinAXuQS0NgmQLRsXqHfZUoVYWlvf28Wwm0dKYsjxl1j4iEEec2iVQ8VH3VC9uA2JjRSFhyJjeEKpuAEmekR0chg6Im12A0tm3NIUBDVQXvmui0wl+CleJqpV2Toijk4YvzFIOeEcy1TgctZtAruU7xkRmfzgQPtLupJEPifd+23+edqHwfklzFSWPra4k/tlJdIUodwB7Wbe7/b9kso3h/O33KiZE9SkQqnAnCFOWN79wclGyjvJJq4pk4p5SEovykejtmKUsDH7p3icNJYPvxOj4TKsdYeFx7mYAqsDhIaWYgzOsHHFpAhraJXmcETjdWoM4Nw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067e238a-b260-4a3b-ef1d-08db007c130f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 15:35:09.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFkO+VY1CJtkX/Jo1c+97GuZ0a7yTUuFsy8mmiPKikMpc6cj27J1vXkR07SwtAoOpQVZe1Tn3E7ircUlZMhAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270144
X-Proofpoint-GUID: 4Ci0inr18Yn-QRfmt_-wqbavPt5zaxVP
X-Proofpoint-ORIG-GUID: 4Ci0inr18Yn-QRfmt_-wqbavPt5zaxVP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2023, at 10:30 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-01-27 at 15:21 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> We had a bug report that xfstest generic/355 was failing on NFSv4.0.
>>> This test sets various combinations of setuid/setgid modes and tests
>>> whether DIO writes will cause them to be stripped.
>>>=20
>>> What I found was that the server did properly strip those bits, but
>>> the client didn't notice because it held a delegation that was not
>>> recalled. The recall didn't occur because the client itself was the
>>> one generating the activity and we avoid recalls in that case.
>>>=20
>>> Clearing setuid bits is an "implicit" activity. The client didn't
>>> specifically request that we do that, so we need the server to issue a
>>> CB_RECALL, or avoid the situation entirely by not issuing a delegation.
>>>=20
>>> The easiest fix here is to simply not give out a delegation if the file
>>> is being opened for write, and the mode has the setuid and/or setgid bi=
t
>>> set. Note that there is a potential race between the mode and lease
>>> being set, so we test for this condition both before and after setting
>>> the lease.
>>>=20
>>> This patch fixes generic/355, generic/683 and generic/684 for me.
>>=20
>> generic/355 2s ...  1s
>>=20
>=20
> I should note that 355 only fails with vers=3D4.0. On 4.1+ the client
> specifies that it doesn't want a delegation (as this test is doing DIO).

I used a NFSv4.0 mount for the test.


>> That's good.
>>=20
>> generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wrong fs?=
)
>> generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wrong fs?=
)
>>=20
>> What am I doing wrong?
>>=20
>>=20
>=20
> Not sure here. This test requires v4.2, but the client and server should
> negotiate that. You might need to run the test by hand and see what it
> outputs. i.e.:
>=20
>    $ sudo ./tests/generic/683

Then, these two failed only for NFSv4.2 and are not run for other
minor versions. For some reason I thought this was an NFSv4.0-only
bug.


>>> Reported-by: Boyang Xue <bxue@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
>>> 1 file changed, 27 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index e61b878a4b45..ace02fd0d590 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *ope=
n, struct nfs4_file *fp,
>>> 	return 0;
>>> }
>>>=20
>>> +/*
>>> + * We avoid breaking delegations held by a client due to its own activ=
ity, but
>>> + * clearing setuid/setgid bits on a write is an implicit activity and =
the client
>>> + * may not notice and continue using the old mode. Avoid giving out a =
delegation
>>> + * on setuid/setgid files when the client is requesting an open for wr=
ite.
>>> + */
>>> +static int
>>> +nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *n=
f)
>>> +{
>>> +	struct inode *inode =3D file_inode(nf->nf_file);
>>> +
>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
>>> +	    (inode->i_mode & (S_ISUID|S_ISGID)))
>>> +		return -EAGAIN;
>>> +	return 0;
>>> +}
>>> +
>>> static struct nfs4_delegation *
>>> nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
>>> 		    struct svc_fh *parent)
>>> @@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>>> 	spin_lock(&fp->fi_lock);
>>> 	if (nfs4_delegation_exists(clp, fp))
>>> 		status =3D -EAGAIN;
>>> +	else if (nfsd4_verify_setuid_write(open, nf))
>>> +		status =3D -EAGAIN;
>>> 	else if (!fp->fi_deleg_file) {
>>> 		fp->fi_deleg_file =3D nf;
>>> 		/* increment early to prevent fi_deleg_file from being
>>> @@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>>> 	if (status)
>>> 		goto out_unlock;
>>>=20
>>> +	/*
>>> +	 * Now that the deleg is set, check again to ensure that nothing
>>> +	 * raced in and changed the mode while we weren't lookng.
>>> +	 */
>>> +	status =3D nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
>>> +	if (status)
>>> +		goto out_unlock;
>>> +
>>> 	spin_lock(&state_lock);
>>> 	spin_lock(&fp->fi_lock);
>>> 	if (fp->fi_had_conflict)
>>> --=20
>>> 2.39.1
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



