Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD05A598F59
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 23:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiHRVRF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347509AbiHRVQs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 17:16:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C84D9D69;
        Thu, 18 Aug 2022 14:09:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IL1rHr016367;
        Thu, 18 Aug 2022 21:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AoFIHLeDV8ZKr2+TLaOTxUdqCwv8YViME+MQ+Y/pJok=;
 b=hm43XivcdmHUcQgdQtpxMPPbkm/NfE9gTEcZd7Ac3e3nT7bOJQenUbl6J/tXFT9QkCG9
 5F6OTPLSoctp2A+rz4pCQg/qNiGEPszc3NZgFkCgnZeDAbYcdLOPFXezwbhKEmVpVrtJ
 zmgqihD5KmzY/YxJD8mKp2sq16+kG4mZhc9MxS0VU1YJKz+Bc65j/3gilL412E5z3dG5
 rdu+ngf6ofVRShkdRPXXNNqM8VF6fUrFuqQ2JOzhIkK6GlBBnVCKqqct+JsmWAvjPGKy
 eFyiA9rcHiMoZh/fHC+f+CtnosGRvrbY2r/G0IjzjQVXT3SJdKz/ShWLwu6J8CHBaDV5 bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1vyyg0gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 21:08:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IIZ5b9015259;
        Thu, 18 Aug 2022 21:08:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6epte9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 21:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHzPeW9CAWVI7/QCis48buHxxy5uql3H9dJk7lF0m3Bzh1HEM1mIDdOkC5xCSQPI6AiTXiUoWaOnG2Rxg9yyYySDo7uXC052v/9LhGXUbPsNf1YkxH66+piaacVmDVTZoeyG5YQHZWHgg9bfjT0JV3RZQJGRyM9pJmWFCp4zVjog4xPT8Jp5LgK5uGufHzJfijQNfYLX/cFbyXTaixV/pTkTnz4VxhwCw6ox6CgZA484qnm5X4R/y5fg8ERmVVsVcVA/zUr1wUnVp2Kb2wad3ZRuPZfmxPeeEXLVOGscPH2JsVfvb32w8JilGWO+40RTOg0d7eDRegNojhOsRCFLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoFIHLeDV8ZKr2+TLaOTxUdqCwv8YViME+MQ+Y/pJok=;
 b=hVsuZNC/XqLy0+oWYvqVdGFPq80srJifhT2RzmRaiXf5gKC9CL++5SSIiqnnaAgc1KAJtTMOxvh+0BIK+5XCTaXCh1vaUbh/KkfNvEAa+v8S9USktPrt54rkbV+xcs7YpxQ6qTWAzRmAZ0t43VkKGIb6Vy/wIqUJVXIvRtjcIYOQMYP5fxlqPk25fv6Zj6aiTmHQSA+9AUTe+BE9YZWAa2P4NIjFEuklrl9+CDWUI751r7Hpii7t0gEZcwVaZ3PxCyfHm5szymlfrEAtD379Rz7VIkILSahrnU8T6G+Qw+6zP4pe/bB6Rt0qib+14eYyo7QBy/NhOtxyWT/F1YcUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoFIHLeDV8ZKr2+TLaOTxUdqCwv8YViME+MQ+Y/pJok=;
 b=MID9Lyk0BDPBXI6Dm4Aq7nfameZMftD0FVpfBd91hrGh74RnRWRX0CFtlJ5RASR6cGSs3Kb7OAlTwqbUvXUnHDIo9yj1vwCQQVjaNHjdvYf6JreZ/YOz5BoFczuO9lRexRSobQpDziaCdLZvQjCHSYt7VhqH7UHJYt1f7qk0uxI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1455.namprd10.prod.outlook.com (2603:10b6:300:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 21:08:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 21:08:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/14] NFSD: move from strlcpy with unused retval to
 strscpy
Thread-Topic: [PATCH 05/14] NFSD: move from strlcpy with unused retval to
 strscpy
Thread-Index: AQHYs0YZdqb1Z0ytEkGMvLQlXtg5dK21Jt2A
Date:   Thu, 18 Aug 2022 21:08:48 +0000
Message-ID: <45B86549-7FA6-4E09-9739-4756FBD830BC@oracle.com>
References: <20220818210123.7637-1-wsa+renesas@sang-engineering.com>
 <20220818210123.7637-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220818210123.7637-5-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0749cb91-07df-4573-3ee6-08da815dd85d
x-ms-traffictypediagnostic: MWHPR10MB1455:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yE+Z/M7e61k30YtBkn5nDb6ZGyIgE6MhR54dMBAhxcL8UXCEkmxlE2gpZcoyDAsTl6nbc/0+xfzU11XKqGZ0hWsiZIE26Wf8jtFgMbXm0f8lw0OhumQOCGKtTj6+8lCODWaAJXtTY6wErZOOzp7hnGJQMzLXJv6cnTAsMYB245WjOUylEDQbVIMwQlZcC4wmN0QUgERdEmTmBEGBxkXHZ+FX0r3bX74gXq1BOT+fEz0TUfSBjOULKgqFB4mlLWmaeRDQoR7AkEvcly4Ty++Wz0dKlwXBnccJfANQmImUicxarQNDqRMJq/S874d9I85bBivzGs0aKWbXoENL3UuOj20yq+BgW2VTU6TA278Cr8QAQ0p6lf29EOPVTo8U8wyVTcAh0XAUu9Hg0Yp+eu2fNbsJBc+HTDR15150WSlnijVbT9nQyS6oijjY2/aMtcf5Gt3+6G93DoP/syc8U7yOBV/fLf0qJxKZxmep7NAI3HG4MIowLJKR+zVFPQMBHq7CoctKI7xRCy5u+Wd1ZrUEEyPuNB9DSqCq9EzoXG2Dv2mTRZbymVJO0BGGAmO65OwbS8n0dUhc9bj1+Gb+SxoyANA3FbrKKShN+X93kBGfSSJXNKz9POvQAsH49miwvBpcNw5xzjQ5RgMB5SVgT7Qp6IZeLf+QAQyWbu9ue6jEBsU44OImMj3sXyb2iDTuHjPPPgT+oBylnzqDbhvNupdiergVO59aTyEuBtplOdlqV9v2ack+QC8xdJ8+0wb9hQwB31kv0MhkdtxjN+ZE5NdfyO5U/Y+SRdWFzFxHuNF9hpHDLOj4Xnp4YlTcYnRUWuCIHmhATmQkNn5+6omSERCUgL/QriOcIoV0vuYsCdnqQ0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(366004)(39860400002)(36756003)(33656002)(316002)(54906003)(8936002)(5660300002)(66946007)(66556008)(66476007)(66446008)(91956017)(478600001)(71200400001)(41300700001)(26005)(6512007)(76116006)(6486002)(64756008)(966005)(8676002)(4326008)(86362001)(53546011)(2906002)(2616005)(83380400001)(186003)(6506007)(122000001)(38100700002)(38070700005)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jxc3DvKbuXsDN6ziCynLO0fnDLwbX6mVX7ylcaZ5q9IUItsF00CA5BkUtak4?=
 =?us-ascii?Q?1Zrd2wjMbcQ7SODC8k14e7vedt+KnOdFr3jqkql4yPdRhs92nhiUnFpq7/WG?=
 =?us-ascii?Q?EgcdmootXPnXK46TDWeKH34xH7Sh9CMFw8LHTDJDWqcab6VnEE0Kv2FnbJqI?=
 =?us-ascii?Q?Bmfau05F+lKBKU+vwYRreD6in0OhkLEJewBS9YHMm2QIdaDSeR4fSsp1lKSj?=
 =?us-ascii?Q?rxwVOhXTpmONUMltTdiBobJvd3BKrLp2CwhGpjRHyS3ejm0LvsgKynNLrBcX?=
 =?us-ascii?Q?ctMuYr5fcCRy9NA5CcaQ0C8Abp+VFcHzdSMssgGezvPIgHMIzJH4tsVIT1Lk?=
 =?us-ascii?Q?dUUogG0X7+0BUXlDMeKMOcwGSKD9zeligEqCqT20pbyEai3gknP7I1oya6aB?=
 =?us-ascii?Q?76WfFbQUgdVtpwbdv63yybpfBFZSZBi7rkbMh9QiCIuvutJUtIKslIUIAApJ?=
 =?us-ascii?Q?LNpnPvXxfcGmAARqBB1JSnMLZTj1HsJ3bTXKOfjm64bNcuzuQY1e3BpQ/THw?=
 =?us-ascii?Q?x0ErYPFo412WzUrkvQQaTEmMw3WIFMNbl2idMVrYpbZZ2lrMJfDPL/OLYoa1?=
 =?us-ascii?Q?eAm8b3Ihufzq+hBrwpT9KH/hHb00B5V44fXc8yI0Pbufs+X0lKuUHbxF1PyU?=
 =?us-ascii?Q?sw75w6d/EtTGqGG+p3E6e2gsAMFdEyPIe3IFcBfBACLUtP8sM+blfM9pcLIY?=
 =?us-ascii?Q?mZdfCV96+QoH0fnI4Ouci9avnsWNE5yMnsF3chaOtrQzoeF7OF6gAUdY1Le1?=
 =?us-ascii?Q?0HmH9g97G/6FC55zNOyi7oH5ZeAAfx+4jVD7Mle/xdSpShSd8P7bXjOxWVy2?=
 =?us-ascii?Q?f7GkOEdpvydprMNWWtzeqH2f69DIAR/8EDAbV2defpk28ucTakAdSAw0hM3r?=
 =?us-ascii?Q?mR1InT0KH0lGLHfqY2I4VKArqA7VzOkYzQuxXMXjSC5nexvqcqXSS3Q40yFA?=
 =?us-ascii?Q?xoKVDHiMsTZdsqOcvMlWbfU1JTNEVEBHzZ55+t1a/pvkaIjUS1JeoUZ/Tyx6?=
 =?us-ascii?Q?TL6s5OllrRUa2mfuA5irbbzD3y7+4q9IN9ZQXtJXo7SujDdUHanvXd0unom0?=
 =?us-ascii?Q?JTuZzlPH2EpmllYACu9BNoz2pH9giTn++I2iPAsdQww/TQY2Nu1P8K6MY2mk?=
 =?us-ascii?Q?ElhwgHyv2hwrsvy1qdOg9NWTlMf+v3L1WVRG8ndsArR5UCwLAwD9uErTfyS6?=
 =?us-ascii?Q?xg+ecyC4d+HvGBrz62jhrI8piKRz52R2b4KEDR7p2XcO8kYUuzhXR/f1x/wI?=
 =?us-ascii?Q?LJWFK2aY6+mrs1/ThNIRqGwnWUJzqovwGDior9X/JLtKH4sU+yGGYQxHPamX?=
 =?us-ascii?Q?OJ6sWaXMQAzEi3IZJdeGg7MIL7jnAtta9YtmcCKMF83besh5SpSrybq5ZCwF?=
 =?us-ascii?Q?TOazLjJolxQb1iANrChCoq9wUTyemanvKtxvBMUHGV+knzjrzDGABDd/fPnn?=
 =?us-ascii?Q?5Tt0ACSuN7ZapAvOR1BwPpVI8w5efffl8hf5K+cIRL4HtOj9WfqPmkbMIzFm?=
 =?us-ascii?Q?yKdGypOOhcz+H0nh4ltDhuHtfHVKwikUqf8RByY6cj7pX1BKj0NlhUGX+4JT?=
 =?us-ascii?Q?6etDPqRALZxRhJMXCV0/TnUjWJAZpWK4czEEqq8j2eiYq7g4G/ijpowOqsQy?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D557F1113838B4EBF1BE7B3C477428E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?b1T4g4JG4BVJCpily0T7caDZNU0bdahf5VDNLt+7nyh4ZUgNQPHfJgOreOVr?=
 =?us-ascii?Q?xSxhmxj/rK9BRSdIa7guEBCKDwC2vRlvzVxeIbUPKYnXoazq43q8bRvfEVgI?=
 =?us-ascii?Q?QEmzpQZCwita5sn2Jx+t0eOxqqAUhUNuwx1MovrwumXXpQCRkzx3/7XWhaJC?=
 =?us-ascii?Q?TzGSuXGwESnTHTV7/UnZGh9bpXHSGvMgEnAUhRUMm9Q9ezQw6u5UICxbcQtH?=
 =?us-ascii?Q?wPDzFJc0QHDldXYGKuYZrsnBMc1eRXKaLoEqd1RVi2ctKA9cUc7LmwhP5dYh?=
 =?us-ascii?Q?oCAmd2usfYFL3i9pCW2Ooq+o9f9rKCrJfRHSDWJd2+yUwWAbmY9/0mceCocS?=
 =?us-ascii?Q?7g5nKKdt185Aww+CoofNkrEL2q+DXg/RASIJgnntDCUXPAz7aWnIbsp6oP65?=
 =?us-ascii?Q?ssuiRZv5PCTMVrx6Pj/1BqqB8IKJtmhLrwesxgxt6T2gt1xsNem4eU+JMQjS?=
 =?us-ascii?Q?0g0Xxh9Vc1OARpvseYaqHDnlgCUV/vJIOdF00/DhO8Yps4G2gEDBug9YxpIE?=
 =?us-ascii?Q?16U+gKgRt2Y40SyVA/adsrEhtlItGW1eGOgBSRhl6o3CE12Oe6QLYJVFLIuF?=
 =?us-ascii?Q?NGvBGYPCTx1eX8OSHMGrMHwtb4VqoLdEHP9bZbMMRUDwjn12MoShr5VNHXzc?=
 =?us-ascii?Q?GF8RT7PLAJRR6LEBqs1MWPoM5H7IvpY13pufgUBU39iK4HrDhNVlpCdKMyWN?=
 =?us-ascii?Q?rgptFbZhFynro8pxS34AHOdP+IE8uOTTleyj6JF4VJgucldtPSRUEO5HQfFo?=
 =?us-ascii?Q?C1jEqokED8CZXEc+k1p6pvIRniE1Y90BdPFkrZvrlEI6ZoEpxDlMKjv0+yI7?=
 =?us-ascii?Q?hG+oI66FR+2/h+n5XwBGLwX+y2fnyXukaFBGPOxHrrLq5a3iIKhSnx0bQgUy?=
 =?us-ascii?Q?+xsQdrFA8fS6VQcERrE8VjYBBkJdb+8DhVOb3fq1Udl9eauvQaE7cP5srXBb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0749cb91-07df-4573-3ee6-08da815dd85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 21:08:48.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjZLSfa2lKgTb9Ye4V3i/FTzjNGGqBTkBS+nVT8rJ0PZCIB1xO9i+hcP79AM71Yu9Gu13YyU9yo9BnN0eoGifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180076
X-Proofpoint-GUID: IgQmZWVX6ya7RGWhlg38PgNk-wwl1B8e
X-Proofpoint-ORIG-GUID: IgQmZWVX6ya7RGWhlg38PgNk-wwl1B8e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 18, 2022, at 5:01 PM, Wolfram Sang <wsa+renesas@sang-engineering.c=
om> wrote:
>=20
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
>=20
> Link: https://lore.kernel.org/r/CAHk-=3DwgfRnXz0W3D37d01q3JFkr_i_uTL=3DV6=
A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Makes sense.

I think I would like to carry 05 and 07 in the NFSD tree so they
can get some exposure to our test workloads before they are merged.
Is that OK with you?


> ---
> fs/nfsd/nfs4idmap.c | 8 ++++----
> fs/nfsd/nfs4proc.c  | 2 +-
> fs/nfsd/nfssvc.c    | 2 +-
> 3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index f92161ce1f97..e70a1a2999b7 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -82,8 +82,8 @@ ent_init(struct cache_head *cnew, struct cache_head *ci=
tm)
> 	new->id =3D itm->id;
> 	new->type =3D itm->type;
>=20
> -	strlcpy(new->name, itm->name, sizeof(new->name));
> -	strlcpy(new->authname, itm->authname, sizeof(new->authname));
> +	strscpy(new->name, itm->name, sizeof(new->name));
> +	strscpy(new->authname, itm->authname, sizeof(new->authname));
> }
>=20
> static void
> @@ -548,7 +548,7 @@ idmap_name_to_id(struct svc_rqst *rqstp, int type, co=
nst char *name, u32 namelen
> 		return nfserr_badowner;
> 	memcpy(key.name, name, namelen);
> 	key.name[namelen] =3D '\0';
> -	strlcpy(key.authname, rqst_authname(rqstp), sizeof(key.authname));
> +	strscpy(key.authname, rqst_authname(rqstp), sizeof(key.authname));
> 	ret =3D idmap_lookup(rqstp, nametoid_lookup, &key, nn->nametoid_cache, &=
item);
> 	if (ret =3D=3D -ENOENT)
> 		return nfserr_badowner;
> @@ -584,7 +584,7 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr=
,
> 	int ret;
> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>=20
> -	strlcpy(key.authname, rqst_authname(rqstp), sizeof(key.authname));
> +	strscpy(key.authname, rqst_authname(rqstp), sizeof(key.authname));
> 	ret =3D idmap_lookup(rqstp, idtoname_lookup, &key, nn->idtoname_cache, &=
item);
> 	if (ret =3D=3D -ENOENT)
> 		return encode_ascii_id(xdr, id);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a72ab97f77ef..0437210b9898 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1343,7 +1343,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *=
nn, char *ipaddr,
> 		return 0;
> 	}
> 	if (work) {
> -		strlcpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
> +		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
> 		refcount_set(&work->nsui_refcnt, 2);
> 		work->nsui_busy =3D true;
> 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 4bb5baa17040..bfbd9f672f59 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -799,7 +799,7 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
> 	if (nrservs =3D=3D 0 && nn->nfsd_serv =3D=3D NULL)
> 		goto out;
>=20
> -	strlcpy(nn->nfsd_name, utsname()->nodename,
> +	strscpy(nn->nfsd_name, utsname()->nodename,
> 		sizeof(nn->nfsd_name));
>=20
> 	error =3D nfsd_create_serv(net);
> --=20
> 2.35.1
>=20

--
Chuck Lever



