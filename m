Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F16F6F3C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEDPkc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDPka (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 11:40:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D3131
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 08:40:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DiRZa003750;
        Thu, 4 May 2023 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+RaspgR/dkOMxEyxtrqieYZ447VVXPiMymx4iOUjCWg=;
 b=FUaL2DNk8H2/q97jPNIIUv57VwvD+33e7tHKmaT4WqvK4nYqTFwL9xy5wTxeLIO+K01G
 9POfj5k4uhEh3We5VqN63WzGJrvRS16wIuSa61I4ZbklIAHZmdXCPEpYn54gpTvMkMBF
 ecUluQxs2YPBVpdPc1Xg2FylwFl0cJM2R6Iwv8K/2C/+l4AHFG3LnAGGTc0J9mU7QiEP
 faxU9su/vip+tlgDa8YkS8ObzQaWgbkZygcLWvZd4+/nPs+xWNWt3X4/Jh7gZjYTtm/g
 YLmn/retGk08rJu9M5wqs80mc2zt2DDER11ANa61a2ClrfHbelIz2Pc4vE+rId57Htk+ qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1t6n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 15:40:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344FNfwo040516;
        Thu, 4 May 2023 15:40:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8q152-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 15:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Qn1IMSfDMMCRn/cExsUyaBRcFGBhz76cPAQhJeDCZtU1hkCaD5kHVDUJ4yV+CsAowVIMRnz5IYH/g5oQwCW2Czdg/pwPArOltsUwqMMFKxqH4/3os8tDRBwDPchgZxtCROz/CqBbTRGLFpgu6L2kROCcQ0oRt22UZ4IcVIhJeMcUVP2BvbrcsK4rjFOyMJCN2KX5NjwCeagsV3to94nTJ2nhKfNP69V/Lht8hnOel03aXyIW4CwiwSEh49Ev58/QVnX50l6k4+Q2VSyAe/82HdT5AoKP5dbVQCYijlGjZDTcOWuUGVuml3PbsnCf67jfhTRA5krFN+nzGB+uaz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RaspgR/dkOMxEyxtrqieYZ447VVXPiMymx4iOUjCWg=;
 b=oS3LjUxQWC8h3VW2qRO4Jiz6hF5YNAldzAY607nidt/t1AI7yyp+N7u44jmbzN98Jckm+ivCO2u6eSHP8tnooEZ7Hek/MM0iAun9NVRlN2g99Cjg6egex4eRS63RCkFpyuFFk7gD/FFrOXue9v2twfZuNnp2/K1+oKADrdDsWF3VhUguLfAEiDjh0d8Ou+IQ7qweXXmtY0zalMmLTM19ENtIwbnTHxTT1XRQhGeuRQnLcL0qE/gSNd8HtpowUEIf4P7B9pLg0ECJin+7orLNWmptMhKT4okYjtFj2gKsQUw2sat6zPjsAGrhhjyO0hSFedqaLy3V5YK+XvBI5oK1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RaspgR/dkOMxEyxtrqieYZ447VVXPiMymx4iOUjCWg=;
 b=PpdoOiPTMho52m3uTEo6ugHSW80K4SWAcEg7ckrXg9zMNHnkFq0Gr8WvpNYxYt4BKq7veQkAO7vc14qMFIz5TNGg+kR4GdbSiXW/MabPFtrqObev6tKRFTuG/dUorg40bYJSQtjRd5csagZijuMQHVM+PFgQlppqve3WCl3G/hQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4122.namprd10.prod.outlook.com (2603:10b6:5:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 15:40:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 15:40:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] net: avoid double iput when sock_alloc_file fails
Thread-Topic: [PATCH] net: avoid double iput when sock_alloc_file fails
Thread-Index: AQHZfbLSlzKle740mUCBeF98PrPl7q9KQf+A
Date:   Thu, 4 May 2023 15:40:15 +0000
Message-ID: <53A81159-DD6C-4A5E-994F-49A536F7BD31@oracle.com>
References: <20230307173707.468744-1-cascardo@canonical.com>
 <95e36d70-7841-4e7d-960a-116b8595b820@kili.mountain>
In-Reply-To: <95e36d70-7841-4e7d-960a-116b8595b820@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4122:EE_
x-ms-office365-filtering-correlation-id: f2fef3d9-f1e2-4e77-3de0-08db4cb5db5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjcO8NDDSUoaQ7BoBD6TdvJwaj7ihb7YIy0KBJJf855YqfH4kH/onZiFCupmyw+ECU7hRQMPYVCp3QBysQ0kLQXWOxTlWjowrJNKFYmTSVUDhEcPZKmVKdi7KPSt8EsC/fu37JBzd8CCb6wydakpl3PqZXcOHkWwR8gVH47DLoximYl0mu5EJmf7wuXnHe0Yn24cZQD0Uy3vG86TR3nHjVUiZ9bwh56r71s/+K8g0os8dzhZv9Oj2FvhpJ6N/0Jwjyy+9TJxygOobMEWs3lxAfk2l84qMwgR8OJ2HwkhOLs7SgkmuuKpyhFP8x5rKNOl3Hu09bogIOqsp2jIaDrgkpq3CkshQAYY338SX2b54JmaUfz0Cley+I6vwh+72/oCu6lcn4hBFbhkIxeeaoKne1qB8q/XR09e5o/3+XwDpT3OwRhZPXZRlpltL/ZzxgklQqFXl9JJ/XwpI01hpLWKzlRSYGXhEtpjM4n/l700BDaRZQ1EDQXA6i8ZOcUExahA0yFAMrYDuY4/x6YjMjCP2Tvp0DG/DQCiiSaN7ooHathV7mW1DqhxT9cIfqutqs46Njz9M/JKLsib6ZDVyWE9CjQhkRLMCG7xSoVaV08miIRAqIRZVJRW6rc5dpdaQOnitlSZIYRKxlg3Ns6AigswsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(316002)(66476007)(33656002)(2906002)(186003)(53546011)(41300700001)(6512007)(26005)(86362001)(2616005)(54906003)(6916009)(6486002)(64756008)(91956017)(66446008)(6506007)(4326008)(66556008)(66946007)(36756003)(76116006)(71200400001)(38070700005)(478600001)(38100700002)(8676002)(8936002)(5660300002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sNEty3zSZHFdqjTxYLE5U6smv6EzPvdN58a+jFdQWZnWdMw5UG1V506LSKiH?=
 =?us-ascii?Q?9ZZIPs1sV3hGgNwI2tcKRkV61soYih24mEdTiWCgfXzU5ia12PDSVuvsbMrD?=
 =?us-ascii?Q?zM1StkGigva+7nUWl7JUJXryXDgQiHIw3kexx2Dn1w7HbInDXBQvNa/q6pxd?=
 =?us-ascii?Q?wrNo/GI5F5GN5oMEhk+LshfvAqphi3/tKaPLoAkX4rsOV6S1yOOdr4c+kv5C?=
 =?us-ascii?Q?6rw+s39JEWClo+/FA7mZXxBrew8F8X5q2ZFoVcadvvGlyGfSCFtOrlthIM0G?=
 =?us-ascii?Q?2vQ5LhrKyq60UTglKhrBA2d9F7GDbyfcLNznIbhvjkVOK349hADS2n0jEcOy?=
 =?us-ascii?Q?ciD/PM0SWU5li0XhXSXTVa6rZB+f0s9Jb+A51ryS6MAsGRmPG+xbSqQQVnVG?=
 =?us-ascii?Q?A15RRBZyFosnt7nJX6VpGQbfnhnF4AioWLrgt7zToS2S0VCdr5FxcX4VaKhs?=
 =?us-ascii?Q?hFc8l21bU0hda12GO5VG7x5Ke0rFZHED8PyL2SNCMzbGwnxqDHInsmdAn1wC?=
 =?us-ascii?Q?zYOSusPOJQ6cePm/IXdrz2P95Io1p+JONzqouov/1peeWIhyVDpCTMVDCUQX?=
 =?us-ascii?Q?R0rWqP6UdkQnrgRC5c3B4l4wnpAqrgSqKdIm279aMZiC6uQga8V6/JC87NaK?=
 =?us-ascii?Q?ke2qYZXPkvq8zKZM0D3RognRE3O6IlLqToBWJc4024nNEYw6qCuYuvHZu15Q?=
 =?us-ascii?Q?BCKPltsBDjJ95Gu1/Ef2GAJhi7UXngVd4dYxmyk1VBVoo6f6bbJVqWg+7fY2?=
 =?us-ascii?Q?ftJWIXth0WJiCJaItoWMnpTCbMd5Aw1GLZeVzWgylFYhqUTYJTQ0cf4qDljg?=
 =?us-ascii?Q?SL9Fzn0OjwVgpNK54jYHajQh4JPIE3B1LmBc30zuoEK8sUW6sP2Lfq56Pohc?=
 =?us-ascii?Q?AVTl5msCpoz9DVeOsGLvh4jDyz/G/l7j6mcRqmbmtw7E1HEnA5IrHbEkHkQQ?=
 =?us-ascii?Q?eMk1y0lTnr7uIsS82VMFQHcvUCbRE3NLcLLa+1Uo46fMDIuz0eGXYLEjr9bM?=
 =?us-ascii?Q?gF2Ja2l7dF6411ehGxMq8v0qbjfPv2DC7sdlaWHnJN0bitJ3VfH2c024T/8M?=
 =?us-ascii?Q?CDAFcxCp+v9CT2/yHM3fIt31iRpdZV+ryLCzr+IqTazjzQRb//XBK0KlxqA9?=
 =?us-ascii?Q?60R8SuPZYIGtntZqDE/eWB713MEPeCo/uSfftxeNxZF8f4oPVoQGIUN7XwbO?=
 =?us-ascii?Q?PhL7N9qMmu+XwcvS/wDan0OrsQ2T8iruvYT2s0p2SeZa7ZDxkNEjKpjC+eQS?=
 =?us-ascii?Q?crwodstTCbldMiHusHmL/a22z3emURsnY0kXCAlvaHC7d7f5js84q9lUOVlC?=
 =?us-ascii?Q?9iYwbuGXaHtq80UpQ74+vcHQMgvhnhTtMMHts6U+1HDaA6BjfVK0Y7YyIo7B?=
 =?us-ascii?Q?jNeJfmob7JUZbsFr/IyZnHvGzQjsq54f+bvdQW2wwMzfGVUHZNvZShb1tqef?=
 =?us-ascii?Q?DnmMeezYit+GX8tESck1lyuf06fAqWI1eZGT/JDQfNPDItEZUYD5ncZjF4SS?=
 =?us-ascii?Q?/H5oJFS4woUCwhAftcbDQUE93Js2DLGRB1gISclLdz91vp7JgnmN6KQBNN2q?=
 =?us-ascii?Q?5SE5F9k2fZo1vCUNWlP6TgGV+x+eg0oX7qFzAM6lcpcp9doCfo84BdQslp7w?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6282723E0B15E4D83F1C9456B6220D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zqbB+DBNs1nB1Va2V/3pDae9+xpNK/Pq288CmjMJGgVVOdXcaXPxJyJAIW0z5RkWeqXopmuTyb6ZH2M7T8ZKhBsnkBTSpnkBFxN6eDa68sQOAIlaUN8fWFGLPWznETjZrQ3jUkIe31E5anbZiLZ4bP1+RY3g97un/uQazj7WVRqqItdoOI6EGfI5bmrCHw2Ue7f/e/D2mI9PDZnTjXpYxgoBSIDp6tokewpfcasoQWJGx8KQBisjrVCwSchUdF9VjgoE69fGr8udyVmr+bF5GFOxjpYcyyIczWBra01Wm4ZnqTCE0Mt3Ln6IN4MOz5FB1hmrdNYw1ajEijTrq5LuPfCijUsnW8dxloqgUP5ZXzWMqSmsVSBnbbFmYr4BNJpOD69jIyAqd1XO9anxbWiNCJ9X6OZQy8ZQLpHhRay7UVY++lN9EbiEbjglw5s5ztCh5m4JFtYbDxpdAHJ1H0exbYX/WeopQazkN6qAR8S0D2/ebWQzOWLOSL19AJ7DsWQmclxv8jNzIq52wxfPpXhnJC5j9le/HnRbTFfP+N5qtY0btK2aNAiegk+S/JJxrZKBVh86VGX9V58wnly70b6N4I+tIWaTEBAYW3W9BS0F+wiQ14N6GWvA7Ua3DpgKXTKghVQGXQJSTRPnfi1FHDeFAQygcmFXfbWxssyjEiKzwoUq3H1zTt+DQFmqqgyKFYlokBIZY12vS60E0YqQfPsRZ1o+U+ImS7ZDu3RUZ7rbxWS8eSQc7Xloo1PANfdfqRMFZJbo6mR2hupHZclAS5WDa8cNpqeaGeHx5SuP9RS3yRlI4ZtK7aTk7AAJ3hpfztOU1xHvHOMjjRVS+SSrd0N2PiXRBgU7Z0lwlbLH/Z27VUxz9Vd5NfKSb6zHqfkFHCdaHGK9Zud6duk9IvETWlcotQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fef3d9-f1e2-4e77-3de0-08db4cb5db5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 15:40:15.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYcUgfwcfRrgIiQ9AEYvRqbcrTanEnk4U2M73kJ1wOh4nJSDFSSq41hwg4f4xiS63Ilh8F2QUMP/wIZNTrcAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=953
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040128
X-Proofpoint-GUID: qklbZ2Ay6_KKfaNZ1JuTEMk3tmXbgPJB
X-Proofpoint-ORIG-GUID: qklbZ2Ay6_KKfaNZ1JuTEMk3tmXbgPJB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 3, 2023, at 7:31 AM, Dan Carpenter <dan.carpenter@linaro.org> wrot=
e:
>=20
> I changed the CC list from netdev to linux-nfs.
>=20
> On Tue, Mar 07, 2023 at 02:37:07PM -0300, Thadeu Lima de Souza Cascardo w=
rote:
>> When sock_alloc_file fails to allocate a file, it will call sock_release=
.
>> __sys_socket_file should then not call sock_release again, otherwise the=
re
>> will be a double free.
>>=20
>=20
> It's just a one liner to make Smatch warn about these sorts of user
> after free bugs.
>=20
> { "sock_release", PARAM_FREED, 0, "$" },
>=20
> Smatch found a related bug in nfs.
>=20
> net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: 'newsock' was already fre=
ed.
> net/sunrpc/svcsock.c:1633 svc_create_socket() warn: 'sock' was already fr=
eed.
> net/sunrpc/svcsock.c:1555 svc_addsock() error: dereferencing freed memory=
 'so'
> net/sunrpc/svcsock.c:1633 svc_create_socket() warn: passing freed memory =
'sock'
> net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: passing freed memory 'new=
sock'
>=20
> I guess the svc_setup_socket() function should free sock on every error
> path?  It seems kind of gnarly.

I'm looking at current upstream, and I don't see svc_setup_socket()
releasing @sock on any return path. What am I missing?

Does your tree have "SUNRPC: Ensure server-side sockets have a sock->file" =
?


--
Chuck Lever


