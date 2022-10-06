Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA635F6B4E
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJFQPL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJFQPJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:15:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C17264BE
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:15:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296FhttY000745;
        Thu, 6 Oct 2022 16:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I/X3ETUTg1RVgZVfyycoG1NMcuz+NfYSp/kMnRuDWpc=;
 b=PzY6OU098wsD4MzYwezttBHxXC1TH6bF8HVfyKq5ocVZ2vHptpRC6wMi4ezvFeDVIZM0
 e29Ep1Vj4oVNJFMsSuEydp9i4GXq8hiTja/+mvepaSi6ApE2nq4PrTMwkGaiWrvTv67k
 ju5Bj6ZeS+wVjfGq4flKWNcGUN2G3alh7zItNZUHuoeyqeheYfL/g8Z/1fFJGBzQvW/y
 ZCDPnChYTVOFeOo9B7b2zW6BAzFzAqcTxff04CGFhRQfHKcTDvNGmRpnvBGLsqq5HMFX
 FZhEMC0zCHmCe3hYsV18QYpSi34UfAvthJc3phPkhqYiqFVPYQY9WZAbcr90dVnyp17R lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2vskb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 16:15:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 296F9j3M002695;
        Thu, 6 Oct 2022 16:15:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0c9ush-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 16:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhIfmBE7J9/7nU0toug1VP12/ONs6ZvAV+0pHWkF6dNeBmkyd41iEV4owE3tGZJG5EsdlR6BJO45hPvrD6Jvd81tdEnbi+Mk9j457E92/8ZGdNGfAW+zG6hJnl+H+LGIOFjJohOKcbNKGKEGnj8OR0MH3F1SX/4S8Ubn6v1nqtRxOQ2lH7zkV1A5Kdif479PRemcKpgmG13DZHKQu8CLpaja5zNwofdKR0kVySP41dJ+bNtwknU/gx9sXH97pBLOVJ4sc/Y8mlzZe93rZ9wSJwvJUP9yPXil5NYoRs8Ag06JxkEaNWWegIiUCkSDs5UcnrqUnW3JQ5TnMbw1V2ea+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/X3ETUTg1RVgZVfyycoG1NMcuz+NfYSp/kMnRuDWpc=;
 b=W/rdWS5emYqC44qV96fqIo+xqaHuo1XjMOddHynzj33QJxIQfe23Wjtdc5onyAPjGhl8FEuKI2hpd54TlNETA16roB9+1WQDbn7iXJp/yjOHXqFLHfqaIrrl80xwbDh1pvS0pwY/J06ydVoimVfNE5FxSrm5DH3vEMrln3bessyCeuNSaZtbWbIDY609r9CQOvNpZ2h9wiVTu3gQ6TQsxCIvGRqh0+eXbpkP/kjmESjD0EYrF3h5/sSbXmMhBTeJCv0YExxJI7NzSUzQre2Cace+1hW0F5RC8uW8x1iQFXdHyTx3Hn4gC96D8hoMJ8ylAnfZymRBAwpOVQ2OkruaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/X3ETUTg1RVgZVfyycoG1NMcuz+NfYSp/kMnRuDWpc=;
 b=ErsNix/MGFlW0XKW1pz9RCVvXhie2PdXEzhr9ipj8dSSBWXd3jm17kdS6S3xqt509KHl5YzqhKZNpiML4I9LQ46AdURYBKqJQjEb+87IOmxpR3ifykOE4roSmVnMe9ck5kOWaDInRFTBWg3FsQzHNLEj5LG1W9nrTCSXgjfvwqk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 16:15:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 16:15:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2MqolQJfc1v/akaCAaqBZylZFK3/59CAgAGjhoCAAAClAA==
Date:   Thu, 6 Oct 2022 16:15:00 +0000
Message-ID: <128AD3F0-AB98-4401-9627-6F806023B132@oracle.com>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
 <166498178061.1527.15489022568685172014.stgit@manet.1015granger.net>
 <339F3E66-C90C-441A-916C-A41F3193E228@oracle.com>
 <ca8c3501e8a4a0e81e95aaaca49e00852d7cc045.camel@poochiereds.net>
In-Reply-To: <ca8c3501e8a4a0e81e95aaaca49e00852d7cc045.camel@poochiereds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5234:EE_
x-ms-office365-filtering-correlation-id: 57bc9e99-b512-4aef-86bb-08daa7b5eb96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRTCHLf9o9G4VGvPSFuBXJPVp6eJ/0iFOMLBKSvaiIofZfY3HnAFf0E2Wwr/wSjmiGPJBg9GU+J+X6UO6Dc9bZH9CTgvJOFApYvSZD87Dj7tqFFg1TEBkP7NYC4hXORYURjJn298W5t212MXDp49yje3FNFUBGiDUakRLwDt2KvdD+qyOSKjFGxOIP0kSeTAdygcua+GJGQkas9mXpw1Fu3pn20lQ4URqD6xcQ9J6eOc+hfw64hQK8JQwd6pJwR27yskBLt7kMAcC58F1IVFD6cZjO/oeg6oL/1XwO/oQkMxqMxINYcw5bmSPwTA/hMEUZWJSftnas2hOIeGAeVKx97GWkojR1bZGWBNYiWpDJdKrClQD0vaXISNKivpjNoAmbl5jCNhUJO6XqcXccXaep7Wnf64X2qF5aIL1toD0lqzMjyEB7GeJKtUjQcvpfuFd+W8yJ0KNQgvGXCK70v81JgdkhYiNulD+7lDoorlzQoDSmj9jvtV+L9M8aqZZqDswgLl4Fx1Rx6qPjKO1+mj54RSAWJW6AkWiPWoQ4J6Cne/805BUPfxiROuZSX8KUIHSkJGK1ILC2NTVvFNkGy5p++aTOtN3u1gScy4Eg4XFflWD5GWY2dlTBY4VZjqPBYJDHOqFYhQVianKKSVtFuiWrPJ4SWNt/csxI3qx7nPRpZBlUB+/2RbY7JARIES5dyLoCszXMJd2G183Hyh2ccdJRj5v77ZTwdV7sn+P64qz6kf6/0XBWsh3+bDIhk2t6+fMN6iPc0FIM3oX643KcQqkD0jsaAM/Iq+jNuuIRJwbawO7wJ4o5+VheW0eGJMN/mh28iQlO7X+UuDhiia7lytcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(36756003)(83380400001)(4326008)(33656002)(91956017)(38070700005)(86362001)(122000001)(38100700002)(8676002)(316002)(6916009)(2616005)(66556008)(186003)(6512007)(53546011)(6506007)(26005)(478600001)(64756008)(2906002)(6486002)(76116006)(71200400001)(66946007)(30864003)(66446008)(66476007)(5660300002)(8936002)(41300700001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ot/xTDP6FnRLSdJ6npLRnBJBxCHy1n69AsvEyh4rBpOcQZIxbGmdwXKHSvch?=
 =?us-ascii?Q?t78yfjbEVnI1zOtPu2RlD1bwRUTsL9wUH6X3FcTJ0sOcQxTfMW9ePJsr/EIU?=
 =?us-ascii?Q?39sht/9BDAZPIpSBOrkuSg9YcIDjfpk3GkefsBLC7NAnh3dSUIyqfyIdj1IY?=
 =?us-ascii?Q?EV4XvKcbkZL2YKUI0IH8EWq7KGv2Z2PRTLX7DICrpNuZhKV6JUkPiMA6dybC?=
 =?us-ascii?Q?YnziNRb4C1p7sx1n7GJ6bsGSFE46EPhJTS5ayWr9/V8WZbKQ5qexhG1bqSxT?=
 =?us-ascii?Q?nLY/uSNIl1rz/ld9q2THt1C8/DakCNv882SLnRfKGOcQuLdaJZvni6u0TfOf?=
 =?us-ascii?Q?7ldzls6gThg4TKoWi2BTtyhTy4p4g54WD1Z/dCmglKpgcPLkmnFJyCMQTAzS?=
 =?us-ascii?Q?42TpZ99RPajJE4dK5plXmy7WshyEhxQyEPaeKLtTj4JDjnjkzH3Q687z7hjO?=
 =?us-ascii?Q?fvwjvv73ENV13VRDEXm5soddkLBEqubKdfn6dMkcMCozaOiboItM2ubObyFC?=
 =?us-ascii?Q?Fl1oFVBZ90TawtbaWEIoOeB1OYMpe9OrChTxiPjnoYuDHbmHo4gBZ93/8cbc?=
 =?us-ascii?Q?5i07L2mfUFcv+Uc/9qfqD0+AOTobtHuxka62ws57ySk32VZvCkf3zE9IR+j+?=
 =?us-ascii?Q?BnSKXRGV26G6vrCSGKBB1tTN9sL+ykhHvJsyulLfsz2OYyICfpMlskZ06CR0?=
 =?us-ascii?Q?/+AW5+0KdY6+4M6Fz3mTK+n3yChj+UAJdqaesn4fiB30OPHJXUGKuqZf2U2m?=
 =?us-ascii?Q?Ir7YJVGRnNCpYHY2vS84pBDw391hNGC+Bni7Q0j0fzJHmL7Tx4ITHVpdThw6?=
 =?us-ascii?Q?C7XxO/9H+/uWZnI79AQeUndJo5iagbzOIx9NHrNfTcV/PoF/zXhSjZh0bZUJ?=
 =?us-ascii?Q?dm+wzSZLwlqI6fPQVf04SEGodhbn7xceppRl5Ouj5nN95ARqWjG72EZGHGLx?=
 =?us-ascii?Q?STPNwVnQbKBG/ceOrIFP2JIUL4IsuX24cQwCbwu4ALuQBMyE+kYmSrIzIZJn?=
 =?us-ascii?Q?I7h+wI//TEAgo/mX15MIWCoESX4wEwECk+bU+2gz8FhYPiFeHZ72pAZtA8Vc?=
 =?us-ascii?Q?4e6ggROe0/2ehAC3xXsw6egOjUoFGPOyi1hypfmMyYWHHHWfyE9gU4wnLHEF?=
 =?us-ascii?Q?VbO2ejp82WzrjY5XpDmLN4YCEN5OWL1OfmzBYmwQMDEjihynh5PrRsFBJTnf?=
 =?us-ascii?Q?KXxvo6hZB4TA1HJomnKCytyk6eoIiG/6on1ZfjtPXuRyLqnHQhbIz/7+N3QQ?=
 =?us-ascii?Q?Ess0IvUO0/rzRga364zmutlgG21DlG2icu31JNXQOnUuJcCwWBPOfouUVATP?=
 =?us-ascii?Q?/cDWQ1dulGGBnl+5jtKKJG9VoBhzm6rbPQeKo4NzlEcnt2Chfb7aTVUof5nh?=
 =?us-ascii?Q?Svz+M6yWf/AQe0zZHoiUQhv3aDnIvDAh/jBl4K/NXhksrFNUMzf0RS4NnY2Q?=
 =?us-ascii?Q?9CaseYrOgSvFc+UeHjh6+j9BGzBsPNd9B6ROEzgH6XEhp5twO0RLYC6f6nUQ?=
 =?us-ascii?Q?MJAJZmnuW5juWSDHaQw7Tv9peWX1rIuRWN4bPBEVmfiupetdBN7geiQtTUm0?=
 =?us-ascii?Q?SuPvbPajCm2T0SFsqQCtCc4ZAykai1BSZBh1XSK7BMBj6P13Sp+AhqjF4NuD?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EC5B7290F657749BE07061916097951@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: avP4ZXvRMFIifC3wtVITXM/n2+DUhYlRKjARmvc2bqIXnlAo7BanUGJtxgQ8n0nYtPWvipkeGUodnXId4Sf3PKAmI42RbYxfn9LFic0LrjoM/nq7Lb1TZdPXAQQLLjdf6Mg9+tnNTHJ6LAuQmBkaY6LUv6I8JQ1X4ZuP2/685TrokeG01mzwaWKS8M+XR0gARhvSi2tz2obcAC8cxmiTYEdspr8SJDtJW/jHEA8IGeUNzg3NWQJLpNyUvo7ciuRMgPTmX5vPiusqIoPQU7V1NhUPWovzPsfDRjKuOv18r6gCZ7syrVSfVTxDy+RnTxHhXgv1vEA02MaFaqo2+Hf4o3WoLfSqal23BUCUrFiPWa1vXQlBLNiPcsNaKFYovD6O/USVatXJbUaC+dXO5/NsaukBYHJOV6HdgdvQI42oMByi/+ElNdrm2R4VZ+0wZVU+7wf7cZyAWVZz/7LOK0luMo2K9MCsi6nDzxd1v7HrmihP90LXZhBrEXJdZZD8E+k4UNx7FWCK7KAxIzHrbgMPcYsJqmV5zBWkoPFfmNQpvd8rWYB3PHymKIQbQ/2YEjXh/Sv6I49nJ2Sv2RrMxCi3fNUTXAB6r8IqgIPRkWroYEpJm8CD9TtQ3izHaQ7tG8f+eUjwZf+4njEOJuPgeP6VaXFtbbWxieFLGXIrRlvzAc3UZNIXR5gTxy095e+9M0vgqhGfXZ7RJSrjug8LFao8BewomC5O8C5dS+obGcN1oL5PPtZa5VpcY3Q0hHQOwEBQfE9o5qTsO9dSY9RquxeexEesuxmbSEfeonjKMTbwIkTf+QYMcsD9qtTnwSlb1EX+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc9e99-b512-4aef-86bb-08daa7b5eb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:15:00.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjVSDOZQhpMuIyZtRJyBtfYGYAov6BlZkjxuFp8D7X0NuOzDz32gzzxHLooS0va7Q+5vWaapFs7zdojDIJuEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060094
X-Proofpoint-GUID: Jgo7SZaRagh8nsgKaDF7ZzqV7wz69JXh
X-Proofpoint-ORIG-GUID: Jgo7SZaRagh8nsgKaDF7ZzqV7wz69JXh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 6, 2022, at 12:12 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>=20
> On Wed, 2022-10-05 at 15:11 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 5, 2022, at 10:56 AM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>> fh_match() is expensive to use for hash chains that contain more
>>> than a few objects. With common workloads, I see multiple thousands
>>> of objects stored in file_hashtbl[], which always has only 256
>>> buckets.
>>>=20
>>> Replace it with an rhashtable, which dynamically resizes its bucket
>>> array to keep hash chains short.
>>>=20
>>> This also enables the removal of the use of state_lock to serialize
>>> operations on the new rhashtable.
>>>=20
>>> The result is an improvement in the latency of NFSv4 operations
>>> and the reduction of nfsd CPU utilization due to the cache misses
>>> of walking long hash chains in file_hashtbl.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c |  229 +++++++++++++++++++++++++++++++++++---------=
-------
>>> fs/nfsd/state.h     |    5 -
>>> 2 files changed, 158 insertions(+), 76 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 2b850de288cf..06499b9481a6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -44,7 +44,9 @@
>>> #include <linux/jhash.h>
>>> #include <linux/string_helpers.h>
>>> #include <linux/fsnotify.h>
>>> +#include <linux/rhashtable.h>
>>> #include <linux/nfs_ssc.h>
>>> +
>>> #include "xdr4.h"
>>> #include "xdr4cb.h"
>>> #include "vfs.h"
>>> @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, str=
uct nfs4_lockowner *lowner)
>>> static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>>> void nfsd4_end_grace(struct nfsd_net *nn);
>>> static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_c=
pntf_state *cps);
>>> +static void unhash_nfs4_file(struct nfs4_file *fp);
>>>=20
>>> /* Locking: */
>>>=20
>>> @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *r=
cu)
>>> void
>>> put_nfs4_file(struct nfs4_file *fi)
>>> {
>>> -	might_lock(&state_lock);
>>> -
>>> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
>>> -		hlist_del_rcu(&fi->fi_hash);
>>> -		spin_unlock(&state_lock);
>>> +	if (refcount_dec_and_test(&fi->fi_ref)) {
>>> +		unhash_nfs4_file(fi);
>>> 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>>> 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>>> 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
>>> @@ -695,19 +695,85 @@ static unsigned int ownerstr_hashval(struct xdr_n=
etobj *ownername)
>>> 	return ret & OWNER_HASH_MASK;
>>> }
>>>=20
>>> -/* hash table for nfs4_file */
>>> -#define FILE_HASH_BITS                   8
>>> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>>> +static struct rhashtable nfs4_file_rhashtbl ____cacheline_aligned_in_s=
mp;
>>>=20
>>> -static unsigned int file_hashval(struct svc_fh *fh)
>>> +/*
>>> + * The returned hash value is based solely on the address of an in-cod=
e
>>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>>> + * pointer is concentrated in its middle bits.
>>> + */
>>> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
>>> +{
>>> +	unsigned long ptr =3D (unsigned long)inode;
>>> +	u32 k;
>>> +
>>> +	k =3D ptr >> L1_CACHE_SHIFT;
>>> +	k &=3D 0x00ffffff;
>>> +	return jhash2(&k, 1, seed);
>>> +}
>>> +
>>> +/**
>>> + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
>>> + * @data: key on which to compute the hash value
>>> + * @len: rhash table's key_len parameter (unused)
>>> + * @seed: rhash table's random seed of the day
>>> + *
>>> + * Return value:
>>> + *   Computed 32-bit hash value
>>> + */
>>> +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
>>> {
>>> -	struct inode *inode =3D d_inode(fh->fh_dentry);
>>> +	const struct svc_fh *fhp =3D data;
>>>=20
>>> -	/* XXX: why not (here & in file cache) use inode? */
>>> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
>>> +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
>>> }
>>>=20
>>> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>>> +/**
>>> + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file objec=
t
>>> + * @data: object on which to compute the hash value
>>> + * @len: rhash table's key_len parameter (unused)
>>> + * @seed: rhash table's random seed of the day
>>> + *
>>> + * Return value:
>>> + *   Computed 32-bit hash value
>>> + */
>>> +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
>>> +{
>>> +	const struct nfs4_file *fi =3D data;
>>> +
>>> +	return nfs4_file_inode_hash(fi->fi_inode, seed);
>>> +}
>>> +
>>> +/**
>>> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
>>> + * @arg: search criteria
>>> + * @ptr: cache item to check
>>> + *
>>> + * Return values:
>>> + *   %0 - Item matches search criteria
>>> + *   %1 - Item does not match search criteria
>>> + */
>>> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>>> +			       const void *ptr)
>>> +{
>>> +	const struct svc_fh *fhp =3D arg->key;
>>> +	const struct nfs4_file *fi =3D ptr;
>>> +
>>> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
>>> +}
>>> +
>>> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
>>> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
>>> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
>>> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rhash),
>>> +	.hashfn			=3D nfs4_file_key_hashfn,
>>> +	.obj_hashfn		=3D nfs4_file_obj_hashfn,
>>> +	.obj_cmpfn		=3D nfs4_file_obj_cmpfn,
>>> +
>>> +	/* Reduce resizing churn on light workloads */
>>> +	.min_size		=3D 512,		/* buckets */
>>> +	.automatic_shrinking	=3D true,
>>> +};
>>>=20
>>> /*
>>> * Check if courtesy clients have conflicting access and resolve it if p=
ossible
>>> @@ -4251,11 +4317,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
>>> }
>>>=20
>>> /* OPEN Share state helper functions */
>>> -static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
>>> -				struct nfs4_file *fp)
>>> +static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *=
fp)
>>> {
>>> -	lockdep_assert_held(&state_lock);
>>> -
>>> 	refcount_set(&fp->fi_ref, 1);
>>> 	spin_lock_init(&fp->fi_lock);
>>> 	INIT_LIST_HEAD(&fp->fi_stateids);
>>> @@ -4273,7 +4336,6 @@ static void nfsd4_init_file(struct svc_fh *fh, un=
signed int hashval,
>>> 	INIT_LIST_HEAD(&fp->fi_lo_states);
>>> 	atomic_set(&fp->fi_lo_recalls, 0);
>>> #endif
>>> -	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
>>> }
>>>=20
>>> void
>>> @@ -4626,71 +4688,84 @@ move_to_close_lru(struct nfs4_ol_stateid *s, st=
ruct net *net)
>>> 		nfs4_put_stid(&last->st_stid);
>>> }
>>>=20
>>> -/* search file_hashtbl[] for file */
>>> -static struct nfs4_file *
>>> -find_file_locked(struct svc_fh *fh, unsigned int hashval)
>>> +static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
>>> {
>>> -	struct nfs4_file *fp;
>>> +	struct nfs4_file *fi;
>>>=20
>>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>>> -				lockdep_is_held(&state_lock)) {
>>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>>> -				return fp;
>>> -		}
>>> -	}
>>> -	return NULL;
>>> +	rcu_read_lock();
>>> +	fi =3D rhashtable_lookup(&nfs4_file_rhashtbl, fhp,
>>> +			       nfs4_file_rhash_params);
>>> +	if (fi)
>>> +		if (!refcount_inc_not_zero(&fi->fi_ref))
>>> +			fi =3D NULL;
>>> +	rcu_read_unlock();
>>> +	return fi;
>>> }
>>>=20
>>> -static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc=
_fh *fh,
>>> -				     unsigned int hashval)
>>> +static void check_nfs4_file_aliases_locked(struct nfs4_file *new,
>>> +					   const struct svc_fh *fhp)
>>> {
>>> -	struct nfs4_file *fp;
>>> -	struct nfs4_file *ret =3D NULL;
>>> -	bool alias_found =3D false;
>>> +	struct rhashtable *ht =3D &nfs4_file_rhashtbl;
>>> +	struct rhash_lock_head __rcu *const *bkt;
>>> +	struct rhashtable_compare_arg arg =3D {
>>> +		.ht	=3D ht,
>>> +		.key	=3D fhp,
>>> +	};
>>> +	struct bucket_table *tbl;
>>> +	struct rhash_head *he;
>>> +	unsigned int hash;
>>>=20
>>> -	spin_lock(&state_lock);
>>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>>> -				 lockdep_is_held(&state_lock)) {
>>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>>> -				ret =3D fp;
>>> -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
>>> -			fp->fi_aliased =3D alias_found =3D true;
>>> -	}
>>> -	if (likely(ret =3D=3D NULL)) {
>>> -		nfsd4_init_file(fh, hashval, new);
>>> -		new->fi_aliased =3D alias_found;
>>> -		ret =3D new;
>>> +	/*
>>> +	 * rhashtable guarantees small buckets, thus this loop stays
>>> +	 * efficient.
>>> +	 */
>>> +	rcu_read_lock();
>>> +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
>>> +	hash =3D rht_key_hashfn(ht, tbl, fhp, nfs4_file_rhash_params);
>>> +	bkt =3D rht_bucket(tbl, hash);
>>> +	rht_for_each_rcu_from(he, rht_ptr_rcu(bkt), tbl, hash) {
>>> +		struct nfs4_file *fi;
>>> +
>>> +		fi =3D rht_obj(ht, he);
>>> +		if (nfs4_file_obj_cmpfn(&arg, fi) =3D=3D 0)
>>> +			continue;
>>> +		if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode) {
>>> +			fi->fi_aliased =3D true;
>>> +			new->fi_aliased =3D true;
>>> +		}
>>> 	}
>>> -	spin_unlock(&state_lock);
>>> -	return ret;
>>> +	rcu_read_unlock();
>>> }
>>>=20
>>> -static struct nfs4_file * find_file(struct svc_fh *fh)
>>> +static noinline struct nfs4_file *
>>> +find_or_hash_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp=
)
>>> {
>>> -	struct nfs4_file *fp;
>>> -	unsigned int hashval =3D file_hashval(fh);
>>> +	struct nfs4_file *fi;
>>>=20
>>> -	rcu_read_lock();
>>> -	fp =3D find_file_locked(fh, hashval);
>>> -	rcu_read_unlock();
>>> -	return fp;
>>> -}
>>> +	init_nfs4_file(fhp, new);
>>>=20
>>> -static struct nfs4_file *
>>> -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
>>> -{
>>> -	struct nfs4_file *fp;
>>> -	unsigned int hashval =3D file_hashval(fh);
>>> +	fi =3D rhashtable_lookup_get_insert_key(&nfs4_file_rhashtbl,
>>> +					      fhp, &new->fi_rhash,
>>> +					      nfs4_file_rhash_params);
>>> +	if (!fi) {
>>> +		fi =3D new;
>>> +		goto check_aliases;
>>> +	}
>>> +	if (IS_ERR(fi))		/* or BUG? */
>>> +		return NULL;
>>> +	if (!refcount_inc_not_zero(&fi->fi_ref))
>>> +		fi =3D new;
>>=20
>> Ah, hrm. Given what we just had to do to nfsd_file_do_acquire(),
>> maybe this needs the same fix to hang onto the RCU read lock
>> while dicking with the nfs4_file object's reference count?
>>=20
>>=20
>=20
> Yes. Probably we should just merge this patch if you want a fix for
> mainline:
>=20
>    nfsd: rework hashtable handling in nfsd_do_file_acquire

It's queued up. I intend to submit it before leaving for Westford.

As for the file_hashtbl, I have fixed that up to be consistent
with the approach in nfsd_file_do_acquire(), and will post a
refresh in a moment.


>>> -	rcu_read_lock();
>>> -	fp =3D find_file_locked(fh, hashval);
>>> -	rcu_read_unlock();
>>> -	if (fp)
>>> -		return fp;
>>> +check_aliases:
>>> +	check_nfs4_file_aliases_locked(fi, fhp);
>>> +
>>> +	return fi;
>>> +}
>>>=20
>>> -	return insert_file(new, fh, hashval);
>>> +static void unhash_nfs4_file(struct nfs4_file *fi)
>>> +{
>>> +	rhashtable_remove_fast(&nfs4_file_rhashtbl, &fi->fi_rhash,
>>> +			       nfs4_file_rhash_params);
>>> }
>>>=20
>>> /*
>>> @@ -4703,9 +4778,10 @@ nfs4_share_conflict(struct svc_fh *current_fh, u=
nsigned int deny_type)
>>> 	struct nfs4_file *fp;
>>> 	__be32 ret =3D nfs_ok;
>>>=20
>>> -	fp =3D find_file(current_fh);
>>> +	fp =3D find_nfs4_file(current_fh);
>>> 	if (!fp)
>>> 		return ret;
>>> +
>>> 	/* Check for conflicting share reservations */
>>> 	spin_lock(&fp->fi_lock);
>>> 	if (fp->fi_share_deny & deny_type)
>>> @@ -5548,7 +5624,9 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struc=
t svc_fh *current_fh, struct nf
>>> 	 * and check for delegations in the process of being recalled.
>>> 	 * If not found, create the nfs4_file struct
>>> 	 */
>>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>>> +	fp =3D find_or_hash_nfs4_file(open->op_file, current_fh);
>>> +	if (unlikely(!fp))
>>> +		return nfserr_jukebox;
>>> 	if (fp !=3D open->op_file) {
>>> 		status =3D nfs4_check_deleg(cl, open, &dp);
>>> 		if (status)
>>> @@ -7905,10 +7983,16 @@ nfs4_state_start(void)
>>> {
>>> 	int ret;
>>>=20
>>> -	ret =3D nfsd4_create_callback_queue();
>>> +	ret =3D rhashtable_init(&nfs4_file_rhashtbl, &nfs4_file_rhash_params)=
;
>>> 	if (ret)
>>> 		return ret;
>>>=20
>>> +	ret =3D nfsd4_create_callback_queue();
>>> +	if (ret) {
>>> +		rhashtable_destroy(&nfs4_file_rhashtbl);
>>> +		return ret;
>>> +	}
>>> +
>>> 	set_max_delegations();
>>> 	return 0;
>>> }
>>> @@ -7939,6 +8023,7 @@ nfs4_state_shutdown_net(struct net *net)
>>>=20
>>> 	nfsd4_client_tracking_exit(net);
>>> 	nfs4_state_destroy_net(net);
>>> +	rhashtable_destroy(&nfs4_file_rhashtbl);
>>> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>> 	nfsd4_ssc_shutdown_umount(nn);
>>> #endif
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index ae596dbf8667..879f085bc39e 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
>>> * inode can have multiple filehandles associated with it, so there is
>>> * (potentially) a many to one relationship between this struct and stru=
ct
>>> * inode.
>>> - *
>>> - * These are hashed by filehandle in the file_hashtbl, which is protec=
ted by
>>> - * the global state_lock spinlock.
>>> */
>>> struct nfs4_file {
>>> 	refcount_t		fi_ref;
>>> 	struct inode *		fi_inode;
>>> 	bool			fi_aliased;
>>> 	spinlock_t		fi_lock;
>>> -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
>>> +	struct rhash_head	fi_rhash;
>>> 	struct list_head        fi_stateids;
>>> 	union {
>>> 		struct list_head	fi_delegations;
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>

--
Chuck Lever



