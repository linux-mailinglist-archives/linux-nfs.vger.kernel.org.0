Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6072A51A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFIVHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIVHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 17:07:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15241FDC;
        Fri,  9 Jun 2023 14:07:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IbTLf008739;
        Fri, 9 Jun 2023 21:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rOW3Y8KnvJl+Quupoz9T37CnOiZszOmYxmpzfdGrorI=;
 b=lr/uI+e/FDQno6BvMIqb7ZZLtNwMSGboLpgq68Ib5SdhfCxxNQtsaGUOHoVG2ITFmGLi
 4xSHZSQZvNquRDFHXS8s0ZfLOaVr8QNc7Y7C34qUON+7rTZUqsi3phBbd2b0tBTQdXdo
 UFSbZ0IfYUlByai4i6elfYI+d+ctQjcA0ZaZ5CzTMuAEOb1vSJ2Vi+mviz1LqLHrxM7U
 TnW8XvHGCq31HptaZSlatLKgye0AiqjbZA95ahGRLqgt4w2hplg09yi726/PKe1nAJi/
 lhi59cBiGn48sx0v8nVBEugzD0JXi++WG5TauRPt8DGEIxkb27NH5E4LGijeGKXxtw3I 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ufj34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 21:07:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359KXYkL035855;
        Fri, 9 Jun 2023 21:07:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6upp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 21:07:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W72ZO41jS/ZmjKVArTy3jSGRn3iEupWxsLK9tRXIVBmmKbpp/4fElFpz6O8dcEKvZ+gbrfXmwBraBMJcNztzJaeRyHULwDp4N2emJVYeme6iENVPMxe1FWnlkGkzCnCtdx99EfqWRV9pA0wvkOirLu0I9HdbN9UbVPq7lMEx/Tbo97bfMNE68Ffs8ceAAIUeUINb5OJSMUd6zXVaK0/Ai7ZJIo1DZ/tEtbOWwCxhezkYSdNfSq7MrYQ8bAS2D/eCidYfPLuhBuowIZQX3tEgWfrlHN9qX802nWG00lTiO1/x+2etIQZryx5goi/EOOgGBwVoAqxywFGrA9/6NQTZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOW3Y8KnvJl+Quupoz9T37CnOiZszOmYxmpzfdGrorI=;
 b=L5QQB2GpAl8M5s8PVgyu4tItwIrQ4gukY8YlJUhvo356V05kzGpTR1XzOjP0F9C9v8gSpeJtV2Uox4d8q0IXVHC9Kc6pVpttN7+iKbTYBBgThd5WIesiKW7L2/f9qAovwsFFR39ID/0+gYso6DJ3x2o6VQbBXUu5uMB5oTc5bd4seP6qMvh3Mkjs8xTmF5RgwF7kRya/7z4GYkuD5FBh2QXtU652aExhJhfsL5FGGoAjmtPa8cvLXv4u6JKW6WCVZr0t9SSaR4mgLFsHv7KUHOVkiLKTYikkpUP/aOCMQGOh32zOaxn0i6Fsw84Q339I0AybNils3UP3Jzb7APD4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOW3Y8KnvJl+Quupoz9T37CnOiZszOmYxmpzfdGrorI=;
 b=lk/LP4dbfYAGbo5H72nbU6+enKjM67+glCElB3QPfLBvWA6YreraciI8WONcqtjHiHYgbA2YKEtGHifB/lGKtCwjnF0ygQBYmfLgHtes4fHdr/ROKbQW1exIRHL5SBv76iGbFzgPOTgfWGFkN2ME/nqHZKhefYxUzAd9xuyzfH8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 21:07:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 21:07:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] svcrdma: Allocate new transports on device's NUMA
 node
Thread-Topic: [PATCH v1 1/4] svcrdma: Allocate new transports on device's NUMA
 node
Thread-Index: AQHZl68+/TAGlbIUOEuf6S0K7i82sa+C9d8AgAAHeAA=
Date:   Fri, 9 Jun 2023 21:07:21 +0000
Message-ID: <AB7C5824-8DF1-4DE0-B03E-ABC8AD1418A3@oracle.com>
References: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
 <168597068439.7694.12044689834419157360.stgit@manet.1015granger.net>
 <3ed1ba55-0f59-0ab6-dc44-2d248a810f6c@talpey.com>
In-Reply-To: <3ed1ba55-0f59-0ab6-dc44-2d248a810f6c@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5164:EE_
x-ms-office365-filtering-correlation-id: 8e4df8ed-d419-47dd-70a4-08db692d83e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPPjzaqZMrJznFEPC8NpwyloPe2MevSpAVj9ApYSKVZAc2J14DyqNJuIM6YudIcDmDmbM1V8szRJRKDEl8Vf+3kl2Gbt7JxDHayR3JGprYXsd5bIEXBSi5fUus9auzv9kkYjLs9DilFX9DdTalUNhy0KNBzFib8USl5gJWx66ai0hFFBkJG/RLrEmCAQA1Kgc9hXJvsFK/j9SLDMngLp8zF8/2GNiEUN17Up6BbW/TUiowkH6FE67ehtN4xQIO82piQf/LHL0Z/AipxVGCBrwNxfmVGBJpWqNSu3AwKlpT3qK2g9Nd1L0eM/T3F4fgnfZuBkDb8ed2zQEbseozzA8YsygOcSauQ886AMTQ3CHacNktgOjVI031NGfkbArumDFVhqmmzmcCyo/3ZMJ+a2fJM3jJ6tmQ0vVxCHep+tymVz8Vt8p3DvQgpcUThufPf5yx0/COvyK5c6OcOHjVXrEOJdZUC5lAQMzNW+3WlJGZ1Mk7knqdxfmPDd7VUuXCqxQx9tL2PbO7IvsoHgwrQNkZVEZppXjs11ldGihlg5Bx2hsekAGPfimKcywicsU8WOEUiBr2hFiJDilEREykfsrbMOA5xmhr2dqnMDMZieLkO9o76j/ME22XJYChKP+rSAc2JRHmAurq+dJYzcutXZlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(6512007)(6506007)(26005)(53546011)(83380400001)(33656002)(86362001)(122000001)(38070700005)(38100700002)(36756003)(2616005)(186003)(41300700001)(6916009)(54906003)(91956017)(478600001)(66446008)(66946007)(66476007)(76116006)(8936002)(8676002)(2906002)(64756008)(316002)(4326008)(5660300002)(71200400001)(6486002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dqiOQhvEG7fCLQYRDUqInucQQT8UJounV3yKPiBDrf3Z7ZMxbkjSqQwFEpL1?=
 =?us-ascii?Q?y6r5umju5pgMdqb/Au/wL8sz6wcWpUVRGKLwvyLiWi8mXcjYJnd1LLIC4+mR?=
 =?us-ascii?Q?Kr2Z12O5aNiXAqVhS9CWOT2t6Gvjk0wU/vBibDFvKYDFwdvrqXfMmLl2Gzjj?=
 =?us-ascii?Q?aXEFFxwxZpUhM/HB8+GFNsKrx4InSY+J3h8t27ke7QO4N+UtRnbQfMdOHCp7?=
 =?us-ascii?Q?1SLhVrTASZFrPCrvY2pzIccT9dJwYD87ImYjjhdZCH4b+k+ZEjZ8pwpkKkTw?=
 =?us-ascii?Q?aZ6XuJVpN4NvK0u9SlQaU7pFd1Kvqc98EkTh/pU9DaMRZc1SUZCjqCetvWSe?=
 =?us-ascii?Q?VD6tSDls3PUBd0CdX1AsjvPHOEKk9aqkvZVchNTiqcCTjXGZs6ziy9TAfAUj?=
 =?us-ascii?Q?11kbU5RggC4X+g9LiNqH/4qR4+5oHkS43NVAAw+HdGHGa8zDfk6hySCoVAs7?=
 =?us-ascii?Q?z/0lbGtqXh9ABURnPNktujO7AgLS76mK98fQYWUu3Qa167gzpSq5mNprtTvh?=
 =?us-ascii?Q?APraclmlUiwR94mq/JRBBZbpRKsOAtYh33XiwxPCN/FWGyENTd2+37xTawAX?=
 =?us-ascii?Q?i2Ln8qQCt/d2PgHJ5w9I2VjXaHcS1AzbdsVGtqr54mitYBo1PLi3OqkC+XDB?=
 =?us-ascii?Q?HfevnmiwggvA0qqVphDi0IULYshsjWZnurNLhHlh9NjLEa+BwZ33jIpDetM5?=
 =?us-ascii?Q?djZNfSNRdTYzR8CFJeRu0gfSO8T9yoT6J+vxgCVyyvDMVjdUCiPAuL0ySmym?=
 =?us-ascii?Q?+nK3Nd31U6cGK1Wti36/N20ov5I9uAXDb3rwgCUsf5Gp6EGD11y5xwW0jmwB?=
 =?us-ascii?Q?ZmbfxVBZebxNJ5dzV/mbNgKu4o6wVIzucdv9ANdw+uYPnaEuAS4HDKWtXMhM?=
 =?us-ascii?Q?Vv3N4jfYsXkAL57e+5tf+nnSXDoDip+mZrlMAwC+FIooqxVtcf6dhvqiOMMS?=
 =?us-ascii?Q?+nw2wVCrLkzK4U/kk0UATYes60QunseiYgcAwrZk2GOq97WcyJ+ZdwBulEEF?=
 =?us-ascii?Q?BOZBJZUxUifEXqJ5L/LFfz+kHRJf3/JafbEWHzdFlMX0ukhxpwNMQZIBmSlX?=
 =?us-ascii?Q?ZV5Zy/dUI6PvXcUGv+zbfLZtFk/TimJOnzRzp8gUbYgDIN63/nzbmUaynprd?=
 =?us-ascii?Q?EpUb7KdLgoEex7ZLXwAqGN3pA5BHy37hvLFUCNa6YuCvgfngVH6WrG4daQFT?=
 =?us-ascii?Q?mTSmI75oleAzWVJYQBMsRfjDNnO3GISwasqucdEudLcKe7TZUHSVgUCrxfvK?=
 =?us-ascii?Q?Qi8VNY4njMCgNT3GghliKwZkCPmU3pOBVNw+uNjV4Y+FXSWm8X4rwyynqBB5?=
 =?us-ascii?Q?HM7ekqJFjpl0maTyf8mSwp2SLnz8lysq0G9CHRNlfXArmw7oqNuGm7AlNb95?=
 =?us-ascii?Q?CLH9RK2LE3OCKcZ6rsv0JMpGIO9JIVxoTZWT0JcG9ozRO3o8gkFFDL6kJV7V?=
 =?us-ascii?Q?YxpMtwMt5FZ4Hh57ws/AWxrBTC/MCYW+JCNeYYunx8pSUurNGcJv9ZAjT2MF?=
 =?us-ascii?Q?L+at8ECE3AXZYgns6cUlO+D0RU3CFCLTTzroBeiM6675WRDx8CzSLyyQrp/2?=
 =?us-ascii?Q?b0BpNSPrZkMKGSPS0R4rztVzh0KjoD9wbn6Pz7bPjIs2gk5bQH+kgnoxofX/?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3377BD60E3FA36459928A454CCA8DCEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HxLoK2Sk6Pi2KcD2T7FpNwcNZlXP4bwsedPZb2iHaKpCR07EcViiq27vFiXI75VUDnumcB/nP7DEjXRp+HAPOlpvAU/1JiNFFuICB8bKkctG+rfI1sv+paRBF1tDY82YSkSqI/k6cq2KZovGnnDNqSDzQGUZsv+AqcgwU3eqmmqGbzyL/VUBBJazfQJDFeAW41DXTGV3TOM6zcpavBSAP+TypTvWNI1QLK5o95G+ilx7/hkSPOXXRaJBXRRCz1Q8vDLVarqyD2UqVCOA/0UuxlZRKrLak2pxlMhcAAy7zuutlqA2qaqDBIYhEymMxXoIxHhzNwDHuVAaK1ec4BvMEeTes7WSGj8BcaiuG29YkIM2Ecj0gTNhysoYcPlQnyVUFUGG6JJs4TzAGXPgJFVxrGu0pyNbqtDx7cJMfWW74JmE2MnNJa8T5DekRrGlr36PYbK+fBnLboB7zffxIfAsRF3eyaimQeTnY9XPe8YgfxryvaRnNnMAbHdxH1fzTJlp1036V/zsXlUWX696bsJSQIcSktDH1qtiChwUaJ2HghqL/nEuHYOWUszXpnUeJHCABsdXME8PToM5aFMk4HUr7XGyRu74fcCJqyODf+lpWsOmiCcxZ5JFfQPNARMfS3Pj86oSA01TAKNU2RHwiishsi1FuS/T4sqI3lxXo90Hpw7ddxgCDsS8WxAjFt84+Mg/4sJXKb6wiSbQwVnIH1LLZ4SzpZncSUgnfI6LBkUVxLiMkJC93/4pwb/lekpDgxGNMPl47C090aWuCe5lbeXQv978v1pY95mQ1Ws4l15udVDaq0LMJEzGdfmx56zq1Qlp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4df8ed-d419-47dd-70a4-08db692d83e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 21:07:21.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0W1JZg4tyBacp8V110q4P8RX5VgQBI2WjsW1KHRPw/Bynb0dc0TTWFRXUZFcKbZCMDTyP36jA2gosj2Vn9SO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090177
X-Proofpoint-GUID: u_HMOhiBOiMXhBDgHXb232-k2ihMb9Yw
X-Proofpoint-ORIG-GUID: u_HMOhiBOiMXhBDgHXb232-k2ihMb9Yw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 9, 2023, at 4:40 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/5/2023 9:11 AM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> The physical device's NUMA node ID is available when allocating an
>> svc_xprt for an incoming connection. Use that value to ensure the
>> svc_xprt structure is allocated on the NUMA node closest to the
>> device.
>=20
> How is "closest" determined from the device's perspective?

That's up to the device driver and network core.


> While I agree
> that allocating DMA-able control structures on the same CPU socket is
> good for signaling latency, it may or may not be the best choice for
> interrupt processing. And, some architectures push the NUMA envelope
> pretty far, such as presenting memory-only NUMA nodes, or highly
> asymmetrical processor cores. How are those accounted for?

My understanding is devices are never attached to such nodes.
Anyway, I don't intend this patch to address that situation.


> Would it make more sense to push this affinity down to the CQ level,
> associating them with selected cores? One obvious strategy might be
> to affinitize the send and receive cq's to different cores, and
> carefully place send-side and receive-side contexts on separate
> affinitized cachelines, to avoid pingponging.

That is already done. Each CQ is handled on one core, and both
NFS's and NFSD's transport set up code is careful to allocate
the Receive CQ and Send CQ on different cores from each other
when more than one core is available.

It's up to the device driver and the system administrator to
ensure that the IRQs are affined to cores on the same node as
the device.


> I'm not against the idea, just wondering if it goes far enough. Do
> you have numbers, and if so, on what platforms?

I have a two-node system here, configured such that each node
gets its own nfsd thread pool. The difference in performance
is a change in the latency distribution curve... it's narrower
when memory participating in DMA lives on the same node as the
device, which lowers the average completion latency.

But, for the send and receive ctxts (in subsequent patches),
they are already allocated on the same node where the CQ is
allocated, most of the time.

It's patch 1/4 that ensures that the xprt is also on that node:
that's done because the completion handlers access a bunch of
fields in svcxprt_rdma.

I think the main purpose of these patches is documentary; but
I do see a small uptick in performance with 1/4.


> Tom.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_transport.c |   18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtr=
dma/svc_rdma_transport.c
>> index ca04f7a6a085..2abd895046ee 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -64,7 +64,7 @@
>>  #define RPCDBG_FACILITY RPCDBG_SVCXPRT
>>    static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *ser=
v,
>> - struct net *net);
>> + struct net *net, int node);
>>  static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>>   struct net *net,
>>   struct sockaddr *sa, int salen,
>> @@ -123,14 +123,14 @@ static void qp_event_handler(struct ib_event *even=
t, void *context)
>>  }
>>    static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *ser=
v,
>> - struct net *net)
>> + struct net *net, int node)
>>  {
>> - struct svcxprt_rdma *cma_xprt =3D kzalloc(sizeof *cma_xprt, GFP_KERNEL=
);
>> + struct svcxprt_rdma *cma_xprt;
>>  - if (!cma_xprt) {
>> - dprintk("svcrdma: failed to create new transport\n");
>> + cma_xprt =3D kzalloc_node(sizeof(*cma_xprt), GFP_KERNEL, node);
>> + if (!cma_xprt)
>>   return NULL;
>> - }
>> +
>>   svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
>>   INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
>>   INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
>> @@ -193,9 +193,9 @@ static void handle_connect_req(struct rdma_cm_id *ne=
w_cma_id,
>>   struct svcxprt_rdma *newxprt;
>>   struct sockaddr *sa;
>>  - /* Create a new transport */
>>   newxprt =3D svc_rdma_create_xprt(listen_xprt->sc_xprt.xpt_server,
>> -       listen_xprt->sc_xprt.xpt_net);
>> +       listen_xprt->sc_xprt.xpt_net,
>> +       ibdev_to_node(new_cma_id->device));
>>   if (!newxprt)
>>   return;
>>   newxprt->sc_cm_id =3D new_cma_id;
>> @@ -304,7 +304,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_s=
erv *serv,
>>     if (sa->sa_family !=3D AF_INET && sa->sa_family !=3D AF_INET6)
>>   return ERR_PTR(-EAFNOSUPPORT);
>> - cma_xprt =3D svc_rdma_create_xprt(serv, net);
>> + cma_xprt =3D svc_rdma_create_xprt(serv, net, NUMA_NO_NODE);
>>   if (!cma_xprt)
>>   return ERR_PTR(-ENOMEM);
>>   set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);

--
Chuck Lever


