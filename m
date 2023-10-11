Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743827C5435
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJKMmQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjJKMmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 08:42:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E98F
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 05:42:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BBJ5KA020209;
        Wed, 11 Oct 2023 12:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EhQn51wKqaxt7cUNfR0A2hipMW/Lr5H8DKJD8ydm7J4=;
 b=D9/atbeiGltKrxwY81uzXeIdEkqw/KdMKwZmq8T+TFJx2Bx2Y1W3Kv6gQ+5TbAdF0YNH
 4yt2rVv5CigDrWT0hG2elIkONLImQ6B+SScf1LpWFyZPjGjHfr39zgpty/3QUx/LxIoq
 fvE7ngw2a4gchdtC5HdFYFJKHBCxkXfEriTeyfUI+miomH/U///BpaPx5iYOqUhrC3u0
 t2JkiwdRYhN1I52qHo1NSTZzEWgOL+Rp8LobubNlSJfPIyohNPqLXj5PttyCFNA3slgU
 gtl1VRFK2IEE2qtmu9oEQBbCpjAd1dO4+3lyA2MCA20sIX18yFp6EKcHO2if3hE9pl9S uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cfrp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 12:41:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BBFtmM014639;
        Wed, 11 Oct 2023 12:41:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsdwjsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 12:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX6/KVy/BgU7ecC+VLtCldPsTJx2YMy1hLsdMHFA/LOOhe6biih4PQc906BAFydYmKpdPyGx/0AwDlVJHpDqDG+AJvohvx8nS9HVb2ymvP1doKYz6oVPnjMafTVItwddiDqUSD7nlT7nl4ccA4Fz0ZOZ0kM5CD4CUBKlL029txL/QCzKxo3m7xIFFYT7RtTSaBwcdxjsRJEXAZQ5otJQCfsT11Y9YL2/of/TLKAfQgo9kLEJLyIl76wzCmtU54RJUXadQUDvnJoTmrKt8fFrBNw1d4abu26wC55/ZDiw24PzUHlbKHW7+Gic8mTXOm5/rTXNeuZmuD+xgYnKGzuW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhQn51wKqaxt7cUNfR0A2hipMW/Lr5H8DKJD8ydm7J4=;
 b=k0zvsK9vq+puVwGFgu8BSGXlnjF1Prl/o5Rw+i8/tf3L0MKm+ENnkflSxzL0TB1rRoH8YZebONqf30BuDzUJEXrx/GISkmB7u4dTucc3BVaR8si5t+vl2OJzT3c+3I+NAdJUiLmtuytLAO5dogx9uFTYZe7PqkhuH+x3Hr+w2V73TwGyOSKjezXxYsa/3nKiwQ4ui9vn/5Mskec76OlThbX6BWHdqKN6+ZzupbZ4EpQhdj/qVW664ygxKYLEAOhuw86nQ8YMtv4jvYijQ8zp7FKiEKWD3hH7CKDttM7sanI9MN2DtzJ0YWE0SkozoA0PxoJ4ZpyR5KDhWdVn2upp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhQn51wKqaxt7cUNfR0A2hipMW/Lr5H8DKJD8ydm7J4=;
 b=I2wzT0uqnO7IDA0ZZUWaduSpAp3Aux6OgEOB+wEDdtPYUTmoLGyxJb2XSxnElE8rVsmO0AvI7Ij/TYI/1RNBUpxOZeuL3EsiRQ4BKDCJWfl27Zv2tNZk+bNynZevUsb5edqP2ujq7uDq06jMKrds1ji4jmYhDgrJLqUfijI78w4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 12:41:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 12:41:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping
 thread.
Thread-Topic: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping
 thread.
Thread-Index: AQHZ+wlZQQI+ju6EmkWAayUDxKVMCbBC93oAgAClFgCAAO3pgA==
Date:   Wed, 11 Oct 2023 12:41:48 +0000
Message-ID: <39CD2E44-0905-40DC-A75B-64B689791562@oracle.com>
References: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
 <834A724C-4A44-4277-AFB5-D639FCF2900B@oracle.com>
 <169697700659.26263.12600384009390271074@noble.neil.brown.name>
In-Reply-To: <169697700659.26263.12600384009390271074@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW6PR10MB7592:EE_
x-ms-office365-filtering-correlation-id: 52226826-3ab3-450f-1308-08dbca576fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfkuCU/33njFVHU/8AcaTpLr5ar8rl9LPAk9it6Yx66dGJWZpyB/fb1M4/kKYuhmzRWOHwA341D93xl4l6VuIUau13lLHvKaekmRTwQixuJoWJtQM+pf2IbGrB3gDpItk0L2VrDFbKxs7Zppmp18EaVsrDGSZMbu18V7+WhA9A7evu0uM0iTUTXaqka41zatphLtb97vC0KLZEwTouXX/e97jlB8tziUReZPHkt2xd4LML1GX6masBqtVCE4z135i0vZJgBRnHTQyDwPdw96pwf7eFm3P/8zzSw+b6UhrTWxKzo0Uxo/C1bmCv6+PfMxcp73haEIgvOrW/t6XznshJfIrIyjOT4tqCFYWLtf31G+KFWpTgRmXnAhgAtx/LExEW+tT1rTiIkglFUlGInaPOdYhuCY0Niy0vPIDVssYd6jvJ/pJmyFaSk5CcxrACPcP0RPP4qDGZ3uFNkJxQfeCXNeFD1HrD2LTJ6M7X+ZHJT9M9VMjkb2XoE7HrTaUXTgkvMnSYHx72xbLVEImjpsSEnZNpx+WYfWnkMnFEmUl74hoowGl5jR4Lz3YICfreh3+Sf+hq/i7/h7nB/5WlFPcRuM70L8YUXqR1myHNaF0x3/6oEwgxKR5IgrX2u4FJ2MJBtLrntRkXy3fJEnLZUduQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(38070700005)(86362001)(122000001)(33656002)(36756003)(6916009)(2906002)(6512007)(478600001)(53546011)(71200400001)(41300700001)(6486002)(5660300002)(6506007)(4326008)(8936002)(8676002)(2616005)(83380400001)(64756008)(316002)(66476007)(91956017)(66556008)(66446008)(76116006)(54906003)(66946007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hTHIxiLE9CcF0PMFk9buylZWEXfMbcCQSyAeCq04UfACm/KKhVaKewlCN7Zl?=
 =?us-ascii?Q?gL7EyJnH4Oxz+XRyV0uQgwDWjyXT9LvMj9jii95fpQYbTAr4NwAiuzEN9boX?=
 =?us-ascii?Q?lcO0s19NvcIZMYxSZ6uk629ArERh06gXg9xznrQkmJb1s6Ftd/NPth4dBGRN?=
 =?us-ascii?Q?bFiYlllxwLJ8PMP/yAQfryschQ69MklFu2Yw/YMQNxofToD7vG2bQRIMAjLB?=
 =?us-ascii?Q?GbYgfhRpNxgJnNyJORrzAWkgMdqB6uDgbZWjxhTm8U4obl+d9DrdkmVpTtS6?=
 =?us-ascii?Q?gvIW0iNSIhj6665WjPVQsyLPguxp5pYVPn8TsW1zFULXuT7R1NX5gblUSabc?=
 =?us-ascii?Q?lkyhGlNHbwA3IGtTFEt4ROIRe+884hl4ATWYwU8AZjcaBjoS6eQhkkLkbAH4?=
 =?us-ascii?Q?W06Z5J+BZ/TOazijs05QlQ4E2h/uPbThNoh76/Gmua0FCAtH/C7X4r2QSj5i?=
 =?us-ascii?Q?DlBcE9QcHPydrFDH0Pzfj3UFmWNH/0rYldBJLeHXAt9r7Dby+tRdbziIl4DP?=
 =?us-ascii?Q?fjJlTJXxEiygH8EcK+78LRVo2kU23DnAAZdpBl8GoyvHyf4S1zQljBoAkhbH?=
 =?us-ascii?Q?FPJt1q+Vj2BXcbFBFzZx+CBkRfTEdToIpMMU74F2+jfUzuvEo594LMYJibal?=
 =?us-ascii?Q?dAGGO0W2OCO2XX4xZ3mJ7Qh91VAfieu7W8m0BZJnCAATBTg0ZJU8MemD9y8t?=
 =?us-ascii?Q?Y8+9GHDL9//2c6lnFjL0/k2Uk2CyiUeuBBEtaV6Mun+DO3Dxxq1iiB49Uy87?=
 =?us-ascii?Q?7pv0NaBvx1esUn4dNhVRSlPON085fbnvYI78ZIam80JTmM+UWdNKX29uhuV5?=
 =?us-ascii?Q?/nNsH03uQ15+QOxyCxBgMeIX2Rxe9OrwTvDNwx8ZexvJIBWK6h/O4CUxXBmw?=
 =?us-ascii?Q?a5BCMq4s8UHKgTno6zk/AKQd+zJ9qIlJ+gzJ7KI/JhToeYxerYgZSdk89TnW?=
 =?us-ascii?Q?mXU3o7LH17tgBWszzSAbvrqTI4i+7Ckmjb5Zw9zIAcp4ShXBwVPMjtdm1iSZ?=
 =?us-ascii?Q?25uqTNDb5eC4X0PpCNlyAlL3O/dxKoHiH6gQtNtMdZm6oPTm5n9P/cZ5PBWi?=
 =?us-ascii?Q?42OoHpWIUEx2FfEgfKbfaPJSzmYA6aATYoP3IGK4RRXV79PgtTBdHrOIUE/b?=
 =?us-ascii?Q?y3jCvdsryOnNxDxcWu5tgtmo//uJc5bsFaGIpDDjWcNeagWYDqRZbsvyOboU?=
 =?us-ascii?Q?TWpUH+Dw+jUcsLOeP77Wud/2Xp9SR9GpyFXYxo0jvGKK357OWUuy9MZprJLp?=
 =?us-ascii?Q?E5C7KiL8cSVVPmYdgL0ZeuMiFhzC4j3iyzVb7SB3xB4iFHW5MUlAfMb9+QjI?=
 =?us-ascii?Q?601N1ijHYarT1STtACD01GObg4jnHWu0W5QvQ9Yp+MyJrmXBEGFsow6ePbYZ?=
 =?us-ascii?Q?WjClfrZRpe8MwGiT6hSyEJEKh6CWRT8IJMY0VCSbtDPDhbexZS6S3XSrUp6G?=
 =?us-ascii?Q?eifoTbv91toTpHxGHuUmmxJEh3hc7eKROR4B7O2SassLlsIAFd1EUntqPcBc?=
 =?us-ascii?Q?aD6XPPzlXdqQKwXdtRJhf9eLceSU/Fh/Is5pvR8D3Skij7xYgc3ZNKdcH0Vc?=
 =?us-ascii?Q?Cu/tiLTbo47sQlQHJ9A14PB9AciaT17vOTaGjK+YnQ5ezrO/yCaPr34MY7er?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <009ABCB84DC9B944A42B47361CD3BBDB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XWlPS/TDLG9lvFb0kSmTiCMydqCQaadWov4aDp+O6vce9Gk59dkpgc6/UN+dFXXy6QIzLVriM+vfctKonBr81m8oxne2/iltt1R968UINuDxJclDwXclHSkncyQ5zu5n+J1ITPjFAhwkPttf6pqbs1laZDBKIRxXVI96vt9Nnw+MvyP8PxJpQ8c+7B4rhyfsPe33uaQTEZKMZKaY5LlmxVHkjYIMOH3BYzRd2giOZaPTh9gjIWg/3/Hl4JXH9f8w5G9Ey9cia9/xvLpiC/y2bCFpOHlcR8Jbmv4rZZCdhHlN87UygzPpe0t6d7xO8g3B/BFZU3025q8mrwA4adgV46xSXN7SCoyIQ9eaqJZRQJZbuoC/BX2/hlmxAbKnkym/8unERKuFHx0H5eGTifWj2pTSOC3QyAfO9FN/TkD2JU0GZuCKPmbK115BYabJfOCFqpRMNSg709ijL12ln0fsXcXRFOXWj1azbfD1+xzOqRpzxzFdyIeWvqBzgErotNqCLi5Y71NNU9Ri5y8MQ27DYLzbUS9j3d+rktrF3EWMA4TdxACuqxEv8t+bnnsFvu4/oodDVNb0vtmmSJTQCJHQOnxm5KCyxdcuP+FkEphLX9BeHXRUYxNDgnl/2xcprNKA/0TEoDU1a2vYYo4OL+7MwbJt3BV5HdItrWVsZMNQsNCrNMPuL/JOrqH7JoDqWs4K2Um21vAvLZ6tQIXsPYDL2s2TytU/Z7HbJXkfxycbEdV65gv7PB4kabH9t2S+j9Xk+eYAN1arzB3s+YRkWPRrX0bEgaUbpIes1EY1zeD1sGIK8Yn+u9bf/NWTyx9LYOHDNewY900p/bfP3ZCC29hEXNKCZDSVD9gW8K03T1N7CTykWREzwvlTLjZJ94Rp9nvk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52226826-3ab3-450f-1308-08dbca576fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 12:41:48.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eq5KIhFKVXKSh43PC8+XmYRBQEwsy2AWhHViVHpRktb2GBIBwsrW2UzHFONuwELRrEpkt9FrZjcxsJfM7D7AXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110111
X-Proofpoint-ORIG-GUID: Syz5-UvNMreRo2p2WXhXZqLGRSXUqh-q
X-Proofpoint-GUID: Syz5-UvNMreRo2p2WXhXZqLGRSXUqh-q
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 10, 2023, at 6:30 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 10 Oct 2023, Chuck Lever III wrote:
>>=20
>>> On Oct 9, 2023, at 7:35 PM, NeilBrown <neilb@suse.de> wrote:
>>> We are required to hold a reference to the svc_serv struct while
>>> stopping the last thread, as doing that could otherwise drop the last
>>> reference itself and the svc_serv would be freed while still in use.
>>>=20
>>> lockd doesn't do this.  After startup, the only reference is held by th=
e
>>> running thread.
>>>=20
>>> So change locked to hold a reference on nlmsvc_serv while-ever the
>>> service is active, and only drop it after the last thread has been
>>> stopped.
>>>=20
>>> Note: it doesn't really make sense for threads to hold references to th=
e
>>> svc_serv any more.  The fact threads are included in serv->sv_nrthreads
>>> is sufficient.  Maybe a future patch could address this.
>>>=20
>>> Reported-by: Jeff Layton <jlayton@kernel.org>
>>> Fixes: 68cc388c3238 ("SUNRPC: change how svc threads are asked to exit.=
")
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>=20
>> Thanks for the fast response!
>>=20
>> Should I squash this into 68cc, or apply it before? I would
>> like to ensure that bisect works nicely over this series of
>> commits.
>=20
> Probably makes sense to put it before.  In that case the patch
> description needs re-wording.
>=20
> And on reflection I think the code should be changed a little so that it
> matches similar code in nfsd and nfs4-callback.
> So I'll repost.
> I'll take the liberty of preserving Jeff's review/test even though I've
> changed the code .... I hope that's OK.

Sounds like a plan. I've picked up v2 and applied it to nfsd-next.


--
Chuck Lever


