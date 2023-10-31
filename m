Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7B7DD73A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 21:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJaUnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 16:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJaUnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 16:43:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8CF5
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 13:43:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKX1TK004799;
        Tue, 31 Oct 2023 20:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1M4APbAYDC33YghRb7EvRjPBjS5e9Kkf+obh9106gg0=;
 b=XqthOCiOuEObsFhB70R7Vkr2xuI7rpQkdtMPg6OFV/388T+X95qPXSV7yFZmtzQR+hhb
 AoaETiNEYfDHS7CTkuq7a8XP25Om7VEZMhW71NVE7evH88zTEVj9TyzHdgk2Kd+u2xPP
 o/usQ/eglnbnBKYNMeEwoHWkQHDes1av0r6sCh8/aiqtz2OGYfdXamdBSz+p42xiE/Uw
 OKLN/dG0WRXo1HLVnZBm3BSVj5Iz2D4q6/AGtRY6lrfUdpoaFrhrGFh4tPp76ULulf+N
 PLcyzcuG6SyJjWL76r40sy9pHsWnwcM+fWu3W12cPuwyyJ//du02bjtNp6uPm91GYuPD eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdp4yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 20:42:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJ93h3022568;
        Tue, 31 Oct 2023 20:42:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr67w38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 20:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaeQgO7m3uvEkfl+YWvs2JDvvI4yFJfxIco1eMf6p3FxYT73SIu4yDcNiGZExL/aAm0TcqT130qcV6Rzied9YXANxUDXGr1qHou7IfWozBhHIdqq1nza4G+YFHN5gLq+Ld/XMWRahjtRQCHENywDI/mSw8gbfqCPGoHyoalB61xe5mklw5LDaw7WaQbwpSfMNoO7H+t/uP10TFFEsnFL5twW6Xn/L+LlY0F7cWGPEET271jGiuOzRA74jfTgumRdMUcGRzYnA4r23hMcd/z1F/25fw5xzvHCjMmOc9qavZ85Kovx2QExit99Uq7zwfBQw0rdk/+2lItANoLAImc9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M4APbAYDC33YghRb7EvRjPBjS5e9Kkf+obh9106gg0=;
 b=X1qDgGM38LHBX67weDzVL8zf5PNYMiDwataNSttCAmd/Az0Y714XQwt1Y81m5+I+S1s1LNNZAFOE/UDKfgidQiPx/MaPnJz1kklQbQ4uhBn6D7zRKP3lnqHJU06vNU4bQYoCYYP54kRRM7sCl6DN44MW8yi+t0ZUrMfmb/wYZ69gT6l4G7wKtbBZ1DuNQUrZjsIsO+ZWgbFqCpCOiOn7lYznT6qlWCVVtXtQisx/Yq/bY7UzOdXuiBe1WSRLau2qjUWXISPEW8VYs4T+bEKE0wefJHSF5CjO5zBVa7CZm4bN5HBqfXuLCAth4x5h9Pva/pGxCe3/ouWns/2CcdMC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M4APbAYDC33YghRb7EvRjPBjS5e9Kkf+obh9106gg0=;
 b=GVUI2mknsNIEw5oGofZyDrJeApCDX96AN1pWLQ8NpJWmEEVl4sbp2CrXX9Xx+3k5bmzJka192VSiYts5tQUiqxjhbyClOx7rOL4VBwQNNNCuglkfOMtiuJfrnMWFBwXp3tWIhmeS4AYamZH7V9X0f9Uw2/PybHu7PmTITPpPvw0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5340.namprd10.prod.outlook.com (2603:10b6:610:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 20:42:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 20:42:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Topic: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Index: AQHaCs5Bx30Sst3AQkeWzWCFyIpqgLBkCzaAgABUNQCAAACLgA==
Date:   Tue, 31 Oct 2023 20:42:50 +0000
Message-ID: <C869423C-B578-4D5D-B171-444EDF2D0D02@oracle.com>
References: <20231030011247.9794-1-neilb@suse.de>
 <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>
 <169878484259.24305.17786556797570881562@noble.neil.brown.name>
In-Reply-To: <169878484259.24305.17786556797570881562@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5340:EE_
x-ms-office365-filtering-correlation-id: 6e2836e9-488f-4dbf-ee16-08dbda51f31a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+BvSf0bUNdbnzLdgne7IlooquGyhgSULMZeILp71GlgTMLG7sRbuyivn4oJKUxZq28CYfymHB5p8cLYi7+nnsWYMXG75pyWU1nttZmr+nh1JvkkLbAYZioyVjJnaR7dLMPtLvLakC4dqg2CvU0lJuR1I9J0rAcMmCM3o84S7ORb3lqePR5IutLgTsFwhx4+fTX+ZhZia9Muhvrbnj/QkFH5oPOGYk2GH7/wU7gZkXnJ168sssYMyWYGAvY+lJ+++asrVoiXWEl5WvUZEMO4BCFbgq4zbj6e1/rsHIPiBRADZfFNvMRmPRUhNFAAJ0IL9SXYt2du/JBKhvWolGID5SLNtNA4Z6+MX3ScO+ZiQWpf6AWJWUcV4G0dwAeQr5Gy6cxiA6RLLlCMjld76vqwGJaulRRAYI9CCIjlT0QQqhGBGb7rtERm1so8+3Fp/I1caw4aJiqoM/mHIt8ZVJTyfjPIUmYor6GL1dKe+JkBbN7oWA3F7csTKd8wN+Jg+lZitk/rY+lhnZNT7Qf5eoe6KgI3Poiu2bikA/TEI+F3QzXNs/3Mfr+TYdeLKiPK0LcLA2PhCJrDbjICPdw5Nmd5jErQS/X33am5P2hxsZjZ6laZ5OIbJdg1GKRU1JxCXABEKw1reWNl5Ps8rY7Pnr+zjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(26005)(2616005)(38100700002)(54906003)(66556008)(76116006)(71200400001)(4326008)(66476007)(64756008)(66446008)(316002)(6916009)(91956017)(5660300002)(66946007)(8936002)(8676002)(53546011)(6506007)(2906002)(6512007)(6486002)(478600001)(41300700001)(122000001)(33656002)(86362001)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k+k47Ou4JyIIbGCS4fVMdcuWmSqUIQUn1b71eheO7ceNzSIFKG/QPn3NrPny?=
 =?us-ascii?Q?xxfkQPiv672B04T78sSftySNcRCT7ANZStmHiZooN2EM25GoDOpz7n9j8YiF?=
 =?us-ascii?Q?K890plBK1MCAkqOGnAm69jUW50TVSZLp49ItqOwF3pwEQLnExmcqE1sPVIQd?=
 =?us-ascii?Q?zgcFtTk994yu28a21NR2h1inHTXyADUOs5HOCEe6USi7tK3yPjEETRkqmizA?=
 =?us-ascii?Q?lIqlpu2L1vFNGHlf5WgEgLZsrqFGYcbFLaOkbR42xeCjnyzs0hYBDIk+WbZ3?=
 =?us-ascii?Q?IUIFgmx+FHUJ9MVk7Dqwx1TVWDYoJ/2lTLkGg8jFzSfsLMEvH8ECGLozLnQr?=
 =?us-ascii?Q?NwgrR6ai7DYTMScQbLbLE0jbBWEcS91tIC5OIIwRTt8hAl1fE8X9HSH4+iBv?=
 =?us-ascii?Q?+flmZwNweNPEVxKhiCgG1uJnC1ioXSr9MWJN43NLwF4LQ0IurA5ZUQVzYb8x?=
 =?us-ascii?Q?HH0FE3P7dyr0giXshFYZUjwYXjIgwV8DVlONFbcsSPkSlPHtrGSvxTfIW9/l?=
 =?us-ascii?Q?AEQHff9ZIsMhrSALlSGBVO4RO+RmCIsIzbyHuz3xfA0/Xn+8g9mIt2t34Luj?=
 =?us-ascii?Q?jt7+i3/FMZYvsTS5qU+02NsZSFQFnlg7a8EzBmT0AR6nd59PHyOZKwH8XSAF?=
 =?us-ascii?Q?nkHLDRqw91gruoLxPLT0VMt3AarOMzcMXgYLJ4teP/0j5NhsmtNK92UwVO13?=
 =?us-ascii?Q?ZexyPVBjja2Sc3MA1wdKY8EaOeg16GZUdxigyXtQnjhuC4/xvjg6wDX94v0l?=
 =?us-ascii?Q?X+1BookT83Iu2SWN5/lgws+4EBkWsoZXRasNm2xuP+Py7/rbIH39madYcto7?=
 =?us-ascii?Q?zQ6fKU8s8M+h4HieQCLJTmYrirjnQOJuKkgq+dJ3N4XaCZzjErh/fTSCEv5E?=
 =?us-ascii?Q?dlMynrgQ9I0HoJe2eDx341MxKsNT3qih9qvz90jqXh3PK3CQ7zYP9dm/0asD?=
 =?us-ascii?Q?4J++3YYW5jfguKBJBEf8RJhLdKtnW9YxMEzEDbcFitxuCnbAuLWHeByzzHKt?=
 =?us-ascii?Q?hTOOixOdIdzKb7y8+ngn8/uP73qYX0+k4sJkzQSPRF7eTy4hc0rriKdaSfkq?=
 =?us-ascii?Q?hh38v8ymf+FAFamf1KY8d2ZaleyGd5mumcpQX59j8klioEnyhU9IoGI6YZ/r?=
 =?us-ascii?Q?H0oCLmc7uD/xRA+iNSGGjN4jQkpUvGVdUleGGVn1un4CspdyU7o22S3QFsHe?=
 =?us-ascii?Q?WXMlGc75DVXz45svCxa5TrWhZxo/yTAcfp+rspfckd+VQpIC8MSAYLRKBK+a?=
 =?us-ascii?Q?HPJ/hJJKMJ0n8RlVIGbGhxAC52edSuS4zCiVvOBfAvax6sNu7MMUHqiFj26L?=
 =?us-ascii?Q?m/19y4QTb3W1xS54TCUAgymiMwsA8ASvPGlmB/haGpFEFzATXNQ36D1dQQm1?=
 =?us-ascii?Q?gT8NjQo268ht7AvrBmwAZg/WoVPrt9d4R4tzpmo8Ah5L5UNyw4yrBnRRTeDw?=
 =?us-ascii?Q?cM92MTGJIyzN9ZDXZBlNRpPAocF8rH7T4EeuPUdrykDaHrwn99NFffBjKlfM?=
 =?us-ascii?Q?YhUt/uTql1lONvBkhJyrYZEYbAA0lg/bW0UyHDCFl8JBncqdSpLHrfz1WMIy?=
 =?us-ascii?Q?kIiw58aF6ZObyt0GFYKWfTI4xMJcmvE230+rrvvtYSC8a4qfD6658SiO1Q8s?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E7D2DA798E27C4D9D331C6A2EE27C8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +YuIKgSEeTHT+V1UFNOeLwyki0hB5iyiK/DoHvarcLMITv7503qw9P9Ww3zJJUPzhuX4fhp8RjWbZs0McqLPSQrBRSheUYsUyeJDHeshwJBC+SSd7fsuvBRsjl5/g3DkDcgCpAA3DyQTEKm1i4jYtzLYl5DeGFDp0ACI2B7M3SnJIQo0V0wOj4t1BFjc8lZ0lW673jYe6jPW4YKeoKOkCmXbIMrPjfyTp+veNyFRiUu7XjLyxNV7TiAPCzMVH+nkP5H3+++yakk+qqwLExxax5Vxf3gcko+hUUJ5jqWLHFBvRM5z793OslLbYIfku1MiEMqRncgpGLM31X2JpByqdVNzThLSa9aJJoiTlndt3ki9w92eKPRs9kuUMyKzH5vbd3X2bnsccUzmEunEbLI+CBCh+lr2PZdnS/L9EbkEV13s5ZEaZAr2qZKCH0a5vBUR49EqL+ouCBX3euE+l9bfMoXUL3rDKB4tXgTNlXhgzOKasUHxZio1eBmOFOu9X59fmUoUb/tEn5pGBNfxkL7RwWW144pik+NefTNH/95R7xUm5eBWJWlCfQNzz6SkzS5IcW+ln4l4Lpdo91HRK2g2noVc06mUD/glmZqPEzNPbu+kyVsNgFZDYesh3/zC0wmvWSgib4xWtwTCFDEOpzgYwW0zsV5nsXjv4pgn97jOZ+ILfrZQT3iLuojCUZIf/jobeH5VezvsJfohmNazo8Lu841m0skHHXMASyL+IgA/+E28lrL9oeHgMhwtgeunocJjceIYsl1gMKWWLjpEzbUEqzGXBYx9bG89JCVVgvBHUE5A9NnMhqRCnWT1jQB04ckfSeHuLgC8a37HmO+VRWL9LP8s2LcLPCMmzxwiTYv8fp+OIdgD7YSNKy6Q+E5+lSwq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2836e9-488f-4dbf-ee16-08dbda51f31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 20:42:50.8824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRNj0AxAu4cByBrJYj4JivR0ROguJpXVqWOXLZSObJW9SIo7J+fCuQLESqj+7hRs3k9hAZIydv7ZolyWnRF9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_07,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=850 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310169
X-Proofpoint-GUID: MV7BwAXa9lEf1cO_DKehOXEslDabhQY3
X-Proofpoint-ORIG-GUID: MV7BwAXa9lEf1cO_DKehOXEslDabhQY3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2023, at 1:40 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>=20
>>> On Oct 29, 2023, at 6:08 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> This patch set continues earlier work of improving how threads and
>>> services are managed.  Specifically it drop the refcount.
>>>=20
>>> The refcount is always changed under the mutex, and almost always is
>>> exactly equal to the number of threads.  Those few cases where it is
>>> more than the number of threads can usefully be handled other ways as
>>> see in the patches.
>>>=20
>>> The first patches fixes a potential use-after-free when adding a socket
>>> fails.  This might be the UAF that Jeff mentioned recently.
>>>=20
>>> The second patch which removes the use of a refcount in pool_stats
>>> handling is more complex than I would have liked, but I think it is
>>> worth if for the result seen in 4/5 of substantial simplification.
>>=20
>> So I need a v2 of this series, then...
>>=20
>> - Move 4/5 to the beginning of the series (patch 1 or 2, doesn't matter)
>=20
> I don't understand....  2 and 3 are necessary prerequisites for 4.  The
> remove places where the refcount is used.

Hrm. that's what I was afraid of.

Isn't there a fix in 4/5 that we want applied to stable kernels,
or did I misunderstand the email exchange between you and Jeff?


--
Chuck Lever


