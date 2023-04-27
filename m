Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544B86F0B62
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Apr 2023 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbjD0RtC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Apr 2023 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbjD0Rs4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Apr 2023 13:48:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E092B4ED0;
        Thu, 27 Apr 2023 10:48:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFmo3L017005;
        Thu, 27 Apr 2023 17:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nhFH39Q4XIUpjyXo6RTauitLykllG0wNIUlItSDiWpU=;
 b=dGdhQ8svkGkJvJHe34KErMWG3U1Fn020vBqZ+Hn7jVKLUqIAXDN5JKZO+YxRma89ORh1
 af+i1x+v25Fa+gHVGtCQJOvtwie6B7l8ZLuI5/4emYAmkLJeYBUzAeL0MHajICZg5dDR
 Ey6H2I9NdHG4r9xy0Lbp5lzwMHW+BRkl4sZzE9NVmhAQYnX6kjVVjBoatPAIi9q36Ize
 Bx7hDnbymWBUaR8iKoK/ST84ZMY96caok6eDtHt2/+po9kR/n3TdfkNzwWXikpYhOQge
 8eAHcsHvCYG9ec+mzocvY3iesjepi+PhZHCCjMjDNnzHLiTa/4ifK8gGVrufHvHtOwJV bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46624puh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:48:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RH6pJG007340;
        Thu, 27 Apr 2023 17:48:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619ns9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W36RgwvhTiJhT7ngSHYm0omfUohL8h7zmZaCClJXVZ+oteepIet0BZ8vPrMyrY8EPgIzfi5zbD+erOkMzo0jUYjD17UjgysY7lP7/YN+5lgJFlXH4UEy/4lnQYyj/gK4e3bBkipdGaiLNF2NOVbvTqqOBsJg3BW9eyaAP/V6IIJG/LELj/zJF7an3M/b6hICadQK79eJvCS1UgBt7sUGBZ/fJtEAYamfGUezuLzjK65/mAP3NJK6fFloGGWXNMRX4GpGpdnZvt6Zms/PVnDnWfm8QEg2+H+Zp/jkxV42fThRVZFdXsLTvwaphmuxCRs1QD7r/5OO1AjNKnA/GQPfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhFH39Q4XIUpjyXo6RTauitLykllG0wNIUlItSDiWpU=;
 b=LDWIHzzDxw0uhpA0UG8NN96jqiYtAfd0KmqSPB/Q2I4M6wOFHnJxkpXg3+imM4cvw3tzWDsOJPpw6/pJ/tcZzX9DJuADhgAuvxXBtkbHOHQJJoK7hik6NH8LrUal86MIFYmirP6cXukkuSweqSEgafjyOHsIwO2tqfFpo/IoxtCD/5QbW4ImjbaMMAlprJq+/tDJIOlpkLbwfTqCrJ8DScCdYPDN93kcDrQrcEzQ5D5OGiwegIwSph+KSA6Hn8rumCEEIhIuj3+3x9C/5TS198kWH63sJhdw8GTOORKRVKQFXZR4Oqf8R/UVF7ERx7ntELGNTf4VC9dDTD3Q23jBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhFH39Q4XIUpjyXo6RTauitLykllG0wNIUlItSDiWpU=;
 b=eecUAARoMngV8ztAF9xrlAvDXu5zWBgtYSyKeujwOsCxJCsjTBAvabrAypJ1vEz77IoW3hKYWGHcpW/3pPJyhKQq1FRYWbuwcP39YWvqPMjeOnyXGBgqWMIJcXGeb3YUvVojZ5R1G8Czkvin1TKVzZem6RYqkvVePDA/BDKg7h8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:48:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 17:48:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Topic: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZeSvPGmUIQ02sEEOITmW0YGNWva8/bfEAgAAAkwA=
Date:   Thu, 27 Apr 2023 17:48:20 +0000
Message-ID: <29A9F2AE-ECF8-4EFC-B1EB-7B147FB17737@oracle.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <SA0PR15MB39193598A4C64E84F6E07582996A9@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB39193598A4C64E84F6E07582996A9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4936:EE_
x-ms-office365-filtering-correlation-id: 4c64b699-b008-4c10-8afb-08db47479729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOsg3UYK3N+C3Mffb4t6ieNJeu+gvYIqmIXgDVU6OBvA6MrZsPS7diWNlSuNHk/h0MPW8wEdy4bqTRLyEM1EJP950Y/YHVAaax22DRgJJmn+9rKmD0ogATy0kmV3jvPShVxuYgr7CNZoeD1WMT4AWJ98v0+CB1Cw9mAHcKWpvCXMz2ZttW0WD4gX+RZMn6R+lgef0MmVraYCZ2koFq8rrIy8FLHwc4XWBxXR0ce/fNITT0VlsHthjJupwG5M0uxNq/IPU6ZJ/moMiAAcvjjhKekuXWr8Qit2yZBfrI2txhFMLcOPKxes8XD22MfZFehpoHBY5WHciaTBTtRYfxq/T8I0niMqRhqNIjsumBNvgCn8sAvXeZ667bC1zeC0qN5G7y60yfUV/GFSWoGploMn++Gt7CrsmON/brFDyoPm6SckIwHDhHH2iSvaCBGkRhHT5KNnuXHzWJ548b23wqhm3bHaSSg32ohercTNPAC4/BaAM4wvpDnVZbAZRn33om8coEDTfGhrDzGXLFa/a9K3F7ecWGoqf/m5TpirXGsFW4fWjyqh0jWfxQFuodUBiboOGUP4HRM0ZL19idsayNjMF1qFUsF4lg5ZAt5XFGDyAAo3n/8UY5vkud3RIWOqr3+asRqENY7lx0W+Vvr30zMcyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(6486002)(478600001)(26005)(186003)(6506007)(36756003)(53546011)(2616005)(6512007)(83380400001)(38100700002)(86362001)(38070700005)(33656002)(122000001)(71200400001)(66476007)(66556008)(64756008)(66946007)(76116006)(66446008)(316002)(91956017)(4326008)(6916009)(2906002)(8676002)(8936002)(41300700001)(5660300002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gh/wDPEXfW2kZGMO6sFuB4dH2BFHZfRKJSCcL5wZ5kseSHn0i5WU0U2n63j7?=
 =?us-ascii?Q?7PR5OulA6XHDKCslGSMpWhW8ZEQr0qeyD+cU0vTPS9jPPm1uR298qQZpdcFv?=
 =?us-ascii?Q?qlnGzoTG9w1/LjW4TCIABscoeJIWwRsgz+cwFqWG8adRMRF4sJ28tYQM+QZF?=
 =?us-ascii?Q?14i//7U5XTbKn8NmaQpCCgNbmev8ZF6RqluV1FiDntFiqO+jMZB5XGY22R5+?=
 =?us-ascii?Q?z7flve1Ny+hGzNqHg6NsZakLjMTxe6Wr2T/XlAaPwWEHImzpovqsGspdm9og?=
 =?us-ascii?Q?exTqw+p/enE5ARLL1qfoRfhuu0F+lufuAnJvtU7S+QMQ+kwjAirSs7kpzmNW?=
 =?us-ascii?Q?PocGVp+22q52/73aZTI/7bb945bqVTQr0h8e4tNJCPBcIROEGZEGt7CoBCof?=
 =?us-ascii?Q?Svsb9QgkqIp3PtCC6OVEyg8xDXCJl7ooXainOuwD29S5z7hKqI4st7Mj9FGY?=
 =?us-ascii?Q?kxn2hnswUvyt1wtJRo/90kLLsSk+e7P+l9F9evdXOptOa57aW2sgvrBp37yJ?=
 =?us-ascii?Q?GzaNaXCjnAWl4zEKy+OxyYos9ftYSCxp3KZJdvgP2KsGZJ2vKVk0PrSgkxdR?=
 =?us-ascii?Q?aod0/G9DZ5/U3Y6MByHWIcRkBXDKjGLI1ou7kxLSk4SXccwyKfOChq3uqGfo?=
 =?us-ascii?Q?IS52IxTCKsmjapGYAxZGodawxYWvUgHno9dKCE2W38ds7tz0ohVw/Az8/twx?=
 =?us-ascii?Q?70cZb8GMrUQmF8JEXzAzFVHNcQLzGGvFG+5pzFiK9h8iQHDJMMoEwgmKaA0a?=
 =?us-ascii?Q?xss4hdlE9o4yysjwrBY8NCdy+tuORyHSxxCAKUnvqu1b+MwfKjAJK13nJE9P?=
 =?us-ascii?Q?PcwfJB6kcPdsh+9keUEqO6OOrXodqapq7cOOS59TvAShM/lbQ2LIkrr/R7Ew?=
 =?us-ascii?Q?Xrjxx3MsiiuX0FPFcHilBYncxmS5l0XPKEOuZT15WXeR/RldJ+3zhFDZ/0NQ?=
 =?us-ascii?Q?GBjnhn+A+xZft0JlbaM3uLOap7M8wYb1WKghoe6o673HiE1njvxvwtLu2Zih?=
 =?us-ascii?Q?quSM4qtLSPMXcUDNI9yYE6/bgbfHOoNScVFCw6Bb04RXAg22bN1wvifE4uFP?=
 =?us-ascii?Q?DmPt1my1x4m0jcIJKkivyyXlSfrSSJXmiGEXrpdvzs9iScQY+937FKSqtwmq?=
 =?us-ascii?Q?wyM9rnwNRbHhWvr2unasoBcq1FtzkEkgwS7Eu6nBR5PLAIAj9y1sh/5XucFZ?=
 =?us-ascii?Q?zFAnBbYca2JVyGhxA12gKn2lO9UHxiLS5BkR2YURZl2xKRY90ZKQOtq32fna?=
 =?us-ascii?Q?ukbNkl1Wv2Gb7030zUYgJaXcStHsjZmKZE1Ayt6Qhc5uIWgIhdpSp7ugMoap?=
 =?us-ascii?Q?S4Y0pxSxa+dm8s+QzX1l2AwlKnqa7W/mNumjL3ZlGxag/zjGHgAzGU9bebOR?=
 =?us-ascii?Q?VvcfAhF2F2gJF7eSQSuwNnYq0McF2bnBq9k0Z3qDWjsfr5loNlTOd007T6xV?=
 =?us-ascii?Q?+NfdVbQ6/ZGYeUiYFxrvaZw/4JxOH7dhyByRXRV0yyNbyzOpSBMswqLBtcHR?=
 =?us-ascii?Q?Iycx0dHeVIKmeGd/Q4GTlsKE1RI69g1Ni0P8zUcUjhE55AUtl5zM3m0zcYQX?=
 =?us-ascii?Q?x4ypSst9aGxH33/+0aCL5gFhVVqgXel3kus6WkfUEVzhUg6Vpe8CYJ65omc5?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B248C54B4296084D8A826F0B83E7DA29@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wNXML8SmahZ2q4y927r39udBSWXFddOFvn4C3CI861HiHRK3TughZ8Y7iJ9/O3j0dmFOmpDS/Vbromy8wOw/65ovNHa0NNdYzt1A7xvo0awIJocjdHwHBpuUfS3/jr+rGDQ3YaakT3/bTjLw6s+zs+7y9gT20B8oxviI1rd4Jdbl8sFcpi8ydM+vB3SgepHURd12Ba5tTCXxRzybt9SlwtO4cd3jU7Ff3tltLtOSlI3KJFY5OCfgHI0Jg4KIjz9mx/G5t7JWxZGP90v1J/0gQLz6PGVaFAABkS+TTe7Oy3cDtGhNECpHrOvhgRIHYizoQAIy7N3wmsD9Qt/xjIUreINedRcWylWEbdwGIjt8dhTOp4/RFau6EjfCdY8ld4OkOsgUqv/2HpBjFY4wL5pgFD3xTj1By+ElhNIaYJpz2cjCJaemiTMT2BC8cprFulG8F5v9bmO0bvdk5vKZ3FKJHJt4LYcP4Cx1ppcCJZk+b1RyEvIpdSrHw2s31DcRlT/VosPPGh4EjIvipuZ04VJyUdQinnqRKxQlzKkiWTWUqYEsEV6kJAnQWJRt6jrVP//tmCm909FK6Wz+bT06Pf1NKDyFoCTQandv9ZyCeIZdoqp1cMCgyIkCkkGoxngbM20ZZjsG+rLPKOuovi057xyGl39XFBcW/oPAawbSJq2dOOK0JCHytPDRFcZDl5SXlxk7QcO0nbLZT3qUEQjPYyhhyudqrSbWUxt1wpi5Emnp6isBPjQyv0EJvDBUa13SOR3M7OlQNv1pisOBr25bNiRNACxVEIxYjpOaMbTayxpj2yoa7htzI8guBW9ixCFqjgeQjCV8aOFKsQtMyr6e/LGNDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c64b699-b008-4c10-8afb-08db47479729
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 17:48:20.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96aFTjg3JUdt0pRhBLeBh7a14MV8PE8RXA594kH4IZpMzs9EwXfe/L34xv5hJVVoQ5Zb1Qk+gOAOjXdmaTuE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270156
X-Proofpoint-ORIG-GUID: AzPLd3GmfN3CIjlTHIWbLBc5AA3_e7Ze
X-Proofpoint-GUID: AzPLd3GmfN3CIjlTHIWbLBc5AA3_e7Ze
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 27, 2023, at 1:46 PM, Bernard Metzler <BMT@zurich.ibm.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Chuck Lever <cel@kernel.org>
>> Sent: Thursday, 27 April 2023 19:15
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: linux-rdma@vger.kernel.org; linux-nfs@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH RFC] RDMA/core: Store zero GIDs in some cases
>>=20
>> From: Bernard Metzler <bmt@zurich.ibm.com>
>>=20
>> Tunnel devices have zero GIDs, so skip the zero GID check when
>> setting up soft iWARP over a tunnel device.
>>=20
>> Suggested-by: Bernard Metzler <bmt@zurich.ibm.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/cache.c      |    4 +++-
>> drivers/infiniband/sw/siw/siw_main.c |    1 +
>> include/rdma/iw_cm.h                 |    9 ++++++++-
>> 3 files changed, 12 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/core/cache.c
>> b/drivers/infiniband/core/cache.c
>> index 2e91d8879326..2493ca4f2739 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -41,6 +41,7 @@
>> #include <net/addrconf.h>
>>=20
>> #include <rdma/ib_cache.h>
>> +#include <rdma/iw_cm.h>
>>=20
>> #include "core_priv.h"
>>=20
>> @@ -441,7 +442,8 @@ static int add_modify_gid(struct ib_gid_table *table=
,
>>  * leave other unused entries as the zero GID. Convert zero GIDs to
>>  * empty table entries instead of storing them.
>>  */
>> - if (rdma_is_zero_gid(&attr->gid))
>> + if (rdma_is_zero_gid(&attr->gid) &&
>> +    !(attr->device->iw_driver_flags & IW_F_STORE_0GID))
>> return 0;
>>=20
>> entry =3D alloc_gid_entry(attr);
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>> b/drivers/infiniband/sw/siw/siw_main.c
>> index dacc174604bf..842a039fa457 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -359,6 +359,7 @@ static struct siw_device *siw_device_create(struct
>> net_device *netdev)
>>=20
>> /* Disable TCP port mapping */
>> base_dev->iw_driver_flags =3D IW_F_NO_PORT_MAP;
>> + base_dev->iw_driver_flags =3D IW_F_STORE_0GID;
>>=20
> That overwrites the first assignment. Probably better
> '|=3D IW_F_STORE_0GID;' ? Or put them on one line...

D'oh! Will fix.

>> sdev->attrs.max_qp =3D SIW_MAX_QP;
>> sdev->attrs.max_qp_wr =3D SIW_MAX_QP_WR;
>> diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
>> index 03abd30e6c8c..c48f2cbe37b5 100644
>> --- a/include/rdma/iw_cm.h
>> +++ b/include/rdma/iw_cm.h
>> @@ -90,7 +90,14 @@ enum iw_flags {
>>  * reserve the port.  This is required for soft iwarp
>>  * to play in the port mapped iwarp space.
>>  */
>> - IW_F_NO_PORT_MAP =3D (1 << 0),
>> + IW_F_NO_PORT_MAP =3D BIT(0),
>> +
>> + /*
>> +  * This flag allows the insertion of zero GIDs into the
>> +  * stored GID table. That is needed to enable soft iWARP
>> +  * on tunnel devices.
>> +  */
>> + IW_F_STORE_0GID =3D BIT(1),
>> };
>>=20
>> /**


--
Chuck Lever


